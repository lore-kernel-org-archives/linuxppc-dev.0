Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34E0C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 14:40:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2652077B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 14:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2652077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=depni.sinp.msu.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rGtd48TszDqkJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 00:40:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=depni.sinp.msu.ru
 (client-ip=213.131.7.21; helo=depni-mx.sinp.msu.ru;
 envelope-from=belyshev@depni.sinp.msu.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=depni.sinp.msu.ru
Received: from depni-mx.sinp.msu.ru (depni-mx.sinp.msu.ru [213.131.7.21])
 by lists.ozlabs.org (Postfix) with ESMTP id 44rGrz36LDzDqf4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 00:38:57 +1000 (AEST)
Received: from spider (unknown [109.63.154.231])
 by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id 8D7AC1BF408;
 Fri, 26 Apr 2019 17:41:08 +0300 (MSK)
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: BUG: crash in __tlb_remove_page_size with STRICT_KERNEL_RWX on
 BOOK3S_32
References: <87pnp9mknl.fsf@depni.sinp.msu.ru>
 <db886597-8867-93e6-a507-6da4963ce0bd@c-s.fr>
Date: Fri, 26 Apr 2019 17:38:50 +0300
In-Reply-To: <db886597-8867-93e6-a507-6da4963ce0bd@c-s.fr> (Christophe Leroy's
 message of "Fri, 26 Apr 2019 09:27:55 +0200")
Message-ID: <878svwn85h.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

> Could you please compile your kernel with CONFIG_PPC_PTDUMP, and
> provide the content of:
>
> /sys/kernel/debug/kernel_page_tables

---[ Start of kernel VM ]---
0xe1000000-0xefffffff  0x21000000       240M        rw       present           dirty  accessed                         
---[ vmalloc() Area ]---
0xf1000000-0xf1000fff  0x80041000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf1002000-0xf1003fff  0x80041000         8K        rw       present  guarded  dirty  accessed                 no cache
0xf1005000-0xf1005fff  0x80060000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf1007000-0xf1007fff  0x80050000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf100a000-0xf100bfff  0xf8001000         8K        rw       present  guarded  dirty  accessed                 no cache
0xf100d000-0xf100dfff  0x80018000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf1010000-0xf1011fff  0xa0006000         8K        rw       present  guarded  dirty  accessed                 no cache
0xf101b000-0xf1025fff  0x3fc00000        44K        rw       present           dirty  accessed                         
0xf1027000-0xf1027fff  0xb87ff000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf1029000-0xf1029fff  0xba7ff000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf102b000-0xf106afff  0x2f300000       256K        rw       present  guarded  dirty  accessed                 no cache
0xf106c000-0xf106ffff  0x3fc0b000        16K        rw       present           dirty  accessed                         
0xf1071000-0xf1071fff  0x80020000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf1074000-0xf1077fff  0xf5004000        16K        rw       present  guarded  dirty  accessed                 no cache
0xf107a000-0xf107bfff  0x80008000         8K        rw       present  guarded  dirty  accessed                 no cache
0xf107d000-0xf107dfff  0xf5000000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf1080000-0xf118afff  0xb8008000      1068K        rw       present  guarded  dirty  accessed                 no cache
0xf1195000-0xf119cfff  0x2f3a0000        32K        rw       present           dirty  accessed                         
0xf119d000-0xf119efff  0x2f3a0000         8K        rw       present           dirty  accessed                         
0xf11a0000-0xf11a5fff  0x2f3a8000        24K        rw       present           dirty  accessed                         
0xf11a6000-0xf11a7fff  0x2f3da000         8K        rw       present           dirty  accessed                         
0xf11a8000-0xf11a9fff  0x2f3a8000         8K        rw       present           dirty  accessed                         
0xf11ab000-0xf11abfff  0xa0004000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf11ad000-0xf11adfff  0xa0000000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf11af000-0xf11affff  0xa0003000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf11b1000-0xf11b1fff  0xa0002000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf11b3000-0xf11b3fff  0xa0001000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf11b5000-0xf11b5fff  0x80010000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf11b7000-0xf11b7fff  0x80008000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf11b9000-0xf11b9fff  0x80008000         4K        rw       present  guarded  dirty  accessed                 no cache
0xf11c0000-0xf11cffff  0x88000000        64K        rw       present  guarded  dirty  accessed                 no cache
0xf11eb000-0xf11ebfff  0x3fc16000         4K        rw       present           dirty  accessed                         
0xf11ec000-0xf11ecfff  0x3fc15000         4K        rw       present           dirty  accessed                         
0xf11ed000-0xf11edfff  0x3fc14000         4K        rw       present           dirty  accessed                         
0xf1200000-0xf1259fff  0xba008000       360K        rw       present  guarded  dirty  accessed                 no cache
0xf1280000-0xf147ffff  0xf5200000         2M        rw       present  guarded  dirty  accessed                 no cache
---[ vmalloc() End ]---
---[ Early I/O remap start ]---
0xfde2b000-0xfde2cfff  0x80016000         8K        rw       present  guarded  dirty  accessed                 no cache
0xfde2d000-0xfde2dfff  0x80000000         4K        rw       present  guarded  dirty  accessed                 no cache
0xfde2e000-0xfde2efff  0xf8000000         4K        rw       present  guarded  dirty  accessed                 no cache
0xfde2f000-0xfe62efff  0xf4000000         8M        rw       present  guarded  dirty  accessed                 no cache
0xfe62f000-0xfe62ffff  0xf4c00000         4K        rw       present  guarded  dirty  accessed                 no cache
0xfe630000-0xfe630fff  0xf4800000         4K        rw       present  guarded  dirty  accessed                 no cache
0xfe631000-0xfee30fff  0xf2000000         8M        rw       present  guarded  dirty  accessed                 no cache
0xfee31000-0xfee31fff  0xf2c00000         4K        rw       present  guarded  dirty  accessed                 no cache
0xfee32000-0xfee32fff  0xf2800000         4K        rw       present  guarded  dirty  accessed                 no cache
0xfee33000-0xff632fff  0xf0000000         8M        rw       present  guarded  dirty  accessed                 no cache
0xff633000-0xff633fff  0xf0c00000         4K        rw       present  guarded  dirty  accessed                 no cache
0xff634000-0xff634fff  0xf0800000         4K        rw       present  guarded  dirty  accessed                 no cache
0xff635000-0xff73ffff  0xb8008000      1068K        rw       present           dirty  accessed                 no cache
0xff740000-0xff7bffff  0x80000000       512K        rw       present  guarded  dirty  accessed                 no cache
0xff7c0000-0xff7fffff  0xf8000000       256K        rw       present  guarded  dirty  accessed                 no cache
---[ Early I/O remap end ]---
---[ Highmem PTEs start ]---
0xff801000-0xff801fff  0x3f804000         4K        rw       present           dirty  accessed                         
0xff802000-0xff802fff  0x3f9c6000         4K        rw       present           dirty  accessed                         
0xff803000-0xff803fff  0x3fa22000         4K        rw       present           dirty  accessed                         
0xff804000-0xff804fff  0x3fa3b000         4K        rw       present           dirty  accessed                         
0xff805000-0xff805fff  0x3fa52000         4K        rw       present           dirty  accessed                         
0xff806000-0xff806fff  0x3fb3b000         4K        rw       present           dirty  accessed                         
0xff807000-0xff807fff  0x3fb52000         4K        rw       present           dirty  accessed                         
0xff808000-0xff808fff  0x3fb26000         4K        rw       present           dirty  accessed                         
0xff809000-0xff809fff  0x3fb48000         4K        rw       present           dirty  accessed                         
0xff80a000-0xff80afff  0x3fb79000         4K        rw       present           dirty  accessed                         
0xff80b000-0xff80bfff  0x3f9e4000         4K        rw       present           dirty  accessed                         
0xff80c000-0xff80cfff  0x3f574000         4K        rw       present           dirty  accessed                         
0xff80d000-0xff80dfff  0x3f5c6000         4K        rw       present           dirty  accessed                         
0xff80e000-0xff80efff  0x3f578000         4K        rw       present           dirty  accessed                         
0xff80f000-0xff80ffff  0x3f60a000         4K        rw       present           dirty  accessed                         
0xff810000-0xff810fff  0x3f791000         4K        rw       present           dirty  accessed                         
---[ Highmem PTEs end ]---
---[ Fixmap start ]---
0xfffde000-0xfffdefff  0x3f086000         4K        rw       present           dirty  accessed                         
0xfffdf000-0xfffdffff  0x3f08a000         4K        rw       present           dirty  accessed                         
---[ Fixmap end ]---


> /sys/kernel/debug/powerpc/block_address_translation

---[ Instruction Block Address Translation ]---
0: 0xc0000000-0xc07fffff 0x00000000 Kernel EXEC coherent 
1: 0xc0800000-0xc087ffff 0x00800000 Kernel EXEC coherent 
2:         -
3:         -
4:         -
5:         -
6:         -
7:         -

---[ Data Block Address Translation ]---
0: 0xc0000000-0xc07fffff 0x00000000 Kernel RO coherent 
1: 0xc0800000-0xc0bfffff 0x00800000 Kernel RO coherent 
2: 0xc0c00000-0xc13fffff 0x00c00000 Kernel RW coherent 
3: 0xc1400000-0xc23fffff 0x01400000 Kernel RW coherent 
4: 0xc2400000-0xc43fffff 0x02400000 Kernel RW coherent 
5: 0xc4400000-0xc83fffff 0x04400000 Kernel RW coherent 
6: 0xc8400000-0xd03fffff 0x08400000 Kernel RW coherent 
7: 0xd0400000-0xe03fffff 0x10400000 Kernel RW coherent 


> /sys/kernel/debug/powerpc/segment_registers

---[ User Segments ]---
0x00000000-0x0fffffff Kern key 1 User key 1 VSID 0x07aa30
0x10000000-0x1fffffff Kern key 1 User key 1 VSID 0x07ab41
0x20000000-0x2fffffff Kern key 1 User key 1 VSID 0x07ac52
0x30000000-0x3fffffff Kern key 1 User key 1 VSID 0x07ad63
0x40000000-0x4fffffff Kern key 1 User key 1 VSID 0x07ae74
0x50000000-0x5fffffff Kern key 1 User key 1 VSID 0x07af85
0x60000000-0x6fffffff Kern key 1 User key 1 VSID 0x07b096
0x70000000-0x7fffffff Kern key 1 User key 1 VSID 0x07b1a7
0x80000000-0x8fffffff Kern key 1 User key 1 VSID 0x07b2b8
0x90000000-0x9fffffff Kern key 1 User key 1 VSID 0x07b3c9
0xa0000000-0xafffffff Kern key 1 User key 1 VSID 0x07b4da
0xb0000000-0xbfffffff Kern key 1 User key 1 VSID 0x07b5eb

---[ Kernel Segments ]---
0xc0000000-0xcfffffff Kern key 0 User key 1 No Exec VSID 0x000ccc
0xd0000000-0xdfffffff Kern key 0 User key 1 No Exec VSID 0x000ddd
0xe0000000-0xefffffff Kern key 0 User key 1 No Exec VSID 0x000eee
0xf0000000-0xffffffff Kern key 0 User key 1 No Exec VSID 0x000fff


> Please also provide the begining of 'dmesg' that shows the memory layout.

[    0.000000] Total memory = 1024MB; using 2048kB for hash table (at (ptrval))
[    0.000000] Linux version 5.1.0-rc6-00072-g8113a85f8720 (ssb@spider) (gcc version 9.0.1 20190409 (experimental) [trunk revision 270234] (GCC)) #1192 PREEMPT Fri Apr 26 16:45:50 MSK 2019
[    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0xd2
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Intrepid mac-io controller, rev: 0, mapped at 0x(ptrval)
[    0.000000] Processor NAP mode on idle enabled.
[    0.000000] PowerMac motherboard: PowerBook G4 15"
[    0.000000] Using PowerMac machine description
[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] -----------------------------------------------------
[    0.000000] Hash_size         = 0x200000
[    0.000000] phys_mem_size     = 0x40000000
[    0.000000] dcache_bsize      = 0x20
[    0.000000] icache_bsize      = 0x20
[    0.000000] cpu_features      = 0x000000002510600a
[    0.000000]   possible        = 0x000000002f7ff14b
[    0.000000]   always          = 0x0000000000000000
[    0.000000] cpu_user_features = 0x9c000001 0x00000000
[    0.000000] mmu_features      = 0x00010001
[    0.000000] Hash              = 0x(ptrval)
[    0.000000] Hash_mask         = 0x7fff
[    0.000000] -----------------------------------------------------
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->1
[    0.000000] PCI host bridge /pci@f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x00000000b0000000..0x00000000bfffffff -> 0x00000000b0000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->1
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]  MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x00000000f3000000 
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x00000000afffffff -> 0x0000000080000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->1
[    0.000000] PCI host bridge /pci@f4000000  ranges:
[    0.000000]  MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x00000000f5000000 
[    0.000000]   IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000000000000
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] Top of RAM: 0x40000000, Total RAM: 0x40000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] On node 0 totalpages: 262144
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 196608 pages, LIFO batch:63
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
[    0.000000] Kernel command line: root=/dev/hda3 ro console=ttyUSB0,115200 console=tty0 init=/boot/init 
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1023092K/1048576K available (8704K kernel code, 348K rwdata, 1344K rodata, 212K init, 1176K bss, 25484K reserved, 0K cma-reserved, 262144K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xfde2b000..0xff800000  : early ioremap
[    0.000000]   * 0xf1000000..0xfde2b000  : vmalloc & ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1

full dmesg: http://aargh.no-ip.org/dmesg.txt
kernel config: http://aargh.no-ip.org/config.txt

> Thanks
> Christophe

Thanks!
