Return-Path: <davem@davemloft.net>
Received: from cheetah.davemloft.net
	(adsl-63-197-226-105.dsl.snfc21.pacbell.net [63.197.226.105])
	by ozlabs.org (Postfix) with ESMTP id 51DB467AAD
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Feb 2005 11:41:05 +1100 (EST)
Date: Tue, 8 Feb 2005 16:40:42 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20050208164042.6dd6fcb0.davem@davemloft.net>
In-Reply-To: <1106028614.4533.69.camel@gaston>
References: <1106028614.4533.69.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
Subject: Re: [PATCH] sungem update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Jan 2005 17:10:14 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This patch updates the sungem driver. I reworked all of the PM stuff, making it
> less prone to races, probably simpler to read as well, and I no longer shut the
> PHY down when the interface is down so that things like laptop-net no longer
> die (the gain in power consumption was minimal, not worth the pain). I also
> implemented basic WOL support.
> 
> There is still something I'm not totally happy with in the locking
> (explained in the comment at the beginning), basically too much locking and a
> couple of places with delays in locks. I will try to improve these later on.
> 
> If you are happy with this, please forward to Linus/Andrew asap
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Sorry for taking so long to review this :-/

This looks fine, except for one thing.  The WOL_* registers don't exist
in the Sun variants of the GEM chip, so it's not safe to try and program
them on all chips blindly like these changes do.  Perhaps some bit test
like:

	if (pdev->vendor != PCI_VENDOR_ID_SUN)
		gp->flags |= GEM_HAS_WOL;

Then protect all the WOL_* register programming with this new
GEM_HAS_WOL flag.
