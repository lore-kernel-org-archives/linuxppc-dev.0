Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64D53DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 22:15:03 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8JCEabp030590
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 08:14:36 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8JCEZhX406978
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 06:14:35 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8JCEZtn026134
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 06:14:35 -0600
Date: Wed, 19 Sep 2007 07:14:33 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Cleanups for physmap_of.c
Message-ID: <20070919071433.69daf024@weaponx.rchland.ibm.com>
In-Reply-To: <20070919041646.GA30212@localhost.localdomain>
References: <20070919041646.GA30212@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Vitaly Wool <vwool@ru.mvista.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Sep 2007 14:16:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This patch includes a whole batch of smallish cleanups for
> drivers/mtd/physmap_of.c.
> 
> 	- A bunch of uneeded #includes are removed
> 	- We switch to the modern linux/of.h etc. in place of
> asm/prom.h
> 	- Use some helper macros to avoid some ugly inline #ifdefs
> 	- A few lines of unreachable code are removed
> 	- A number of indentation / line-wrapping fixes
> 	- More consistent use of kernel idioms such as if (!p) instead
> of if (p == NULL)
> 	- Clarify some printk()s and other informative strings.	

Most of that looks good.  Just a couple issues below.  Mostly it
doesn't apply cleanly to my tree because you didn't base if off of the
patch I sent out last week to fix optional partitions.

> 	- (the big one) Despite the name, this driver really has
> nothing to do with drivers/mtd/physmap.c.  The fact that the flash
> chips must be physically direct mapped is a constrant, but doesn't
> really say anything about the actual purpose of this driver, which is
> to instantiate MTD devices based on information from the device tree.
> Therefore the physmap name is replaced everywhere within the file with
> "of_flash".  The file itself and the Kconfig option is not renamed for
> now (so that the diff is actually a diff).  That can come later.

Later when?  If we're all in agreement, then why don't we just apply
your patch after you fix it up and I can move the file in my git tree.
That way we don't forget about it.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Index: working-2.6/drivers/mtd/maps/physmap_of.c
> ===================================================================
> --- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-09-14 14:24:06.000000000 +1000
> +++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-09-19 13:59:23.000000000 +1000
> @@ -1,5 +1,5 @@
>  /*
> - * Normal mappings of chips in physical memory for OF devices
> + * Flash mappings described by the OF (or flattened) device tree
>   *
>   * Copyright (C) 2006 MontaVista Software Inc.
>   * Author: Vitaly Wool <vwool@ru.mvista.com>
> @@ -15,20 +15,15 @@
> 
>  #include <linux/module.h>
>  #include <linux/types.h>
> -#include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/map.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/mtd/physmap.h>
> -#include <asm/io.h>
> -#include <asm/prom.h>
> -#include <asm/of_device.h>
> -#include <asm/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> 
> -struct physmap_flash_info {
> +struct of_flash {
>  	struct mtd_info		*mtd;
>  	struct map_info		map;
>  	struct resource		*res;
> @@ -38,8 +33,10 @@ struct physmap_flash_info {
>  };
> 
>  #ifdef CONFIG_MTD_PARTITIONS
> +#define OF_FLASH_PARTS(info)	((info)->parts)
> +
>  static int parse_obsolete_partitions(struct of_device *dev,
> -				     struct physmap_flash_info *info,
> +				     struct of_flash *info,
>  				     struct device_node *dp)
>  {
>  	int i, plen, nr_parts;
> @@ -56,11 +53,9 @@ static int parse_obsolete_partitions(str
> 
>  	nr_parts = plen / sizeof(part[0]);
> 
> -	info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition), GFP_KERNEL);
> -	if (!info->parts) {
> -		printk(KERN_ERR "Can't allocate the flash partition data!\n");
> +	info->parts = kzalloc(nr_parts * sizeof(*info->parts), GFP_KERNEL);
> +	if (!info->parts)
>  		return -ENOMEM;

You dropped the printk here.  Any particular reason why?

> -	}
> 
>  	names = of_get_property(dp, "partition-names", &plen);
> 
> @@ -86,8 +81,8 @@ static int parse_obsolete_partitions(str
>  	return nr_parts;
>  }
> 
> -static int __devinit process_partitions(struct physmap_flash_info *info,
> -					struct of_device *dev)
> +static int __devinit parse_partitions(struct of_flash *info,
> +				      struct of_device *dev)
>  {
>  	const char *partname;
>  	static const char *part_probe_types[]
> @@ -109,87 +104,68 @@ static int __devinit process_partitions(
>  	for (pp = dp->child; pp; pp = pp->sibling)
>  		nr_parts++;
> 
> -	if (nr_parts) {
> -		info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition),
> -				      GFP_KERNEL);
> -		if (!info->parts) {
> -			printk(KERN_ERR "Can't allocate the flash partition data!\n");
> -			return -ENOMEM;
> -		}
> +	if (nr_parts == 0)
> +		return parse_obsolete_partitions(dev, info, dp);

You reintroduced the optional partitions bug I fixed with:

http://git.infradead.org/?p=users/jwboyer/powerpc.git;a=commit;h=7cafc8f8c89d1f49039b7c345ca832fbd2d1e639

josh
