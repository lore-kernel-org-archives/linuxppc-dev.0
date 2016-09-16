Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbC071yKqzDsbG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:56:55 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 21so2071052pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:56:55 -0700 (PDT)
Date: Fri, 16 Sep 2016 20:56:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/13] powerpc: Add a Kconfig and a functions to set new
 soft_enabled mask
Message-ID: <20160916205644.0663db70@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-13-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-13-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:32:02 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:


> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 9e5e9a6d4147..ae31b1e85fdb 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -209,6 +209,10 @@ notrace void arch_local_irq_restore(unsigned long en)
>  	unsigned char irq_happened;
>  	unsigned int replay;
>  
> +#ifdef CONFIG_IRQ_DEBUG_SUPPORT
> +	WARN_ON(en & local_paca->soft_enabled & ~IRQ_DISABLE_MASK_LINUX);
> +#endif
> +
>  	/* Write the new soft-enabled value */
>  	soft_enabled_set(en);
>  

Oh one other quick thing I just noticed: you could put this debug
check into your soft_enabled accessors.

We did decide it's okay for your masking level to go both ways,
didn't we? I.e.,

local_irq_disable();
local_irq_pmu_save(flags);
local_irq_pmu_restore(flags);
local_irq_enable();

-> LINUX -> LINUX|PMU -> LINUX ->

This means PMU interrupts would not get replayed despite being
enabled here. In practice I think that doesn't matter/can't happen
because a PMU interrupt while masked would hard disable anyway. A
comment explaining it might be nice though.

Thanks,
Nick
