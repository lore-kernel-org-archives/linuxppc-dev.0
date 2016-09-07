Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTjhs0BX7zDsFJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 22:39:41 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 128so927673pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 05:39:40 -0700 (PDT)
Date: Wed, 7 Sep 2016 22:39:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 11/12] powerpc: Add a Kconfig and a function to
 set new soft_enabled mask
Message-ID: <20160907223921.1a3936df@roar.ozlabs.ibm.com>
In-Reply-To: <9fbb7a10-13a2-8542-2050-d73a958167d7@linux.vnet.ibm.com>
References: <1472409448-18172-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472409448-18172-12-git-send-email-maddy@linux.vnet.ibm.com>
 <20160829114129.7e68c805@roar.ozlabs.ibm.com>
 <9fbb7a10-13a2-8542-2050-d73a958167d7@linux.vnet.ibm.com>
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

On Mon, 5 Sep 2016 22:48:00 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> On Monday 29 August 2016 07:11 AM, Nicholas Piggin wrote:
> > On Mon, 29 Aug 2016 00:07:27 +0530
> > Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
> >  
> >> New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add a warn_on
> >> to alert the usage of soft_irq_set_mask() for disabling lower
> >> bitmask interrupts.
> >>
> >> Have also moved the code under the CONFIG_TRACE_IRQFLAGS in
> >> arch_local_irq_restore() to new Kconfig as suggested.
> >>
> >> Patch also adds a new soft_irq_set_mask() to update paca->soft_enabled.
> >>
> >> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> >> ---
> >>   arch/powerpc/Kconfig              |  4 ++++
> >>   arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
> >>   arch/powerpc/kernel/irq.c         |  4 ++--
> >>   3 files changed, 23 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >> index 927d2ab2ce08..878f05925340 100644
> >> --- a/arch/powerpc/Kconfig
> >> +++ b/arch/powerpc/Kconfig
> >> @@ -51,6 +51,10 @@ config TRACE_IRQFLAGS_SUPPORT
> >>   	bool
> >>   	default y
> >>   
> >> +config IRQ_DEBUG_SUPPORT
> >> +	bool
> >> +	default n
> >> +
> >>   config LOCKDEP_SUPPORT
> >>   	bool
> >>   	default y
> >> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> >> index 415734c07cfa..9f71559ce868 100644
> >> --- a/arch/powerpc/include/asm/hw_irq.h
> >> +++ b/arch/powerpc/include/asm/hw_irq.h
> >> @@ -81,6 +81,23 @@ static inline unsigned long arch_local_irq_disable(void)
> >>   	return flags;
> >>   }
> >>   
> >> +static inline unsigned long soft_irq_set_mask(int value)
> >> +{
> >> +	unsigned long flags, zero;
> >> +
> >> +#ifdef CONFIG_IRQ_DEBUG_SUPPORT
> >> +	WARN_ON(value <= IRQ_DISABLE_MASK_LINUX);
> >> +#endif
> >> +	asm volatile(
> >> +		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
> >> +		: "=r" (flags), "=&r" (zero)
> >> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> >> +		 "i" (value)
> >> +		: "memory");
> >> +
> >> +	return flags;
> >> +}  
> > One other thing, if we have:
> >
> > local_irq_save(flags);              // disable LINUX mask -> LINUX
> > local_irq_and_pmu_save(flags);      // disable PMU   mask -> LINUX|PMU
> > local_irq_and_pmu_restore(flags);   // enable  PMU   mask -> LINUX
> > local_irq_restore(flags);           // enable  LINUX mask -> NONE
> >
> > Then the nested code that re-enables PMUs will not replay PMU interrupt
> > until the outer irq is re-enabled. I don't *think* this is a problem,
> > but it probably should be commented.
> >
> > Which brings us to arch_local_irq_restore() (from another patch):
> >
> >
> > @@ -208,7 +209,7 @@ notrace void arch_local_irq_restore(unsigned long en)
> >
> >   	/* Write the new soft-enabled value */
> >   	set_soft_enabled(en);
> > -	if (!en)
> > +	if (en == IRQ_DISABLE_MASK_LINUX)
> >   		return;
> >   	/*
> >   	 * From this point onward, we can take interrupts, preempt,
> >
> > I think this is a bit buggy for some cases of nested disables. For the
> > above it is okay, but if we have:
> >
> > local_irq_and_pmu_save(flags);
> > local_irq_and_pmu_save(flags);
> > local_irq_and_pmu_restore(flags);
> > local_irq_and_pmu_restore(flags);
> >
> >
> > The first restore will restore LINUX|PMU mask, which will not be caught
> > by this check.
> >
> > Testing instead for non-zero (any IRQ bits masked) should work. We should
> > probably also add an IRQ_DEBUG_SUPPORT check to ensure LINUX bit is always
> > one of the outer-most bits to be cleared (theoretically we could support  
> 
> Just sent out the newer version of the patchset with most of the 
> comments addressed.

Thanks, I'm just having a look through it.


> But I am not sure about this comment. IIUC, will something like this 
> will do?
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index a02c6a3bc6fa..af0c08aefbcf 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -209,6 +209,11 @@ notrace void arch_local_irq_restore(unsigned long en)
>          unsigned char irq_happened;
>          unsigned int replay;
> 
> +#ifdef CONFIG_IRQ_DEBUG_SUPPORT
> +       WARN_ONCE (en & (en & local_paca->soft_enabled),
> +                  "soft_enabled transition to Unsupported state\n");
> +#endif
> +
>          /* Write the new soft-enabled value */
>          set_soft_enabled(en);

We want to make sure no new bits are set

  WARN_ON(en & ~local_paca->soft_enabled)

My other suggestion was just to ensure the LINUX bit is enabled last:

  WARN_ON(en & local_paca->soft_enabled & ~IRQ_DISABLE_MASK_LINUX)

Thanks,
Nick
