Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Dec 2007 14:51:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071218035108.GA10212@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071217170303.GA4303@loki.buserror.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2007 at 11:03:04AM -0600, Scott Wood wrote:
> On Mon, Dec 17, 2007 at 04:14:03PM +1100, David Gibson wrote:
[snip]
> > These phy nodes have basically no information in them.  PHY nodes are
> > optional -
> 
> If they are truly optional, then several Linux drivers (including ucc_geth,
> which this board uses) are broken, as they'll error out if there's no
> phy-handle (gianfar is even worse -- it looks like the fsl_soc code will
> crash in that case).  But what do you propose they do in the absence of a
> phy-handle?  Hope that probing only finds one phy?

Sorry, I was misleading.  PHY nodes may be optional depending on the
hardware configuration; what circumstances they're necessary in is up
to the MAC binding.  Allowing the nodes to be omitted when there's
only one PHY on the bus to be probed would be a common choice, for
example.

In this case the driver and binding have been developed together and
for the time being it does require PHY nodes, obviously.  I'm saying
that maybe that requirement ought to be changed.

> > only include them if they actually have something useful to say (which
> > would mean at least a compatible property).
> 
> They *do* have useful information -- reg and phandle.  The type of phy can
> be probed, but which phy corresponds to which ethernet can't.

Well, phandle is only used to find the phy node itself, so it doesn't
count.  The only piece of information there is the reg - the PHY id.
Following a phandle to another node is a fairly complex way of finding
a single integer.  

Eh, I guess it's ok, but just directly giving the PHY id or a probe
mask in the MAC node would also be fine (we do this for 4xx EMAC).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
