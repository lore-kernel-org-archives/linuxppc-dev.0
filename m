Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id A2B59B6F05
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 19:05:01 +1000 (EST)
Received: by iwn36 with SMTP id 36so6256946iwn.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 02:05:00 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Jul 2010 02:05:00 -0700
Message-ID: <AANLkTik9n_UkLKdmKT7PHiOL1-EW_TlMJFOGvWCU44xb@mail.gmail.com>
Subject: cpm_uart_console_write() stuck in waiting for transmitter fifo ready
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>, galak@kernel.crashing.org,
	panto@intracom.gr, Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gurus,

Please give me some hints and directions to debug this problem. I've
been scratching my head for quite a while.

The problem is that after/when the kernel switches to the real console
from the boot console, printk() calls cpm_uart_console_write() to
print the first (?) message using the cpm_uart driver. But the
transmitter buffer never becomes ready. It's shown below with the gdb
session.

Program received signal SIGSTOP, Stopped (signal).
0xc00f3510 in cpm_uart_console_write (co=3D<value optimized out>,
s=3D0xc017703e "console [ttyCPM0] enabled, bootconsole disabled\n",
count=3D0x30) at /home/code/linux-2.6.33.5/arch/powerpc/include/asm/io.h:15=
4
(gdb) next
(gdb) x/4h bdbase
0xfddfa020:	0xffff	0xffff	0xffff	0xffff
(gdb)

Why would the TxBD be filled with all 0xF? Would it be possible that
the bdbase actually points somewhere else other than the TxBD?

The kernel boot messages are copied below. My target is MPC870, using
SMC1 as UART. I'm porting the kernel based on adder875 board.

=3D> bootm 1000000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    706700 Bytes =3D 690.1 kB
   Load Address: 00400000
   Entry Point:  00400554
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:09:9b:01:58:64
CPU clock-frequency <- 0x7270e00 (120MHz)
CPU timebase-frequency <- 0x7270e0 (8MHz)
CPU bus-frequency <- 0x3938700 (60MHz)

zImage starting: loaded at 0x00400000 (sp: 0x07d1cbd0)
Allocating 0x186be5 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x005c1b78)...done 0x173b10 bytes

Linux/PowerPC load: root=3D/dev/ram
Finalizing device tree... flat tree at 0x5ce300
Probing machine type ...
  My MPC870 ... match !
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using My MPC870 machine description
Linux version 2.6.33.5 (shawn@ubuntu) (gcc version 4.2.2) #17 Wed Jul
14 01:24:03 PDT 2010
bootconsole [udbg0] enabled
setup_arch: bootmem
arch: exit
Top of RAM: 0x8000000, Total RAM: 0x8000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c016b5b0, node_mem_map c0189000
  DMA zone: 256 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 32512 pages, LIFO batch:7
MMU: Allocated 72 bytes of context maps for 16 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=3D/dev/ram
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128096k/131072k available (1416k kernel code, 2836k reserved,
72k data, 74k bss, 76k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfde00000..0xfe000000  : consistent mem
  * 0xfddfa000..0xfde00000  : early ioremap
  * 0xc9000000..0xfddfa000  : vmalloc & ioremap
SLUB: Genslabs=3D12, HWalign=3D16, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
Hierarchical RCU implementation.
NR_IRQS:512 nr_irqs:512
irq: Allocated host of type 2 @0xc7804000
irq: irq_create_mapping(0xc7804000, 0x5)
irq: -> using host @c7804000
  alloc irq_desc for 16 on node 0
  alloc kstat_irqs on node 0
irq: irq 5 on host /soc@fa200000/interrupt-controller@0 mapped to virtual i=
rq 16
irq: Allocated host of type 2 @0xc7804200
irq: irq_create_mapping(0xc7804200, 0x0)
irq: -> using host @c7804200
  alloc irq_desc for 17 on node 0
  alloc kstat_irqs on node 0
irq: irq 0 on host /soc@fa200000/cpm@9c0/interrupt-controller@930
mapped to virtual irq 17
Decrementer Frequency =3D 0x7270e0
irq: irq_create_mapping(0xc7804000, 0xf)
irq: -> using host @c7804000
  alloc irq_desc for 18 on node 0
  alloc kstat_irqs on node 0
irq: irq 15 on host /soc@fa200000/interrupt-controller@0 mapped to
virtual irq 18
time_init: decrementer frequency =3D 7.500000 MHz
time_init: processor frequency   =3D 120.000000 MHz
clocksource: timebase mult[21555555] shift[22] registered
clockevent: decrementer mult[1eb851e] shift[32] cpu[0]
irq: irq_create_mapping(0xc7804200, 0x4)
irq: -> using host @c7804200
  alloc irq_desc for 19 on node 0
  alloc kstat_irqs on node 0
irq: irq 4 on host /soc@fa200000/cpm@9c0/interrupt-controller@930
mapped to virtual irq 1=EF=BF=BD

Thanks a lot,
-Shawn.
