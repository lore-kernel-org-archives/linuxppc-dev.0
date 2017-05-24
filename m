Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXmWF233BzDqcj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 18:57:45 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4O8iDMr068726
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 04:57:35 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2an22kbwc0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 04:57:34 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 24 May 2017 18:57:31 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4O8vMaG62980202
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 18:57:30 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4O8uuAe000662
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 18:56:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, mikey@neuling.org,
 Greg Johnson <gwj@google.com>
Subject: Re: [PATCH] powerpc: Fix booting P9 hash with CONFIG_PPC_RADIX_MMU=N
In-Reply-To: <20170524070326.13531-1-mikey@neuling.org>
References: <20170524070326.13531-1-mikey@neuling.org>
Date: Wed, 24 May 2017 14:26:38 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmqir5tl.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Currently if you disable CONFIG_PPC_RADIX_MMU you'll crash on boot on
> a P9. This is because we still set MMU_FTR_TYPE_RADIX via
> ibm,pa-features and MMU_FTR_TYPE_RADIX is what's used for code patching
> in much of the asm code (ie. slb_miss_realmode)
>
> This patch fixes the problem by stopping MMU_FTR_TYPE_RADIX from being
> set from ibm.pa-features.
>
> We may eventually end up removing the CONFIG_PPC_RADIX_MMU option
> completely but until then this fixes the issue.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/kernel/prom.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 40c4887c27..f830562974 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -161,7 +161,9 @@ static struct ibm_pa_feature {
>  	{ .pabyte = 0,  .pabit = 3, .cpu_features  = CPU_FTR_CTRL },
>  	{ .pabyte = 0,  .pabit = 6, .cpu_features  = CPU_FTR_NOEXECUTE },
>  	{ .pabyte = 1,  .pabit = 2, .mmu_features  = MMU_FTR_CI_LARGE_PAGE },
> +#ifdef CONFIG_PPC_RADIX_MMU
>  	{ .pabyte = 40, .pabit = 0, .mmu_features  = MMU_FTR_TYPE_RADIX },
> +#endif
>  	{ .pabyte = 1,  .pabit = 1, .invert = 1, .cpu_features = CPU_FTR_NODSISRALIGN },
>  	{ .pabyte = 5,  .pabit = 0, .cpu_features  = CPU_FTR_REAL_LE,
>  				    .cpu_user_ftrs = PPC_FEATURE_TRUE_LE },
> -- 
> 2.11.0

Instead can we do that feature removal in mmu_early_init_devtree. ie, something like

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 8f6f2a173e47..8f43f3827bac 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -394,7 +394,7 @@ void __init mmu_early_init_devtree(void)
 {
 	/* Disable radix mode based on kernel command line. */
 	/* We don't yet have the machinery to do radix as a guest. */
-	if (disable_radix || !(mfmsr() & MSR_HV))
+	if (!IS_ENABLED(CONFIG_PPC_RADIX_MMU) || disable_radix || !(mfmsr() & MSR_HV))
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
 	/*
