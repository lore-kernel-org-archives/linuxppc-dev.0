Return-Path: <bastiaan.nijkamp@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) by ozlabs.org (Postfix) with ESMTP id D31A0B70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 01:28:51 +1100 (EST)
Received: by qyk7 with SMTP id 7so3308175qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Oct 2010 07:28:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CAB2729.6080402@freescale.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
From: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Date: Tue, 5 Oct 2010 16:28:28 +0200
Message-ID: <AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
To: John Traill <john.traill@freescale.com>
Content-Type: multipart/alternative; boundary=00151748dbc2b7fa010491df7a53
Cc: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00151748dbc2b7fa010491df7a53
Content-Type: text/plain; charset=ISO-8859-1

Hi John,

1. Yes, they are both running the exact same kernel and both are configured
in the same way. With the exception that one is set as host and the other as
a agent.

2. Accept All is set for both boards.

3. As i understand, the agent cannot send anything before it is enumerated,
so it would be safe to first reset the agent and right after that the host.
In either case, thats the way i am using. The full kernel log until the
discovery times out after 30 seconds is shown below:

Using SBC8548 machine description
Memory CAM mapping: 256 Mb, residual: 0Mb
Linux version 2.6.35.6 (dl704@lxws006) (gcc version 4.4.1 (Wind River Linux
Sour
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
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/nfs rw nfsroot=192.168.100.21:
/thales/target/rfs/
sbc8548_wrlinux4 ip=192.168.100.151:192.168.100.21:192.168.100.21:255
.255.255.0:
sbc8548_1:eth0:off console=ttyS0,115200
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256996k/262144k available (2644k kernel code, 5148k reserved, 108k
data,
 77k bss, 136k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfdffd000..0xfe000000  : early ioremap
  * 0xd1000000..0xfdffd000  : vmalloc & ioremap
Hierarchical RCU implementation.
 RCU-based detection of stalled CPUs is disabled.
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
fsl-of-rio e00c0000.rapidio: Of-device full name
/soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
0x0000000020000000.
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
fsl-of-rio e00c0000.rapidio: DeviceID is 0xffffffff
fsl-of-rio e00c0000.rapidio: Configured as AGENT
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
fsl-of-rio e00c0000.rapidio: Hardware port width: 4
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0
fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainance
Window Size 0x400000,New Main Start: 0xd1080000
RIO: discover master port 0, RIO0 mport

A interesting thing that i found out is that when the agent is reset while
the host is locked up (eg. it cannot be stopped nor can i read the registers
and memory trough a JTAG Interface), the host comes back online and just
continues booting linux with a RapidIO error. See the log below.

Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Of-device full name
/soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
0x0000000020000000.
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
fsl-of-rio e00c0000.rapidio: DeviceID is 0x0
fsl-of-rio e00c0000.rapidio: Configured as HOST
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
fsl-of-rio e00c0000.rapidio: Hardware port width: 4
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0
fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainance
Window Size 0x400000,New Main Start: 0xd1080000
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
2010/10/5 John Traill <john.traill@freescale.com>

> Bastiaan,
>
> A few things to check.
>
> 1. Is the target board also set up for small common transport system size
> ie 256.
>
> 2. Make sure the target has "Accept All" set - in fsl_rio.c look for
>
>>       /* Set to receive any dist ID for serial RapidIO controller. */
>>        if (port->phy_type == RIO_PHY_SERIAL)
>>                out_be32((priv->regs_win + RIO_ISR_AACR), RIO_ISR_AACR_AA);
>>
>
> 3. How do you synchronise reset between both systems ? Both need to be
> reset to insure the inbound/outbound ackid's remain in sync. If you only
> reset one then you have the potential for the ackid's to get out of sync.
> Also what is the kernel log on the agent system ?
>
> Cheers.
>
>
>
> On 05/10/10 09:56, Bastiaan Nijkamp wrote:
>
>>
>> Hi Alex,
>>
>> Thanks for your advice. We are trying to make a board-to-board
>> connection without any additional hardware (eg. a switch). The boards
>> use a 50-pin, right-angle MEC8-125-02-L-D-RA1 connector from SAMTEC and
>> are connected trough a EEDP-016-12.00-RA1-RA2-2 cross cable from SAMTEC.
>> I hope this information is sufficient since there is not much one can
>> find about it on Google. In addition, you can see a picture of the board
>> including the connector in the datasheet located at
>> http://www.windriver.com/products/product-notes/SBC8548E-product-note.pdf
>> .
>> It is the connector on the left side of the PCI-EX slot.
>>
>> We have tried your suggestion but the situation does not change other
>> than the lane-mode being set to single lane 0, it still locks up when
>> trying to generate a maintenance transaction. I still think it is memory
>> related since the lock up occurs when accessing the maintenance window.
>> Although all memory related settings seems to be alright.
>>
>> The kernel output is as follows:
>>
>> Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000
>> fsl-of-rio e00c0000.rapidio: Of-device full name
>> /soc8548@e0000000/rapidio@c0000
>> fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
>> fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
>> 0x0000000010000000.
>> fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
>> fsl-of-rio e00c0000.rapidio: DeviceID is 0x0
>> fsl-of-rio e00c0000.rapidio: Configured as HOST
>> fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0
>> fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
>> fsl-of-rio e00c0000.rapidio: Hardware port width: 4
>> fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0
>> fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
>> fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO
>> Maintainance Window Size 0x400000,New Main Start: 0xd1080000
>> RIO: enumerate master port 0, RIO0 mport
>> fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
>> fsl_rio_config_read: Passed IS_ALIGNED.
>> fsl_rio_config_read: Passed 'out_be32_1'
>> fsl_rio_config_read: Passed 'out_be32_2'
>> fsl_rio_config_read: len is 4
>> fsl_rio_config_read: triggering '__fsl_read_rio_config'
>> fsl_rio_config_read: going to request to read data at d108006
>>
>> Regards,
>> Bastiaan
>>
>> 2010/10/4 Bounine, Alexandre <Alexandre.Bounine@idt.com
>> <mailto:Alexandre.Bounine@idt.com>>
>>
>>
>>    Hi Bastiaan,
>>
>>    Are you trying board-to-board connection?
>>    I am not familiar with WRS SBC8548 board - which type of connector they
>>    use for SRIO?
>>
>>    Assuming that all configuration is correct,
>>    I would recommend first to try setting up x1 link mode at the lowest
>>    link speed.
>>    The x4 mode may present challenges in some cases.
>>
>>    For quick test you may just add port width override into fsl_rio.c
>>    like shown below (ugly but sometimes it helps ;) ):
>>
>>    @@ -1461,10 +1461,16 @@ int fsl_rio_setup(struct platform_device *dev)
>>            rio_register_mport(port);
>>
>>            priv->regs_win = ioremap(regs.start, regs.end - regs.start +
>> 1);
>>            rio_regs_win = priv->regs_win;
>>
>>    +dev_info(&dev->dev, "Overriding RIO_PORT setting to single lane 0\n");
>>    +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
>>    0x800000);
>>    +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
>>    0x2000000);
>>    +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) &
>>    ~0x800000);
>>    +msleep(100);
>>    +
>>            /* Probe the master port phy type */
>>            ccsr = in_be32(priv->regs_win + RIO_CCSR);
>>            port->phy_type = (ccsr & 1) ? RIO_PHY_SERIAL :
>> RIO_PHY_PARALLEL;
>>            dev_info(&dev->dev, "RapidIO PHY type: %s\n",
>>                            (port->phy_type == RIO_PHY_PARALLEL) ?
>>    "parallel" :
>>
>>
>>    Let me know what happens.
>>    Please keep me in the CC: list next time when posting RapidIO questions
>>    to the linuxppc-dev or kernel mailing lists.
>>
>>    Regards,
>>
>>    Alex.
>>
>>
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
> --
> John Traill
> Systems Engineer
> Network and Computing Systems Group
>
> Freescale Semiconductor UK LTD
> Colvilles Road
> East Kilbride
> Glasgow G75 0TG, Scotland
>
> Tel: +44 (0) 1355 355494
> Fax: +44 (0) 1355 261790
>
> E-mail: john.traill@freescale.com
>
> Registration Number: SC262720
> VAT Number: GB831329053
>
> [ ] General Business Use
> [ ] Freescale Internal Use Only
> [ ] Freescale Confidential Proprietary
>
>

--00151748dbc2b7fa010491df7a53
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi John,</div>
<div>=A0</div>
<div>1. Yes, they are both running the exact same kernel and both are confi=
gured in the same way. With the exception that one is set as host and the o=
ther as a agent.</div>
<div>=A0</div>
<div>2. Accept All is set for both boards. </div>
<div>=A0</div>
<div>3. As i understand, the agent cannot send anything before it is enumer=
ated, so it would be safe to first reset the agent and right=A0after that t=
he host. In either case, thats the way i am using. The full kernel log unti=
l the discovery times out after 30 seconds is shown below:</div>


<div>=A0</div>
<div>Using SBC8548 machine description<br>Memory CAM mapping: 256 Mb, resid=
ual: 0Mb<br>Linux version 2.6.35.6 (<a href=3D"mailto:dl704@lxws006">dl704@=
lxws006</a>) (gcc version 4.4.1 (Wind River Linux Sour<br>cery G++ 4.4-250)=
 ) #3 Tue Oct 5 13:24:45 CEST 2010<br>

bootconsole [udbg0] enabled<br>setup_arch: bootmem<br>sbc8548_setup_arch()<=
br>arch: exit<br>Zone PFN ranges:<br>=A0 DMA=A0=A0=A0=A0=A0 0x00000000 -&gt=
; 0x00010000<br>=A0 Normal=A0=A0 empty<br>Movable zone start PFN for each n=
ode<br>early_node_map[1] active PFN ranges<br>

=A0=A0=A0 0: 0x00000000 -&gt; 0x00010000<br>MMU: Allocated 1088 bytes of co=
ntext maps for 255 contexts<br>Built 1 zonelists in Zone order, mobility gr=
ouping on.=A0 Total pages: 65024<br>Kernel command line: root=3D/dev/nfs rw=
 nfsroot=3D192.168.100.21:/thales/target/rfs/<br>

sbc8548_wrlinux4 ip=3D192.168.100.151:192.168.100.21:192.168.100.21:255.255=
.255.0:<br>sbc8548_1:eth0:off console=3DttyS0,115200<br>PID hash table entr=
ies: 1024 (order: 0, 4096 bytes)<br>Dentry cache hash table entries: 32768 =
(order: 5, 131072 bytes)<br>

Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>Memory: 25=
6996k/262144k available (2644k kernel code, 5148k reserved, 108k data,<br>=
=A077k bss, 136k init)<br>Kernel virtual memory layout:<br>=A0 * 0xfffdf000=
..0xfffff000=A0 : fixmap<br>

=A0 * 0xfdffd000..0xfe000000=A0 : early ioremap<br>=A0 * 0xd1000000..0xfdff=
d000=A0 : vmalloc &amp; ioremap<br>Hierarchical RCU implementation.<br>=A0R=
CU-based detection of stalled CPUs is disabled.<br>=A0Verbose stalled-CPUs =
detection is disabled.<br>

NR_IRQS:512 nr_irqs:512<br>mpic: Setting up MPIC &quot; OpenPIC=A0 &quot; v=
ersion 1.2 at e0040000, max 1 CPUs<br>mpic: ISU size: 80, shift: 7, mask: 7=
f<br>mpic: Initializing for 80 sources<br>clocksource: timebase mult[50cede=
6] shift[22] registered<br>

pid_max: default: 32768 minimum: 301<br>Mount-cache hash table entries: 512=
<br>NET: Registered protocol family 16<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 <br>PCI: Probing PCI hardware<br>bio: create slab &lt;bio-0&gt; at 0<br=
>vgaarb: loaded<br>
Switching to clocksource timebase<br>
NET: Registered protocol family 2<br>IP route cache hash table entries: 204=
8 (order: 1, 8192 bytes)<br>TCP established hash table entries: 8192 (order=
: 4, 65536 bytes)<br>TCP bind hash table entries: 8192 (order: 3, 32768 byt=
es)<br>

TCP: Hash tables configured (established 8192 bind 8192)<br>TCP reno regist=
ered<br>UDP hash table entries: 256 (order: 0, 4096 bytes)<br>UDP-Lite hash=
 table entries: 256 (order: 0, 4096 bytes)<br>NET: Registered protocol fami=
ly 1<br>

RPC: Registered udp transport module.<br>RPC: Registered tcp transport modu=
le.<br>RPC: Registered tcp NFSv4.1 backchannel transport module.<br>Setting=
 up RapidIO peer-to-peer network <a>/soc8548@e0000000/rapidio@c0000</a><br>

fsl-of-rio e00c0000.rapidio: Of-device full name <a>/soc8548@e0000000/rapid=
io@c0000</a><br>fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dff=
ff]<br>fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size 0x00=
00000020000000.<br>

fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54<br=
>fsl-of-rio e00c0000.rapidio: DeviceID is 0xffffffff<br>fsl-of-rio e00c0000=
.rapidio: Configured as AGENT<br>fsl-of-rio e00c0000.rapidio: Overriding RI=
O_PORT setting to single lane 0<br>

fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial<br>fsl-of-rio e00c000=
0.rapidio: Hardware port width: 4<br>fsl-of-rio e00c0000.rapidio: Training =
connection status: Single-lane 0<br>fsl-of-rio e00c0000.rapidio: RapidIO Co=
mmon Transport System size: 256<br>

fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainance=
 Window Size 0x400000,New Main Start: 0xd1080000<br>RIO: discover master po=
rt 0, RIO0 mport</div>
<div>=A0</div>
<div>A interesting thing that i found out is that when the agent is reset w=
hile the host is locked up (eg. it cannot be stopped nor can i read the reg=
isters and memory trough a JTAG Interface), the host comes back online and =
just continues booting linux with a RapidIO error. See the log below.</div>


<div>=A0</div>
<div>Setting up RapidIO peer-to-peer network <a>/soc8548@e0000000/rapidio@c=
0000</a><br>fsl-of-rio e00c0000.rapidio: Of-device full name <a>/soc8548@e0=
000000/rapidio@c0000</a><br>fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0=
000-0xe00dffff]<br>

fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size 0x000000002=
0000000.<br>fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53,=
 rxirq 54<br>fsl-of-rio e00c0000.rapidio: DeviceID is 0x0<br>fsl-of-rio e00=
c0000.rapidio: Configured as HOST<br>

fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0<b=
r>fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial<br>fsl-of-rio e00c0=
000.rapidio: Hardware port width: 4<br>fsl-of-rio e00c0000.rapidio: Trainin=
g connection status: Single-lane 0<br>

fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256<br>f=
sl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainance =
Window Size 0x400000,New Main Start: 0xd1080000<br>RIO: enumerate master po=
rt 0, RIO0 mport<br>

fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4<br=
>fsl_rio_config_read: Passed IS_ALIGNED.<br>fsl_rio_config_read: Passed &#3=
9;out_be32_1&#39;<br>fsl_rio_config_read: Passed &#39;out_be32_2&#39;<br>

fsl_rio_config_read: len is 4<br>fsl_rio_config_read: triggering &#39;__fsl=
_read_rio_config&#39;<br>fsl_rio_config_read: going to request to read data=
 at d1080068<br>RIO: cfg_read error -14 for ff:0:68<br>fsl_rio_config_read:=
 index 0 destid 255 hopcount 0 offset 00000068 len 4<br>

fsl_rio_config_read: Passed IS_ALIGNED.<br>fsl_rio_config_read: Passed &#39=
;out_be32_1&#39;<br>fsl_rio_config_read: Passed &#39;out_be32_2&#39;<br>fsl=
_rio_config_read: len is 4<br>fsl_rio_config_read: triggering &#39;__fsl_re=
ad_rio_config&#39;<br>

