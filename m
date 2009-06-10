Return-Path: <Lixin.Yao@HSTX.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2125CB719F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 08:32:06 +1000 (EST)
Received: from mail.hstx.com (mail.hstx.com [64.95.133.106])
	by ozlabs.org (Postfix) with ESMTP id 52BBFDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 08:32:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9EA19.4E5DE142"
Subject: Kernel Crash Around Device Tree Access
Date: Wed, 10 Jun 2009 15:17:56 -0700
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB0C@exchtxus2.HSTX.global.vpn>
From: "Lixin Yao" <Lixin.Yao@HSTX.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9EA19.4E5DE142
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I use 2.6.28 kernel for a board using processor MPC866T. The kernel
startup occationally (1 out of 5 times) crashes at various init of
device drivers. Sometimes, it happens on the init of cpm_uart driver,
sometimes on other drivers. It always happens at of access of device
tree like "of_find_node_by_name", "of_get_property", etc. A bad pointer
to property name crashes the kernel. It appears the device tree got
corrupted when it happens. I am having difficulty identifying the
problem. Any insight will be helpful.

Note, once the kernel starts, it works fine. I tried to pull in fixes
from 2.6.30 around prom and of area, and they don't help.

Following is a dump showing the problem:

Filename 'eclipse/cuImage.eclipse_idu_8xx'.
Load address: 0x200000
Loading:
#################################################################
=20
#################################################################
=20
#################################################################
=20
#################################################################
         ############
