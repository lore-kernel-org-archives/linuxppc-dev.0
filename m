Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSMWv0pWDzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 14:58:02 +1000 (AEST)
Message-ID: <1494997069.3092.5.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/mm: Rename find_linux_pte_or_hugepte
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 May 2017 14:57:49 +1000
In-Reply-To: <87wp9g17tt.fsf@skywalker.in.ibm.com>
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494926782-25700-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494933772.21847.48.camel@kernel.crashing.org>
 <87wp9g17tt.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-17 at 08:57 +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Tue, 2017-05-16 at 14:56 +0530, Aneesh Kumar K.V wrote:
> > > +static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea,
> > > +                                   bool *is_thp, unsigned *hshift)
> > > +{
> > > +       VM_WARN((!arch_irqs_disabled() && !__hard_irqs_disabled()) ,
> > > +               "%s called with irq enabled\n", __func__);
> > > +       return __find_linux_pte(pgdir, ea, is_thp, hshift);
> > > +}
> > > +
> > 
> > When is arch_irqs_disabled() not sufficient ?
> 
> We can do lockless page table walk in interrupt handlers where we find
> MSR_EE = 0. 

Such as ?

> I was not sure we mark softenabled 0 there. What I wanted to
> indicate in the patch is that we are safe with either softenable = 0 or MSR_EE = 0

Reading the MSR is expensive...

Can you find a case where we are hard disabled and not soft disable in
C code ? I can't think of one off-hand ... I know we have some asm that
can do that very temporarily but I wouldn't think we have anything at
runtime.

Talking of which, we have this in irq.c:


#ifdef CONFIG_TRACE_IRQFLAGS
	else {
		/*
		 * We should already be hard disabled here. We had bugs
		 * where that wasn't the case so let's dbl check it and
		 * warn if we are wrong. Only do that when IRQ tracing
		 * is enabled as mfmsr() can be costly.
		 */
		if (WARN_ON(mfmsr() & MSR_EE))
			__hard_irq_disable();
	}
#endif

I think we should move that to a new CONFIG_PPC_DEBUG_LAZY_IRQ because
distros are likely to have CONFIG_TRACE_IRQFLAGS these days no ?

Also we could add additional checks, such as MSR_EE matching paca-
>irq_happened or the above you mentioned, ie, WARN if we find case
where IRQs are hard disabled but soft enabled.

If we find these, I think we should fix them.

Cheers,
Ben.
