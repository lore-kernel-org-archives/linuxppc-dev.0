Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 3EF87DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 08:26:24 +1100 (EST)
Message-ID: <49D28A7E.2090703@mlbassoc.com>
Date: Tue, 31 Mar 2009 15:26:22 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: MPC83xx console : no output after handover
References: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>	<49D280E0.9020701@mlbassoc.com>
	<5ee96a840903311403r331943d2wf9dbb16491f6bc3@mail.gmail.com>
In-Reply-To: <5ee96a840903311403r331943d2wf9dbb16491f6bc3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthew L. Creech wrote:
> On Tue, Mar 31, 2009 at 4:45 PM, Gary Thomas <gary@mlbassoc.com> wrote:
>> What does your command line (boot args) when it fails?  It should
>> probably have something like "console=ttyS0,115200" in it.
>>
> 
> Yes, that's what I'm using.  It also seems to be the default if none
> is supplied.
> 
> For the sake of completeness, here's a full dump:
> 
> ============
> Using MPC831x RDB machine description
> Linux version 2.6.29 (mlcreech@lap) (gcc version 4.3.2 (Sourcery G++ Lite 4.3-50
> ) ) #3 PREEMPT Tue Mar 31 15:10:02 EDT 2009
> console [udbg0] enabled
> setup_arch: bootmem
> mpc831x_rdb_setup_arch()
> arch: exit
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00008000
>   Normal   0x00008000 -> 0x00008000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x00008000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
> Kernel command line: root=/dev/mtdblock1 init=/bin/sh console=ttyS0,115200
> IPIC (128 IRQ sources) at fdffd700
> PID hash table entries: 512 (order: 9, 2048 bytes)
> clocksource: timebase mult[7800001] shift[22] registered
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 126236k/131072k available (3260k kernel code, 4692k reserved, 136k data,
>  98k bss, 160k init)
> SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Calibrating delay loop... 66.30 BogoMIPS (lpj=33152)
> Mount-cache hash table entries: 512
> net_namespace: 708 bytes
> NET: Registered protocol family 16
> 
> bio: create slab <bio-0> at 0
> Freescale Elo / Elo Plus DMA driver
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP reno registered
> NET: Registered protocol family 1
> WDT driver for MPC8xxx initialized. mode:reset timeout=65535 (32 seconds)
> fsl-elo-dma e00082a8.dma: Probe the Freescale DMA driver for fsl,elo-dma control
> ler at e00082a8...
> fsl-elo-dma e00082a8.dma: #0 (fsl,elo-dma-channel), irq 71
> fsl-elo-dma e00082a8.dma: #1 (fsl,elo-dma-channel), irq 71
> fsl-elo-dma e00082a8.dma: #2 (fsl,elo-dma-channel), irq 71
> fsl-elo-dma e00082a8.dma: #3 (fsl,elo-dma-channel), irq 71
> squashfs: version 4.0 (2009/01/31) Phillip Lougher
> Registering unionfs 2.5.1 (for 2.6.29-rc2)
> yaffs Mar 31 2009 02:31:59 Installing.
> msgmni has been set to 246
> alg: No test for stdrng (krng)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered (default)
> io scheduler cfq registered
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
> console handover: boot [udbg0] -> real [ttyS0]
> serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
> ============

The fact that you get the ttyS1 line printed is interesting.  At
this point, the kernel is switching from raw console I/O (only
suitable for bring-up messages) to the general serial driver
(interrupt driven, etc).  I'm curious about what the ttyS1 driver
is causing to break...

A couple of things you could try:
  * Disable ttyS1 (take it out of your device tree)
  * Look at the console log when this happens.  Look in your system
    map for the symbol '__log_buf', e.g.
       c031ca54 b __log_buf
    This will get stored at physical location '0x31ca54' and will
    often contain data that didn't get a chance to print, for example
    if you have stuck interrupts that prevent the console from working.
    I'd just run it to this point and then examine the memory - either
    using a BDI if one is attached, or press RESET (I hope you have one!)
    and then look using your boot loader (uBoot, RedBoot, ...)



-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
