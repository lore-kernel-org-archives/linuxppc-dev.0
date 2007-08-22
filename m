Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 724B7DDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 03:25:05 +1000 (EST)
Date: Wed, 22 Aug 2007 12:24:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
Message-ID: <20070822172456.GA22932@ld0162-tx32.am.freescale.net>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
	<46CB0E56.2020601@freescale.com>
	<20070822010907.GA12472@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070822010907.GA12472@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 11:09:07AM +1000, David Gibson wrote:
> On Tue, Aug 21, 2007 at 11:09:58AM -0500, Scott Wood wrote:
> > The point of #2 was as part of the fix to #1 -- otherwise, the same 
> > check for NULL would have to be moved into ft_create_node to 
> > conditionally call ft_find_device or ft_find_device_rel.
> 
> Um... oh, ok, I hadn't spotted that (1) made ft_create() use
> find_device_rel().  That sounds doubly wrong: you have the internal
> offset pointer, you should be able to create a phandle using the
> phandle allocation stuff, rather than having to refind the node you've
> just created from the parent.

Yeah, that'd make more sense.

> > >  (3) I really dislike;  I just don't see the point.
> > 
> > It's needed by dt_get_path().
> 
> No, it isn't.  dt_get_path() needs *some* way of getting the name of a
> node, but it could be a separate function, which I think would be
> preferable rather than folding it into getprop - you don't need to
> search for the name, so a getname() function would have quite a
> different structure to getprop().

I'd rather not add a new entry in ops just for that; it's more of an
attribute of the dtb format that name is handled specially.  IIUC, on
real OF you'd use the same code for both.

Plus, something might come along that needs to dynamically look for
either name or something else.  It's more flexible this way.

-Scott
