Return-Path: <vows_siu@yahoo.com.hk>
Received: from imsm057dat.netvigator.com (imsm057.netvigator.com
	[218.102.48.210]) by ozlabs.org (Postfix) with ESMTP id F420A67BED
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 20:49:45 +1000 (EST)
From: "alva" <vows_siu@yahoo.com.hk>
To: "'Wade Maxfield'" <wmaxfield@gmail.com>,
	"'ppc'" <linuxppc-embedded@ozlabs.org>
Subject: RE: ML40X, ppc 405 crash
Date: Tue, 22 Aug 2006 18:52:40 +0800
Message-ID: <000001c6c5d9$184dba00$8500a8c0@dc.roysiu.servebbs.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C6C61C.2670FA00"
In-Reply-To: <45a1b53e0608211434n2c61167i8952ab8737f102cc@mail.gmail.com>
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

------=_NextPart_000_0001_01C6C61C.2670FA00
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: quoted-printable

So can u access your NFS mapped partition? If you can access every FILEs
on the partition, running updatedb  ought to index the NFS partition
also. Then =93locate fixdep=94 is just to find the local indexed =
database
and display the matched result --- I just don=92t understand the =
problem.
Please state more what have you done in order to let us help you.

=20

=20

-----Original Message-----
From: linuxppc-embedded-bounces+vows_siu=3Dyahoo.com.hk@ozlabs.org
[mailto:linuxppc-embedded-bounces+vows_siu=3Dyahoo.com.hk@ozlabs.org] On
Behalf Of Wade Maxfield
Sent: Tuesday, August 22, 2006 5:34 AM
To: ppc
Subject: ML40X, ppc 405 crash

=20


  I was running NFS on ML40X.  I did a "updatedb" and then immediately,
"locate fixdep"

  I got the following crash

root@ml403:/home/moduletest# updatedb
locate fixdep
eth0: Could not transmit buffer.=20
eth0: Could not transmit buffer.
eth0: Could not transmit buffer.
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C01D0F74 LR: C01D0910 SP: C28B1930 REGS: c28b1880 TRAP: 0300    Not
tainted
MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=20
DAR: 00000004, DSISR: 00800000
TASK =3D c0b034c0[5097] 'frcode' THREAD: c28b0000
Last syscall: 234
GPR00: 00000000 C28B1930 C0B034C0 C35E3200 C03CC380 C276E810 000005E8
C3CE8880
GPR08: 00000002 00000000 C3CE890C 00000000 33003599 10018E04 100C3208
C02DCE08=20
GPR16: C00DB1CC C02DCE08 00000002 0000000A C28B1DF8 C02E0000 C02A0000
C3A30940
GPR24: 00000000 00000000 00000000 C3A30940 00000000 C35E3200 C3CE8880
C03A8800
NIP [c01d0f74] pfifo_fast_dequeue+0x40/0x74
LR [c01d0910] qdisc_restart+0x30/0x2b4=20
Call trace:
 [c01c1e94] dev_queue_xmit+0x264/0x318
 [c01dd8dc] ip_finish_output+0x140/0x2cc
 [c01dddb0] ip_queue_xmit+0x348/0x53c
 [c01ef628] tcp_transmit_skb+0x324/0x7f8
 [c01f05fc] tcp_write_xmit+0x14c/0x31c=20
 [c01ed360] __tcp_data_snd_check+0xc8/0xfc
 [c01ed9a4] tcp_rcv_established+0x2c0/0x8ac
 [c01f7250] tcp_v4_do_rcv+0x184/0x374
 [c01f7d9c] tcp_v4_rcv+0x95c/0xa4c
 [c01da000] ip_local_deliver+0x120/0x298
 [c01da86c] ip_rcv+0x400/0x508=20
 [c01c2614] netif_receive_skb+0x24c/0x2fc
 [c01c276c] process_backlog+0xa8/0x1a0
 [c01c2908] net_rx_action+0xa4/0x1cc
 [c001bef4] ___do_softirq+0x7c/0x114
Kernel panic - not syncing: Aiee, killing interrupt handler!=20
 <0>Rebooting in 180 seconds..
------------------------------------------------------------------------
------------------------------------------------------------------------
-----

Here is the kernel build and boot information.  (I use the demo compact
flash disk image shipped with the ml403 as an intermediate. I've not yet
been able to get a small enough build to fit on 412 meg using your
tools.)=20

