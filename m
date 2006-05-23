Return-Path: <rick.moleres@xilinx.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4311C67B33
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 09:56:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C67EAE.EA627DBB"
Subject: RE: question about linux with Xilinx ML-403
Date: Tue, 23 May 2006 15:21:54 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C0252AB7B@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Ming Liu" <eemingliu@hotmail.com>,
	"rick.moleres" <rick.moleres@xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C67EAE.EA627DBB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ming,

=20

-----Original Message-----
From: Ming Liu [mailto:eemingliu@hotmail.com]=20
Sent: Tuesday, May 23, 2006 3:42 AM
To: rick.moleres
Cc: linuxppc-embedded@ozlabs.org
Subject: question about linux with Xilinx ML-403

=20

Hi Rick,

> Yes, we have a driver for the PLB TEMAC (different than the GSRD LL

> TEMAC) for Linux 2.4 (MontaVista Linux 2.4.20) that's shipped in EDK

> 8.1.1, and MontaVista is on the verge of publishing a driver for PLB

> TEMAC for Linux 2.6. (I believe it came across this mailing list a few

> weeks ago)

=20

I have generated the BSP by EDK 8.1.1 for my project in ML403(hardcore=20

Temac and PLB Temac included). I noticed that there is a directory
called=20

Xilinx_gige in the directory of /drivers/net. Is this the driver for=20

MontaVista Linux2.4.20?

=20

Yes, this is the PLB TEMAC driver for Linux 2.4.20.  In EDK 8.1.x, the
temac driver and Makefile are copied to drivers/net/xilinx_gige.  This
xilinx_gige directory is not available in the MVL 3.1 Preview Kit, only
in the full Professional kit.  We put the temac driver here mostly to
take advantage of the JUMBO_FRAME_SUPPORT in kernel configuration.

=20

 I copied the BSP and overwrote the original one in=20

the linux kernel directory (in the kernel directory, there is only a=20

directory called Xilinx_enet, no Xilinx_gige. So I just copied=20

Xilinx_gige.). However, my problem is in the menuconfig item of Network=20

Device Support->1000Mbit ethernet, there is not any option to choose and


enable the Xilinx on-chip ethernet. Is this a problem of MontaVista
Linux=20

3.1 Preview Kit, or my problem?  And What shall I do to enable the
tri-mode=20

Temac in my platform? Thanks for your answer.=20

=20

Our best recommendation is to use the drivers/net/xilinx_enet directory
for the temac driver and just enable the Xilinx 10/100 Ethernet in
menuconfig.  If you want jumbo frame support, modify adapter.c in the
driver to define the CONFIG_XILINX_GIGE_JUMBO constant.

=20

Note that Linux 2.6 support for the temac should be available from
MontaVista soon and a driver was pushed to this mailing list in March.
There will be support for MV Linux 2.6 in EDK 8.2.1 (around August).

=20

=20

Thanks,

Rick

=20


------_=_NextPart_001_01C67EAE.EA627DBB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Ming,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>-----Original Message-----<br>
From: Ming Liu [mailto:eemingliu@hotmail.com] <br>
Sent: Tuesday, May 23, 2006 3:42 AM<br>
To: rick.moleres<br>
Cc: linuxppc-embedded@ozlabs.org<br>
Subject: question about linux with Xilinx ML-403</span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Hi Rick,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&gt; Yes, we have a driver for the PLB TEMAC
(different than the GSRD LL<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&gt; TEMAC) for Linux 2.4 (MontaVista Linux =
2.4.20)
that's shipped in EDK<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&gt; 8.1.1, and MontaVista is on the verge of
publishing a driver for PLB<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&gt; TEMAC for Linux 2.6. (I believe it came =
across
this mailing list a few<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&gt; weeks ago)<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>I have generated the BSP by EDK 8.1.1 for my =
project
in ML403(hardcore <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Temac and PLB Temac included). I noticed that =
there is
a directory called <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Xilinx_gige in the directory of /drivers/net. =
Is this
the driver for <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>MontaVista =
Linux2.4.20?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Yes, this is the PLB TEMAC driver for Linux 2.4.20. &nbsp;In EDK =
8.1.x,
the temac driver and Makefile are copied to drivers/net/xilinx_gige. =
&nbsp;This
xilinx_gige directory is not available in the MVL 3.1 Preview Kit, only =
in the full
Professional kit. &nbsp;We put the temac driver here mostly to take =
advantage
of the JUMBO_FRAME_SUPPORT in kernel =
configuration.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>&nbsp;I copied the BSP and overwrote the =
original one
in <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>the linux kernel directory (in the kernel =
directory,
there is only a <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>directory called Xilinx_enet, no Xilinx_gige. =
So I
just copied <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Xilinx_gige.). However, my problem is in the
menuconfig item of Network <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Device Support-&gt;1000Mbit ethernet, there =
is not any
option to choose and <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>enable the Xilinx on-chip ethernet. Is this a =
problem
of MontaVista Linux <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>3.1 Preview Kit, or my problem?&nbsp; And =
What shall I
do to enable the tri-mode <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt'>Temac in my platform? Thanks for your answer. =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>Our best recommendation is to use =
the
drivers/net/xilinx_enet directory for the temac driver and just enable =
the Xilinx
10/100 Ethernet in menuconfig. &nbsp;If you want jumbo frame support, =
modify
adapter.c in the driver to define the CONFIG_XILINX_GIGE_JUMBO =
constant.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>Note that Linux 2.6 support for =
the temac should
be available from MontaVista soon and a driver was pushed to this =
mailing list
in March. &nbsp;There will be support for MV Linux 2.6 in EDK 8.2.1 =
(around
August).<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>Thanks,<o:p></o:p></span></font></=
p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'>Rick<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_001_01C67EAE.EA627DBB--
