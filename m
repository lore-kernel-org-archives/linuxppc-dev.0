Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCHv2] powerpc: DBox2 Board Support
Date: Mon, 24 Dec 2007 13:18:01 +0100
References: <476E9930.6000205@scram.de>
In-Reply-To: <476E9930.6000205@scram.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712241318.02299.arnd@arndb.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 23 December 2007, Jochen Friedrich wrote:
> This patch adds device tree source, default config and setup code for
> DBox2 devices.

Cool stuff. I used to have one of these boxes myself, maybe I should
get one again when it's hitting mainline.

Is this already a complete port, or do you also need some device
drivers or boot wrapper code to go along with it?

> +	memory {
> +		device_type = "memory";
> +		reg = <0 2000000>;
> +	};

I thought there are both models with 32MB and 16MB available.
If that's true, shouldn't this be filled out by the boot loader?

> +#
> +# Frame buffer hardware drivers
> +#
> +# CONFIG_FB_OF is not set
> +# CONFIG_FB_VGA16 is not set
> +# CONFIG_FB_S1D13XXX is not set
> +# CONFIG_FB_IBM_GXT4500 is not set
> +# CONFIG_FB_VIRTUAL is not set
> +# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

No hardware framebuffer driver? Can't you use
the FB_OF driver by default? I'd guess that a
set-top box without output is rather pointless ;-)

> +# DOS/FAT/NT Filesystems
> +#
> +CONFIG_FAT_FS=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_FAT_DEFAULT_CODEPAGE=437
> +CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> +# CONFIG_NTFS_FS is not set

What media can you connect that use the FAT file system?

I'd guess that if you can get rid of these, you can also
disable the entire block layer, which should free up
some kernel memory.

> @@ -0,0 +1,30 @@
> +/*
> + * A collection of structures, addresses, and values associated with
> + * the DBox2.
> + *
> + * Author: (c) 2007 Jochen Friedrich
> + *
> + * This file is licensed under the
> + * terms of the GNU General Public License version 2.  This program is licensed
> + * "as is" without any warranty of any kind, whether express or implied.
> + */
> +
> +#ifdef __KERNEL__
> +#ifndef __ASM_DBOX2_H__
> +#define __ASM_DBOX2_H__

You don't need the #ifdef __KERNEL__ any more if you don't have
any user-visible parts in the header. Just leave it out of the
list of exported header files (as you already do).

> +
> +/* Vendor information in BR Bootloader
> + */
> +
> +#define DBOX2_VENDOR_OFFSET	(0x1ffe0)
> +
> +enum dbox2_mid {
> +	DBOX2_MID_NOKIA       = 1,
> +	DBOX2_MID_PHILIPS     = 2,
> +	DBOX2_MID_SAGEM       = 3,
> +};
> +
> +enum dbox2_mid dbox2_get_mid(void);

Can you move this functionality from the kernel to the boot wrapper?
It looks like this is something that really belongs into the device
tree.

> +static void __init dbox2_setup_arch(void)
> +{
> +	struct device_node *np;
> +	static u8 __iomem *config;
> +
> +	cpm_reset();
> +	init_ioports();
> +
> +	/* Enable external IRQs for AVIA chips */
> +	clrbits32(&mpc8xx_immr->im_siu_conf.sc_siumcr, 0x00000c00);

This smells like a hack. What are AVIA chips, and shouldn't
their driver enable the IRQs?

> +	if (dbox2_manuf_id == DBOX2_MID_NOKIA)
> +		np = of_find_node_by_path("/localbus@8000000/enx@0");
> +	else
> +		np = of_find_node_by_path("/localbus@8000000/gtx@0");
> +
> +	if (np) {
> +		of_detach_node(np);
> +		of_node_put(np);
> +	}
> +
> +	if (dbox2_manuf_id == DBOX2_MID_PHILIPS)
> +		np = of_find_node_by_path("/localbus@8000000/cam@4000000");
> +	else
> +		np = of_find_node_by_path("/localbus@8000000/cam@4040000");
> +
> +	if (np) {
> +		of_detach_node(np);
> +		of_node_put(np);
> +	}
> +}

What is this code for? Why do you want to detach nodes from the device
tree that have been put in there by the boot loader?

> +static struct of_device_id __initdata of_bus_ids[] = {
> +	{ .name = "soc", },
> +	{ .name = "cpm", },
> +	{ .name = "localbus", },
> +	{},
> +};

Shouldn't this check for 'compatible' properties instead of 'name'?

> +static int __init declare_of_platform_devices(void)
> +{
> +	/* Publish the QE devices */
> +	if (machine_is(dbox2))
> +		of_platform_bus_probe(NULL, of_bus_ids, NULL);
> +
> +	return 0;
> +}
> +device_initcall(declare_of_platform_devices);

This is a candidate for the new platform_initcall stuff.

I also once did a patch that let you have a default 'of_bus_ids'
member in the ppc_md. I never got around to submitting that, but
if there is interest, I can dig it out again.

> --- a/include/asm-powerpc/mpc8xx.h
> +++ b/include/asm-powerpc/mpc8xx.h
> @@ -23,6 +23,10 @@
>  #include <platforms/8xx/mpc885ads.h>
>  #endif
>  
> +#if defined(CONFIG_DBOX2)
> +#include <platforms/8xx/dbox2.h>
> +#endif
> +

Don't hide #includes or platform specific #defines in #ifdef.

	Arnd <><
