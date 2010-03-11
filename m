Return-Path: <garazi85@hotmail.com>
Received: from snt0-omc4-s11.snt0.hotmail.com (snt0-omc4-s11.snt0.hotmail.com
	[65.55.90.214]) by ozlabs.org (Postfix) with ESMTP id D740BB7CCD
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 22:27:08 +1100 (EST)
Message-ID: <SNT133-w21AEB277CB407A5207B833C4320@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_68857284-e7a7-4bc4-b62d-60fe293125b7_"
From: garazi juez uriagereka <garazi85@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: MTD partitions missing
Date: Thu, 11 Mar 2010 11:22:03 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_68857284-e7a7-4bc4-b62d-60fe293125b7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C

I am Garazi and I am
working  in the Electronic Design Group at the University of the
Basque Country.


I'm running the Xilinx git kernel 2.6.31
from git.xilinx.com on a V5 PPC440 CORE( Xilinx ML507). We have a NOR CFI
flash device.=20

Flash chip has been particionated according to
this table:
=20
 =20
 =20
  START ADDRESS


 =20
 =20
  OFFSET
 =20
 =20
  SIZE


 =20
 =20
  =20
 =20
=20
=20
 =20
  LINUX
 =20
 =20
  0xFE000000
 =20
 =20
  0x00000000
 =20
 =20
  0x00500000 (5M)
 =20
 =20
  =20
 =20
=20
=20
 =20
  JFFS2 Filesystem
 =20
 =20
  0xFE500000
 =20
 =20
  0x00500000
 =20
 =20
  0x01600000 (22M)
 =20
 =20
  =20
 =20
=20
=20
 =20
  UNUSED
 =20
 =20
  0xFFB00000
 =20
 =20
  0x01B00000
 =20
 =20
  0x00114000(4896 K)=20
 =20
 =20
  =20
 =20
=20
=20
 =20
  LOADER
 =20
 =20
  0xFFFE0000
 =20
 =20
  0x01FE0000
 =20
 =20
  0x00020000(128K)

In order to get this four partitions=2C my .dts file has been
configured this way:

bootargs =3D
"console=3DttyS0 ip=3Don root=3D/dev/ram rw =20
  =20
  =20
mtdparts=3Dfe000000.flash:5M(zImage)=2C22M(rootfs)=2C4896k(unused)=2C128k(l=
oader)"=3B

First
of all=2C linux kernel was booted from Flash=2C using a ramdisk for the
flash system and a loader =2C and it worked.

Now=2C I am trying to
mount JFFS2 file system but I can not. I have tried it in two
different ways:
1. Mounting JFFS2 file system when  the
kernel has already booted.
2. Changing my dts file and mounting JFFS2
automatically when kernel boots.

bootargs =3D
"console=3DttyS0 ip=3Don root=3D/dev/mtdblock1 rw  rootfs=3Djffs2

      =20
mtdparts=3Dfe000000.flash:5M(zImage)=2C22M(rootfs)=2C4896k(unused)=2C128k(l=
oader)"=3B

 I
guess that the problem is related to MTD driver=2C because mtd
partitions are not correctly created. I check partition file and just one o=
f four partition appears
(cat  /proc/partitions --> mtdblock0 just
appears).

I have read in the Internet that there are other
people who have had the same problem when they have updated 2.6.28
kernel to 2.6.31 kernel. Although=2C there is no answer.

I would appreciate any kind of help.

Regards=2C

Garazi


 		 	   		 =20
_________________________________________________________________
Recibe en tu m=F3vil un SMS con tu Hotmail recibido. =A1Date de alta ya!
http://serviciosmoviles.es.msn.com/=

