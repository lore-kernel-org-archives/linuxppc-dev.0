Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound5-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5ADBEDDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jul 2007 01:02:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7CA15.9F3FE513"
Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
Date: Thu, 19 Jul 2007 09:00:33 -0600
In-Reply-To: <OF313D78D4.648AA3F0-ONC125731D.004BF98E-C125731D.004C2CC5@eurotel.it>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: <linux-ppc@eurotel.it>
Message-Id: <20070719150106.669DC6805D@mail55-fra.bigfish.com>
Cc: mamsadegh@hotmail.com, linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C7CA15.9F3FE513
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

The first thing I would try is to make sure eth1 comes up without first =
bringing up eth0.  In other words, does it come up independently?  If =
not, there could be something wrong with its configuration in the kernel =
or perhaps a hardware design issue.  If both interfaces come up =
independently, but not together, then there=A1=AFs likely a driver issue =
as we have not tested dual channel TEMAC with the Linux plb_temac =
driver.  Perhaps others on the list have.  The areas that I would look =
at would be:  make sure each interface is getting a unique and correct =
PHY address; make sure any calls to the shared registers of the two =
channels are protected with semaphores/spinlocks.  For example, I=A1=AFm =
pretty sure the PHY registers are shared, so any PHY accesses should be =
protected.  I would think other Xilinx driver accesses like =
Start/Stop/Reset/Get or SetOptions/etc=A1=AD should be protected as they =
may access shared registers.

=20

-Rick

=20

________________________________

From: Massimiliano.Patriarca@eurotel.it =
[mailto:Massimiliano.Patriarca@eurotel.it] On Behalf Of =
linux-ppc@eurotel.it
Sent: Thursday, July 19, 2007 7:51 AM
To: Rick Moleres
Cc: Ming Liu; linuxppc-embedded@ozlabs.org; =
linuxppc-embedded-bounces+linux-ppc=3Deurotel.it@ozlabs.org; =
mamsadegh@hotmail.com
Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6

=20


Hi, we are trying to use both side of an hard temac + 2 plb temac in a =
Virtex4FX12 project.=20
we succesfull implemented a single temac Montavista tree with eth0.=20
when trying to use both temac, devices are correctly registered with =
kernel-=20
eth0 comes up and working ok-=20
when manually start eth1 (/sbin/ifconfig eth1 up) kernel hang without =
any error or info in the console=20

# dmesg=20
Linux version 2.6.10_mvl401-ml40x (massimiliano@linux-yhbz) (gcc version =
3.4.3 (MontaVista 3.4.3-25.0.135.0702900 2007-04-01)) #250 Wed Jul 18 =
12:20:43 CEST 2007=20
Eurotel motherboard init=20
Port by MontaVista Software, Inc. (source@mvista.com)=20
On node 0 totalpages: 7812=20
  DMA zone: 7812 pages, LIFO batch:1=20
  Normal zone: 0 pages, LIFO batch:1=20
  HighMem zone: 0 pages, LIFO batch:1=20
