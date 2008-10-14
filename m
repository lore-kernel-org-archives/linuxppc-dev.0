Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id A22CBDE2AF
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 03:45:43 +1100 (EST)
Subject: Re: MPC8321, ethernet and i2c problems after upgrade from 2.6.25
	to 2.6.27
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20081014152758.GC12934@ld0162-tx32.am.freescale.net>
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
	<20081013163151.GD19080@ld0162-tx32.am.freescale.net>
	<1223918059.32141.62.camel@gentoo-jocke.transmode.se>
	<48F393EB.6000100@freescale.com> <48F39B97.6030602@freescale.com>
	<1223970931.32141.80.camel@gentoo-jocke.transmode.se>
	<20081014152758.GC12934@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 18:45:40 +0200
Message-Id: <1224002740.32141.103.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-14 at 10:27 -0500, Scott Wood wrote:
> On Tue, Oct 14, 2008 at 09:55:31AM +0200, Joakim Tjernlund wrote:
> > On Mon, 2008-10-13 at 14:03 -0500, Scott Wood wrote:
> > > Joakim Tjernlund wrote:
> > > > Because all the kernel comments I can see still implies that this should work
> > > 
> > > Which kernel comments?
> > 
> > The one already mentioned and in i2c-boardinfo.c
> 
> I already addressed the one already mentioned (it was sloppy terminology
> in the comment, written from the perspective of devtree-less arches). 
> The latter is even less clear, as it doesn't mention dynamic buses at
> all.
> 
> Feel free to submit a documentation patch clearing it up. :-)
> 
> > > > and because this was the only way in earlier releases to add an i2c device.
> > > 
> > > We've supported enumerating i2c-mpc devices using the device tree for 
> > > almost as long as there's been new-style i2c devices.
> > 
> > Don't know how long that has been but looking at the mpc832x_mds dts
> > file it has been there less than a year.
> 
> commit d13ae8620dfdedfa7e9ab6d1eec294adc0516065 added i2c device probing
> from the device tree in 7/21/07, less than 3 months after new-style i2c
> devices were added to the i2c core.  There were patches floating around
> the lists for longer than that.
> 
> > > Why not?  U-boot allows you to pass in a device tree dynamically.
> > 
> > I don't use a dynamic device tree, mine is built in.
> 
> So do a fixup in your board code.

Just did and this is what I came up with:
/* This should be removed once we have the rtc in u-boot's
   device tree */
static struct device_node *new_node(const char *path,
		struct device_node *parent)
{
	struct device_node *np = kzalloc(sizeof(*np), GFP_KERNEL);

	if (!np)
		return NULL;
	np->full_name = kmalloc(strlen(path) + 1, GFP_KERNEL);
	if (!np->full_name) {
		kfree(np);
		return NULL;
	}
	strcpy(np->full_name, path);
	of_node_set_flag(np, OF_DYNAMIC);
	kref_init(&np->kref);
	np->parent = of_node_get(parent);
	return np;
}

static struct property prop_compatible = {
	.name "compatible",
	.value = "dallas,ds1337",
	.length = sizeof("dallas,ds1337"),
};
static const unsigned long rtc_addr = 0x68;
static struct property prop_reg = {
	.name "reg",
	.value = &rtc_addr,
	.length = sizeof(rtc_addr),
};

int __init tmcu_i2c_board_devs(void)
{
	int ret=0;
	struct device_node *np, *i2c_np, *rtc_node=NULL;

	i2c_np = of_find_node_by_name(NULL, "i2c");
	if (!i2c_np)
		return -1;
	np = of_find_node_by_name(i2c_np, "rtc");
	if (!np) {
		rtc_node = new_node("/rtc", i2c_np);
		prom_add_property(rtc_node, &prop_compatible);
		prom_add_property(rtc_node, &prop_reg);
		of_attach_node(rtc_node);
	}
	return ret;
}
arch_initcall(tmcu_i2c_board_devs);

Wasn't easy to find out how, strangely I could not find a generic
new_node() function, had to copy one.

> 
> I'm not sure how you would even go about building a device tree into
> U-boot currently, though.

That is easy :)
