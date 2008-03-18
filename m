Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C7448DE014
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 06:21:55 +1100 (EST)
Date: Tue, 18 Mar 2008 22:21:52 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080318192152.GA26493@localhost.localdomain>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
	<20080318174329.GB4099@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080318174329.GB4099@loki.buserror.net>
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

On Tue, Mar 18, 2008 at 12:43:29PM -0500, Scott Wood wrote:
> On Tue, Mar 11, 2008 at 08:24:29PM +0300, Anton Vorontsov wrote:
> > +    Required properties:
> > +      - compatible : should be "fsl,gtm" ("fsl,qe-gtm" in addition for QE
> > +                     GTMs).
> > +      - reg : should contain gtm registers location and length (0x40).
> > +      - interrupts : should contain four interrupts.
> > +      - interrupt-parent : interrupt source phandle.
> 
> interrupt-parent isn't required; it's perfectly valid to specify that in the
> parent node instead.

Ok

> 
> > +    Example:
> > +
> > +    gtm@500 {
> > +    	compatible = "fsl,gtm";
> > +    	reg = <0x500 0x40>;
> > +    	interrupts = <90 8 78 8 84 8 72 8>;
> > +    	interrupt-parent = <&ipic>;
> > +    };
> > +
> > +    gtm@440 {
> > +    	compatible = "fsl,qe-gtm", "fsl,gtm";
> > +    	reg = <0x440 0x40>;
> > +    	interrupts = <12 13 14 15>;
> > +    	interrupt-parent = <&qeic>;
> > +    };
> 
> "timer" would be a better node name than "gtm".

Ok

> > +static int __init gtm_init_gtm(void)
> 
> Name seems rather redundant... what's wrong with gtm_init()?

Probably :%s/// effect. Will fix.

> > +/*
> > + * For now we just fixing up the clock -- it's brg-frequency for QE
> > + * chips, generic code does not and should not know these details.
> > + *
> > + * Later we might want to set up BRGs, when QE will actually use
> > + * them (there are TIMERCS bits in the CMXGCR register, but today
> > + * these bits seem to be no-ops.
> > + */
> > +static int __init qe_init_gtm(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	for_each_compatible_node(np, NULL, "fsl,qe-gtm") {
> > +		struct gtm *gtm = np->data;
> > +
> > +		if (!gtm) {
> > +			/* fsl,qe-gtm without fsl,gtm compatible? */
> > +			WARN_ON(1);
> > +			continue;
> > +		}
> > +
> > +		gtm->clock = qe_get_brg_clk();
> > +	}
> > +
> > +	return 0;
> > +}
> > +arch_initcall(qe_init_gtm);
> 
> If this happens before the gtm_init_gtm(),

"If" isn't possible, order is guaranteed.

> then np->data will not be set. 

It's a bug in the device tree or in the Linux code then.

> If this happens after gtm_init_gtm(), then gtm_init_gtm() will fail in
> gtm_get_clock(), if there's no clock-frequency -- and if there is, then why
> do we need qe_init_gtm() at all?

Because for the QE clock-frequency != brg-frequency.

> > +/**
> > + * gtm_get_timer - request GTM timer for use with the rest of GTM API
> > + * @width:	timer width (only 16 bits wide timers implemented so far)
> > + *
> > + * This function reserves GTM timer for later use. It returns gtm_timer
> > + * structure to use with the rest of GTM API, you should use timer->irq
> > + * to manage timer interrupt.
> > + */
> > +extern struct gtm_timer *gtm_get_timer(int width);
> 
> To support using the GTM as a wakeup from deep sleep on 831x (which I've had
> a patch pending for quite a while now), we'll need some way of reserving a
> specific timer (only GTM1, timer 4 is supported).

You can add reserve function either in the PM driver (if any), or
you can do something in the device tree (wakeup-timer = <..>). I don't
see any problems if you want to implement it.

> > +/**
> > + * gtm_put_timer - release GTM timer
> > + * @width:	timer width (only 16 bits wide timers implemented so far)
> > + *
> > + * This function releases GTM timer sp others might request it.
> > + */
> > +extern void gtm_put_timer(struct gtm_timer *tmr);
> > +
> > +/**
> > + * gtm_reset_ref_timer_16 - (re)set single (16 bits) timer in reference mode
> > + * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
> > + * @hz:		timer rate in Hz
> > + * @ref:	refernce value
> 
> How about "period" or "expiry"?  And it'd be better to let the caller
> request a time in some real unit (e.g. microseconds), and let the gtm driver
> figure out how to divide that between prescaler and reference value,
> especially in the absence of a way to ask for the allowable hz ranges.

Will think about it.

> > + * @ffr:	free run flag
> 
> Could we call it something more intuitive such as "freerun"?

Easy.

> > + * Thus function (re)sets GTM timer so it counts up to the reference value and
> > + * fires the interrupt when the value is reached. If ffr flag is set, timer
> > + * will also reset itself upon reference value, otherwise it continues to
> > + * increment.
> > + */
> > +extern int gtm_reset_ref_timer_16(struct gtm_timer *tmr, unsigned int hz,
> > +				  u16 ref, bool ffr);
> > +
> > +/**
> > + * gtm_ack_ref_timer_16 - acknowledge timer event (free-run timers only)
> > + * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
> > + *
> > + * Thus function used to acknowledge timer interrupt event, use it inside the
> > + * interrupt handler.
> > + */
> > +static inline void gtm_ack_ref_timer_16(struct gtm_timer *tmr)
> 
> What does the "ref" mean in these names?
> 
> How about "gtm_arm_timer16" and "gtm_ack_timer16"?

Ok.

> 
> > +{
> > +	out_be16(tmr->gtevr, 0xFFFF);
> > +}
> 
> You need to include <asm/io.h> for this.

Ok.

> Don't blindly clear all events, just the events that have been acted upon. 
> Either take the events as an argument, or make the ack function specifi

Ok.


Thanks,

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
