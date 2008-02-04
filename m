Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 40E89DDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 07:56:18 +1100 (EST)
Date: Mon, 4 Feb 2008 23:56:00 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 08/11] [POWERPC] qe_lib: implement QE GTM support
Message-ID: <20080204205600.GA20400@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
	<20080203171019.GH28024@localhost.localdomain>
	<20080204203003.GA4202@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080204203003.GA4202@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 04, 2008 at 02:30:04PM -0600, Scott Wood wrote:
> On Sun, Feb 03, 2008 at 08:10:19PM +0300, Anton Vorontsov wrote:
> > GTM stands for General-purpose Timers Module and able to generate
> > timer{1,2,3,4} interrupts.
> > 
> > There are several limitations in this support:
> > 1. Cascaded (32 bit) timers unimplemented (1-2, 3-4).
> >    This is straightforward to implement when needed, two timers should
> >    be marked as "requested" and configured as appropriate.
> > 2. Super-cascaded (64 bit) timers unimplemented (1-2-3-4).
> >    This is also straightforward to implement when needed, all timers
> >    should be marked as "requested" and configured as appropriate.
> 
> This isn't QE-specific; the same (as far as I see) timer hardware exists on,
> for example, mpc8313 and mpc8349.

In my endless todo list. I'll try to evolve it to support fsl gtms in
general. Though the problem is that, for example, for QE USB we prefer
QE timers. So, we probably want to pass timers via device tree to
distinguish them.

> > +config QE_GTM
> > +	bool
> > +	help
> > +	  QE General-Purpose Timers Module support
> 
> No bool text?

No. This is silent config option.

> > +struct gtm_timer {
> > +	unsigned int irq;
> > +	bool requested;
> > +
> > +	u8 __iomem *gtcfr;
> > +	u16 __iomem *gtmdr;
> > +	u16 __iomem *gtpsr;
> > +	u16 __iomem *gtcnr;
> > +	u16 __iomem *gtrfr;
> > +	u16 __iomem *gtevr;
> > +};
> 
> __be16

Will do.

> > +static struct gtm_timer timers[4];
> > +static struct qe_timers __iomem *qet;
> > +static spinlock_t gtm_lock = __SPIN_LOCK_UNLOCKED(gtm_lock);
> 
> static DEFINE_SPINLOCK(gtm_lock);

I'm trying to open-code as much as I could (well, not as much, but
just using common sense :-), so I prefer the first variant, if you
don't mind. DEFINE_SPINLOCK() and above are equivalents.

This is not something I'm going to argue about, though. Just ask
one more time and I'll simply change it to DEFINE_SPINLOCK().

> Put these in a struct so multiple timer blocks can be supported (the non-QE
> chips tend to have two blocks).

Yes, this is in my todo list. Btw, QE chips have three gtms, QE + 2 IMMR.

> > +int qe_reset_ref_timer_16(int num, unsigned int hz, u16 ref)
> 
> What does this function do?  What goes in "hz" and "ref"?  Is it periodic or
> one-shot?

"ref" means that it counts to some reference value and fires the
interrupt. Hz is count rate. This particular function implements
"reset reference mode", timer will reset itself when reference
value is reached. We probably want to add frr flag (free run).
Will kernel-doc this function.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
