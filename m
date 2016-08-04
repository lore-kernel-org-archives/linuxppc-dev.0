Return-Path: <mgorman@techsingularity.net>
Received: from outbound-smtp07.blacknight.com (outbound-smtp07.blacknight.com
 [46.22.139.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4sSl0BkLzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 00:16:54 +1000 (AEST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
 by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id
 48A941C1A24
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 15:09:36 +0100 (IST)
Date: Thu, 4 Aug 2016 15:09:34 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] fadump: Register the memory reserved by fadump
Message-ID: <20160804140934.GM2799@techsingularity.net>
References: <1470318165-2521-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1470318165-2521-1-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 07:12:45PM +0530, Srikar Dronamraju wrote:
> Fadump kernel reserves large chunks of memory even before the pages are
> initialized. This could mean memory that corresponds to several nodes might
> fall in memblock reserved regions.
> 
> Kernels compiled with CONFIG_DEFERRED_STRUCT_PAGE_INIT will initialize
> only certain size memory per node. The certain size takes into account
> the dentry and inode cache sizes. Currently the cache sizes are
> calculated based on the total system memory including the reserved
> memory. However such a kernel when booting the same kernel as fadump
> kernel will not be able to allocate the required amount of memory to
> suffice for the dentry and inode caches. This results in crashes like
> the below on large systems such as 32 TB systems.
> 
> Dentry cache hash table entries: 536870912 (order: 16, 4294967296 bytes)
> vmalloc: allocation failure, allocated 4097114112 of 17179934720 bytes
> swapper/0: page allocation failure: order:0, mode:0x2080020(GFP_ATOMIC)
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6-master+ #3
> Call Trace:
> [c00000000108fb10] [c0000000007fac88] dump_stack+0xb0/0xf0 (unreliable)
> [c00000000108fb50] [c000000000235264] warn_alloc_failed+0x114/0x160
> [c00000000108fbf0] [c000000000281484] __vmalloc_node_range+0x304/0x340
> [c00000000108fca0] [c00000000028152c] __vmalloc+0x6c/0x90
> [c00000000108fd40] [c000000000aecfb0]
> alloc_large_system_hash+0x1b8/0x2c0
> [c00000000108fe00] [c000000000af7240] inode_init+0x94/0xe4
> [c00000000108fe80] [c000000000af6fec] vfs_caches_init+0x8c/0x13c
> [c00000000108ff00] [c000000000ac4014] start_kernel+0x50c/0x578
> [c00000000108ff90] [c000000000008c6c] start_here_common+0x20/0xa8
> 
> Register the memory reserved by fadump, so that the cache sizes are
> calculated based on the free memory (i.e Total memory - reserved
> memory).
> 
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>

I didn't suggest this specifically. While it happens to be safe on ppc64,
it potentially overwrites any future caller of set_dma_reserve. While the
only other one is for the e820 map, it may be better to change the API
to inc_dma_reserve?

It's also unfortunate that it's called dma_reserve because it has
nothing to do with DMA or ZONE_DMA. inc_kernel_reserve may be more
appropriate?

-- 
Mel Gorman
SUSE Labs
