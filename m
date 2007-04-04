Return-Path: <dgibson@ozlabs.org>
Date: Wed, 4 Apr 2007 16:38:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 6/6] bootwrapper: cuboot for 83xx
Message-ID: <20070404063834.GA26616@localhost.localdomain>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194930.GF31965@ld0162-tx32.am.freescale.net>
	<20070323055442.GB27940@localhost.localdomain>
	<20070323153056.GD6060@ld0162-tx32.am.freescale.net>
	<20070323233712.GC4459@localhost.localdomain>
	<20070404020629.GA2453@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070404020629.GA2453@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2007 at 07:06:29PM -0700, Mark A. Greer wrote:
> On Sat, Mar 24, 2007 at 10:37:12AM +1100, David Gibson wrote:
> > On Fri, Mar 23, 2007 at 10:30:56AM -0500, Scott Wood wrote:
> > > On Fri, Mar 23, 2007 at 04:54:42PM +1100, David Gibson wrote:
> > > > I don't think you should need a vmlinux_alloc for this platform.
> > > 
> > > Without it, the kernel has to fit in 4MiB.  As others pointed out, that
> > > can be too small if an initramfs is used.  Unlike 8xx (which was what
> > > caused me to stick the kernel at 0 in previous patches), 83xx platforms
> > > should have plenty of memory above the wrapper.
> 
> > Or we could get the wrapper script to base the link/load address on
> > the vmlinux size.
> 
> That might be handy for some but it won't work for everyone.  Some
> platforms require a specific link/load address.  We can provide what
> you said as a default but allow it to be overridden by platform code
> somehow.

Sure.  The wrapper already does platform dependent things, so I was
assuming it would only do this for some platforms.

> > > > The more complicated reason is that looking ahead to when we're using
> > > > libfdt instead of flatdevtree.c, we may need an extra step that
> > > > prepares the device tree for read/write access (with libfdt, an
> > > > fdt_open_into()).  That won't happen until after platform_init(), but
> > > > will be before .fixups().
> > > 
> > > OK.
> > 
> > Actually, to be clearer here: this reason actually degenerates to the
> > first; I want the "ft_open" step to go after console_open so we can
> > get error messages from it.
> 
> The problem is,  the console device is specified in the dt so you have
> to ft_open before you console_open.

Sorry, I should clarify.  In the context of libfdt, I was thinking
*read* access to the fdt can happen at any point - right from
platform_init().  ft_open() would mark the point at which write access
to the tree can begin.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
