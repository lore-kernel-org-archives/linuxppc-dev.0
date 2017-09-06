Return-Path: <pavrampu@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnHZn5qStzDrJL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 18:59:29 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v868xQx8139223
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Sep 2017 04:59:27 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ctb800d18-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Sep 2017 04:59:26 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pavrampu@linux.vnet.ibm.com>;
 Wed, 6 Sep 2017 04:59:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 06 Sep 2017 14:32:14 +0530
From: pavrampu <pavrampu@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Pavithra Prakash
 <pavrampu@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv: Clear LPCR[PECE1] via stop-api only for
 deep state offline
In-Reply-To: <1504180061-32345-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1504180061-32345-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <40a9c8f5d12d3885c1e54b9e4835eb25@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-08-31 17:17, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via
> stop-api only on Hotplug") clears the PECE1 bit of the LPCR via
> stop-api during CPU-Hotplug to prevent wakeup due to a decrementer on
> an offlined CPU which is in a deep stop state.
> 
> In the case where the stop-api support is found to be lacking, the
> commit 785a12afdb4a ("powerpc/powernv/idle: Disable LOSE_FULL_CONTEXT
> states when stop-api fails") disables deep states that lose hypervisor
> context. Thus in this case, the offlined CPU will be put to some
> shallow idle state.
> 
> However, we currently unconditionally clear the PECE1 in LPCR via
> stop-api during CPU-Hotplug even when deep states are disabled due to
> stop-api failure.
> 
> Fix this by clearing PECE1 of LPCR via stop-api during CPU-Hotplug
> *only* when the offlined CPU will be put to a deep state that loses
> hypervisor context.
> 
> Fixes: commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via
> stop-api only on Hotplug")
> 
> Reported-by: Pavithra Prakash <pavirampu@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Tested-by: Pavithra Prakash <pavrampu@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powernv/idle.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c
> b/arch/powerpc/platforms/powernv/idle.c
> index 9f59041..23f8fba 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -393,7 +393,13 @@ static void pnv_program_cpu_hotplug_lpcr(unsigned
> int cpu, u64 lpcr_val)
>  	u64 pir = get_hard_smp_processor_id(cpu);
> 
>  	mtspr(SPRN_LPCR, lpcr_val);
> -	opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
> +
> +	/*
> +	 * Program the LPCR via stop-api only for deepest stop state
> +	 * can lose hypervisor context.
> +	 */
> +	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
> +		opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
>  }
> 
>  /*