Built 1 zonelists=20
Kernel command line: console=3Dttl0 root=3D/dev/xsysace2 rw ip=3Doff=20
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000=20
PID hash table entries: 128 (order: 7, 2048 bytes)=20
hr_time_init: arch_to_nsec =3D 8192000, nsec_to_arch =3D 1099511627=20
Console: colour dummy device 80x25=20
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)=20
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)=20
Memory: 28420k available (1864k kernel code, 528k data, 124k init, 0k =
highmem)=20
Calibrating delay loop... 252.92 BogoMIPS (lpj=3D126464)=20
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)=20
spawn_desched_task(00000000)=20
desched cpu_callback 3/00000000=20
ksoftirqd started up.=20
desched cpu_callback 2/00000000=20
desched thread 0 started up.=20
NET: Registered protocol family 16=20
Registering platform device 'xilinx_temac.0'. Parent at platform=20
Registering platform device 'xilinx_temac.1'. Parent at platform=20
Registering platform device 'xilinx_sysace.0'. Parent at platform=20
Registering platform device 'xilinx_gpio.0'. Parent at platform=20
Registering platform device 'xilinx_gpio.1'. Parent at platform=20
Registering platform device 'oled_fb.0'. Parent at platform=20
Generic PHY: Registered new driver=20
oled_fb: 4096 video memory mapped to c2011000=20
Console: switching to colour frame buffer device 16x8=20
xgpio #0 at 0x40000000 mapped to 0xC2020000=20
xgpio #1 at 0x40020000 mapped to 0xC2040000=20
io scheduler noop registered=20
io scheduler anticipatory registered=20
io scheduler deadline registered=20
io scheduler cfq registered=20
loop: loaded (max 8 devices)=20
elevator: using anticipatory as default io scheduler=20
System ACE at 0x41800000 mapped to 0xC2060000, irq=3D4, 1000944KB=20
 xsysace: xsysace1 xsysace2=20
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky=20
XTemac: using FIFO direct interrupt driven mode.=20
eth0: Xilinx TEMAC #0 at 0x20000000 mapped to 0xC2080000, irq=3D0=20
eth0: XTemac id 1.0f, block id 5, type 8=20
XTemac: using FIFO direct interrupt driven mode.=20
eth1: Xilinx TEMAC #1 at 0x20010000 mapped to 0xC20A0000, irq=3D10=20
eth1: XTemac id 1.0f, block id 5, type 8=20
i2c /dev entries driver=20
i2c-xil_custom: registered with I2C (0)=20
i2c-xil_custom: registered with I2C (1)=20
mice: PS/2 mouse device common for all mice=20
NET: Registered protocol family 2=20
IP: routing cache hash table of 512 buckets, 4Kbytes=20
TCP: Hash tables configured (established 2048 bind 4096)=20
NET: Registered protocol family 1=20
NET: Registered protocol family 17=20
EXT3-fs warning: maximal mount count reached, running e2fsck is =
recommended=20
kjournald starting.  Commit interval 5 seconds=20
EXT3 FS on xsysace2, internal journal=20
EXT3-fs: recovery complete.=20
EXT3-fs: mounted filesystem with ordered data mode.=20
VFS: Mounted root (ext3 filesystem).=20
Freeing unused kernel memory: 124k init=20
eth0: XTemac: Options: 0xb8f2=20
eth0: XTemac: speed set to 100Mb/s=20
eth0: XTemac: PHY Link carrier lost.=20

# /sbin/ifconfig eth1 up=20
# eth1: XTemac: Options: 0xb8f2=20

Any suggestion?=20




"Rick Moleres" <Rick.Moleres@xilinx.com>=20
Sent by: linuxppc-embedded-bounces+linux-ppc=3Deurotel.it@ozlabs.org=20

08/02/2007 17.23=20

To

"Ming Liu" <eemingliu@hotmail.com>, <mamsadegh@hotmail.com>=20

cc

linuxppc-embedded@ozlabs.org=20

Subject

RE: ML403 Hard TEMAC, PLB and Linux 2.6

=20

=20

=20




Hi,

As Ming says the Linux 2.6 TEMAC driver is made available in EDK 8.2.2 =
as part of the BSP and Libraries generation for Linux 2.6.  Note that we =
made a recent fix for better PHY address detection and speed =
negotiation. I've attached the adapter here, and it will be available in =
EDK 9.1.1 when that's released.

Thanks,
Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On =
Behalf Of Ming Liu
Sent: Thursday, February 08, 2007 2:31 AM
To: mamsadegh@hotmail.com
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6

Hi,
In xapp902, they are using the old cores for Temac. So it will be easier =
to=20
generate a project in EDK 8.2. Not only the cores there are new, but =
also=20
it can generate the driver for linux 2.6.

BR
Ming

