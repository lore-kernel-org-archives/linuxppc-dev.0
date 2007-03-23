Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Mar 2007 10:39:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/6] bootwrapper: Add a cuImage target.
Message-ID: <20070323233927.GD4459@localhost.localdomain>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194928.GE31965@ld0162-tx32.am.freescale.net>
	<20070323054048.GA27940@localhost.localdomain>
	<20070323151836.GC6060@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070323151836.GC6060@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 10:18:36AM -0500, Scott Wood wrote:
> On Fri, Mar 23, 2007 at 04:40:48PM +1100, David Gibson wrote:
> > > +cuboot-plats :=
> > > +src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
> > 
> > Rather than this special cuboot-plats stuff, I suggest you just list
> > each cuboot platform in src-plat independently.
> 
> OK, I suppose the number of platforms will be few enough for that.
> 
> > We can also git rid of the need for a CONFIG option specifying the dts
> > (and thereby taking us back to the one-config-per-board era) by using
> > rules like:
> > 
> > $(obj)/uImage.83xx.%: vmlinux $(wrapperbits) $(srctree)/$(src)/dts/%.dts
> > 	$(call if_changed,wrap,cuboot-83xx,$(srctree)/$(src)/dts/$*)
> 
> But then you can't build with an out-of-tree dts.  It's not a huge deal,
> but still...  What's wrong with a config option?

Because it takes us back to reconfigure the kernel for each different
device tree, even though both the vmlinux and the zImage can run
happily on multiple device trees.

> > And to get the right things built use something like:
> > image-$(CONFIG-83xx)	+= $(mpx83xx-boards:%=uImage.83xx.%)
> 
> And then I'd have to determine which boards are supported by the kernel
> that was built, so I don't trick the user into thinking that valid images
> were produced for every single 83xx.  I'd also have to enumerate every
> single board in the makefile, which would suck.

Hrm, yeah that is a bit sucky.  Could we use a wildcard?  Or make
per-platform subdirectories of arch/powerpc/boot/dts?

> > Or optionally add a batch of bool config options for each board
> > variant.
> 
> I don't want to do that.  There shouldn't have to be a 1-1 correspondence
> between each dts file and anything in the kernel.

Yeah, fair enough.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
