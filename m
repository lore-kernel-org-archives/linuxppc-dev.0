Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BAAA67C2D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 04:41:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9DIfeiA001818
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 14:41:40 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9DIfeBS142266
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 14:41:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9DIfe4w003364
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 14:41:40 -0400
Subject: kernel BUG in __cache_alloc_node at  linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Christoph Lameter <clameter@sgi.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 13:41:34 -0500
Message-Id: <1160764895.11239.14.camel@farscape>
Mime-Version: 1.0
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Folks, 
    Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
tree.  It's fairly early during boot, so I've included the whole log
below.   This partition has 8 procs, (shared, including threads), and
512M RAM.  

A bisect claims: 
765c4507af71c39aba21006bbd3ec809fe9714ff is first bad commit
commit 765c4507af71c39aba21006bbd3ec809fe9714ff
Author: Christoph Lameter <clameter@sgi.com>
Date:   Wed Sep 27 01:50:08 2006 -0700

    [PATCH] GFP_THISNODE for the slab allocator

Am willing to dig deeper, but looking for pointers on what to poke next.

Thanks, 
-Will

-----------------------------------------------------
ppc64_pft_size                = 0x18
physicalMemorySize            = 0x22000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x1ffff
-----------------------------------------------------
Linux version 2.6.19-rc1-gb8a3ad5b (willschm@airbag2) (gcc version 4.1.0
(SUSE Linux)) #56 SMP Fri Oct 13 13:06:18 CDT 2006
[boot]0012 Setup Arch
No ramdisk, default root is /dev/sda2
EEH: No capable adapters found
PPC64 nvram contains 7168 bytes
Zone PFN ranges:
  DMA             0 ->   139264
  Normal     139264 ->   139264
early_node_map[3] active PFN ranges
    1:        0 ->    32768
    0:    32768 ->    90112
    1:    90112 ->   139264
[boot]0015 Setup Done
Built 2 zonelists.  Total pages: 136576
Kernel command line: root=/dev/sda3  xmon=on
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
freeing bootmem node 0
freeing bootmem node 1
Memory: 530256k/557056k available (5508k kernel code, 30468k reserved,
2224k data, 543k bss, 244k init)
kernel BUG in __cache_alloc_node
at /development/kernels/linux-2.6.git/mm/slab.c:3177!
cpu 0x0: Vector: 700 (Program Check) at [c0000000007938d0]
    pc: c0000000000b3c78: .__cache_alloc_node+0x44/0x1e8
    lr: c0000000000b3ec8: .fallback_alloc+0xac/0xf0
    sp: c000000000793b50
   msr: 8000000000021032
  current = 0xc000000000583a90
  paca    = 0xc000000000584300
    pid   = 0, comm = swapper
kernel BUG in __cache_alloc_node
at /development/kernels/linux-2.6.git/mm/slab.c:3177!
enter ? for help
[c000000000793c00] c0000000000b3ec8 .fallback_alloc+0xac/0xf0
[c000000000793ca0] c0000000000b4478 .kmem_cache_zalloc+0xc8/0x11c
[c000000000793d40] c0000000000b6624 .kmem_cache_create+0x1e8/0x5e0
[c000000000793e30] c00000000053e834 .kmem_cache_init+0x1d8/0x4b0
[c000000000793ef0] c000000000524748 .start_kernel+0x244/0x328
[c000000000793f90] c0000000000084f8 .start_here_common+0x54/0x5c
0:mon>