done
Bytes transferred =3D 1389443 (153383 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.28-00015-g324a40e-dirt
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1389379 Bytes =3D  1.3 MB
   Load Address: 00400000
   Entry Point:  00400598
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Using Eclipse IDU 8xx machine description
Linux version 2.6.28-00015-g324a40e-dirty (lyao01@lyao01-desktop) (gcc
version 4
.2.2) #12 Wed Jun 10 17:59:17 EDT 2009
Zone PFN ranges:
  DMA      0x00000000 -> 0x00004000
  Normal   0x00004000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
16256
Kernel command line: console=3DttyCPM0,38400 root=3D/dev/nfs rw
nfsroot=3D10.15.34.196
:/home/lyao01/work/target_idu_xxx_2.6
ip=3D172.20.16.151:10.15.34.196:172.20.16.1:
255.255.255.0:nccv2:eth0:off eclipse=3Dnccv2 RSR=3D0xc0
PID hash table entries: 256 (order: 8, 1024 bytes)
Decrementer Frequency =3D 0x5f5e10
clocksource: timebase mult[28000000] shift[22] registered
STXN: drivers/serial/cpm_uart/cpm_uart_core.c, cpm_uart_console_init
START
console [ttyCPM0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61892k/65536k available (2688k kernel code, 3576k reserved, 96k
data, 11
2k bss, 116k init)
SLUB: Genslabs=3D11, HWalign=3D16, Order=3D0-3, MinObjects=3D0, =
CPUs=3D1, Nodes=3D1
Calibrating delay loop... 11.93 BogoMIPS (lpj=3D5968)
Mount-cache hash table entries: 512
net_namespace: 288 bytes
NET: Registered protocol family 16
Unable to handle kernel paging request for data at address 0x08000604
Faulting instruction address: 0xc0129ab0
Oops: Kernel access of bad area, sig: 11 [#1]
Eclipse IDU 8xx
Modules linked in:
NIP: c0129ab0 LR: c018c6b4 CTR: c0287648
REGS: c3817d50 TRAP: 0300   Not tainted  (2.6.28-00015-g324a40e-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22004044  XER: 0000005f
DAR: 08000604, DSISR: c0000000
TASK =3D c3818000[1] 'swapper' THREAD: c3816000
GPR00: 08000604 c3817e00 c3818000 08000604 c024cfbc c3800648 00000002
c02e2780
GPR08: 00000000 c02b0000 c02b003c 08000604 84004048 02000000 03ffb200
03ffaf20
GPR16: 00000000 ffffffff 03fb2b80 00000001 03fff814 007ffeb0 007fff00
00800000
GPR24: 00000ef9 00000000 00000000 c024cfbc c02bf324 00000000 c024cfbc
c3ffeb10
NIP [c0129ab0] strcasecmp+0xc/0x64
LR [c018c6b4] of_find_node_by_name+0x40/0x98
Call Trace:
[c3817e00] [0000005f] 0x5f (unreliable)
[c3817e20] [c02876a4] of_add_fixed_phys+0x5c/0x118
[c3817e60] [c00021ec] do_one_initcall+0x38/0x1a4
[c3817fd0] [c0283168] kernel_init+0x88/0xf4
[c3817ff0] [c000da9c] kernel_thread+0x4c/0x68
Instruction dump:
4200ffa8 7c635850 4e800020 7c635850 4e800020 7c6300d0 4e800020 7d635b78
4e800020 3d20c02b 7c6b1b78 3949003c <880b0000> 396b0001 7c030378
7d2a18ae
---[ end trace 31fd0ba7d8756001 ]---
Kernel panic - not syncing: Attempted to kill init!



Thanks.

Lixin Yao
Harris Stratex Networks Inc.
RTP, NC, USA

------_=_NextPart_001_01C9EA19.4E5DE142
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>Kernel Crash Around Device Tree Access</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I use 2.6.28 kernel for a board using =
processor MPC866T. The kernel startup occationally (1 out of 5 times) =
crashes at various init of device drivers. Sometimes, it happens on the =
init of cpm_uart driver, sometimes on other drivers. It always happens =
at of access of device tree like &quot;of_find_node_by_name&quot;, =
&quot;of_get_property&quot;, etc. A bad pointer to property name crashes =
the kernel. It appears the device tree got corrupted when it happens. I =
am having difficulty identifying the problem. Any insight will be =
helpful.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Note, once the kernel starts, it works =
fine. I tried to pull in fixes from 2.6.30 around prom and of area, and =
they don't help.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Following is a dump showing the =
problem:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Filename =
'eclipse/cuImage.eclipse_idu_8xx'.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Load address: 0x200000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Loading: =
#################################################################</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#################################################################</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
############</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">done</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Bytes transferred =3D 1389443 (153383 =
hex)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">## Booting image at 00200000 =
...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.28-00015-g324a40e-dirt</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Image Type:&nbsp;&nbsp; =
PowerPC Linux Kernel Image (gzip compressed)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Data =
Size:&nbsp;&nbsp;&nbsp; 1389379 Bytes =3D&nbsp; 1.3 MB</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Load Address: =
00400000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Entry Point:&nbsp; =
00400598</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Verifying Checksum ... =
OK</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; Uncompressing Kernel =
Image ... OK</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Using Eclipse IDU 8xx machine =
description</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Linux version =
2.6.28-00015-g324a40e-dirty (lyao01@lyao01-desktop) (gcc version =
4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">.2.2) #12 Wed Jun 10 17:59:17 EDT =
2009</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Zone PFN ranges:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000 -&gt; 0x00004000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; Normal&nbsp;&nbsp; 0x00004000 =
-&gt; 0x00004000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Movable zone start PFN for each =
node</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">early_node_map[1] active PFN =
ranges</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; 0: 0x00000000 -&gt; =
0x00004000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Built 1 zonelists in Zone order, =
mobility grouping on.&nbsp; Total pages: 16256</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Kernel command line: =
console=3DttyCPM0,38400 root=3D/dev/nfs rw nfsroot=3D10.15.34.196</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">:/home/lyao01/work/target_idu_xxx_2.6 =
ip=3D172.20.16.151:10.15.34.196:172.20.16.1:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">255.255.255.0:nccv2:eth0:off =
eclipse=3Dnccv2 RSR=3D0xc0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">PID hash table entries: 256 (order: 8, =
1024 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Decrementer Frequency =3D =
0x5f5e10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">clocksource: timebase mult[28000000] =
shift[22] registered</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">STXN: =
drivers/serial/cpm_uart/cpm_uart_core.c, cpm_uart_console_init =
START</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">console [ttyCPM0] enabled</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Dentry cache hash table entries: 8192 =
(order: 3, 32768 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Inode-cache hash table entries: 4096 =
(order: 2, 16384 bytes)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Memory: 61892k/65536k available (2688k =
kernel code, 3576k reserved, 96k data, 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">2k bss, 116k init)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">SLUB: Genslabs=3D11, HWalign=3D16, =
Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Calibrating delay loop... 11.93 =
BogoMIPS (lpj=3D5968)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Mount-cache hash table entries: =
512</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">net_namespace: 288 bytes</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NET: Registered protocol family =
16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Unable to handle kernel paging request =
for data at address 0x08000604</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Faulting instruction address: =
0xc0129ab0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oops: Kernel access of bad area, sig: =
11 [#1]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Eclipse IDU 8xx</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Modules linked in:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP: c0129ab0 LR: c018c6b4 CTR: =
c0287648</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">REGS: c3817d50 TRAP: 0300&nbsp;&nbsp; =
Not tainted&nbsp; (2.6.28-00015-g324a40e-dirty)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">MSR: 00009032 =
&lt;EE,ME,IR,DR&gt;&nbsp; CR: 22004044&nbsp; XER: 0000005f</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">DAR: 08000604, DSISR: c0000000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">TASK =3D c3818000[1] 'swapper' THREAD: =
c3816000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR00: 08000604 c3817e00 c3818000 =
08000604 c024cfbc c3800648 00000002 c02e2780</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR08: 00000000 c02b0000 c02b003c =
08000604 84004048 02000000 03ffb200 03ffaf20</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR16: 00000000 ffffffff 03fb2b80 =
00000001 03fff814 007ffeb0 007fff00 00800000</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">GPR24: 00000ef9 00000000 00000000 =
c024cfbc c02bf324 00000000 c024cfbc c3ffeb10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">NIP [c0129ab0] =
strcasecmp+0xc/0x64</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">LR [c018c6b4] =
of_find_node_by_name+0x40/0x98</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Call Trace:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c3817e00] [0000005f] 0x5f =
(unreliable)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c3817e20] [c02876a4] =
of_add_fixed_phys+0x5c/0x118</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c3817e60] [c00021ec] =
do_one_initcall+0x38/0x1a4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c3817fd0] [c0283168] =
kernel_init+0x88/0xf4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[c3817ff0] [c000da9c] =
kernel_thread+0x4c/0x68</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Instruction dump:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">4200ffa8 7c635850 4e800020 7c635850 =
4e800020 7c6300d0 4e800020 7d635b78</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">4e800020 3d20c02b 7c6b1b78 3949003c =
&lt;880b0000&gt; 396b0001 7c030378 7d2a18ae</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">---[ end trace 31fd0ba7d8756001 =
]---</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Kernel panic - not syncing: Attempted =
to kill init!</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Lixin Yao</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Harris Stratex Networks Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">RTP, NC, USA</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C9EA19.4E5DE142--