fsl_rio_config_read: going to request to read data at d1080068<br>RIO: cfg_=
read error -14 for ff:0:68<br>fsl_rio_config_read: index 0 destid 255 hopco=
unt 0 offset 00000068 len 4<br>fsl_rio_config_read: Passed IS_ALIGNED.<br>

fsl_rio_config_read: Passed &#39;out_be32_1&#39;<br>fsl_rio_config_read: Pa=
ssed &#39;out_be32_2&#39;<br>fsl_rio_config_read: len is 4<br>fsl_rio_confi=
g_read: triggering &#39;__fsl_read_rio_config&#39;<br>fsl_rio_config_read: =
going to request to read data at d1080068<br>

RIO: cfg_read error -14 for ff:0:68<br>RIO: master port 0 device has lost e=
numeration to a remote host</div>
<div><br>Regards,</div>
<div>Bastiaan<br></div>
<div class=3D"gmail_quote">2010/10/5 John Traill <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:john.traill@freescale.com">john.traill@freescale.com</a>&gt;<=
/span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Bastiaan,<br><br>A few things to=
 check.<br><br>1. Is the target board also set up for small common transpor=
t system size ie 256.<br>

<br>2. Make sure the target has &quot;Accept All&quot; set - in fsl_rio.c l=
ook for<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">=A0 =A0 =A0 /* Set to receive an=
y dist ID for serial RapidIO controller. */<br>=A0 =A0 =A0 =A0if (port-&gt;=
phy_type =3D=3D RIO_PHY_SERIAL)<br>

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32((priv-&gt;regs_win + RIO_ISR_AACR),=
 RIO_ISR_AACR_AA);<br></blockquote><br>3. How do you synchronise reset betw=
