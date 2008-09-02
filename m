Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5706CDDE41
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 03:12:29 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m82HCOjJ011296
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 13:12:24 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m82HCFUw109380
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 11:12:20 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m82HCEIP009568
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 11:12:14 -0600
Message-ID: <48BD73FB.1050601@linux.vnet.ibm.com>
Date: Tue, 02 Sep 2008 12:12:27 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: libhugetlbfs-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Buglet in 16G page handling
References: <20080902050510.GB12965@yookeroo.seuss>
In-Reply-To: <20080902050510.GB12965@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> When BenH and I were looking at the new code for handling 16G pages,
> we noticed a small bug.  It doesn't actually break anything user
> visible, but it's certainly not the way things are supposed to be.
> The 16G patches didn't update the huge_pte_offset() and
> huge_pte_alloc() functions, which means that the hugepte tables for
> 16G pages will be allocated much further down the page table tree than
> they should be - allocating several levels of page table with a single
> entry in them along the way.
>
> The patch below is supposed to fix this, cleaning up the existing
> handling of 64k vs 16M pages while its at it.  However, it needs some
> testing.
>
> I've checked that it doesn't break existing 16M support, either with
> 4k or 64k base pages.  I haven't figured out how to test with 64k
> pages yet, at least until the multisize support goes into
> libhugetlbfs.  For 16G pages, I just don't have access to a machine
> with enough memory to test.  Jon, presumably you must have found such
> a machine when you did the 16G page support in the first place.  Do
> you still have access, and can you test this patch?
>   
I do have access to a machine to test it.  I applied the patch to -rc4
and used a pseries_defconfig.  I boot with
default_hugepagesz=16G... in order to test huge page sizes other then
16M at this point.

Running the libhugetlbfs test suite it gets as far as   Readback (64):  
PASS
before it hits the following program check.

kernel BUG at arch/powerpc/mm/hugetlbpage.c:98!
cpu 0x0: Vector: 700 (Program Check) at [c0000002843db580]
    pc: c000000000035ff4: .free_hugepte_range+0x2c/0x7c
    lr: c000000000036af0: .hugetlb_free_pgd_range+0x2c0/0x398
    sp: c0000002843db800
   msr: 8000000000029032
  current = 0xc00000028417a2a0
  paca    = 0xc0000000008d4300
    pid   = 3334, comm = readback
kernel BUG at arch/powerpc/mm/hugetlbpage.c:98!
enter ? for help
[c0000002843db880] c000000000036af0 .hugetlb_free_pgd_range+0x2c0/0x398
[c0000002843db980] c0000000000da224 .free_pgtables+0x98/0x140
[c0000002843dba40] c0000000000dc4d8 .exit_mmap+0x13c/0x22c
[c0000002843dbb00] c00000000005b218 .mmput+0x78/0x148
[c0000002843dbba0] c000000000060528 .exit_mm+0x164/0x18c
[c0000002843dbc50] c000000000062718 .do_exit+0x2e8/0x858
[c0000002843dbd10] c000000000062d24 .do_group_exit+0x9c/0xd0
[c0000002843dbdb0] c000000000062d74 .sys_exit_group+0x1c/0x30
[c0000002843dbe30] c0000000000086d4 syscall_exit+0x0/0x40
--- Exception: c00 (System Call) at 000000802db7a530
SP (fffffa6e290) is in userspace


Line 98 appears to be this BUG_ON

static inline pte_t *hugepd_page(hugepd_t hpd)
{
        BUG_ON(!(hpd.pd & HUGEPD_OK));


Jon

> Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2008-09-02 13:39:52.000000000 +1000
> +++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2008-09-02 14:08:56.000000000 +1000
> @@ -128,29 +128,37 @@ static int __hugepte_alloc(struct mm_str
>  	return 0;
>  }
>
> -/* Base page size affects how we walk hugetlb page tables */
> -#ifdef CONFIG_PPC_64K_PAGES
> -#define hpmd_offset(pud, addr, h)	pmd_offset(pud, addr)
> -#define hpmd_alloc(mm, pud, addr, h)	pmd_alloc(mm, pud, addr)
> -#else
> -static inline
> -pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
> +
> +static pud_t *hpud_offset(pgd_t *pgd, unsigned long addr, struct hstate *hstate)
> +{
> +	if (huge_page_shift(hstate) < PUD_SHIFT)
> +		return pud_offset(pgd, addr);
> +	else
> +		return (pud_t *) pgd;
> +}
> +static pud_t *hpud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
> +			 struct hstate *hstate)
>  {
> -	if (huge_page_shift(hstate) == PAGE_SHIFT_64K)
> +	if (huge_page_shift(hstate) < PUD_SHIFT)
> +		return pud_alloc(mm, pgd, addr);
> +	else
> +		return (pud_t *) pgd;
> +}
> +static pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
> +{
> +	if (huge_page_shift(hstate) < PMD_SHIFT)
>  		return pmd_offset(pud, addr);
>  	else
>  		return (pmd_t *) pud;
>  }
> -static inline
> -pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
> -		  struct hstate *hstate)
> +static pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
> +			 struct hstate *hstate)
>  {
> -	if (huge_page_shift(hstate) == PAGE_SHIFT_64K)
> +	if (huge_page_shift(hstate) < PMD_SHIFT)
>  		return pmd_alloc(mm, pud, addr);
>  	else
>  		return (pmd_t *) pud;
>  }
> -#endif
>
>  /* Build list of addresses of gigantic pages.  This function is used in early
>   * boot before the buddy or bootmem allocator is setup.
> @@ -204,7 +212,7 @@ pte_t *huge_pte_offset(struct mm_struct 
>
>  	pg = pgd_offset(mm, addr);
>  	if (!pgd_none(*pg)) {
> -		pu = pud_offset(pg, addr);
> +		pu = hpud_offset(pg, addr, hstate);
>  		if (!pud_none(*pu)) {
>  			pm = hpmd_offset(pu, addr, hstate);
>  			if (!pmd_none(*pm))
> @@ -233,7 +241,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
>  	addr &= hstate->mask;
>
>  	pg = pgd_offset(mm, addr);
> -	pu = pud_alloc(mm, pg, addr);
> +	pu = hpud_alloc(mm, pg, addr, hstate);
>
>  	if (pu) {
>  		pm = hpmd_alloc(mm, pu, addr, hstate);
>
>
>   
