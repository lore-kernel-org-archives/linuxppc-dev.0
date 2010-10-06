Return-Path: <tanderson@curtisswright.com>
Received: from mail152.messagelabs.com (mail152.messagelabs.com
	[216.82.253.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail152.messagelabs.com",
	Issuer "MessageLabs" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F1351B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 05:08:11 +1100 (EST)
From: "Anderson, Trevor" <tanderson@curtisswright.com>
To: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>, John Traill
	<john.traill@freescale.com>
Date: Wed, 6 Oct 2010 14:08:02 -0400
Subject: RE: Serial RapidIO Maintaintance read causes lock up
Message-ID: <1682399277683944B902B3657D2FCE21654570E411@CAREXCLUSTER03.ATL.CW.LOCAL>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
	<AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
In-Reply-To: <AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="_000_1682399277683944B902B3657D2FCE21654570E411CAREXCLUSTER0_"
MIME-Version: 1.0
Cc: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_1682399277683944B902B3657D2FCE21654570E411CAREXCLUSTER0_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I may have come across a similar problem, but I've never worked card-to-ca=
rd without at least one switch in the way.
The problems I have encountered have been hang-ups during memory-mapped ma=
intenance reads to devices that the switch reports as "up".

A workaround for the hang-up is to use a DMA transfer that bypasses the AT=
MU to perform a maintenance read (not all, just the first, a test read of =
a new discovery). If the DMA fails, as it does in those unusual circumstan=
ces, it will report a bus transfer error - but it will not hang up. You ca=
n recover, and avoid or re-try the connection later.

A real "fix" for your problem may be to ensure that both of your RapidIO i=
nterfaces are programmed to accept all incoming transactions (see "Accept =
All Configuration Register (AACR)" in Freescale reference manual). But no =
guarantees with that - it just seemed to clear up problems on my own rig.





From: linuxppc-dev-bounces+tanderson=3Dcurtisswright.com@lists.ozlabs.org =
[mailto:linuxppc-dev-bounces+tanderson=3Dcurtisswright.com@lists.ozlabs.or=
g] On Behalf Of Bastiaan Nijkamp
Sent: Tuesday, October 05, 2010 7:28 AM
To: John Traill
Cc: Bounine, Alexandre; linuxppc-dev@lists.ozlabs.org
Subject: Re: Serial RapidIO Maintaintance read causes lock up

Hi John,

1. Yes, they are both running the exact same kernel and both are configure=
d in the same way. With the exception that one is set as host and the othe=
r as a agent.

2. Accept All is set for both boards.

3. As i understand, the agent cannot send anything before it is enumerated=
, so it would be safe to first reset the agent and right after that the ho=
st. In either case, thats the way i am using. The full kernel log until th=
e discovery times out after 30 seconds is shown below:

Using SBC8548 machine description
Memory CAM mapping: 256 Mb, residual: 0Mb
Linux version 2.6.35.6 (dl704@lxws006<mailto:dl704@lxws006>) (gcc version =
4.4.1 (Wind River Linux Sour
cery G++ 4.4-250) ) #3 Tue Oct 5 13:24:45 CEST 2010
bootconsole [udbg0] enabled
setup_arch: bootmem
sbc8548_setup_arch()
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024=

Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.100.21:/thales/t=
arget/rfs/
sbc8548_wrlinux4 ip=3D192.168.100.151:192.168.100.21:192.168.100.21:255.25=
5.255.0:
sbc8548_1:eth0:off console=3DttyS0,115200
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256996k/262144k available (2644k kernel code, 5148k reserved, 108k=
 data,
 77k bss, 136k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfdffd000..0xfe000000  : early ioremap
  * 0xd1000000..0xfdffd000  : vmalloc & ioremap
Hierarchical RCU implementation.
 RCU-based detection of stalled=20CPUs is disabled.
 Verbose stalled-CPUs detection is disabled.
NR_IRQS:512 nr_irqs:512
mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 80, shift: 7, mask: 7f
mpic: Initializing for 80 sources
clocksource: timebase mult[50cede6] shift[22] registered
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16

PCI: Probing PCI hardware
bio: create slab <bio-0> at 0
vgaarb: loaded
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Of-device full name /soc8548@e0000000/rapidio=
@c0000
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size 0x00000000=
20000000.
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
fsl-of-rio e00c0000.rapidio: DeviceID is 0xffffffff
fsl-of-rio e00c0000.rapidio: Configured as AGENT
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
fsl-of-rio e00c0000.rapidio: Hardware port width: 4
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0
fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainanc=
e Window Size 0x400000,New Main Start: 0xd1080000
RIO: discover master port 0, RIO0 mport

A interesting thing that i found out is that when the agent is reset while=
 the host is locked up (eg. it cannot be stopped nor can i read the regist=
ers and memory trough a JTAG Interface), the host comes back online and ju=
st continues booting linux with a RapidIO error. See the log below.

Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Of-device full name /soc8548@e0000000/rapidio=
@c0000
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size 0x00000000=
20000000.
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
fsl-of-rio e00c0000.rapidio: DeviceID is 0x0
fsl-of-rio e00c0000.rapidio: Configured as HOST
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
fsl-of-rio e00c0000.rapidio: Hardware port width: 4
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0
fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainanc=
e Window Size 0x400000,New Main Start: 0xd1080000
RIO: enumerate master port 0, RIO0 mport
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
fsl_rio_config_read: Passed IS_ALIGNED.
fsl_rio_config_read: Passed 'out_be32_1'
fsl_rio_config_read: Passed 'out_be32_2'
fsl_rio_config_read: len is 4
fsl_rio_config_read: triggering '__fsl_read_rio_config'
fsl_rio_config_read: going to request to read data at d1080068
RIO: cfg_read error -14 for ff:0:68
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
fsl_rio_config_read: Passed IS_ALIGNED.
fsl_rio_config_read: Passed 'out_be32_1'
fsl_rio_config_read: Passed 'out_be32_2'
fsl_rio_config_read: len is 4
fsl_rio_config_read: triggering '__fsl_read_rio_config'
fsl_rio_config_read: going to request to read data at d1080068
RIO: cfg_read error -14 for ff:0:68
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
fsl_rio_config_read: Passed IS_ALIGNED.
fsl_rio_config_read: Passed 'out_be32_1'
fsl_rio_config_read: Passed 'out_be32_2'
fsl_rio_config_read: len is 4
fsl_rio_config_read: triggering '__fsl_read_rio_config'
fsl_rio_config_read: going to request to read data at d1080068
RIO: cfg_read error -14 for ff:0:68
RIO: master port 0 device has lost enumeration to a remote host

Regards,
Bastiaan
2010/10/5 John Traill <john.traill@freescale.com<mailto:john.traill@freesc=
ale.com>>
Bastiaan,

A few things to check.

1. Is the target board also set up for small common transport system size =
ie 256.

2. Make sure the target has "Accept All" set - in fsl_rio.c look for
      /* Set to receive any dist ID for serial RapidIO controller. */
       if (port->phy_type =3D=3D RIO_PHY_SERIAL)
               out_be32((priv->regs_win + RIO_ISR_AACR), RIO_ISR_AACR_AA);=


3. How do you synchronise reset between both systems ? Both need to be res=
et to insure the inbound/outbound ackid's remain in sync. If you only rese=
t one then you have the potential for the ackid's to get out of sync. Also=
 what is the kernel log on the agent system ?

Cheers.



On 05/10/10 09:56, Bastiaan Nijkamp wrote:

Hi Alex,

Thanks for your advice. We are trying to make a board-to-board
connection without any additional hardware (eg. a switch). The boards
use a 50-pin, right-angle MEC8-125-02-L-D-RA1 connector from SAMTEC and
are connected trough a EEDP-016-12.00-RA1-RA2-2 cross cable from SAMTEC.
I hope this information is sufficient since there is not much one can
find about it on Google. In addition, you can see a picture of the board
including the connector in the datasheet located at
http://www.windriver.com/products/product-notes/SBC8548E-product-note.pdf.=

It is the connector on the left side of the PCI-EX slot.

We have tried your suggestion but the situation does not change other
than the lane-mode being set to single lane 0, it still locks up when
trying to generate a maintenance transaction. I still think it is memory
related since the lock up occurs when accessing the maintenance window.
Although all memory related settings seems to be alright.

The kernel output is as follows:

Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Of-device full name
/soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
0x0000000010000000.
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
fsl-of-rio e00c0000.rapidio: DeviceID is 0x0
fsl-of-rio e00c0000.rapidio: Configured as HOST
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
fsl-of-rio e00c0000.rapidio: Hardware port width: 4
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0
fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO
Maintainance Window Size 0x400000,New Main Start: 0xd1080000
RIO: enumerate master port 0, RIO0 mport
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
fsl_rio_config_read: Passed IS_ALIGNED.
fsl_rio_config_read: Passed 'out_be32_1'
fsl_rio_config_read: Passed 'out_be32_2'
fsl_rio_config_read: len is 4
fsl_rio_config_read: triggering '__fsl_read_rio_config'
fsl_rio_config_read: going to request to read data at d108006

Regards,
Bastiaan

2010/10/4 Bounine, Alexandre <Alexandre.Bounine@idt.com<mailto:Alexandre.B=
ounine@idt.com>
<mailto:Alexandre.Bounine@idt.com<mailto:Alexandre.Bounine@idt.com>>>


   Hi Bastiaan,

   Are you trying board-to-board connection?
   I am not familiar with WRS SBC8548 board - which type of connector they=

   use for SRIO?

   Assuming that all configuration is correct,
   I would recommend first to try setting up x1 link mode at the lowest
   link speed.
   The x4 mode may present challenges in some cases.

   For quick test you may just add port width override into fsl_rio.c
   like shown below (ugly but sometimes it helps ;) ):

   @@ -1461,10 +1461,16 @@ int fsl_rio_setup(struct platform_device *dev)
           rio_register_mport(port);

           priv->regs_win =3D ioremap(regs.start, regs.end - regs.start + =
1);
           rio_regs_win =3D priv->regs_win;

   +dev_info(&dev->dev, "Overriding RIO_PORT setting to single lane 0\n");=

   +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
   0x800000);
   +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
   0x2000000);
   +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) &
   ~0x800000);
   +msleep(100);
   +
           /* Probe the master port phy type */
           ccsr =3D in_be32(priv->regs_win + RIO_CCSR);
           port->phy_type =3D (ccsr & 1) ? RIO_PHY_SERIAL : RIO_PHY_PARALL=
