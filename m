Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2hQW3d0CzDqRV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 18:22:59 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 75so7310736pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 23:22:59 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 17 Jan 2017 12:52:51 +0530
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 3/4] powerpc/mm: add radix__remove_section_mapping()
Message-ID: <20170117072251.GD8963@dhcp-9-109-223-248.in.ibm.com>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-4-git-send-email-arbab@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484593666-8001-4-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 01:07:45PM -0600, Reza Arbab wrote:
> Tear down and free the four-level page tables of physical mappings
> during memory hotremove.
> 
> Borrow the basic structure of remove_pagetable() and friends from the
> identically-named x86 functions. Reduce the frequency of tlb flushes and
> page_table_lock spinlocks by only doing them in the outermost function.
> There was some question as to whether the locking is needed at all.
> Leave it for now, but we could consider dropping it.
> 
> Memory must be offline to be removed, thus not in use. So there
> shouldn't be the sort of concurrent page walking activity here that
> might prompt us to use RCU.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/radix.h |   1 +
>  arch/powerpc/mm/pgtable-book3s64.c         |   2 +-
>  arch/powerpc/mm/pgtable-radix.c            | 133 +++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index 43c2571..0032b66 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -294,6 +294,7 @@ static inline unsigned long radix__get_tree_size(void)
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  int radix__create_section_mapping(unsigned long start, unsigned long end);
> +int radix__remove_section_mapping(unsigned long start, unsigned long end);
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  #endif /* __ASSEMBLY__ */
>  #endif
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 2b13f6b..b798ff6 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -139,7 +139,7 @@ int create_section_mapping(unsigned long start, unsigned long end)
>  int remove_section_mapping(unsigned long start, unsigned long end)
>  {
>  	if (radix_enabled())
> -		return -ENODEV;
> +		return radix__remove_section_mapping(start, end);
>  
>  	return hash__remove_section_mapping(start, end);
>  }
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 075b4ec..cfba666 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -476,10 +476,143 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
>  }
>

Shouldn't most of these functions have __meminit?
  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> +static void free_pte_table(pte_t *pte_start, pmd_t *pmd)
> +{
> +	pte_t *pte;
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++) {
> +		pte = pte_start + i;
> +		if (!pte_none(*pte))
> +			return;

If !pte_none() we fail the hotplug? Or silently
leave the allocated pte's around. I guess this is
the same as x86

> +	}
> +
> +	pte_free_kernel(&init_mm, pte_start);
> +	pmd_clear(pmd);
> +}
> +
> +static void free_pmd_table(pmd_t *pmd_start, pud_t *pud)
> +{
> +	pmd_t *pmd;
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++) {
> +		pmd = pmd_start + i;
> +		if (!pmd_none(*pmd))
> +			return;
> +	}
> +
> +	pmd_free(&init_mm, pmd_start);
> +	pud_clear(pud);
> +}
> +
> +static void remove_pte_table(pte_t *pte_start, unsigned long addr,
> +			     unsigned long end)
> +{
> +	unsigned long next;
> +	pte_t *pte;
> +
> +	pte = pte_start + pte_index(addr);
> +	for (; addr < end; addr = next, pte++) {
> +		next = (addr + PAGE_SIZE) & PAGE_MASK;
> +		if (next > end)
> +			next = end;
> +
> +		if (!pte_present(*pte))
> +			continue;
> +
> +		pte_clear(&init_mm, addr, pte);
> +	}
> +}
> +
> +static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
> +			     unsigned long end)
> +{
> +	unsigned long next;
> +	pte_t *pte_base;
> +	pmd_t *pmd;
> +
> +	pmd = pmd_start + pmd_index(addr);
> +	for (; addr < end; addr = next, pmd++) {
> +		next = pmd_addr_end(addr, end);
> +
> +		if (!pmd_present(*pmd))
> +			continue;
> +
> +		if (pmd_huge(*pmd)) {
> +			pte_clear(&init_mm, addr, (pte_t *)pmd);

pmd_clear()?

> +			continue;
> +		}
> +
> +		pte_base = (pte_t *)pmd_page_vaddr(*pmd);
> +		remove_pte_table(pte_base, addr, next);
> +		free_pte_table(pte_base, pmd);
> +	}
> +}
> +
> +static void remove_pud_table(pud_t *pud_start, unsigned long addr,
> +			     unsigned long end)
> +{
> +	unsigned long next;
> +	pmd_t *pmd_base;
> +	pud_t *pud;
> +
> +	pud = pud_start + pud_index(addr);
> +	for (; addr < end; addr = next, pud++) {
> +		next = pud_addr_end(addr, end);
> +
> +		if (!pud_present(*pud))
> +			continue;
> +
> +		if (pud_huge(*pud)) {
> +			pte_clear(&init_mm, addr, (pte_t *)pud);
pud_clear()?
> +			continue;
> +		}
> +
> +		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
> +		remove_pmd_table(pmd_base, addr, next);
> +		free_pmd_table(pmd_base, pud);
> +	}
> +}
> +
> +static void remove_pagetable(unsigned long start, unsigned long end)
> +{
> +	unsigned long addr, next;
> +	pud_t *pud_base;
> +	pgd_t *pgd;
> +
> +	spin_lock(&init_mm.page_table_lock);
> +

x86 does more granular lock acquisition only during
clearing the relevant entries. I suppose we don't have
to worry about it since its not fast path and frequent.

Balbir Singh.
