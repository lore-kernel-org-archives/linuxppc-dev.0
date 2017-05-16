Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRtpJ6zFYzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 20:23:52 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4GAK43I002020
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 06:23:47 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afs4shm30-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 06:23:47 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 May 2017 20:23:43 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4GANYdp3473898
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 20:23:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4GAN2tK021086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 20:23:03 +1000
Subject: Re: [PATCH v2 1/2] mm/hugetlb: Cleanup ARCH_HAS_GIGANTIC_PAGE
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, mpe@ellerman.id.au,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1494926264-22463-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 16 May 2017 15:52:46 +0530
MIME-Version: 1.0
In-Reply-To: <1494926264-22463-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <87c68117-3163-b092-ec51-1d618fc42b85@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2017 02:47 PM, Aneesh Kumar K.V wrote:
> This moves the #ifdef in C code to a Kconfig dependency. Also we move the
> gigantic_page_supported() function to be arch specific. This gives arch to
> conditionally enable runtime allocation of gigantic huge page. Architectures
> like ppc64 supports different gigantic huge page size (16G and 1G) based on the
> translation mode selected. This provides an opportunity for ppc64 to enable
> runtime allocation only w.r.t 1G hugepage.

Right.

> 
> No functional change in this patch.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/arm64/Kconfig               | 2 +-
>  arch/arm64/include/asm/hugetlb.h | 4 ++++
>  arch/s390/Kconfig                | 2 +-
>  arch/s390/include/asm/hugetlb.h  | 3 +++
>  arch/x86/Kconfig                 | 2 +-
>  mm/hugetlb.c                     | 7 ++-----
>  6 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3741859765cf..1f8c1f73aada 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -11,7 +11,7 @@ config ARM64
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> -	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_GIGANTIC_PAGE if MEMORY_ISOLATION && COMPACTION && CMA
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_SG_CHAIN
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index bbc1e35aa601..793bd73b0d07 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -83,4 +83,8 @@ extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  				  unsigned long addr, pte_t *ptep);
>  
> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> +static inline bool gigantic_page_supported(void) { return true; }
> +#endif
> +
>  #endif /* __ASM_HUGETLB_H */
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index a2dcef0aacc7..a41bbf420dda 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -67,7 +67,7 @@ config S390
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> -	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_GIGANTIC_PAGE if MEMORY_ISOLATION && COMPACTION && CMA
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_SG_CHAIN
> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> index cd546a245c68..89057b2cc8fe 100644
> --- a/arch/s390/include/asm/hugetlb.h
> +++ b/arch/s390/include/asm/hugetlb.h
> @@ -112,4 +112,7 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
>  	return pte_modify(pte, newprot);
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> +static inline bool gigantic_page_supported(void) { return true; }
> +#endif
>  #endif /* _ASM_S390_HUGETLB_H */
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index cc98d5a294ee..30a6328136ac 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -22,7 +22,7 @@ config X86_64
>  	def_bool y
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
> -	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_GIGANTIC_PAGE if MEMORY_ISOLATION && COMPACTION && CMA
>  	select ARCH_SUPPORTS_INT128
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select HAVE_ARCH_SOFT_DIRTY

Should not we define gigantic_page_supported() function for X86 as well
like the other two archs above ?
