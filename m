Return-Path: <rmcguire@videopresence.com>
Received: from smtpout06-04.prod.mesa1.secureserver.net
	(smtpout06-01.prod.mesa1.secureserver.net [64.202.165.224])
	by ozlabs.org (Postfix) with SMTP id 59FA1DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 19:01:55 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: radeonfb / Radeon 9250 not detecting memory
Date: Sat, 3 Feb 2007 00:01:47 -0800
Message-ID: <000001c74769$8e43ba90$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C74726.80207A90"
Reply-To: rmcguire@videopresence.com
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

------=_NextPart_000_0001_01C74726.80207A90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

All,

 

I seem to be hitting a fit on PCI errors on this board. Was wondering if
anybody could help me through this.

 

Here is a condensed log of what happens when I boot 2.6.20-rc6, on a
MPC8360E PowerPC. 

I have edited out all the extra stuff and left only what should be
important.

The ATI card is the 1:0b:0 device that gets mapped to IRQ 0x17

 

I have turned on and added some extra debug in the RadeonFB driver.

Is there a common place reason why the driver can't detect the memory size?

 

Calling initcall 0xc036c3c0: pcibios_init+0x0/0x24c()

PCI: Probing PCI hardware

Try to map irq for 0000:00:19.0...

pci_busdev_to_OF_node(0,0xc8)

 parent is /soc8360@f0000000/pci@8500

 result is <NULL>

Try to map irq for 0000:00:19.1...

pci_busdev_to_OF_node(0,0xc9)

 parent is /soc8360@f0000000/pci@8500

 result is <NULL>

Try to map irq for 0000:01:0b.0...

pci_busdev_to_OF_node(1,0x58)

pci_busdev_to_OF_node(0,0xc8)

 parent is /soc8360@f0000000/pci@8500

 result is <NULL>

 -> got one, spec 2 cells (0x00000017...) on /soc8360@f0000000/pic@700

Try to map irq for 0000:01:0b.1...

pci_busdev_to_OF_node(1,0x59)

PCI: bridge rsrc 0..ffffffff (100), parent c038d184

PCI: bridge rsrc 80000000..8fffffff (1200), parent c038d168

PCI: bridge rsrc 90000000..9fffffff (200), parent c038d168

PCI: bridge rsrc f1001000..f1001fff (101), parent c03da03c

PCI: bridge rsrc 90000000..900fffff (200), parent c03da074

PCI: bridge rsrc 80000000..8fffffff (1201), parent c03da058

PCI:0000:01:0b.0: Resource 0: 0000000080000000-0000000087ffffff (f=1208)

PCI:0000:01:0b.0: Resource 1: 00000000f1001000-00000000f10010ff (f=101)

PCI:0000:01:0b.0: Resource 2: 0000000090000000-000000009000ffff (f=200)

PCI:0000:01:0b.1: Resource 0: 0000000088000000-000000008fffffff (f=1208)

PCI:0000:01:0b.1: Resource 1: 0000000090010000-000000009001ffff (f=200)

Calling initcall 0xc036e440: init_qe_ic_sysfs+0x0/0x80()

.

Calling initcall 0xc0377300: fbmem_init+0x0/0xd0()

...

Calling initcall 0xc036ee0c: mpc8360_declare_of_platform_devices+0x0/0x88()

.....

Calling initcall 0xc0123a70: pci_init+0x0/0x50()

Calling initcall 0xc037708c: pci_sysfs_init+0x0/0x58()

Calling initcall 0xc03770e4: pci_proc_init+0x0/0x9c()

Calling initcall 0xc03777a0: fb_console_init+0x0/0x1ac()

Calling initcall 0xc037794c: radeonfb_init+0x0/0x1e0()

radeonfb_pci_register BEGIN

videoboot: Booting PCI video card bus 1, function 0, device 11

