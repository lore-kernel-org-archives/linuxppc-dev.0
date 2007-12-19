Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95963DDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 03:16:27 +1100 (EST)
Date: Wed, 19 Dec 2007 10:15:52 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071219161551.GA20238@ld0162-tx32.am.freescale.net>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
	<20071219130559.GA7846@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071219130559.GA7846@localhost.localdomain>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 19, 2007 at 04:05:59PM +0300, Anton Vorontsov wrote:
> No, we can't drop it. We can replace it by clock-frequency, but
> not just drop it, because bus frequency used by at least one driver --
> spi_mpc83xx, to calculate proper clocks prescaling value.

Hmm... maybe it should be using the brg frequency instead?  I'll look at
the documentation to see what the actual clock it's looking for is.

> > Yes, replace it with compatible = "fsl,cpm-muram".
> 
> cpm? This is QE. 

QE, CPM3, whatever.  This isn't the marketing department. :-)

. I'll name it fsl,qe-muram. If you think it
> is fully compatible with cpm, then I'd better add
> "fsl,qe-muram", "fsl,cpm-muram".

It's just memory, so there's not much to be incompatible.  It's used for
(mostly) the same things on QE and older CPMs, and *should* be matched by
the same code even if it isn't today.

I'm OK with listing both QE and CPM if that's what you want to do,
though.

-Scott