>From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
>To: <christophe.alayrac@cresitt.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
>Date: Thu, 8 Feb 2007 07:13:47 +0000
>
>
>Hi
>Thanks for reply
>Well, regarding xapp902, there is a very simple question, Where can I =
find=20
it? It seems that Xilinx has deleted all of the links to these files.
>
>
>
>
>
>----------------------------------------
> > Subject: Re: ML403 Hard TEMAC, PLB and Linux 2.6
> > From: christophe.alayrac@cresitt.com
> > To: mamsadegh@hotmail.com
> > CC: linuxppc-embedded@ozlabs.org
> > Date: Thu, 8 Feb 2007 06:51:45 +0100
> >
> > Le mercredi 07 f=E9vrier 2007 ?22:30 +0000, Mohammad Sadegh Sadri a
> > =E9crit :
> > Hi Mohammad,
> >
> > Please find here after some answer
> >
> > > 1- I want to use, ML403, Hard TEMAC and PLB TEMAC cores. Is there =
any=20
ready to use design, or any reference design available for this?
> > > I'm using EDK 8.1 and I understood that, when I choose the ML403=20
board , EDK does not use hard temac, so , should I add it manually? ( =
well=20
this is funny, but the wizard does not use hard temac , is it true? )
> > > Is there any ready EDK projects for ML403, with TEMAC and PLB =
TEMAC=20
modules already inserted and cofigured? (I don't want to use GSRD ) ( If =

yes would you please put the link here )
> > >
> > You can start from XAPP 902 from Xilinx, this design demonstrate =
TEMAC
> > use in loopback mode. Some memers from that community have tried =
from
> > that design as a starting point. I did not nknow if the succeed.
> > I would recommand to get EDK 8.2 SP2 and use the Wizard to build a =
new
> > design with TEMAC.
> >
> > > 2- Simply, Is there any driver available for linux 2.6 , for PLB=20
TEMAC and Hard TEMAC modules? If yes , can you put the link here, so =
that I=20
can download it?
> > >
> > For the kernel you can get it from Montavista source code site using =

GIT
> > to download it (linux-xilinx-26). This is 2.6.17.4 version (last =
week!)
> >
> > Then you will need to pacth the Kernel with TEMAC drivers (look for
> > TEMAC PAULUS MVISTA with google, or follow my messages in that =
mailing
> > list)
> > NOTE: If you use that TEMAC patch do not use SGDMA on your TEMAC, =
use
> > FIFO.
> >
> > > thanks
> > Regards
> >
> > Chris
> > > _________________________________________________________________
> > > Personalize your Live.com homepage with the news, weather, and =
photos=20
you care about.
> > > http://www.live.com/getstarted.aspx?icid=3DT001MSN30A0701
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>_________________________________________________________________
>Live Search: New search found
>http://get.live.com/search/overview
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
=D3=EB=C1=AA=BB=FA=B5=C4=C5=F3=D3=D1=BD=F8=D0=D0=BD=BB=C1=F7=A3=AC=C7=EB=CA=
=B9=D3=C3 MSN Messenger:  http://messenger.msn.com/cn =20

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded=20


------_=_NextPart_001_01C7CA15.9F3FE513
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:sans-serif;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@SimSun";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;}
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
	font-family:SimSun;}
tt
	{font-family:SimSun;}
