Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DDA7ADDF3D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:49:17 +1100 (EST)
Date: Tue, 18 Dec 2007 19:51:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071218165135.GA32585@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
	<20071218035108.GA10212@localhost.localdomain>
	<4767F271.4090703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4767F271.4090703@freescale.com>
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

On Tue, Dec 18, 2007 at 10:16:49AM -0600, Scott Wood wrote:
> David Gibson wrote:
> >In this case the driver and binding have been developed together and
> >for the time being it does require PHY nodes, obviously.  I'm saying
> >that maybe that requirement ought to be changed.
> 
> I don't see why.
> 
> >Well, phandle is only used to find the phy node itself, so it doesn't
> >count.  The only piece of information there is the reg - the PHY id.
> >Following a phandle to another node is a fairly complex way of finding
> >a single integer.  
> >
> >Eh, I guess it's ok, but just directly giving the PHY id or a probe
> >mask in the MAC node would also be fine (we do this for 4xx EMAC).
> 
> It's not just a simple integer -- it also tells you which mdio bus it's on.

Exactly. And at least one board (MPC8568E-MDS) using this feature:
UECs are using PHYs placed on the TSEC's MDIO bus. This is hardware
configurable, and could be contrariwise: TSECs can use PHYs that
are under control of UEC MDIO bus controller.

That's why we're naming PHYs as bus:phyid.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
