Return-Path: <dgibson@ozlabs.org>
Date: Fri, 24 Aug 2007 11:01:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
Message-ID: <20070824010122.GA7281@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
	<46CB0E56.2020601@freescale.com>
	<20070822010907.GA12472@localhost.localdomain>
	<20070822172456.GA22932@ld0162-tx32.am.freescale.net>
	<20070823020147.GB7042@localhost.localdomain>
	<46CDC86E.2070907@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46CDC86E.2070907@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2007 at 12:48:30PM -0500, Scott Wood wrote:
> David Gibson wrote:
> > Actually, no - sorry, that's the other problem with this, which I
> > forgot to mention.  On real OF, the "name" property contains the
> > node's name *without the unit address*; that is, only the portion
> > before the '@'.  So your getprop change does not match real OF
> > behaviour - and real OF behaviour will not do what you want for
> > dt_get_path().
> 
> Ah, OK.
> 
> > Actually, in any case, I don't think we want to implement get_path()
> > this way for real OF.  Better to have get_path() itself as a callback:
> > on real OF I believe we can directly ask for the full path to a given
> > phandle, the get name based implementation can then be made specific
> > to the flat device tree.
> > 
> > Or actually, I think we might be able to come up with a get_path()
> > implementation for flat tree that's less hideous than repeatedly
> > calling get_parent() which is an ugly, ugly operation on the flat tree
> 
> It's likely to be ugly no matter what, though I'll try to come up with 
> something slightly nicer.  If I were doing this code from scratch, I'd 
> probably liven the tree first and reflatten it to pass to the kernel.

Eh, probably not worth bothering doing an actual implementation at
this stage - I'll have to redo it for libfdt anyway.

> > (and will get worse with libfdt).
> 
> Why is that?

flatdevtree uses some of the information it caches in the phandle
context stuff to remember who's the parent of a node.  libfdt uses raw
offsets into the structure, so the *only* way to implement
get_parent() is to rescan the dt from the beginning, keeping track of
parents until reaching the given node.

> >>Plus, something might come along that needs to dynamically look for
> >>either name or something else.  It's more flexible this way.
> > 
> > Hrm... "something might come along" just seems contrived to me.
> 
> Well, I generally prefer doing things the more flexible way in the 
> absence of a good reason not to.  OF returning the bare name is a good 
> reason not to.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
