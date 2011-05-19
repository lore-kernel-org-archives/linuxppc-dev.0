Return-Path: <bsamograd@Interalia.com>
Received: from CgyExchg.Interalia.ca (mail.interalia.com [72.13.188.35])
	by ozlabs.org (Postfix) with ESMTP id B8A75B718C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 06:11:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CC1660.F5CCF633"
Subject: Unable to handle kernel paging request for data at address 0x00000000
Date: Thu, 19 May 2011 14:11:37 -0600
Message-ID: <C5362BC88E4CB545B18EA43E89EC0D56024427BD@cgyexchg.Interalia.ca>
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

------_=_NextPart_001_01CC1660.F5CCF633
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I'm trying to get 2.6.38.6 up and running on my ppc880 board and I've
run into a problem when the kernel is attempting to perform it's first
exec (/sbin/init).  I've tried to debug it as much as I can so I thought
I would post this to see if anybody has any ideas or suggestions about
what might be going wrong.

=20

Following is a full output of the board bootup messages from U-boot and
the kernel:

=20

------------------------------------------------------------------------
-----------------------------------------------

U-Boot 1.3.1 (May 19 2011 - 09:55:57)

=20

CPU:   MPC885ZPnn at 131.666 MHz [40.0...133.0 MHz]

       8 kB I-Cache 8 kB D-Cache FEC present

DRAM:  64 MB

*** Warning - bad CRC, using default environment

=20

In:    serial

Out:   serial

Err:   serial

Net:   FEC ETHERNET, FEC2 ETHERNET

IDE:   Hit any key to stop autoboot:  0

Using FEC ETHERNET device

TFTP from server 192.168.0.6; our IP address is 192.168.0.4

Filename 'uImage'.

Load address: 0xe00000

Loading: T
#################################################################

         ##############

done

Bytes transferred =3D 1155044 (119fe4 hex)

## Booting image at 00e00000 ...

   Image Name:   Linux-2.6.38.6sbx-dirty

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    1154980 Bytes =3D  1.1 MB

   Load Address: 00400000

   Entry Point:  0040055c

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK

## Current stack ends at 0x03F91AB8 =3D> set upper limit to 0x00800000

## cmdline at 0x007FFF00 ... 0x007FFF79

memstart    =3D 0x00000000

memsize     =3D 0x04000000

flashstart  =3D 0x00000000

flashsize   =3D 0x00000000

flashoffset =3D 0x00000000

sramstart   =3D 0x00000000

sramsize    =3D 0x00000000

immr_base   =3D 0xFF000000

bootflags   =3D 0x00000001

intfreq     =3D 131.666 MHz

busfreq     =3D 65.833 MHz

ethaddr     =3D 00:07:07:00:4C:64

IP addr     =3D 192.168.0.4

baudrate    =3D  38400 bps

No initrd

## Transferring control to Linux (at address 0040055c) ...

Kernel Command Line: console=3DttyCPM0,38400 root=3D/dev/nfs,rw
nfsroot=3D192.168.0.6:/sbx ip=3D192.168.0.15:192.168.0.6:::sbx:eth0:off
init=3D/bin/bash

Memory <- <0x0 0x4000000> (64MB)

ENET0: local-mac-address <- 00:07:07:00:4c:64

ENET1: local-mac-address <- 00:3b:f5:21:63:6f

CPU clock-frequency <- 0x7d912de (132MHz)

CPU timebase-frequency <- 0x3ec896 (4MHz)

CPU bus-frequency <- 0x3ec896f (66MHz)

=20

zImage starting: loaded at 0x00400000 (sp: 0x03f91978)

Allocating 0x251480 bytes for kernel ...

gunzipping (0x00000000 <- 0x0040c000:0x0068b948)...done 0x23cde0 bytes

=20

Linux/PowerPC load: console=3DttyCPM0,38400 root=3D/dev/nfs,rw
nfsroot=3D192.168.0.6:/sbx ip=3D192.168.0.15:192.168.0.6:::sbx:eth0:off
init=3D/bin/bash

