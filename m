Return-Path: <kniht@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66163DDDDF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 15:10:59 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB549ROi021035
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 21:09:27 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB54ApZc205850
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 21:10:51 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB54AoXR006677
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 21:10:51 -0700
Message-ID: <4938A9C9.8080200@us.ibm.com>
Date: Thu, 04 Dec 2008 22:10:49 -0600
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fix boot freeze on machine with empty memory node
References: <1227564155.22243.45.camel@nimitz>
In-Reply-To: <1227564155.22243.45.camel@nimitz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, nacc <nacc@linux.vnet.ibm.com>,
	Milton Miller <miltonm@bga.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Nathan Lynch <ntl@pobox.com>, anton <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Hansen wrote:
> I got a bug report about a distro kernel not booting on a particular
> machine.  It would freeze during boot:
>
>   
>> ...
>> Could not find start_pfn for node 1
>> [boot]0015 Setup Done
>> Built 2 zonelists in Node order, mobility grouping on.  Total pages: 123783
>> Policy zone: DMA
>> Kernel command line:
>> [boot]0020 XICS Init
>> [boot]0021 XICS Done
>> PID hash table entries: 4096 (order: 12, 32768 bytes)
>> clocksource: timebase mult[7d0000] shift[22] registered
>> Console: colour dummy device 80x25
>> console handover: boot [udbg0] -> real [hvc0]
>> Dentry cache hash table entries: 1048576 (order: 7, 8388608 bytes)
>> Inode-cache hash table entries: 524288 (order: 6, 4194304 bytes)
>> freeing bootmem node 0
>>     
>
> I've reproduced this on 2.6.27.7.  I'm pretty sure it is caused by this
> patch:
>
> http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8f64e1f2d1e09267ac926e15090fd505c1c0cbcb
>
> The problem is that Jon took a loop which was (in psuedocode):
>
> 	for_each_node(nid)
> 		NODE_DATA(nid) = careful_alloc(nid);
> 		setup_bootmem(nid);
> 		reserve_node_bootmem(nid);
>
> and broke it up into:
>
> 	for_each_node(nid)
> 		NODE_DATA(nid) = careful_alloc(nid);
> 		setup_bootmem(nid);
> 	for_each_node(nid)
> 		reserve_node_bootmem(nid);
>
> The issue comes in when the 'careful_alloc()' is called on a node with
> no memory.  It falls back to using bootmem from a previously-initialized
> node.  But, bootmem has not yet been reserved when Jon's patch is
> applied.  It gives back bogus memory (0xc000000000000000) and pukes
> later in boot.
>
> The following patch collapses the loop back together.  It also breaks
> the mark_reserved_regions_for_nid() code out into a function and adds
> some comments.  I think a huge part of introducing this bug is because
> for loop was too long and hard to read.
>
> The actual bug fix here is the:
>
> +		if (end_pfn <= node->node_start_pfn ||
> +		    start_pfn >= node_end_pfn)
> +			continue;
>
> Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
>
> diff -ru linux-2.6.27.7.orig/arch/powerpc//mm/numa.c linux-2.6.27.7/arch/powerpc//mm/numa.c
> --- linux-2.6.27.7.orig/arch/powerpc//mm/numa.c	2008-11-20 17:02:37.000000000 -0600
> +++ linux-2.6.27.7/arch/powerpc//mm/numa.c	2008-11-24 15:53:35.000000000 -0600
> @@ -822,6 +822,67 @@
>  	.priority = 1 /* Must run before sched domains notifier. */
>  };
>
> +static void mark_reserved_regions_for_nid(int nid)
> +{
> +	struct pglist_data *node = NODE_DATA(nid);
> +	int i;
> +
> +	for (i = 0; i < lmb.reserved.cnt; i++) {
> +		unsigned long physbase = lmb.reserved.region[i].base;
> +		unsigned long size = lmb.reserved.region[i].size;
> +		unsigned long start_pfn = physbase >> PAGE_SHIFT;
> +		unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);
> +		struct node_active_region node_ar;
> +		unsigned long node_end_pfn = node->node_start_pfn +
> +					     node->node_spanned_pages;
> +
> +		/*
> +		 * Check to make sure that this lmb.reserved area is
> +		 * within the bounds of the node that we care about.
> +		 * Checking the nid of the start and end points is not
> +		 * sufficient because the reserved area could span the
> +		 * entire node.
> +		 */
> +		if (end_pfn <= node->node_start_pfn ||
> +		    start_pfn >= node_end_pfn)
> +			continue;
> +
> +		get_node_active_region(start_pfn, &node_ar);
> +		while (start_pfn < end_pfn &&
> +			node_ar.start_pfn < node_ar.end_pfn) {
> +			unsigned long reserve_size = size;
> +			/*
> +			 * if reserved region extends past active region
> +			 * then trim size to active region
> +			 */
> +			if (end_pfn > node_ar.end_pfn)
> +				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
> +					- (start_pfn << PAGE_SHIFT);
> +			dbg("reserve_bootmem %lx %lx nid=%d\n", physbase,
> +				reserve_size, node_ar.nid);
> +			reserve_bootmem_node(NODE_DATA(node_ar.nid), physbase,
> +						reserve_size, BOOTMEM_DEFAULT);
> +			/*
> +			 * if reserved region is contained in the active region
> +			 * then done.
> +			 */
> +			if (end_pfn <= node_ar.end_pfn)
> +				break;
> +
> +			/*
> +			 * reserved region extends past the active region
> +			 *   get next active region that contains this
> +			 *   reserved region
> +			 */
> +			start_pfn = node_ar.end_pfn;
> +			physbase = start_pfn << PAGE_SHIFT;
> +			size = size - reserve_size;
> +			get_node_active_region(start_pfn, &node_ar);
> +		}
> +	}
> +}
> +
> +
>  void __init do_init_bootmem(void)
>  {
>  	int nid;
> @@ -847,7 +908,13 @@
>
>  		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
>
> -		/* Allocate the node structure node local if possible */
> +		/*
> +		 * Allocate the node structure node local if possible
> +		 *
> +		 * Be careful moving this around, as it relies on all
> +		 * previous nodes' bootmem to be initialized and have
> +		 * all reserved areas marked.
> +		 */
>  		NODE_DATA(nid) = careful_allocation(nid,
>  					sizeof(struct pglist_data),
>  					SMP_CACHE_BYTES, end_pfn);
> @@ -879,53 +946,14 @@
>  				  start_pfn, end_pfn);
>
>  		free_bootmem_with_active_regions(nid, end_pfn);
> -	}
> -
> -	/* Mark reserved regions */
> -	for (i = 0; i < lmb.reserved.cnt; i++) {
> -		unsigned long physbase = lmb.reserved.region[i].base;
> -		unsigned long size = lmb.reserved.region[i].size;
> -		unsigned long start_pfn = physbase >> PAGE_SHIFT;
> -		unsigned long end_pfn = ((physbase + size) >> PAGE_SHIFT);
> -		struct node_active_region node_ar;
> -
> -		get_node_active_region(start_pfn, &node_ar);
> -		while (start_pfn < end_pfn &&
> -			node_ar.start_pfn < node_ar.end_pfn) {
> -			unsigned long reserve_size = size;
> -			/*
> -			 * if reserved region extends past active region
> -			 * then trim size to active region
> -			 */
> -			if (end_pfn > node_ar.end_pfn)
> -				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
> -					- (start_pfn << PAGE_SHIFT);
> -			dbg("reserve_bootmem %lx %lx nid=%d\n", physbase,
> -				reserve_size, node_ar.nid);
> -			reserve_bootmem_node(NODE_DATA(node_ar.nid), physbase,
> -						reserve_size, BOOTMEM_DEFAULT);
> -			/*
> -			 * if reserved region is contained in the active region
> -			 * then done.
> -			 */
> -			if (end_pfn <= node_ar.end_pfn)
> -				break;
> -
> -			/*
> -			 * reserved region extends past the active region
> -			 *   get next active region that contains this
> -			 *   reserved region
> -			 */
> -			start_pfn = node_ar.end_pfn;
> -			physbase = start_pfn << PAGE_SHIFT;
> -			size = size - reserve_size;
> -			get_node_active_region(start_pfn, &node_ar);
> -		}
> -
> -	}
> -
> -	for_each_online_node(nid)
> +		/*
> +		 * Be very careful about moving this around.  Future
> +		 * calls to careful_allocation() depend on this getting
> +		 * done correctly.
> +		 */
> +		mark_reserved_regions_for_nid(nid);
>  		sparse_memory_present_with_active_regions(nid);
> +	}
>  }
>
>  void __init paging_init(void)
>
>
> -- Dave
>
>   

