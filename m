Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDycX0ryzzDt26
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 20:36:59 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAA9Xu5P017204
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 04:36:57 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26md6fxv7v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 04:36:57 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 04:36:57 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, bsingharora@gmail.com
Subject: Re: [PATCH] powerpc/mm: Correct process and partition table max size
In-Reply-To: <1478669793-15074-1-git-send-email-sjitindarsingh@gmail.com>
References: <1478669793-15074-1-git-send-email-sjitindarsingh@gmail.com>
Date: Thu, 10 Nov 2016 15:06:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87eg2j1xsc.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> Version 3.00 of the ISA states that the PATS (partition table size) field
> of the PTCR (partition table control register) and the PRTS (process table
> size) field of the partition table entry must both be less than or equal
> to 24. However the actual size of the partition and process tables is equal
> to 2 to the power of 12 plus the PATS and PRTS fields, respectively. This
> means that the max allowable size of each of these tables is 2^36 or 64GB
> for both.
>
> Thus when checking the size shift for each we should be checking for values
> of greater than 36 instead of the current check for shifts larger than 24
> and 23.
>
> Fixes: 2bfd65e45e877fb5704730244da67c748d28a1b8
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/pgtable-radix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index ed7bddc..80f3479 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -159,7 +159,7 @@ static void __init radix_init_pgtable(void)
>  	 * Allocate Partition table and process table for the
>  	 * host.
>  	 */
> -	BUILD_BUG_ON_MSG((PRTB_SIZE_SHIFT > 23), "Process table size too large.");
> +	BUILD_BUG_ON_MSG((PRTB_SIZE_SHIFT > 36), "Process table size too large.");
>  	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT);
>  	/*
>  	 * Fill in the process table.
> @@ -181,7 +181,7 @@ static void __init radix_init_partition_table(void)
>
>  	rts_field = radix__get_tree_size();
>
> -	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
> +	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too large.");
>  	partition_tb = early_alloc_pgtable(1UL << PATB_SIZE_SHIFT);
>  	partition_tb->patb0 = cpu_to_be64(rts_field | __pa(init_mm.pgd) |
>  					  RADIX_PGD_INDEX_SIZE | PATB_HR);
> -- 
> 2.5.5