span.EmailStyle19
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
10.0pt;font-family:Arial;color:navy'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>The first thing I would try is to =
make
sure eth1 comes up without first bringing up eth0. &nbsp;In other words, =
does
it come up independently?&nbsp; If not, there could be something wrong =
with its
configuration in the kernel or perhaps a hardware design issue. &nbsp;If =
both
interfaces come up independently, but not together, then there=A1=AFs =
likely a
driver issue as we have not tested dual channel TEMAC with the Linux =
plb_temac
driver. &nbsp;Perhaps others on the list have.&nbsp; The areas that I =
would
look at would be:&nbsp; make sure each interface is getting a unique and
correct PHY address; make sure any calls to the shared registers of the =
two
channels are protected with semaphores/spinlocks. &nbsp;For example, =
I=A1=AFm pretty
sure the PHY registers are shared, so any PHY accesses should be =
protected. &nbsp;I
would think other Xilinx driver accesses like Start/Stop/Reset/Get or
SetOptions/etc=A1=AD should be protected as they may access shared =
registers.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>-Rick<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter =
style=3D'margin-left:.5in;text-align:center'><font
size=3D3 face=3DSimSun><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><b><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma;font-weight:bold'>From:</spa=
n></font></b><font
size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma'>
Massimiliano.Patriarca@eurotel.it =
[mailto:Massimiliano.Patriarca@eurotel.it] <b><span
style=3D'font-weight:bold'>On Behalf Of =
</span></b>linux-ppc@eurotel.it<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Thursday, July 19, =
2007 7:51
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Rick Moleres<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> Ming Liu;
linuxppc-embedded@ozlabs.org;
linuxppc-embedded-bounces+linux-ppc=3Deurotel.it@ozlabs.org;
mamsadegh@hotmail.com<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> RE: ML403 Hard =
TEMAC, PLB
and Linux 2.6</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3DSimSun><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0in;margin-right:0in;margin-bottom:
12.0pt;margin-left:.5in'><font size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><br>
</span></font><font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;
font-family:sans-serif'>Hi, we are trying to use both side of an hard =
temac + 2
plb temac in a Virtex4FX12 project.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>we
succesfull implemented a single temac Montavista tree with =
eth0.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>when
trying to use both temac, devices are correctly registered with =
kernel-</span></font>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>eth0
comes up and working ok-</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>when
manually start eth1 (/sbin/ifconfig eth1 up) kernel hang without any =
error or
info in the console</span></font> <br>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>#
dmesg</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Linux
version 2.6.10_mvl401-ml40x (massimiliano@linux-yhbz) (gcc version 3.4.3
(MontaVista 3.4.3-25.0.135.0702900 2007-04-01)) #250 Wed Jul 18 12:20:43 =
CEST
2007</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Eurotel
motherboard init</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Port
by MontaVista Software, Inc. (source@mvista.com)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>On
node 0 totalpages: 7812</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>&nbsp;
DMA zone: 7812 pages, LIFO batch:1</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>&nbsp;
Normal zone: 0 pages, LIFO batch:1</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>&nbsp;
HighMem zone: 0 pages, LIFO batch:1</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Built
1 zonelists</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Kernel
command line: console=3Dttl0 root=3D/dev/xsysace2 rw =
ip=3Doff</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Xilinx
INTC #0 at 0x41200000 mapped to 0xFDFFF000</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>PID
hash table entries: 128 (order: 7, 2048 bytes)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>hr_time_init:
arch_to_nsec =3D 8192000, nsec_to_arch =3D 1099511627</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Console:
colour dummy device 80x25</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Dentry
cache hash table entries: 4096 (order: 2, 16384 bytes)</span></font> =
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Inode-cache
hash table entries: 2048 (order: 1, 8192 bytes)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Memory:
28420k available (1864k kernel code, 528k data, 124k init, 0k =
highmem)</span></font>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Calibrating
delay loop... 252.92 BogoMIPS (lpj=3D126464)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Mount-cache
hash table entries: 512 (order: 0, 4096 bytes)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>spawn_desched_task(0000=
0000)</span></font>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>desched
cpu_callback 3/00000000</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>ksoftirqd
started up.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>desched
cpu_callback 2/00000000</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>desched
thread 0 started up.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>NET:
Registered protocol family 16</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Registering
platform device 'xilinx_temac.0'. Parent at platform</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Registering
platform device 'xilinx_temac.1'. Parent at platform</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Registering
platform device 'xilinx_sysace.0'. Parent at platform</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Registering
platform device 'xilinx_gpio.0'. Parent at platform</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Registering
platform device 'xilinx_gpio.1'. Parent at platform</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Registering
platform device 'oled_fb.0'. Parent at platform</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Generic
PHY: Registered new driver</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>oled_fb:
4096 video memory mapped to c2011000</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Console:
switching to colour frame buffer device 16x8</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>xgpio
#0 at 0x40000000 mapped to 0xC2020000</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>xgpio
#1 at 0x40020000 mapped to 0xC2040000</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>io
scheduler noop registered</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>io
scheduler anticipatory registered</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>io
scheduler deadline registered</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>io
scheduler cfq registered</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>loop:
loaded (max 8 devices)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>elevator:
using anticipatory as default io scheduler</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>System
ACE at 0x41800000 mapped to 0xC2060000, irq=3D4, 1000944KB</span></font> =
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>&nbsp;xsysace:
xsysace1 xsysace2</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Universal
TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky</span></font> =
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>XTemac:
using FIFO direct interrupt driven mode.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>eth0:
Xilinx TEMAC #0 at 0x20000000 mapped to 0xC2080000, =
irq=3D0</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>eth0:
XTemac id 1.0f, block id 5, type 8</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>XTemac:
using FIFO direct interrupt driven mode.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>eth1:
Xilinx TEMAC #1 at 0x20010000 mapped to 0xC20A0000, =
irq=3D10</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>eth1:
XTemac id 1.0f, block id 5, type 8</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>i2c
/dev entries driver</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>i2c-xil_custom:
registered with I2C (0)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>i2c-xil_custom:
registered with I2C (1)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>mice:
PS/2 mouse device common for all mice</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>NET:
Registered protocol family 2</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>IP:
routing cache hash table of 512 buckets, 4Kbytes</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>TCP:
Hash tables configured (established 2048 bind 4096)</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>NET:
Registered protocol family 1</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>NET:
Registered protocol family 17</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>EXT3-fs
warning: maximal mount count reached, running e2fsck is =
recommended</span></font>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>kjournald
starting. &nbsp;Commit interval 5 seconds</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>EXT3
FS on xsysace2, internal journal</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>EXT3-fs:
recovery complete.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>EXT3-fs:
mounted filesystem with ordered data mode.</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>VFS:
Mounted root (ext3 filesystem).</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Freeing
unused kernel memory: 124k init</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>eth0:
XTemac: Options: 0xb8f2</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>eth0:
XTemac: speed set to 100Mb/s</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>eth0:
XTemac: PHY Link carrier lost.</span></font> <br>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>#
/sbin/ifconfig eth1 up</span></font> <br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>#
eth1: XTemac: Options: 0xb8f2</span></font> <br>
<br>
<font size=3D2 face=3Dsans-serif><span =
style=3D'font-size:10.0pt;font-family:sans-serif'>Any
suggestion?</span></font> <br>
<br>
<br>
<o:p></o:p></p>

