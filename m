Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14C401A0331
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 23:16:07 +1100 (AEDT)
In-Reply-To: <1454980831-16631-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V3] powerpc/mm: Fix Multi hit ERAT cause by recent THP update
Message-Id: <20160209121606.EA46C140B97@ozlabs.org>
Date: Tue,  9 Feb 2016 23:16:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 01:20:31 UTC, "Aneesh Kumar K.V" wrote:
> With ppc64 we use the deposited pgtable_t to store the hash pte slot
> information. We should not withdraw the deposited pgtable_t without
> marking the pmd none. This ensure that low level hash fault handling
> will skip this huge pte and we will handle them at upper levels.
> 
> Recent change to pmd splitting changed the above in order to handle the
> race between pmd split and exit_mmap. The race is explained below.
> 
> Consider following race:
> 
> 		CPU0				CPU1
> shrink_page_list()
>   add_to_swap()
>     split_huge_page_to_list()
>       __split_huge_pmd_locked()
>         pmdp_huge_clear_flush_notify()
> 	// pmd_none() == true
> 					exit_mmap()
> 					  unmap_vmas()
> 					    zap_pmd_range()
> 					      // no action on pmd since pmd_none() == true
> 	pmd_populate()
> 
> As result the THP will not be freed. The leak is detected by check_mm():
> 
> 	BUG: Bad rss-counter state mm:ffff880058d2e580 idx:1 val:512
> 
> The above required us to not mark pmd none during a pmd split.
> 
> The fix for ppc is to clear the huge pte of _PAGE_USER, so that low
> level fault handling code skip this pte. At higher level we do take ptl
> lock. That should serialze us against the pmd split. Once the lock is
> acquired we do check the pmd again using pmd_same. That should always
> return false for us and hence we should retry the access. We do the
> pmd_same check in all case after taking plt with
> THP (do_huge_pmd_wp_page, do_huge_pmd_numa_page and
> huge_pmd_set_accessed)
> 
> Also make sure we wait for irq disable section in other cpus to finish
> before flipping a huge pte entry with a regular pmd entry. Code paths
> like find_linux_pte_or_hugepte depend on irq disable to get
> a stable pte_t pointer. A parallel thp split need to make sure we
> don't convert a pmd pte to a regular pmd entry without waiting for the
> irq disable section to finish.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9db4cd6c21535a4846b38808f3

cheers
