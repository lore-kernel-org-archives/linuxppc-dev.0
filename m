Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 996B4DDF11
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 03:53:10 +1100 (EST)
Date: Tue, 15 Jan 2008 10:52:30 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [DTC PATCH] libfdt: Add ft_get_next_node(), ft_get_next_prop(),
	and ft_getprop_offset().
Message-ID: <20080115165230.GB10812@ld0162-tx32.am.freescale.net>
References: <20080114163004.GA27880@ld0162-tx32.am.freescale.net>
	<20080115001657.GC20649@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080115001657.GC20649@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 11:16:57AM +1100, David Gibson wrote:
> On Mon, Jan 14, 2008 at 10:30:04AM -0600, Scott Wood wrote:
> > ft_get_next_node() enumerates children of a given node.
> > ft_get_next_prop() enumerates propreties of a given node.
> > 
> > ft_getprop_offset() is like ft_getprop(), but takes a property offset rather
> > than a node offset and property name; it is primarily intended for use
> > with ft_get_next_prop().
> 
> Urg... this kind of serves me right for not getting my act together on
> iterator functions yet.  I really don't like this approach much.  I'll
> see if I can come up with something I prefer this afternoon.

OK.

> The biggest thing I dislike is that I've deliberately avoided having
> any offsets-to-properties exposed to the library user.  That's because
> the whole offsets change when you write the tree problem is worse for
> properties than nodes (in that likely idiomatic uses will be bitten by
> changes in property offsets).

We can drop the property iteration for now; I wrote it for an attempt at
node merging which I postponed.

> > +	if (depth != 0)
> > +		return -FDT_ERR_BADSTRUCTURE;
> 
> I think this should be FDT_ERR_TRUNCATED.

I'd expect TRUNCATED when we hit totalsize without an FDT_END, not when
we hit FDT_END in an inappropriate context.

> > +	return -FDT_ERR_NOTFOUND;
> 
> In fact, so should this.  This function should never actually reach
> the FDT_END tag.

No, it's valid if you're iterating over all nodes (node -1, depth -1).

> > +#define FDT_ERR_BADDEPTH	8
> > +	/* FDT_ERR_BADDEPTH: Function was passed a negative
> > +	 * (or otherwise invalid) depth. */
> 
> You've added this error code, but you don't actually return it
> anywhere...

Oops, it must have been from the aforementioned node merging code, and I
thought it was from fdt_get_next_node when splitting things up.

> This description is incorrect - you've copied the fdt_getprop()
> description and forgotten to update it.

/me hides in shame

-Scott
