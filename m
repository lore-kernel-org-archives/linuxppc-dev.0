Return-Path: <kl@jasmine.eu.org>
Received: from riddly.domek.prywatny (arz222.internetdsl.tpnet.pl
	[83.17.211.222]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26B23679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Aug 2006 09:35:21 +1000 (EST)
Received: from karol by riddly.domek.prywatny with local (Exim 4.50)
	id 1G83lc-0000aS-D7
	for linuxppc-embedded@ozlabs.org; Wed, 02 Aug 2006 01:35:16 +0200
Date: Wed, 2 Aug 2006 01:35:16 +0200
From: Karol Lewandowski <kl@jasmine.eu.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [BUG] ibm_emac: kernel panic with CONFIG_SLOB=y
Message-ID: <20060801233516.GC1754@riddly.domek.prywatny>
References: <20060801204011.GB1754@riddly.domek.prywatny>
	<20060801221342.GA13171@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060801221342.GA13171@gate.ebshome.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 01, 2006 at 03:13:42PM -0700, Eugene Surovegin wrote:
> On Tue, Aug 01, 2006 at 10:40:11PM +0200, Karol Lewandowski wrote:
> > Hi,
> > 
> > I'm getting reproductible kernel panic when I use smaller SLOB
> > allocator (instead of SLAB).  This is reproductible but very randomly
> > -- sometimes it happens during bootup, sometimes few minutes later.
> > 
> > Hardware is custom board with IBM405EP (very close to Bubingna, just
> > no RTC):
> > 
> > # cat /proc/cpuinfo
> > processor	: 0
> > cpu		: 405EP
> > clock		: 200MHz
> > revision	: 9.80 (pvr 5121 0950)
> > bogomips	: 199.47
> > machine		: MagicBox
> > plb bus clock	: 100MHz
> > pci bus clock	: 25MHz
> > 
> > Enabling SLAB instead of SLOB fixes this, so I assume this is driver
> > issue.
> 
> This is probably the same issue  I had with SLAB debugging.

With SLAB debugging I get oops even faster:

Linux version 2.6.17-magicbox2 (builder@riddly) (gcc version 3.4.5) #3 Wed Aug 2 01:14:21 CEST 2006
MagicBox port (C) 2005 Karol Lewandowski <kl@jasmine.eu.org>
Built 1 zonelists
Kernel command line: console=ttyS0,115200 root=/dev/ram rw
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28252k available (1560k kernel code, 508k data, 104k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 2020k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
squashfs: version 3.0 (2006/03/15) Phillip Lougher
Initializing Cryptographic API
io scheduler noop registered (default)
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
RAMDISK driver initialized: 4 RAM disks of 8192K size 1024 blocksize
PPC 4xx OCP EMAC driver, version 3.54
mal0: initialized, 4 TX channels, 2 RX channels
eth0: emac0, MAC 00:50:c2:1e:af:fe
eth0: found Generic MII PHY (0x00)
emac1: reset timeout
emac1: can't find PHY!
slab error in cache_free_debugcheck(): cache `size-2048': double free, or memory outside object was overwritten
Call Trace:
[C1D95DC0] [C0009988] show_stack+0x58/0x180 (unreliable)
[C1D95DF0] [C004E92C] __slab_error+0x2c/0x3c
[C1D95E00] [C004F0BC] cache_free_debugcheck+0x150/0x2a8
[C1D95E30] [C004FDC0] kfree+0x74/0xf0
[C1D95E50] [C01FAB40] emac_probe+0x6a0/0x6b8
[C1D95E90] [C000C884] ocp_device_probe+0x38/0x60
[C1D95EA0] [C00CEAD8] driver_probe_device+0x64/0x108
[C1D95EC0] [C00CECA8] __driver_attach+0x80/0xe4
[C1D95EE0] [C00CDE30] bus_for_each_dev+0x54/0x94
[C1D95F10] [C00CED30] driver_attach+0x24/0x34
[C1D95F20] [C00CE424] bus_add_driver+0x74/0x148
[C1D95F40] [C00CF2C0] driver_register+0xa4/0xb8
[C1D95F70] [C000C9D8] ocp_register_driver+0x28/0x38
[C1D95F80] [C01FAB90] emac_init+0x38/0x6c
[C1D95F90] [C0002440] init+0xa4/0x27c
[C1D95FF0] [C0005054] kernel_thread+0x44/0x60
c1dc60bc: redzone 1:0x0, redzone 2:0x0.
kernel BUG in cache_free_debugcheck at mm/slab.c:2640!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C004F16C LR: C004F130 CTR: 00000000
REGS: c1d95d50 TRAP: 0700   Not tainted  (2.6.17-magicbox2)
MSR: 00021030 <ME,IR,DR>  CR: 44004022  XER: 20000000
TASK = c1d93ae0[1] 'swapper' THREAD: c1d94000
GPR00: 00000001 C1D95E00 C1D93AE0 C1DC68C4 C1DC68C8 FFFFFFFF C00CC0C4 C01C0000 
GPR08: C01C0DBF 0000001B C021536C 0000001C 00000000 00000000 01FFC700 00000000 
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 01FF609C 00000000 00000003 C1DC63A8 
GPR24: C0223A80 C01FAB40 C0200000 C1DC6080 00000000 5A2CF071 C1DC60BC C0222A80 
NIP [C004F16C] cache_free_debugcheck+0x200/0x2a8
LR [C004F130] cache_free_debugcheck+0x1c4/0x2a8
Call Trace:
[C1D95E00] [C004F100] cache_free_debugcheck+0x194/0x2a8 (unreliable)
[C1D95E30] [C004FDC0] kfree+0x74/0xf0
[C1D95E50] [C01FAB40] emac_probe+0x6a0/0x6b8
[C1D95E90] [C000C884] ocp_device_probe+0x38/0x60
[C1D95EA0] [C00CEAD8] driver_probe_device+0x64/0x108
[C1D95EC0] [C00CECA8] __driver_attach+0x80/0xe4
[C1D95EE0] [C00CDE30] bus_for_each_dev+0x54/0x94
[C1D95F10] [C00CED30] driver_attach+0x24/0x34
[C1D95F20] [C00CE424] bus_add_driver+0x74/0x148
[C1D95F40] [C00CF2C0] driver_register+0xa4/0xb8
[C1D95F70] [C000C9D8] ocp_register_driver+0x28/0x38
[C1D95F80] [C01FAB90] emac_init+0x38/0x6c
[C1D95F90] [C0002440] init+0xa4/0x27c
[C1D95FF0] [C0005054] kernel_thread+0x44/0x60
Instruction dump:
7c0bf050 7f804b96 801f001c 7c00e010 38000000 7c000114 0f000000 7d29e1d6 
7d6b4a14 7fcb5a78 312bffff 7c095910 <0f000000> 801f0018 700b0200 41a20024 
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..

 
> In short, those allocators aren't compatible with non-coherent cache 
> archs (like 4xx), because driver assumes at least L1 cache line 
> alignment for all allocated memory.
> 
> For more info, you can read this post:
> 
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-February/022087.html

This is all black magic for me, all I can do is to suggest blacklisting
these features on certain archs, i.e. adjusting Kconfigs:

--- kernel-2.6-2.6.17-magicbox2/init/Kconfig.orig	2006-08-02 01:24:04.000000000 +0200
+++ kernel-2.6-2.6.17-magicbox2/init/Kconfig	2006-08-02 01:25:49.000000000 +0200
@@ -367,7 +367,7 @@
 
 config SLAB
 	default y
-	bool "Use full SLAB allocator" if EMBEDDED
+	bool "Use full SLAB allocator" if (EMBEDDED && !4xx)
 	help
 	  Disabling this replaces the advanced SLAB allocator and
 	  kmalloc support with the drastically simpler SLOB allocator.


... and doing something like that for every architecture without
coherent cache (and SLAB debugging).

I'm not that sure that it's good way to go, though.

thanks
-- 
This signature intentionally says nothing.
