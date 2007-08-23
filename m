Return-Path: <dgibson@ozlabs.org>
Date: Thu, 23 Aug 2007 12:01:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
Message-ID: <20070823020147.GB7042@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
	<46CB0E56.2020601@freescale.com>
	<20070822010907.GA12472@localhost.localdomain>
	<20070822172456.GA22932@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070822172456.GA22932@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 12:24:56PM -0500, Scott Wood wrote:
> On Wed, Aug 22, 2007 at 11:09:07AM +1000, David Gibson wrote:
> > On Tue, Aug 21, 2007 at 11:09:58AM -0500, Scott Wood wrote:
> > > The point of #2 was as part of the fix to #1 -- otherwise, the same 
> > > check for NULL would have to be moved into ft_create_node to 
> > > conditionally call ft_find_device or ft_find_device_rel.
> > 
> > Um... oh, ok, I hadn't spotted that (1) made ft_create() use
> > find_device_rel().  That sounds doubly wrong: you have the internal
> > offset pointer, you should be able to create a phandle using the
> > phandle allocation stuff, rather than having to refind the node you've
> > just created from the parent.
> 
> Yeah, that'd make more sense.
> 
> > > >  (3) I really dislike;  I just don't see the point.
> > > 
> > > It's needed by dt_get_path().
> > 
> > No, it isn't.  dt_get_path() needs *some* way of getting the name of a
> > node, but it could be a separate function, which I think would be
> > preferable rather than folding it into getprop - you don't need to
> > search for the name, so a getname() function would have quite a
> > different structure to getprop().
> 
> I'd rather not add a new entry in ops just for that; it's more of an
> attribute of the dtb format that name is handled specially.  IIUC, on
> real OF you'd use the same code for both.

Actually, no - sorry, that's the other problem with this, which I
forgot to mention.  On real OF, the "name" property contains the
node's name *without the unit address*; that is, only the portion
before the '@'.  So your getprop change does not match real OF
behaviour - and real OF behaviour will not do what you want for
dt_get_path().

Actually, in any case, I don't think we want to implement get_path()
this way for real OF.  Better to have get_path() itself as a callback:
on real OF I believe we can directly ask for the full path to a given
phandle, the get name based implementation can then be made specific
to the flat device tree.

Or actually, I think we might be able to come up with a get_path()
implementation for flat tree that's less hideous than repeatedly
calling get_parent() which is an ugly, ugly operation on the flat tree
(and will get worse with libfdt).

> Plus, something might come along that needs to dynamically look for
> either name or something else.  It's more flexible this way.

Hrm... "something might come along" just seems contrived to me.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
