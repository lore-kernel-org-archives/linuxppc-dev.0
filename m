Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w5xRh3zY9zDqFl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 15:20:31 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3H5IxYx116021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 01:20:26 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ucey90cj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 01:20:26 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 10:50:23 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3H5IwLg7667824
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 10:48:58 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3H5KLrl025277
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 10:50:21 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Minor fix for MCE TLB flush for radix
In-Reply-To: <20170416142119.27242-1-npiggin@gmail.com>
References: <20170416142119.27242-1-npiggin@gmail.com>
Date: Mon, 17 Apr 2017 10:50:20 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgqzhap7.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> The TLB flush for radix first flushes TLB for radix configuration,
> then flushes for hash configuration. The second flush is unnecessary
> but does not affect correctness.
>
> Fixes: 1a472c9dba6b9 ("powerpc/mm/radix: Add tlbflush routines")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


> ---
>  arch/powerpc/kernel/mce_power.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index 763d6f58caa8..7b765aa9f2ff 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -72,10 +72,13 @@ void __flush_tlb_power8(unsigned int action)
>
>  void __flush_tlb_power9(unsigned int action)
>  {
> -	if (radix_enabled())
> -		flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
> +	unsigned int num_sets;
>
> -	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
> +	if (radix_enabled())
> +		num_sets = POWER9_TLB_SETS_RADIX;
> +	else
> +		num_sets = POWER9_TLB_SETS_HASH;
> +	flush_tlb_206(num_sets, action);
>  }
>
>
> -- 
> 2.11.0
