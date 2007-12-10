Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id B69FFDDF76
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 10:13:48 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so89330uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 15:13:45 -0800 (PST)
Date: Tue, 11 Dec 2007 02:04:45 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH RFC 4/7] [GPIO] Let drivers link if they support GPIO
	API as an addition
Message-ID: <20071210230445.GA1141@zarina>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204906.GD32278@localhost.localdomain>
	<20071210225525.2F6C6266154@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071210225525.2F6C6266154@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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

On Mon, Dec 10, 2007 at 02:55:24PM -0800, David Brownell wrote:
> > I'm interested in your opinion about that patch. You're also Cc'ed
> > to patch that using that feature.
> >
> > I know, currently that patch will conflict with GPIOLIB patches in -mm,
> > so this is only RFC.
> 
> The point of CONFIG_GENERIC_GPIO is to be *the* conditional used to
> tell whether that programming interface is available ... starting
> from "#include <asm/gpio.h>", and including all gpio_*() calls.
> 
> So my first reaction is to not like this patch.  It changes semantics
> in an incompatible way.  And AFAICT, needlessly so.

Why incompatible? gpio-aware drivers will get -ENOSYS on gpio_request,
thus they will not do anything wrong. GPIO-only drivers could still
depend on GENERIC_GPIO, and their behaviour will not change.

> What other options did consider?  Like, why not #ifdef the GPIO parts
> of that NAND driver,

Hehe, it's used to avoid #ifdef hell indeed. ;-) And no-op wrappers
like that I purposed is widely used to avoid #ifdefs. They will just
optimize away.

> or have the whole driver depend on GENERIC_GPIO?

Well, this is an option, and I was considering this. Further more,
I implemented gpio api for all platforms which currently using fsl
upm nand, so in theory I can add "depends on GENERIC_GPIO".

But the thing is: some drivers don't actually *require* gpios, they
can use it, but at the same time they might live without it.

As for fsl upm nand (the user of that change), it can poll status
from the nand chip instead of looking for RNB gpio. So, strict
depending on GENERIC_GPIO looks weird in that case.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
