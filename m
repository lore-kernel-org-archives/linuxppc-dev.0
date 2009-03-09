Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FC7CDE034
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 04:55:56 +1100 (EST)
Date: Mon, 9 Mar 2009 17:46:22 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: 2.6.29-rc7-git2 : crash in kmem_list3_init()
Message-ID: <20090309174622.GB31585@csn.ul.ie>
References: <49B5448B.6030205@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <49B5448B.6030205@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cl@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 09, 2009 at 10:02:11PM +0530, Sachin P. Sant wrote:
> While trying to boot 2.6.29-rc7-git2 on a power5 box ran into
> following crash.
>
> Unable to handle kernel paging request for data at address 0xc000000070001008
> Faulting instruction address: 0xc000000000119070
> cpu 0x0: Vector: 300 (Data Access) at [c000000000ac3980]
>    pc: c000000000119070: .kmem_list3_init+0x68/0x8c
>    lr: c00000000011906c: .kmem_list3_init+0x64/0x8c
>    sp: c000000000ac3c00
>   msr: 8000000000009032
>   dar: c000000070001008
> dsisr: 42000000
>  current = 0xc0000000009ea610
>  paca    = 0xc000000000b43480
>    pid   = 0, comm = swapper
> enter ? for help
> [c000000000ac3c90] c00000000068b788 .setup_cpu_cache+0xf8/0x1e8
> [c000000000ac3d20] c00000000011c8a0 .kmem_cache_create+0x43c/0x500
> [c000000000ac3e20] c000000000948c54 .kmem_cache_init+0x284/0x640
> [c000000000ac3ee0] c000000000920a5c .start_kernel+0x360/0x480
> [c000000000ac3f90] c0000000000083d8 .start_here_common+0x1c/0x44
>
> Attached here is the dmesg log with loglevel=8 mminit_loglevel=4
> as well as .config used.
>
> Tried to boot a kernel.org kernel on this box for first time so not
> sure if this is a new problem or a recurring one. Will try booting
> some older kernels on this box and will report the results.
>
> Node 0 Memory: 0x8000000-0x3a000000
> Node 1 Memory: 0x0-0x8000000 0x3a000000-0x72000000
> PCI host bridge /pci@800000020000003  ranges:
>   IO 0x000003fe00700000..0x000003fe007fffff -> 0x0000000000000000
>  MEM 0x00000401c0000000..0x00000401ffffffff -> 0x00000000c0000000 
> EEH: PCI Enhanced I/O Error Handling Enabled
> PPC64 nvram contains 7168 bytes
> Using shared processor idle loop
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00007200
>   Normal   0x00007200 -> 0x00007200
> Movable zone start PFN for each node
> early_node_map[3] active PFN ranges
>     1: 0x00000000 -> 0x00000800
>     0: 0x00000800 -> 0x00003a00
>     1: 0x00003a00 -> 0x00007200

What's interesting about this machine is that the nodes are interleaving. It's
possible someone is double initialising incorrectly.

> mminit::pageflags_layout_widths Section 0 Node 4 Zone 2 Flags 22
> mminit::pageflags_layout_shifts Section 20 Node 4 Zone 2
> mminit::pageflags_layout_offsets Section 0 Node 60 Zone 58
> mminit::pageflags_layout_zoneid Zone ID: 58 -> 64
> mminit::pageflags_layout_usage location: 64 -> 58 unused 58 -> 22 flags 22 -> 0
> On node 0 totalpages: 12800
>   DMA zone: 18 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 12782 pages, LIFO batch:1
> mminit::memmap_init Initialising map node 0 zone 0 pfns 2048 -> 14848
> On node 1 totalpages: 16384
>   DMA zone: 40 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 16344 pages, LIFO batch:1
> mminit::memmap_init Initialising map node 1 zone 0 pfns 0 -> 29184

See, the core initialising at least goes over both nodes when
initialising node 1. The page mappings should be ok because this
situation is checked for but it's possible the SLAB allocator is missing
something.

> [boot]0015 Setup Done
> mminit::zonelist general 0:DMA = 0:DMA 1:DMA 
> mminit::zonelist thisnode 0:DMA = 0:DMA 
> mminit::zonelist general 1:DMA = 1:DMA 0:DMA 
> mminit::zonelist thisnode 1:DMA = 1:DMA 
> Built 2 zonelists in Node order, mobility grouping on.  Total pages: 29126
> Policy zone: DMA
> Kernel command line: root=/dev/sda5 quiet sysrq=1 loglevel=8 mminit_loglevel=4 
> [boot]0020 XICS Init
> [boot]0021 XICS Done
> pic: no ISA interrupt controller
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> time_init: decrementer frequency = 207.050000 MHz
> time_init: processor frequency   = 1656.400000 MHz
> clocksource: timebase mult[1351aa5] shift[22] registered
> clockevent: decrementer mult[3501] shift[16] cpu[0]
> Console: colour dummy device 80x25
> console handover: boot [udbg0] -> real [hvc0]
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     8192
> ... MAX_LOCKDEP_CHAINS:      16384
> ... CHAINHASH_SIZE:          8192
>  memory used by lock dependency info: 3839 kB
>  per task-struct memory footprint: 1920 bytes
> Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
> freeing bootmem node 0
> freeing bootmem node 1
> Memory: 1812096k/1867776k available (9792k kernel code, 57856k reserved, 1216k data, 8025k bss, 448k init)
> Unable to handle kernel paging request for data at address 0xc000000070001008

