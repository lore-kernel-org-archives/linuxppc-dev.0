Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvHH91xKvzDqMh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 17:05:57 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b1so39595165pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 22:05:57 -0800 (PST)
Date: Thu, 5 Jan 2017 16:05:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 08/12] powerpc: Add support to mask perf interrupts
 and replay them
Message-ID: <20170105160538.1fdb1b3c@roar.ozlabs.ibm.com>
In-Reply-To: <fff30cf9-a589-2a6d-ec87-40a92fb084a2@linux.vnet.ibm.com>
References: <1483530590-30274-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1483530590-30274-9-git-send-email-maddy@linux.vnet.ibm.com>
 <20170104223801.739a09a7@roar.ozlabs.ibm.com>
 <fff30cf9-a589-2a6d-ec87-40a92fb084a2@linux.vnet.ibm.com>
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

On Wed, 4 Jan 2017 22:21:05 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> On Wednesday 04 January 2017 06:08 PM, Nicholas Piggin wrote:
> > On Wed,  4 Jan 2017 17:19:46 +0530
> > Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
> >  
> >> @@ -134,7 +137,7 @@ static inline bool arch_irqs_disabled(void)
> >>   	_was_enabled = local_paca->soft_enabled;	\
> >>   	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
> >>   	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
> >> -	if (!(_was_enabled & IRQ_DISABLE_MASK_LINUX))	\
> >> +	if (!(_was_enabled & IRQ_DISABLE_MASK_ALL))	\
> >>   		trace_hardirqs_off();			\
> >>   } while(0)  
> > Hang on, maybe there's some confusion about this. trace_hardirqs_off() is
> > for Linux irqs (i.e., local_irq_disable()), so that should continue to
> > test just the LINUX mask I think. Otherwise this
> >
> >      powerpc_local_pmu_disable();
> >      hard_irq_disable();  
> 
> Currently we set both bits for pmu soft disable
> 
>                  flags = 
> soft_disabled_mask_or_return(IRQ_DISABLE_MASK_LINUX | \
> IRQ_DISABLE_MASK_PMU);                  \
> 
> So yes in the above seq, we will miss the pmu bit. But since 
> trace_hardirqs_off()
> is for _LINUX, instead will it not be safer to OR it?
> 
>          local_paca->soft_disabled_mask |= IRQ_DISABLE_MASK_LINUX;\

I would just say set all unconditionally. Despite "Linux" IRQs being the
special case, I would much prefer it to be written as much as possible
with all mask bits being equal, and then cases where LINUX bits need to
be handled differently built on that.

We might end up adding more bits, or even splitting the current single
LINUX bit into several others.

hard disable effectively masks all the interrupts, so then it seems we
should set them all in the disabled mask rather than just one. The
special case would then be just the test for the LINUX bit when deciding
whether to call trace_hardirqs_off().

Thanks,
Nick
