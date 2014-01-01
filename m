Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F6C22C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jan 2014 21:29:30 +1100 (EST)
Message-ID: <1388572145.4373.41.camel@pasglop>
Subject: Re: [PATCH] powerpc: thp: Fix crash on mremap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 01 Jan 2014 21:29:05 +1100
In-Reply-To: <1388570027-22933-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1388570027-22933-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aarcange@redhat.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 kirill.shutemov@linux.intel.com, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-01 at 15:23 +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This patch fix the below crash
> 
> NIP [c00000000004cee4] .__hash_page_thp+0x2a4/0x440
> LR [c0000000000439ac] .hash_page+0x18c/0x5e0
> ...
> Call Trace:
> [c000000736103c40] [00001ffffb000000] 0x1ffffb000000(unreliable)
> [437908.479693] [c000000736103d50] [c0000000000439ac] .hash_page+0x18c/0x5e0
> [437908.479699] [c000000736103e30] [c00000000000924c] .do_hash_page+0x4c/0x58
> 
> On ppc64 we use the pgtable for storing the hpte slot information and
> store address to the pgtable at a constant offset (PTRS_PER_PMD) from
> pmd. On mremap, when we switch the pmd, we need to withdraw and deposit
> the pgtable again, so that we find the pgtable at PTRS_PER_PMD offset
> from new pmd.
> 
> We also want to move the withdraw and deposit before the set_pmd so
> that, when page fault find the pmd as trans huge we can be sure that
> pgtable can be located at the offset.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> NOTE:
> For other archs we would just be removing the pgtable from the list and adding it back.
> I didn't find an easy way to make it not do that without lots of #ifdef around. Any
> suggestion around that is welcome.

What about

-		if (new_ptl != old_ptl) {
+               if (new_ptl != old_ptl || ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW) {

Or something similar ?

Cheers,
Ben.

>  mm/huge_memory.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7de1bf85f683..eb2e60d9ba45 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1500,24 +1500,23 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
>  	 */
>  	ret = __pmd_trans_huge_lock(old_pmd, vma, &old_ptl);
>  	if (ret == 1) {
> +		pgtable_t pgtable;
> +
>  		new_ptl = pmd_lockptr(mm, new_pmd);
>  		if (new_ptl != old_ptl)
>  			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>  		pmd = pmdp_get_and_clear(mm, old_addr, old_pmd);
>  		VM_BUG_ON(!pmd_none(*new_pmd));
> +		/*
> +		 * Archs like ppc64 use pgtable to store per pmd
> +		 * specific information. So when we switch the pmd,
> +		 * we should also withdraw and deposit the pgtable
> +		 */
> +		pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
> +		pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
>  		set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
> -		if (new_ptl != old_ptl) {
> -			pgtable_t pgtable;
> -
> -			/*
> -			 * Move preallocated PTE page table if new_pmd is on
> -			 * different PMD page table.
> -			 */
> -			pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
> -			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
> -
> +		if (new_ptl != old_ptl)
>  			spin_unlock(new_ptl);
> -		}
>  		spin_unlock(old_ptl);
>  	}
>  out:
