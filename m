Return-Path: <hch@lst.de>
Date: Wed, 14 Sep 2005 13:05:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050914110506.GA7049@lst.de>
References: <1126643920.11056.53.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126643920.11056.53.camel@cashmere.sps.mot.com>
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

On Tue, Sep 13, 2005 at 03:38:40PM -0500, Jon Loeliger wrote:
> +#ifndef _ASM_POWERPC_HARDIRQ_H
> +#define _ASM_POWERPC_HARDIRQ_H
> +#ifdef __KERNEL__

the __KERNEL__ ifdefs is not needed.  <asm/hardirq.h> is only included
from <linux/hardirq.h> which doesn't have anything user-visible.

> +
> +#include <linux/config.h>

not needed.

> +#include <linux/cache.h>
> +
> +#ifdef __powerpc64__
> +#include <linux/preempt.h>
> +#else
> +#include <linux/smp_lock.h>
> +#include <asm/irq.h>
> +#endif

We shouldn't need either of these include blocks at all.

> +
> +/* The __last_jiffy_stamp field is needed to ensure that no decrementer
> + * interrupt is lost on SMP machines. Since on most CPUs it is in the same
> + * cache line as local_irq_count, it is cheap to access and is also used on UP
> + * for uniformity.
> + */
> +typedef struct {
> +	unsigned int __softirq_pending;	/* set_bit is used on this */
> +	unsigned int __last_jiffy_stamp;
> +} ____cacheline_aligned irq_cpustat_t;

I'd suggest just using a DECLARE_PER_CPU variable for last_jiffy_stamp.
In facct I plan to get rid of irq_cpustat_t completely at some point.
