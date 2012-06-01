Return-Path: <mcp@lanl.gov>
Received: from proofpoint4.lanl.gov (proofpoint4.lanl.gov [204.121.3.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ACEE9B6FCB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2012 06:52:23 +1000 (EST)
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
 by proofpoint4.lanl.gov (8.14.4/8.14.4) with ESMTP id q51KeoDd023127
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 14:40:50 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mailrelay2.lanl.gov (Postfix) with ESMTP id 4747917BD012
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 14:40:50 -0600 (MDT)
Received: from ECS-EXG-P-CH05.win.lanl.gov (ecs-exg-p-ch05.win.lanl.gov
 [128.165.106.15])
 by mailrelay2.lanl.gov (Postfix) with ESMTP id 2E1C217BCDC9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 14:40:50 -0600 (MDT)
From: "Proicou, Mike" <mcp@lanl.gov>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Serial RAPID IO kernel hang on maintenance read transaction
Date: Fri, 1 Jun 2012 20:40:49 +0000
Message-ID: <15E2FEE7DC073B4FA1F33D10F5FAAFB1098F8EED@ECS-EXG-P-MB01.win.lanl.gov>
Content-Type: multipart/alternative;
 boundary="_000_15E2FEE7DC073B4FA1F33D10F5FAAFB1098F8EEDECSEXGPMB01winl_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_15E2FEE7DC073B4FA1F33D10F5FAAFB1098F8EEDECSEXGPMB01winl_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I've been struggling with a kernel hang during bootup + enumeration of a Ra=
pid IO system.

My current system contains a N.A.T MCH (using the IDT/Tundra Tsi 578 switch=
) and a Vadatech AMC719 card using the Freescale P4080 processor.  There wi=
ll be other cards added to the system, but I'm testing with just this for n=
ow.

I'm using a Linux kernel version 2.6.34.6.  I've set riohdid=3D0 on the ker=
nel command line, and I'm expecting Linux to fully enumerate and configure =
the Rapid IO fabric. (This may be a bad assumption on my part.)

After lots of tracing, I've determined that the kernel is hanging on the fi=
rst maintenance transaction to the switch.  The hang will often be followed=
 by a "machine check in kernel mode" exception and panic.

 This is very similar to the behavior reported in this mailing list  thread=
 from 2010: http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-October/086=
235.html  I've read that thread several times and tries most of the suggest=
ions, but they don't appear to apply in my hardware configuration.linu



Is it possible that something in the switch isn't completely initialized at=
 the time that Linux tries to do the maintenance transaction?  If so, how d=
o I find it?

Here's the console  log for a bootup using the supplied kernel:

Freescale XGMAC MDIO Bus: probed
Setting up RapidIO peer-to-peer network /rapidio@ffe0c0000
fsl-of-rio ffe0c0000.rapidio: Of-device full name /rapidio@ffe0c0000
fsl-of-rio ffe0c0000.rapidio: Regs: [mem 0xffe0c0000-0xffe0dffff]
fsl-of-rio ffe0c0000.rapidio: LAW start 0x0000000c20000000, size 0x00000000=
01000000.
fsl-of-rio ffe0c0000.rapidio: errirq: 16, bellirq: 57, txirq: 60, rxirq 61
fsl-of-rio ffe0c0000.rapidio: RapidIO PHY type: serial
SRIO Port 1 Status: Lane0Sync Lane1Sync Lane2Sync Lane3Sync Aligned
SRIO Port 2 Status: (Note: Freescale driver only supports Port 1)
fsl-of-rio ffe0c0000.rapidio: Hardware port width: 4
fsl-of-rio ffe0c0000.rapidio: Training connection status: Four-lane
fsl-of-rio ffe0c0000.rapidio: RapidIO Common Transport System size: 256
RIO: enumerate master port 0, RIO0 mport
Machine check in kernel mode.
RIO: port1 error
Caused by (from MCSR=3Da000): Load Error Report
Guarded Load Error Report
Oops: Machine check, sig: 7 [#1]
SMP NR_CPUS=3D8 amc718_based
last sysfs file:
Modules linked in:
NIP: c001a460 LR: c01ee41c CTR: c001a420
REGS: effc9f10 TRAP: 0204   Not tainted  (2.6.34.6-vt3-svn36835)
MSR: 00021002 <ME,CE>  CR: 24022024  XER: 00000000
TASK =3D ebc68000[1] 'swapper' THREAD: ebc62000 CPU: 6
GPR00: f1200000 ebc63d10 ebc68000 00000000 00000000 3fc00000 3fc00000 f1200=
068
GPR08: 00000004 ebc63d18 f1190c20 eb530000 24022022 d811c00a 00000000 00000=
000
GPR16: 00000000 7ffe2a00 00000000 00000000 7fff0df0 00000000 00000000 00000=
000
GPR24: 00000081 000000ff 00000000 ebd89400 00000068 00029002 c05e8914 ebc63=
d58
NIP [c001a460] fsl_rio_config_read+0x40/0x78
LR [c01ee41c] rio_mport_read_config_32+0x7c/0xac
Call Trace:
[ebc63d50] [c01eed64] rio_get_host_deviceid_lock+0x3c/0x50
[ebc63d70] [c045acd4] rio_enum_peer+0x28/0x3e4
[ebc63dd0] [c045b178] rio_enum_mport+0xe8/0x244
[ebc63e10] [c045a59c] rio_init_mports+0x90/0xe4
[ebc63e30] [c0457a5c] fsl_of_rio_rpn_probe+0x3c/0x50
[ebc63e40] [c034abe4] of_platform_device_probe+0x58/0x98
[ebc63e60] [c02274d8] driver_probe_device+0xa4/0x1b4
[ebc63e80] [c02260cc] bus_for_each_drv+0x6c/0xa8
[ebc63eb0] [c022735c] device_attach+0xa4/0xc8
[ebc63ed0] [c0226afc] bus_probe_device+0x2c/0x44
[ebc63ee0] [c02245f8] device_add+0x460/0x5a8
[ebc63f30] [c034a750] of_device_register+0x34/0x48
[ebc63f40] [c0008d64] of_platform_device_create+0x44/0x74
[ebc63f50] [c0008f90] of_platform_bus_probe+0x130/0x15c
[ebc63f70] [c0565480] declare_of_platform_devices+0x24/0x140
[ebc63f90] [c05651cc] __machine_initcall_amc718_based_declare_of_platform_d=
evices+0x2c/0x3c
[ebc63fa0] [c0001cb8] do_one_initcall+0x3c/0x1d0
[ebc63fd0] [c055e9b0] kernel_init+0x190/0x230
[ebc63ff0] [c000f284] kernel_thread+0x4c/0x68
Instruction dump:
814b000c 54e0ba7e 7cc60378 7c0004ac 90ca0000 2f880001 800b0018 7ce03a14
419e0020 2f880002 419e002c 38600000 <80e70000> 7c2006ac 90e90000 4e800020
---[ end trace 561bb236c800851f ]---
Kernel panic - not syncing: Attempted to kill init!
Call Trace:
Rebooting in 180 seconds..

Here's a partial log with some additional output and a dump of the error re=
gisters at the time of failure:



fsl-elo-dma ffe101300.dma: request channel 0 IRQ
fsl-elo-dma ffe101300.dma: request channel 1 IRQ
fsl-elo-dma ffe101300.dma: request channel 2 IRQ
fsl-elo-dma ffe101300.dma: request channel 3 IRQ
Freescale PowerQUICC MII Bus: probed
Freescale XGMAC MDIO Bus: probed
fsl-of-rio ffe0c0000.rapidio: Setting up RapidIO peer-to-peer network /rapi=
dio@ffe0c0000
fsl-of-rio ffe0c0000.rapidio: Of-device full name /rapidio@ffe0c0000
fsl-of-rio ffe0c0000.rapidio: Regs: [mem 0xffe0c0000-0xffe0dffff]
fsl-of-rio ffe0c0000.rapidio: LAW start 0x0000000c20000000, size 0x00000000=
01000000
fsl-of-rio ffe0c0000.rapidio: get_immrbase() ffe000000
fsl-of-rio ffe0c0000.rapidio: IO c20000000 c20ffffff
  alloc irq_desc for 57 on node 0
  alloc kstat_irqs on node 0
irq: irq 57 on host /soc@ffe000000/pic@40000 mapped to virtual irq 57
  alloc irq_desc for 60 on node 0
  alloc kstat_irqs on node 0
irq: irq 60 on host /soc@ffe000000/pic@40000 mapped to virtual irq 60
  alloc irq_desc for 61 on node 0
  alloc kstat_irqs on node 0
irq: irq 61 on host /soc@ffe000000/pic@40000 mapped to virtual irq 61
fsl-of-rio ffe0c0000.rapidio: errirq: 16, bellirq: 57, txirq: 60, rxirq 61
fsl-of-rio ffe0c0000.rapidio: Host deviceid 0
fsl-of-rio ffe0c0000.rapidio: RapidIO PHY type: serial
fsl-of-rio ffe0c0000.rapidio: SRIO Port 1 Status: Lane0Sync Lane1Sync Lane2=
Sync Lane3Sync Aligned
fsl-of-rio ffe0c0000.rapidio: SRIO Port 2 Status: (Note: Freescale driver o=
nly supports Port 1)
fsl-of-rio ffe0c0000.rapidio: Hardware port width: 4
fsl-of-rio ffe0c0000.rapidio: Training connection status: Four-lane
fsl-of-rio ffe0c0000.rapidio: RapidIO Common Transport System size: 256
RIO: enumerate master port 0, RIO0 mport
fsl_local_config_write: index 0 offset 00000068 data 00000000
fsl_local_config_read: index 0 offset 00000068 (ebc63da8) =3D 00000000
fsl_local_config_write: index 0 offset 00000060 data 00000000
fsl_local_config_read: index 0 offset 0000013c (ebc63da8) =3D e0000000
RIO0 mport PGCCSR e0000000
fsl_local_config_read: index 0 offset 0000000c (ebc63d58) =3D 00000100
fsl_local_config_read: index 0 offset 00000100 (ebc63d58) =3D 06000001
fsl_local_config_read: index 0 offset 00000158 (ebc63d88) =3D 00020302
fsl_local_config_read: index 0 offset 0000013c (ebc63da8) =3D e0000000
RIO0 mport is active PGCCSR e0000000
rio_enum_peer 1Machine check in kernel mode.
RIO: port1 error
 P1 error regs EDCSR 00000005 IECSR 00000000 ESCSR 00020302
   LTLEDCSR 00000000
Caused by (from MCSR=3Da000): Load Error Report
Guarded Load Error Report
Oops: Machine check, sig: 7 [#1]
SMP NR_CPUS=3D8 amc718_based
last sysfs file:
Modules linked in:
NIP: c001a838 LR: c01f201c CTR: c001a748
REGS: effc9f10 TRAP: 0204   Not tainted  (2.6.34.6-MCP-svn1717)
MSR: 00021002 <ME,CE>  CR: 24022022  XER: 00000000
TASK =3D ebc68000[1] 'swapper' THREAD: ebc62000 CPU: 6
GPR00: 00000068 ebc63cf0 ebc68000 ffffffea 00000000 000000ff 00000000 00000=
068
GPR08: 00000004 ebd80000 3fc00000 f1190c20 24022022 d814c00a 00000000 00000=
000
GPR16: 00000000 7ffe2a00 00000000 00000000 7fff0df0 00000000 00000000 00000=
000
GPR24: 00000081 000000ff f1200068 00000000 ebc63d18 00000000 000000ff 00000=
068
NIP [c001a838] fsl_rio_config_read+0xf0/0x11c
LR [c01f201c] rio_mport_read_config_32+0x7c/0xac
Call Trace:
[ebc63cf0] [7ffe2a00] 0x7ffe2a00 (unreliable)
[ebc63d10] [c01f201c] rio_mport_read_config_32+0x7c/0xac
[ebc63d50] [c01f28d0] rio_get_host_deviceid_lock+0x3c/0x60
[ebc63d70] [c045ec8c] rio_enum_peer+0x34/0x4c0
[ebc63dd0] [c045f228] rio_enum_mport+0x110/0x290
[ebc63e10] [c045e484] rio_init_mports+0x90/0xe4
[ebc63e30] [c045b944] fsl_of_rio_rpn_probe+0x4c/0x60
[ebc63e40] [c034ea48] of_platform_device_probe+0x58/0x98
[ebc63e60] [c022b334] driver_probe_device+0xa4/0x1b4
[ebc63e80] [c0229f28] bus_for_each_drv+0x6c/0xa8
[ebc63eb0] [c022b1b8] device_attach+0xa4/0xc8
[ebc63ed0] [c022a958] bus_probe_device+0x2c/0x44
[ebc63ee0] [c0228454] device_add+0x460/0x5a8
[ebc63f30] [c034e5b4] of_device_register+0x34/0x48
[ebc63f40] [c0008d64] of_platform_device_create+0x44/0x74
[ebc63f50] [c0008f90] of_platform_bus_probe+0x130/0x15c
[ebc63f70] [c056b534] declare_of_platform_devices+0x24/0x140
[ebc63f90] [c056b280] __machine_initcall_amc718_based_declare_of_platform_d=
evices+0x2c/0x3c
[ebc63fa0] [c0001cb8] do_one_initcall+0x3c/0x1d0
[ebc63fd0] [c05649b0] kernel_init+0x190/0x230
[ebc63ff0] [c000f284] kernel_thread+0x4c/0x68
Instruction dump:
7fa6eb78 7fe7fb78 7f49d378 4843d975 2f9b0000 409e0028 935c0000 7f63db78
4bffff58 a35a0000 7c2006ac 4bffffc8 <835a0000> 7c2006ac 4bffffbc 3c60c04e
---[ end trace 561bb236c800851f ]---
Kernel panic - not syncing: Attempted to kill init!
Call Trace:
Rebooting in 180 seconds..

Thanks for any help ...

Mike Proicou


--_000_15E2FEE7DC073B4FA1F33D10F5FAAFB1098F8EEDECSEXGPMB01winl_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;"><br>
I've been struggling with a kernel hang during bootup &#43; enumeration of =
a Rapid IO system.<br>
<br>
My current system contains a N.A.T MCH (using the IDT/Tundra Tsi 578 switch=
) and a Vadatech AMC719 card using the Freescale P4080 processor.&nbsp; The=
re will be other cards added to the system, but I'm testing with just this =
for now.<br>
<br>
I'm using a Linux kernel version 2.6.34.6.&nbsp; I've set riohdid=3D0 on th=
e kernel command line, and I'm expecting Linux to fully enumerate and confi=
gure the Rapid IO fabric. (This may be a bad assumption on my part.)<br>
<br>
After lots of tracing, I've determined that the kernel is hanging on the fi=
rst maintenance transaction to the switch.&nbsp; The hang will often be fol=
lowed by a &quot;machine check in kernel mode&quot; exception and panic.<br=
>
<br>
&nbsp;This is very similar to the behavior reported in this mailing list&nb=
sp; thread from 2010:
<a href=3D"http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-October/0862=
35.html" target=3D"_blank">
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-October/086235.html</a>=
&nbsp; I've read that thread several times and tries most of the suggestion=
s, but they don't appear to apply in my hardware configuration.linu<br>
<br>
<br>
<br>
Is it possible that something in the switch isn't completely initialized at=
 the time that Linux tries to do the maintenance transaction?&nbsp; If so, =
how do I find it?<br>
<br>
Here's the console&nbsp; log for a bootup using the supplied kernel:<br>
<br>
Freescale XGMAC MDIO Bus: probed<br>
Setting up RapidIO peer-to-peer network /rapidio@ffe0c0000<br>
fsl-of-rio ffe0c0000.rapidio: Of-device full name /rapidio@ffe0c0000<br>
fsl-of-rio ffe0c0000.rapidio: Regs: [mem 0xffe0c0000-0xffe0dffff]<br>
fsl-of-rio ffe0c0000.rapidio: LAW start 0x0000000c20000000, size 0x00000000=
01000000.<br>
fsl-of-rio ffe0c0000.rapidio: errirq: 16, bellirq: 57, txirq: 60, rxirq 61<=
br>
fsl-of-rio ffe0c0000.rapidio: RapidIO PHY type: serial<br>
SRIO Port 1 Status: Lane0Sync Lane1Sync Lane2Sync Lane3Sync Aligned<br>
SRIO Port 2 Status: (Note: Freescale driver only supports Port 1)<br>
fsl-of-rio ffe0c0000.rapidio: Hardware port width: 4<br>
fsl-of-rio ffe0c0000.rapidio: Training connection status: Four-lane<br>
fsl-of-rio ffe0c0000.rapidio: RapidIO Common Transport System size: 256<br>
RIO: enumerate master port 0, RIO0 mport<br>
Machine check in kernel mode.<br>
RIO: port1 error<br>
Caused by (from MCSR=3Da000): Load Error Report<br>
Guarded Load Error Report<br>
Oops: Machine check, sig: 7 [#1]<br>
SMP NR_CPUS=3D8 amc718_based<br>
last sysfs file: <br>
Modules linked in:<br>
NIP: c001a460 LR: c01ee41c CTR: c001a420<br>
REGS: effc9f10 TRAP: 0204&nbsp;&nbsp; Not tainted&nbsp; (2.6.34.6-vt3-svn36=
835)<br>
MSR: 00021002 &lt;ME,CE&gt;&nbsp; CR: 24022024&nbsp; XER: 00000000<br>
TASK =3D ebc68000[1] 'swapper' THREAD: ebc62000 CPU: 6<br>
GPR00: f1200000 ebc63d10 ebc68000 00000000 00000000 3fc00000 3fc00000 f1200=
068 <br>
GPR08: 00000004 ebc63d18 f1190c20 eb530000 24022022 d811c00a 00000000 00000=
000 <br>
GPR16: 00000000 7ffe2a00 00000000 00000000 7fff0df0 00000000 00000000 00000=
000 <br>
GPR24: 00000081 000000ff 00000000 ebd89400 00000068 00029002 c05e8914 ebc63=
d58 <br>
NIP [c001a460] fsl_rio_config_read&#43;0x40/0x78<br>
LR [c01ee41c] rio_mport_read_config_32&#43;0x7c/0xac<br>
Call Trace:<br>
[ebc63d50] [c01eed64] rio_get_host_deviceid_lock&#43;0x3c/0x50<br>
[ebc63d70] [c045acd4] rio_enum_peer&#43;0x28/0x3e4<br>
[ebc63dd0] [c045b178] rio_enum_mport&#43;0xe8/0x244<br>
[ebc63e10] [c045a59c] rio_init_mports&#43;0x90/0xe4<br>
[ebc63e30] [c0457a5c] fsl_of_rio_rpn_probe&#43;0x3c/0x50<br>
[ebc63e40] [c034abe4] of_platform_device_probe&#43;0x58/0x98<br>
[ebc63e60] [c02274d8] driver_probe_device&#43;0xa4/0x1b4<br>
[ebc63e80] [c02260cc] bus_for_each_drv&#43;0x6c/0xa8<br>
[ebc63eb0] [c022735c] device_attach&#43;0xa4/0xc8<br>
[ebc63ed0] [c0226afc] bus_probe_device&#43;0x2c/0x44<br>
[ebc63ee0] [c02245f8] device_add&#43;0x460/0x5a8<br>
[ebc63f30] [c034a750] of_device_register&#43;0x34/0x48<br>
[ebc63f40] [c0008d64] of_platform_device_create&#43;0x44/0x74<br>
[ebc63f50] [c0008f90] of_platform_bus_probe&#43;0x130/0x15c<br>
[ebc63f70] [c0565480] declare_of_platform_devices&#43;0x24/0x140<br>
[ebc63f90] [c05651cc] __machine_initcall_amc718_based_declare_of_platform_d=
evices&#43;0x2c/0x3c<br>
[ebc63fa0] [c0001cb8] do_one_initcall&#43;0x3c/0x1d0<br>
[ebc63fd0] [c055e9b0] kernel_init&#43;0x190/0x230<br>
[ebc63ff0] [c000f284] kernel_thread&#43;0x4c/0x68<br>
Instruction dump:<br>
814b000c 54e0ba7e 7cc60378 7c0004ac 90ca0000 2f880001 800b0018 7ce03a14 <br=
>
419e0020 2f880002 419e002c 38600000 &lt;80e70000&gt; 7c2006ac 90e90000 4e80=
0020 <br>
---[ end trace 561bb236c800851f ]---<br>
Kernel panic - not syncing: Attempted to kill init!<br>
Call Trace:<br>
Rebooting in 180 seconds..<br>
<br>
Here's a partial log with some additional output and a dump of the error re=
gisters at the time of failure:<br>
<br>
<br>
<br>
fsl-elo-dma ffe101300.dma: request channel 0 IRQ<br>
fsl-elo-dma ffe101300.dma: request channel 1 IRQ<br>
fsl-elo-dma ffe101300.dma: request channel 2 IRQ<br>
fsl-elo-dma ffe101300.dma: request channel 3 IRQ<br>
Freescale PowerQUICC MII Bus: probed<br>
Freescale XGMAC MDIO Bus: probed<br>
fsl-of-rio ffe0c0000.rapidio: Setting up RapidIO peer-to-peer network /rapi=
dio@ffe0c0000<br>
fsl-of-rio ffe0c0000.rapidio: Of-device full name /rapidio@ffe0c0000<br>
fsl-of-rio ffe0c0000.rapidio: Regs: [mem 0xffe0c0000-0xffe0dffff]<br>
fsl-of-rio ffe0c0000.rapidio: LAW start 0x0000000c20000000, size 0x00000000=
01000000<br>
fsl-of-rio ffe0c0000.rapidio: get_immrbase() ffe000000<br>
fsl-of-rio ffe0c0000.rapidio: IO c20000000 c20ffffff<br>
&nbsp; alloc irq_desc for 57 on node 0<br>
&nbsp; alloc kstat_irqs on node 0<br>
irq: irq 57 on host /soc@ffe000000/pic@40000 mapped to virtual irq 57<br>
&nbsp; alloc irq_desc for 60 on node 0<br>
&nbsp; alloc kstat_irqs on node 0<br>
irq: irq 60 on host /soc@ffe000000/pic@40000 mapped to virtual irq 60<br>
&nbsp; alloc irq_desc for 61 on node 0<br>
&nbsp; alloc kstat_irqs on node 0<br>
irq: irq 61 on host /soc@ffe000000/pic@40000 mapped to virtual irq 61<br>
fsl-of-rio ffe0c0000.rapidio: errirq: 16, bellirq: 57, txirq: 60, rxirq 61<=
br>
fsl-of-rio ffe0c0000.rapidio: Host deviceid 0<br>
fsl-of-rio ffe0c0000.rapidio: RapidIO PHY type: serial<br>
fsl-of-rio ffe0c0000.rapidio: SRIO Port 1 Status: Lane0Sync Lane1Sync Lane2=
Sync Lane3Sync Aligned<br>
fsl-of-rio ffe0c0000.rapidio: SRIO Port 2 Status: (Note: Freescale driver o=
nly supports Port 1)<br>
fsl-of-rio ffe0c0000.rapidio: Hardware port width: 4<br>
fsl-of-rio ffe0c0000.rapidio: Training connection status: Four-lane<br>
fsl-of-rio ffe0c0000.rapidio: RapidIO Common Transport System size: 256<br>
RIO: enumerate master port 0, RIO0 mport<br>
fsl_local_config_write: index 0 offset 00000068 data 00000000<br>
fsl_local_config_read: index 0 offset 00000068 (ebc63da8) =3D 00000000<br>
fsl_local_config_write: index 0 offset 00000060 data 00000000<br>
fsl_local_config_read: index 0 offset 0000013c (ebc63da8) =3D e0000000<br>
RIO0 mport PGCCSR e0000000<br>
fsl_local_config_read: index 0 offset 0000000c (ebc63d58) =3D 00000100<br>
fsl_local_config_read: index 0 offset 00000100 (ebc63d58) =3D 06000001<br>
fsl_local_config_read: index 0 offset 00000158 (ebc63d88) =3D 00020302<br>
fsl_local_config_read: index 0 offset 0000013c (ebc63da8) =3D e0000000<br>
RIO0 mport is active PGCCSR e0000000<br>
rio_enum_peer 1Machine check in kernel mode.<br>
RIO: port1 error<br>
&nbsp;P1 error regs EDCSR 00000005 IECSR 00000000 ESCSR 00020302<br>
&nbsp;&nbsp; LTLEDCSR 00000000<br>
Caused by (from MCSR=3Da000): Load Error Report<br>
Guarded Load Error Report<br>
Oops: Machine check, sig: 7 [#1]<br>
SMP NR_CPUS=3D8 amc718_based<br>
last sysfs file: <br>
Modules linked in:<br>
NIP: c001a838 LR: c01f201c CTR: c001a748<br>
REGS: effc9f10 TRAP: 0204&nbsp;&nbsp; Not tainted&nbsp; (2.6.34.6-MCP-svn17=
17)<br>
MSR: 00021002 &lt;ME,CE&gt;&nbsp; CR: 24022022&nbsp; XER: 00000000<br>
TASK =3D ebc68000[1] 'swapper' THREAD: ebc62000 CPU: 6<br>
GPR00: 00000068 ebc63cf0 ebc68000 ffffffea 00000000 000000ff 00000000 00000=
068 <br>
GPR08: 00000004 ebd80000 3fc00000 f1190c20 24022022 d814c00a 00000000 00000=
000 <br>
GPR16: 00000000 7ffe2a00 00000000 00000000 7fff0df0 00000000 00000000 00000=
000 <br>
GPR24: 00000081 000000ff f1200068 00000000 ebc63d18 00000000 000000ff 00000=
068 <br>
NIP [c001a838] fsl_rio_config_read&#43;0xf0/0x11c<br>
LR [c01f201c] rio_mport_read_config_32&#43;0x7c/0xac<br>
Call Trace:<br>
[ebc63cf0] [7ffe2a00] 0x7ffe2a00 (unreliable)<br>
[ebc63d10] [c01f201c] rio_mport_read_config_32&#43;0x7c/0xac<br>
[ebc63d50] [c01f28d0] rio_get_host_deviceid_lock&#43;0x3c/0x60<br>
[ebc63d70] [c045ec8c] rio_enum_peer&#43;0x34/0x4c0<br>
[ebc63dd0] [c045f228] rio_enum_mport&#43;0x110/0x290<br>
[ebc63e10] [c045e484] rio_init_mports&#43;0x90/0xe4<br>
[ebc63e30] [c045b944] fsl_of_rio_rpn_probe&#43;0x4c/0x60<br>
[ebc63e40] [c034ea48] of_platform_device_probe&#43;0x58/0x98<br>
[ebc63e60] [c022b334] driver_probe_device&#43;0xa4/0x1b4<br>
[ebc63e80] [c0229f28] bus_for_each_drv&#43;0x6c/0xa8<br>
[ebc63eb0] [c022b1b8] device_attach&#43;0xa4/0xc8<br>
[ebc63ed0] [c022a958] bus_probe_device&#43;0x2c/0x44<br>
[ebc63ee0] [c0228454] device_add&#43;0x460/0x5a8<br>
[ebc63f30] [c034e5b4] of_device_register&#43;0x34/0x48<br>
[ebc63f40] [c0008d64] of_platform_device_create&#43;0x44/0x74<br>
[ebc63f50] [c0008f90] of_platform_bus_probe&#43;0x130/0x15c<br>
[ebc63f70] [c056b534] declare_of_platform_devices&#43;0x24/0x140<br>
[ebc63f90] [c056b280] __machine_initcall_amc718_based_declare_of_platform_d=
evices&#43;0x2c/0x3c<br>
[ebc63fa0] [c0001cb8] do_one_initcall&#43;0x3c/0x1d0<br>
[ebc63fd0] [c05649b0] kernel_init&#43;0x190/0x230<br>
[ebc63ff0] [c000f284] kernel_thread&#43;0x4c/0x68<br>
Instruction dump:<br>
7fa6eb78 7fe7fb78 7f49d378 4843d975 2f9b0000 409e0028 935c0000 7f63db78 <br=
>
4bffff58 a35a0000 7c2006ac 4bffffc8 &lt;835a0000&gt; 7c2006ac 4bffffbc 3c60=
c04e <br>
---[ end trace 561bb236c800851f ]---<br>
Kernel panic - not syncing: Attempted to kill init!<br>
Call Trace:<br>
Rebooting in 180 seconds..<br>
<br>
Thanks for any help ...<br>
<br>
Mike Proicou<br>
<br>
</div>
</body>
</html>

--_000_15E2FEE7DC073B4FA1F33D10F5FAAFB1098F8EEDECSEXGPMB01winl_--
