Return-Path: <jochen@scram.de>
Message-ID: <47726DB5.2030507@scram.de>
Date: Wed, 26 Dec 2007 16:05:25 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2] powerpc: DBox2 Board Support
References: <476E9930.6000205@scram.de> <200712241318.02299.arnd@arndb.de>
In-Reply-To: <200712241318.02299.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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

Hi Arnd,

>> This patch adds device tree source, default config and setup code for
>> DBox2 devices.
> 
ia > Cool stuff. I used to have one of these boxes myself, maybe I should
> get one again when it's hitting mainline.
> 
> Is this already a complete port, or do you also need some device
> drivers or boot wrapper code to go along with it?

Currently, it needs the u-boot patches from cvs.tuxbox.org and some
external device drivers (however, they can all be loaded as modules).
The port is complete enough to get a console on the serial port and
a rootfs either on flash or on nfs.

>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0 2000000>;
>> +	};
> 
> I thought there are both models with 32MB and 16MB available.
> If that's true, shouldn't this be filled out by the boot loader?

IIRC, the cuImage wrapper overwrites this with the boot loader
parameters.

OTOH, the memory is part of the localbus (CS1). Should it be a child
of localbus in this case?

>> +#
>> +# Frame buffer hardware drivers
>> +#
>> +# CONFIG_FB_OF is not set
>> +# CONFIG_FB_VGA16 is not set
>> +# CONFIG_FB_S1D13XXX is not set
>> +# CONFIG_FB_IBM_GXT4500 is not set
>> +# CONFIG_FB_VIRTUAL is not set
>> +# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
> No hardware framebuffer driver? Can't you use
> the FB_OF driver by default? I'd guess that a
> set-top box without output is rather pointless ;-)

I didn't check FB_OF. On Dbox2, the avia driver creates a 
framebuffer device.

>> +# DOS/FAT/NT Filesystems
>> +#
>> +CONFIG_FAT_FS=y
>> +CONFIG_MSDOS_FS=y
>> +CONFIG_VFAT_FS=y
>> +CONFIG_FAT_DEFAULT_CODEPAGE=437
>> +CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
>> +# CONFIG_NTFS_FS is not set
> 
> What media can you connect that use the FAT file system?
> 
> I'd guess that if you can get rid of these, you can also
> disable the entire block layer, which should free up
> some kernel memory.

There are two mods available using the block layer, although currently i don't
support any of them:

1. using the GPIO lines of the modem port, it's possible to connect a SD card.
   It might be possible to use it using the GPIO SPI driver (but it would need
   some glue code to create a platform device).

2. using the memory expansion port and CS2, there is an IDE interface available
   with a CPLD acting as localbus/IDE bridge. There is a device driver for
   ARCH=ppc.

Unfortunately, i don't own any of these modifications.

>> +
>> +/* Vendor information in BR Bootloader
>> + */
>> +
>> +#define DBOX2_VENDOR_OFFSET	(0x1ffe0)
>> +
>> +enum dbox2_mid {
>> +	DBOX2_MID_NOKIA       = 1,
>> +	DBOX2_MID_PHILIPS     = 2,
>> +	DBOX2_MID_SAGEM       = 3,
>> +};
>> +
>> +enum dbox2_mid dbox2_get_mid(void);
> 
> Can you move this functionality from the kernel to the boot wrapper?
> It looks like this is something that really belongs into the device
> tree.

OK.

>> +	if (dbox2_manuf_id == DBOX2_MID_NOKIA)
>> +		np = of_find_node_by_path("/localbus@8000000/enx@0");
>> +	else
>> +		np = of_find_node_by_path("/localbus@8000000/gtx@0");
>> +
>> +	if (np) {
>> +		of_detach_node(np);
>> +		of_node_put(np);
>> +	}
>> +
>> +	if (dbox2_manuf_id == DBOX2_MID_PHILIPS)
>> +		np = of_find_node_by_path("/localbus@8000000/cam@4000000");
>> +	else
>> +		np = of_find_node_by_path("/localbus@8000000/cam@4040000");
>> +
>> +	if (np) {
>> +		of_detach_node(np);
>> +		of_node_put(np);
>> +	}
>> +}
> 
> What is this code for? Why do you want to detach nodes from the device
> tree that have been put in there by the boot loader?

There are small differences between the 3 manufacturers. I guess this
should go to the boot wrapper, as well.

This is even more important if the localbus uses #address-cells = <2>, as
the differen manufacturers set up the address mapping for CS3, CS5 and CS7
differently.

>> +static void __init dbox2_setup_arch(void)
>> +{
>> +	struct device_node *np;
>> +	static u8 __iomem *config;
>> +
>> +	cpm_reset();
>> +	init_ioports();
>> +
>> +	/* Enable external IRQs for AVIA chips */
>> +	clrbits32(&mpc8xx_immr->im_siu_conf.sc_siumcr, 0x00000c00);
> 
> This smells like a hack. What are AVIA chips, and shouldn't
> their driver enable the IRQs?

No. This just configures the Pin as IRQ input. Maybe, the new GPIO
functions could be used for this, instead. Then it could be done
in the driver (the driver should't directly mess with SIU internals).

>> +static struct of_device_id __initdata of_bus_ids[] = {
>> +	{ .name = "soc", },
>> +	{ .name = "cpm", },
>> +	{ .name = "localbus", },
>> +	{},
>> +};
> 
> Shouldn't this check for 'compatible' properties instead of 'name'?

I copied this from mpc885ads_setup.c.

>> +static int __init declare_of_platform_devices(void)
>> +{
>> +	/* Publish the QE devices */
>> +	if (machine_is(dbox2))
>> +		of_platform_bus_probe(NULL, of_bus_ids, NULL);
>> +
>> +	return 0;
>> +}
>> +device_initcall(declare_of_platform_devices);
> 
> This is a candidate for the new platform_initcall stuff.
> 
> I also once did a patch that let you have a default 'of_bus_ids'
> member in the ppc_md. I never got around to submitting that, but
> if there is interest, I can dig it out again.

That would be nice :)

>> --- a/include/asm-powerpc/mpc8xx.h
>> +++ b/include/asm-powerpc/mpc8xx.h
>> @@ -23,6 +23,10 @@
>>  #include <platforms/8xx/mpc885ads.h>
>>  #endif
>>  
>> +#if defined(CONFIG_DBOX2)
>> +#include <platforms/8xx/dbox2.h>
>> +#endif
>> +
> 
> Don't hide #includes or platform specific #defines in #ifdef.

As soon as the manufacturer info is included in the device tree,
dbox2.h is no longer needed.

Thanks,
Jochen
