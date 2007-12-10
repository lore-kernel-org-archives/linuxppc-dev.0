Return-Path: <david-b@pacbell.net>
Received: from smtp124.sbc.mail.sp1.yahoo.com (smtp124.sbc.mail.sp1.yahoo.com
	[69.147.64.97]) by ozlabs.org (Postfix) with SMTP id 89CFCDDF3A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 09:55:28 +1100 (EST)
Date: Mon, 10 Dec 2007 14:55:24 -0800
From: David Brownell <david-b@pacbell.net>
To: linuxppc-dev@ozlabs.org, avorontsov@ru.mvista.com
Subject: Re: [PATCH RFC 4/7] [GPIO] Let drivers link if they support GPIO API
	as an addition
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204906.GD32278@localhost.localdomain>
In-Reply-To: <20071210204906.GD32278@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20071210225525.2F6C6266154@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm interested in your opinion about that patch. You're also Cc'ed
> to patch that using that feature.
>
> I know, currently that patch will conflict with GPIOLIB patches in -mm,
> so this is only RFC.

The point of CONFIG_GENERIC_GPIO is to be *the* conditional used to
tell whether that programming interface is available ... starting
from "#include <asm/gpio.h>", and including all gpio_*() calls.

So my first reaction is to not like this patch.  It changes semantics
in an incompatible way.  And AFAICT, needlessly so.

What other options did consider?  Like, why not #ifdef the GPIO parts
of that NAND driver, or have the whole driver depend on GENERIC_GPIO?

- Dave