EL;
           dev_info(&dev->dev, "RapidIO PHY type: %s\n",
                           (port->phy_type =3D=3D RIO_PHY_PARALLEL) ?
   "parallel" :


   Let me know what happens.
   Please keep me in the CC: list next time when posting RapidIO questions=

   to the linuxppc-dev or kernel mailing lists.

   Regards,

   Alex.



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org<mailto:Linuxppc-dev@lists.ozlabs.org>
https://lists.ozlabs.org/listinfo/linuxppc-dev

--
John Traill
Systems Engineer
Network and Computing Systems Group

Freescale Semiconductor UK LTD
Colvilles Road
East Kilbride
Glasgow G75 0TG, Scotland

Tel: +44 (0) 1355 355494
Fax: +44 (0) 1355 261790

E-mail: john.traill@freescale.com<mailto:john.traill@freescale.com>

Registration Number: SC262720
VAT Number: GB831329053

[ ] General Business Use
[ ] Freescale Internal Use Only
[ ] Freescale Confidential Proprietary


_______________________________________________________________________
This e-mail and any files transmitted with it are proprietary and intended=
 solely for the use of the individual or entity to whom they are addressed=
. If you have reason to believe that you have received this e-mail in erro=
r, please notify the sender and destroy this email and any attached files.=
 Please note that any views or opinions presented in this e-mail are solel=
y those of the author and do not necessarily represent those of the Curtis=
s-Wright Corporation or any of its subsidiaries.  Documents attached heret=
o may contain technology subject to government export regulations. Recipie=
nt is solely responsible for ensuring that any re-export, transfer or disc=
losure of this information is in accordance with applicable government exp=
ort regulations.  The recipient should check this e-mail and any attachmen=
ts for the presence of viruses. Curtiss-Wright Corporation and its subsidi=
aries accept no liability for any damage caused by any virus transmitted b=
y this e-mail.
--_000_1682399277683944B902B3657D2FCE21654570E411CAREXCLUSTER0_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mic=
rosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word=
" xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schema=
s-microsoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:of=
fice:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:=
s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-mi=
crosoft-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-micro=
soft-com:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:sp=
readsheet" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadshe=
et" xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" xmlns:oa=3D"urn:sch=
emas-microsoft-com:office:activation" xmlns:html=3D"http://www.w3.org/TR/R=
EC-html40" xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:rtc=
=3D"http://microsoft.com/officenet/conferencing" xmlns:D=3D"DAV:" xmlns:Re=
pl=3D"http://schemas.microsoft.com/repl/" xmlns:mt=3D"http://schemas.micro=
soft.com/sharepoint/soap/meetings/" xmlns:x2=3D"http://schemas.microsoft.c=
om/office/excel/2003/xml" xmlns:ppda=3D"http://www.passport.com/NameSpace.=
xsd" xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" xmlns=
:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" xmlns:ds=3D=
"http://www.w3.org/2000/09/xmldsig#" xmlns:dsp=3D"http://schemas.microsoft=
.com/sharepoint/dsp" xmlns:udc=3D"http://schemas.microsoft.com/data/udc" x=
mlns:xsd=3D"http://www.w3.org/2001/XMLSchema" xmlns:sub=3D"http://schemas.=
microsoft.com/sharepoint/soap/2002/1/alerts/" xmlns:ec=3D"http://www.w3.or=
g/2001/04/xmlenc#" xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" x=
mlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" xmlns:xsi=3D"ht=
tp://www.w3.org/2001/XMLSchema-instance" xmlns:udcs=3D"http://schemas.micr=
osoft.com/data/udc/soap" xmlns:udcxf=3D"http://schemas.microsoft.com/data/=
udc/xmlfile" xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttop=
art" xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" x=
mlns:dsss=3D"http://schemas.microsoft.com/office/2006/digsig-setup" xmlns:=
dssi=3D"http://schemas.microsoft.com/office/2006/digsig" xmlns:mdssi=3D"ht=
tp://schemas.openxmlformats.org/package/2006/digital-signature" xmlns:mver=
=3D"http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:m=3D=
"http://schemas.microsoft.com/office/2004/12/omml" xmlns:mrels=3D"http://s=
chemas.openxmlformats.org/package/2006/relationships" xmlns:spwp=3D"http:/=
/microsoft.com/sharepoint/webpartpages" xmlns:ex12t=3D"http://schemas.micr=
osoft.com/exchange/services/2006/types" xmlns:ex12m=3D"http://schemas.micr=
osoft.com/exchange/services/2006/messages" xmlns:pptsl=3D"http://schemas.m=
icrosoft.com/sharepoint/soap/SlideLibrary/" xmlns:spsl=3D"http://microsoft=
.com/webservices/SharePointPortalServer/PublishedLinksService" xmlns:Z=3D"=
urn:schemas-microsoft-com:" xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/T=
R/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">=

<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Tahoma;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-reply;
=09font-family:"Calibri","sans-serif";
=09color:#1F497D;}
.MsoChpDefault
=09{mso-style-type:export-only;}
@page Section1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
=09{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'>I may have come across a similar problem, but I&#8217;ve ne=
ver
worked card-to-card without at least one switch in the way.<o:p></o:p></sp=
an></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'>The problems I have encountered have been hang-ups during m=
emory-mapped
maintenance reads to devices that the switch reports as &#8220;up&#8221;.<=
o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'>A workaround for the hang-up is to use a DMA transfer that
bypasses the ATMU to perform a maintenance read (not all, just the first, =
a
test read of a new discovery). If the DMA fails, as it does in those unusu=
al
circumstances, it will report a bus transfer error - but it will not hang =
up. You
can recover, and avoid or re-try the connection later.<o:p></o:p></span></=
p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'>A real &#8220;fix&#8221; for your problem may be to ensure =
that
both of your RapidIO interfaces are programmed to accept all incoming
transactions (see &#8220;Accept All Configuration Register (AACR)&#8221; i=
n
Freescale reference manual). But no guarantees with that - it just seemed =
to
clear up problems on my own rig.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri"=
,"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in=
 4.0pt'>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in=
 0in 0in'>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:"Tahom=
a","sans-serif"'>From:</span></b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> linuxppc-dev=
-bounces+tanderson=3Dcurtisswright.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tanderson=3Dcurtisswright.com@lists.ozlabs.or=
g] <b>On
Behalf Of </b>Bastiaan Nijkamp<br>
<b>Sent:</b> Tuesday, October 05, 2010 7:28 AM<br>
<b>To:</b> John Traill<br>
<b>Cc:</b> Bounine, Alexandre; linuxppc-dev@lists.ozlabs.org<br>
<b>Subject:</b> Re: Serial RapidIO Maintaintance read causes lock up<o:p><=
/o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<div>

<p class=3DMsoNormal>Hi John,<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>1. Yes, they are both running the exact same kernel a=
nd both
are configured in the same way. With the exception that one is set as host=
 and
the other as a agent.<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>2. Accept All is set for both boards. <o:p></o:p></p>=


</div>

<div>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>3. As i understand, the agent cannot send anything be=
fore it
is enumerated, so it would be safe to first reset the agent and
right&nbsp;after that the host. In either case, thats the way i am using. =
The
full kernel log until the discovery times out after 30 seconds is shown be=
low:<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>Using SBC8548 machine description<br>
Memory CAM mapping: 256 Mb, residual: 0Mb<br>
Linux version 2.6.35.6 (<a href=3D"mailto:dl704@lxws006">dl704@lxws006</a>=
) (gcc
version 4.4.1 (Wind River Linux Sour<br>
cery G++ 4.4-250) ) #3 Tue Oct 5 13:24:45 CEST 2010<br>
bootconsole [udbg0] enabled<br>
setup_arch: bootmem<br>
sbc8548_setup_arch()<br>
arch: exit<br>
Zone PFN ranges:<br>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000 -&gt; 0x00010000<br>
&nbsp; Normal&nbsp;&nbsp; empty<br>
Movable zone start PFN for each node<br>
early_node_map[1] active PFN ranges<br>
&nbsp;&nbsp;&nbsp; 0: 0x00000000 -&gt; 0x00010000<br>
MMU: Allocated 1088 bytes of context maps for 255 contexts<br>
Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages: =
65024<br>
Kernel command line: root=3D/dev/nfs rw
nfsroot=3D192.168.100.21:/thales/target/rfs/<br>
sbc8548_wrlinux4 ip=3D192.168.100.151:192.168.100.21:192.168.100.21:255.25=
5.255.0:<br>
sbc8548_1:eth0:off console=3DttyS0,115200<br>
PID hash table entries: 1024 (order: 0, 4096 bytes)<br>
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
Memory: 256996k/262144k available (2644k kernel code, 5148k reserved, 108k=

data,<br>
&nbsp;77k bss, 136k init)<br>
Kernel virtual memory layout:<br>
&nbsp; * 0xfffdf000..0xfffff000&nbsp; : fixmap<br>
&nbsp; * 0xfdffd000..0xfe000000&nbsp; : early ioremap<br>
&nbsp; * 0xd1000000..0xfdffd000&nbsp; : vmalloc &amp; ioremap<br>
Hierarchical RCU implementation.<br>
&nbsp;RCU-based detection of stalled CPUs is disabled.<br>
&nbsp;Verbose stalled-CPUs detection is disabled.<br>
NR_IRQS:512 nr_irqs:512<br>
mpic: Setting up MPIC &quot; OpenPIC&nbsp; &quot; version 1.2 at e0040000,=
 max
1 CPUs<br>
mpic: ISU size: 80, shift: 7, mask: 7f<br>
mpic: Initializing for 80 sources<br>
clocksource: timebase mult[50cede6] shift[22] registered<br>
pid_max: default: 32768 minimum: 301<br>
Mount-cache hash table entries: 512<br>
NET: Registered protocol family 16<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <=
br>
PCI: Probing PCI hardware<br>
bio: create slab &lt;bio-0&gt; at 0<br>
vgaarb: loaded<br>
Switching to clocksource timebase<br>
NET: Registered protocol family 2<br>
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>
TCP established hash table entries: 8192 (order: 4, 65536 bytes)<br>
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
TCP: Hash tables configured (established 8192 bind 8192)<br>
TCP reno registered<br>
UDP hash table entries: 256 (order: 0, 4096 bytes)<br>
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)<br>
NET: Registered protocol family 1<br>
RPC: Registered udp transport module.<br>
RPC: Registered tcp transport module.<br>
RPC: Registered tcp NFSv4.1 backchannel transport module.<br>
Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000<br=
>
fsl-of-rio e00c0000.rapidio: Of-device full name
/soc8548@e0000000/rapidio@c0000<br>
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]<br>
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
0x0000000020000000.<br>
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54<b=
r>
fsl-of-rio e00c0000.rapidio: DeviceID is 0xffffffff<br>
fsl-of-rio e00c0000.rapidio: Configured as AGENT<br>
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0<=
br>
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial<br>
fsl-of-rio e00c0000.rapidio: Hardware port width: 4<br>
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0<br>=

fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256<br>=

fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainanc=
e
Window Size 0x400000,New Main Start: 0xd1080000<br>
RIO: discover master port 0, RIO0 mport<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>A interesting thing that i found out is that when the=
 agent
is reset while the host is locked up (eg. it cannot be stopped nor can i r=
ead
the registers and memory trough a JTAG Interface), the host comes back onl=
ine
and just continues booting linux with a RapidIO error. See the log below.<=
o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>Setting up RapidIO peer-to-peer network
/soc8548@e0000000/rapidio@c0000<br>
fsl-of-rio e00c0000.rapidio: Of-device full name /soc8548@e0000000/rapidio=
@c0000<br>
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]<br>
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
0x0000000020000000.<br>
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54<b=
r>
fsl-of-rio e00c0000.rapidio: DeviceID is 0x0<br>
fsl-of-rio e00c0000.rapidio: Configured as HOST<br>
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0<=
br>
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial<br>
fsl-of-rio e00c0000.rapidio: Hardware port width: 4<br>
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0<br>=

fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256<br>=

fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainanc=
e
Window Size 0x400000,New Main Start: 0xd1080000<br>
RIO: enumerate master port 0, RIO0 mport<br>
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4<b=
r>
fsl_rio_config_read: Passed IS_ALIGNED.<br>
fsl_rio_config_read: Passed 'out_be32_1'<br>
fsl_rio_config_read: Passed 'out_be32_2'<br>
fsl_rio_config_read: len is 4<br>
fsl_rio_config_read: triggering '__fsl_read_rio_config'<br>
fsl_rio_config_read: going to request to read data at d1080068<br>
RIO: cfg_read error -14 for ff:0:68<br>
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4<b=
r>
fsl_rio_config_read: Passed IS_ALIGNED.<br>
fsl_rio_config_read: Passed 'out_be32_1'<br>
fsl_rio_config_read: Passed 'out_be32_2'<br>
fsl_rio_config_read: len is 4<br>
fsl_rio_config_read: triggering '__fsl_read_rio_config'<br>
fsl_rio_config_read: going to request to read data at d1080068<br>
RIO: cfg_read error -14 for ff:0:68<br>
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4<b=
r>
fsl_rio_config_read: Passed IS_ALIGNED.<br>
fsl_rio_config_read: Passed 'out_be32_1'<br>
fsl_rio_config_read: Passed 'out_be32_2'<br>
fsl_rio_config_read: len is 4<br>
fsl_rio_config_read: triggering '__fsl_read_rio_config'<br>
fsl_rio_config_read: going to request to read data at d1080068<br>
RIO: cfg_read error -14 for ff:0:68<br>
RIO: master port 0 device has lost enumeration to a remote host<o:p></o:p>=
</p>

