Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJ7zw0vDwzDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 20:50:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RAmirj120619
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 06:50:33 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bydde3v2u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 06:50:32 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 06:50:32 -0400
Subject: Re: [RFC PATCH 3/3] mm/hugetlb: Remove pmd_huge_split_prepare
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill@shutemov.name>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727083756.32217-3-aneesh.kumar@linux.vnet.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 16:20:25 +0530
MIME-Version: 1.0
In-Reply-To: <20170727083756.32217-3-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <912dcb7d-4dff-979a-3777-2e9e13a7adda@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/27/2017 02:07 PM, Aneesh Kumar K.V wrote:

> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 8c8fb6fbdabe..b856e130c678 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -164,8 +164,6 @@ extern pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma,
>   extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>   					 pgtable_t pgtable);
>   extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
> -extern void hash__pmdp_huge_split_prepare(struct vm_area_struct *vma,
> 
> @@ -1956,14 +1956,39 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   		return __split_huge_zero_page_pmd(vma, haddr, pmd);
>   	}
> 


....

> +	 */
> +	old_pmd = pmdp_invalidate(vma, haddr, pmd);
> +
> +	page = pmd_page(old_pmd);
>   	VM_BUG_ON_PAGE(!page_count(page), page);
>   	page_ref_add(page, HPAGE_PMD_NR - 1);
> -	write = pmd_write(*pmd);
> -	young = pmd_young(*pmd);
> -	soft_dirty = pmd_soft_dirty(*pmd);
> -
> -	pmdp_huge_split_prepare(vma, haddr, pmd);
> +	write = pmd_write(old_pmd);
> +	young = pmd_young(old_pmd);
> +	dirty = pmd_dirty(*pmd);

This should be

	dirty = pmd_dirty(old_pmd);


> +	soft_dirty = pmd_soft_dirty(old_pmd);
> +	/*
> +	 * withdraw the table only after we mark the pmd entry invalid
> +	 */
>   	pgtable = pgtable_trans_huge_withdraw(mm, pmd);

-aneesh
