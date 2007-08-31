Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Aug 2007 12:58:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Document and implement an improved flash device binding for
	powerpc (v4)
Message-ID: <20070831025817.GF19271@localhost.localdomain>
References: <20070830012118.GF22844@localhost.localdomain>
	<20070830172932.GA3317@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830172932.GA3317@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 12:29:33PM -0500, Scott Wood wrote:
> On Thu, Aug 30, 2007 at 11:21:18AM +1000, David Gibson wrote:
> > +    For JEDEC compatible devices, the following additional properties
> > +    are defined:
> > +
> > +     - vendor-id : Contains the flash chip's vendor id (1 byte).
> > +     - device-id : Contains the flash chip's device id (1 byte).
> 
> Are these required, or recommended?

Heh.. that's an interesting question.  I think they're a "SHOULD" in
rfc terminology.  According to Segher, this information should be
provided for any JEDEC chip.  However, it can, in practice, be probed
by the mtd code, and in fact there's no obvious way of actually
specifying these to the mtd code, so these properties aren't ever
actually used (at present, anyway).

> > +    In addition to the information on the flash bank itself, the
> > +    device tree may optionally contain additional information
> > +    describing partitions of the flash address space.  This can be
> > +    used on platforms which have strong conventions about which
> > +    portions of the flash are used for what purposes, but which don't
> > +    use an on-flash partition table such as RedBoot.
> > +
> > +    Each partition is represented as a sub-node of the flash device.
> > +    Each node's name represents the name of the corresponding
> > +    partition of the flash device.
> 
> Hmm...  I'm not thrilled with using the node name for this.  For one, the
> node name usually functions more as a node type than a label.  It also
> means that spaces can't be used in the name, which is fairly common for
> existing partition maps.
> 
> This might be a good time to introduce a standard "label" property.

Hrm, yeah, that's not a bad idea.  I'm thinking 'label' is used if
present, otherwise it falls back to the node name.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
