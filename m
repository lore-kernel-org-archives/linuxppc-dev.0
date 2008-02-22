Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id C55A6DDEBA
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 10:54:58 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so28496uge.0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 15:54:56 -0800 (PST)
Date: Sat, 23 Feb 2008 02:35:00 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH RFC 4/7] [GPIO] Let drivers link if they support GPIO
	API as an addition
Message-ID: <20080222233459.GA23622@zarina>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210225525.2F6C6266154@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20071210230445.GA1141@zarina>
	<200802221542.03359.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200802221542.03359.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 22, 2008 at 03:42:03PM -0800, David Brownell wrote:
> On Monday 10 December 2007, Anton Vorontsov wrote:
> > On Mon, Dec 10, 2007 at 02:55:24PM -0800, David Brownell wrote:
> 
> > > The point of CONFIG_GENERIC_GPIO is to be *the* conditional used to
> > > tell whether that programming interface is available ... starting
> > > from "#include <asm/gpio.h>", and including all gpio_*() calls.
> > > 
> > > So my first reaction is to not like this patch.  It changes semantics
> > > in an incompatible way.  And AFAICT, needlessly so.
> > 
> > Why incompatible? gpio-aware drivers will get -ENOSYS on gpio_request,
> > thus they will not do anything wrong. GPIO-only drivers could still
> > depend on GENERIC_GPIO, and their behaviour will not change.
> 
> If you still want this, I think a better approach would be:
> 
>   http://marc.info/?l=linux-kernel&m=120295461410848&w=2
> 
> That is, #include <linux/gpio.h> and have *that* do the relevant
> switch, based on GENERIC_GPIO.  No semantic changes at all, if
> one discounts the implicit switch to <linux/gpio.h> (important
> for platforms that don't *have* any <asm/gpio.h> header), which
> won't affect any existing code.
> 
> So your NAND code could use that, and work equally well on
> SOC variants that have generic GPIOs and those that don't.
> 
> Comments?

I like it. :-) Thanks.

p.s. would be great to see this in 2.6.25, so we can start use
this include for the new code.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
