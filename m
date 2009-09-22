Return-Path: <tmorrison@empirix.com>
Received: from manexowa.empirix.com (unknown [66.151.190.243])
	by ozlabs.org (Postfix) with ESMTP id 621CFB70B3
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 05:42:07 +1000 (EST)
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 22 Sep 2009 15:36:22 -0400
Subject: PCI HotPlug and Adding Resources after Linux Boots 
Message-ID: <80955630EE34634AB5030FB8CE9BDCEFD7459DF2@EXBEDCLST.empirix.com>
Content-Type: multipart/alternative;
	boundary="_000_80955630EE34634AB5030FB8CE9BDCEFD7459DF2EXBEDCLSTempiri_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_80955630EE34634AB5030FB8CE9BDCEFD7459DF2EXBEDCLSTempiri_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am not exactly sure who to direct this question to (general Linux kernel =
or LinuxPPC),
so I am directing to both - in hopes that someone will recognize this probl=
em - and perhaps
give me some suggestions on how to proceed...

I am running Linux (2.6.23x (and 2.6.27.x)) on a MPC8572 based system.

I have an 8616 switch that has a Port (6) connected to a FPGA that is
NOT loaded at before Linux boots (note: this port is configured for HOTPLUG
events - which we do get after FPGA  is loaded). We are NOT using a
static device tree map (because the devices in the system are very dynamic)=
.

We use instead the pci auto scan mechanism(s) to scan/assign resources
(including into the BAR registers) at bootup to all of the devices that are
attached to this MPC8572...

Here is the port that is attached to the device (note: there are NO
resources assigned at this point this port):

