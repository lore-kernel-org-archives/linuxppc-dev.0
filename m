Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGs460HxmzDqCw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:34:13 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v162YCRg146770
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Feb 2017 21:34:12 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28d8qrpeyr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Feb 2017 21:34:11 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 08:04:06 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 117C7E0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 08:05:28 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v162Y3Yr20709474
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 08:04:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v162Y2ol027100
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 08:04:03 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Fix typo in set_pte_at()
In-Reply-To: <1486340396-24609-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1486340396-24609-1-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Mon, 06 Feb 2017 08:03:57 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw88gi96.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> This fixes the typo about the _PAGE_PTE in set_pte_at() by changing
> "tryint" to "trying to".
>
> Fixes: 6a119eae942 ("powerpc/mm: Add a _PAGE_PTE bit")

I guess this is not needed. We add that when we want to hint whether the
patch needs backporting. 


> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/pgtable.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index cb39c8b..a03ff3d 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -193,9 +193,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>  	 */
>  	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
>
> -	/*
> -	 * Add the pte bit when tryint set a pte
> -	 */
> +	/* Add the pte bit when trying to set a pte */
>  	pte = __pte(pte_val(pte) | _PAGE_PTE);
>
>  	/* Note: mm->context.id might not yet have been assigned as
> -- 
> 2.7.4