een both systems ? Both need to be reset to insure the inbound/outbound ack=
id&#39;s remain in sync. If you only reset one then you have the potential =
for the ackid&#39;s to get out of sync. Also what is the kernel log on the =
agent system ?<br>

<br>Cheers.=20
<div>
<div></div>
<div class=3D"h5"><br><br><br>On 05/10/10 09:56, Bastiaan Nijkamp wrote:<br=
></div></div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5"><br>Hi Alex,<br><br>Thanks for your advice. We are trying=
 to make a board-to-board<br>connection without any additional hardware (eg=
. a switch). The boards<br>use a 50-pin, right-angle MEC8-125-02-L-D-RA1 co=
nnector from SAMTEC and<br>

are connected trough a EEDP-016-12.00-RA1-RA2-2 cross cable from SAMTEC.<br=
>I hope this information is sufficient since there is not much one can<br>f=
ind about it on Google. In addition, you can see a picture of the board<br>

including the connector in the datasheet located at<br><a href=3D"http://ww=
w.windriver.com/products/product-notes/SBC8548E-product-note.pdf" target=3D=
"_blank">http://www.windriver.com/products/product-notes/SBC8548E-product-n=
ote.pdf</a>.<br>

It is the connector on the left side of the PCI-EX slot.<br><br>We have tri=
ed your suggestion but the situation does not change other<br>than the lane=
-mode being set to single lane 0, it still locks up when<br>trying to gener=
ate a maintenance transaction. I still think it is memory<br>

related since the lock up occurs when accessing the maintenance window.<br>=
Although all memory related settings seems to be alright.<br><br>The kernel=
 output is as follows:<br><br>Setting up RapidIO peer-to-peer network /soc8=
548@e0000000/rapidio@c0000<br>

fsl-of-rio e00c0000.rapidio: Of-device full name<br>/soc8548@e0000000/rapid=
io@c0000<br>fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]<=
br>fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size<br>
0x0000000010000000.<br>
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54<br=
>fsl-of-rio e00c0000.rapidio: DeviceID is 0x0<br>fsl-of-rio e00c0000.rapidi=
o: Configured as HOST<br>fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT s=
etting to single lane 0<br>

fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial<br>fsl-of-rio e00c000=
0.rapidio: Hardware port width: 4<br>fsl-of-rio e00c0000.rapidio: Training =
connection status: Single-lane 0<br>fsl-of-rio e00c0000.rapidio: RapidIO Co=
mmon Transport System size: 256<br>

fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO<br>Maintaina=
nce Window Size 0x400000,New Main Start: 0xd1080000<br>RIO: enumerate maste=
r port 0, RIO0 mport<br>fsl_rio_config_read: index 0 destid 255 hopcount 0 =
offset 00000068 len 4<br>

fsl_rio_config_read: Passed IS_ALIGNED.<br>fsl_rio_config_read: Passed &#39=
;out_be32_1&#39;<br>fsl_rio_config_read: Passed &#39;out_be32_2&#39;<br>fsl=
_rio_config_read: len is 4<br>fsl_rio_config_read: triggering &#39;__fsl_re=
ad_rio_config&#39;<br>

fsl_rio_config_read: going to request to read data at d108006<br><br>Regard=
s,<br>Bastiaan<br><br>2010/10/4 Bounine, Alexandre &lt;<a href=3D"mailto:Al=
exandre.Bounine@idt.com" target=3D"_blank">Alexandre.Bounine@idt.com</a><br=
>

