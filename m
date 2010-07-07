Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id AF18EB6EF3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jul 2010 10:17:17 +1000 (EST)
Received: by iwn36 with SMTP id 36so6414179iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jul 2010 17:17:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100706181811.4542df5a@schlenkerla.am.freescale.net>
References: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
	<20100706152110.4f25e96b@schlenkerla.am.freescale.net>
	<AANLkTikNgYy9aAUAe9wTsNKDg3cNokSTVJ_6aA6n3SI9@mail.gmail.com>
	<20100706181811.4542df5a@schlenkerla.am.freescale.net>
Date: Tue, 6 Jul 2010 17:17:16 -0700
Message-ID: <AANLkTimUxcsTMXNPOFfJxybp8u7Wv7Mt_nhW1EE01RqG@mail.gmail.com>
Subject: Re: kernel boot stuck at udbg_putc_cpm()
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> That was it. The value @0xfa203bf8 is 0x20000001. The kernel certainly
>> moved forward till it stuck at the new place cpm_uart_initbd() as
>> shown below.
>
> Do you get any output from the serial port? =A0I'd have expected
> something by the time you get to cpm_uart_initbd() -- in fact, the
> early output will have been shut down by then to make room for the real
> serial driver.

Nothing new on the serial port. :-( Is the interrupt enabled during
the early debug stage? I'm not sure if the interrupt controller is set
properly in DTS. The same MPC875 settings are copied from the
adder875-uboot.dts.

    Memory <- <0x0 0x8000000> (128MB)
    ENET0: local-mac-address <- 00:09:9b:01:58:64
    CPU clock-frequency <- 0x7270e00 (120MHz)
    CPU timebase-frequency <- 0x393870 (4MHz)
    CPU bus-frequency <- 0x3938700 (60MHz)

    zImage starting: loaded at 0x00400000 (sp: 0x07d1ccd0)
    Allocating 0x186bdd bytes for kernel ...
    gunzipping (0x00000000 <- 0x0040c000:0x00591c30)...done 0x173b18 bytes

    Linux/PowerPC load: root=3D/dev/ram
    Finalizing device tree... flat tree at 0x59e300

Here is the kernel log buf dump. Anything suspicious?

<6>Using My MPC870 machine description
<5>Linux version 2.6.33.5 (shawn@ubuntu) (gcc version 4.3.3 (GCC) )
#10 Mon Jul 5 22:58:30 PDT 2010
<7>Top of RAM: 0x8000000, Total RAM: 0x8000000
<7>Memory hole size: 0MB
<4>Zone PFN ranges:
<4>  DMA      0x00000000 -> 0x00008000
<4>  Normal   0x00008000 -> 0x00008000
<4>Movable zone start PFN for each node
<4>early_node_map[1] active PFN ranges
<4>    0: 0x00000000 -> 0x00008000
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c016c5b0, node_mem_map c0189000
<7>  DMA zone: 256 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 32512 pages, LIFO batch:7
<6>MMU: Allocated 72 bytes of context maps for 16 contexts
<4>Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 325=
12
<5>Kernel command line: root=3D/dev/ram
<6>PID hash table entries: 512 (order: -1, 2048 bytes)
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128096k/131072k available (1420k kernel code, 2836k
reserved, 68k data, 74k bss, 76k init)
<6>Kernel virtual memory layout:
<6>  * 0xfffdf000..0xfffff000  : fixmap
<6>  * 0xfde00000..0xfe000000  : consistent mem
<6>  * 0xfddfa000..0xfde00000  : early ioremap
<6>  * 0xc9000000..0xfddfa000  : vmalloc & ioremap
<6>SLUB: Genslabs=3D12, HWalign=3D16, Order=3D0-3, MinObjects=3D0, CPUs=3D1=
, Nodes=3D1
<6>Hierarchical RCU implementation.
<6>NR_IRQS:512 nr_irqs:512
<7>  alloc irq_desc for 16 on node 0
<7>  alloc kstat_irqs on node 0
<7>irq: irq 5 on host /soc@fa200000/interrupt-controller@0 mapped to
virtual irq 16
<7>  alloc irq_desc for 17 on node 0
<7>  alloc kstat_irqs on node 0
<7>irq: irq 0 on host /soc@fa200000/cpm@9c0/interrupt-controller@930
mapped to virtual irq 17
<7>time_init: decrementer frequency =3D 3.750000 MHz
<7>time_init: processor frequency   =3D 120.000000 MHz
<6>clocksource: timebase mult[42aaaaab] shift[22] registered
<7>clockevent: decrementer mult[f5c28f] shift[32] cpu[0]
<7>  alloc irq_desc for 18 on node 0
<7>  alloc kstat_irqs on node 0
<7>irq: irq 4 on host /soc@fa200000/cpm@9c0/interrupt-controller@930
mapped to virtual irq 18

Thanks,
-Shawn.
