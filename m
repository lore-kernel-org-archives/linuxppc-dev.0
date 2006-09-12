Return-Path: <a.llano@usyscom.com>
Received: from correo.ziv.es (eu31-237.clientes.euskaltel.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id 8F30267A3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 02:45:59 +1000 (EST)
Subject: MPC5200 fec frame corruption
From: "Asier Llano Palacios" <a.llano@usyscom.com>
To: "Sylvain Munaut" <tnt@246tNt.com>,
	<linuxppc-embedded@ozlabs.org>
In-Reply-To: <20060607120252.qjekdh5yzyrs4s0g@webmail.bluenox.com>
References: <000d01c689f4$281750c0$4129320a@telxsi.com>
	<20060607120252.qjekdh5yzyrs4s0g@webmail.bluenox.com>
Content-Type: text/plain;
	charset="Windows-1252"
Date: Tue, 12 Sep 2006 18:33:31 +0200
Message-ID: <1158078812.5297.92.camel@usys-sw-server>
MIME-Version: 1.0
Cc: a.arzuaga@usyscom.com, m.alvarez@ziv.es, t.arzuaga@usyscom.com
Reply-To: a.llano@usyscom.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

We have been working with the MPC5200 fec and a linux-2.6.10 with some
patches extracted from Sylvain's bitkeeper repository. We have 3
different boards that worked properly with that kernel.

We upgraded to the new MPC5200B and it still worked properly with the
2.6.10 kernel.

We upgraded to the new code of the Sylvain's git repository and the FEC
transmitted frames are corrupted. This corruption only happens with the
current git repository and the MPC5200B.

                MPC5200   MPC5200B
linux-2.6.10:     OK         OK
Sylvain's git:    OK       CORRUPT

The problem is that the lite5200 and the lite5200b work flawlessly, but
our architecture is essentialy the same but with different PHYs (Marvell
88E6095F and 88E6060). Our architecture works properly with the
linux-2.6.10, so we don't think that it is a hardware related problem.
We have been watching the MII bus by osciloscope and the errors are
clearly transmitted by the MPC5200B (no noise or distortion).

We have inserted traces in the functions of the FEC driver with the
buffer information that is sent to the DMA and the frames are correct.

The corruption pattern is as follows:
Transmition frame:
0000  ff ff ff ff ff ff 00 11  22 33 44 55 e0 00 e0 73
0010  00 11 22 33 44 55 66 77  88 99 aa bb cc dd ee ff
0020  12 23 34 45 56 67 78 89  9a ab bc cd de ef f0 01
0030  24 35 46 57 68 79 8a 9b  ac bd ce df e0 f1 02 13
0040  36 47 58 69 7a 8b 9c ad  be cf d0 e1 f2 03 14 25
0050  48 59 6a 7b 8c 9d ae bf  c0 d1 e2 f3 04 15 26 37
0060  5a 6b 7c 8d 9e af b0 c1  d2 e3 f4 05 16 27 38 49
0070  6c 7d 8e 9f a0 b1 c2 d3  e4 f5 06 17 28 39 4a 5b
0080  7e 8f 90 a1 b2 c3 d4 e5  f6 07 18 29 3a 4b 5c 6d

Reception frame (corrupted bytes marked):
0000 (7e)ff ff ff ff ff 00 11  22 33 44 55 e0 00 e0 73
0010  00 11 22 33 44 55 66 77  88 99 aa bb cc dd ee ff
0020  12 23 34 45 56 67 78 89  9a ab bc cd de ef f0 01
0030  24 35 46 57 68 79 8a 9b  ac bd ce df e0 f1(ee)13
0040  36 47 58 69 7a 8b 9c ad  be cf d0 e1 f2 03 14 25
0050  48 59 6a 7b 8c 9d ae bf  c0 d1 e2 f3 04 15 26 37
0060  5a 6b 7c 8d 9e af b0 c1  d2 e3 f4 05 16 27 38 49
0070  6c 7d 8e 9f a0 b1 c2 d3  e4 f5 06 17 28 39(26)5b
0080  7e 8f 90 a1 b2 c3 d4 e5  f6 07 18 29 3a 4b 5c 6d

The corrupted bytes are sometimes correct, sometimes overwriten
by the byte that is 0x20 bytes before, and sometimes changed
by the bytes that is 0x40 bytes before. About 50% of the time
the marked bytes are worong.

I'd like to know if anything here makes any sense to you, so
that I can understand the origin of the problem, or any
additional test to perform.

Thank you in advance,
Asier Llano=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
=B5SysCom uses virus scanning software but excludes any liability for =
viruses contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
=B5SysCom utiliza software antivirus, pero no se hace responsable de los =
virus contenidos en los ficheros anexos.
