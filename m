Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz6gH5YvKzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 15:51:07 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so13195595pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 22:51:07 -0700 (PDT)
Date: Tue, 26 Jul 2016 15:50:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 8/9] powerpc: Support to replay PMIs
Message-ID: <20160726155058.13651136@roar.ozlabs.ibm.com>
In-Reply-To: <1469458342-26233-9-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-9-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon, 25 Jul 2016 20:22:21 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Code to replay the Performance Monitoring Interrupts(PMI).
> In the masked_interrupt handler, for PMIs we reset the MSR[EE]
> and return. This is due the fact that PMIs are level triggered.
> In the __check_irq_replay(), we enabled the MSR[EE] which will
> fire the interrupt for us.
> 
> Patch also adds a new arch_local_irq_disable_var() variant. New
> variant takes an input value to write to the paca->soft_enabled.
> This will be used in following patch to implement the tri-state
> value for soft-enabled.

Same comment also applies about patches being standalone
transformations that work before and after. Some of these
can be squashed together I think.


> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 14 ++++++++++++++
>  arch/powerpc/kernel/irq.c         |  9 ++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h
> b/arch/powerpc/include/asm/hw_irq.h index cc69dde6eb84..863179654452
> 100644 --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -81,6 +81,20 @@ static inline unsigned long
> arch_local_irq_disable(void) return flags;
>  }
>  
> +static inline unsigned long arch_local_irq_disable_var(int value)
> +{
> +	unsigned long flags, zero;
> +
> +	asm volatile(
> +		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
> +		: "=r" (flags), "=&r" (zero)
> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> +		  "i" (value)
> +		: "memory");
> +
> +	return flags;
> +}

arch_ function suggests it is arch implementation of a generic
kernel function or something. I think our soft interrupt levels
are just used in powerpc specific code.

The name could also be a little more descriptive.

I would have our internal function be something like

soft_irq_set_level(), and then the arch disable just sets to
the appropriate level as it does today.

The PMU disable level could be implemented in powerpc specific
header with local_irq_and_pmu_disable() or something like that.

Thanks,
Nick
