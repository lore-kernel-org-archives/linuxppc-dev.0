Return-Path: <bsamograd@Interalia.com>
Received: from CgyExchg.Interalia.ca (mail.interalia.com [72.13.188.35])
	by ozlabs.org (Postfix) with ESMTP id BA9551007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 07:34:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CC10EB.635C6595"
Subject: mpc8xx IDE hard drive enumeration
Date: Thu, 12 May 2011 15:27:25 -0600
Message-ID: <C5362BC88E4CB545B18EA43E89EC0D5602405848@cgyexchg.Interalia.ca>
From: "Burton Samograd" <bsamograd@Interalia.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC10EB.635C6595
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello list,

=20

I'm currently attempting to get Linux running on a custom board and have
gotten to the point of trying to get our IDE FlashCard working.  I have
ported u-boot and have the flash card working as expected (as in being
able to read and write sectors) so it looks like it is possible to get
it working in Linux with the parameters I have setup (this is using
CONFIG_IDE_8XX_DIRECT and the various CFG_PCMCIA_* parameters).

=20

I have built the kernel with IDE Block Device support and have selected
the MPC8xx IDE support as well, using 8xx_DIRECT as the interface.  I
have ensured that my parameters for PCMCIA match those of u-boot.  I get
the following on bootup with regards to the IDE subsystem (having
defined DEBUG and added some additional debugging into in
drivers/ide/ppc/mpc8xx.c):

=20

...

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=3Dxx

win->br: 0xfe100000, PCMCIA_MEM_SIZE: 0x80, pcmcia_phy_end: 0xfe100080

win->br: 0xfe100080, PCMCIA_MEM_SIZE: 0x80, pcmcia_phy_end: 0xfe100100

win->br: 0xfe100100, PCMCIA_MEM_SIZE: 0x80, pcmcia_phy_end: 0xfe100180

win->br: 0xfe100c00, PCMCIA_MEM_SIZE: 0x80, pcmcia_phy_end: 0xfe100c80

win->br: 0xfe100c80, PCMCIA_MEM_SIZE: 0x80, pcmcia_phy_end: 0xfe100d00

win->br: 0xfe100d00, PCMCIA_MEM_SIZE: 0x80, pcmcia_phy_end: 0xfe100d80

PCMCIA slot A: phys mem fe100000...fe100d80 (size 00000d80)

PCMCIA virt base: c1000000

base: c1000000 + 00000000 =3D c1000000

port[0]: c1000000 + 00000000 =3D c1000000

port[1]: c1000000 + 00000081 =3D c1000081

port[2]: c1000000 + 00000082 =3D c1000082

port[3]: c1000000 + 00000083 =3D c1000083

port[4]: c1000000 + 00000084 =3D c1000084

port[5]: c1000000 + 00000085 =3D c1000085

port[6]: c1000000 + 00000086 =3D c1000086

port[7]: c1000000 + 00000087 =3D c1000087

port[8]: c1000000 + 00000106 =3D c1000106

port[9]: c1000000 + 0000000a =3D c100000a

...

=20

The IDE driver is calling m8xx_ide_init_hwif_ports successfully (not so
if I define 8xx_PCCARD) and from the source it just seems to be getting
the PCMCIA parameters that are setup by u-boot.  Everything seems fine
up to this point.

=20

Now, I'm wondering, why is it not enumerating the drives on the found
hwif ports?  Would I need to specify the drives on the command line, or
some other step that I might be missing?  Can anyone see anything
drastically wrong with the PCMCIA parameters (even though they seem to
work fine with u-boot). =20

=20

We are using a rather old kernel (2.6.12 I think, with customizations
for our hardware), but this is a rather old custom board with very
limited ram so we are attempting to get the older kernel working first
before looking into upgrading.

=20

Any help appreciated.

=20

--

Burton Samograd


------_=_NextPart_001_01CC10EB.635C6595
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
	{margin:0cm;
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
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello list,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m currently attempting to get Linux running =
on a
custom board and have gotten to the point of trying to get our IDE =
FlashCard
working.&nbsp; I have ported u-boot and have the flash card working as =
expected
(as in being able to read and write sectors) so it looks like it is =
possible to
get it working in Linux with the parameters I have setup (this is using =
CONFIG_IDE_8XX_DIRECT
and the various CFG_PCMCIA_* parameters).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have built the kernel with IDE Block Device support =
and
have selected the MPC8xx IDE support as well, using 8xx_DIRECT as the
interface.&nbsp; I have ensured that my parameters for PCMCIA match =
those of
u-boot.&nbsp; I get the following on bootup with regards to the IDE =
subsystem (having
defined DEBUG and added some additional debugging into in =
drivers/ide/ppc/mpc8xx.c):<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Uniform Multi-Platform E-IDE driver Revision: =
7.00alpha2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ide: Assuming 50MHz system bus speed for PIO modes; =
override
with idebus=3Dxx<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>win-&gt;br: 0xfe100000, PCMCIA_MEM_SIZE: 0x80,
pcmcia_phy_end: 0xfe100080<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>win-&gt;br: 0xfe100080, PCMCIA_MEM_SIZE: 0x80,
pcmcia_phy_end: 0xfe100100<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>win-&gt;br: 0xfe100100, PCMCIA_MEM_SIZE: 0x80,
pcmcia_phy_end: 0xfe100180<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>win-&gt;br: 0xfe100c00, PCMCIA_MEM_SIZE: 0x80,
pcmcia_phy_end: 0xfe100c80<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>win-&gt;br: 0xfe100c80, PCMCIA_MEM_SIZE: 0x80,
pcmcia_phy_end: 0xfe100d00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>win-&gt;br: 0xfe100d00, PCMCIA_MEM_SIZE: 0x80,
pcmcia_phy_end: 0xfe100d80<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCMCIA slot A: phys mem fe100000...fe100d80 (size =
00000d80)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCMCIA virt base: =
c1000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>base: c1000000 + 00000000 =3D =
c1000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[0]: c1000000 + 00000000 =3D =
c1000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[1]: c1000000 + 00000081 =3D =
c1000081<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[2]: c1000000 + 00000082 =3D =
c1000082<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[3]: c1000000 + 00000083 =3D =
c1000083<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[4]: c1000000 + 00000084 =3D =
c1000084<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[5]: c1000000 + 00000085 =3D =
c1000085<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[6]: c1000000 + 00000086 =3D =
c1000086<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[7]: c1000000 + 00000087 =3D =
c1000087<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[8]: c1000000 + 00000106 =3D =
c1000106<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>port[9]: c1000000 + 0000000a =3D =
c100000a<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The IDE driver is calling m8xx_ide_init_hwif_ports =
successfully
(not so if I define 8xx_PCCARD) and from the source it just seems to be =
getting
the PCMCIA parameters that are setup by u-boot.&nbsp; Everything seems =
fine up
to this point.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Now, I&#8217;m wondering, why is it not enumerating =
the
drives on the found hwif ports?&nbsp; Would I need to specify the drives =
on the
command line, or some other step that I might be missing?&nbsp; Can =
anyone see
anything drastically wrong with the PCMCIA parameters (even though they =
seem to
work fine with u-boot).&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We are using a rather old kernel (2.6.12 I think, =
with
customizations for our hardware), but this is a rather old custom board =
with
very limited ram so we are attempting to get the older kernel working =
first
before looking into upgrading.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any help appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>--<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Burton Samograd<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CC10EB.635C6595--
