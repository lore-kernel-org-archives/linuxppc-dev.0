Return-Path: <jason.rennie@rftechnology.com.au>
Received: from mail905.opentransfer.com (mail905.opentransfer.com
 [98.130.1.180]) by ozlabs.org (Postfix) with ESMTP id B18112C00A9
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Sep 2013 13:13:57 +1000 (EST)
Message-ID: <5226A3E3.2050308@rftechnology.com.au>
Date: Wed, 04 Sep 2013 13:07:15 +1000
From: Jason Rennie <jason.rennie@rftechnology.com.au>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Power PC Build problem
Content-Type: multipart/alternative;
 boundary="------------000207050204040700070604"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000207050204040700070604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi everyone,

I apologise if the question is inappropriate for this list but here goes.

I'm using buildroot to build for an APC8272ADS (PPC 603e) chip with 
Intel/Sharp Memory chips on board. I have an old build of the kernel 
(2.6.18) that does appear to work correctly the relevant portion is
------
Serial: CPM driver $Revision: 0.02 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
physmap platform flash device: 01000000 at ff000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
  Intel/Sharp Extended Query Table at 0x010A
  Intel/Sharp Extended Query Table at 0x010A
  Intel/Sharp Extended Query Table at 0x010A
  Intel/Sharp Extended Query Table at 0x010A
  Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x8000,blocks=4
erase region 1: offset=0x20000,size=0x20000,blocks=127
3 cmdlinepart partitions found on MTD device physmap-flash.0
Creating 3 MTD partitions on "physmap-flash.0":
0x00000000-0x00080000 : "U-Boot"
0x00080000-0x00180000 : "Linux"
0x00180000-0x01000000 : "root"
eth0: FCC ENET Version 0.3, de:ad:be:ef:12:34
-------

But when I try building it with the latest buildroot (2013.08) and I 
configure the kernel (3.10.10) I get one of two things. If I don't 
include specific settings for physmap compat support (Device Drivers -> 
MTD Support -> Mapping drivers for chip access) then I get a kernel 
panic when it can't mount the root filesystem as follows
-----------

Linux/PowerPC load: console=ttyCPM0,115200 root=31:02 rw 
rootfstype=jffs2 init=s 
mtdparts=physmap-flash.0:512k(U-Boot),3072k(Linux),-(root) 
ip=192.168.1.231:192.168.1.148::255.255.255.0:eclipse:eth0:on panic=1
Finalizing device tree... flat tree at 0x7f9420
Using Freescale MPC8272 ADS machine description
Linux version 3.10.10 (jason@piDevel) (gcc version 4.7.3 (Buildroot 
2013.08) ) #13 PREEMPT Wed Sep 4 10:47:47 EST 2013
PCI host bridge /pci@f0010800 (primary) ranges:
  MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000 Prefetch
  MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000
   IO 0x00000000f6000000..0x00000000f7ffffff -> 0x0000000000000000
Zone ranges:
   DMA      [mem 0x00000000-0x03ffffff]
   Normal   empty
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x00000000-0x03ffffff]
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyCPM0,115200 root=31:02 rw 
rootfstype=jffs2 init=s 
mtdparts=physmap-flash.0:512k(U-Boot),3072k(Linux),-(root) 
ip=192.168.1.231:192.168.1.148::255.255.255.0:eclipse:eth0:on panic=1
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Sorting __ex_table...
Memory: 60880k/65536k available (3760k kernel code, 4656k reserved, 144k 
data, 85k bss, 160k init)
Kernel virtual memory layout:
   * 0xfffdf000..0xfffff000  : fixmap
   * 0xfcfb4000..0xfe000000  : early ioremap
   * 0xc5000000..0xfcfb4000  : vmalloc & ioremap
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
NR_IRQS:512 nr_irqs:512 16
clocksource: timebase mult[3c9b26ca] shift[24] registered
console [ttyCPM0] enabled
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
devtmpfs: initialized
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xffffff]
pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff pref]
pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
Can't get bus-range for /pci@f0010800, assuming it starts at 0
bio: create slab <bio-0> at 0
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
<giometti@linux.it>
PTP clock support registered
Switching to clocksource timebase
NET: Registered protocol family 2
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
msgmni has been set to 118
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
f0011a00.serial: ttyCPM0 at MMIO 0xc505ea00 (irq = 40) is a CPM UART
f0011a60.serial: ttyCPM1 at MMIO 0xc5060a60 (irq = 43) is a CPM UART
brd: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
eth0: fs_enet: de:ad:be:ef:01:d7
eth1: fs_enet: 00:00:00:00:00:00
libphy: CPM2 Bitbanged MII: probed
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
IP-Config: Complete:
      device=eth0, hwaddr=de:ad:be:ef:01:d7, ipaddr=192.168.1.231, 
