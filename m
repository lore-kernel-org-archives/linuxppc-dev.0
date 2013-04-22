Return-Path: <aarcange@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id D4E742C0130
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 01:49:54 +1000 (EST)
Date: Mon, 22 Apr 2013 17:49:02 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V6 18/27] mm/THP: withdraw the pgtable after pmdp
 related operations
Message-ID: <20130422154901.GC13442@redhat.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366624861-24948-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Mon, Apr 22, 2013 at 03:30:52PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> For architectures like ppc64 we look at deposited pgtable when
> calling pmdp_get_and_clear. So do the pgtable_trans_huge_withdraw
> after finishing pmdp related operations.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  mm/huge_memory.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 84f3180..2a43782 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1363,9 +1363,10 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		struct page *page;
>  		pgtable_t pgtable;
>  		pmd_t orig_pmd;
> -		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
> +
>  		orig_pmd = pmdp_get_and_clear(tlb->mm, addr, pmd);
>  		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> +		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
>  		if (is_huge_zero_pmd(orig_pmd)) {
>  			tlb->mm->nr_ptes--;
>  			spin_unlock(&tlb->mm->page_table_lock);

I think here a comment inline (not only in the commit msg) is in
order. Otherwise it's hard to imagine others to be aware of this arch
detail when they will read the code later. So it would be prone to
break later without a comment.

Thanks,
Andrea
