Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 077E71A03CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 15:32:12 +1000 (EST)
Message-ID: <1406007123.22200.11.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc: thp: invalidate old 64K based hash page
 mapping before insert
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 22 Jul 2014 15:32:03 +1000
In-Reply-To: <1405435927-24027-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1405435927-24027-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1405435927-24027-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-15 at 20:22 +0530, Aneesh Kumar K.V wrote:
> If we changed base page size of the segment, either via sub_page_protect
> or via remap_4k_pfn, we do a demote_segment which doesn't flush the hash
> table entries. We do that when inserting a new hash pte by checking the
> _PAGE_COMBO flag. We missed to do that when inserting hash for a new 16MB
> page. Add the same. This patch mark the 4k base page size 16MB hugepage
> via _PAGE_COMBO.

please improve the above, I don't understand it.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hugepage-hash64.c | 66 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
> index 826893fcb3a7..28d1b8b93674 100644
> --- a/arch/powerpc/mm/hugepage-hash64.c
> +++ b/arch/powerpc/mm/hugepage-hash64.c
> @@ -18,6 +18,56 @@
>  #include <linux/mm.h>
>  #include <asm/machdep.h>
>  
> +static void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
> +				pmd_t *pmdp, unsigned int psize, int ssize)
> +{

What do that function do ? From the name of it, it would be used
whenever one wants to flush a huge page out of the hash, and thus would
be rather generic, but you only use it in a fairly narrow special
case...

> +	int i, max_hpte_count, valid;
> +	unsigned long s_addr = addr;
> +	unsigned char *hpte_slot_array;
> +	unsigned long hidx, shift, vpn, hash, slot;
> +
> +	hpte_slot_array = get_hpte_slot_array(pmdp);
> +	/*
> +	 * IF we try to do a HUGE PTE update after a withdraw is done.
> +	 * we will find the below NULL. This happens when we do
> +	 * split_huge_page_pmd
> +	 */
> +	if (!hpte_slot_array)
> +		return;

Can I assume we proper synchronization here ? (Interrupt off vs. IPIs on
the withdraw side or something similar ?)

> +	if (ppc_md.hugepage_invalidate)
> +		return ppc_md.hugepage_invalidate(vsid, addr, hpte_slot_array,
> +						  psize, ssize);
> +	/*
> +	 * No bluk hpte removal support, invalidate each entry
> +	 */
> +	shift = mmu_psize_defs[psize].shift;
> +	max_hpte_count = HPAGE_PMD_SIZE >> shift;
> +	for (i = 0; i < max_hpte_count; i++) {
> +		/*
> +		 * 8 bits per each hpte entries
> +		 * 000| [ secondary group (one bit) | hidx (3 bits) | valid bit]
> +		 */
> +		valid = hpte_valid(hpte_slot_array, i);
> +		if (!valid)
> +			continue;
> +		hidx =  hpte_hash_index(hpte_slot_array, i);
> +
> +		/* get the vpn */
> +		addr = s_addr + (i * (1ul << shift));
> +		vpn = hpt_vpn(addr, vsid, ssize);
> +		hash = hpt_hash(vpn, shift, ssize);
> +		if (hidx & _PTEIDX_SECONDARY)
> +			hash = ~hash;
> +
> +		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> +		slot += hidx & _PTEIDX_GROUP_IX;
> +		ppc_md.hpte_invalidate(slot, vpn, psize,
> +				       MMU_PAGE_16M, ssize, 0);
> +	}
> +}
> +
> +
>  int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>  		    pmd_t *pmdp, unsigned long trap, int local, int ssize,
>  		    unsigned int psize)
> @@ -85,6 +135,15 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>  	vpn = hpt_vpn(ea, vsid, ssize);
>  	hash = hpt_hash(vpn, shift, ssize);
>  	hpte_slot_array = get_hpte_slot_array(pmdp);
> +	if (psize == MMU_PAGE_4K) {
> +		/*
> +		 * invalidate the old hpte entry if we have that mapped via 64K
> +		 * base page size. This is because demote_segment won't flush
> +		 * hash page table entries.
> +		 */

Please provide a better explanation of the scenario, this is really not
clear to me.

> +		if (!(old_pmd & _PAGE_COMBO))
> +			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K, ssize);
> +	}
>  
>  	valid = hpte_valid(hpte_slot_array, index);
>  	if (valid) {
> @@ -172,6 +231,13 @@ repeat:
>  		mark_hpte_slot_valid(hpte_slot_array, index, slot);
>  	}
>  	/*
> +	 * Mark the pte with _PAGE_COMBO, if we are trying to hash it with
> +	 * base page size 4k.
> +	 */
> +	if (psize == MMU_PAGE_4K)
> +		new_pmd |= _PAGE_COMBO;
> +
> +

Why ? Please explain.

Ben.

> 	/*
>  	 * No need to use ldarx/stdcx here
>  	 */
>  	*pmdp = __pmd(new_pmd & ~_PAGE_BUSY);
