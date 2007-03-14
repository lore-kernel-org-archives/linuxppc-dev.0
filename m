Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Mar 2007 10:56:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070314235625.GC12573@localhost.localdomain>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<20070314063546.GH25514@localhost.localdomain>
	<20070314165921.GC10075@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070314165921.GC10075@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 11:59:21AM -0500, Scott Wood wrote:
> On Wed, Mar 14, 2007 at 05:35:46PM +1100, David Gibson wrote:
> > I'm very dubious about this approach.  The basic problem is that
> > pre-device-tree uboot really doesn't much interface commonality across
> > boards.  Each has some kind of bd_t with vaguely similar fields, but
> > that's about the extent of it.  Hence the complete tangle of #ifdefs
> > in ppcboot.h, and the smaller, but still significant number through
> > cuboot.c.  There's no guarantee that there won't be per-board magic
> > necessary in some cases, which will require yet more #ifdefs.
> 
> Sure...  This is solely a compatibility hack to keep the kernel from
> regressing with respect to which firmware it boots on when moving from
> arch/ppc to arch/powerpc.  It's not intended to be a model for how things
> should be done when one has control over the firmware.

Yeah, but there's a lot of arch/ppc boards which can boot from old
u-boots to be ported over eventually.  I just see this as the nucleus
of exactly the same sort of tangled mess we have in arch/ppc.  Even if
it only covers the old boards in arch/ppc not newer ones, it's still
bad enough.

People copy bad examples, even when they're not intended as good
examples.

> > What I'd prefer to see is an approach more like what I've done in my
> > Ebony patches.  With the possible exception of obtaining the MAC
> > addresses, that should work now on old U-Boot as well as on IBM
> > OpenBios (a.k.a. treeboot).
> 
> If you want to get the MAC address, you'll still need the ifdef mess (or
> a per-target offset list, which strikes me as being more error-prone). 

Why so?  If the board .c defines the board's specific bd_t..

> In any case, there's no reason why the two methods can't coexist.  The
> cuboot platform would be used for booting on old u-boots without losing
> functionality such as command line, mac address, and clock passing; a
> simpler here's-a-device-tree-with-everything-filled-in platform could be
> used for other cases.

I'm not expecting the other approach to lose any functionality that
cuboot has.

> > In that approach, each board has its own .c file with whatever code is
> > necessary for filling in the device tree.  That would include, for
> > example, a local definition of the bd_t specifically for that board.
> > The device tree information can come either from a bd_t (or other
> > firmware structure), or directly from the hardware registers (as Ebony
> > is able to do for everything except MAC addresses).  Those board .c
> > files *can* use plenty of common functions and macros to do things
> > that are the same across different boards.  In the ideal case, the
> > board .c will consist of nothing but invocations of a handful of
> > common functions; but it's important that there's still a place there
> > for special case code on any boards which have bugs that need it.
> 
> There is a place for that -- nothing forces every board to go through
> cuboot.c.  Cuboot is just one platform that happens to handle several
> boards.

But it's really not.  It's several platforms that are generated from
one .c file, using cpp.

> > Some specific comments below
> > [snip]
> > > +static void *set_one_mac(void *last_node, unsigned char *addr)
> > > +{
> > > +	void *node = find_node_by_prop_value_str(last_node, "device_type",
> > > +	                                         "network");
> > > +
> > > +	if (node)
> > > +		setprop(node, "local-mac-address", addr, 6);
> > > +
> > > +	return node;
> > > +}
> > 
> > This function isn't safe, because it relies on finding the ethernet
> > devices in a particular order.
> 
> Yes, I was somewhat worried about that, but I don't know what a better
> way to do it would be; "first ethernet", "second ethernet", etc. is all
> the information that u-boot gives.  I suppose we could sort by address,
> but that'd be more code and still not be guaranteed to be right.

No, that would be dumb.

> In any case, it's not the end of the world if the mac addresses get
> reversed, as long as each device has a unique one.  The worst thing
> that's likely to happen is that someone using bootp would have to have
> two entries if the mac addresses get reversed from bootloader to kernel. 
> It could also cause problems if the bootloader uses the network but the
> kernel does not initiate any traffic, causing a switch to send traffic to
> the wrong port.  These problems can be remedied by upgrading the
> firmware. :-)

