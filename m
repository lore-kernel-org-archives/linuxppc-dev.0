Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Mar 2007 17:35:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070314063546.GH25514@localhost.localdomain>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:42:04PM -0600, Scott Wood wrote:
> Add a bootwrapper platform (cuboot) that takes a bd_t from a legacy
> U-Boot, and inserts data from it into a device tree which has been
> compiled into the kernel.  This should help ease the transition to
> arch/powerpc in cases where U-Boot has not yet been updated to pass a
> device tree, or where upgrading firmware isn't practical.
> 
> The device trees currently in the kernel tree must have
> /chosen/linux,stdout-path added to work with cuboot.
> 
> The kernel command line, mac addresses, and various clocks will be filled
> in based on the bd_t.

I'm very dubious about this approach.  The basic problem is that
pre-device-tree uboot really doesn't much interface commonality across
boards.  Each has some kind of bd_t with vaguely similar fields, but
that's about the extent of it.  Hence the complete tangle of #ifdefs
in ppcboot.h, and the smaller, but still significant number through
cuboot.c.  There's no guarantee that there won't be per-board magic
necessary in some cases, which will require yet more #ifdefs.

What I'd prefer to see is an approach more like what I've done in my
Ebony patches.  With the possible exception of obtaining the MAC
addresses, that should work now on old U-Boot as well as on IBM
OpenBios (a.k.a. treeboot).

In that approach, each board has its own .c file with whatever code is
necessary for filling in the device tree.  That would include, for
example, a local definition of the bd_t specifically for that board.
The device tree information can come either from a bd_t (or other
firmware structure), or directly from the hardware registers (as Ebony
is able to do for everything except MAC addresses).  Those board .c
files *can* use plenty of common functions and macros to do things
that are the same across different boards.  In the ideal case, the
board .c will consist of nothing but invocations of a handful of
common functions; but it's important that there's still a place there
for special case code on any boards which have bugs that need it.

I think that in many cases, the same zImage should be able to boot on
a board with old u-boot, and on the same board with vendor firmware
where such exists (e.g. treeboot).

Some specific comments below
[snip]
> +static void *set_one_mac(void *last_node, unsigned char *addr)
> +{
> +	void *node = find_node_by_prop_value_str(last_node, "device_type",
> +	                                         "network");
> +
> +	if (node)
> +		setprop(node, "local-mac-address", addr, 6);
> +
> +	return node;
> +}

This function isn't safe, because it relies on finding the ethernet
devices in a particular order.  In general I've tried to make dtc
output nodes in the same order they're in the dts file, but that
behaviour isn't guaranteed: for robustness, users of a device tree
blob should not rely on the order of nodes.  There have certainly been
interim versions of dtc which reversed the order of nodes between
input and output because of the way I handled lists.

> +static void set_mac_addrs(void)
> +{
> +	__attribute__((unused)) void *node =
> +		set_one_mac(NULL, bd.bi_enetaddr);
> +
> +#ifdef HAVE_ENET1ADDR
> +	if (node)
> +		node = set_one_mac(node, bd.bi_enet1addr);
> +#endif
> +#ifdef HAVE_ENET2ADDR
> +	if (node)
> +		node = set_one_mac(node, bd.bi_enet2addr);
> +#endif
> +#ifdef HAVE_ENET3ADDR
> +	if (node)
> +		node = set_one_mac(node, bd.bi_enet3addr);
> +#endif
> +}

Ick with the #ifdefs.  I think the nice way to do this would be for
the board .c file to have a table containing the path to each network
node, along with a pointer to the address (generated as a pointer to a
field within the bd_t).  That table can be passed to a common helper
which will iterate through making the necessary device tree changes
for each one.

[snip]
> +#if defined(TARGET_83xx) || defined(TARGET_85xx) || defined(TARGET_86xx)
> +	node = find_node_by_prop_value_str(NULL, "device_type",
> "soc");

Does the path of the "soc" node actually vary?

> +	if (node) {
> +		void *serial;
> +
> +		setprop(node, "bus-frequency", &bd.bi_busfreq,
> +		        sizeof(bd.bi_busfreq));
> +
> +		serial = finddevice_rel(node, "serial@4500");
> +		if (serial)
> +			setprop(serial, "clock-frequency", &bd.bi_busfreq,
> +			        sizeof(bd.bi_busfreq));
> +
> +		serial = finddevice_rel(node, "serial@4600");
> +		if (serial)
> +			setprop(serial, "clock-frequency", &bd.bi_busfreq,
> +			        sizeof(bd.bi_busfreq));
> +	}
> +#endif

Again with the #ifdefs, and board specific node names being used in
the innards here.  This could also be done more nicely with a table
driven approach.

[snip]
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 157d8c8..99bf85e 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -29,6 +29,7 @@ initrd=
>  dtb=
>  dts=
>  cacheit=
> +gzip=.gz
>  
>  # cross-compilation prefix
>  CROSS=
> @@ -104,9 +105,9 @@ done
>  
>  if [ -n "$dts" ]; then
>      if [ -z "$dtb" ]; then
> -	dtb="$platform.dtb"
> +	dtb="$tmpdir/$platform.dtb"
>      fi
> -    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
> +    dtc -f -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1

The fixup of the dts->dtb handling in wrapper, and the optional gzip
thing probably don't belong in this patch, though they're reasonable
ideas of themselves.

[snip]
> diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
> index e5d8191..77c298c 100644
> --- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
> @@ -180,9 +180,10 @@ late_initcall(mpc834x_rtc_hookup);
>   */
>  static int __init mpc834x_mds_probe(void)
>  {
> -        unsigned long root = of_get_flat_dt_root();
> +	unsigned long root = of_get_flat_dt_root();
>  
> -        return of_flat_dt_is_compatible(root, "MPC834xMDS");
> +	return 1;
> +	return of_flat_dt_is_compatible(root, "MPC834xMDS");
>  }

The chunk above looks totally bogus.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
