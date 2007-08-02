Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 7C140DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 01:21:04 +1000 (EST)
Message-ID: <46B1F6D4.3070707@ru.mvista.com>
Date: Thu, 02 Aug 2007 19:23:00 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
References: <20070730150648.GA5005@ru.mvista.com>	<20070801020836.GB31391@localhost.localdomain>	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
In-Reply-To: <20070801054751.GM31391@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

David Gibson wrote:

>>Also mine.  I've been home sick the last couple of days, but by way of
>>a sharper prod, see my draft work below.  It patches both
>>booting-without-of.txt with a revised binding, and implements it in
>>the physmap_of driver (which needs renaming, but that's another
>>story).  It also revises the ebony device tree as an example.

>>This is certainly not complete - it defines none of the extra
>>properties that JEDEC chips need (although the mtd drivers'
>>defaults/probing seem to cope for ebony).  And there are various other
>>ommisions.  Still, it's a starting point - something precise for you
>>to flame Segher :-p.

    Let me flame you a bit for starters ;-)

> Duh, forgot to attach the actual patch.  Here it is:

> Index: working-2.6/Documentation/powerpc/booting-without-of.txt
> ===================================================================
> --- working-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-07-30 17:07:14.000000000 +1000
> +++ working-2.6/Documentation/powerpc/booting-without-of.txt	2007-07-30 17:07:14.000000000 +1000
> @@ -1757,45 +1757,23 @@ platforms are moved over to use the flat
>  		};
>  	};
>  
> -    j) Flash chip nodes
> +   j) CFI or JEDEC memory-mapped NOR flash
>  
>      Flash chips (Memory Technology Devices) are often used for solid state
>      file systems on embedded devices.
>  
> -    Required properties:
> +     - compatible : should contain the specific model of flash chip(s) used
> +       followed by either "cfi-flash" or "jedec-flash"

    This "compatible" prop (and the node in whole) doesn't say a thing about 
how the flash is mapped into the CPU address space.  I strongly disagree that 
this node provides enough info to select a driver. :-/

> +     - reg : Address range of the flash chip
> +     - bank-width : Width (in bytes) of the flash bank.  Equal to the device width
> +       times the number of interleaved chips.
> +     - device-width : (optional) Width of a single flash chip.  If omitted,
> +       assumed to be equal to 'bank-width'.

    Why then not just introduce the "interleave" prop and obsolete the
"bank-width"?

> -   Example:
> -
> - 	flash@ff000000 {
> - 		device_type = "rom";
> - 		compatible = "direct-mapped";
> - 		probe-type = "CFI";
> - 		reg = <ff000000 01000000>;
> - 		bank-width = <4>;
> - 		partitions = <00000000 00f80000
> - 			      00f80000 00080001>;
> - 		partition-names = "fs\0firmware";
> - 	};

    Why delete the example? :-/

> +    Flash partitions
> +     - reg :
> +     - read-only : (optional)

    All that would look nice but partition is even less of a device than the
original "rom" node was... well, who cares now? :-)

> Index: working-2.6/drivers/mtd/maps/physmap_of.c
> ===================================================================
> --- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-07-30 17:07:11.000000000 +1000
> +++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-07-30 17:07:14.000000000 +1000
[...]
> @@ -30,17 +33,72 @@ struct physmap_flash_info {
>  	struct map_info		map;
>  	struct resource		*res;
>  #ifdef CONFIG_MTD_PARTITIONS
> -	int			nr_parts;
>  	struct mtd_partition	*parts;
>  #endif
>  };
>  
> -static const char *rom_probe_types[] = { "cfi_probe", "jedec_probe", "map_rom", NULL };
>  #ifdef CONFIG_MTD_PARTITIONS
> -static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
> -#endif
> +static int __devinit handle_of_flash_partitions(struct physmap_flash_info *info,
> +						 struct of_device *dev)
> +{
> +	static const char *part_probe_types[]
> +		= { "cmdlinepart", "RedBoot", NULL };
> +	struct device_node *dp = dev->node, *pp;
> +	int nr_parts, i, err;
> +
> +	/* First look for RedBoot table or partitions on the command
> +	 * line, these take precedence over device tree information */
> +	nr_parts = parse_mtd_partitions(info->mtd, part_probe_types,
> +					&info->parts, 0);
> +	if (nr_parts > 0) {
> +		add_mtd_partitions(info->mtd, info->parts, err);
> +		return 0;
> +	}
> +
> +	/* First count the subnodes */
> +	nr_parts = 0;
> +	for (pp = dp->child; pp; pp = pp->sibling)
> +		nr_parts++;
> +
> +	info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition), GFP_KERNEL);
> +	if (!info->parts) {
> +		printk(KERN_ERR "Can't allocate the flash partition data!\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (pp = dp->child, i = 0 ; pp; pp = pp->sibling, i++) {
> +		const u32 *reg;
> +		const char *name;
> +		const void *ro;

    We hardly need the above 2 variables.

> +		int len;
> +
> +		reg = of_get_property(pp, "reg", &len);
> +		if (! reg || (len != 2*sizeof(u32))) {

    Kill the space after !, please.

> +			dev_err(&dev->dev, "Invalid 'reg' on %s\n",
> +				dp->full_name);
> +			err = -EINVAL;
> +			goto fail;
> +		}
> +		info->parts[i].offset = reg[0];
> +		info->parts[i].size = reg[1];
> +
> +		name = of_get_property(pp, "name", &len);
> +		info->parts[i].name = name;
> +
> +		ro = of_get_property(pp, "read-only", &len);
> +		if (ro)
> +			info->parts[i].mask_flags = MTD_WRITEABLE;
> +	}
> +
> +	add_mtd_partitions(info->mtd, info->parts, nr_parts);
> +	return 0;
> +
> + fail:
> +	kfree(info->parts);
> +	info->parts = NULL;
> +	return err;
> +}

    Oh, I see that the new partition representation have really simplified
