Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 373C3DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 15:23:02 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l7T5N3bM018359
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 15:23:03 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7T5QYCd177806
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 15:26:34 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7T6N0xf028415
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 16:23:00 +1000
Date: Wed, 29 Aug 2007 15:22:54 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Document and implement an improved flash device binding for
	powerpc
Message-ID: <20070829052254.GA3206@localhost.localdomain>
References: <20070828034751.GD6811@localhost.localdomain>
	<20070828133926.230b4132@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828133926.230b4132@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2007 at 01:39:26PM -0500, Josh Boyer wrote:
> On Tue, 28 Aug 2007 13:47:51 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > This patch replaces the binding for flash chips in
> > booting-without-of.txt with an clarified and improved version.  It
> > also makes drivers/mtd/maps/physmap_of.c recognize this new binding.
> > Finally it revises the Ebony device tree source to use the new binding
> > as an example.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > I don't know that this is ready yet, but I thought I'd try to kick
> > along the rather stalled process of getting this new flash binding in
> > place by sending out my current draft.
> > 
> > Index: working-2.6/Documentation/powerpc/booting-without-of.txt
> > ===================================================================
> > --- working-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-08-28 13:25:42.000000000 +1000
> > +++ working-2.6/Documentation/powerpc/booting-without-of.txt	2007-08-28 13:38:10.000000000 +1000
> > @@ -1757,45 +1757,46 @@ platforms are moved over to use the flat
> >  		};
> >  	};
> > 
> > -    j) Flash chip nodes
> > +   j) CFI or JEDEC memory-mapped NOR flash
> 
> > -   Example:
> > -
> > - 	flash@ff000000 {
> > - 		device_type = "rom";
> > - 		compatible = "direct-mapped";
> > - 		probe-type = "CFI";
> > - 		reg = <ff000000 01000000>;
> > - 		bank-width = <4>;
> > - 		partitions = <00000000 00f80000
> > - 			      00f80000 00080001>;
> > - 		partition-names = "fs\0firmware";
> > - 	};
> 
> Instead of removing it completely, could you fix the example to match
> the new binding?

Oops, meant to do that.  Done now.

> > +     - compatible : should contain the specific model of flash chip(s)
> > +       used, if known, followed by either "cfi-flash" or "jedec-flash"
> > +     - reg : Address range of the flash chip
> > +     - bank-width : Width (in bytes) of the flash bank.  Equal to the
> > +       device width times the number of interleaved chips.
> > +     - device-width : (optional) Width of a single flash chip.  If
> > +       omitted, assumed to be equal to 'bank-width'.
> 
> > +     - #address-cells, #size-cells : Must be present if the flash has
> > +       sub-nodes representing partitions (see below).  In this case
> > +       both #address-cells and #size-cells must be equal to 1.
> 
> Why is that?  Are we explicitly not caring about chips that are > 4
> GiB?  I think MTD has a limitation here anyway, but it seems a bit
> short-sighted to explicitly limit what #address-cells can be.

>4GiB of NOR flash would be rather unusual (and pricey).  I think it's
simplest to leave this in the binding for now - it's a restriction
which can easily be removed later without breaking backwards
compatibility.

> > +
> > +    For JEDEC compatible devices, the following additional properties
> > +    are defined:
> > +
> > +     - vendor-id : Contains the flash chip's vendor id (1 byte).
> > +     - device-id : Contains the flash chip's device id (1 byte).
> > +
> > +    In addition to the information on the flash bank itself, the
> > +    device tree may optionally contain additional information
> > +    describing partitions of the flash address space.  This can be
> > +    used on platforms which have strong conventions about which
> > +    portions of the flash are used for what purposes, but which don't
> > +    use an on-flash partition table such as RedBoot.
> > +
> > +    Each partitions is represented as a sub-node of the flash device.
> 
> <nit> "Each partition.." </nit>

Oops, fixed.

> > Index: working-2.6/drivers/mtd/maps/physmap_of.c
> > ===================================================================
> > --- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-08-28 13:25:42.000000000 +1000
> > +++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-08-28 13:26:43.000000000 +1000
> > @@ -4,6 +4,9 @@
> >   * Copyright (C) 2006 MontaVista Software Inc.
> >   * Author: Vitaly Wool <vwool@ru.mvista.com>
> >   *
> > + * Revised to handle newer style flash binding by:
> > + *   Copyright (C) 2007 David Gibson, IBM Corporation.
> > + *
> >   * This program is free software; you can redistribute  it and/or modify it
> >   * under  the terms of  the GNU General  Public License as published by the
> >   * Free Software Foundation;  either version 2 of the  License, or (at your
> > @@ -30,56 +33,129 @@ struct physmap_flash_info {
> >  	struct map_info		map;
> >  	struct resource		*res;
> >  #ifdef CONFIG_MTD_PARTITIONS
> > -	int			nr_parts;
> >  	struct mtd_partition	*parts;
> >  #endif
> >  };
> > 
> > -static const char *rom_probe_types[] = { "cfi_probe", "jedec_probe", "map_rom", NULL };
> > -#ifdef CONFIG_MTD_PARTITIONS
> > -static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
> > -#endif
> > -
> >  #ifdef CONFIG_MTD_PARTITIONS
> > -static int parse_flash_partitions(struct device_node *node,
> > -		struct mtd_partition **parts)
> > +static int parse_obsolete_partitions(struct physmap_flash_info *info,
> > +				     struct device_node *dp)
> >  {
> 
> If this is going to be obsoleted, can we put a printk in here whining
> about the fact that the device tree still uses it if parititions are
> found?

Good idea.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
