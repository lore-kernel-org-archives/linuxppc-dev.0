Return-Path: <aarcange@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 4E4122C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 01:15:26 +1000 (EST)
Date: Wed, 24 Apr 2013 17:14:57 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V6 18/27] mm/THP: withdraw the pgtable after pmdp
 related operations
Message-ID: <20130424151457.GA20440@redhat.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130422154901.GC13442@redhat.com>
 <87a9oo2t5a.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a9oo2t5a.fsf@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Apr 24, 2013 at 02:38:01PM +0530, Aneesh Kumar K.V wrote:
> From 7444a5eda33c00eea465b51c405cb830c57513b7 Mon Sep 17 00:00:00 2001
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Date: Wed, 6 Mar 2013 12:50:37 +0530
> Subject: [PATCH] mm/THP: withdraw the pgtable after pmdp related operations
> 
> For architectures like ppc64 we look at deposited pgtable when
> calling pmdp_get_and_clear. So do the pgtable_trans_huge_withdraw
> after finishing pmdp related operations.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  mm/huge_memory.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 84f3180..21c5ebd 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1363,9 +1363,15 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		struct page *page;
>  		pgtable_t pgtable;
>  		pmd_t orig_pmd;
> -		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
> +		/*
> +		 * For architectures like ppc64 we look at deposited pgtable
> +		 * when calling pmdp_get_and_clear. So do the
> +		 * pgtable_trans_huge_withdraw after finishing pmdp related
> +		 * operations.
> +		 */
>  		orig_pmd = pmdp_get_and_clear(tlb->mm, addr, pmd);
>  		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> +		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);

So I assume you're going to check the pmdp pointer address in
_withdraw, as the *pmd content is already clear. And that you're
checking the deposited pmd earlier in pmdp_get_and_clear. A bit
strange overall not seeing how exactly you're using the new parameter
and the deposited pmds, but safe.

Thanks,
Andrea