Finalizing device tree... flat tree at 0x698300

Using Freescale MPC885 ADS machine description

Linux version 2.6.38.6sbx-dirty (root@burton-fedora-14.interalia.com)
(gcc version 4.2.2) #43 Thu May 19 13:55:22 MDT 2011

Zone PFN ranges:

  DMA      0x00000000 -> 0x00000800

  Normal   empty

  HighMem  0x00000800 -> 0x00004000

Movable zone start PFN for each node

early_node_map[1] active PFN ranges

    0: 0x00000000 -> 0x00004000

MMU: Allocated 72 bytes of context maps for 16 contexts

Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
16256

Kernel command line: console=3DttyCPM0,38400 root=3D/dev/nfs,rw
nfsroot=3D192.168.0.6:/sbx ip=3D192.168.0.15:192.168.0.6:::sbx:eth0:off
init=3D/bin/bash

PID hash table entries: 32 (order: -5, 128 bytes)

Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)

Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)

Memory: 62544k/65536k available (2212k kernel code, 2992k reserved, 80k
data, 81k bss, 96k init)

Kernel virtual memory layout:

  * 0xfffcf000..0xfffff000  : fixmap

  * 0xff800000..0xffc00000  : highmem PTEs

  * 0xff600000..0xff800000  : consistent mem

  * 0xff5f8000..0xff600000  : early ioremap

  * 0xc1000000..0xff5f8000  : vmalloc & ioremap

SLUB: Genslabs=3D14, HWalign=3D16, Order=3D0-3, MinObjects=3D0, =
CPUs=3D1, Nodes=3D1

NR_IRQS:512 nr_irqs:512 16

Decrementer Frequency =3D 0x7d912d

clocksource: timebase mult[1e61377e] shift[22] registered

console [ttyCPM0] enabled

pid_max: default: 4096 minimum: 301

Mount-cache hash table entries: 512

NET: Registered protocol family 16

bio: create slab <bio-0> at 0

Switching to clocksource timebase

NET: Registered protocol family 2

Switched to NOHz mode on CPU #0

IP route cache hash table entries: 1024 (order: 0, 4096 bytes)

TCP established hash table entries: 512 (order: 0, 4096 bytes)

TCP bind hash table entries: 512 (order: -1, 2048 bytes)

TCP: Hash tables configured (established 512 bind 512)

TCP reno registered

NET: Registered protocol family 1

RPC: Registered udp transport module.

RPC: Registered tcp transport module.

RPC: Registered tcp NFSv4.1 backchannel transport module.

highmem bounce pool size: 64 pages

msgmni has been set to 16

io scheduler noop registered

io scheduler deadline registered (default)

ff000a80.serial: ttyCPM0 at MMIO 0xc1010a80 (irq =3D 19) is a CPM UART

ff000a90.serial: ttyCPM1 at MMIO 0xc1018a90 (irq =3D 24) is a CPM UART

Generic RTC Driver v1.07

Uniform Multi-Platform E-IDE driver

ide-gd driver 1.18

eth0: fs_enet: 00:07:07:00:4c:64

eth1: fs_enet: 00:3b:f5:21:63:6f

FEC MII Bus: probed

mdio_bus ff000e00: error probing PHY at address 3

TCP cubic registered

NET: Registered protocol family 17

IP-Config: Guessing netmask 255.255.255.0

IP-Config: Complete:

     device=3Deth0, addr=3D192.168.0.15, mask=3D255.255.255.0,
gw=3D255.255.255.255,

     host=3Dsbx, domain=3D, nis-domain=3D(none),

     bootserver=3D192.168.0.6, rootserver=3D192.168.0.6, rootpath=3D

VFS: Mounted root (nfs filesystem) readonly on device 0:10.

Freeing unused kernel memory: 96k init

Failed to execute /bin/bash.  Attempting defaults...

Unable to handle kernel paging request for data at address 0x00000000

Faulting instruction address: 0xc000b77c

