Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A27AADDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 17:06:56 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n2A66iKF009779
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 17:06:44 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2A67BPu491700
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 17:07:11 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2A66rA0007167
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 17:06:53 +1100
Message-ID: <49B60371.7050508@in.ibm.com>
Date: Tue, 10 Mar 2009 11:36:41 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.29-rc7-git2 : crash in kmem_list3_init()
References: <49B5448B.6030205@in.ibm.com>
In-Reply-To: <49B5448B.6030205@in.ibm.com>
Content-Type: multipart/mixed; boundary="------------080709090005030303070000"
Cc: Mel Gorman <mel@csn.ul.ie>, cl@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080709090005030303070000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sachin P. Sant wrote:
> sure if this is a new problem or a recurring one. Will try booting
> some older kernels on this box and will report the results.
I tried few older kernels till 2.6.28 and all of them had the
same problem.

I also tried using SLUB instead of SLAB. That also failed to
boot with following trace.

Unable to handle kernel paging request for data at address 0xc000000070001030
Faulting instruction address: 0xc00000000011c7e0
cpu 0x0: Vector: 300 (Data Access) at [c000000000ac39a0]
    pc: c00000000011c7e0: .new_slab+0x2b8/0x33c
    lr: c00000000011c7dc: .new_slab+0x2b4/0x33c
    sp: c000000000ac3c20
   msr: 8000000000009032
   dar: c000000070001030
 dsisr: 42000000
  current = 0xc0000000009ea4b0
  paca    = 0xc000000000b53480
    pid   = 0, comm = swapper
enter ? for help
[c000000000ac3cc0] c00000000011dc28 .kmem_cache_open+0x1a4/0x448
[c000000000ac3d90] c00000000011f5dc .create_kmalloc_cache+0x78/0x100
[c000000000ac3e40] c000000000948bec .kmem_cache_init+0x8c/0x1c8
[c000000000ac3ee0] c000000000920a5c .start_kernel+0x360/0x480
[c000000000ac3f90] c0000000000083d8 .start_here_common+0x1c/0x44

Complete dmesg log attached. Is there anything else i can try ?

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------080709090005030303070000
Content-Type: text/plain;
 name="rc7-git2-slub-dmesg-log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rc7-git2-slub-dmesg-log"

boot: 
Please wait, loading kernel...
Allocated 01500000 bytes for kernel @ 01c00000
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded 004f0000 @ 05700000
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line: root=/dev/sda5 quiet sysrq=1 loglevel=8 mminit_loglevel=4 
memory layout at init:
  alloc_bottom : 0000000005bf0000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000072000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000072000000
Looking for displays
instantiating rtas at 0x00000000077c0000 ... done
boot cpu hw idx 0000000000000000
starting cpu hw idx 0000000000000002... done
starting cpu hw idx 0000000000000004... done
starting cpu hw idx 0000000000000006... done
starting cpu hw idx 0000000000000008... done
starting cpu hw idx 000000000000000a... done
starting cpu hw idx 000000000000000c... done
starting cpu hw idx 000000000000000e... done
starting cpu hw idx 0000000000000010... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000006000000 -> 0x00000000060011ed
Device tree struct  0x0000000006010000 -> 0x0000000006020000
Calling quiesce ...
returning from prom_init
Using pSeries machine description
Page orders: linear mapping = 12, virtual = 12, io = 12, vmemmap = 24
Found initrd at 0xc000000005700000:0xc000000005bf0000
console [udbg0] enabled
Partition configured for 18 cpus.
CPU maps initialized for 2 threads per core
 (thread shift is 1)
