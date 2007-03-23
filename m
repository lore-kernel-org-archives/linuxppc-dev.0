Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Mar 2007 10:37:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/6] bootwrapper: cuboot for 83xx
Message-ID: <20070323233712.GC4459@localhost.localdomain>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194930.GF31965@ld0162-tx32.am.freescale.net>
	<20070323055442.GB27940@localhost.localdomain>
	<20070323153056.GD6060@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070323153056.GD6060@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 10:30:56AM -0500, Scott Wood wrote:
> On Fri, Mar 23, 2007 at 04:54:42PM +1100, David Gibson wrote:
> > I don't think you should need a vmlinux_alloc for this platform.
> 
> Without it, the kernel has to fit in 4MiB.  As others pointed out, that
> can be too small if an initramfs is used.  Unlike 8xx (which was what
> caused me to stick the kernel at 0 in previous patches), 83xx platforms
> should have plenty of memory above the wrapper.

I think we ought to be able to find a better way.  Thing is, when we
have a huge initramfs/kernel is the same case that having the kernel
relocate itself hurts the most.

Is there any reasonable way we can determine the memory size early
enough for the zImage to relocate itself to (approximately) the top of
RAM first thing?

Or we could get the wrapper script to base the link/load address on
the vmlinux size.

> In fact, it should probably be the default to use ordinary malloc for the
> vmlinux, at least if it doesn't fit at 0.  If a platform *needs* it at
> zero, it can supply a vmlinux_alloc that always either returns 0 or
> fails.

I'd actually really like to get rid of malloc() from the zImage
entirely.  I think it's possible when we switch to libfdt..

> > > +	simple_alloc_init(_end, avail_ram, 32, 64);
> > > +	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
> > > +	serial_console_init();
> > > +	platform_ops.vmlinux_alloc = vmlinux_alloc;
> > 
> > 
> > I think this should be the end of platform_init.  The actual device
> > tree mangling should instead be done from the .fixups hook function.
> > The simple reason is that in general we want to defer as much as
> > possible until after the console_open so that we can get error
> > messages. 
> 
> Serial output with ns16550.c works after serial_console_init() even
> before open() is called, but I agree in principle.

Yes I know, but I'm making the suggestion in principle ;-).

> > The more complicated reason is that looking ahead to when we're using
> > libfdt instead of flatdevtree.c, we may need an extra step that
> > prepares the device tree for read/write access (with libfdt, an
> > fdt_open_into()).  That won't happen until after platform_init(), but
> > will be before .fixups().
> 
> OK.

Actually, to be clearer here: this reason actually degenerates to the
first; I want the "ft_open" step to go after console_open so we can
get error messages from it.

> > > +	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
> > > +	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
> > > +	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
> > > +
> > > +	soc = find_node_by_devtype(NULL, "soc");
> > 
> > Hrm... more-or-less by definition, cuboot will be using the device
> > trees included in the kernel tree.  So why can't we just fix the mpc
> > device trees so the soc node is just called "/soc" instead of having to
> > use this find by type stuff.
> 
> I'm not sure that it's true that only in-tree device trees would be used
> -- I can imagine customers having old firmware on custom boards that
> would like to upgrade the kernel, but do not want to upgrade the
> firmware.

Um.. since the zImage's tree comes from the kernel, what does
upgrading the firmware have to do with it?

> I'd be happy to see the name be changed to just be "/soc", though it
> would require u-boot changes.

Err.. why?

> > > +	if (soc) {
> > > +		void *serial = NULL;
> > > +
> > > +		setprop(soc, "bus-frequency", &bd.bi_busfreq,
> > > +		        sizeof(bd.bi_busfreq));
> > 
> > This should probably just be 'clock-frequency' on the soc node (since
> > the soc node represents the on-chip bus).  But to fix that I guess
> > we'd need parallel changes to the kernel proper.
> 
> And to u-boot, if we don't want to have to support both properties.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
