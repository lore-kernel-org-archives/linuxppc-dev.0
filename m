Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 Jan 2008 18:15:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>, jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [DTC PATCH] libfdt: Add ft_get_next_node(),
	ft_get_next_prop(), and ft_getprop_offset().
Message-ID: <20080116071511.GE5016@localhost.localdomain>
References: <20080114163004.GA27880@ld0162-tx32.am.freescale.net>
	<20080115001657.GC20649@localhost.localdomain>
	<20080115165230.GB10812@ld0162-tx32.am.freescale.net>
	<20080116034939.GB5016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080116034939.GB5016@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 16, 2008 at 02:49:39PM +1100, David Gibson wrote:
> On Tue, Jan 15, 2008 at 10:52:30AM -0600, Scott Wood wrote:
> > On Tue, Jan 15, 2008 at 11:16:57AM +1100, David Gibson wrote:
> > > On Mon, Jan 14, 2008 at 10:30:04AM -0600, Scott Wood wrote:
[snip]
> > > > +	if (depth != 0)
> > > > +		return -FDT_ERR_BADSTRUCTURE;
> > > 
> > > I think this should be FDT_ERR_TRUNCATED.
> > 
> > I'd expect TRUNCATED when we hit totalsize without an FDT_END, not when
> > we hit FDT_END in an inappropriate context.
> 
> Well, TRUNCATED is valid for either situation, and fdt_next_tag() also
> returns FDT_END if it reaches totalsize.

Thought I should elaborate on this a bit - I'm not sure that the
current handling of FDT_ERR_TRUNCATED is entirely correct.  The
description says only when the FDT_END tag is missing, but the way
fdt_next_tag() works means we will also (for some functions, at least)
give this error when FDT_END appears without a suitable number of
FDT_END_NODE tags preceding it.

The rationale behind FDT_ERR_TRUNCATED - why it exists as a separate
code from FDT_ERR_BADSTRUCTURE - is that the read-only functions
should work more-or-less sanely on incomplete trees created by the
sequential-write functions (fdt_sw.c).  FDT_ERR_TRUNCATED is supposed
to indicate that the function couldn't complete properly because the
tree is malformed, but that suitable calls to the fdt_sw functions
could complete the tree so that it's no longer malformed.

I'm not sure that either the comment describing TRUNCATED, or the code
entirely matches that rationale...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