mask=255.255.255.0, gw=255.255.255.255
      host=eclipse, domain=, nis-domain=(none)
      bootserver=192.168.1.148, rootserver=192.168.1.148, rootpath=
VFS: Cannot open root device "31:02" or unknown-block(31,2): error -19
Please append a correct "root=" boot option; here are the available 
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(31,2)
Rebooting in 1 seconds..

-----------
and when I do include the physmap settings

<*> Flash device in physical memory map
  [*]   Physmap compat support
   (0xFF000000) Physical start address of flash mapping
   (0x1000000) Physical length of flash mapping
   (2)     Bank width in octets

which I took from the earlier build and do seem to be right, it does the 
following.
--------------------
f0011a00.serial: ttyCPM0 at MMIO 0xc505ea00 (irq = 40) is a CPM UART
f0011a60.serial: ttyCPM1 at MMIO 0xc5060a60 (irq = 43) is a CPM UART
brd: module loaded
physmap platform flash device: 01000000 at ff000000
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
PREEMPT Freescale MPC8272 ADS
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.10 #12
task: c3830000 ti: c3832000 task.ti: c3832000
NIP: c01a5da8 LR: c01a6200 CTR: c01a60cc
REGS: c3833c00 TRAP: 0200   Not tainted  (3.10.10)
MSR: 00049030 <EE,ME,IR,DR>  CR: 22000022  XER: 00000000