<table class=3DMsoNormalTable border=3D0 cellpadding=3D0 width=3D"100%"
 style=3D'width:100.0%;margin-left:.5in'>
 <tr>
  <td width=3D"39%" valign=3Dtop style=3D'width:39.98%;padding:.75pt =
.75pt .75pt .75pt'>
  <p class=3DMsoNormal><b><font size=3D1 face=3Dsans-serif><span =
style=3D'font-size:
  7.5pt;font-family:sans-serif;font-weight:bold'>&quot;Rick =
Moleres&quot;
  &lt;Rick.Moleres@xilinx.com&gt;</span></font></b><font size=3D1
  face=3Dsans-serif><span =
style=3D'font-size:7.5pt;font-family:sans-serif'> </span></font><br>
  <font size=3D1 face=3Dsans-serif><span =
style=3D'font-size:7.5pt;font-family:sans-serif'>Sent
  by: =
linuxppc-embedded-bounces+linux-ppc=3Deurotel.it@ozlabs.org</span></font>=
 <o:p></o:p></p>
  <p><font size=3D1 face=3Dsans-serif><span =
style=3D'font-size:7.5pt;font-family:
  sans-serif'>08/02/2007 17.23</span></font> <o:p></o:p></p>
  </td>
  <td width=3D"58%" valign=3Dtop style=3D'width:58.98%;padding:.75pt =
