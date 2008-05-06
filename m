Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6FC2CDE00E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 May 2008 03:39:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8AFA0.2D652C5D"
Subject: porting pci driverfrom arch=ppc on kernel 2.6.16 to arch=powerpc on
	2.6.24...
Date: Tue, 6 May 2008 10:39:35 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6020D6A5D@uss-am-xch-01.am.trimblecorp.net>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8AFA0.2D652C5D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have a framebuffer driver for the Fujitsu CoralP that registers fine
with the PCI bus and operates for my new arch=3Dpowerpc 2.6.24 build. =
The
only thing that failed when jumping from arch=3Dppc on my 2.6.16 kernel =
to
my new 2.6.24 kernel is the interrupt request. While testing other
functionality I simply compiled-out the interrupt request because it is
not always critical for basic frame buffer operation. I'm back to
wanting the interrupt.

=20

Specifically, I have a lite5200b-based board in both cases (2.6.14 and
2.6.24 kernels). Under the old ppc scheme I obtained irq=3D1 via a call =
to


=20

pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &irqnum).

=20

Under my new powerpc kernel 2.6.24 I obtain irq=3D0 and the subsequent
interrupt request fails. Also, a hard-coded irq=3D1 fails too. I know =
this
is an issue with NOT querying the device tree, but I'm not sure what to
specify in lite5200b.dts, or what property I need to query to get the
correct pci interrupt.

=20

If anyone is familiar with lite5200b.dts, is all the info I need already
in there, or do I need to add my pci device? I've done some mucking
around in the dts file but I'm not a pci expert so I am a bit confused.


------_=_NextPart_001_01C8AFA0.2D652C5D
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
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I have a framebuffer driver for the
Fujitsu CoralP that registers fine with the PCI bus and operates for my =
new arch=3Dpowerpc
2.6.24 build. The only thing that failed when jumping from arch=3Dppc on =
my
2.6.16 kernel to my new 2.6.24 kernel is the interrupt request. While =
testing
other functionality I simply compiled-out the interrupt request because =
it is
not always critical for basic frame buffer operation. I&#8217;m back to =
wanting
the interrupt.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Specifically, I have a =
lite5200b-based
board in both cases (2.6.14 and 2.6.24 kernels). Under the old ppc =
scheme I obtained
irq=3D1 via a call to <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>pci_read_config_byte(pci_dev,
PCI_INTERRUPT_LINE, &amp;irqnum).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Under my new powerpc kernel 2.6.24 =
I
obtain irq=3D0 and the subsequent interrupt request fails. Also, a =
hard-coded
irq=3D1 fails too. I know this is an issue with NOT querying the device =
tree, but
I&#8217;m not sure what to specify in lite5200b.dts, or what property I =
need to
query to get the correct pci interrupt.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>If anyone is familiar with =
lite5200b.dts,
is all the info I need already in there, or do I need to add my pci =
device? I&#8217;ve
done some mucking around in the dts file but I&#8217;m not a pci expert =
so I am
a bit confused.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8AFA0.2D652C5D--