Ew.  As I say below, a per-board (or per-soc) table can give you this
information.  Or, we could define a "linux,network-index" property to
give the right ordering.

> > > +static void set_mac_addrs(void)
> > > +{
> > > +	__attribute__((unused)) void *node =
> > > +		set_one_mac(NULL, bd.bi_enetaddr);
> > > +
> > > +#ifdef HAVE_ENET1ADDR
> > > +	if (node)
> > > +		node = set_one_mac(node, bd.bi_enet1addr);
> > > +#endif
> > > +#ifdef HAVE_ENET2ADDR
> > > +	if (node)
> > > +		node = set_one_mac(node, bd.bi_enet2addr);
> > > +#endif
> > > +#ifdef HAVE_ENET3ADDR
> > > +	if (node)
> > > +		node = set_one_mac(node, bd.bi_enet3addr);
> > > +#endif
> > > +}
> > 
> > Ick with the #ifdefs.  I think the nice way to do this would be for
> > the board .c file to have a table containing the path to each network
> > node, along with a pointer to the address (generated as a pointer to a
> > field within the bd_t).  That table can be passed to a common helper
> > which will iterate through making the necessary device tree changes
> > for each one.
> 
> If you want to do that for your boards, go ahead -- I'm just trying to
> provide a simple glue layer between the old u-boot interface and the new
> device tree interface.  I'd rather avoid per-board glue except where
> truly necessary.  Per SOC family is a bit more palatable (I already have
> cuboot-83xx.c, cuboot-85xx.c, etc), but individual boards could vary as
> to what's actually hooked up.  This information is already in the device
> tree; I'd rather not have to duplicate it in the wrapper.

Sorry, when I've said "per-board" you can substitute "per-soc" when
there are no relevant devices outside the soc.  And the fact is you
*do* have per-board glue; that's what it means to have #ifdefs all
over the place.

> > [snip]
> > > +#if defined(TARGET_83xx) || defined(TARGET_85xx) || defined(TARGET_86xx)
> > > +	node = find_node_by_prop_value_str(NULL, "device_type",
> > > "soc");
> > 
> > Does the path of the "soc" node actually vary?
> 
> Yes, unfortunately -- the chip model number is in the node name (rather
> than in compatible or model or someplace sensible like that).

Eck.  Again per-soc tables can address this without the need to define
the new finddevice_rel() interface hook.

> > > +	if (node) {
> > > +		void *serial;
> > > +
> > > +		setprop(node, "bus-frequency", &bd.bi_busfreq,
> > > +		        sizeof(bd.bi_busfreq));
> > > +
> > > +		serial = finddevice_rel(node, "serial@4500");
> > > +		if (serial)
> > > +			setprop(serial, "clock-frequency", &bd.bi_busfreq,
> > > +			        sizeof(bd.bi_busfreq));
> > > +
> > > +		serial = finddevice_rel(node, "serial@4600");
> > > +		if (serial)
> > > +			setprop(serial, "clock-frequency", &bd.bi_busfreq,
> > > +			        sizeof(bd.bi_busfreq));
> > > +	}
> > > +#endif
> > 
> > Again with the #ifdefs, and board specific node names being used in
> > the innards here.  
> 
> Technically, it's SOC-specific rather than board-specific (and the ifdef
> limits it to the SOCs where it's relevant).
> 
> > This could also be done more nicely with a table driven approach.
> 
> Agreed.  I'd be OK with factoring out the table into cuboot-83xx.c, etc.
> rather than ifdeffing it in cuboot.c.
> 
> > The fixup of the dts->dtb handling in wrapper, and the optional gzip
> > thing probably don't belong in this patch, though they're reasonable
> > ideas of themselves.
> 
> OK.
> 
> > >  static int __init mpc834x_mds_probe(void)
> > >  {
> > > -        unsigned long root = of_get_flat_dt_root();
> > > +	unsigned long root = of_get_flat_dt_root();
> > >  
> > > -        return of_flat_dt_is_compatible(root, "MPC834xMDS");
> > > +	return 1;
> > > +	return of_flat_dt_is_compatible(root, "MPC834xMDS");
> > >  }
> > 
> > The chunk above looks totally bogus.
> 
> Yeah, that wasn't supposed to be in there (I apparently overlooked it
> when using 'git commit -a').  It was a hack to test the patch on a custom
> board.
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
