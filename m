Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2BFF4DDEEB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 07:27:19 +1100 (EST)
Date: Tue, 18 Mar 2008 23:27:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080318202717.GA1030@localhost.localdomain>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
	<20080318174329.GB4099@loki.buserror.net>
	<20080318192152.GA26493@localhost.localdomain>
	<47E01E22.9000807@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47E01E22.9000807@freescale.com>
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

On Tue, Mar 18, 2008 at 02:55:14PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
> >>>+arch_initcall(qe_init_gtm);
> >>If this happens before the gtm_init_gtm(),
> >
> >"If" isn't possible, order is guaranteed.
> 
> You use arch_initcall for both, so you're relying on link order.  I 
> think this at least merits a comment.
> >>then np->data will not be set. 
> >
> >It's a bug in the device tree or in the Linux code then.
> 
> Hmm?  It's set by gtm_init_gtm().  If this code runs before 
> gtm_init_gtm(), what are you expecting to initialize np->data?

What code exactly?

> >>If this happens after gtm_init_gtm(), then gtm_init_gtm() will fail in
> >>gtm_get_clock(), if there's no clock-frequency -- and if there is, then 
> >>why
> >>do we need qe_init_gtm() at all?
> >
> >Because for the QE clock-frequency != brg-frequency.
> 
> Sorry, I missed that you were getting clock-frequency from the parent, 
> rather than the gtm node.  If you do the latter, then you can just stick 
> the relevant frequency in the gtm node and not worry about where it 
> comes from.  This would be analogous to how UART clocks are specified.

Ok.

> Also, what if some arch_initcall runs between gtm_init_gtm and 
> qe_init_gtm, that registers itself as a client of the gtm driver, and 
> uses the wrong clock value?

Again, what code exactly? If it is a driver (for what this API is
created for), it hardly will run earlier than arch/ code. If this is
platform code (arch/powerpc/platform/), then it is hardly will run
earlier than arch/sysdev/. Inside the arch/sysdev/ fsl_gtm.c is
guaranteed to run earlier than qe_lib/gtm.c. So, where is the problem?

Since I'll implement clock-frequency inside the timer node, this
isn't relevant anymore...

> >>>+extern struct gtm_timer *gtm_get_timer(int width);
> >>To support using the GTM as a wakeup from deep sleep on 831x (which I've 
> >>had
> >>a patch pending for quite a while now), we'll need some way of reserving a
> >>specific timer (only GTM1, timer 4 is supported).
> >
> >You can add reserve function either in the PM driver (if any), or
> 
> What I meant was that there needs to be some way of telling this driver 
> not to hand the reserved timer out to some other client.
> 
> >you can do something in the device tree (wakeup-timer = <..>). I don't
> >see any problems if you want to implement it.
> 
> How about simply having optional arguments to gtm_get_timer() to specify 
> the GTM device and timer number, which will fail if it's already in use? 
>  Then, the PM driver simply needs to run early enough to grab the timer 
> it needs.

Ah. You need specific timer. No problem. I don't like idea of new arguments
to the gtm_get_timer() function (complicates things), but we can just
implement another one. gtm_get_timer_<name>, choice the name please.
_specific, _2, _for, __gtm_get_timer, ...

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
