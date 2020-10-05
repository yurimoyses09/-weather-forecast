import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  String get initialValue => null;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String temperatura = "Temperatura: ";
  String data = "Data: ";
  String hora = "Hota: ";
  String desc = "Descrição: ";
  String cidade = "Cidade: ";
  String humidade = "Humidade: ";

  void reset() {
    setState(() {
      temperatura = " ";
      data = " ";
      hora = " ";
      desc = " ";
      cidade = " ";
      humidade = " ";
    });
  }

  clicouReset(){
    reset();
  }
  clicouBotao() async{
    String url = "https://api.hgbrasil.com/weather?array_limit=2&fields=only_results,temp,data,time,description,city,humidity,wind_speedy,forecast,max,min,date,%20&key=6250f1a1";
    Response resp = await get(url);
    Map stats = json.decode(resp.body);
    setState(() {
      temperatura = stats["temp"].toString();
      data = stats["date"].toString();
      hora = stats["time"].toString();
      desc = stats["description"].toString();
      cidade = stats["city"].toString();
      humidade = stats["humidity"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.amber,
                child: Image.asset(
                    "assets/imgs/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.topCenter,
                height: 70,
                child: IconButton(
                  onPressed: clicouBotao,
                  icon: FaIcon(FontAwesomeIcons.globeAmericas, color: Colors.blueAccent,size: 50,),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.topCenter,
                height: 80,
                child: IconButton(
                  onPressed: clicouReset,
                  icon: FaIcon(FontAwesomeIcons.globeAmericas, color: Colors.redAccent,size: 50,),
                ),
              ),
              Componentes.rotulo("Temperaura - " + temperatura),
              Componentes.rotulo("Data - " + data),
              Componentes.rotulo("Hora - " + hora),
              Componentes.rotulo("Descrição - " + desc),
              Componentes.rotulo("Cidade - " + cidade),
              Componentes.rotulo("Humidade - " + humidade),
            ],
          ),
      ),
    );
  }
}

class Componentes {

  static rotulo(rotulo) {
    return Text(
      rotulo,
      style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }
}
