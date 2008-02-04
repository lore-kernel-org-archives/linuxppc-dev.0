Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D919EDDFE3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 07:30:41 +1100 (EST)
Date: Mon, 4 Feb 2008 14:30:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 08/11] [POWERPC] qe_lib: implement QE GTM support
Message-ID: <20080204203003.GA4202@loki.buserror.net>
References: <20080203170820.GA18520@localhost.localdomain>
	<20080203171019.GH28024@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080203171019.GH28024@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 03, 2008 at 08:10:19PM +0300, Anton Vorontsov wrote:
> GTM stands for General-purpose Timers Module and able to generate
> timer{1,2,3,4} interrupts.
> 
> There are several limitations in this support:
> 1. Cascaded (32 bit) timers unimplemented (1-2, 3-4).
>    This is straightforward to implement when needed, two timers should
>    be marked as "requested" and configured as appropriate.
> 2. Super-cascaded (64 bit) timers unimplemented (1-2-3-4).
>    This is also straightforward to implement when needed, all timers
>    should be marked as "requested" and configured as appropriate.

This isn't QE-specific; the same (as far as I see) timer hardware exists on,
for example, mpc8313 and mpc8349.

> +config QE_GTM
> +	bool
> +	help
> +	  QE General-Purpose Timers Module support

No bool text?

> +struct gtm_timer {
> +	unsigned int irq;
> +	bool requested;
> +
> +	u8 __iomem *gtcfr;
> +	u16 __iomem *gtmdr;
> +	u16 __iomem *gtpsr;
> +	u16 __iomem *gtcnr;
> +	u16 __iomem *gtrfr;
> +	u16 __iomem *gtevr;
> +};

__be16

> +static struct gtm_timer timers[4];
> +static struct qe_timers __iomem *qet;
> +static spinlock_t gtm_lock = __SPIN_LOCK_UNLOCKED(gtm_lock);

static DEFINE_SPINLOCK(gtm_lock);

Put these in a struct so multiple timer blocks can be supported (the non-QE
chips tend to have two blocks).

> +int qe_reset_ref_timer_16(int num, unsigned int hz, u16 ref)

What does this function do?  What goes in "hz" and "ref"?  Is it periodic or
one-shot?

-Scott
