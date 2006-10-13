Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EBE0F67BEC
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 06:57:29 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9DKvQge022489
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 16:57:26 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9DKvQJm087056
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 16:57:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9DKvQtd004857
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 16:57:26 -0400
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <1160769226.11239.22.camel@farscape>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 15:57:20 -0500
Message-Id: <1160773040.11239.28.camel@farscape>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-13-10 at 14:53 -0500, Will Schmidt wrote:
> On Fri, 2006-13-10 at 12:05 -0700, Christoph Lameter wrote:
> > On Fri, 13 Oct 2006, Will Schmidt wrote:
> > 
> > >     Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
> > > tree.  It's fairly early during boot, so I've included the whole log
> > > below.   This partition has 8 procs, (shared, including threads), and
> > > 512M RAM.  
> > 
> > This looks like slab bootstrap. You are bootstrapping while having 
> > zonelists build with zones that are only going to be populated later? 
> > This will lead to incorrect NUMA placement of lots of slab structures on 
> > bootup.
> 
> I dont think so..   but it's not an area I'm very familiar with.   one
> of the other PPC folks might chime in with something here.  
> 
> > 
> > Check if the patch below may cure the oops. Your memory is likely 
> > still placed on the wrong numa nodes since we have to fallback from 
> > the intended node.
> 
> Nope, no change with this patch.
> 

Here is another boot log, with that patch applied, and with a numa=debug
parm. 

-----------------------------------------------------
ppc64_pft_size                = 0x18
physicalMemorySize            = 0x22000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x1ffff
-----------------------------------------------------
Linux version 2.6.19-rc1-gb8a3ad5b-dirty (willschm@airbag2) (gcc version
4.1.0 (SUSE Linux)) #60 SMP Fri Oct 13 14:48:20 CDT 2006
[boot]0012 Setup Arch
NUMA associativity depth for CPU/Memory: 3
adding cpu 0 to node 0
node 0
NODE_DATA() = c000000015ffee80
start_paddr = 8000000
end_paddr = 16000000
bootmap_paddr = 15ffc000
reserve_bootmem ffc0000 40000
reserve_bootmem 15ffc000 2000
reserve_bootmem 15ffee80 1180
node 1
NODE_DATA() = c000000021ff7c80
start_paddr = 0
end_paddr = 22000000
bootmap_paddr = 21ff2000
reserve_bootmem 0 847000
reserve_bootmem 264b000 9000
reserve_bootmem 77b2000 84e000
reserve_bootmem 21ff2000 5000
reserve_bootmem 21ff7c80 1180
reserve_bootmem 21ff8e58 71a4
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
Kernel command line: root=/dev/sda3  xmon=on  numa=debug
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
at /development/kernels/linux-2.6.git/mm/slab.c:3178!
cpu 0x0: Vector: 700 (Program Check) at [c0000000007938d0]
    pc: c0000000000b3c78: .__cache_alloc_node+0x44/0x1e8
    lr: c0000000000b3ed4: .fallback_alloc+0xb8/0xfc
    sp: c000000000793b50
   msr: 8000000000021032
  current = 0xc000000000583a90
  paca    = 0xc000000000584300
    pid   = 0, comm = swapper
kernel BUG in __cache_alloc_node
at /development/kernels/linux-2.6.git/mm/slab.c:3178!
enter ? for help
[c000000000793c00] c0000000000b3ed4 .fallback_alloc+0xb8/0xfc
[c000000000793ca0] c0000000000b4484 .kmem_cache_zalloc+0xc8/0x11c
[c000000000793d40] c0000000000b6630 .kmem_cache_create+0x1e8/0x5e0
[c000000000793e30] c00000000053e834 .kmem_cache_init+0x1d8/0x4b0
[c000000000793ef0] c000000000524748 .start_kernel+0x244/0x328
[c000000000793f90] c0000000000084f8 .start_here_common+0x54/0x5c
0:mon>                          
