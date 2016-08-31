Return-Path: <mhocko@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPLDm3XQ9zDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 19:48:37 +1000 (AEST)
Date: Wed, 31 Aug 2016 11:48:33 +0200
From: Michal Hocko <mhocko@suse.cz>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 0/3] Account reserved memory when allocating system hash
Message-ID: <20160831094832.GA21661@dhcp22.suse.cz>
References: <1472476010-4709-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472476010-4709-1-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 29-08-16 18:36:47, Srikar Dronamraju wrote:
> Fadump kernel reserves large chunks of memory even before the pages are
> initialised. This could mean memory that corresponds to several nodes might
> fall in memblock reserved regions.
> 
> Kernels compiled with CONFIG_DEFERRED_STRUCT_PAGE_INIT will initialise
> only certain size memory per node. The certain size takes into account
> the dentry and inode cache sizes. However such a kernel when booting a
> secondary kernel will not be able to allocate the required amount of
> memory to suffice for the dentry and inode caches. This results in
> crashes like the below on large systems such as 32 TB systems.
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
> This patchset solves this problem by accounting the size of reserved memory
> when calculating the size of large system hashes.

So I think that this is just a fallout from how fadump is hackish and
tricky. Reserving large portion/majority of memory from the kernel just
sounds like a mind field. This patchset is dealing with one particular
problem. Fair enough, it seems like the easiest way to go and something
that would be stable backport safe as well so
Acked-by: Michal Hocko <mhocko@suse.com> to those whole series

but I cannot say I would be happy about the whole fadump thing...

> While this patchset applies on v4.8-rc3, it cannot be tested on v4.8-rc3
> because of http://lkml.kernel.org/r/20160829093844.GA2592@linux.vnet.ibm.com
> However it has been tested on v4.7/v4.6 and v4.4

another supporting argument for the above. 15 out of 16 nodes without
any memory... Sigh

> v2: http://lkml.kernel.org/r/1470330729-6273-1-git-send-email-srikar@linux.vnet.ibm.com 
> 
> Cc: linux-mm@kvack.org
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> 
> Srikar Dronamraju (3):
>   mm: Introduce arch_reserved_kernel_pages()
>   mm/memblock: Expose total reserved memory
>   powerpc: Implement arch_reserved_kernel_pages
> 
>  arch/powerpc/include/asm/mmzone.h |  3 +++
>  arch/powerpc/kernel/fadump.c      |  5 +++++
>  include/linux/memblock.h          |  1 +
>  include/linux/mm.h                |  3 +++
>  mm/memblock.c                     |  5 +++++
>  mm/page_alloc.c                   | 12 ++++++++++++
>  6 files changed, 29 insertions(+)
> 
> -- 
> 1.8.5.6

-- 
Michal Hocko
SUSE Labs