</div>

<div>

<p class=3DMsoNormal><br>
Regards,<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>Bastiaan<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>2010/10/5 John Traill &lt;<a
href=3D"mailto:john.traill@freescale.com">john.traill@freescale.com</a>&gt=
;<o:p></o:p></p>

<p class=3DMsoNormal>Bastiaan,<br>
<br>
A few things to check.<br>
<br>
1. Is the target board also set up for small common transport system size =
ie
256.<br>
<br>
2. Make sure the target has &quot;Accept All&quot; set - in fsl_rio.c look=
 for<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; &nbsp; &nbsp; /* Set to receive any dist ID fo=
r
serial RapidIO controller. */<br>
&nbsp; &nbsp; &nbsp; &nbsp;if (port-&gt;phy_type =3D=3D RIO_PHY_SERIAL)<br=
>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;out_be32((priv-&gt;regs_win + RIO_ISR_AACR), RIO_ISR_AACR_AA);<o:p><=
/o:p></p>

<p class=3DMsoNormal><br>
3. How do you synchronise reset between both systems ? Both need to be res=
et to
insure the inbound/outbound ackid's remain in sync. If you only reset one =
then
you have the potential for the ackid's to get out of sync. Also what is th=
e
kernel log on the agent system ?<br>
<br>
Cheers. <o:p></o:p></p>

