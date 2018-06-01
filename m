Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86b28drzF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:55:03 +1000 (AEST)
In-Reply-To: <20180530123225.7732-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm: Fix kernel crash on page table free
Message-Id: <40y86Z5Hqmz9s2k@ozlabs.org>
Date: Sat,  2 Jun 2018 01:55:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-30 at 12:32:25 UTC, "Aneesh Kumar K.V" wrote:
> Fix the below crash on BookE 64. pgtable_page_dtor expects struct page *arg.
> 
> Also call the destructor on non book3s platforms correctly. This free up the
> split ptl locks correctly if we had allocated them before.
> 
> Call Trace:
> [c0000000f30c7520] [c00000000021eeec] .kmem_cache_free+0x9c/0x44c (unreliable)
> [c0000000f30c75c0] [c0000000001ee07c] .ptlock_free+0x1c/0x30
> [c0000000f30c7630] [c0000000001ee260] .tlb_remove_table+0xdc/0x224
> [c0000000f30c76c0] [c0000000001ee640] .free_pgd_range+0x298/0x500
> [c0000000f30c77d0] [c000000000232afc] .shift_arg_pages+0x10c/0x1e0
> [c0000000f30c7910] [c000000000232dd0] .setup_arg_pages+0x200/0x25c
> [c0000000f30c79c0] [c0000000002ad4fc] .load_elf_binary+0x450/0x16c8
> [c0000000f30c7b10] [c000000000234914] .search_binary_handler.part.11+0x9c/0x248
> [c0000000f30c7bb0] [c00000000023595c] .do_execveat_common.isra.13+0x868/0xc18
> [c0000000f30c7cb0] [c00000000000184c] .run_init_process+0x34/0x4c
> [c0000000f30c7d30] [c000000000001880] .try_to_run_init_process+0x1c/0x68
> [c0000000f30c7db0] [c000000000002bd8] .kernel_init+0xdc/0x130
> [c0000000f30c7e30] [c0000000000009dc] .ret_from_kernel_thread+0x58/0x7c
> 
> Fixes: 702346768 ("powerpc/mm/nohash: Remove pte fragment dependency from nohash")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/667416f38554eef94485496f3a27b9

cheers