.75pt .75pt .75pt'>
  <table class=3DMsoNormalTable border=3D0 cellpadding=3D0 =
width=3D"100%"
   style=3D'width:100.0%'>
   <tr>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal align=3Dright style=3D'text-align:right'><font =
size=3D1
    face=3Dsans-serif><span =
style=3D'font-size:7.5pt;font-family:sans-serif'>To</span></font><o:p></o=
:p></p>
    </td>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal><font size=3D1 face=3Dsans-serif><span =
style=3D'font-size:
    7.5pt;font-family:sans-serif'>&quot;Ming Liu&quot;
    &lt;eemingliu@hotmail.com&gt;, =
&lt;mamsadegh@hotmail.com&gt;</span></font> <o:p></o:p></p>
    </td>
   </tr>
   <tr>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal align=3Dright style=3D'text-align:right'><font =
size=3D1
    face=3Dsans-serif><span =
style=3D'font-size:7.5pt;font-family:sans-serif'>cc</span></font><o:p></o=
:p></p>
    </td>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal><font size=3D1 face=3Dsans-serif><span =
style=3D'font-size:
    =
7.5pt;font-family:sans-serif'>linuxppc-embedded@ozlabs.org</span></font> =
<o:p></o:p></p>
    </td>
   </tr>
   <tr>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal align=3Dright style=3D'text-align:right'><font =
size=3D1
    face=3Dsans-serif><span =
style=3D'font-size:7.5pt;font-family:sans-serif'>Subject</span></font><o:=
p></o:p></p>
    </td>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal><font size=3D1 face=3Dsans-serif><span =
style=3D'font-size:
    7.5pt;font-family:sans-serif'>RE: ML403 Hard TEMAC, PLB and Linux =
2.6</span></font><o:p></o:p></p>
    </td>
   </tr>
  </table>
  <p class=3DMsoNormal><font size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>
  <table class=3DMsoNormalTable border=3D0 cellpadding=3D0>
   <tr>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal><font size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>
    </td>
    <td valign=3Dtop style=3D'padding:.75pt .75pt .75pt .75pt'>
    <p class=3DMsoNormal><font size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>
    </td>
   </tr>
  </table>
  <p class=3DMsoNormal><font size=3D3 face=3DSimSun><span =
style=3D'font-size:12.0pt'><o:p></o:p></span></font></p>
  </td>
 </tr>