Sorry I was out for a while.  I just tried testing the patch on a 
machine with 3 gigantic pages and it crashes.

This first log snippet is from the machine WITHOUT the patch.
...
NUMA associativity depth for CPU/Memory: 3
Node 0 Memory: 0x0-0x288000000 0x500000000-0x1000000000
Node 1 Memory: 0x288000000-0x500000000 0x1000000000-0x1400000000
adding cpu 0 to node 0
node 0
NODE_DATA() = c0000004ffff1480
start_paddr = 0
end_paddr = 1000000000
bootmap_paddr = 4fffd0000
node 1
NODE_DATA() = c0000004fffc8980
start_paddr = 288000000
end_paddr = 1400000000
bootmap_paddr = 4fff90000
reserve_bootmem 0 c30000 nid=0
reserve_bootmem 2f00000 b86400 nid=0
reserve_bootmem 2f00000 b90000 nid=0
reserve_bootmem 3b90000 30000 nid=0
reserve_bootmem f530000 ad0000 nid=0
reserve_bootmem 4fff90000 30000 nid=1
reserve_bootmem 4fffc8980 27680 nid=1
reserve_bootmem 4ffff8b58 74a8 nid=1
reserve_bootmem 800000000 800000000 nid=0
reserve_bootmem 1000000000 400000000 nid=1
EEH: No capable adapters found
PPC64 nvram contains 15360 bytes
Using shared processor idle loop
Zone PFN ranges:
  DMA      0x00000000 -> 0x00140000
  Normal   0x00140000 -> 0x00140000