--_68857284-e7a7-4bc4-b62d-60fe293125b7_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
Hello=2C<br><p style=3D"margin-bottom: 0cm=3B"><br>I am Garazi and I am
working&nbsp=3B in the Electronic Design Group at the University of the
Basque Country.<br><br><br>I'm running the Xilinx git kernel 2.6.31
from git.xilinx.com on a V5 PPC440 CORE( Xilinx ML507). We have a NOR CFI
flash device. <br><br>Flash chip has been particionated according to
this table:</p><p style=3D"margin-bottom: 0cm=3B"><br></p><table class=3D"e=
cxecxecxMsoNormalTable" style=3D"margin-left: -0.25pt=3B border-collapse: c=
ollapse=3B" border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr sty=
le=3D"height: 25.85pt=3B"><td style=3D"border-style: solid none none solid=
=3B border-color: black -moz-use-text-color black black=3B border-width: 1p=
t medium 1pt 1pt=3B padding: 0cm 5.4pt=3B width: 131.4pt=3B height: 25.85pt=
=3B" valign=3D"top" width=3D"175"><p style=3D"text-align: justify=3B" class=
=3D"ecxecxecxMsoNormal"><span style=3D"font-size: 12pt=3B line-height: 115%=
=3B font-family: 'Times New Roman'=2C'serif'=3B">&nbsp=3B</span></p>
  </td>
  <td style=3D"border-style: solid none none solid=3B border-color: black -=
moz-use-text-color black black=3B border-width: 1pt medium 1pt 1pt=3B paddi=
ng: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" valign=3D"top" widt=
h=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">START ADDRESS<br>
</span></p>
  </td>
  <td style=3D"border-style: solid none none solid=3B border-color: black -=
moz-use-text-color black black=3B border-width: 1pt medium 1pt 1pt=3B paddi=
ng: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" valign=3D"top" widt=
h=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">OFFSET</span></p>
  </td>
  <td style=3D"border-style: solid solid none=3B border-color: black=3B bor=
der-width: 1pt=3B padding: 0cm 5.4pt=3B width: 126.3pt=3B height: 25.85pt=
=3B" valign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">SIZE<br>
</span></p>
  </td>
 =20
  <td style=3D"border: medium none =3B height: 25.85pt=3B" height=3D"34" wi=
dth=3D"0">&nbsp=3B</td>
 =20
 </tr>
 <tr style=3D"height: 25.85pt=3B">
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 131.4pt=3B height: 25.85pt=3B" vali=
gn=3D"top" width=3D"175">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">LINUX</span></p>
  </td>
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" val=
ign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0xFE000000</span></p>
  </td>
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" val=
ign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0x00000000</span></p>
  </td>
  <td style=3D"border-style: none solid=3B border-color: -moz-use-text-colo=
r black black=3B border-width: medium 1pt 1pt=3B padding: 0cm 5.4pt=3B widt=
h: 126.3pt=3B height: 25.85pt=3B" valign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0x00500000 (5M)</span></p>
  </td>
 =20
  <td style=3D"border: medium none =3B height: 25.85pt=3B" height=3D"34" wi=
dth=3D"0">&nbsp=3B</td>
 =20
 </tr>
 <tr style=3D"height: 25.85pt=3B">
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 131.4pt=3B height: 25.85pt=3B" vali=
gn=3D"top" width=3D"175">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">JFFS2 Filesystem</span></p>
  </td>
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" val=
ign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0xFE500000</span></p>
  </td>
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" val=
ign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0x00500000</span></p>
  </td>
  <td style=3D"border-style: none solid=3B border-color: -moz-use-text-colo=
r black black=3B border-width: medium 1pt 1pt=3B padding: 0cm 5.4pt=3B widt=
h: 126.3pt=3B height: 25.85pt=3B" valign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0x01600000 (22M)</span></p>
  </td>
 =20
  <td style=3D"border: medium none =3B height: 25.85pt=3B" height=3D"34" wi=
dth=3D"0">&nbsp=3B</td>
 =20
 </tr>
 <tr style=3D"height: 25.85pt=3B">
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 131.4pt=3B height: 25.85pt=3B" vali=
gn=3D"top" width=3D"175">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">UNUSED</span></p>
  </td>
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" val=
ign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0xFFB00000</span></p>
  </td>
  <td style=3D"border-style: none none none solid=3B border-color: -moz-use=
-text-color -moz-use-text-color black black=3B border-width: medium medium =
1pt 1pt=3B padding: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" val=
ign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0x01B00000</span></p>
  </td>
  <td style=3D"border-style: none solid=3B border-color: -moz-use-text-colo=
r black black=3B border-width: medium 1pt 1pt=3B padding: 0cm 5.4pt=3B widt=
h: 126.3pt=3B height: 25.85pt=3B" valign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0x00114000(4896 K) </span></p>
  </td>
 =20
  <td style=3D"border: medium none =3B height: 25.85pt=3B" height=3D"34" wi=
