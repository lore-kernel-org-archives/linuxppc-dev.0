Return-Path: <dgibson@ozlabs.org>
Date: Wed, 22 Aug 2007 11:09:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
Message-ID: <20070822010907.GA12472@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
	<46CB0E56.2020601@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46CB0E56.2020601@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 11:09:58AM -0500, Scott Wood wrote:
> David Gibson wrote:
> > On Mon, Aug 20, 2007 at 12:39:49PM -0500, Scott Wood wrote:
> > 
> >>1. ft_create_node was returning the internal pointer rather than a phandle.
> >>2. ft_find_device_rel was treating a "top" phandle of NULL as an error,
> >>rather than as the root of the tree.
> >>3. Return the node's name when getprop() is called with the "name"
> >>property.
> > 
> > 
> > Hrm.  I'm not convinced.  (1) certainly needs fixing.  (2) is kind of
> > unclear - there is an ft_find_device() after all for doing root-based
> > searches.
> 
> The point of #2 was as part of the fix to #1 -- otherwise, the same 
> check for NULL would have to be moved into ft_create_node to 
> conditionally call ft_find_device or ft_find_device_rel.

Um... oh, ok, I hadn't spotted that (1) made ft_create() use
find_device_rel().  That sounds doubly wrong: you have the internal
offset pointer, you should be able to create a phandle using the
phandle allocation stuff, rather than having to refind the node you've
just created from the parent.

> The non-relative function should probably be removed, though.

Well, yes, I wouldn't have much problem with just having a relative
version.

Come to that, I don't actually care all that much what happens to
flatdevtree.c, seeing as I intend to replace it with libfdt, just as
soon as I can get enough other things off my plate.

> >  (3) I really dislike;  I just don't see the point.
> 
> It's needed by dt_get_path().

No, it isn't.  dt_get_path() needs *some* way of getting the name of a
node, but it could be a separate function, which I think would be
preferable rather than folding it into getprop - you don't need to
search for the name, so a getname() function would have quite a
different structure to getprop().

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
