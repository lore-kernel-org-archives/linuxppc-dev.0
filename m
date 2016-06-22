Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZ7280GlqzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 11:54:38 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5M1rs47037003
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 21:54:36 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q9navyq1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 21:54:36 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 22 Jun 2016 11:54:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6CEE23578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 11:54:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5M1sU9B23331010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 11:54:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5M1sTs5031151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 11:54:30 +1000
Subject: Re: [PATCH v6 07/11] powerpc/powernv: set power_save func after the
 idle states are initialized
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Jun 2016 11:54:28 +1000
In-Reply-To: <1465404871-5406-8-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-8-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1466560468.4089.7.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-08 at 11:54 -0500, Shreyas B. Prabhu wrote:
> pnv_init_idle_states discovers supported idle states from the
> device tree and does the required initialization. Set power_save
> function pointer only after this initialization is done
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Please merge that one as-is now, no need to wait for the rest, as
otherwise pwoer9 crashes at boot. It doesn't need to wait for the
rest of the series.

Cheers,
Ben.

> ---
> - No changes since v1
> 
>  arch/powerpc/platforms/powernv/idle.c  | 3 +++
>  arch/powerpc/platforms/powernv/setup.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c
> b/arch/powerpc/platforms/powernv/idle.c
> index fcc8b68..fbb09fb 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -285,6 +285,9 @@ static int __init pnv_init_idle_states(void)
>  	}
>  
>  	pnv_alloc_idle_core_states();
> +
> +	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
> +		ppc_md.power_save = power7_idle;
>  out_free:
>  	kfree(flags);
>  out:
> diff --git a/arch/powerpc/platforms/powernv/setup.c
> b/arch/powerpc/platforms/powernv/setup.c
> index ee6430b..8492bbb 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -315,7 +315,7 @@ define_machine(powernv) {
>  	.get_proc_freq          = pnv_get_proc_freq,
>  	.progress		= pnv_progress,
>  	.machine_shutdown	= pnv_shutdown,
> -	.power_save             = power7_idle,
> +	.power_save             = NULL,
>  	.calibrate_decr		= generic_calibrate_decr,
>  #ifdef CONFIG_KEXEC
>  	.kexec_cpu_down		= pnv_kexec_cpu_down,
