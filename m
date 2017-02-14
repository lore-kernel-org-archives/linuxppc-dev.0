Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMpv13RR4zDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 15:13:33 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vMpv105tvz9s6s
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2017 15:13:32 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E49v9P119234
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2017 23:13:31 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28krc9583h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2017 23:13:31 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 09:43:28 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4D9C2125804F
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2017 09:43:28 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E4DQDs37814332
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2017 09:43:26 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E4DPN0004829
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2017 09:43:26 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: arbab@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mm: Fix build break with RADIX=y & HUGETLBFS=n
In-Reply-To: <1487038451-6119-1-git-send-email-mpe@ellerman.id.au>
References: <1487038451-6119-1-git-send-email-mpe@ellerman.id.au>
Date: Tue, 14 Feb 2017 09:43:20 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87inodv28v.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> If we enable RADIX but disable HUGETLBFS, the build breaks with:
>
>   arch/powerpc/mm/pgtable-radix.c:557:7: error: implicit declaration of function 'pmd_huge'
>   arch/powerpc/mm/pgtable-radix.c:588:7: error: implicit declaration of function 'pud_huge'
>
> Fix it by stubbing those functions when HUGETLBFS=n.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


> Fixes: 4b5d62ca17a1 ("powerpc/mm: add radix__remove_section_mapping()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable-4k.h  | 5 +++++
>  arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> index 9db83b4e017d..8708a0239a56 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> @@ -47,7 +47,12 @@ static inline int hugepd_ok(hugepd_t hpd)
>  	return hash__hugepd_ok(hpd);
>  }
>  #define is_hugepd(hpd)		(hugepd_ok(hpd))
> +
> +#else /* !CONFIG_HUGETLB_PAGE */
> +static inline int pmd_huge(pmd_t pmd) { return 0; }
> +static inline int pud_huge(pud_t pud) { return 0; }
>  #endif /* CONFIG_HUGETLB_PAGE */
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> index 198aff33c380..2ce4209399ed 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> @@ -46,6 +46,9 @@ static inline int hugepd_ok(hugepd_t hpd)
>  }
>  #define is_hugepd(pdep)			0
>
> +#else /* !CONFIG_HUGETLB_PAGE */
> +static inline int pmd_huge(pmd_t pmd) { return 0; }
> +static inline int pud_huge(pud_t pud) { return 0; }
>  #endif /* CONFIG_HUGETLB_PAGE */
>
>  static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
> -- 
> 2.7.4