---------------------------------------------------------------------------=
----------------------
02:06.0 PCI bridge: PLX Technology, Inc.: Unknown device 8616 (rev bb) (pro=
g-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D02, secondary=3D05, subordinate=3D05, sec-latency=3D=
0
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/2=
 Enable+
        Capabilities: [68] #10 [0162]
        Capabilities: [a4] #0d [0000]

root@slave7 ~ # lspci -t
-+-[01]---00.0-[02-05]--+-01.0
 |                      +-04.0-[03]--
 |                      +-05.0-[04]--
 |                      \-06.0-[05]-

---------------------------------------------------------------------------=
----------------------

Later, after I detect there is an FPGA to load - I load it. At completion o=
f the
loading of the FPGA - the 8616  detects the FPGA - and creates a HotPlug
event that the PCI Express HotPlug Driver handles:
---------------------------------------------------------------------------=
----------------------

root@slave7 ~ # pciehp: pcie_isr: intr_loc 8
pciehp: pciehp:  Presence/Notify input change.
pciehp: Card present on Slot(0005_0070)
pciehp: Surprise Removal
pciehp: hpc_get_power_status: SLOTCTRL 80 value read 8
pciehp: hpc_get_attention_status: SLOTCTRL 80, value read 8
pciehp: board_added: slot device, slot offset, hp slot =3D 0, 0 ,0
pciehp: hpc_check_lnk_status: lnk_status =3D 2021
PCI: Found 0000:05:00.0 [1172/0004] 00ff00 00
PCI: Calling quirk c0012d3c for 0000:05:00.0
program_fw_provided_values: Could not get hotplug parameters
entering assign resources (size: 2000000)
PCI: Failed to allocate mem resource #0:2000000@0 for 0000:05:00.0
bus pci: add device 0000:05:00.0
entering uevent
pci: Trying to Match Device 0000:05:00.0 with Driver pcieport-driver
pci: Trying to Match Device 0000:05:00.0 with Driver serial
pci: Trying to Match Device 0000:05:00.0 with Driver pexntb
pciehp: hpc_get_power_status: SLOTCTRL 80 value read 8
pciehp: hpc_get_attention_status: SLOTCTRL 80, value read 8

02:06.0 PCI bridge: PLX Technology, Inc.: Unknown device 8616 (rev bb) (pro=
g-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D02, secondary=3D05, subordinate=3D05, sec-latency=3D=
0
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/2=
 Enable+
        Capabilities: [68] #10 [0162]
        Capabilities: [a4] #0d [0000]

05:00.0 Class ff00: Altera Corporation: Unknown device 0004 (rev 01)
        Subsystem: Altera Corporation: Unknown device 0004
        Flags: fast devsel
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/5=
 Enable-
        Capabilities: [78] Power Management version 3
        Capabilities: [80] #10 [0001]

root@slave7 ~ # lspci -t
-+-[01]---00.0-[02-05]--+-01.0
 |                      +-04.0-[03]--
 |                      +-05.0-[04]--
 |                      \-06.0-[05]----00.0
 \-[00]---00.0

---------------------------------------------------------------------------=
----------------------

So, as you can see - the device has been read - and it requires 32M of reso=
urces, but
because its parent doesn't have any resources allocated - it seemingly can'=
t allocate and
use any additional resources.

How do I 'customize' and/or add resources at this point for this device (us=
ing semi-standard mechanisms)?

Thanks in advance for any/all ideas...


I


Tom Morrison
Principal Software Engineer
EMPIRIX
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670
email: tmorrison@empirix.com<mailto:tmorrison@empirix.com>
www.empirix.com<http://www.empirix.com/>




--_000_80955630EE34634AB5030FB8CE9BDCEFD7459DF2EXBEDCLSTempiri_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:st1=3D"urn:schemas-microsoft-com:off=
ice:smarttags" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PostalCode"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I am not exactly sure who to direct this question to (ge=
neral
Linux kernel or LinuxPPC),<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>so I am directing to both &#8211; in hopes that someone =
will
recognize this problem &#8211; and perhaps<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>give me some suggestions on how to proceed&#8230;<o:p></=
o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I am running Linux (2.6.23x (and 2.6.27.x)) on a MPC8572=
 based
system.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I have an 8616 switch that has a Port (6) connected to a
FPGA that is <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>NOT loaded at before Linux boots (note: this port is
configured for HOTPLUG<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>events - which we do get after FPGA&nbsp; is loaded). We=
 are
NOT using a <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>static device tree map (because the devices in the syste=
m are
very dynamic).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><br>
We use instead the pci auto scan mechanism(s) to scan/assign resources <o:p=
></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>(including into the BAR registers) at bootup to all of t=
he
devices that are <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>attached to this MPC8572&#8230;<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Here is the port that is attached to the device (note: t=
here
are NO <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>resources assigned at this point this port):<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>--------------------------------------------------------=
-----------------------------------------<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>02:06.0 PCI bridge: PLX Techno=
logy,
Inc.: Unknown device 8616 (rev bb) (prog-if 00 [<st1:place w:st=3D"on"><st1=
:City
 w:st=3D"on">Normal</st1:City></st1:place> decode])<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Flags: bus master, fast devsel, latency 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Bus: primary=3D02, secondary=3D05, subordinate=3D05, sec-latency=3D0<o:p></=
o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [40] Power Management version 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/2 Enable+=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [68] #10 [0162]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [a4] #0d [0000]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>root@slave7 ~ # lspci -t<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>-+-[01]---00.0-[02-05]--+-01.0=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;+-04.0-[03]--<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
+-05.0-[04]--<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
\-06.0-[05]&#8212;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>--------------------------------------------------------=
-----------------------------------------<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Later, after I detect there is an FPGA to load - I load =
it. At
completion of the<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>loading of the FPGA - the 8616 &nbsp;detects the FPGA &#=
8211;
and creates a HotPlug <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>event that the PCI Express HotPlug Driver handles:<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>--------------------------------------------------------=
-----------------------------------------<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>root@slave7 ~ # pciehp: pcie_i=
sr:
intr_loc 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: pciehp:&nbsp;
Presence/Notify input change.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: Card present on
Slot(0005_0070)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: Surprise Removal<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: hpc_get_power_status:
SLOTCTRL 80 value read 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: hpc_get_attention_stat=
us:
SLOTCTRL 80, value read 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: board_added: slot devi=
ce,
slot offset, hp slot =3D 0, 0 ,0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: hpc_check_lnk_status:
lnk_status =3D 2021<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>PCI: Found 0000:05:00.0 [1172/=
0004]
00ff00 00<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>PCI: Calling quirk c0012d3c fo=
r
0000:05:00.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>program_fw_provided_values: Co=
uld
not get hotplug parameters<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>entering assign resources (siz=
e:
2000000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>PCI: Failed to allocate mem re=
source
#0:2000000@0 for 0000:05:00.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>bus pci: add device 0000:05:00=
.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>entering uevent<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pci: Trying to Match Device
0000:05:00.0 with Driver pcieport-driver<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pci: Trying to Match Device
0000:05:00.0 with Driver serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pci: Trying to Match Device
0000:05:00.0 with Driver pexntb<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: hpc_get_power_status:
SLOTCTRL 80 value read 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>pciehp: hpc_get_attention_stat=
us:
SLOTCTRL 80, value read 8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>02:06.0 PCI bridge: PLX Techno=
logy,
Inc.: Unknown device 8616 (rev bb) (prog-if 00 [<st1:place w:st=3D"on"><st1=
:City
 w:st=3D"on">Normal</st1:City></st1:place> decode])<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Flags: bus master, fast devsel, latency 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Bus: primary=3D02, secondary=3D05, subordinate=3D05, sec-latency=3D0<o:p></=
o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [40] Power Management version 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/2 Enable+=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [68] #10 [0162]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [a4] #0d [0000]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>05:00.0 Class ff00: Altera
Corporation: Unknown device 0004 (rev 01)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Subsystem: Altera Corporation: Unknown device 0004<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Flags: fast devsel<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/5 Enable-=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [78] Power Management version 3<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
Capabilities: [80] #10 [0001]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>root@slave7 ~ # lspci -t<o:p><=
/o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>-+-[01]---00.0-[02-05]--+-01.0=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
+-04.0-[03]--<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
+-05.0-[04]--<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
\-06.0-[05]----00.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;\-[00]---00.0<o:p></o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>--------------------------------------------------------=
-----------------------------------------<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>So, as you can see &#8211; the device has been read &#82=
11;
and it requires 32M of resources, but<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>because its parent doesn&#8217;t have any resources allo=
cated
&#8211; it seemingly can&#8217;t allocate and<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>use any additional resources.<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>How do I &#8216;customize&#8217; and/or add resources at
this point for this device (using semi-standard mechanisms)?<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Thanks in advance for any/all ideas&#8230;<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p style=3D'margin-bottom:12.0pt'><strong><b><font size=3D2 color=3Dnavy
face=3DVerdana><span style=3D'font-size:10.0pt;font-family:Verdana;color:na=
vy'>Tom
Morrison</span></font></b></strong><font size=3D2 color=3Dnavy face=3DVerda=
na><span
style=3D'font-size:10.0pt;font-family:Verdana;color:navy'><br>
</span></font><font color=3Dnavy><span style=3D'color:navy'>Principal Softw=
are
Engineer</span></font><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><strong><b><font size=
=3D2
color=3Dnavy face=3DVerdana><span style=3D'font-size:10.0pt;font-family:Ver=
dana;
color:navy'>EMPIRIX</span></font></b></strong><font size=3D2 color=3Dnavy
face=3DVerdana><span style=3D'font-size:10.0pt;font-family:Verdana;color:na=
vy'> </span></font><font
color=3Dnavy><span style=3D'color:navy'><br>
<u1:Street u2:st=3D"on"><u1:address u2:st=3D"on"><st1:Street w:st=3D"on"><s=
t1:address
 w:st=3D"on">20 Crosby Drive</u1:address></u1:Street></st1:address></st1:St=
reet> </span></font><b><font
color=3D"#ff6600"><span style=3D'color:#FF6600;font-weight:bold'>-</span></=
font></b><font
size=3D2 color=3Dnavy face=3DVerdana><span style=3D'font-size:10.0pt;font-f=
amily:Verdana;
color:navy'> <u1:place u2:st=3D"on"><u1:City u2:st=3D"on"><st1:place w:st=
=3D"on"><st1:City
 w:st=3D"on">Bedford</u1:City></st1:City>, <u1:State u2:st=3D"on"><st1:Stat=
e w:st=3D"on">MA</u1:State></st1:State><b><font
 size=3D3 color=3Dblack face=3D"Times New Roman"><span style=3D'font-size:1=
2.0pt;
 font-family:"Times New Roman";color:black;font-weight:bold'>&nbsp;</span><=
/font></b><font
 size=3D3 color=3Dblack face=3D"Times New Roman"><span style=3D'font-size:1=
2.0pt;
 font-family:"Times New Roman";color:black'>&nbsp;<u1:PostalCode u2:st=3D"o=
n"></span></font><st1:PostalCode
 w:st=3D"on">01730</u1:PostalCode></u1:place></st1:PostalCode></st1:place><=
/span></font><br>
<b><font color=3D"#ff6600"><span style=3D'color:#FF6600;font-weight:bold'>p=
:</span></font></b><font
color=3D"#ff6600"><span style=3D'color:#FF6600'> </span></font><font size=
=3D2
color=3Dnavy face=3DVerdana><span style=3D'font-size:10.0pt;font-family:Ver=
dana;
color:navy'>781.266.3567 </span></font><b><font size=3D2 color=3D"#ff6600"
face=3DVerdana><span style=3D'font-size:10.0pt;font-family:Verdana;color:#F=
F6600;
font-weight:bold'>f:</span></font></b> <font size=3D2 color=3Dnavy face=3DV=
erdana><span
style=3D'font-size:10.0pt;font-family:Verdana;color:navy'>781.266.3670 </sp=
an></font><b><span
style=3D'font-weight:bold'><br>
</span></b><b><font size=3D2 color=3D"#ff6600" face=3DVerdana><span style=
=3D'font-size:
10.0pt;font-family:Verdana;color:#FF6600;font-weight:bold'>email:</span></f=
ont></b>
<u><font size=3D2 color=3Dblue face=3DVerdana><span style=3D'font-size:10.0=
pt;
font-family:Verdana;color:blue'><a href=3D"mailto:tmorrison@empirix.com"><f=
ont
size=3D3><span style=3D'font-size:12.0pt'>tmorrison@empirix.com</span></fon=
t></a></span></font></u><font
size=3D2 color=3Dnavy face=3DVerdana><span style=3D'font-size:10.0pt;font-f=
amily:Verdana;
color:navy'> </span></font><font size=3D2 color=3D"#ff6600" face=3DVerdana>=
<span
style=3D'font-size:10.0pt;font-family:Verdana;color:#FF6600'><br>
<a href=3D"http://www.empirix.com/"><font size=3D3><span style=3D'font-size=
:12.0pt'>www.empirix.com</span></font></a></span></font><font
size=3D2 color=3Dnavy face=3DVerdana><span style=3D'font-size:10.0pt;font-f=
amily:Verdana;
color:navy'><br>
<br>
<br>
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_80955630EE34634AB5030FB8CE9BDCEFD7459DF2EXBEDCLSTempiri_--
