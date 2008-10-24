Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD97DDDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 11:20:01 +1100 (EST)
Subject: Re: [PATCH] fix i2c on PPC linkstation / kurobox machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0810240059170.9657@axis700.grange>
References: <20081022191650.GA11406@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810232029380.9657@axis700.grange>
	<20081023213309.GA19777@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810240059170.9657@axis700.grange>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 11:19:40 +1100
Message-Id: <1224807581.7654.424.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Weiser <michael@weiser.dinsnail.net>,
	=?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-24 at 01:05 +0200, Guennadi Liakhovetski wrote:
> i2c is broken on linkstation / kurobox machines since at least 2.6.27. Fix 
> it. Also remove CONFIG_SERIAL_OF_PLATFORM, which, if enabled, breaks the 
> serial console after the "console handover: boot [udbg0] -> real [ttyS1]" 
> message.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

You may want to use udbg_printf() to track down what's up. There's some
fishy code there indeed, what happens is that the legacy serial code
creates a platform device at boot time. Then, the of_serial attaches to
the device node for the same device and tries to register it. It's
supposed to "detect" that it's the same device but yeah, it may be
buggy, I've seen problems with it in the past, among others, I think it
can lose some state.

In the meantime, removing SERIAL_OF_PLATFORM is a good solution.

Ben.
