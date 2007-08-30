Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36580DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 01:17:23 +1000 (EST)
Date: Thu, 30 Aug 2007 10:17:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 8/9] mpc82xx: Update mpc8272ads,
	and factor out PCI and reset.
Message-ID: <20070830151714.GA24473@ld0162-tx32.am.freescale.net>
References: <20070828201929.GH24329@ld0162-tx32.am.freescale.net>
	<66A3DBEB-412D-4229-88DA-B47F3256CEF6@kernel.crashing.org>
	<20070830055644.GA21604@ld0162-tx32.am.freescale.net>
	<573185B5-2B02-4D97-BAC8-D508C16D6093@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <573185B5-2B02-4D97-BAC8-D508C16D6093@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 09:56:16AM -0500, Kumar Gala wrote:
> It don't feel its a mishmash of crap its just how things are  
> defined.  Maybe the SOC node was a mistake, but I think we are past  
> the point of return on that.

The node itself wasn't a mistake -- the IMMR is relocatable, so it should
be under a bus node.  The mistake was assuming the PCI ranges went
straight to the CPU space, rather than getting translated through the
parent bus's ranges.  We got away with that mistake because of a similar
bug in the 32-bit PCI code.

In the past few months, this issue began to be addressed in a handful of
device trees.  In the device trees I prepared, I used separate bus and
control nodes.  In the 8544, 8548, and 8641 device trees, extra ranges
were hacked into the soc node.  All other PCI-bearing Freescale device
tree files are still broken.

I don't think a few months is an unrecoverable legacy.

> Having one platform's device tree be different just creates confusion  
> to our customers.

The intent isn't for 82xx to be different from everything else -- it's
simply the first one to get fixed in this way.  Incremental changes, and
what not.

Note that it would be quite easy to make the code accept either type of
device tree.

> While there isn't anything technically wrong with what your proposing
> it will cause support issues down the line which I want to avoid.

Such as?

-Scott
