Return-Path: <tavi@cs.pub.ro>
Received: from mail.cs.pub.ro (prof.cs.pub.ro [141.85.37.3])
	by ozlabs.org (Postfix) with ESMTP id B836B67AAA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 02:18:52 +1100 (EST)
Received: from [10.39.1.15] (unknown [10.39.1.15])
	by mail.cs.pub.ro (Postfix) with ESMTP id 7906A3FA0EF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 16:55:42 +0200 (EET)
From: Octavian Purdila <tavi@cs.pub.ro>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Date: Tue, 8 Feb 2005 16:56:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200502081656.25023.tavi@cs.pub.ro>
Subject: linux kernel PPC 405GP stucked after running init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi list,

I am playing with an embedded system based on an IBM PPC 405GP. So far I made 
the kernel boot, but it gets stuck after running the the init process 
(busybox). Any hints?

I notice that ShowRegs does not output anything, and I traced this behavior to 
pt_regs passed as NULL in the serial irq routine. Is this normal? 

Thank you,
tavi

SysRq : Show Regs
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
busybox       R running     0     1      0     2               (NOTLB)
ksoftirqd/0   S 00000000     0     2      1             3       (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c001a228] ksoftirqd+0xa4/0xc8
 [c00281e8] kthread+0xb8/0xc0
 [c000594c] kernel_thread+0x44/0x60
events/0      S 00000000     0     3      1     4       8     2 (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c0023a40] worker_thread+0x1fc/0x220
 [c00281e8] kthread+0xb8/0xc0
 [c000594c] kernel_thread+0x44/0x60
khelper       S 00000000     0     4      3             5       (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c0023a40] worker_thread+0x1fc/0x220
 [c00281e8] kthread+0xb8/0xc0
 [c000594c] kernel_thread+0x44/0x60
kblockd/0     S 00000000     0     5      3             6     4 (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c0023a40] worker_thread+0x1fc/0x220
 [c00281e8] kthread+0xb8/0xc0
 [c000594c] kernel_thread+0x44/0x60
pdflush       S 00000000     0     6      3             7     5 (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c0030f44] __pdflush+0xb0/0x1e4
 [c0031098] pdflush+0x20/0x30
 [c00281e8] kthread+0xb8/0xc0
 [c000594c] kernel_thread+0x44/0x60
pdflush       S 00000000     0     7      3             9     6 (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c0030f44] __pdflush+0xb0/0x1e4
 [c0031098] pdflush+0x20/0x30
 [c00281e8] kthread+0xb8/0xc0
 [c000594c] kernel_thread+0x44/0x60
aio/0         S 00000000     0     9      3                   7 (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c0023a40] worker_thread+0x1fc/0x220
 [c00281e8] kthread+0xb8/0xc0
 [c000594c] kernel_thread+0x44/0x60
kswapd0       S 00000000     0     8      1            10     3 (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c00375cc] kswapd+0x84/0xa0
 [c000594c] kernel_thread+0x44/0x60
mtdblockd     S 00000000     0    10      1                   8 (L-TLB)
Call trace:
 [c0005a70] __switch_to+0x48/0x70
 [c00a4928] schedule+0x2e8/0x684
 [c009885c] mtd_blktrans_thread+0x18c/0x1c4
 [c000594c] kernel_thread+0x44/0x60
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu: empty
HighMem per-cpu: empty

Free pages:       14240kB (0kB HighMem)
Active:1 inactive:173 dirty:0 writeback:0 unstable:0 free:3560 slab:57 
mapped:14 pagetables:2
DMA free:14240kB min:512kB low:640kB high:768kB active:4kB inactive:692kB 
present:16384kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 6*4kB 3*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 
0*2048kB 3*4096kB = 14240kB
Normal: empty
HighMem: empty
Free swap:            0kB
4096 pages of RAM
0 pages of HIGHMEM
3576 free pages
265 reserved pages
14 pages shared
0 pages swap cached
