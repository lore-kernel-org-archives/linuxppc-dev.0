Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmRWS5VwbzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 18:53:24 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5C8mwAd132757
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 04:53:22 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b1m60sweu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 04:53:22 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 02:53:21 -0600
Date: Mon, 12 Jun 2017 14:23:16 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/14] powerpc/64s: idle provide a default idle for POWER9
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170611235835.7400-4-npiggin@gmail.com>
Message-Id: <20170612085316.GB10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Mon, Jun 12, 2017 at 09:58:24AM +1000, Nicholas Piggin wrote:
> Before the cpuidle driver is enabled, provide a default idle
> function similarly to POWER7/8.
> 
> This should not have much effect, because the cpuidle driver
> for powernv is mandatory, but if that changes we should have
> a fallback.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index f188d84d9c59..e327e1585ddc 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -677,6 +677,8 @@ static int __init pnv_init_idle_states(void)
> 
>  	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
>  		ppc_md.power_save = power7_idle;
> +	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
> +		ppc_md.power_save = power9_idle;

We are already initializing this in pnv_power9_idle_init() depending
on whether the device tree has exposed at least one INST_FAST idle
state. Else this should be NULL, because the firmware doesn't want us
to use a platform idle state!


> 
>  out:
>  	return 0;
> -- 
> 2.11.0
> 