Linux version 2.6.10_mvl401-ml40x (HYPERLINK
"mailto:root@localhost.localdomain"root@localhost.localdomain) (gcc
version 3.4.3 (MontaV
ista 3.4.3-25.0.107.0601076 2006-07-21)) #1 Fri Aug 18 14:43:45 CDT 2006

Xilinx ML40x Reference System (Virtex-4 FX)
Port by MontaVista Software, Inc. (HYPERLINK
"mailto:source@mvista.com"source@mvista.com)
Built 1 zonelists
Kernel command line: console=3DttyS0,115200 ip=3Don root=3D/dev/xsysace2 =
rw=20
Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
PID hash table entries: 512 (order: 9, 8192 bytes)
hr_time_init: arch_to_nsec =3D 6990506, nsec_to_arch =3D 1288490158
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)=20
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 61824k available (2244k kernel code, 640k data, 140k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)=20
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
Registering platform device 'xilinx_emac.0'. Parent at platform=20
Registering platform device 'xilinx_fb.0'. Parent at platform
Registering platform device 'xilinx_sysace.0'. Parent at platform
Registering platform device 'xilinx_iic.0'. Parent at platform
Registering platform device 'xilinx_gpio.0'. Parent at platform=20
Registering platform device 'xilinx_gpio.1'. Parent at platform
Registering platform device 'xilinx_gpio.2'. Parent at platform
Registering platform device 'xilinx_ps2.0'. Parent at platform
Registering platform device 'xilinx_ps2.1'. Parent at platform=20
Installing knfsd (copyright (C) 1996 HYPERLINK
"mailto:okir@monad.swb.de"okir@monad.swb.de).
Console: switching to colour frame buffer device 80x30
xgpio #0 at 0x90000000 mapped to 0xC505C000
xgpio #1 at 0x90001000 mapped to 0xC505E000=20
xgpio #2 at 0x90002000 mapped to 0xC5060000
xilinx_ps2 #0 at 0xA9000000 mapped to 0xC5062000
xilinx_ps2 #1 at 0xA9001000 mapped to 0xC5064000
Serial: 8250/16550 driver $Revision: 1.90 $ 5 ports, IRQ sharing
disabled=20
Registering platform device 'serial8250'. Parent at platform
ttyS0 at MMIO 0x0 (irq =3D 9) is a 16450
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered=20
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
elevator: using anticipatory as default io scheduler
System ACE at 0xCF000000 mapped to 0xC5066000, irq=3D3, 500472KB=20
 xsysace: xsysace1 xsysace2
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
NET: Registered protocol family 24
xemac 0: using fifo mode.
eth0: Xilinx EMAC #0 at 0x60000000 mapped to 0xC5068000, irq=3D0=20
i2c /dev entries driver
xilinx_iic.0 #0 at 0xA8000000 mapped to 0xC506E000, irq=3D6
mice: PS/2 mouse device common for all mice
atkbd.c: keyboard reset failed on xilinxps2/serio0
atkbd.c: keyboard reset failed on xilinxps2/serio1=20
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17=20
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from HYPERLINK "http://0.0.0.0"0.0.0.0, my
address is HYPERLINK "http://172.17.6.49"172.17.6.49
IP-Config: Complete:
      device=3Deth0, addr=3DHYPERLINK "http://172.17.6.49" 172.17.6.49,
mask=3DHYPERLINK "http://255.255.254.0"255.255.254.0, gw=3DHYPERLINK
"http://172.17.7.254"172.17.7.254,
     host=3DHYPERLINK "http://172.17.6.49"172.17.6.49, =
domain=3DHYPERLINK
"http://precisiondrilling.com" precisiondrilling.com, =
nis-domain=3D(none),
     bootserver=3DHYPERLINK "http://0.0.0.0"0.0.0.0, =
rootserver=3DHYPERLINK
"http://0.0.0.0"0.0.0.0, rootpath=3D
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended=20
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 140k init
INIT: version 2.78 booting
Activating swap...
Checking all file systems...
fsck 1.27 (8-Mar-2002)
Calculating module dependencies... depmod: QM_MODULES: Function not
implemented=20

done.
Loading modules:
modprobe: QM_MODULES: Function not implemented

Mounting local filesystems...
nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.=20
Disable TCP/IP Explicit Congestion Notification: done.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Starting dhcpcd on eth0
Running ntpdate to synchronize clock.
Cleaning: /tmp /var/lock /var/rundhcpcd[775]: dhcpConfig: ioctl
SIOCADDRT: File exists=20