Starting Linux PPC64 #5 SMP Tue Mar 10 10:35:45 IST 2009
-----------------------------------------------------
ppc64_pft_size                = 0x19
physicalMemorySize            = 0x72000000
htab_hash_mask                = 0x3ffff
-----------------------------------------------------
Linux version 2.6.29-rc7-git2 (root@linux-4hy5) (gcc version 4.3.1 20080507 (prerelease) [gcc-4_3-branch revision 135036] (SUSE Linux) ) #5 SMP Tue Mar 10 10:35:45 IST 2009
[boot]0012 Setup Arch
mminit::memory_register Entering add_active_range(1, 0x0, 0x800) 0 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x800, 0xa00) 1 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0xa00, 0xc00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0xc00, 0xe00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0xe00, 0x1000) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x1000, 0x1200) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x1200, 0x1400) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x1400, 0x1600) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x1600, 0x1800) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x1800, 0x1a00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x1a00, 0x1c00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x1c00, 0x1e00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x1e00, 0x2000) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x2000, 0x2200) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x2200, 0x2400) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x2400, 0x2600) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x2600, 0x2800) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x2800, 0x2a00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x2a00, 0x2c00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x2c00, 0x2e00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x2e00, 0x3000) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x3000, 0x3200) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x3200, 0x3400) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x3400, 0x3600) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x3600, 0x3800) 2 entries of 256 used
mminit::memory_register Entering add_active_range(0, 0x3800, 0x3a00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x3a00, 0x3c00) 2 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x3c00, 0x3e00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x3e00, 0x4000) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x4000, 0x4200) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x4200, 0x4400) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x4400, 0x4600) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x4600, 0x4800) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x4800, 0x4a00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x4a00, 0x4c00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x4c00, 0x4e00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x4e00, 0x5000) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x5000, 0x5200) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x5200, 0x5400) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x5400, 0x5600) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x5600, 0x5800) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x5800, 0x5a00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x5a00, 0x5c00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x5c00, 0x5e00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x5e00, 0x6000) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x6000, 0x6200) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x6200, 0x6400) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x6400, 0x6600) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x6600, 0x6800) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x6800, 0x6a00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x6a00, 0x6c00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x6c00, 0x6e00) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x6e00, 0x7000) 3 entries of 256 used
mminit::memory_register Entering add_active_range(1, 0x7000, 0x7200) 3 entries of 256 used
Node 0 Memory: 0x8000000-0x3a000000
Node 1 Memory: 0x0-0x8000000 0x3a000000-0x72000000
PCI host bridge /pci@800000020000003  ranges:
  IO 0x000003fe00700000..0x000003fe007fffff -> 0x0000000000000000
 MEM 0x00000401c0000000..0x00000401ffffffff -> 0x00000000c0000000 
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Using shared processor idle loop
Zone PFN ranges:
  DMA      0x00000000 -> 0x00007200
  Normal   0x00007200 -> 0x00007200
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    1: 0x00000000 -> 0x00000800
    0: 0x00000800 -> 0x00003a00
    1: 0x00003a00 -> 0x00007200
mminit::pageflags_layout_widths Section 0 Node 4 Zone 2 Flags 22
mminit::pageflags_layout_shifts Section 20 Node 4 Zone 2
mminit::pageflags_layout_offsets Section 0 Node 60 Zone 58
mminit::pageflags_layout_zoneid Zone ID: 58 -> 64
mminit::pageflags_layout_usage location: 64 -> 58 unused 58 -> 22 flags 22 -> 0
On node 0 totalpages: 12800
  DMA zone: 18 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 12782 pages, LIFO batch:1
mminit::memmap_init Initialising map node 0 zone 0 pfns 2048 -> 14848
On node 1 totalpages: 16384
  DMA zone: 40 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 16344 pages, LIFO batch:1