</table>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3DSimSun><span
style=3D'font-size:12.0pt'><br>
<br>
<br>
</span></font><tt><font size=3D2 face=3DSimSun><span =
style=3D'font-size:10.0pt'>Hi,</span></font></tt><font
size=3D2><span style=3D'font-size:10.0pt'><br>
<br>
<tt><font face=3DSimSun>As Ming says the Linux 2.6 TEMAC driver is made =
available
in EDK 8.2.2 as part of the BSP and Libraries generation for Linux 2.6. =
</font></tt></span></font><tt><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></tt><tt><font
size=3D2 face=3DSimSun><span style=3D'font-size:10.0pt'>Note that we =
made a recent
fix for better PHY address detection and speed negotiation. I've =
attached the
adapter here, and it will be available in EDK 9.1.1 when that's =
released.</span></font></tt><font
size=3D2><span style=3D'font-size:10.0pt'><br>
<br>
<tt><font face=3DSimSun>Thanks,</font></tt><br>
<tt><font face=3DSimSun>Rick</font></tt><br>
<br>
<tt><font face=3DSimSun>-----Original Message-----</font></tt><br>
<tt><font face=3DSimSun>From:
linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On =
Behalf Of
Ming Liu</font></tt><br>
<tt><font face=3DSimSun>Sent: Thursday, February 08, 2007 2:31 =
AM</font></tt><br>
<tt><font face=3DSimSun>To: mamsadegh@hotmail.com</font></tt><br>
<tt><font face=3DSimSun>Cc: linuxppc-embedded@ozlabs.org</font></tt><br>
<tt><font face=3DSimSun>Subject: RE: ML403 Hard TEMAC, PLB and Linux =
2.6</font></tt><br>
<br>
<tt><font face=3DSimSun>Hi,</font></tt><br>
<tt><font face=3DSimSun>In xapp902, they are using the old cores for =
Temac. So it
will be easier to </font></tt><br>
<tt><font face=3DSimSun>generate a project in EDK 8.2. Not only the =
cores there
are new, but also </font></tt><br>
<tt><font face=3DSimSun>it can generate the driver for linux =
2.6.</font></tt><br>
<br>
<tt><font face=3DSimSun>BR</font></tt><br>
<tt><font face=3DSimSun>Ming</font></tt><br>
<br>
<tt><font face=3DSimSun>&gt;From: Mohammad Sadegh Sadri
&lt;mamsadegh@hotmail.com&gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;To: =
&lt;christophe.alayrac@cresitt.com&gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;CC: =
linuxppc-embedded@ozlabs.org</font></tt><br>
<tt><font face=3DSimSun>&gt;Subject: RE: ML403 Hard TEMAC, PLB and Linux =
2.6</font></tt><br>
<tt><font face=3DSimSun>&gt;Date: Thu, 8 Feb 2007 07:13:47 =
+0000</font></tt><br>
<tt><font face=3DSimSun>&gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;Hi</font></tt><br>
<tt><font face=3DSimSun>&gt;Thanks for reply</font></tt><br>
<tt><font face=3DSimSun>&gt;Well, regarding xapp902, there is a very =
simple
question, Where can I find </font></tt><br>
<tt><font face=3DSimSun>it? It seems that Xilinx has deleted all of the =
links to
these files.</font></tt><br>
<tt><font face=3DSimSun>&gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;</font></tt><br>
<tt><font =
face=3DSimSun>&gt;----------------------------------------</font></tt><br=
>
<tt><font face=3DSimSun>&gt; &gt; Subject: Re: ML403 Hard TEMAC, PLB and =
Linux
2.6</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; From: =
christophe.alayrac@cresitt.com</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; To: =
mamsadegh@hotmail.com</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; CC: =
linuxppc-embedded@ozlabs.org</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; Date: Thu, 8 Feb 2007 06:51:45 =
+0100</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; Le mercredi 07 f<span =
lang=3DZH-CN>=E9v</span>rier
2007 ?22:30 +0000, Mohammad Sadegh Sadri a</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; <span lang=3DZH-CN>=E9c</span>rit =
:</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; Hi Mohammad,</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; Please find here after some =
answer</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt; 1- I want to use, ML403, Hard =
TEMAC and
PLB TEMAC cores. Is there any </font></tt><br>
<tt><font face=3DSimSun>ready to use design, or any reference design =
available
for this?</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt; I'm using EDK 8.1 and I =
understood that,
when I choose the ML403 </font></tt><br>
<tt><font face=3DSimSun>board , EDK does not use hard temac, so , should =
I add it
manually? ( well </font></tt><br>
<tt><font face=3DSimSun>this is funny, but the wizard does not use hard =
temac ,
is it true? )</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt; Is there any ready EDK projects =
for ML403,
with TEMAC and PLB TEMAC </font></tt><br>
<tt><font face=3DSimSun>modules already inserted and cofigured? (I don't =
want to
use GSRD ) ( If </font></tt><br>
<tt><font face=3DSimSun>yes would you please put the link here =
)</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; You can start from XAPP 902 from =
Xilinx, this
design demonstrate TEMAC</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; use in loopback mode. Some memers from =
that
community have tried from</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; that design as a starting point. I did =
not
nknow if the succeed.</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; I would recommand to get EDK 8.2 SP2 =
and use
the Wizard to build a new</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; design with TEMAC.</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt; 2- Simply, Is there any driver =
available
for linux 2.6 , for PLB </font></tt><br>
<tt><font face=3DSimSun>TEMAC and Hard TEMAC modules? If yes , can you =
put the
link here, so that I </font></tt><br>
<tt><font face=3DSimSun>can download it?</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; For the kernel you can get it from =
Montavista
source code site using </font></tt><br>
<tt><font face=3DSimSun>GIT</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; to download it (linux-xilinx-26). This =
is
2.6.17.4 version (last week!)</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; Then you will need to pacth the Kernel =
with
TEMAC drivers (look for</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; TEMAC PAULUS MVISTA with google, or =
follow my
messages in that mailing</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; list)</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; NOTE: If you use that TEMAC patch do =
not use
SGDMA on your TEMAC, use</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; FIFO.</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt; thanks</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; Regards</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; Chris</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt;
_________________________________________________________________</font><=
/tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt; Personalize your Live.com =
homepage with
the news, weather, and photos </font></tt><br>
<tt><font face=3DSimSun>you care about.</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt;
http://www.live.com/getstarted.aspx?icid=3DT001MSN30A0701</font></tt><br>=