<div>

<div>

<p class=3DMsoNormal><br>
<br>
<br>
On 05/10/10 09:56, Bastiaan Nijkamp wrote:<o:p></o:p></p>

</div>

</div>

<blockquote style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0=
in 0in 0in 6.0pt;
margin-left:4.8pt;margin-right:0in'>

<div>

<div>

<p class=3DMsoNormal><br>
Hi Alex,<br>
<br>
Thanks for your advice. We are trying to make a board-to-board<br>
connection without any additional hardware (eg. a switch). The boards<br>
use a 50-pin, right-angle MEC8-125-02-L-D-RA1 connector from SAMTEC and<br=
>
are connected trough a EEDP-016-12.00-RA1-RA2-2 cross cable from SAMTEC.<b=
r>
I hope this information is sufficient since there is not much one can<br>
find about it on Google. In addition, you can see a picture of the board<b=
r>
including the connector in the datasheet located at<br>
<a
href=3D"http://www.windriver.com/products/product-notes/SBC8548E-product-n=
ote.pdf"
target=3D"_blank">http://www.windriver.com/products/product-notes/SBC8548E=
-product-note.pdf</a>.<br>
It is the connector on the left side of the PCI-EX slot.<br>
<br>
We have tried your suggestion but the situation does not change other<br>
than the lane-mode being set to single lane 0, it still locks up when<br>
trying to generate a maintenance transaction. I still think it is memory<b=
r>
related since the lock up occurs when accessing the maintenance window.<br=
>
Although all memory related settings seems to be alright.<br>
<br>
The kernel output is as follows:<br>
<br>
Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000<br=
>
fsl-of-rio e00c0000.rapidio: Of-device full name<br>
/soc8548@e0000000/rapidio@c0000<br>
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]<br>
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size<br>
0x0000000010000000.<br>
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54<b=
r>
fsl-of-rio e00c0000.rapidio: DeviceID is 0x0<br>
fsl-of-rio e00c0000.rapidio: Configured as HOST<br>
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0<=
br>
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial<br>
fsl-of-rio e00c0000.rapidio: Hardware port width: 4<br>
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0<br>=

fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256<br>=

fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO<br>
Maintainance Window Size 0x400000,New Main Start: 0xd1080000<br>
RIO: enumerate master port 0, RIO0 mport<br>
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4<b=
r>
fsl_rio_config_read: Passed IS_ALIGNED.<br>
fsl_rio_config_read: Passed 'out_be32_1'<br>
fsl_rio_config_read: Passed 'out_be32_2'<br>
fsl_rio_config_read: len is 4<br>
fsl_rio_config_read: triggering '__fsl_read_rio_config'<br>
fsl_rio_config_read: going to request to read data at d108006<br>
<br>
Regards,<br>
Bastiaan<br>
<br>
2010/10/4 Bounine, Alexandre &lt;<a href=3D"mailto:Alexandre.Bounine@idt.c=
om"
target=3D"_blank">Alexandre.Bounine@idt.com</a><o:p></o:p></p>

</div>

</div>

<p class=3DMsoNormal>&lt;mailto:<a href=3D"mailto:Alexandre.Bounine@idt.co=
m"
target=3D"_blank">Alexandre.Bounine@idt.com</a>&gt;&gt; <o:p></o:p></p>

<div>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><br>
<br>
&nbsp; &nbsp;Hi Bastiaan,<br>
<br>
&nbsp; &nbsp;Are you trying board-to-board connection?<br>
&nbsp; &nbsp;I am not familiar with WRS SBC8548 board - which type of conn=
ector
they<br>
&nbsp; &nbsp;use for SRIO?<br>
<br>
&nbsp; &nbsp;Assuming that all configuration is correct,<br>
&nbsp; &nbsp;I would recommend first to try setting up x1 link mode at the=

