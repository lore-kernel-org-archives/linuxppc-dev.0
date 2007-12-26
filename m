Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv2] powerpc: DBox2 Board Support
Date: Wed, 26 Dec 2007 20:53:53 +0100
References: <476E9930.6000205@scram.de> <200712241318.02299.arnd@arndb.de>
	<47726DB5.2030507@scram.de>
In-Reply-To: <47726DB5.2030507@scram.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200712262053.55150.arnd@arndb.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 December 2007, Jochen Friedrich wrote:
> >> +	memory {
> >> +		device_type = "memory";
> >> +		reg = <0 2000000>;
> >> +	};
> > 
> > I thought there are both models with 32MB and 16MB available.
> > If that's true, shouldn't this be filled out by the boot loader?
> 
> IIRC, the cuImage wrapper overwrites this with the boot loader
> parameters.

Then maybe set it to zero size in the dts file, and add a comment.
 
> OTOH, the memory is part of the localbus (CS1). Should it be a child
> of localbus in this case?

No, memory nodes are required to be at the root of the device tree
for historic reasons.

> I didn't check FB_OF. On Dbox2, the avia driver creates a 
> framebuffer device.

fb_of needs some properties in the device tree set up correctly,
but is very simple otherwise. If it does all you need, it's
probably a good idea to use that and get rid of the avia framebuffer
driver

> There are two mods available using the block layer, although currently i don't
> support any of them:
> 
> 1. using the GPIO lines of the modem port, it's possible to connect a SD card.
>    It might be possible to use it using the GPIO SPI driver (but it would need
>    some glue code to create a platform device).
> 
> 2. using the memory expansion port and CS2, there is an IDE interface available
>    with a CPLD acting as localbus/IDE bridge. There is a device driver for
>    ARCH=ppc.
> 
> Unfortunately, i don't own any of these modifications.

If neither of these is in the mainline kernel, it doesn't make sense to
have support for the block layer in defconfig, so just try how much 
memory you can free up with this.

> >> +static void __init dbox2_setup_arch(void)
> >> +{
> >> +	struct device_node *np;
> >> +	static u8 __iomem *config;
> >> +
> >> +	cpm_reset();
> >> +	init_ioports();
> >> +
> >> +	/* Enable external IRQs for AVIA chips */
> >> +	clrbits32(&mpc8xx_immr->im_siu_conf.sc_siumcr, 0x00000c00);
> > 
> > This smells like a hack. What are AVIA chips, and shouldn't
> > their driver enable the IRQs?
> 
> No. This just configures the Pin as IRQ input. Maybe, the new GPIO
> functions could be used for this, instead. Then it could be done
> in the driver (the driver should't directly mess with SIU internals).

Maybe it should then be done in the boot wrapper. If the device
tree lists this line as an interrupt, I'd say that is what it should
be.

> >> +static struct of_device_id __initdata of_bus_ids[] = {
> >> +	{ .name = "soc", },
> >> +	{ .name = "cpm", },
> >> +	{ .name = "localbus", },
> >> +	{},
> >> +};
> > 
> > Shouldn't this check for 'compatible' properties instead of 'name'?
> 
> I copied this from mpc885ads_setup.c.

Right, I noticed before that we're rather inconsistent with this.
It would really be good to have more common standards on this.

> > I also once did a patch that let you have a default 'of_bus_ids'
> > member in the ppc_md. I never got around to submitting that, but
> > if there is interest, I can dig it out again.
> 
> That would be nice :)

The reason I haven't submitted it yet is that I'm not sure whether
there are cases where we actually _need_ to test for 'name' instead
of 'compatible' because of existing device trees in firmware.

I might just do a patch and see if someone complains about the
idea.
 
	Arnd <><