GPR00: c01a59a0 c3833cb0 c3830000 00000000 c39c0e24 c3833cf8 00000002 
00000aaa
GPR08: c5080000 0000aaaa 00000002 00000002 42000024 00000000 c000406c 
00000000
GPR16: 00000000 00000000 c39c0e24 c02c9ff4 00000001 c02c8d30 c02c9fe8 
c0356e23
GPR24: c02c8d78 00000001 00000000 00000001 c03b89d8 00000000 c39c0e24 
c3833cf8
NIP [c01a5da8] jedec_reset+0x124/0x448
LR [c01a6200] jedec_probe_chip+0x134/0x1050
Call Trace:
[c3833cb0] [c002d900] call_usermodehelper_exec+0x154/0x160 (unreliable)
[c3833cf0] [c01a59a0] mtd_do_chip_probe+0x78/0x34c
[c3833d70] [c01a73a8] physmap_flash_probe+0x1ec/0x30c
[c3833db0] [c01996c8] driver_probe_device+0xb8/0x1f4
[c3833dd0] [c0197a64] bus_for_each_drv+0x60/0xa8
[c3833e00] [c01995d8] device_attach+0x7c/0x94
[c3833e20] [c0198ac4] bus_probe_device+0x34/0xac
[c3833e40] [c0196f94] device_add+0x3d4/0x570
[c3833e80] [c019acd0] platform_device_add+0x164/0x1dc
[c3833ea0] [c039a438] physmap_init+0x34/0x50
[c3833ec0] [c0003acc] do_one_initcall+0xdc/0x180
[c3833ef0] [c0386bcc] kernel_init_freeable+0x11c/0x1c0
[c3833f30] [c0004088] kernel_init+0x1c/0xf4
[c3833f40] [c000d3a8] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
5529063e 7d2839ae 48000024 2f8a0002 40be0010 5529043e 7d283b2e 48000010
2f8a0004 409e0324 7d28392e 7c0004ac <81250008> 8105000c 81440018 7d6849d6
---[ end trace 06e97f39189bf8ef ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007

Rebooting in 1 seconds..
--------------------
I assume it is crashing when it tries to probe the flash chips?

I'm at a loss to work out what I am doing wrong here. Can anybody offer 
any pointers?

Jason

--------------000207050204040700070604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-text-flowed" style="font-family: -moz-fixed;
      font-size: 14px;" lang="x-western">Hi everyone,
      <br>
      <br>
      I apologise if the question is inappropriate for this list but
      here goes.
      <br>
      <br>
      I'm using buildroot to build for an APC8272ADS (PPC 603e) chip
      with Intel/Sharp Memory chips on board. I have an old build of the
      kernel (2.6.18) that does appear to work correctly the relevant
      portion is
      <br>
      ------
      <br>
      Serial: CPM driver $Revision: 0.02 $
      <br>
      ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
      <br>
      ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
      <br>
      RAMDISK driver initialized: 16 RAM disks of 32768K size 1024
      blocksize
      <br>
      physmap platform flash device: 01000000 at ff000000
      <br>
      physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
      <br>
      &nbsp;Intel/Sharp Extended Query Table at 0x010A
      <br>
      &nbsp;Intel/Sharp Extended Query Table at 0x010A
      <br>
      &nbsp;Intel/Sharp Extended Query Table at 0x010A
      <br>
      &nbsp;Intel/Sharp Extended Query Table at 0x010A
      <br>
      &nbsp;Intel/Sharp Extended Query Table at 0x010A
      <br>
      Using buffer write method
      <br>
      cfi_cmdset_0001: Erase suspend on write enabled
      <br>
      erase region 0: offset=0x0,size=0x8000,blocks=4
      <br>
      erase region 1: offset=0x20000,size=0x20000,blocks=127
      <br>
      3 cmdlinepart partitions found on MTD device physmap-flash.0
      <br>
      Creating 3 MTD partitions on "physmap-flash.0":
      <br>
      0x00000000-0x00080000 : "U-Boot"
      <br>
      0x00080000-0x00180000 : "Linux"
      <br>
      0x00180000-0x01000000 : "root"
      <br>
      eth0: FCC ENET Version 0.3, de:ad:be:ef:12:34
      <br>
      -------
      <br>
      <br>
      But when I try building it with the latest buildroot (2013.08) and
      I configure the kernel (3.10.10) I get one of two things. If I
      don't include specific settings for physmap compat support (Device
      Drivers -&gt; MTD Support -&gt; Mapping drivers for chip access)
      then I get a kernel panic when it can't mount the root filesystem
      as follows
      <br>
      -----------
      <br>
      <br>
      Linux/PowerPC load: console=ttyCPM0,115200 root=31:02 rw
      rootfstype=jffs2 init=s
      mtdparts=physmap-flash.0:512k(U-Boot),3072k(Linux),-(root)
      ip=192.168.1.231:192.168.1.148::255.255.255.0:eclipse:eth0:on
      panic=1
      <br>
      Finalizing device tree... flat tree at 0x7f9420
      <br>
      Using Freescale MPC8272 ADS machine description
      <br>
      Linux version 3.10.10 (jason@piDevel) (gcc version 4.7.3
      (Buildroot 2013.08) ) #13 PREEMPT Wed Sep 4 10:47:47 EST 2013
      <br>
      PCI host bridge /pci@f0010800 (primary) ranges:
      <br>
      &nbsp;MEM 0x0000000080000000..0x000000009fffffff -&gt;
      0x0000000080000000 Prefetch
      <br>
      &nbsp;MEM 0x00000000a0000000..0x00000000bfffffff -&gt;
      0x00000000a0000000
      <br>
      &nbsp; IO 0x00000000f6000000..0x00000000f7ffffff -&gt;
      0x0000000000000000
      <br>
      Zone ranges:
      <br>
      &nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [mem 0x00000000-0x03ffffff]
      <br>
      &nbsp; Normal&nbsp;&nbsp; empty
      <br>
      Movable zone start for each node
      <br>
      Early memory node ranges
      <br>
      &nbsp; node&nbsp;&nbsp; 0: [mem 0x00000000-0x03ffffff]
      <br>
      Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total
      pages: 16256
      <br>
      Kernel command line: console=ttyCPM0,115200 root=31:02 rw
      rootfstype=jffs2 init=s
      mtdparts=physmap-flash.0:512k(U-Boot),3072k(Linux),-(root)
      ip=192.168.1.231:192.168.1.148::255.255.255.0:eclipse:eth0:on
      panic=1
      <br>
      PID hash table entries: 256 (order: -2, 1024 bytes)
      <br>
      Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
      <br>
      Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
      <br>
      Sorting __ex_table...
      <br>
      Memory: 60880k/65536k available (3760k kernel code, 4656k
      reserved, 144k data, 85k bss, 160k init)
      <br>
      Kernel virtual memory layout:
      <br>
      &nbsp; * 0xfffdf000..0xfffff000&nbsp; : fixmap
      <br>
      &nbsp; * 0xfcfb4000..0xfe000000&nbsp; : early ioremap
      <br>
      &nbsp; * 0xc5000000..0xfcfb4000&nbsp; : vmalloc &amp; ioremap
      <br>
      SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
      <br>
      Preemptible hierarchical RCU implementation.
      <br>
      NR_IRQS:512 nr_irqs:512 16
      <br>
      clocksource: timebase mult[3c9b26ca] shift[24] registered
      <br>
      console [ttyCPM0] enabled
      <br>
      pid_max: default: 32768 minimum: 301
      <br>
      Mount-cache hash table entries: 512
      <br>
      devtmpfs: initialized
      <br>
      NET: Registered protocol family 16
      <br>
      PCI: Probing PCI hardware
      <br>
      PCI host bridge to bus 0000:00
      <br>
      pci_bus 0000:00: root bus resource [io&nbsp; 0x0000-0xffffff]
      <br>
      pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff
      pref]
      <br>
      pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff]
      <br>
      pci_bus 0000:00: root bus resource [bus 00-ff]
      <br>
      Can't get bus-range for /pci@f0010800, assuming it starts at 0
      <br>
      bio: create slab &lt;bio-0&gt; at 0
      <br>
      pps_core: LinuxPPS API ver. 1 registered
      <br>
      pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
      Giometti <a class="moz-txt-link-rfc2396E"
        href="mailto:giometti@linux.it">&lt;giometti@linux.it&gt;</a>
      <br>
      PTP clock support registered
      <br>
      Switching to clocksource timebase
      <br>
      NET: Registered protocol family 2
      <br>
      TCP established hash table entries: 512 (order: 0, 4096 bytes)
      <br>
      TCP bind hash table entries: 512 (order: -1, 2048 bytes)
      <br>
      TCP: Hash tables configured (established 512 bind 512)
      <br>
      TCP: reno registered
      <br>
      UDP hash table entries: 256 (order: 0, 4096 bytes)
      <br>
      UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
      <br>
      NET: Registered protocol family 1
      <br>
      RPC: Registered named UNIX socket transport module.
      <br>
      RPC: Registered udp transport module.
      <br>
      RPC: Registered tcp transport module.
      <br>
      RPC: Registered tcp NFSv4.1 backchannel transport module.
      <br>
      jffs2: version 2.2. (NAND) (SUMMARY)&nbsp; &Acirc;&copy; 2001-2006 Red Hat, Inc.
      <br>
      msgmni has been set to 118
      <br>
      Block layer SCSI generic (bsg) driver version 0.4 loaded (major
      252)
      <br>
      io scheduler noop registered
      <br>
      io scheduler deadline registered
      <br>
      io scheduler cfq registered (default)
      <br>
      f0011a00.serial: ttyCPM0 at MMIO 0xc505ea00 (irq = 40) is a CPM
      UART
      <br>
      f0011a60.serial: ttyCPM1 at MMIO 0xc5060a60 (irq = 43) is a CPM
      UART
      <br>
      brd: module loaded
      <br>
      tun: Universal TUN/TAP device driver, 1.6
      <br>
      tun: (C) 1999-2004 Max Krasnyansky <a
        class="moz-txt-link-rfc2396E" href="mailto:maxk@qualcomm.com">&lt;maxk@qualcomm.com&gt;</a>
      <br>
      eth0: fs_enet: de:ad:be:ef:01:d7
      <br>
      eth1: fs_enet: 00:00:00:00:00:00
      <br>
      libphy: CPM2 Bitbanged MII: probed
      <br>
      TCP: cubic registered
      <br>
      NET: Registered protocol family 10
      <br>
      sit: IPv6 over IPv4 tunneling driver
      <br>
      NET: Registered protocol family 17
      <br>
      IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
      <br>
      IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
      <br>
      IP-Config: Complete:
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp; device=eth0, hwaddr=de:ad:be:ef:01:d7, ipaddr=192.168.1.231,
      mask=255.255.255.0, gw=255.255.255.255
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp; host=eclipse, domain=, nis-domain=(none)
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp; bootserver=192.168.1.148, rootserver=192.168.1.148, rootpath=
      <br>
      VFS: Cannot open root device "31:02" or unknown-block(31,2): error
      -19
      <br>
      Please append a correct "root=" boot option; here are the
      available partitions:
      <br>
      Kernel panic - not syncing: VFS: Unable to mount root fs on
      unknown-block(31,2)
      <br>
      Rebooting in 1 seconds..
      <br>
      <br>
      -----------
      <br>
      and when I do include the physmap settings
      <br>
      <br>
      &lt;*&gt; Flash device in physical memory map
      <br>
      &nbsp;[*]&nbsp;&nbsp; Physmap compat support
      <br>
      &nbsp; (0xFF000000) Physical start address of flash mapping
      <br>
      &nbsp; (0x1000000) Physical length of flash mapping
      <br>
      &nbsp; (2)&nbsp;&nbsp;&nbsp;&nbsp; Bank width in octets
      <br>
      <br>
      which I took from the earlier build and do seem to be right, it
      does the following.
      <br>
      --------------------
      <br>
      f0011a00.serial: ttyCPM0 at MMIO 0xc505ea00 (irq = 40) is a CPM
      UART
      <br>
      f0011a60.serial: ttyCPM1 at MMIO 0xc5060a60 (irq = 43) is a CPM
      UART
      <br>
      brd: module loaded
      <br>
      physmap platform flash device: 01000000 at ff000000
      <br>
      Machine check in kernel mode.
      <br>
      Caused by (from SRR1=49030): Transfer error ack signal
      <br>
      Oops: Machine check, sig: 7 [#1]
      <br>
      PREEMPT Freescale MPC8272 ADS
      <br>
      Modules linked in:
      <br>
      CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.10 #12
      <br>
      task: c3830000 ti: c3832000 task.ti: c3832000
      <br>
      NIP: c01a5da8 LR: c01a6200 CTR: c01a60cc
      <br>
      REGS: c3833c00 TRAP: 0200&nbsp;&nbsp; Not tainted&nbsp; (3.10.10)
      <br>
      MSR: 00049030 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 22000022&nbsp; XER: 00000000
      <br>
      <br>
      GPR00: c01a59a0 c3833cb0 c3830000 00000000 c39c0e24 c3833cf8
      00000002 00000aaa
      <br>
      GPR08: c5080000 0000aaaa 00000002 00000002 42000024 00000000
      c000406c 00000000
      <br>
      GPR16: 00000000 00000000 c39c0e24 c02c9ff4 00000001 c02c8d30
      c02c9fe8 c0356e23
      <br>
      GPR24: c02c8d78 00000001 00000000 00000001 c03b89d8 00000000
      c39c0e24 c3833cf8
      <br>
      NIP [c01a5da8] jedec_reset+0x124/0x448
      <br>
      LR [c01a6200] jedec_probe_chip+0x134/0x1050
      <br>
      Call Trace:
      <br>
      [c3833cb0] [c002d900] call_usermodehelper_exec+0x154/0x160
      (unreliable)
      <br>
      [c3833cf0] [c01a59a0] mtd_do_chip_probe+0x78/0x34c
      <br>
      [c3833d70] [c01a73a8] physmap_flash_probe+0x1ec/0x30c
      <br>
      [c3833db0] [c01996c8] driver_probe_device+0xb8/0x1f4
      <br>
      [c3833dd0] [c0197a64] bus_for_each_drv+0x60/0xa8
      <br>
      [c3833e00] [c01995d8] device_attach+0x7c/0x94
      <br>
      [c3833e20] [c0198ac4] bus_probe_device+0x34/0xac
      <br>
      [c3833e40] [c0196f94] device_add+0x3d4/0x570
      <br>
      [c3833e80] [c019acd0] platform_device_add+0x164/0x1dc
      <br>
      [c3833ea0] [c039a438] physmap_init+0x34/0x50
      <br>
      [c3833ec0] [c0003acc] do_one_initcall+0xdc/0x180
      <br>
      [c3833ef0] [c0386bcc] kernel_init_freeable+0x11c/0x1c0
      <br>
      [c3833f30] [c0004088] kernel_init+0x1c/0xf4
      <br>
      [c3833f40] [c000d3a8] ret_from_kernel_thread+0x5c/0x64
      <br>
      Instruction dump:
      <br>
      5529063e 7d2839ae 48000024 2f8a0002 40be0010 5529043e 7d283b2e
      48000010
      <br>
      2f8a0004 409e0324 7d28392e 7c0004ac &lt;81250008&gt; 8105000c
      81440018 7d6849d6
      <br>
      ---[ end trace 06e97f39189bf8ef ]---
      <br>
      <br>
      Kernel panic - not syncing: Attempted to kill init!
      exitcode=0x00000007
      <br>
      <br>
      Rebooting in 1 seconds..
      <br>
      --------------------
      <br>
      I assume it is crashing when it tries to probe the flash chips?
      <br>
      <br>
      I'm at a loss to work out what I am doing wrong here. Can anybody
      offer any pointers?
      <br>
      <br>
      Jason
      <br>
    </div>
  </body>
</html>

--------------000207050204040700070604--
