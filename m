Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttr2L1G92zDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 23:38:18 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id i5so37088023pgh.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 04:38:18 -0800 (PST)
Date: Wed, 4 Jan 2017 22:38:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 08/12] powerpc: Add support to mask perf interrupts
 and replay them
Message-ID: <20170104223801.739a09a7@roar.ozlabs.ibm.com>
In-Reply-To: <1483530590-30274-9-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483530590-30274-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1483530590-30274-9-git-send-email-maddy@linux.vnet.ibm.com>
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

On Wed,  4 Jan 2017 17:19:46 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> @@ -134,7 +137,7 @@ static inline bool arch_irqs_disabled(void)
>  	_was_enabled = local_paca->soft_enabled;	\
>  	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
>  	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
> -	if (!(_was_enabled & IRQ_DISABLE_MASK_LINUX))	\
> +	if (!(_was_enabled & IRQ_DISABLE_MASK_ALL))	\
>  		trace_hardirqs_off();			\
>  } while(0)

Hang on, maybe there's some confusion about this. trace_hardirqs_off() is
for Linux irqs (i.e., local_irq_disable()), so that should continue to
test just the LINUX mask I think. Otherwise this

    powerpc_local_pmu_disable();
    hard_irq_disable();

Will miss calling trace_hardirqs_off(). You don't have a function that
disables PMU irqs without Linux irqs, but one might exist.

What I was concerned about is actually setting the disable mask to ALL

  	local_paca->soft_enabled = IRQ_DISABLE_MASK_ALL;

No? Otherwise if you did

    powerpc_local_irq_pmu_disable();
    hard_irq_disable();

Then you would lose the PMU bit out of the mask.

Thanks,
Nick
