Return-Path: <Kip.Leitner@ipc.com>
Received: from stsnycon1.corp.root.ipc.com (ipcny.ipc.com [65.244.37.61])
	by ozlabs.org (Postfix) with ESMTP id B67EC67CB2
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2005 05:27:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C59216.5EB626E8"
Date: Tue, 26 Jul 2005 15:15:21 -0400
Message-ID: <9A63F321BC93984690A3CA6A1652C2ED080F1FDF@exnanycmbx1.corp.root.ipc.com>
From: "Leitner, Kip" <Kip.Leitner@ipc.com>
To: <linuxppc-dev@ozlabs.org>
Subject: 8260 FCC Ethernet problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C59216.5EB626E8
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Rune,
=20
I just found your post regarding the Local_Protect_Bit not being set in
8260 FCC, for "some versions of 2.4 source " fcc_enet.c, and this
causing problems.  In my situation, we are getting late collision errors
in our application, details follow (after your patch notes). =20
=20
We are wondering if we apply your patch to 2.4.18 fcc_enet.c, will this
fix our late collision problem, as 2.4.18 fcc_enet.c has the uncorrected
part of the code in our Linux distribution that your patch fixes.
=20
Sincerely,
=20
Kip Leitner  =20
=20
**************
<Rune Wrote >
=20
I just found that there is a problem in the FCC driver.
This was fixed in some versions of the 2.4 source....
=20
Th Local Protect Bit is not set when enterring Full Duplex mode. This
causes the FCC to turn off the transmitter when packets are received,
and also
causes NonOctet frame errors and CRC errors (late collission)
=20
This diff is agains the 2.6.7 sources, but should apply cleanly against
top of source.
=20
=3D=3D=3D=3D=3D arch/ppc/8260_io/fcc_enet.c 1.20 vs edited =
=3D=3D=3D=3D=3D
--- 1.20/arch/ppc/8260_io/fcc_enet.c    2004-07-06 16:44:29 -05:00
+++ edited/arch/ppc/8260_io/fcc_enet.c  2004-09-10 14:44:05 -05:00
@@ -2013,9 +2013,9 @@
        fccp =3D fcp->fccp;
=20
        if (duplex)
-               fccp->fcc_fpsmr |=3D FCC_PSMR_FDE;
+               fccp->fcc_fpsmr |=3D FCC_PSMR_FDE | FCC_PSMR_LPB;
        else
-               fccp->fcc_fpsmr &=3D ~FCC_PSMR_FDE;
+               fccp->fcc_fpsmr &=3D ~(FCC_PSMR_FDE | FCC_PSMR_LPB);
=20
        /* Enable transmit/receive */
        fccp->fcc_gfmr |=3D FCC_GFMR_ENR | FCC_GFMR_ENT;
=20
=20
Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

=20

**************

< Dump  from Kip Leitner >=20

=20

In kernel version 2.4.18, in the Ethernet driver fcc_enet.c, we hit the
ring data dump with text message "eth0: transmit timeout".  Upon
inspection of the buffer descriptors, we noticed that buffer four (4,
0-based numbering) shows status for a late collision.  Our lan
conditions at the time of the dump:  PHY running at 10 Base T,
half-duplex, connected to half-duplex hub.  We know (from our high-level
software) that while we were continuously transmitting, we also began to
receive packets, which is when this repeatable condition of the Ring
Dump occurred. Dump below (more text after):

=20

NETDEV WATCHDOG: eth0: transmit timed out

eth0: transmit timed out.

 Ring data dump: cur_tx c01aa380 (full) cur_rx c01aa220.

 Tx @base c01aa308 :

9c00 0051 070f79a2

1c00 0056 070f7da2

1c00 0056 070f7ea2

1c00 0051 070f7ba2

1c80 003f 070f51c2                    ** Late Collision **

9c00 0056 070f50c2

9c00 0051 070f52c2

9c00 0056 070f53c2

9c00 0056 070f55c2

9c00 0051 070f54c2

dc00 0038 070f56c2

9c00 0056 070f57c2

9c00 0051 070f58c2

9c00 0056 070f59c2

9c00 0056 070f5ac2

bc00 0056 070f7ca2

 Rx @base c01aa208 :

9c00 0040 0046f000

9c00 0040 0046f800

9c00 0040 0046e000

9c00 0072 0046e800

9c00 0072 0046d000

9c00 0072 0046d800

9c00 0072 0046c000

9c00 0072 0046c800

9c00 0072 0046b000

9c00 0072 0046b800

9c00 0072 0046a000

9c00 0040 0046a800

9c00 0072 00469000

9c00 0072 00469800

9c00 0072 00468000

9c00 0072 00468800

9c00 0072 00467000

9c00 0040 00467800

9c00 0072 00466000

9c00 0040 00466800

9c00 0072 00465000

9c00 0040 00465800

9c00 0040 00464000

9c00 0040 00464800

9c00 0040 00463000

9c00 0040 00463800

9c00 0040 00462000

9c00 0040 00462800

9c00 0040 00461000

9c00 0040 00461800

9c00 0040 00460000

bc00 0040 00460800  =20

=20

We are wondering if our hardware (we build our own) has a problem, our
physical network has a problem, and/or if=20

=20

--> the driver supports recovery from late collisions. =20

=20

=20


------_=_NextPart_001_01C59216.5EB626E8
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PostalCode"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1><pre><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Rune,<o:p></o:p></span></font></pre><pre><font=
 size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>I just =
