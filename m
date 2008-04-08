Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 Apr 2008 12:44:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for Xilinx
	uart 16550.
Message-ID: <20080408024440.GB17820@localhost.localdomain>
References: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
	<200804030134.11437.arnd@arndb.de>
	<fa686aa40804021943m208c2ff0va6c6b629a747439f@mail.gmail.com>
	<200804030616.09825.arnd@arndb.de>
	<1207406756.6809.2.camel@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1207406756.6809.2.camel@vader.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, John Linn <john.linn@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 05, 2008 at 09:45:56AM -0500, Josh Boyer wrote:
> On Thu, 2008-04-03 at 06:16 +0200, Arnd Bergmann wrote:
> > On Thursday 03 April 2008, Grant Likely wrote:
> > > >
> > > >  Since it is not really compatible with ns16550, shouldn't you at least specify
> > > >  a different "compatible" property? That way, the driver won't do incorrect
> > > >  accesses when you try to use an old driver with a device tree that specifies
> > > >  one of these.
> > > 
> > > Heh; we've gone back and forth on this issue.  The problem is that we
> > > have a common case of ns16550 like devices that require a little bit
> > > of register address tweaking that spans a whole range of vendors (so
> > > adding a compatible match with each of those vendor's prefixes is
> > > probably non-scalable).  So, if "ns16550" is not a good idea, then
> > > what should be used?  "sparse16550" has been suggested more than once.
> > 
> > After another IRC discussion between Grant, Segher and myself, we concluded
> > that we don't need to invent a new "compatible" value, as only new device
> > trees with old kernels will have a problem with this, and they don't work
> > in the first place.
> > 
> > The devices will still have their specific "compatible" value, e.g.
> > "xlnx,plb-uart16550-1.00.c", followed by "ns16550", and possibly
> > "ns16450" and "i8250", although the last two do not have an effect
> > on Linux.
> > 
> > Josh, can you please forward all three patches in their latest version?
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> So is the discussion on reg-offset settled then?  It seemed Paul and
> David had some issues with that, and I'd like to make sure everyone is
> agreed on that before I bring in patches 2 and 3.

I didn't like it very much, but I don't really care enough to argue
about it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
