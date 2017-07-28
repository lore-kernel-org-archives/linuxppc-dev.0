Return-Path: <srs0=11tg=67=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJYb65fblzDrM9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 13:04:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xJYb64mMmz8sy4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 13:04:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xJYb60ytKz9s71
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2017 13:04:01 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6S2wt3t052009
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2017 23:04:00 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byqnv3dun-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2017 23:03:59 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 28 Jul 2017 13:03:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6S33sqa26148890
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2017 13:03:54 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6S33qYJ019973
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2017 13:03:53 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: joserz@linux.vnet.ibm.com, oohall@gmail.com, sjitindarsingh@gmail.com,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH v2] powerpc/mm: Fix pmd/pte_devmap() on non-leaf entries
In-Reply-To: <1501207681-2576-1-git-send-email-mpe@ellerman.id.au>
References: <1501207681-2576-1-git-send-email-mpe@ellerman.id.au>
Date: Fri, 28 Jul 2017 08:33:47 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d18l1cvg.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> From: Oliver O'Halloran <oohall@gmail.com>
>
> The Radix MMU translation tree as defined in ISA v3.0 contains two
> different types of entry, directories and leaves. Leaves are
> identified by _PAGE_PTE being set.
>
> The formats of the two entries are different, with the directory
> entries containing no spare bits for use by software. In particular
> the bit we use for _PAGE_DEVMAP is not reserved for software, and is
> part of the NLB (Next Level Base) field, essentially the address of
> the next level in the tree.
>
> Note that the Linux pte_t is not == _PAGE_PTE. A huge page pmd
> entry (or devmap!) is also a leaf and so has _PAGE_PTE set, even
> though we use a pmd_t for it in Linux.
>
> The fix is to ensure that the pmd/pte_devmap() confirm they are
> looking at a leaf entry (_PAGE_PTE) as well as checking _PAGE_DEVMAP.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> [mpe: Add a comment in the code and flesh out change log]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> v2: Add a comment in the code and flesh out change log
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index d1da415e283c..818a58fc3f4f 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -608,9 +608,17 @@ static inline pte_t pte_mkdevmap(pte_t pte)
>  	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
>  }
>  
> +/*
> + * This is potentially called with a pmd as the argument, in which case it's not
> + * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
> + * That's because the bit we use for _PAGE_DEVMAP is not reserved for software
> + * use in page directory entries (ie. non-ptes).
> + */
>  static inline int pte_devmap(pte_t pte)
>  {
> -	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
> +	u64 mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
> +
> +	return (pte_raw(pte) & mask) == mask;
>  }
>  
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> -- 
> 2.7.4