lowest<br>
&nbsp; &nbsp;link speed.<br>
&nbsp; &nbsp;The x4 mode may present challenges in some cases.<br>
<br>
&nbsp; &nbsp;For quick test you may just add port width override into fsl_=
rio.c<br>
&nbsp; &nbsp;like shown below (ugly but sometimes it helps ;) ):<br>
<br>
&nbsp; &nbsp;@@ -1461,10 +1461,16 @@ int fsl_rio_setup(struct platform_dev=
ice
*dev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rio_register_mport(port);<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;priv-&gt;regs_win =3D
ioremap(regs.start, regs.end - regs.start + 1);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rio_regs_win =3D priv-&gt;regs_wi=
n;<br>
<br>
&nbsp; &nbsp;+dev_info(&amp;dev-&gt;dev, &quot;Overriding RIO_PORT setting=
 to
single lane 0\n&quot;);<br>
&nbsp; &nbsp;+out_be32(priv-&gt;regs_win + 0x15C, in_be32(priv-&gt;regs_wi=
n +
0x15C) |<br>
&nbsp; &nbsp;0x800000);<br>
&nbsp; &nbsp;+out_be32(priv-&gt;regs_win + 0x15C, in_be32(priv-&gt;regs_wi=
n +
0x15C) |<br>
&nbsp; &nbsp;0x2000000);<br>
&nbsp; &nbsp;+out_be32(priv-&gt;regs_win + 0x15C, in_be32(priv-&gt;regs_wi=
n +
0x15C) &amp;<br>
&nbsp; &nbsp;~0x800000);<br>
&nbsp; &nbsp;+msleep(100);<br>
&nbsp; &nbsp;+<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Probe the master port phy type=
 */<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ccsr =3D in_be32(priv-&gt;regs_wi=
n +
RIO_CCSR);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;port-&gt;phy_type =3D (ccsr &amp;=
 1) ?
RIO_PHY_SERIAL : RIO_PHY_PARALLEL;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dev_info(&amp;dev-&gt;dev,
&quot;RapidIO PHY type: %s\n&quot;,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;
&nbsp; &nbsp; &nbsp;(port-&gt;phy_type =3D=3D RIO_PHY_PARALLEL) ?<br>
&nbsp; &nbsp;&quot;parallel&quot; :<br>
<br>
<br>
&nbsp; &nbsp;Let me know what happens.<br>
&nbsp; &nbsp;Please keep me in the CC: list next time when posting RapidIO=

questions<br>
&nbsp; &nbsp;to the linuxppc-dev or kernel mailing lists.<br>
<br>
&nbsp; &nbsp;Regards,<br>
<br>
&nbsp; &nbsp;Alex.<br>
<br>
<br>
<br>
<o:p></o:p></p>

</div>

</div>

<p class=3DMsoNormal>_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxpp=
c-dev@lists.ozlabs.org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blan=
k">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><o:p></o:p></p>

</blockquote>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><br>
-- <br>
John Traill<br>
Systems Engineer<br>
Network and Computing Systems Group<br>
<br>
Freescale Semiconductor UK LTD<br>
Colvilles Road<br>
East Kilbride<br>
Glasgow G75 0TG, Scotland<br>
<br>
Tel: +44 (0) 1355 355494<br>
Fax: +44 (0) 1355 261790<br>
<br>
E-mail: <a href=3D"mailto:john.traill@freescale.com" target=3D"_blank">joh=
n.traill@freescale.com</a><br>
<br>
Registration Number: SC262720<br>
VAT Number: GB831329053<br>
<br>
[ ] General Business Use<br>
[ ] Freescale Internal Use Only<br>
[ ] Freescale Confidential Proprietary<o:p></o:p></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</div>

<BR>
_______________________________________________________________________<BR=
>
This e-mail and any files transmitted with it are proprietary and intended=
 solely for the use of the individual or entity to whom they are addressed=
. If you have reason to believe that you have received this e-mail in erro=
r, please notify the sender and destroy this email and any attached files.=
 Please note that any views or opinions presented in this e-mail are solel=
y those of the author and do not necessarily represent those of the Curtis=
s-Wright Corporation or any of its subsidiaries.  Documents attached heret=
o may contain technology subject to government export regulations. Recipie=
nt is solely responsible for ensuring that any re-export, transfer or disc=
losure of this information is in accordance with applicable government exp=
ort regulations.  The recipient should check this e-mail and any attachmen=
ts for the presence of viruses. Curtiss-Wright Corporation and its subsidi=
aries accept no liability for any damage caused by any virus transmitted b=
y this e-mail.<BR>
</body>

</html>

--_000_1682399277683944B902B3657D2FCE21654570E411CAREXCLUSTER0_--
