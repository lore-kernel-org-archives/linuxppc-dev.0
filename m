Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 10:27:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Message-ID: <20070214232701.GF16279@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 01:08:01PM -0700, Yoder Stuart-B08248 wrote:
>  
> > >> Hmm.  There are two "soc" devices here, one nested under the
> > >> first??
> > >>
> > >> I'm assuming these are two levels of busses the opb bus is attached
> > >> to the plb bus.  Is the "soc" device_type the right way to
> > >> do this?
> > >
> > > Right, OPB hangs off of PLB in this case.  I dunno if "soc" is the 
> > > right
> > > device type for them though.
> > 
> > I would use device_type "plb" (or "plb4") and "opb" I think.
> > Similar to how PCI and ISA etc. busses are represented.
> 
> I think we should avoid making up new device_types unlesss it
> really is necessary.
> 
> Is it really necessary to distinguish between devices on
> the PLB or OPB?

Well.. maybe.  There are registers (DCR, not MMIO) in the PLB<->OPB
bridge.  I don't think the actual mapping can be changed, but some
error reporting and arbitration are controller there.  I think it's
better to represent the two busses, in case the distinction becomes
important at some point.

> As I undestand it the "soc" device type is a logical container
> for a group of devices in an SOC, not necessarily a group
> of devices on the same bus.  Could we simply list all those
> devices under an "soc" node at the same level.
> 
> If for some reason the bus hierarchy distinction _is_ required,
> my suggestion would be to create new generic device type for
> representing an internal bus.   The "device_type" is supposed
> to be somewhat general-- "network", "serial", etc.
> 
> We could create something like "soc-bus" or "internal-bus" with
> a compatible field that identifies the type of bus.
> 
> The general philosophy is a general device_type prooperty and
> a specific compatible property.

Yes, that's partly why I'm using "soc" for now.  I've thought that a
new general device_type might be a good idea though.  What's a "soc"
and what's an "internal" bus I think are not necessarily clear,
though.  I would suggest a type for any memory mapped,
non-hotpluggable, non-probeable bus.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
