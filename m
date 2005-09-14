Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20050914110506.GA7049@lst.de>
References: <1126643920.11056.53.camel@cashmere.sps.mot.com>
	<20050914110506.GA7049@lst.de>
Content-Type: text/plain
Message-Id: <1126705294.14036.4.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 14 Sep 2005 08:41:34 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/hardirq.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-09-14 at 06:05, Christoph Hellwig wrote:
> On Tue, Sep 13, 2005 at 03:38:40PM -0500, Jon Loeliger wrote:
> > +#ifndef _ASM_POWERPC_HARDIRQ_H
> > +#define _ASM_POWERPC_HARDIRQ_H
> > +#ifdef __KERNEL__
> 
> the __KERNEL__ ifdefs is not needed.  <asm/hardirq.h> is only included
> from <linux/hardirq.h> which doesn't have anything user-visible.

Will do.

> > +
> > +#include <linux/config.h>
> 
> not needed.
> 
> > +#include <linux/cache.h>
> > +
> > +#ifdef __powerpc64__
> > +#include <linux/preempt.h>
> > +#else
> > +#include <linux/smp_lock.h>
> > +#include <asm/irq.h>
> > +#endif
> 
> We shouldn't need either of these include blocks at all.

OK.  I'll do some out-ripping and verify that it
all compiles still.

> > +
> > +/* The __last_jiffy_stamp field is needed to ensure that no decrementer
> > + * interrupt is lost on SMP machines. Since on most CPUs it is in the same
> > + * cache line as local_irq_count, it is cheap to access and is also used on UP
> > + * for uniformity.
> > + */
> > +typedef struct {
> > +	unsigned int __softirq_pending;	/* set_bit is used on this */
> > +	unsigned int __last_jiffy_stamp;
> > +} ____cacheline_aligned irq_cpustat_t;
> 
> I'd suggest just using a DECLARE_PER_CPU variable for last_jiffy_stamp.
> In facct I plan to get rid of irq_cpustat_t completely at some point.

Hmmm... So, I don't want to mess that up.  How about I leave it
as I've suggested and leave that step up to you as a follow on?

Thanks,
jdl
