Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7540CDDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 03:33:50 +1100 (EST)
Date: Wed, 19 Dec 2007 19:36:02 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071219163602.GA21780@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
	<20071219130559.GA7846@localhost.localdomain>
	<20071219161551.GA20238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071219161551.GA20238@ld0162-tx32.am.freescale.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 19, 2007 at 10:15:52AM -0600, Scott Wood wrote:
> On Wed, Dec 19, 2007 at 04:05:59PM +0300, Anton Vorontsov wrote:
> > No, we can't drop it. We can replace it by clock-frequency, but
> > not just drop it, because bus frequency used by at least one driver --
> > spi_mpc83xx, to calculate proper clocks prescaling value.
> 
> Hmm... maybe it should be using the brg frequency instead?  I'll look at
> the documentation to see what the actual clock it's looking for is.

It says "QE clk / 2" for MPC8360 and MPC8323. BRG clk for MPC8555 (cpm2).
"system clock" (SOC) for MPC8349.

I just looked into u-boot, for mpc83xx: brgclk = qe_clk / 2, so we can
use it.

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
