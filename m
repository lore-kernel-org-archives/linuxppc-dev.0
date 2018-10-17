Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3DECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 11:54:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32A621526
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 11:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32A621526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZrFP6sMGzDrL7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 22:54:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZrBR1BhyzF3Vv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 22:51:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42ZrBK52w1z9ttBL;
 Wed, 17 Oct 2018 13:51:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id QGTD0Sc6mw6I; Wed, 17 Oct 2018 13:51:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42ZrBK4NXpz9ttBK;
 Wed, 17 Oct 2018 13:51:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ECAD18B7FA;
 Wed, 17 Oct 2018 13:51:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id LtOwRRlLBntN; Wed, 17 Oct 2018 13:51:53 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B481F8B7F2;
 Wed, 17 Oct 2018 13:51:53 +0200 (CEST)
Subject: Re: [PATCH v5 21/22] powerpc/nohash32: allow setting GUARDED
 attribute in the PMD directly
From: Christophe LEROY <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <0dc7d683dfd155c85b9472bd2e24e7bea5907ca2.1537892499.git.christophe.leroy@c-s.fr>
Message-ID: <374bf0b3-0790-449b-d07c-c2c755fdeb1a@c-s.fr>
Date: Wed, 17 Oct 2018 13:51:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0dc7d683dfd155c85b9472bd2e24e7bea5907ca2.1537892499.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/09/2018 à 18:51, Christophe Leroy a écrit :
> On the 8xx, the GUARDED attribute of the pages is managed in the
> L1 entry, therefore to avoid having to copy it into L1 entry
> at each TLB miss, we have to set it in the PMD
> 
> In order to allow this, this patch splits the VM alloc space in two
> parts, one for VM alloc and non Guarded IO, and one for Guarded IO.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

I'm not too happy with this part, I think I'll drop it for now and 
rework it in a future serie to something more generic using mm slices.

Christophe