mminit::memmap_init Initialising map node 1 zone 0 pfns 0 -> 29184
[boot]0015 Setup Done
mminit::zonelist general 0:DMA = 0:DMA 1:DMA 
mminit::zonelist thisnode 0:DMA = 0:DMA 
mminit::zonelist general 1:DMA = 1:DMA 0:DMA 
mminit::zonelist thisnode 1:DMA = 1:DMA 
Built 2 zonelists in Node order, mobility grouping on.  Total pages: 29126
Policy zone: DMA
Kernel command line: root=/dev/sda5 quiet sysrq=1 loglevel=8 mminit_loglevel=4 
[boot]0020 XICS Init
[boot]0021 XICS Done
pic: no ISA interrupt controller
PID hash table entries: 4096 (order: 12, 32768 bytes)
time_init: decrementer frequency = 207.050000 MHz
time_init: processor frequency   = 1656.400000 MHz
clocksource: timebase mult[1351aa5] shift[22] registered
clockevent: decrementer mult[3501] shift[16] cpu[0]
Console: colour dummy device 80x25
console handover: boot [udbg0] -> real [hvc0]
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 3839 kB
 per task-struct memory footprint: 1920 bytes
Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
freeing bootmem node 0
freeing bootmem node 1
Memory: 1812032k/1867776k available (9792k kernel code, 57920k reserved, 1216k data, 8025k bss, 448k init)
Unable to handle kernel paging request for data at address 0xc000000070001030
Faulting instruction address: 0xc00000000011c7e0
cpu 0x0: Vector: 300 (Data Access) at [c000000000ac39a0]
    pc: c00000000011c7e0: .new_slab+0x2b8/0x33c
    lr: c00000000011c7dc: .new_slab+0x2b4/0x33c
    sp: c000000000ac3c20
   msr: 8000000000009032
   dar: c000000070001030
 dsisr: 42000000
  current = 0xc0000000009ea4b0
  paca    = 0xc000000000b53480
    pid   = 0, comm = swapper
