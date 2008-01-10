Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 072C4DE053
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 01:00:15 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0ADxjcL029237
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 08:59:50 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0ADxFni113264
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:59:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0ADwUPx030091
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:58:31 -0700
Date: Thu, 10 Jan 2008 07:58:30 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: How complete should the DTS be?
Message-ID: <20080110075830.247a13e5@zod.rchland.ibm.com>
In-Reply-To: <1199947849.6734.231.camel@pasglop>
References: <4782DAD8.1080104@pikatech.com>
	<86AA8535-E2CF-4891-900B-340049A5CA19@kernel.crashing.org>
	<20080110031331.GF17816@localhost.localdomain>
	<4785B2F5.6040001@pikatech.com>
	<20080110060245.GE19088@localhost.localdomain>
	<1199947849.6734.231.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 Jan 2008 17:50:49 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Thu, 2008-01-10 at 17:02 +1100, David Gibson wrote:
> > On Thu, Jan 10, 2008 at 12:53:57AM -0500, Sean MacLennan wrote:
> > > David Gibson wrote:
> > > > Hrm... I'd say this is not something which has a firm convention yet.
> > > > It's going to become more of an issue once we get a macros system for
> > > > dtc, so the "440EP" macro would have all the devices, even if some are
> > > > not connected on a given board.
> > > >
> > > > I'm contemplating suggesting that we adopt the "status" property from
> > > > IEEE1275 to cover this.
> > > >
> > > >   
> > > When I am laying out the dts, leaving out what isn't used makes the dts 
> > > file cleaner, at least in my view. It doesn't hurt to have the second 
> > > i2c bus there, but it also doesn't help and leaving it out points out 
> > > that it is not used.
> > > 
> > > When we get a macro system I assume the second i2c bus will be there but 
> > > hidden by a macro. It will still be clean and shouldn't cause grief.
> > 
> > Right, but if it is there we'll want to mark it as unused in some way
> > so that the kernel doesn't waste resources attempting to drive it.
> 
> Sure but I don't want to make it mandatory for people to put unused
> devices in. If the macro system brings them in, then yes, it's good to
> have a way to properly mark them unused. But people hand crafting DTS
> shouldn't have to bloat them.
> 
> There is -one- case where you may want to put unused devices, is if you
> do some kind of resource management on that specific bus (like need to
> be able to dynamically allocate space on the bus). In this case, you
> want to know everything that's there and potentially decodes addresses
> to avoid collisions.

There are other uses too.  E.g. pin sharing between devices based on
DIP switch settings.  You'd want to enumerate all the devices, and then
add 'status = "failed-not-connected"' to the ones that don't have pins.

josh
