Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hb8Z4CJkzF2Mg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 00:24:45 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4AENi2X048984
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 10:24:40 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hvmedh8yb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 10:24:35 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 10 May 2018 15:24:22 +0100
Subject: Re: [PATCH 1/2] powerpc/pmu/fsl: fix is_nmi test for irq mask change
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20180510010424.16854-1-npiggin@gmail.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 10 May 2018 19:54:18 +0530
MIME-Version: 1.0
In-Reply-To: <20180510010424.16854-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6bada32c-6b5e-1886-6353-9a554304381f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 10 May 2018 06:34 AM, Nicholas Piggin wrote:
> When soft enabled was changed to irq disabled mask, this test missed
> being converted (although the equivalent book3s test was converted).
>
> The PMU drivers consider it an NMI when they take a PMI while general
> interrupts are disabled. This change restores that behaviour.
Looks fine to me.
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> Fixes: 01417c6cc7 ("powerpc/64: Change soft_enabled from flag to bitmask")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/perf/core-fsl-emb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
> index 85f1d18e5fd3..ba485844d506 100644
> --- a/arch/powerpc/perf/core-fsl-emb.c
> +++ b/arch/powerpc/perf/core-fsl-emb.c
> @@ -42,7 +42,7 @@ static DEFINE_MUTEX(pmc_reserve_mutex);
>   static inline int perf_intr_is_nmi(struct pt_regs *regs)
>   {
>   #ifdef __powerpc64__
> -	return !regs->softe;
> +	return (regs->softe & IRQS_DISABLED);
>   #else
>   	return 0;
>   #endif