</div></div>&lt;mailto:<a href=3D"mailto:Alexandre.Bounine@idt.com" target=
=3D"_blank">Alexandre.Bounine@idt.com</a>&gt;&gt;=20
<div>
<div></div>
<div class=3D"h5"><br><br>=A0 =A0Hi Bastiaan,<br><br>=A0 =A0Are you trying =
board-to-board connection?<br>=A0 =A0I am not familiar with WRS SBC8548 boa=
rd - which type of connector they<br>=A0 =A0use for SRIO?<br><br>=A0 =A0Ass=
uming that all configuration is correct,<br>

=A0 =A0I would recommend first to try setting up x1 link mode at the lowest=
<br>=A0 =A0link speed.<br>=A0 =A0The x4 mode may present challenges in some=
 cases.<br><br>=A0 =A0For quick test you may just add port width override i=
nto fsl_rio.c<br>

=A0 =A0like shown below (ugly but sometimes it helps ;) ):<br><br>=A0 =A0@@=
 -1461,10 +1461,16 @@ int fsl_rio_setup(struct platform_device *dev)<br>=A0=
 =A0 =A0 =A0 =A0 =A0rio_register_mport(port);<br><br>=A0 =A0 =A0 =A0 =A0 =
=A0priv-&gt;regs_win =3D ioremap(regs.start, regs.end - regs.start + 1);<br=
>

=A0 =A0 =A0 =A0 =A0 =A0rio_regs_win =3D priv-&gt;regs_win;<br><br>=A0 =A0+d=
ev_info(&amp;dev-&gt;dev, &quot;Overriding RIO_PORT setting to single lane =
0\n&quot;);<br>=A0 =A0+out_be32(priv-&gt;regs_win + 0x15C, in_be32(priv-&gt=
;regs_win + 0x15C) |<br>

=A0 =A00x800000);<br>=A0 =A0+out_be32(priv-&gt;regs_win + 0x15C, in_be32(pr=
iv-&gt;regs_win + 0x15C) |<br>=A0 =A00x2000000);<br>=A0 =A0+out_be32(priv-&=
gt;regs_win + 0x15C, in_be32(priv-&gt;regs_win + 0x15C) &amp;<br>=A0 =A0~0x=
800000);<br>=A0 =A0+msleep(100);<br>

=A0 =A0+<br>=A0 =A0 =A0 =A0 =A0 =A0/* Probe the master port phy type */<br>=
=A0 =A0 =A0 =A0 =A0 =A0ccsr =3D in_be32(priv-&gt;regs_win + RIO_CCSR);<br>=
=A0 =A0 =A0 =A0 =A0 =A0port-&gt;phy_type =3D (ccsr &amp; 1) ? RIO_PHY_SERIA=
L : RIO_PHY_PARALLEL;<br>=A0 =A0 =A0 =A0 =A0 =A0dev_info(&amp;dev-&gt;dev, =
&quot;RapidIO PHY type: %s\n&quot;,<br>

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(port-&gt;phy_type =
=3D=3D RIO_PHY_PARALLEL) ?<br>=A0 =A0&quot;parallel&quot; :<br><br><br>=A0 =
=A0Let me know what happens.<br>=A0 =A0Please keep me in the CC: list next =
time when posting RapidIO questions<br>=A0 =A0to the linuxppc-dev or kernel=
 mailing lists.<br>

<br>=A0 =A0Regards,<br><br>=A0 =A0Alex.<br><br><br><br><br></div></div>____=
___________________________________________<br>Linuxppc-dev mailing list<br=
><a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxpp=
c-dev@lists.ozlabs.org</a><br>

<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br></blockquote><br>--=
 <br>John Traill<br>Systems Engineer<br>Network and Computing Systems Group=
<br>

<br>Freescale Semiconductor UK LTD<br>Colvilles Road<br>East Kilbride<br>Gl=
asgow G75 0TG, Scotland<br><br>Tel: +44 (0) 1355 355494<br>Fax: +44 (0) 135=
5 261790<br><br>E-mail: <a href=3D"mailto:john.traill@freescale.com" target=
=3D"_blank">john.traill@freescale.com</a><br>

<br>Registration Number: SC262720<br>VAT Number: GB831329053<br><br>[ ] Gen=
eral Business Use<br>[ ] Freescale Internal Use Only<br>[ ] Freescale Confi=
dential Proprietary<br><br></blockquote></div><br>

--00151748dbc2b7fa010491df7a53--