enter ? for help
[c000000000ac3cc0] c00000000011dc28 .kmem_cache_open+0x1a4/0x448
[c000000000ac3d90] c00000000011f5dc .create_kmalloc_cache+0x78/0x100
[c000000000ac3e40] c000000000948bec .kmem_cache_init+0x8c/0x1c8
[c000000000ac3ee0] c000000000920a5c .start_kernel+0x360/0x480
[c000000000ac3f90] c0000000000083d8 .start_here_common+0x1c/0x44
0:mon> ls .new_slab
.new_slab: c00000000011c528
0:mon> di c00000000011c528
c00000000011c528  7c0802a6      mflr    r0
c00000000011c52c  fb41ffd0      std     r26,-48(r1)
c00000000011c530  fba1ffe8      std     r29,-24(r1)
c00000000011c534  fbc1fff0      std     r30,-16(r1)
c00000000011c538  fb61ffd8      std     r27,-40(r1)
c00000000011c53c  fb81ffe0      std     r28,-32(r1)
c00000000011c540  fbe1fff8      std     r31,-8(r1)
c00000000011c544  f8010010      std     r0,16(r1)
c00000000011c548  ebc2b2a8      ld      r30,-19800(r2)
c00000000011c54c  38000000      li      r0,0
c00000000011c550  f821ff61      stdu    r1,-160(r1)
c00000000011c554  7c7a1b78      mr      r26,r3
c00000000011c558  6000ffe0      ori     r0,r0,65504
c00000000011c55c  7cbd2b78      mr      r29,r5
c00000000011c560  780083e4      rldicr  r0,r0,16,47
c00000000011c564  60000006      ori     r0,r0,6
0:mon> 
c00000000011c568  7c800038      and     r0,r4,r0
c00000000011c56c  0b000000      tdnei   r0,0
c00000000011c570  3c000007      lis     r0,7
c00000000011c574  812300a0      lwz     r9,160(r3)
c00000000011c578  2f85ffff      cmpwi   cr7,r5,-1
c00000000011c57c  eb630018      ld      r27,24(r3)
c00000000011c580  60001ef0      ori     r0,r0,7920
c00000000011c584  7c002038      and     r0,r0,r4
c00000000011c588  7b648022      rldicl  r4,r27,48,32
c00000000011c58c  7c004b78      or      r0,r0,r9
c00000000011c590  781c0020      clrldi  r28,r0,32
c00000000011c594  63801200      ori     r0,r28,4608
c00000000011c598  78030020      clrldi  r3,r0,32
c00000000011c59c  409e0018      bne     cr7,c00000000011c5b4    # .new_slab+0x8c/0x33c
c00000000011c5a0  2b840008      cmplwi  cr7,r4,8
c00000000011c5a4  419d0074      bgt     cr7,c00000000011c618    # .new_slab+0xf0/0x33c
0:mon> 
c00000000011c5a8  4bffa561      bl      c000000000116b08        # .alloc_pages_current+0x0/0x124
c00000000011c5ac  60000000      nop
c00000000011c5b0  4800005c      b       c00000000011c60c        # .new_slab+0xe4/0x33c
c00000000011c5b4  2b840008      cmplwi  cr7,r4,8
c00000000011c5b8  419d0060      bgt     cr7,c00000000011c618    # .new_slab+0xf0/0x33c
c00000000011c5bc  2f850000      cmpwi   cr7,r5,0
c00000000011c5c0  7ca92b78      mr      r9,r5
c00000000011c5c4  409c0014      bge     cr7,c00000000011c5d8    # .new_slab+0xb0/0x33c
c00000000011c5c8  a00d000a      lhz     r0,10(r13)
c00000000011c5cc  e93e82a8      ld      r9,-32088(r30)
c00000000011c5d0  78001764      rldicr  r0,r0,2,61
c00000000011c5d4  7d2902aa      lwax    r9,r9,r0
c00000000011c5d8  786a77e2      rldicl  r10,r3,46,63
c00000000011c5dc  e97e8178      ld      r11,-32392(r30)
c00000000011c5e0  79291f24      rldicr  r9,r9,3,60
c00000000011c5e4  38c00000      li      r6,0
0:mon> 
c00000000011c5e8  300affff      addic   r0,r10,-1
c00000000011c5ec  7c000110      subfe   r0,r0,r0
c00000000011c5f0  780acf26      rldicr  r10,r0,57,60
c00000000011c5f4  7cab482a      ldx     r5,r11,r9
c00000000011c5f8  794a3f24      rldicr  r10,r10,7,60
c00000000011c5fc  394a2308      addi    r10,r10,8968
c00000000011c600  7ca55214      add     r5,r5,r10
c00000000011c604  4bfce7e1      bl      c0000000000eade4        # .__alloc_pages_internal+0x0/0x528
c00000000011c608  60000000      nop
c00000000011c60c  2fa30000      cmpdi   cr7,r3,0
c00000000011c610  7c7f1b78      mr      r31,r3
c00000000011c614  40fe0090      bne+    cr7,c00000000011c6a4    # .new_slab+0x17c/0x33c
c00000000011c618  2f9dffff      cmpwi   cr7,r29,-1
c00000000011c61c  eb7a0098      ld      r27,152(r26)
c00000000011c620  7b648022      rldicl  r4,r27,48,32
c00000000011c624  409e001c      bne     cr7,c00000000011c640    # .new_slab+0x118/0x33c
0:mon> 
c00000000011c628  2b840008      cmplwi  cr7,r4,8
c00000000011c62c  419d0208      bgt     cr7,c00000000011c834    # .new_slab+0x30c/0x33c
c00000000011c630  7f83e378      mr      r3,r28
c00000000011c634  4bffa4d5      bl      c000000000116b08        # .alloc_pages_current+0x0/0x124
c00000000011c638  60000000      nop
c00000000011c63c  4800005c      b       c00000000011c698        # .new_slab+0x170/0x33c
c00000000011c640  2b840008      cmplwi  cr7,r4,8
c00000000011c644  419d01f0      bgt     cr7,c00000000011c834    # .new_slab+0x30c/0x33c
c00000000011c648  2f9d0000      cmpwi   cr7,r29,0
c00000000011c64c  409c0014      bge     cr7,c00000000011c660    # .new_slab+0x138/0x33c
c00000000011c650  a00d000a      lhz     r0,10(r13)
c00000000011c654  e93e82a8      ld      r9,-32088(r30)
c00000000011c658  78001764      rldicr  r0,r0,2,61
c00000000011c65c  7fa902aa      lwax    r29,r9,r0
c00000000011c660  7b8a77e2      rldicl  r10,r28,46,63
c00000000011c664  e97e8178      ld      r11,-32392(r30)
0:mon> 
c00000000011c668  7ba91f24      rldicr  r9,r29,3,60
c00000000011c66c  7f83e378      mr      r3,r28
c00000000011c670  38c00000      li      r6,0
c00000000011c674  300affff      addic   r0,r10,-1
c00000000011c678  7c000110      subfe   r0,r0,r0
c00000000011c67c  780acf26      rldicr  r10,r0,57,60
c00000000011c680  7cab482a      ldx     r5,r11,r9
c00000000011c684  794a3f24      rldicr  r10,r10,7,60
c00000000011c688  394a2308      addi    r10,r10,8968
c00000000011c68c  7ca55214      add     r5,r5,r10
c00000000011c690  4bfce755      bl      c0000000000eade4        # .__alloc_pages_internal+0x0/0x528
c00000000011c694  60000000      nop
c00000000011c698  2fa30000      cmpdi   cr7,r3,0
c00000000011c69c  7c7f1b78      mr      r31,r3
c00000000011c6a0  419e0198      beq     cr7,c00000000011c838    # .new_slab+0x310/0x33c
c00000000011c6a4  b37f000e      sth     r27,14(r31)
0:mon> 
c00000000011c6a8  e87f0000      ld      r3,0(r31)
c00000000011c6ac  7b698402      rldicl  r9,r27,48,16
c00000000011c6b0  38a00001      li      r5,1
c00000000011c6b4  e97e8178      ld      r11,-32392(r30)
c00000000011c6b8  7ca54830      slw     r5,r5,r9
c00000000011c6bc  78602720      rldicl  r0,r3,4,60
c00000000011c6c0  786337a0      rldicl  r3,r3,6,62
c00000000011c6c4  7ca507b4      extsw   r5,r5
c00000000011c6c8  78001f24      rldicr  r0,r0,3,60
c00000000011c6cc  1c630a80      mulli   r3,r3,2688
c00000000011c6d0  e89a0000      ld      r4,0(r26)
c00000000011c6d4  7c0b002a      ldx     r0,r11,r0
c00000000011c6d8  78847fe2      rldicl  r4,r4,47,63
c00000000011c6dc  7c601a14      add     r3,r0,r3
c00000000011c6e0  2084000d      subfic  r4,r4,13
c00000000011c6e4  4bfdd679      bl      c0000000000f9d5c        # .mod_zone_page_state+0x0/0x128
0:mon> 
c00000000011c6e8  60000000      nop
c00000000011c6ec  e93f0000      ld      r9,0(r31)
c00000000011c6f0  a01f000e      lhz     r0,14(r31)
c00000000011c6f4  79292720      rldicl  r9,r9,4,60
c00000000011c6f8  39290022      addi    r9,r9,34
c00000000011c6fc  79291f24      rldicr  r9,r9,3,60
c00000000011c700  7d3a4a14      add     r9,r26,r9
c00000000011c704  e9690008      ld      r11,8(r9)
c00000000011c708  2fab0000      cmpdi   cr7,r11,0
c00000000011c70c  419e0030      beq     cr7,c00000000011c73c    # .new_slab+0x214/0x33c
c00000000011c710  392b0050      addi    r9,r11,80
c00000000011c714  7d4048a8      ldarx   r10,0,r9
c00000000011c718  314a0001      addic   r10,r10,1
c00000000011c71c  7d4049ad      stdcx.  r10,0,r9
c00000000011c720  40c2fff4      bne-    c00000000011c714        # .new_slab+0x1ec/0x33c
c00000000011c724  392b0058      addi    r9,r11,88
0:mon> 
c00000000011c728  7c0007b4      extsw   r0,r0
c00000000011c72c  7d6048a8      ldarx   r11,0,r9
c00000000011c730  7d605a14      add     r11,r0,r11
c00000000011c734  7d6049ad      stdcx.  r11,0,r9
c00000000011c738  40c2fff4      bne-    c00000000011c72c        # .new_slab+0x204/0x33c
c00000000011c73c  e81f0000      ld      r0,0(r31)
c00000000011c740  fb5f0010      std     r26,16(r31)
c00000000011c744  3d200021      lis     r9,33
c00000000011c748  61290d00      ori     r9,r9,3328
c00000000011c74c  60000080      ori     r0,r0,128
c00000000011c750  f81f0000      std     r0,0(r31)
c00000000011c754  e81a0000      ld      r0,0(r26)
c00000000011c758  7d280039      and.    r8,r9,r0
c00000000011c75c  41820010      beq     c00000000011c76c        # .new_slab+0x244/0x33c
c00000000011c760  e81f0000      ld      r0,0(r31)
c00000000011c764  60000002      ori     r0,r0,2
0:mon> 
c00000000011c768  f81f0000      std     r0,0(r31)
c00000000011c76c  3c001000      lis     r0,4096
c00000000011c770  e95e8018      ld      r10,-32744(r30)
c00000000011c774  e97a0000      ld      r11,0(r26)
c00000000011c778  3920ffff      li      r9,-1
c00000000011c77c  780007c6      rldicr  r0,r0,32,31
c00000000011c780  79290044      rldicr  r9,r9,0,1
c00000000011c784  7c1f0214      add     r0,r31,r0
c00000000011c788  7968afe3      rldicl. r8,r11,53,63
c00000000011c78c  7c001e74      sradi   r0,r0,3
c00000000011c790  7c0051d2      mulld   r0,r0,r10
c00000000011c794  780083e4      rldicr  r0,r0,16,47
c00000000011c798  7f604a14      add     r27,r0,r9
c00000000011c79c  41e20030      beq+    c00000000011c7cc        # .new_slab+0x2a4/0x33c
c00000000011c7a0  e81f0000      ld      r0,0(r31)
c00000000011c7a4  39200000      li      r9,0
0:mon> 
c00000000011c7a8  780b9fe3      rldicl. r11,r0,51,63
c00000000011c7ac  41820008      beq     c00000000011c7b4        # .new_slab+0x28c/0x33c
c00000000011c7b0  e93f00ae      lwa     r9,172(r31)
c00000000011c7b4  3ca00001      lis     r5,1
c00000000011c7b8  7f63db78      mr      r3,r27
c00000000011c7bc  3880005a      li      r4,90
c00000000011c7c0  7ca54836      sld     r5,r5,r9
c00000000011c7c4  4bf1ce29      bl      c0000000000395ec        # .memset+0x0/0xfc
c00000000011c7c8  60000000      nop
c00000000011c7cc  7f7cdb78      mr      r28,r27
c00000000011c7d0  7f7ddb78      mr      r29,r27
c00000000011c7d4  4800001c      b       c00000000011c7f0        # .new_slab+0x2c8/0x33c
c00000000011c7d8  4bffe2e9      bl      c00000000011aac0        # .setup_object+0x0/0x9c
c00000000011c7dc  e81a0012      lwa     r0,16(r26)
c00000000011c7e0  7fbc012a      stdx    r29,r28,r0
c00000000011c7e4  7fbceb78      mr      r28,r29
0:mon> r
R00 = 0000000000000000   R16 = 0000000002561f58
R01 = c000000000ac3c20   R17 = 0000000000000000
R02 = c000000000abc0d8   R18 = c000000000961f58
R03 = c000000000b29480   R19 = 00000000019ffcb0
R04 = f000000000268000   R20 = 0000000000000070
R05 = c000000070001030   R21 = c000000000b294a0
R06 = 0000000000000001   R22 = 0000000000000000
R07 = 0000000000000001   R23 = 0000000000000000
R08 = 0000000000000000   R24 = 00000000000000d0
R09 = 0000000000000000   R25 = c000000000b29480
R10 = 2e8ba2e8ba2e8ba3   R26 = c000000000b29480
R11 = 0000000000000000   R27 = c000000070000000
R12 = 0000000048000024   R28 = c000000070001030
R13 = c000000000b53480   R29 = c0000000700010a0
R14 = c000000000962020   R30 = c000000000a22498
R15 = c000000000847668   R31 = f000000000268000
pc  = c00000000011c7e0 .new_slab+0x2b8/0x33c
lr  = c00000000011c7dc .new_slab+0x2b4/0x33c
msr = 8000000000009032   cr  = 28000022
ctr = 0000000000000000   xer = 000000000000000c   trap =  300
dar = c000000070001030   dsisr = 42000000
0:mon>



--------------080709090005030303070000--
