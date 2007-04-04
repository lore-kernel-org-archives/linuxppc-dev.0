Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id A786EDDE3F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 12:05:08 +1000 (EST)
Date: Tue, 3 Apr 2007 19:06:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/6] bootwrapper: cuboot for 83xx
Message-ID: <20070404020629.GA2453@mag.az.mvista.com>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194930.GF31965@ld0162-tx32.am.freescale.net>
	<20070323055442.GB27940@localhost.localdomain>
	<20070323153056.GD6060@ld0162-tx32.am.freescale.net>
	<20070323233712.GC4459@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070323233712.GC4459@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 24, 2007 at 10:37:12AM +1100, David Gibson wrote:
> On Fri, Mar 23, 2007 at 10:30:56AM -0500, Scott Wood wrote:
> > On Fri, Mar 23, 2007 at 04:54:42PM +1100, David Gibson wrote:
> > > I don't think you should need a vmlinux_alloc for this platform.
> > 
> > Without it, the kernel has to fit in 4MiB.  As others pointed out, that
> > can be too small if an initramfs is used.  Unlike 8xx (which was what
> > caused me to stick the kernel at 0 in previous patches), 83xx platforms
> > should have plenty of memory above the wrapper.

> Or we could get the wrapper script to base the link/load address on
> the vmlinux size.

That might be handy for some but it won't work for everyone.  Some
platforms require a specific link/load address.  We can provide what
you said as a default but allow it to be overridden by platform code
somehow.

> > > The more complicated reason is that looking ahead to when we're using
> > > libfdt instead of flatdevtree.c, we may need an extra step that
> > > prepares the device tree for read/write access (with libfdt, an
> > > fdt_open_into()).  That won't happen until after platform_init(), but
> > > will be before .fixups().
> > 
> > OK.
> 
> Actually, to be clearer here: this reason actually degenerates to the
> first; I want the "ft_open" step to go after console_open so we can
> get error messages from it.

The problem is,  the console device is specified in the dt so you have
to ft_open before you console_open.

Mark
