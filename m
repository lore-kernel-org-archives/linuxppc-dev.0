Return-Path: <benh@kernel.crashing.org>
Subject: Re: How complete should the DTS be?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080110060245.GE19088@localhost.localdomain>
References: <4782DAD8.1080104@pikatech.com>
	<86AA8535-E2CF-4891-900B-340049A5CA19@kernel.crashing.org>
	<20080110031331.GF17816@localhost.localdomain>
	<4785B2F5.6040001@pikatech.com>
	<20080110060245.GE19088@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 Jan 2008 17:50:49 +1100
Message-Id: <1199947849.6734.231.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-01-10 at 17:02 +1100, David Gibson wrote:
> On Thu, Jan 10, 2008 at 12:53:57AM -0500, Sean MacLennan wrote:
> > David Gibson wrote:
> > > Hrm... I'd say this is not something which has a firm convention yet.
> > > It's going to become more of an issue once we get a macros system for
> > > dtc, so the "440EP" macro would have all the devices, even if some are
> > > not connected on a given board.
> > >
> > > I'm contemplating suggesting that we adopt the "status" property from
> > > IEEE1275 to cover this.
> > >
> > >   
> > When I am laying out the dts, leaving out what isn't used makes the dts 
> > file cleaner, at least in my view. It doesn't hurt to have the second 
> > i2c bus there, but it also doesn't help and leaving it out points out 
> > that it is not used.
> > 
> > When we get a macro system I assume the second i2c bus will be there but 
> > hidden by a macro. It will still be clean and shouldn't cause grief.
> 
> Right, but if it is there we'll want to mark it as unused in some way
> so that the kernel doesn't waste resources attempting to drive it.

Sure but I don't want to make it mandatory for people to put unused
devices in. If the macro system brings them in, then yes, it's good to
have a way to properly mark them unused. But people hand crafting DTS
shouldn't have to bloat them.

There is -one- case where you may want to put unused devices, is if you
do some kind of resource management on that specific bus (like need to
be able to dynamically allocate space on the bus). In this case, you
want to know everything that's there and potentially decodes addresses
to avoid collisions.

Cheers,
Ben.