Oops: Kernel access of bad area, sig: 11 [#1]

Freescale MPC885 ADS

last sysfs file:

NIP: c000b77c LR: c000deb0 CTR: 00000100

REGS: c02e7cc0 TRAP: 0300   Not tainted  (2.6.38.6sbx-dirty)

MSR: 00009032 <EE,ME,IR,DR>  CR: 22248042  XER: 0000f800

DAR: 00000000, DSISR: c0000000

TASK =3D c02e4000[1] 'swapper' THREAD: c02e6000

GPR00: c000deac c02e7d70 c02e4000 00000000 00000100 c03ecffc 00000000
c022e8ec

GPR08: c02445a0 c02445a0 00009032 000005e0 22248042 10000900 22242044
22242044

GPR16: 22248044 00000000 00000000 00000001 c03e1000 c02e7e38 00000030
00000022

GPR24: c03e1000 c03e27fc c0240000 7ffffff1 c03ecffc 7ffffff1 03c05d21
c02cd0a0

NIP [c000b77c] __flush_dcache_icache+0x14/0x40

LR [c000deb0] flush_dcache_icache_page+0x14/0x24

Call Trace:

[c02e7d70] [c000deac] flush_dcache_icache_page+0x10/0x24 (unreliable)

[c02e7d80] [c000e0c8] set_pte_at+0x50/0x7c

[c02e7da0] [c0060548] handle_pte_fault+0x228/0x3ac

[c02e7dd0] [c00617d8] __get_user_pages+0x2a4/0x3cc

[c02e7e30] [c007536c] get_arg_page+0x40/0xb8

[c02e7e50] [c00755dc] copy_strings+0x114/0x2e8

[c02e7ea0] [c0075ca0] do_execve+0x120/0x254

[c02e7ee0] [c000719c] sys_execve+0x50/0x7c

[c02e7f00] [c000be6c] ret_from_syscall+0x0/0x38

[c02e7fc0] [00001032] 0x1032

[c02e7fd0] [c0002404] init_post+0x88/0xb8

[c02e7fe0] [c0211424] kernel_init+0x144/0x15c

[c02e7ff0] [c000b994] kernel_thread+0x4c/0x68

Instruction dump:

4d820020 7c8903a6 7c001bac 38630010 4200fff8 7c0004ac 4e800020 60000000

54630026 38800100 7c8903a6 7c661b78 <7c00186c> 38630010 4200fff8
7c0004ac

---[ end trace 5e2c5aac0577498f ]---

note: swapper[1] exited with preempt_count 1

BUG: scheduling while atomic: swapper/1/0x00000001

Call Trace:

[c02e7950] [c0006908] show_stack+0x50/0x154 (unreliable)

[c02e7990] [c0016b54] __schedule_bug+0x54/0x68

[c02e79a0] [c01b6560] schedule+0x60/0x344

[c02e7a90] [c01b6d84] schedule_timeout+0x148/0x17c

[c02e7ac0] [c00247c0] msleep_interruptible+0x1c/0x54

[c02e7ad0] [c01139d4] __uart_wait_until_sent+0x90/0xec

[c02e7af0] [c01156c0] uart_close+0x19c/0x2c4

[c02e7b40] [c0109cfc] tty_release+0x1b4/0x45c

[c02e7be0] [c00713ac] fput+0xa8/0x14c

[c02e7c00] [c006e77c] filp_close+0x78/0x90

[c02e7c20] [c001c18c] put_files_struct+0x88/0xe8

[c02e7c40] [c001d640] do_exit+0x168/0x544

[c02e7c80] [c0009528] die+0x184/0x19c

[c02e7ca0] [c000d7c0] bad_page_fault+0xe8/0xfc

[c02e7cb0] [c000c30c] handle_page_fault+0x7c/0x80

[c02e7d70] [c000deac] flush_dcache_icache_page+0x10/0x24

[c02e7d80] [c000e0c8] set_pte_at+0x50/0x7c

[c02e7da0] [c0060548] handle_pte_fault+0x228/0x3ac

[c02e7dd0] [c00617d8] __get_user_pages+0x2a4/0x3cc

[c02e7e30] [c007536c] get_arg_page+0x40/0xb8

[c02e7e50] [c00755dc] copy_strings+0x114/0x2e8

[c02e7ea0] [c0075ca0] do_execve+0x120/0x254

[c02e7ee0] [c000719c] sys_execve+0x50/0x7c

[c02e7f00] [c000be6c] ret_from_syscall+0x0/0x38

[c02e7fc0] [00001032] 0x1032

[c02e7fd0] [c0002404] init_post+0x88/0xb8

[c02e7fe0] [c0211424] kernel_init+0x144/0x15c

[c02e7ff0] [c000b994] kernel_thread+0x4c/0x68

BUG: scheduling while atomic: swapper/1/0x00000001

Call Trace:

[c02e7950] [c0006908] show_stack+0x50/0x154 (unreliable)

[c02e7990] [c0016b54] __schedule_bug+0x54/0x68

[c02e79a0] [c01b6560] schedule+0x60/0x344

[c02e7a90] [c01b6d84] schedule_timeout+0x148/0x17c

[c02e7ac0] [c00247c0] msleep_interruptible+0x1c/0x54

[c02e7ad0] [c01139d4] __uart_wait_until_sent+0x90/0xec

[c02e7af0] [c01156fc] uart_close+0x1d8/0x2c4

[c02e7b40] [c0109cfc] tty_release+0x1b4/0x45c

[c02e7be0] [c00713ac] fput+0xa8/0x14c

[c02e7c00] [c006e77c] filp_close+0x78/0x90

[c02e7c20] [c001c18c] put_files_struct+0x88/0xe8

[c02e7c40] [c001d640] do_exit+0x168/0x544

[c02e7c80] [c0009528] die+0x184/0x19c

[c02e7ca0] [c000d7c0] bad_page_fault+0xe8/0xfc

[c02e7cb0] [c000c30c] handle_page_fault+0x7c/0x80

[c02e7d70] [c000deac] flush_dcache_icache_page+0x10/0x24

[c02e7d80] [c000e0c8] set_pte_at+0x50/0x7c

[c02e7da0] [c0060548] handle_pte_fault+0x228/0x3ac

[c02e7dd0] [c00617d8] __get_user_pages+0x2a4/0x3cc

[c02e7e30] [c007536c] get_arg_page+0x40/0xb8

[c02e7e50] [c00755dc] copy_strings+0x114/0x2e8

[c02e7ea0] [c0075ca0] do_execve+0x120/0x254

[c02e7ee0] [c000719c] sys_execve+0x50/0x7c

[c02e7f00] [c000be6c] ret_from_syscall+0x0/0x38

[c02e7fc0] [00001032] 0x1032

[c02e7fd0] [c0002404] init_post+0x88/0xb8

[c02e7fe0] [c0211424] kernel_init+0x144/0x15c

[c02e7ff0] [c000b994] kernel_thread+0x4c/0x68

Kernel panic - not syncing: Attempted to kill init!

Rebooting in 180 seconds..

------------------------------------------------------------------------
-----------------------------------------------

=20

Note: I specify /bin/bash for init on the command line (which currently
isn't present on my current root file system), but it's defaulting to
/sbin/init, which is present in my root filesystem.  This problem
occurred whether /bin/bash or /sbin/init were set.

=20

Any advice or help appreciated.

=20

--

Burton Samograd


------_=_NextPart_001_01CC1660.F5CCF633
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
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
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m trying to get 2.6.38.6 up and running on my =
ppc880
board and I&#8217;ve run into a problem when the kernel is attempting to
perform it&#8217;s first exec (/sbin/init).&nbsp; I&#8217;ve tried to =
debug it
as much as I can so I thought I would post this to see if anybody has =
any ideas
or suggestions about what might be going =
wrong.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Following is a full output of the board bootup =
messages from
U-boot and the kernel:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><a name=3D"OLE_LINK2"></a><a =
name=3D"OLE_LINK1"><font size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>----------------------------=
-------------------------------------------------------------------------=
------------------<o:p></o:p></span></font></a></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>U-Boot 1.3.1 (May 19 2011 - =
09:55:57)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU:&nbsp;&nbsp; MPC885ZPnn at 131.666 MHz =
[40.0...133.0
MHz]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 kB I-Cache 8 =
kB
D-Cache FEC present<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>DRAM:&nbsp; 64 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>*** Warning - bad CRC, using default =
environment<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In:&nbsp;&nbsp;&nbsp; =
serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Out:&nbsp;&nbsp; serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Err:&nbsp;&nbsp; serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Net:&nbsp;&nbsp; FEC ETHERNET, FEC2 =
ETHERNET<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>IDE:&nbsp;&nbsp; Hit any key to stop autoboot:&nbsp; =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Using FEC ETHERNET =
device<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TFTP from server 192.168.0.6; our IP address is =
192.168.0.4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Filename 'uImage'.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Load address: 0xe00000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Loading: T
#################################################################<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
##############<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>done<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Bytes transferred =3D 1155044 (119fe4 =
hex)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>## Booting image at 00e00000 =
...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.38.6sbx-dirty<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux =
Kernel
Image (gzip compressed)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1154980 =
Bytes
=3D&nbsp; 1.1 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Load Address: =
00400000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Entry Point:&nbsp; =
0040055c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Verifying Checksum ... =
OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Uncompressing Kernel Image ... =
OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>## Current stack ends at 0x03F91AB8 =3D&gt; set upper =
limit to
0x00800000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>## cmdline at 0x007FFF00 ... =
0x007FFF79<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>memstart&nbsp;&nbsp;&nbsp; =3D =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>memsize&nbsp;&nbsp;&nbsp;&nbsp; =3D =
0x04000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>flashstart&nbsp; =3D =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>flashsize&nbsp;&nbsp; =3D =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>flashoffset =3D =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>sramstart&nbsp;&nbsp; =3D =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>sramsize&nbsp;&nbsp;&nbsp; =3D =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>immr_base&nbsp;&nbsp; =3D =
0xFF000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>bootflags&nbsp;&nbsp; =3D =
0x00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>intfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D 131.666 =
MHz<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>busfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D 65.833 =
MHz<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ethaddr&nbsp;&nbsp;&nbsp;&nbsp; =3D =
00:07:07:00:4C:64<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>IP addr&nbsp;&nbsp;&nbsp;&nbsp; =3D =
192.168.0.4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>baudrate&nbsp;&nbsp;&nbsp; =3D&nbsp; 38400 =
bps<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>No initrd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>## Transferring control to Linux (at address =
0040055c) ...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kernel Command Line: console=3DttyCPM0,38400 =
root=3D/dev/nfs,rw
nfsroot=3D192.168.0.6:/sbx ip=3D192.168.0.15:192.168.0.6:::sbx:eth0:off
init=3D/bin/bash<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Memory &lt;- &lt;0x0 0x4000000&gt; =
(64MB)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ENET0: local-mac-address &lt;- =
00:07:07:00:4c:64<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ENET1: local-mac-address &lt;- =
00:3b:f5:21:63:6f<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU clock-frequency &lt;- 0x7d912de =
(132MHz)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU timebase-frequency &lt;- 0x3ec896 =
(4MHz)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU bus-frequency &lt;- 0x3ec896f =
(66MHz)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>zImage starting: loaded at 0x00400000 (sp: =
0x03f91978)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Allocating 0x251480 bytes for kernel =
...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>gunzipping (0x00000000 &lt;- =
0x0040c000:0x0068b948)...done
0x23cde0 bytes<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Linux/PowerPC load: console=3DttyCPM0,38400 =
root=3D/dev/nfs,rw
nfsroot=3D192.168.0.6:/sbx ip=3D192.168.0.15:192.168.0.6:::sbx:eth0:off
init=3D/bin/bash<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Finalizing device tree... flat tree at =
0x698300<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Using Freescale MPC885 ADS machine =
description<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Linux version 2.6.38.6sbx-dirty
(root@burton-fedora-14.interalia.com) (gcc version 4.2.2) #43 Thu May 19
13:55:22 MDT 2011<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Zone PFN ranges:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000 =
-&gt;
0x00000800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; Normal&nbsp;&nbsp; =
empty<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; HighMem&nbsp; 0x00000800 -&gt; =
0x00004000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Movable zone start PFN for each =
node<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>early_node_map[1] active PFN =
ranges<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; 0: 0x00000000 -&gt; =
0x00004000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>MMU: Allocated 72 bytes of context maps for 16 =
contexts<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Built 1 zonelists in Zone order, mobility grouping =
on.&nbsp;
Total pages: 16256<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kernel command line: console=3DttyCPM0,38400 =
root=3D/dev/nfs,rw
nfsroot=3D192.168.0.6:/sbx ip=3D192.168.0.15:192.168.0.6:::sbx:eth0:off
init=3D/bin/bash<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PID hash table entries: 32 (order: -5, 128 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dentry cache hash table entries: 1024 (order: 0, 4096 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Inode-cache hash table entries: 1024 (order: 0, 4096 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Memory: 62544k/65536k available (2212k kernel code, =
2992k
reserved, 80k data, 81k bss, 96k init)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kernel virtual memory =
layout:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; * 0xfffcf000..0xfffff000&nbsp; : =
fixmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; * 0xff800000..0xffc00000&nbsp; : highmem =
PTEs<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; * 0xff600000..0xff800000&nbsp; : consistent =
mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; * 0xff5f8000..0xff600000&nbsp; : early =
ioremap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; * 0xc1000000..0xff5f8000&nbsp; : vmalloc &amp;
ioremap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>SLUB: Genslabs=3D14, HWalign=3D16, Order=3D0-3, =
MinObjects=3D0,
CPUs=3D1, Nodes=3D1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NR_IRQS:512 nr_irqs:512 =
16<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Decrementer Frequency =3D =
0x7d912d<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>clocksource: timebase mult[1e61377e] shift[22] =
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>console [ttyCPM0] =
enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>pid_max: default: 4096 minimum: =
301<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mount-cache hash table entries: =
512<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NET: Registered protocol family =
16<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>bio: create slab &lt;bio-0&gt; at =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Switching to clocksource =
timebase<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NET: Registered protocol family =
2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Switched to NOHz mode on CPU =
#0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>IP route cache hash table entries: 1024 (order: 0, =
4096
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TCP established hash table entries: 512 (order: 0, =
4096
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TCP bind hash table entries: 512 (order: -1, 2048 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TCP: Hash tables configured (established 512 bind =
512)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TCP <st1:City w:st=3D"on"><st1:place =
w:st=3D"on">reno</st1:place></st1:City>
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NET: Registered protocol family =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>RPC: Registered udp transport =
module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>RPC: Registered tcp transport =
module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>RPC: Registered tcp NFSv4.1 backchannel transport =
module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>highmem bounce pool size: 64 =
pages<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>msgmni has been set to =
16<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>io scheduler noop =
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>io scheduler deadline registered =
(default)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ff000a80.serial: ttyCPM0 at MMIO 0xc1010a80 (irq =3D =
19) is a
CPM UART<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ff000a90.serial: ttyCPM1 at MMIO 0xc1018a90 (irq =3D =
24) is a
CPM UART<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Generic RTC Driver v1.07<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Uniform Multi-Platform E-IDE =
driver<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ide-gd driver 1.18<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>eth0: fs_enet: =
00:07:07:00:4c:64<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>eth1: fs_enet: =
00:3b:f5:21:63:6f<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>FEC MII Bus: probed<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>mdio_bus ff000e00: error probing PHY at address =
3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TCP cubic registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NET: Registered protocol family =
17<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>IP-Config: Guessing netmask =
255.255.255.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>IP-Config: Complete:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, =
addr=3D192.168.0.15,
mask=3D255.255.255.0, gw=3D255.255.255.255,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; host=3Dsbx, domain=3D,
nis-domain=3D(none),<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D192.168.0.6,
rootserver=3D192.168.0.6, rootpath=3D<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>VFS: Mounted root (nfs filesystem) readonly on device =
0:10.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Freeing unused kernel memory: 96k =
init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Failed to execute /bin/bash.&nbsp; Attempting =
defaults...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Unable to handle kernel paging request for data at =
address
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Faulting instruction address: =
0xc000b77c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oops: Kernel access of bad area, sig: 11 =
[#1]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Freescale MPC885 ADS<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>last sysfs file:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NIP: c000b77c LR: c000deb0 CTR: =
00000100<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>REGS: c02e7cc0 TRAP: 0300&nbsp;&nbsp; Not =
tainted&nbsp;
(2.6.38.6sbx-dirty)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: =
22248042&nbsp;
XER: 0000f800<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>DAR: 00000000, DSISR: =
c0000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TASK =3D c02e4000[1] 'swapper' THREAD: =
c02e6000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GPR00: c000deac c02e7d70 c02e4000 00000000 00000100 =
c03ecffc
00000000 c022e8ec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GPR08: c02445a0 c02445a0 00009032 000005e0 22248042 =
10000900
22242044 22242044<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GPR16: 22248044 00000000 00000000 00000001 c03e1000 =
c02e7e38
00000030 00000022<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>GPR24: c03e1000 c03e27fc c0240000 7ffffff1 c03ecffc =
7ffffff1
03c05d21 c02cd0a0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NIP [c000b77c] =
__flush_dcache_icache+0x14/0x40<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>LR [c000deb0] =
flush_dcache_icache_page+0x14/0x24<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7d70] [c000deac] =
flush_dcache_icache_page+0x10/0x24
(unreliable)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7d80] [c000e0c8] =
set_pte_at+0x50/0x7c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7da0] [c0060548] =
handle_pte_fault+0x228/0x3ac<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7dd0] [c00617d8] =
__get_user_pages+0x2a4/0x3cc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7e30] [c007536c] =
get_arg_page+0x40/0xb8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7e50] [c00755dc] =
copy_strings+0x114/0x2e8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ea0] [c0075ca0] =
do_execve+0x120/0x254<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ee0] [c000719c] =
sys_execve+0x50/0x7c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7f00] [c000be6c] =
ret_from_syscall+0x0/0x38<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fc0] [00001032] =
0x1032<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fd0] [c0002404] =
init_post+0x88/0xb8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fe0] [c0211424] =
kernel_init+0x144/0x15c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ff0] [c000b994] =
kernel_thread+0x4c/0x68<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Instruction dump:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>4d820020 7c8903a6 7c001bac 38630010 4200fff8 7c0004ac
4e800020 60000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>54630026 38800100 7c8903a6 7c661b78 &lt;7c00186c&gt;
38630010 4200fff8 7c0004ac<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>---[ end trace 5e2c5aac0577498f =
]---<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>note: swapper[1] exited with preempt_count =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>BUG: scheduling while atomic: =
swapper/1/0x00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7950] [c0006908] show_stack+0x50/0x154 =
(unreliable)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7990] [c0016b54] =
__schedule_bug+0x54/0x68<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e79a0] [c01b6560] =
schedule+0x60/0x344<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7a90] [c01b6d84] =
schedule_timeout+0x148/0x17c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ac0] [c00247c0] =
msleep_interruptible+0x1c/0x54<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ad0] [c01139d4] =
__uart_wait_until_sent+0x90/0xec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7af0] [c01156c0] =
uart_close+0x19c/0x2c4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7b40] [c0109cfc] =
tty_release+0x1b4/0x45c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7be0] [c00713ac] =
fput+0xa8/0x14c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7c00] [c006e77c] =
filp_close+0x78/0x90<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7c20] [c001c18c] =
put_files_struct+0x88/0xe8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7c40] [c001d640] =
do_exit+0x168/0x544<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7c80] [c0009528] =
die+0x184/0x19c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ca0] [c000d7c0] =
bad_page_fault+0xe8/0xfc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7cb0] [c000c30c] =
handle_page_fault+0x7c/0x80<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7d70] [c000deac] =
flush_dcache_icache_page+0x10/0x24<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7d80] [c000e0c8] =
set_pte_at+0x50/0x7c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7da0] [c0060548] =
handle_pte_fault+0x228/0x3ac<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7dd0] [c00617d8] =
__get_user_pages+0x2a4/0x3cc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7e30] [c007536c] =
get_arg_page+0x40/0xb8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7e50] [c00755dc] =
copy_strings+0x114/0x2e8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ea0] [c0075ca0] =
do_execve+0x120/0x254<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ee0] [c000719c] =
sys_execve+0x50/0x7c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7f00] [c000be6c] =
ret_from_syscall+0x0/0x38<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fc0] [00001032] =
0x1032<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fd0] [c0002404] =
init_post+0x88/0xb8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fe0] [c0211424] =
kernel_init+0x144/0x15c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ff0] [c000b994] =
kernel_thread+0x4c/0x68<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>BUG: scheduling while atomic: =
swapper/1/0x00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7950] [c0006908] show_stack+0x50/0x154 =
(unreliable)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7990] [c0016b54] =
__schedule_bug+0x54/0x68<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e79a0] [c01b6560] =
schedule+0x60/0x344<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7a90] [c01b6d84] =
schedule_timeout+0x148/0x17c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ac0] [c00247c0] =
msleep_interruptible+0x1c/0x54<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ad0] [c01139d4] =
__uart_wait_until_sent+0x90/0xec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7af0] [c01156fc] =
uart_close+0x1d8/0x2c4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7b40] [c0109cfc] =
tty_release+0x1b4/0x45c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7be0] [c00713ac] =
fput+0xa8/0x14c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7c00] [c006e77c] =
filp_close+0x78/0x90<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7c20] [c001c18c] =
put_files_struct+0x88/0xe8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7c40] [c001d640] =
do_exit+0x168/0x544<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7c80] [c0009528] =
die+0x184/0x19c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ca0] [c000d7c0] =
bad_page_fault+0xe8/0xfc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7cb0] [c000c30c] =
handle_page_fault+0x7c/0x80<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7d70] [c000deac] =
flush_dcache_icache_page+0x10/0x24<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7d80] [c000e0c8] =
set_pte_at+0x50/0x7c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7da0] [c0060548] =
handle_pte_fault+0x228/0x3ac<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7dd0] [c00617d8] =
__get_user_pages+0x2a4/0x3cc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7e30] [c007536c] =
get_arg_page+0x40/0xb8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7e50] [c00755dc] =
copy_strings+0x114/0x2e8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ea0] [c0075ca0] =
do_execve+0x120/0x254<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ee0] [c000719c] =
sys_execve+0x50/0x7c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7f00] [c000be6c] =
ret_from_syscall+0x0/0x38<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fc0] [00001032] =
0x1032<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fd0] [c0002404] =
init_post+0x88/0xb8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7fe0] [c0211424] =
kernel_init+0x144/0x15c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[c02e7ff0] [c000b994] =
kernel_thread+0x4c/0x68<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kernel panic - not syncing: Attempted to kill =
init!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Rebooting in 180 =
seconds..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>------------------------------------------------------=
-----------------------------------------------------------------<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Note: I specify /bin/bash for init on the command =
line
(which currently isn&#8217;t present on my current root file system), =
but it&#8217;s
defaulting to /sbin/init, which is present in my root filesystem.&nbsp; =
This
problem occurred whether /bin/bash or /sbin/init were =
set.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any advice or help =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>--<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:City w:st=3D"on"><st1:place w:st=3D"on"><font =
size=3D2
  face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Burton</span></font></st1:pl=
ace></st1:City><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> =
Samograd<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CC1660.F5CCF633--