parsing -- this function is hardly shorter than the old one... :-P

> -#ifdef CONFIG_MTD_PARTITIONS
>  static int parse_flash_partitions(struct device_node *node,
>  		struct mtd_partition **parts)
>  {
> @@ -79,7 +137,14 @@ static int parse_flash_partitions(struct
>  err:
>  	return retval;

    Could get rid of that useless label and goto's in this function, while at
it...

>  }
> -#endif
> +#else /* MTD_PARTITIONS */
> +static int __devinit handle_of_flash_partitions(struct physmap_flash_info *info,
> +						 struct device_node *dev)
> +{
> +	add_mtd_device(info->mtd);
> +	return 0;
> +}
> +#endif /* MTD_PARTITIONS */
>  
>  static int of_physmap_remove(struct of_device *dev)
>  {
> @@ -115,13 +180,45 @@ static int of_physmap_remove(struct of_d
>  	return 0;
>  }
>  
> +/* Helper function to handle probing of the obsolete "direct-mapped"
> + * compatible binding, which has an extra "probe-type" property
> + * describing the type of flash probe necessary. */

    Too early to obsolete it, I'm afraid... :-)

> +static struct mtd_info * __devinit obsolete_probe(struct of_device *dev,
> +						  struct map_info *map)
> +{
> +	struct device_node *dp = dev->node;
> +	const char *of_probe;
> +	struct mtd_info *mtd;
> +	static const char *rom_probe_types[]
> +		= { "cfi_probe", "jedec_probe", "map_rom"};
> +	int i;
> +
> +	of_probe = of_get_property(dp, "probe-type", NULL);
> +	if (!of_probe) {
> +		for (i = 0; i < ARRAY_SIZE(rom_probe_types); i++) {
> +			mtd = do_map_probe(rom_probe_types[i], map);
> +			if (mtd)
> +				return mtd;
> +		}
> +		return NULL;
> +	} else if (strcmp(of_probe, "CFI") == 0) {
> +		return do_map_probe("cfi_probe", map);
> +	} else if (strcmp(of_probe, "JEDEC") == 0) {
> +		return do_map_probe("jedec_probe", map);
> +	} else {
> + 		if (strcmp(of_probe, "ROM") != 0)
> +			dev_dbg(&dev->dev, "obsolete_probe: don't know probe type "
> +				"'%s', mapping as rom\n", of_probe);
> +		return do_map_probe("mtd_rom", map);
> +	}
> +}
> +
>  static int __devinit of_physmap_probe(struct of_device *dev, const struct of_device_id *match)
>  {
>  	struct device_node *dp = dev->node;
>  	struct resource res;
>  	struct physmap_flash_info *info;
> -	const char **probe_type;
> -	const char *of_probe;
> +	const char *probe_type = (const char *)match->data;
>  	const u32 *width;
>  	int err;
[...]
> @@ -221,6 +297,14 @@ err_out:
>  
>  static struct of_device_id of_physmap_match[] = {
>  	{
> +		.compatible	= "cfi-flash",
> +		.data		= (void *)"cfi_probe",
> +	},
> +	{
> +		.compatible	= "jedec-flash",
> +		.data		= (void *)"jedec_probe",
> +	},
> +	{

    This would also trigger on non-linearly mapped CFI or JEDEC flashes which 
is not a good idea -- however, as we're using the MTD probing code anyway, it 
will just fail, so it's not luckily is not a fatal design flaw.

>  		.type		= "rom",
>  		.compatible	= "direct-mapped"
>  	},
> Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-07-30 17:07:14.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-07-30 17:07:14.000000000 +1000
[...]
> @@ -158,14 +161,20 @@
>  				};
>  
>  				large-flash@2,0 {

    Hmm... what does @2,0 mean? :-O

> -					device_type = "rom";
> -					compatible = "direct-mapped";
> -					probe-type = "JEDEC";
> +					compatible = "jedec-flash";
>  					bank-width = <1>;
> -					partitions = <0 380000
> -						      380000 80000>;
> -					partition-names = "fs", "firmware";
> +//					partitions = <0 380000
> +//						      380000 80000>;
> +//					partition-names = "fs", "firmware";
>  					reg = <2 0 400000>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;

    Heh...

> +					fs@0 {
> +						reg = <0 380000>;
> +					};
> +					firmware@380000 {
> +						reg = <380000 80000>;

   I guess the "firmware" should have a "read-only" prop...

> +					};
>  				};

    So, I don't see what we're really winning with your changes...

WBR, Sergei