> ---
>   arch/powerpc/include/asm/book3s/32/pgalloc.h |  2 +-
>   arch/powerpc/include/asm/book3s/32/pgtable.h |  2 ++
>   arch/powerpc/include/asm/nohash/32/pgalloc.h | 19 ++++++++--
>   arch/powerpc/include/asm/nohash/32/pgtable.h | 19 ++++++++--
>   arch/powerpc/mm/dump_linuxpagetables.c       | 21 +++++++++--
>   arch/powerpc/mm/mem.c                        |  7 ++++
>   arch/powerpc/mm/pgtable_32.c                 | 52 +++++++++++++++++++++++++---
>   arch/powerpc/platforms/Kconfig.cputype       |  2 ++
>   8 files changed, 112 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> index 711a8b84e3ee..9097cfd4ce43 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> @@ -139,7 +139,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>   	pgtable_free_tlb(tlb, page_address(table), 0);
>   }
>   
> -static inline pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
> +static inline pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va, bool is_g)
>   {
>   	if (!pmd_present(*pmdp)) {
>   		pte_t *ptep = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 7a8a590f6b4c..28001d5eaa89 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -156,6 +156,8 @@ static inline bool pte_user(pte_t pte)
>   #define IOREMAP_TOP	KVIRT_TOP
>   #endif
>   
> +#define IOREMAP_BASE	VMALLOC_START
> +
>   /*
>    * Just any arbitrary offset to the start of the vmalloc VM area: the
>    * current 16MB value just means that there will be a 64MB "hole" after the
> diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> index 77c09bef3122..bfb26c385dac 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> @@ -60,6 +60,14 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
>   	*pmdp = __pmd(__pa(pte) | _PMD_PRESENT);
>   }
>   
> +#ifdef CONFIG_PPC_PMD_GUARDED
> +static inline void pmd_populate_kernel_g(struct mm_struct *mm, pmd_t *pmdp,
> +					 pte_t *pte)
> +{
> +	*pmdp = __pmd(__pa(pte) | _PMD_PRESENT | _PMD_GUARDED);
> +}
> +#endif
> +
>   static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
>   				pgtable_t pte_page)
>   {
> @@ -84,6 +92,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
>   #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
>   #endif
>   
> +#ifndef CONFIG_PPC_PMD_GUARDED
> +#define pmd_populate_kernel_g			pmd_populate_kernel
> +#endif
> +
>   static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>   					  unsigned long address)
>   {
> @@ -151,7 +163,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>   	pgtable_free_tlb(tlb, table, 0);
>   }
>   
> -static inline pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
> +static inline pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va, bool is_g)
>   {
>   	if (!pmd_present(*pmdp)) {
>   		pte_t *ptep = __va(memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE));
> @@ -164,7 +176,10 @@ static inline pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
>   		else
>   			memset(ptep, 0, PTE_FRAG_SIZE);
>   
> -		pmd_populate_kernel(&init_mm, pmdp, ptep);
> +		if (is_g)
> +			pmd_populate_kernel_g(&init_mm, pmdp, ptep);
> +		else
> +			pmd_populate_kernel(&init_mm, pmdp, ptep);
>   	}
>   	return pte_offset_kernel(pmdp, va);
>   }
> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
> index dc82c10383d5..fccc5620a988 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> @@ -84,9 +84,14 @@ extern int icache_44x_need_flush;
>    * virtual space that goes below PKMAP and FIXMAP
>    */
>   #ifdef CONFIG_HIGHMEM
> -#define KVIRT_TOP	PKMAP_BASE
> +#define _KVIRT_TOP	PKMAP_BASE
>   #else
> -#define KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
> +#define _KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
> +#endif
> +#ifdef CONFIG_PPC_PMD_GUARDED
> +#define KVIRT_TOP	_ALIGN_DOWN(_KVIRT_TOP, PGDIR_SIZE)
> +#else
> +#define KVIRT_TOP	_KVIRT_TOP
>   #endif
>   
>   /*
> @@ -99,6 +104,12 @@ extern int icache_44x_need_flush;
>   #else
>   #define IOREMAP_TOP	KVIRT_TOP
>   #endif
> +#ifdef CONFIG_PPC_PMD_GUARDED
> +#define IOREMAP_BASE	_ALIGN_UP(VMALLOC_START + (IOREMAP_TOP - VMALLOC_START) / 2, \
> +				  PGDIR_SIZE)
> +#else
> +#define IOREMAP_BASE	VMALLOC_START
> +#endif
>   
>   /*
>    * Just any arbitrary offset to the start of the vmalloc VM area: the
> @@ -123,7 +134,11 @@ extern int icache_44x_need_flush;
>   #else
>   #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
>   #endif
> +#ifdef CONFIG_PPC_PMD_GUARDED
> +#define VMALLOC_END	IOREMAP_BASE
> +#else
>   #define VMALLOC_END	ioremap_bot
> +#endif
>   
>   /*
>    * Bits in a linux-style PTE.  These match the bits in the
> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> index e60aa6d7456d..105d0118f735 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> @@ -76,9 +76,9 @@ struct addr_marker {
>   
>   static struct addr_marker address_markers[] = {
>   	{ 0,	"Start of kernel VM" },
> +#ifdef CONFIG_PPC64
>   	{ 0,	"vmalloc() Area" },
>   	{ 0,	"vmalloc() End" },
> -#ifdef CONFIG_PPC64
>   	{ 0,	"isa I/O start" },
>   	{ 0,	"isa I/O end" },
>   	{ 0,	"phb I/O start" },
> @@ -87,8 +87,19 @@ static struct addr_marker address_markers[] = {
>   	{ 0,	"I/O remap end" },
>   	{ 0,	"vmemmap start" },
>   #else
> +#ifdef CONFIG_PPC_PMD_GUARDED
> +	{ 0,	"vmalloc() Area" },
> +	{ 0,	"vmalloc() End" },
> +	{ 0,	"Early I/O remap start" },
> +	{ 0,	"Early I/O remap end" },
> +	{ 0,	"I/O remap start" },
> +	{ 0,	"I/O remap end" },
> +#else
>   	{ 0,	"Early I/O remap start" },
>   	{ 0,	"Early I/O remap end" },
> +	{ 0,	"vmalloc() I/O remap start" },
> +	{ 0,	"vmalloc() I/O remap end" },
> +#endif
>   #ifdef CONFIG_NOT_COHERENT_CACHE
>   	{ 0,	"Consistent mem start" },
>   	{ 0,	"Consistent mem end" },
> @@ -286,9 +297,9 @@ static void populate_markers(void)
>   	int i = 0;
>   
>   	address_markers[i++].start_address = PAGE_OFFSET;
> +#ifdef CONFIG_PPC64
>   	address_markers[i++].start_address = VMALLOC_START;
>   	address_markers[i++].start_address = VMALLOC_END;
> -#ifdef CONFIG_PPC64
>   	address_markers[i++].start_address = ISA_IO_BASE;
>   	address_markers[i++].start_address = ISA_IO_END;
>   	address_markers[i++].start_address = PHB_IO_BASE;
> @@ -301,6 +312,12 @@ static void populate_markers(void)
>   	address_markers[i++].start_address =  VMEMMAP_BASE;
>   #endif
>   #else /* !CONFIG_PPC64 */
> +#ifdef CONFIG_PPC_PMD_GUARDED
> +	address_markers[i++].start_address = VMALLOC_START;
> +	address_markers[i++].start_address = VMALLOC_END;
> +#endif
> +	address_markers[i++].start_address = IOREMAP_BASE;
> +	address_markers[i++].start_address = ioremap_bot;
>   	address_markers[i++].start_address = ioremap_bot;
>   	address_markers[i++].start_address = IOREMAP_TOP;
>   #ifdef CONFIG_NOT_COHERENT_CACHE
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index dd949d6649a2..1a4a20a95eaf 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -388,8 +388,15 @@ void __init mem_init(void)
>   #endif /* CONFIG_NOT_COHERENT_CACHE */
>   	pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
>   		ioremap_bot, IOREMAP_TOP);
> +#ifdef CONFIG_PPC_PMD_GUARDED
> +	pr_info("  * 0x%08lx..0x%08lx  : ioremap\n",
> +		IOREMAP_BASE, ioremap_bot);
> +	pr_info("  * 0x%08lx..0x%08lx  : vmalloc\n",
> +		VMALLOC_START, VMALLOC_END);
> +#else
>   	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
>   		VMALLOC_START, VMALLOC_END);
> +#endif
>   #endif /* CONFIG_PPC32 */
>   }
>   
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 745f2f30d4e9..ce78c06db660 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -151,7 +151,14 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
>   
>   	if (slab_is_available()) {
>   		struct vm_struct *area;
> -		area = get_vm_area_caller(size, VM_IOREMAP, caller);
> +		bool is_g = pgprot_val(prot) & _PAGE_GUARDED;
> +
> +		if (IS_ENABLED(CONFIG_PPC_PMD_GUARDED) && is_g)
> +			area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_BASE,
> +						    ioremap_bot, caller);
> +		else
> +			area = get_vm_area_caller(size, VM_IOREMAP, caller);
> +
>   		if (area == 0)
>   			return NULL;
>   		area->phys_addr = p;
> @@ -192,19 +199,54 @@ void iounmap(volatile void __iomem *addr)
>   }
>   EXPORT_SYMBOL(iounmap);
>   
> +#ifdef CONFIG_PPC_PMD_GUARDED
> +static int __pte_alloc_kernel_g(pmd_t *pmd, unsigned long address)
> +{
> +	pte_t *new = pte_alloc_one_kernel(&init_mm, address);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	smp_wmb(); /* See comment in __pte_alloc */
> +
> +	spin_lock(&init_mm.page_table_lock);
> +	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
> +		pmd_populate_kernel_g(&init_mm, pmd, new);
> +		new = NULL;
> +	}
> +	spin_unlock(&init_mm.page_table_lock);
> +	if (new)
> +		pte_free_kernel(&init_mm, new);
> +	return 0;
> +}
> +
> +static pte_t *pte_alloc_kernel_g(pmd_t *pmd, unsigned long address)
> +{
> +	if (unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel_g(pmd, address))
> +		return NULL;
> +	return pte_offset_kernel(pmd, address);
> +}
> +#else
> +#define pte_alloc_kernel_g(pmd, address)	pte_alloc_kernel(pmd, address)
> +#endif
> +
>   __ref int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
>   {
>   	pmd_t *pd;
>   	pte_t *pg;
>   	int err = -ENOMEM;
> +	bool is_g = pgprot_val(prot) & _PAGE_GUARDED;
>   
>   	/* Use upper 10 bits of VA to index the first level map */
>   	pd = pmd_offset(pud_offset(pgd_offset_k(va), va), va);
>   	/* Use middle 10 bits of VA to index the second-level map */
> -	if (slab_is_available())
> -		pg = pte_alloc_kernel(pd, va);
> -	else
> -		pg = early_pte_alloc_kernel(pd, va);
> +	if (slab_is_available()) {
> +		if (is_g)
> +			pg = pte_alloc_kernel_g(pd, va);
> +		else
> +			pg = pte_alloc_kernel(pd, va);
> +	} else {
> +		pg = early_pte_alloc_kernel(pd, va, is_g);
> +	}
>   	if (pg != 0) {
>   		err = 0;
>   		/* The PTE should never be already set nor present in the
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 6c6a7c72cae4..d0984546fbec 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -355,6 +355,8 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
>   	def_bool y
>   	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
>   
> +config PPC_PMD_GUARDED
> +	bool
>   
>   config PPC_MMU_NOHASH
>   	def_bool y
> 
