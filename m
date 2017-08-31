Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjh3R4cyPzDr79
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 22:08:19 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id t3so335583pgt.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:08:19 -0700 (PDT)
Date: Thu, 31 Aug 2017 22:07:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Pavithra Prakash
 <pavirampu@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv: Clear LPCR[PECE1] via stop-api only
 for deep state offline
Message-ID: <20170831220758.5a5d2171@roar.ozlabs.ibm.com>
In-Reply-To: <1504180061-32345-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1504180061-32345-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 31 Aug 2017 17:17:41 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

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

This looks okay to me. The bug is due to calling opal_slw_set_reg when
firmware has not enabled that feature, right?

> 
> Fixes: commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via
> stop-api only on Hotplug")
> 
> Reported-by: Pavithra Prakash <pavirampu@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 9f59041..23f8fba 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -393,7 +393,13 @@ static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
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
