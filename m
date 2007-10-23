Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 09:44:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC: Remove the need for the GLR Parser.
Message-ID: <20071023234450.GD10595@localhost.localdomain>
References: <E1Ik4aw-0007ud-Lu@jdl.com>
	<20071023025412.GI31839@localhost.localdomain>
	<E1IkKge-00060g-2l@jdl.com> <E1IkMI8-0000b3-0U@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IkMI8-0000b3-0U@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 11:07:39AM -0500, Jon Loeliger wrote:
> So, like, the other day Jon Loeliger mumbled:
> > 
> > > First, a trivial one: I remember leaving this as a right-recursion,
> > > despite the stack-nastiness, because that way the properties end up in
> > > the same order as in the source.  I think that behaviour is worth
> > > preserving, but of course we can do it with left-recursion by changing
> > > chain_property() to add to the end of the list instead of the
> > > beginning.
> > 
> > Understood.  And I wrestled with that as well.  In fact, I even
> > wrote the reverse_properties() function, which I will include,
> > and used it initially.  However, several test failed.  So I
> > removed it, and it all started happily working again.
> 
> I was confused.  It was the version of the code that _did_
> use the property reversal that worked.

Ok.  Except that I think we shouldn't need to have an explicit
reverse_properties().  Just build the list in-order by having
chain_property() append to the end of the list.

It's theoretically expensive, since we have to walk the list each
time, but frankly I don't think we need to worry about dtc performance
until we actually see a single non-contrived tree that takes a
noticeable amount of time to process:  I've never seen one yet.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
