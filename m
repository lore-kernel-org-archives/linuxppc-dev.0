Return-Path: <satyam.sharma@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 1EE96DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 16:45:57 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so486823wra
	for <linuxppc-dev@ozlabs.org>; Wed, 09 May 2007 23:45:56 -0700 (PDT)
Message-ID: <a781481a0705092345rf9fdc9cs8495516299a28fae@mail.gmail.com>
Date: Thu, 10 May 2007 12:15:55 +0530
From: "Satyam Sharma" <satyam.sharma@gmail.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
In-Reply-To: <20070509224113.cca81a24.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070510052622.3E8D5DDF4B@ozlabs.org>
	<20070509224113.cca81a24.akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

On 5/10/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 10 May 2007 15:25:58 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > --- linux-cell.orig/include/linux/interrupt.h 2007-05-10 14:51:22.000000000 +1000
> > +++ linux-cell/include/linux/interrupt.h      2007-05-10 15:18:04.000000000 +1000
> > @@ -241,6 +241,16 @@ static inline void __deprecated save_and
> >  #define save_and_cli(x)      save_and_cli(&x)
> >  #endif /* CONFIG_SMP */
> >
> > +/* Some architectures might implement lazy enabling/disabling of
> > + * interrupts. In some cases, such as stop_machine, we might want
> > + * to ensure that after a local_irq_disable(), interrupts have
> > + * really been disabled in hardware. Such architectures need to
> > + * implement the following hook.
> > + */
> > +#ifndef hard_irq_disable
> > +#define hard_irq_disable()   do { } while(0)
> > +#endif
>
> We absolutely require that the architecture's hard_irq_disable() be defined
> when we do this.  If it happens that the definition of hard_irq_disable()
> is implemented three levels deep in nested includes then we risk getting
> into a situation where different .c files see different implementations of
> hard_irq_disable(), which could lead to confusing results, to say the least.

So you're saying that this mechanism forces the arch (that really
wants hard_irq_disable) to _#define_ hard_irq_disable (as a macro),
and if it implements it as an inline function, for example, then we're
screwed?

> Your implementation comes via the inclusion of system.h which then includes
> hw_irq.h.  That's perhaps a little fragile and it would be better to
>
> a) include in the comment the name of the arch file which must implement
>    hard_irq_disable() and
>
> b) include that file directly from this one.

Hmmm. How about:

1. Introduce some CONFIG_WANTS_HARD_IRQ_DISABLE that is #defined (or
left undefined) by the arch/.../defconfig (depending upon whether or
not that arch implements a hard_irq_disable() for itself or not)

2. Then pull-in that code into include/linux/interrupt.h somehow
(through some known / fixed header file, or through asm/system.h, or
anyhow -- it doesn't really matter)

3. And:

#ifndef CONFIG_WANTS_HARD_IRQ_DISABLE
#define hard_irq_disable() do { } while(0)
#endif

We don't need to standardize on some particular arch-specific header
filename in this case.

Comments?

Satyam
