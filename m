Return-Path: <dgibson@ozlabs.org>
Date: Thu, 30 Aug 2007 15:58:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Introduce new CPM device bindings.
Message-ID: <20070830055812.GB32543@localhost.localdomain>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201619.GB24210@ld0162-tx32.am.freescale.net>
	<20070829053941.GC3206@localhost.localdomain>
	<20070829135806.GB30184@ld0162-tx32.am.freescale.net>
	<20070830005559.GB22844@localhost.localdomain>
	<20070830054854.GA21533@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830054854.GA21533@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 12:48:54AM -0500, Scott Wood wrote:
> On Thu, Aug 30, 2007 at 10:55:59AM +1000, David Gibson wrote:
> > Am I correct in thinking that it's basically an arch/ppc versus
> > arch/powerpc thing.  In which case couldn't you use CONFIG_PPC_MERGE
> > instead?
> 
> The idea was to allow boards to be converted incrementally, as I don't
> have access to test 100% of the boards that use the CPM code.

Hrm.  Right.  This is still problematical, because what happens if you
have both old-binding and new-binding boards configured simultaneously?

> > > It has a phandle to the phy node...  if you mean the mdio bus node, why?
> > 
> > Well, I'm just working of the example of 4xx EMAC.  The way it does
> > mdio, it wants a handle on the mdio bus to perform various operations
> > there as well on the phy to tell it how to address them.  fsl-enet may
> > do things differently and have no particular need for such a handle.
> 
> Even if it did need such a handle, couldn't it just look at the phy
> node's parent?

Well, yes, but it's just a bit more fiddling.  For the purposes of
emac, it seemed simpler to supply pass the mdio phandle as well.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