<tt><font face=3DSimSun>&gt; &gt; &gt;
_______________________________________________</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt; Linuxppc-embedded mailing =
list</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt; =
Linuxppc-embedded@ozlabs.org</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt; &gt;
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</font></tt><br>
<tt><font face=3DSimSun>&gt; &gt;</font></tt><br>
<tt><font face=3DSimSun>&gt;</font></tt><br>
<tt><font =
face=3DSimSun>&gt;_______________________________________________________=
__________</font></tt><br>
<tt><font face=3DSimSun>&gt;Live Search: New search =
found</font></tt><br>
<tt><font =
face=3DSimSun>&gt;http://get.live.com/search/overview</font></tt><br>
<tt><font =
face=3DSimSun>&gt;_______________________________________________</font><=
/tt><br>
<tt><font face=3DSimSun>&gt;Linuxppc-embedded mailing =
list</font></tt><br>
<tt><font face=3DSimSun>&gt;Linuxppc-embedded@ozlabs.org</font></tt><br>
<tt><font =
face=3DSimSun>&gt;https://ozlabs.org/mailman/listinfo/linuxppc-embedded</=
font></tt><br>
<br>
<tt><font =
face=3DSimSun>___________________________________________________________=
______</font></tt><br>
<tt><font face=3DSimSun><span =
lang=3DZH-CN>=D3=EB=C1=AA=BB=FA=B5=C4=C5=F3=D3=D1=BD=F8=D0=D0=BD=BB=C1=F7=
=A3=AC=C7=EB=CA=B9=D3=C3</span></font></tt><tt><font
face=3DSimSun> MSN Messenger: </font></tt></span></font><tt><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></tt><tt><font
size=3D2 face=3DSimSun><span =
style=3D'font-size:10.0pt'>http://messenger.msn.com/cn =
</span></font></tt><tt><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font></tt><font
size=3D2><span style=3D'font-size:10.0pt'><br>
<br>
<tt><font =
face=3DSimSun>_______________________________________________</font></tt>=
<br>
<tt><font face=3DSimSun>Linuxppc-embedded mailing list</font></tt><br>
<tt><font face=3DSimSun>Linuxppc-embedded@ozlabs.org</font></tt><br>
<tt><font =
face=3DSimSun>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</font=
></tt></span></font>
<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7CA15.9F3FE513--
