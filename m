Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D48E9DDF1B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 01:59:48 +1000 (EST)
Date: Mon, 18 Aug 2008 10:59:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: "richw@netcomuk.co.uk" <richw@netcomuk.co.uk>
Subject: Re: Clock / Timebase / Bus Frequencies Help
Message-ID: <20080818155921.GA26475@loki.buserror.net>
References: <380-220088118115212377@M2W006.mail2web.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <380-220088118115212377@M2W006.mail2web.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 18, 2008 at 07:52:12AM -0400, richw@netcomuk.co.uk wrote:
> We've got an 8347 based board very similar to the A&M asp8347. Core clock
> is 400MHz. Bus clock is 266666666Hz.
> According to the data sheet for the 8347, the decrementer clock runs at a
> quarter of the rate of the bus clock. I have two questions:
> In arch/powerpc/boot/redboot-83xx.c, the timebase clock is passed to
> dt_fixup_cpu_clocks() as bi_busfreq / 16. If I leave it like this, my
> system clock runs approximately 4 times too fast. 
> Can anyone point me in the direction of an explanation for the div by 16
> rather than 4?

It's a bug, which I pointed out here:
http://ozlabs.org/pipermail/linuxppc-dev/2008-June/058704.html

> If I change the call to dt_fixup_cpu_clocks so that bi_busfreq/4 is passed
> in, then the clock runs more accurately. However, its still not correct.
> This gives a decrementer frequency of 66666666Hz, but if I hard code the
> value to 66000000Hz, the clock runs accurately.
> Can anyone shed any light on why the value passed in by the boot loader
> (redboot) seems to be inaccurate.

Redboot probably has the wrong crystal frequency hardcoded.

-Scott
