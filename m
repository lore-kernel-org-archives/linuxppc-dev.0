Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEAFB1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 15:06:59 +1100 (AEDT)
Message-ID: <1424059606.21410.41.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: re-enable dynticks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 16 Feb 2015 15:06:46 +1100
In-Reply-To: <1424045319.3018.2.camel@ellerman.id.au>
References: <54DE52BC.3020303@us.ibm.com>
 <1424045319.3018.2.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-16 at 11:08 +1100, Michael Ellerman wrote:
> On Fri, 2015-02-13 at 13:38 -0600, Paul Clarke wrote:
> > implement arch_irq_work_has_interrupt() for powerpc
> > 
> > Commit 9b01f5bf3 introduced a dependency on "IRQ work self-IPIs" for 
> > full dynamic ticks to be enabled, by expecting architectures to 
> > implement a suitable arch_irq_work_has_interrupt() routine.
> > 
> > Several arches have implemented this routine, including x86 (3010279f) 
> > and arm (09f6edd4), but powerpc was omitted.
> > 
> > This patch implements this routine for powerpc.
> > 
 .../...
> 
> It makes the message change, but is that correct? ie. do we actually implement
> "IRQ work self-IPIs"?

I think so... Fred, do you think what we do will work ? We hijack our
decrementer (local timer) by making it shoot almost immediately (1 tick
away) and run the irq work at the beginning of __timer_interrupt().

At that point we are on our irq stack and have done irq_enter but that's
about it.

Cheers,
Ben.

> > diff --git a/arch/powerpc/include/asm/irq_work.h 
> > b/arch/powerpc/include/asm/irq_work.h
> > new file mode 100644
> > index 0000000..18365ec
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/irq_work.h
> > @@ -0,0 +1,11 @@
> > +#ifndef _ASM_IRQ_WORK_H
> > +#define _ASM_IRQ_WORK_H
> > +
> > +#include <asm/processor.h>
> > +
> > +static inline bool arch_irq_work_has_interrupt(void)
> > +{
> > +	return 1;
> 
> Should be "true";
> 
> > +}
> 
> cheers
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