Movable zone start PFN for each node
early_node_map[4] active PFN ranges
    0: 0x00000000 -> 0x00028800
    1: 0x00028800 -> 0x00050000
    0: 0x00080000 -> 0x00100000
    1: 0x00100000 -> 0x00140000
On node 0 totalpages: 690176
  DMA zone: 689152 pages, LIFO batch:1
On node 1 totalpages: 423936
  DMA zone: 422818 pages, LIFO batch:1
[boot]0015 Setup Done


--------------------------------------
This is a log snippet when the patch has been applied.
--------------------------------------

NUMA associativity depth for CPU/Memory: 3
Node 0 Memory: 0x0-0x288000000 0x500000000-0x1000000000
Node 1 Memory: 0x288000000-0x500000000 0x1000000000-0x1400000000
adding cpu 0 to node 0
node 0
NODE_DATA() = c0000004ffff1480
start_paddr = 0
end_paddr = 1000000000
bootmap_paddr = 4fffd0000
reserve_bootmem 0 c30000 nid=0
reserve_bootmem 2f00000 b86800 nid=0
reserve_bootmem 2f00000 b90000 nid=0
reserve_bootmem 3b90000 30000 nid=0
reserve_bootmem f530000 ad0000 nid=0
reserve_bootmem 4fffd0000 20000 nid=1
Unable to handle kernel paging request for data at address 0x00007618
Faulting instruction address: 0xc0000000007279fc
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=1024 NUMA pSeries
Modules linked in:
Supported: Yes
NIP: c0000000007279fc LR: c000000000711b3c CTR: 8000000000f7cdec
REGS: c000000000963aa0 TRAP: 0300   Not tainted  (2.6.27.7-4-ppc64)
MSR: 8000000000001032 <ME,IR,DR>  CR: 24022082  XER: 00000001
DAR: 0000000000007618, DSISR: 0000000040000000
TASK = c0000000008b7fa0[0] 'swapper' THREAD: c000000000960000 CPU: 0
GPR00: 0000000000000008 c000000000963d20 c0000000009615c8 0000000000000000
GPR04: 00000004fffd0000 0000000000020000 0000000000000000 ffffffffffffffff
GPR08: 0000000000000000 00000004fffe0000 0000000000d3a20b 000000000000068c
GPR12: 0000000024022082 c000000000a22c80 c000000000743378 c000000000666106
GPR16: c000000000963d98 c000000000aa91d0 c000000000963d90 c000000000963d98
GPR20: c000000000963da0 c000000000c025d0 c0000004ffff1480 c000000000000000
GPR24: 0000000000000005 0000000000020000 c000000000c02e60 000000000004ffff
GPR28: 0000000000020000 000000000004fffd 0000000000000000 00000004fffd0000
NIP [c0000000007279fc] .reserve_bootmem_node+0x4/0x24
LR [c000000000711b3c] .do_init_bootmem+0xc10/0xd4c
Call Trace:
[c000000000963d20] [c000000000711b14] .do_init_bootmem+0xbe8/0xd4c 
(unreliable)
[c000000000963e40] [c000000000706294] .setup_arch+0x1a4/0x21c
[c000000000963ee0] [c000000000700888] .start_kernel+0xdc/0x554
[c000000000963f90] [c000000000008568] .start_here_common+0x3c/0x54
Instruction dump:
38a00001 79248402 4bfffe84 3d230001 7c841a14 3929ffff 38a00000 78848402
79238402 38c00000 4bfffe64 3d240001 <e8637618> 7cc73378 3929ffff 78848402
---[ end trace 31fd0ba7d8756001 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
------------[ cut here ]------------
Badness at kernel/smp.c:331
NIP: c0000000000b9734 LR: c0000000000b9a30 CTR: 8000000000f7cdec
REGS: c0000000009631a0 TRAP: 0700   Tainted: G      D    (2.6.27.7-4-ppc64)
MSR: 8000000000021032 <ME,IR,DR>  CR: 28022084  XER: 00000001
TASK = c0000000008b7fa0[0] 'swapper' THREAD: c000000000960000 CPU: 0
GPR00: 0000000000000001 c000000000963420 c0000000009615c8 0000000000000001
GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000028022082 c000000000a22c80 c000000000743378 c000000000666106
GPR16: c000000000963d98 c000000000aa91d0 c000000000963d90 c000000000963d98
GPR20: c000000000963da0 c000000000c025d0 c0000004ffff1480 c000000000000000
GPR24: 0000000000000000 c0000000008ff0d0 0000000000000000 0000000000000000
GPR28: 0000000000000000 0000000000000000 c0000000008e8138 000000000000000b
NIP [c0000000000b9734] .smp_call_function_mask+0x68/0x2c4
LR [c0000000000b9a30] .smp_call_function+0xa0/0xcc
Call Trace:
[c000000000963420] [c0000000004d6718] ._spin_unlock_irqrestore+0x3c/0x50 
(unreliable)
[c000000000963600] [c0000000000b9a30] .smp_call_function+0xa0/0xcc
[c000000000963710] [c00000000002d3a0] .smp_send_stop+0x24/0x3c
[c000000000963790] [c0000000004e1284] .panic+0xa8/0x1b8
[c000000000963820] [c0000000000903ac] .do_exit+0xa0/0x980
[c000000000963910] [c000000000027ffc] .die+0x274/0x278
[c0000000009639b0] [c000000000030e98] .bad_page_fault+0xb8/0xd4
[c000000000963a30] [c000000000005698] handle_page_fault+0x3c/0x5c
--- Exception: 300 at .reserve_bootmem_node+0x4/0x24
    LR = .do_init_bootmem+0xc10/0xd4c
[c000000000963d20] [c000000000711b14] .do_init_bootmem+0xbe8/0xd4c 
(unreliable)
[c000000000963e40] [c000000000706294] .setup_arch+0x1a4/0x21c
[c000000000963ee0] [c000000000700888] .start_kernel+0xdc/0x554
[c000000000963f90] [c000000000008568] .start_here_common+0x3c/0x54
Instruction dump:
eb010298 eb6102a6 f8810218 f8a10220 f8c10228 f8e10230 f9010238 f9210240
f9410248 880d01da 7c000074 7800d182 <0b000000> 3be10210 a3ad000a e8be8028
