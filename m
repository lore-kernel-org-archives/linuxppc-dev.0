Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/THP: Wait for all hash_page calls to finish
 before invalidating HPTE entries
In-reply-to: <1371624294-19451-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371624294-19451-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 19 Jun 2013 16:55:46 +1000
Message-ID: <7312.1371624946@ale.ozlabs.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> When we collapse normal pages to hugepage, we first clear the pmd, then invalidate all
> the PTE entries. The assumption here is that any low level page fault will see pmd as
> none and take the slow path that will wait on mmap_sem. But we could very well be in
> a hash_page with local ptep pointer value. Such a hash page can result in adding new
> HPTE entries for normal subpages/small page. That means we could be modifying the
> page content as we copy them to a huge page. Fix this by waiting on hash_page to finish
> after marking the pmd none and bfore invalidating HPTE entries. We use the heavy
> kick_all_cpus_sync(). This should be ok as we do this in the background khugepaged
> thread and not in application context. But we block page fault handling for this time.
> Also if we find collapse slow we can ideally increase the scan rate.

80 columns here

> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/pgtable_64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index bbecac4..4bb44c3 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -543,6 +543,14 @@ pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
>  		pmd = *pmdp;
>  		pmd_clear(pmdp);
>  		/*
> +		 * Wait for all pending hash_page to finish
> +		 * We can do this by waiting for a context switch to happen on
> +		 * the cpus. Any new hash_page after this will see pmd none
> +		 * and fallback to code that takes mmap_sem and hence will block
> +		 * for collapse to finish.
> +		 */
> +		kick_all_cpus_sync();
> +		/*

This doesn't apply on mainline... I assume it's needs your TPH patches?

Also, dumb question. Is this a bug we're fixing or just an optimisation?

Mikey



>  		 * Now invalidate the hpte entries in the range
>  		 * covered by pmd. This make sure we take a
>  		 * fault and will find the pmd as none, which will
> -- 
> 1.8.1.2
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