.
INIT: Entering runlevel: 3
Starting kernel log daemon: klogd.
Starting system log daemon: syslogd.
Hostname: ml403.
Creating barrier for shutdown
Starting X11 session for user 'linux'
Welcome to the ML403 Evaluation Board=20
(C) 2004 Xilinx, Inc - Systems Engineering Group







--
No virus found in this incoming message.
Checked by AVG Free Edition.
Version: 7.1.405 / Virus Database: 268.11.4/424 - Release Date:
2006/8/21


--=20
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.405 / Virus Database: 268.11.4/424 - Release Date:
2006/8/21
=20

------=_NextPart_000_0001_01C6C61C.2670FA00
Content-Type: text/html;
	charset="windows-1250"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dwindows-1250">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
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
	{color:blue;
	text-decoration:underline;}
p
	{margin-right:0cm;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-TW link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>So can u access =
your NFS
mapped partition? If you can access every FILEs on the partition, =
running updatedb
=A0ought to index the NFS partition also. Then =93locate fixdep=94 is
just to find the local indexed database and display the matched result =
--- I
just don=92t understand the problem. Please state more what have you =
done
in order to let us help you.</span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>&nbsp;</span></fon=
t></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>&nbsp;</span></fon=
t></p>

<p class=3DMsoNormal style=3D'margin-left:24.0pt'><font size=3D2 =
face=3DTahoma><span
lang=3DEN-US style=3D'font-size:10.0pt;font-family:Tahoma'>-----Original
Message-----<br>
<b><span style=3D'font-weight:bold'>From:</span></b> =
linuxppc-embedded-bounces+vows_siu=3Dyahoo.com.hk@ozlabs.org
[mailto:linuxppc-embedded-bounces+vows_siu=3Dyahoo.com.hk@ozlabs.org] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Wade Maxfield<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> </span></font><font =
size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Tahoma'>Tuesday,
 August 22, 2006</span></font><font size=3D2 face=3DTahoma><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Tahoma'> </span></font><font
 size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Tahoma'>5:34
 AM</span></font><font size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Tahoma'><br>
<b><span style=3D'font-weight:bold'>To:</span></b> ppc<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> ML40X, ppc 405 =
crash</span></font></p>

<p class=3DMsoNormal style=3D'margin-left:24.0pt'><font size=3D3
face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:12.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal =
style=3D'margin-right:0cm;margin-bottom:12.0pt;margin-left:
24.0pt'><font size=3D3 face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:
12.0pt'><br>
&nbsp; I was running NFS on ML40X.&nbsp; I did a &quot;updatedb&quot; =
and then
immediately, &quot;locate fixdep&quot;<br>
<br>
&nbsp; I got the following crash<br>
<br>
root@ml403:/home/moduletest# updatedb<br>
locate fixdep<br>
eth0: Could not transmit buffer. <br>
eth0: Could not transmit buffer.<br>
eth0: Could not transmit buffer.<br>
Oops: kernel access of bad area, sig: 11 [#1]<br>
PREEMPT<br>
NIP: C01D0F74 LR: C01D0910 SP: C28B1930 REGS: c28b1880 TRAP:
0300&nbsp;&nbsp;&nbsp; Not tainted<br>
MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 <br>
DAR: 00000004, DSISR: 00800000<br>
TASK =3D c0b034c0[5097] 'frcode' THREAD: c28b0000<br>
Last syscall: 234<br>
GPR00: 00000000 C28B1930 C0B034C0 C35E3200 C03CC380 C276E810 000005E8 =
C3CE8880<br>
GPR08: 00000002 00000000 C3CE890C 00000000 33003599 10018E04 100C3208 =
C02DCE08 <br>
GPR16: C00DB1CC C02DCE08 00000002 0000000A C28B1DF8 C02E0000 C02A0000 =
C3A30940<br>
GPR24: 00000000 00000000 00000000 C3A30940 00000000 C35E3200 C3CE8880 =
C03A8800<br>
NIP [c01d0f74] pfifo_fast_dequeue+0x40/0x74<br>
LR [c01d0910] qdisc_restart+0x30/0x2b4 <br>
Call trace:<br>
&nbsp;[c01c1e94] dev_queue_xmit+0x264/0x318<br>
&nbsp;[c01dd8dc] ip_finish_output+0x140/0x2cc<br>
&nbsp;[c01dddb0] ip_queue_xmit+0x348/0x53c<br>
&nbsp;[c01ef628] tcp_transmit_skb+0x324/0x7f8<br>
&nbsp;[c01f05fc] tcp_write_xmit+0x14c/0x31c <br>
&nbsp;[c01ed360] __tcp_data_snd_check+0xc8/0xfc<br>
&nbsp;[c01ed9a4] tcp_rcv_established+0x2c0/0x8ac<br>
&nbsp;[c01f7250] tcp_v4_do_rcv+0x184/0x374<br>
&nbsp;[c01f7d9c] tcp_v4_rcv+0x95c/0xa4c<br>
&nbsp;[c01da000] ip_local_deliver+0x120/0x298<br>
&nbsp;[c01da86c] ip_rcv+0x400/0x508 <br>
&nbsp;[c01c2614] netif_receive_skb+0x24c/0x2fc<br>
&nbsp;[c01c276c] process_backlog+0xa8/0x1a0<br>
&nbsp;[c01c2908] net_rx_action+0xa4/0x1cc<br>
&nbsp;[c001bef4] ___do_softirq+0x7c/0x114<br>
Kernel panic - not syncing: Aiee, killing interrupt handler! <br>
&nbsp;&lt;0&gt;Rebooting in 180 seconds..<br>
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
---<br>
<br>
Here is the kernel build and boot information.&nbsp; (I use the demo =
compact
flash disk image shipped with the ml403 as an intermediate. I've not yet =
been
able to get a small enough build to fit on 412 meg using your tools.) =
<br>
<br>
Linux version 2.6.10_mvl401-ml40x (<a =
href=3D"mailto:root@localhost.localdomain">root@localhost.localdomain</a>=
)
(gcc version 3.4.3 (MontaV<br>
ista 3.4.3-25.0.107.0601076 2006-07-21)) #1 Fri Aug 18 =
</span></font><span lang=3DEN-US>14:43:45 CDT</span><span lang=3DEN-US> =
2006 <br>
Xilinx ML40x Reference System (Virtex-4 FX)<br>
Port by MontaVista Software, Inc. (<a =
href=3D"mailto:source@mvista.com">source@mvista.com</a>)<br>
Built 1 zonelists<br>
Kernel command line: console=3DttyS0,115200 ip=3Don root=3D/dev/xsysace2 =
rw <br>
Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0<br>
PID hash table entries: 512 (order: 9, 8192 bytes)<br>
hr_time_init: arch_to_nsec =3D 6990506, nsec_to_arch =3D 1288490158<br>
Console: colour dummy device 80x25<br>
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes) <br>
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
Memory: 61824k available (2244k kernel code, 640k data, 140k init, 0k =
highmem)<br>
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<br>
spawn_desched_task(00000000) <br>
desched cpu_callback 3/00000000<br>
ksoftirqd started up.<br>
desched cpu_callback 2/00000000<br>
desched thread 0 started up.<br>
NET: Registered protocol family 16<br>
Registering platform device 'xilinx_emac.0'. Parent at platform <br>
Registering platform device 'xilinx_fb.0'. Parent at platform<br>
Registering platform device 'xilinx_sysace.0'. Parent at platform<br>
Registering platform device 'xilinx_iic.0'. Parent at platform<br>
Registering platform device 'xilinx_gpio.0'. Parent at platform <br>
Registering platform device 'xilinx_gpio.1'. Parent at platform<br>
Registering platform device 'xilinx_gpio.2'. Parent at platform<br>
Registering platform device 'xilinx_ps2.0'. Parent at platform<br>
Registering platform device 'xilinx_ps2.1'. Parent at platform <br>
Installing knfsd (copyright (C) 1996 <a =
href=3D"mailto:okir@monad.swb.de">okir@monad.swb.de</a>).<br>
Console: switching to colour frame buffer device 80x30<br>
xgpio #0 at 0x90000000 mapped to 0xC505C000<br>
xgpio #1 at 0x90001000 mapped to 0xC505E000 <br>
xgpio #2 at 0x90002000 mapped to 0xC5060000<br>
xilinx_ps2 #0 at 0xA9000000 mapped to 0xC5062000<br>
xilinx_ps2 #1 at 0xA9001000 mapped to 0xC5064000<br>
Serial: 8250/16550 driver $Revision: 1.90 $ 5 ports, IRQ sharing =
disabled <br>
Registering platform device 'serial8250'. Parent at platform<br>
ttyS0 at MMIO 0x0 (irq =3D 9) is a 16450<br>
io scheduler noop registered<br>
io scheduler anticipatory registered<br>
io scheduler deadline registered<br>
io scheduler cfq registered <br>
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 =
blocksize<br>
loop: loaded (max 8 devices)<br>
elevator: using anticipatory as default io scheduler<br>
System ACE at 0xCF000000 mapped to 0xC5066000, irq=3D3, 500472KB <br>
&nbsp;xsysace: xsysace1 xsysace2<br>
PPP generic driver version 2.4.2<br>
PPP Deflate Compression module registered<br>
NET: Registered protocol family 24<br>
xemac 0: using fifo mode.<br>
eth0: Xilinx EMAC #0 at 0x60000000 mapped to 0xC5068000, irq=3D0 <br>
i2c /dev entries driver<br>
xilinx_iic.0 #0 at 0xA8000000 mapped to 0xC506E000, irq=3D6<br>
mice: PS/2 mouse device common for all mice<br>
atkbd.c: keyboard reset failed on xilinxps2/serio0<br>
atkbd.c: keyboard reset failed on xilinxps2/serio1 <br>
NET: Registered protocol family 2<br>
IP: routing cache hash table of 512 buckets, 4Kbytes<br>
TCP: Hash tables configured (established 4096 bind 8192)<br>
NET: Registered protocol family 1<br>
NET: Registered protocol family 17 <br>
Sending DHCP requests ., OK<br>
IP-Config: Got DHCP answer from <a href=3D"http://0.0.0.0">0.0.0.0</a>, =
my
address is <a href=3D"http://172.17.6.49">172.17.6.49</a><br>
IP-Config: Complete:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, addr=3D<a =
href=3D"http://172.17.6.49">
172.17.6.49</a>, mask=3D<a =
href=3D"http://255.255.254.0">255.255.254.0</a>, gw=3D<a
href=3D"http://172.17.7.254">172.17.7.254</a>,<br>
&nbsp;&nbsp;&nbsp;&nbsp; host=3D<a =
href=3D"http://172.17.6.49">172.17.6.49</a>,
domain=3D<a href=3D"http://precisiondrilling.com"> =
precisiondrilling.com</a>,
nis-domain=3D(none),<br>
&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D<a =
href=3D"http://0.0.0.0">0.0.0.0</a>,
rootserver=3D<a href=3D"http://0.0.0.0">0.0.0.0</a>, rootpath=3D<br>
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended =
<br>
VFS: Mounted root (ext2 filesystem).<br>
Freeing unused kernel memory: 140k init<br>
INIT: version 2.78 booting<br>
Activating swap...<br>
Checking all file systems...<br>
fsck 1.27 (8-Mar-2002)<br>
Calculating module dependencies... depmod: QM_MODULES: Function not =
implemented
<br>
<br>
done.<br>
Loading modules:<br>
modprobe: QM_MODULES: Function not implemented<br>
<br>
Mounting local filesystems...<br>
nothing was mounted<br>
Cleaning: /etc/network/ifstate.<br>
Setting up IP spoofing protection: rp_filter. <br>
Disable TCP/IP Explicit Congestion Notification: done.<br>
Configuring network interfaces: done.<br>
Starting portmap daemon: portmap.<br>
Starting dhcpcd on eth0<br>
Running ntpdate to synchronize clock.<br>
Cleaning: /tmp /var/lock /var/rundhcpcd[775]: dhcpConfig: ioctl =
SIOCADDRT: File
exists <br>
<br>
.<br>
INIT: Entering runlevel: 3<br>
Starting kernel log daemon: klogd.<br>
Starting system log daemon: syslogd.<br>
Hostname: ml403.<br>
Creating barrier for shutdown<br>
Starting X11 session for user 'linux'<br>
Welcome to the ML403 Evaluation Board <br>
(C) 2004 Xilinx, Inc - Systems Engineering Group<br>
<br>
<br>
<br>
<br>
<br>
</span></p>

<p style=3D'margin-left:24.0pt'><font size=3D2 face=3D"Times New =
Roman"><span
lang=3DEN-US style=3D'font-size:10.0pt'>--<br>
No virus found in this incoming message.<br>
Checked by AVG Free Edition.<br>
Version: 7.1.405 / Virus Database: 268.11.4/424 - Release Date: =
2006/8/21</span></font></p>

</div>

</body>

</html>
<BR>

<P><FONT SIZE=3D2>--<BR>
No virus found in this outgoing message.<BR>
Checked by AVG Free Edition.<BR>
Version: 7.1.405 / Virus Database: 268.11.4/424 - Release Date: =
2006/8/21<BR>
</FONT> </P>

------=_NextPart_000_0001_01C6C61C.2670FA00--
