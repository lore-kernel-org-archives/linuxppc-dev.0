Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 12:49:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@comcast.net>
Subject: Re: libfdt: going forward for u-boot
Message-ID: <20070322014929.GI2295@localhost.localdomain>
References: <4601C8F7.5060006@comcast.net>
	<20070322004959.GE2295@localhost.localdomain>
	<4601D7FF.1080801@comcast.net>
	<20070322012507.GF2295@localhost.localdomain>
	<4601DDD4.2030105@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4601DDD4.2030105@comcast.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 09:37:24PM -0400, Jerry Van Baren wrote:
> David Gibson wrote:
> > On Wed, Mar 21, 2007 at 09:12:31PM -0400, Jerry Van Baren wrote:
> >> David Gibson wrote:
> 
> [snip]
> 
> >>>> fdt_rw.c
> >>>> --------
> >>>> * Nonessential improvements to fdt_open_into()
> >>>>   * Validate the header (fdt_move() does the validation, but I skip
> >>>>       the move if buf == fdt so I needed to add the validation)
> >>>>   * Do the fdt_move() only if (buf != fdt) - I call this at times with
> >>>>       a new (longer) length but don't want to actually move the blob,
> >>>>       just want the longer length so I can modify the fdt in-place.  The
> >>>>       current code works, but it seemed silly to do a move if I'm not
> >>>>       actually moving it.
> >>> If fdt == buf, the memmove() in fdt_move() will become a no-op in any
> >>> case.  I don't see any point to conditionalizing the fdt_move().
> >> But it allows me to make the blob bigger.  Ahh, it looks like all I need 
> >> to do is:
> >>          fdt_set_header(fdt, totalsize, bufsize);
> >> so I agree, I'm working way too hard on this one.
> > 
> > No, if you want to make more space to do edits in, you should
> > definitely be using fdt_open_into() - that's the purpose of
> > fdt_open_into().  I'm just saying there's no need to conditionalize
> > the fdt_move(), because fdt_move() *already* correctly handles the
> > case where fdt==buf.
> 
> Not in my copy unless the memmove() implementation counts.

The memmove() implementation is what I mean.  memmove() is defined to
handle overlapping areas - fdt==buf is a degenerate case of
overlapping areas.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
