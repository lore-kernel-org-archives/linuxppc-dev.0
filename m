Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNtGG2lzbzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 13:49:26 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v743mllp070068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 23:49:23 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4dx7gceb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 23:49:23 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 13:49:20 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v743nIxv25231496
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 13:49:18 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v743n9xZ005873
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 13:49:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH] powerpc/mm: Invalidate partition table cache on host proc
 tbl base update
In-Reply-To: <20170803041551.7934-1-sjitindarsingh@gmail.com>
References: <20170803041551.7934-1-sjitindarsingh@gmail.com>
Date: Fri, 04 Aug 2017 09:19:04 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp6kngb3.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> The host process table base is stored in the partition table by calling
> the function native_register_process_table(). Currently this just sets
> the entry in memory and is missing a proceeding cache invalidation
> instruction. Any update to the partition table should be followed by a
> cache invalidation instruction specifying invalidation of the caching of
> any partition table entries (RIC = 2, PRS = 0).
>
> We already have a function to update the partition table with the
> required cache invalidation instructions - mmu_partition_table_set_entry().
> Update the native_register_process_table() function to call
> mmu_partition_table_set_entry(), this ensures all appropriate
> invalidation will be performed.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 671a45d..1d5178f 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -33,7 +33,8 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
>  {
>  	unsigned long patb1 = base | table_size | PATB_GR;
>
> -	partition_tb->patb1 = cpu_to_be64(patb1);
> +	mmu_partition_table_set_entry(0, be64_to_cpu(partition_tb->patb0),
> +				      patb1);
>  	return 0;
>  }
>
> -- 
> 2.9.4
