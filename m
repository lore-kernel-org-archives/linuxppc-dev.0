Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB67C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 08:40:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74A520811
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 08:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74A520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44G1CV58QVzDqK9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 19:40:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44G1971JB4zDqHf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 19:38:02 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x288Xl8A130262
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Mar 2019 03:38:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r3m6d29nx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Mar 2019 03:38:00 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Fri, 8 Mar 2019 08:37:57 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 8 Mar 2019 08:37:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x288bnKj60686356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2019 08:37:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 281C15204F;
 Fri,  8 Mar 2019 08:37:49 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.28])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id EF93D52052;
 Fri,  8 Mar 2019 08:37:46 +0000 (GMT)
Date: Fri, 8 Mar 2019 10:37:45 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v4 04/19] powerpc: mm: Add p?d_large() definitions
References: <20190306155031.4291-1-steven.price@arm.com>
 <20190306155031.4291-5-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306155031.4291-5-steven.price@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19030808-0028-0000-0000-0000035189F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030808-0029-0000-0000-0000240FFED7
Message-Id: <20190308083744.GA6592@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-08_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903080062
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 kvm-ppc@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 James Morse <james.morse@arm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 06, 2019 at 03:50:16PM +0000, Steven Price wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For powerpc pmd_large() was already implemented, so hoist it out of the
> CONFIG_TRANSPARENT_HUGEPAGE condition and implement the other levels.
> 
> Also since we now have a pmd_large always implemented we can drop the
> pmd_is_leaf() function.
> 
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: kvm-ppc@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 30 ++++++++++++++------

There is one more definition of pmd_large() in
arch/powerpc/include/asm/pgtable.h

>  arch/powerpc/kvm/book3s_64_mmu_radix.c       | 12 ++------
>  2 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index c9bfe526ca9d..c4b29caf2a3b 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -907,6 +907,12 @@ static inline int pud_present(pud_t pud)
>  	return (pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
>  }
> 
> +#define pud_large	pud_large
> +static inline int pud_large(pud_t pud)
> +{
> +	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> +}
> +
>  extern struct page *pud_page(pud_t pud);
>  extern struct page *pmd_page(pmd_t pmd);
>  static inline pte_t pud_pte(pud_t pud)
> @@ -954,6 +960,12 @@ static inline int pgd_present(pgd_t pgd)
>  	return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>  }
> 
> +#define pgd_large	pgd_large
> +static inline int pgd_large(pgd_t pgd)
> +{
> +	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
> +}
> +
>  static inline pte_t pgd_pte(pgd_t pgd)
>  {
>  	return __pte_raw(pgd_raw(pgd));
> @@ -1107,6 +1119,15 @@ static inline bool pmd_access_permitted(pmd_t pmd, bool write)
>  	return pte_access_permitted(pmd_pte(pmd), write);
>  }
> 
> +#define pmd_large	pmd_large
> +/*
> + * returns true for pmd migration entries, THP, devmap, hugetlb
> + */
> +static inline int pmd_large(pmd_t pmd)
> +{
> +	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
>  extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
> @@ -1133,15 +1154,6 @@ pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
>  	return hash__pmd_hugepage_update(mm, addr, pmdp, clr, set);
>  }
> 
> -/*
> - * returns true for pmd migration entries, THP, devmap, hugetlb
> - * But compile time dependent on THP config
> - */
> -static inline int pmd_large(pmd_t pmd)
> -{
> -	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> -}
> -
>  static inline pmd_t pmd_mknotpresent(pmd_t pmd)
>  {
>  	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> index 1b821c6efdef..040db20ac2ab 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> @@ -363,12 +363,6 @@ static void kvmppc_pte_free(pte_t *ptep)
>  	kmem_cache_free(kvm_pte_cache, ptep);
>  }
> 
> -/* Like pmd_huge() and pmd_large(), but works regardless of config options */
> -static inline int pmd_is_leaf(pmd_t pmd)
> -{
> -	return !!(pmd_val(pmd) & _PAGE_PTE);
> -}
> -
>  static pmd_t *kvmppc_pmd_alloc(void)
>  {
>  	return kmem_cache_alloc(kvm_pmd_cache, GFP_KERNEL);
> @@ -455,7 +449,7 @@ static void kvmppc_unmap_free_pmd(struct kvm *kvm, pmd_t *pmd, bool full,
>  	for (im = 0; im < PTRS_PER_PMD; ++im, ++p) {
>  		if (!pmd_present(*p))
>  			continue;
> -		if (pmd_is_leaf(*p)) {
> +		if (pmd_large(*p)) {
>  			if (full) {
>  				pmd_clear(p);
>  			} else {
> @@ -588,7 +582,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
>  	else if (level <= 1)
>  		new_pmd = kvmppc_pmd_alloc();
> 
> -	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_is_leaf(*pmd)))
> +	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_large(*pmd)))
>  		new_ptep = kvmppc_pte_alloc();
> 
>  	/* Check if we might have been invalidated; let the guest retry if so */
> @@ -657,7 +651,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
>  		new_pmd = NULL;
>  	}
>  	pmd = pmd_offset(pud, gpa);
> -	if (pmd_is_leaf(*pmd)) {
> +	if (pmd_large(*pmd)) {
>  		unsigned long lgpa = gpa & PMD_MASK;
> 
>  		/* Check if we raced and someone else has set the same thing */
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