What is meant to be stored at this address 0xc000000070001008? Because the
error occurs aftre freeing bootmem memory, I wonder with the interleaving
node if memory is getting inappropriately freed.

> Faulting instruction address: 0xc000000000119070
> cpu 0x0: Vector: 300 (Data Access) at [c000000000ac3980]
>     pc: c000000000119070: .kmem_list3_init+0x68/0x8c
>     lr: c00000000011906c: .kmem_list3_init+0x64/0x8c
>     sp: c000000000ac3c00
>    msr: 8000000000009032
>    dar: c000000070001008
>  dsisr: 42000000
>   current = 0xc0000000009ea610
>   paca    = 0xc000000000b43480
>     pid   = 0, comm = swapper
> enter ? for help
> [c000000000ac3c90] c00000000068b788 .setup_cpu_cache+0xf8/0x1e8
> [c000000000ac3d20] c00000000011c8a0 .kmem_cache_create+0x43c/0x500
> [c000000000ac3e20] c000000000948c54 .kmem_cache_init+0x284/0x640
> [c000000000ac3ee0] c000000000920a5c .start_kernel+0x360/0x480
> [c000000000ac3f90] c0000000000083d8 .start_here_common+0x1c/0x44
> 0:mon>
> 0:mon> ls .kmem_list3_init
> .kmem_list3_init: c000000000119008
> 0:mon> di c000000000119008
> c000000000119008  7c0802a6      mflr    r0
> c00000000011900c  fb81ffe0      std     r28,-32(r1)
> c000000000119010  fba1ffe8      std     r29,-24(r1)
> c000000000119014  fbc1fff0      std     r30,-16(r1)
> c000000000119018  ebc2b2a0      ld      r30,-19808(r2)
> c00000000011901c  7c7d1b78      mr      r29,r3
> c000000000119020  f8010010      std     r0,16(r1)
> c000000000119024  3b800000      li      r28,0
> c000000000119028  38030010      addi    r0,r3,16
> c00000000011902c  39230020      addi    r9,r3,32
> c000000000119030  f821ff71      stdu    r1,-144(r1)
> c000000000119034  f87d0000      std     r3,0(r29)
> c000000000119038  f8030018      std     r0,24(r3)
> c00000000011903c  e8be8000      ld      r5,-32768(r30)
> c000000000119040  f8030010      std     r0,16(r3)
> c000000000119044  f87d0008      std     r3,8(r29)
> 0:mon> 
> c000000000119048  fb830070      std     r28,112(r3)
> c00000000011904c  fb830078      std     r28,120(r3)
> c000000000119050  9383003c      stw     r28,60(r3)
> c000000000119054  f9230028      std     r9,40(r3)
> c000000000119058  f9230020      std     r9,32(r3)
> c00000000011905c  e89e8100      ld      r4,-32512(r30)
> c000000000119060  38630040      addi    r3,r3,64
> c000000000119064  38a50020      addi    r5,r5,32
> c000000000119068  482b7b3d      bl      c0000000003d0ba4        # .__spin_lock_init+0x0/0x84
> c00000000011906c  60000000      nop
> c000000000119070  939d0088      stw     r28,136(r29) 
> 
> ^^^^^^ fails here
> This probably corresponds to the following line from kmem_list3_init()
> 
> 	parent->free_objects = 0;
> 

If parent is NULL, it would have crashed before this but no worries
about that, it's NULL

> c000000000119074  fb9d0030      std     r28,48(r29)
> c000000000119078  38210090      addi    r1,r1,144
> c00000000011907c  e8010010      ld      r0,16(r1)
> c000000000119080  eb81ffe0      ld      r28,-32(r1)
> c000000000119084  eba1ffe8      ld      r29,-24(r1)
> 0:mon> r
> R00 = c00000000011906c   R16 = 0000000000000000
> R01 = c000000000ac3c00   R17 = c000000000ac3d98
> R02 = c000000000abb3e0   R18 = c000000000ac3d90
> R03 = 0000000000000001   R19 = 0000000000010000
> R04 = c000000000862718   R20 = 0000000000046000
> R05 = c0000000011b99a8   R21 = c000000000862a08
> R06 = 0000000000000000   R22 = 00000000000003f4
> R07 = c000000070000000   R23 = ffffffffffffff80
> R08 = c0000000009ea638   R24 = 0000000000001000
> R09 = ffffffffffffffff   R25 = 0000000000000000
> R10 = 0000000000000002   R26 = 0000000000000f80
> R11 = c0000000009ea638   R27 = 0000000000000080
> R12 = 0000000044022044   R28 = 0000000000000000
> R13 = c000000000b43480   R29 = c000000070000f80
> R14 = c000000000962338   R30 = c000000000a224a8
> R15 = c000000000845d68   R31 = c000000038004200
> pc  = c000000000119070 .kmem_list3_init+0x68/0x8c
> lr  = c00000000011906c .kmem_list3_init+0x64/0x8c
> msr = 8000000000009032   cr  = 44022042
> ctr = 0000000000000000   xer = 000000000000000c   trap =  300
> dar = c000000070001008   dsisr = 42000000
> 0:mon>
> 
