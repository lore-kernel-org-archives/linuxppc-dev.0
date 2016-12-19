Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thx1Z1lFQzDwKW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 20:48:17 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJ9iPil024635
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 04:48:15 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27e81ntt7u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 04:48:15 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 02:48:14 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v3 4/5] powerpc/mm: add radix__remove_section_mapping()
In-Reply-To: <1481831443-22761-5-git-send-email-arbab@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-5-git-send-email-arbab@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 15:18:07 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wpewtfl4.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> Tear down and free the four-level page tables of the linear mapping
> during memory hotremove.
>
> We borrow the basic structure of remove_pagetable() and friends from the
> identically-named x86 functions.
>

Can you add more details here, which explain why we don't need to follow
the RCU page table free when doing memory hotunplug ?

> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/radix.h |   1 +
>  arch/powerpc/mm/pgtable-book3s64.c         |   2 +-
>  arch/powerpc/mm/pgtable-radix.c            | 163 +++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+), 1 deletion(-)
>
....
....


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
> +		spin_lock(&init_mm.page_table_lock);
> +		pte_clear(&init_mm, addr, pte);
> +		spin_unlock(&init_mm.page_table_lock);
> +	}
> +
> +	flush_tlb_mm(&init_mm);

Why call a flush here. we do that at the end of remove_page_table .
Isn't that sufficient ?

> +}
> +
> +static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
> +			     unsigned long end, unsigned long map_page_size)
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
> +		if (map_page_size == PMD_SIZE) {
> +			spin_lock(&init_mm.page_table_lock);
> +			pte_clear(&init_mm, addr, (pte_t *)pmd);
> +			spin_unlock(&init_mm.page_table_lock);
> +
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
> +			     unsigned long end, unsigned long map_page_size)
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
> +		if (map_page_size == PUD_SIZE) {
> +			spin_lock(&init_mm.page_table_lock);
> +			pte_clear(&init_mm, addr, (pte_t *)pud);
> +			spin_unlock(&init_mm.page_table_lock);
> +
> +			continue;
> +		}
> +
> +		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
> +		remove_pmd_table(pmd_base, addr, next, map_page_size);
> +		free_pmd_table(pmd_base, pud);
> +	}
> +}
> +
> +static void remove_pagetable(unsigned long start, unsigned long end,
> +			     unsigned long map_page_size)
> +{
> +	unsigned long next;
> +	unsigned long addr;
> +	pgd_t *pgd;
> +	pud_t *pud;
> +
> +	for (addr = start; addr < end; addr = next) {
> +		next = pgd_addr_end(addr, end);
> +
> +		pgd = pgd_offset_k(addr);
> +		if (!pgd_present(*pgd))
> +			continue;
> +
> +		pud = (pud_t *)pgd_page_vaddr(*pgd);
> +		remove_pud_table(pud, addr, next, map_page_size);
> +		free_pud_table(pud, pgd);
> +	}
> +
> +	flush_tlb_mm(&init_mm);


So we want to flush the full kernel tlb when we do a hotplug ?
May be check using flush_tlb_kernel_range(). Also that flush_tlb_mm() do
check for mm_is_thread_local(). Do we update init_mm correct to handle
that check ? I assume we want a tlbie() here instead of tlbiel() ?


> +}
> +
>  int radix__create_section_mapping(unsigned long start, unsigned long end)
>  {
>  	unsigned long page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;
> @@ -482,6 +635,16 @@ int radix__create_section_mapping(unsigned long start, unsigned long end)
>
>  	return 0;
>  }
> +
> +int radix__remove_section_mapping(unsigned long start, unsigned long end)
> +{
> +	unsigned long page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;
> +
> +	start = _ALIGN_DOWN(start, page_size);
> +	remove_pagetable(start, end, page_size);
> +
> +	return 0;
> +}
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP


-aneesh