RWM rinfo->name[] ATI Radeon Y`

RWM rinfo->family 0000000a

RWM rinfo->chipset 00005960

RWM rinfo->fb_base_phys 80000000

RWM rinfo->mmio_base_phys 90000000

RWM rinfo->mmio_base d1058000

VENDOR_ID 0f00 = 59601002

DEVICE_ID 0f02 = 00075960

CONFIG_MEMSIZE 00f8 = 00000000

REG_MEM_BASE 0f10 = 80000008

pci_busdev_to_OF_node(1,0x58)

radeonfb (0000:01:0b.0): Cannot match card to OF node !

aper_base: 80000000 MC_FB_LOC to: 87ff8000, MC_AGP_LOC to: ffff9000

RWM VideoRAM size read 00000000

radeonfb (0000:01:0b.0): Found 0k of SDRAM 64 bits wide videoram

radeonfb (0000:01:0b.0): cannot map FB

radeonfb: probe of 0000:01:0b.0 failed with error -5

 

 

-Russ


------=_NextPart_000_0001_01C74726.80207A90
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
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
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

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I seem to be hitting a fit on PCI errors on this =
board. Was
wondering if anybody could help me through =
this.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Here is a condensed log of what happens when I boot
2.6.20-rc6, on a MPC8360E PowerPC. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have edited out all the extra stuff and left only =
what
should be important.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The ATI card is the 1:0b:0 device that gets mapped to =
IRQ
0x17<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have turned on and added some extra debug in the =
RadeonFB
driver&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Is there a common place reason why the driver =
can&#8217;t
detect the memory size?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc036c3c0:
pcibios_init+0x0/0x24c()<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Probing PCI =
hardware<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Try to map irq for
0000:00:19.0...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(0,0xc8)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;parent is
/soc8360@f0000000/pci@8500<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;result is =
&lt;NULL&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Try to map irq for
0000:00:19.1...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(0,0xc9)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;parent is
/soc8360@f0000000/pci@8500<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;result is =
&lt;NULL&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Try to map irq for
0000:01:0b.0...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(1,0x58)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(0,0xc8)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;parent is
/soc8360@f0000000/pci@8500<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;result is =
&lt;NULL&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;-&gt; got =
one, spec 2
cells (0x00000017...) on =
/soc8360@f0000000/pic@700<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Try to map irq for
0000:01:0b.1...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(1,0x59)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc =
0..ffffffff
(100), parent c038d184<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc
80000000..8fffffff (1200), parent c038d168<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc
90000000..9fffffff (200), parent c038d168<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc
f1001000..f1001fff (101), parent c03da03c<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc
90000000..900fffff (200), parent c03da074<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: bridge rsrc
80000000..8fffffff (1201), parent c03da058<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI:0000:01:0b.0: =
Resource
0: 0000000080000000-0000000087ffffff =
(f=3D1208)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI:0000:01:0b.0: =
Resource
1: 00000000f1001000-00000000f10010ff =
(f=3D101)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI:0000:01:0b.0: =
Resource
2: 0000000090000000-000000009000ffff =
(f=3D200)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI:0000:01:0b.1: =
Resource
0: 0000000088000000-000000008fffffff =
(f=3D1208)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI:0000:01:0b.1: =
Resource
1: 0000000090010000-000000009001ffff =
(f=3D200)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc036e440:
init_qe_ic_sysfs+0x0/0x80()<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc0377300:
fbmem_init+0x0/0xd0()<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc036ee0c:
mpc8360_declare_of_platform_devices+0x0/0x88()<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>.....<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc0123a70:
pci_init+0x0/0x50()<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc037708c:
pci_sysfs_init+0x0/0x58()<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc03770e4:
pci_proc_init+0x0/0x9c()<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc03777a0:
fb_console_init+0x0/0x1ac()<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Calling initcall =
0xc037794c:
radeonfb_init+0x0/0x1e0()<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>radeonfb_pci_register BEGIN<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>videoboot: Booting =
PCI video
card bus 1, function 0, device 11<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>RWM =
rinfo-&gt;name[] ATI
Radeon Y`<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>RWM =
rinfo-&gt;family
0000000a<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>RWM =
rinfo-&gt;chipset
00005960<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>RWM =
rinfo-&gt;fb_base_phys
80000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DPT-BR style=3D'font-size:10.0pt;font-family:"Courier New"'>RWM
rinfo-&gt;mmio_base_phys 90000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DPT-BR style=3D'font-size:10.0pt;font-family:"Courier New"'>RWM
rinfo-&gt;mmio_base d1058000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>VENDOR_ID 0f00 =3D =
59601002<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>DEVICE_ID 0f02 =3D =
00075960<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_MEMSIZE 00f8 =
=3D
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>REG_MEM_BASE 0f10 =
=3D 80000008<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>pci_busdev_to_OF_node(1,0x58)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>radeonfb =
(0000:01:0b.0):
Cannot match card to OF node !<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>aper_base: 80000000
MC_FB_LOC to: 87ff8000, MC_AGP_LOC to: =
ffff9000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>RWM VideoRAM size =
read
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>radeonfb =
(0000:01:0b.0):
Found 0k of SDRAM 64 bits wide videoram<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>radeonfb =
(0000:01:0b.0):
cannot map FB<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>radeonfb: probe of
0000:01:0b.0 failed with error -5<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Russ<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C74726.80207A90--
