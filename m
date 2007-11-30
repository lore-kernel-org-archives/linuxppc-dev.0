Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11703DDE09
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 07:57:50 +1100 (EST)
Subject: Re: [PATCH 15/24] powerpc: early debug forces console log level to max
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: T Ziomek <ctz001@email.mot.com>
In-Reply-To: <Pine.LNX.4.64.0711301306520.5450@gauley.ddna.labs.mot.com>
References: <20071130061200.4BAF9DDFAE@ozlabs.org>
	<Pine.LNX.4.64.0711301306520.5450@gauley.ddna.labs.mot.com>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 07:56:25 +1100
Message-Id: <1196456185.13230.100.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-30 at 13:10 -0600, T Ziomek wrote:
> > This patch makes the early debug option force the console loglevel
> > to the max. The early debug option is meant to catch messages very
> > early in the kernel boot process, in many cases, before the kernel
> > has a chance to parse the "debug" command line argument. Thus it
> > makes sense when CONFIG_PPC_EARLY_DEBUG is set, to force the console
> > log level to the max at boot time.
>   . . .
> > +#ifdef CONFIG_PPC_EARLY_DEBUG
> > +     console_loglevel = 10;
> > +#endif
> > }
> 
> The change makes sense, but wouldn't it also make sense to note it in
> arch/powerpc/Kconfig.debug?  Otherwise it's really hard to figure out
> why,
> after bringing up a new board, removing "debug" from the kernel cmd
> line
> does, well, nothing.

Possibly, though you aren't supposed to leave EARLY_DEBUG enabled
once you are done debugging :-)

Ben.