found your post regarding the Local_Protect_Bit not being set in 8260 =
FCC, for &#8220;some versions of 2.4 source &#8220; fcc_enet.c, and this =
causing problems.&nbsp; In my situation, we are getting late collision =
errors in our application, details follow (after your patch =
notes).&nbsp; <o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>We are =
wondering if we apply your patch to 2.4.18 fcc_enet.c, will this fix our =
late collision problem, as 2.4.18 fcc_enet.c has the uncorrected part of =
the code in our Linux distribution that your patch =
fixes.<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Sincerely,<o:p></o:p></span></font></pre><pre>=
<font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>Kip =
Leitner &nbsp;&nbsp;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>**************<o:p></o:p></span></font></pre><=
pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>&lt;Rune =
Wrote &gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>I just =
found that there is a problem in the FCC =
driver.<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>This was =
fixed in some versions of the 2.4 =
source....<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>Th Local =
Protect Bit is not set when enterring Full Duplex mode. =
This<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>causes =
the FCC to turn off the transmitter when packets are received, and =
also<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>causes =
NonOctet frame errors and CRC errors (late =
collission)<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>This diff =
is agains the 2.6.7 sources, but should apply cleanly =
against<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>top of =
source.<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>=3D=3D=3D=3D=3D arch/ppc/8260_io/fcc_enet.c =
1.20 vs edited =3D=3D=3D=3D=3D<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>--- =
1.20/arch/ppc/8260_io/fcc_enet.c&nbsp;&nbsp;&nbsp; 2004-07-06 16:44:29 =
-05:00<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>+++ =
edited/arch/ppc/8260_io/fcc_enet.c&nbsp; 2004-09-10 14:44:05 =
-05:00<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>@@ =
-2013,9 +2013,9 @@<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fccp =3D fcp-&gt;fccp;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(duplex)<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fccp-&gt;fcc_fpsmr |=3D =
FCC_PSMR_FDE;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fccp-&gt;fcc_fpsmr |=3D =
FCC_PSMR_FDE | FCC_PSMR_LPB;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
else<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fccp-&gt;fcc_fpsmr &amp;=3D =
~FCC_PSMR_FDE;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fccp-&gt;fcc_fpsmr &amp;=3D =
~(FCC_PSMR_FDE | FCC_PSMR_LPB);<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Enable transmit/receive */<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fccp-&gt;fcc_gfmr |=3D FCC_GFMR_ENR | =
FCC_GFMR_ENT;<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>Rune =
Torgersen<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>System =
Developer<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Innovative Systems =
LLC<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>1000 =
Innovative Drive<o:p></o:p></span></font></pre><pre><st1:place
w:st=3D"on"><st1:City w:st=3D"on"><font size=3D2 face=3D"Courier =
New"><span
  style=3D'font-size:10.0pt'>Mitchell</span></font></st1:City>, =
<st1:State w:st=3D"on">SD</st1:State> <st1:PostalCode
 =
w:st=3D"on">57301</st1:PostalCode></st1:place><o:p></o:p></pre><pre><font=

size=3D2 face=3D"Courier New"><span style=3D'font-size:10.0pt'>Ph: =
605-995-6120<o:p></o:p></span></font></pre><pre><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>www.innovsys.com<o:p></o:p></span></font></pre=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<pre><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>**************<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&lt; Dump &nbsp;from Kip Leitner &gt; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In kernel version 2.4.18, in the Ethernet driver =
fcc_enet.c,
we hit the ring data dump with text message &#8220;eth0: transmit
timeout&#8221;.&nbsp; Upon inspection of the buffer descriptors, we =
noticed
that buffer four (4, 0-based numbering) shows status for a late =
collision.
&nbsp;Our lan conditions at the time of the dump:&nbsp; PHY running at =
10 Base
T, half-duplex, connected to half-duplex hub.&nbsp; We know (from our
high-level software) that while we were continuously transmitting, we =
also
began to receive packets, which is when this repeatable condition of the =
Ring
Dump occurred. Dump below (more text =
after):<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NETDEV WATCHDOG: eth0: transmit timed =
out<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>eth0: transmit timed =
out.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;Ring data dump: cur_tx c01aa380 (full) cur_rx
c01aa220.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;Tx @base c01aa308 =
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0051 070f79a2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>1c00 0056 070f7da2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>1c00 0056 070f7ea2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>1c00 0051 070f7ba2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>1c80 003f
070f51c2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
** Late Collision **<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0056 070f50c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0051 070f52c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0056 070f53c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0056 070f55c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0051 070f54c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>dc00 0038 070f56c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0056 070f57c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0051 070f58c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0056 070f59c2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0056 070f5ac2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>bc00 0056 070f7ca2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;Rx @base c01aa208 =
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 0046f000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 0046f800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 0046e000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 0046e800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 0046d000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 0046d800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 0046c000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 0046c800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 0046b000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 0046b800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 0046a000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 0046a800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 00469000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 00469800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 00468000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 00468800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 00467000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00467800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 00466000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00466800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0072 00465000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00465800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00464000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00464800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00463000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00463800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00462000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00462800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00461000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00461800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>9c00 0040 00460000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>bc00 0040 00460800 =
&nbsp;&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We are wondering if our hardware (we build our own) =
has a
problem, our physical network has a problem, and/or if =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;
font-family:Wingdings'>&agrave;</span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'> the driver supports =
recovery from
late collisions. &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C59216.5EB626E8--