dth=3D"0">&nbsp=3B</td>
 =20
 </tr>
 <tr style=3D"height: 25.85pt=3B">
  <td style=3D"border-style: none none solid solid=3B border-color: -moz-us=
e-text-color -moz-use-text-color black black=3B border-width: medium medium=
 1pt 1pt=3B padding: 0cm 5.4pt=3B width: 131.4pt=3B height: 25.85pt=3B" val=
ign=3D"top" width=3D"175">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">LOADER</span></p>
  </td>
  <td style=3D"border-style: none none solid solid=3B border-color: -moz-us=
e-text-color -moz-use-text-color black black=3B border-width: medium medium=
 1pt 1pt=3B padding: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" va=
lign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0xFFFE0000</span></p>
  </td>
  <td style=3D"border-style: none none solid solid=3B border-color: -moz-us=
e-text-color -moz-use-text-color black black=3B border-width: medium medium=
 1pt 1pt=3B padding: 0cm 5.4pt=3B width: 125.75pt=3B height: 25.85pt=3B" va=
lign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0x01FE0000</span></p>
  </td>
  <td style=3D"border-style: none solid solid=3B border-color: -moz-use-tex=
t-color black black=3B border-width: medium 1pt 1pt=3B padding: 0cm 5.4pt=
=3B width: 126.3pt=3B height: 25.85pt=3B" valign=3D"top" width=3D"168">
  <p style=3D"text-align: justify=3B" class=3D"ecxecxecxMsoNormal"><span st=
yle=3D"font-size: 12pt=3B line-height: 115%=3B font-family: 'Times New Roma=
n'=2C'serif'=3B">0x00020000(128K)</span></p></td></tr></tbody></table><p st=
yle=3D"margin-bottom: 0cm=3B"><br></p>
<p style=3D"margin-bottom: 0cm=3B">In order to get this four partitions=2C =
my .dts file has been
configured this way:<br><br><font style=3D"" color=3D"#ff0000"><b>bootargs =
=3D
"console=3DttyS0 ip=3Don root=3D/dev/ram rw&nbsp=3B <br>&nbsp=3B&nbsp=3B&nb=
sp=3B
&nbsp=3B&nbsp=3B&nbsp=3B
mtdparts=3Dfe000000.flash:5M(zImage)=2C22M(rootfs)=2C4896k(unused)=2C128k(l=
oader)"=3B</b></font><br><br>First
of all=2C linux kernel was booted from Flash=2C using a ramdisk for the
flash system and a loader =2C and it worked.<br><br>Now=2C I am trying to
mount JFFS2 file system but I can not. I have tried it in two
different ways:</p><br>1. Mounting JFFS2 file system when&nbsp=3B the
kernel has already booted.<br>2. Changing my dts file and mounting JFFS2
automatically when kernel boots.<br><br><font style=3D"" color=3D"#ff0000">=
<b>bootargs =3D
"console=3DttyS0 ip=3Don root=3D/dev/mtdblock1 rw&nbsp=3B rootfs=3Djffs2
<br>&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3B
mtdparts=3Dfe000000.flash:5M(zImage)=2C22M(rootfs)=2C4896k(unused)=2C128k(l=
oader)"=3B</b></font><br><br>&nbsp=3BI
guess that the problem is related to MTD driver=2C because mtd
partitions are not correctly created. I check partition file and just one o=
f four partition appears<br>(cat&nbsp=3B /proc/partitions --&gt=3B mtdblock=
0 just
appears).<br><br>I have read in the Internet that there are other
people who have had the same problem when they have updated 2.6.28
kernel to 2.6.31 kernel. Although=2C there is no answer.<br><br>I would app=
reciate any kind of help.<br><br>Regards=2C<br><br>Garazi<br><br><br> 		 	 =
  		  <br /><hr />=BFSabes que la Videollamada de Messenger es GRATIS <a hr=
ef=3D'http://events.es.msn.com/windows-live/redes-sociales/default.aspx' ta=
rget=3D'_new'>=A1Desc=FAbrela!</a></body>
</html>=

--_68857284-e7a7-4bc4-b62d-60fe293125b7_--
