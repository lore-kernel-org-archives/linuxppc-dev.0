Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 239B0DDF57
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 13:28:57 +1000 (EST)
Message-ID: <48645E6A.6020202@firmworks.com>
Date: Thu, 26 Jun 2008 17:28:42 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, david@gibson.dropbear.id.au
Subject: Re: [PATCH] Support NAND partitions >4GiB with Open Firmware
References: <48642B50.9060607@firmworks.com>
	<20080627032046.GH17621@yookeroo.seuss>
In-Reply-To: <20080627032046.GH17621@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



David Gibson wrote:
> On Thu, Jun 26, 2008 at 01:50:40PM -1000, Mitch Bradley wrote:
>   
>> This patch modifes ofpart.c so the total size of NAND FLASH
>> and the size of an individual partition can exceed 4GiB.  It does so
>> by decoding the "reg" property based on the values of "#address-cells"
>> and "#size-cells" in the parent node, thus allowing the base address
>> and size to be 64-bit numbers if necessary.  It handles any combination
>> of #address-cells = 1 or 2 and #size-cells = 1 or 2, handles the case
>> where the parent node doesn't have #address-cells / #size-cells properties,
>> and handles the case where the value of #address-cells is incorrectly
>> inherited from farther up the tree than the direct parent.
>>
>> This patch does not solve the problem that the MTD subsystem
>> itself is limited to 2 GiB NAND sizes, but it is a step in that direction.
>> The final assignment of the 64-bit partition offset and size values is
>> truncated (by the C type conversion rules) to the actual size of the
>> struct mtd_partition offset and size fields (which are currently u_int32's).
>> At some point in the future, when those fields become larger, the code
>> should "just work".
>>
>> The patch should apply to either 2.6.25 or 2.6.26rc.  It has been tested
>> on the OLPC variant of 2.6.25 , with additional patches to other
>> OLPC-specific files that aren't necessary for other architectures
>> that have more mature support for Open Firmware.  The OLPC
>> patch set, plus a set of test cases that verify correct operation for
>> various #address-cells / #size-cells combinations, can be found at
>> http://dev.laptop.org/~wmb/ofpart-olpc.tgz
>>     
>
> I like the idea - but there are some uglies in the implementation.
>
>   
>> Signed-off-by: Mitch Bradley <wmb@firmworks.com>
>>
>> diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
>> index f86e069..b83b26c 100644
>> --- a/drivers/mtd/ofpart.c
>> +++ b/drivers/mtd/ofpart.c
>> @@ -7,6 +7,10 @@
>>  * Revised to handle newer style flash binding by:
>>  *   Copyright (C) 2007 David Gibson, IBM Corporation.
>>  *
>> + * Revised to handle multi-cell addresses and size in reg properties,
>> + * paving the way for NAND FLASH devices > 4GiB by:
>> + *   Mitch Bradley <wmb@laptop.org>
>> + *
>>  * This program is free software; you can redistribute  it and/or modify it
>>  * under  the terms of  the GNU General  Public License as published by the
>>  * Free Software Foundation;  either version 2 of the  License, or (at your
>> @@ -15,0 +19,0 @@
>>
>> #include <linux/module.h>
>> #include <linux/init.h>
>> +#include <linux/device.h>
>> #include <linux/of.h>
>> #include <linux/mtd/mtd.h>
>> #include <linux/mtd/partitions.h>
>>
>> +u_int32_t decode_cell(const u_int8_t *prop)
>> +{
>> +       return ((prop[0] << 24) + (prop[1] << 16) + (prop[2] << 8) +  
>> prop[3]);
>> +}
>>     
>
> You don't appear to actually use this new function.
>   

It's already gone in the new version (the announcement of which may have 
been delayed by the mailing list of which I'm not a subscriber).
>   
>> int __devinit of_mtd_parse_partitions(struct device *dev,
>>                                       struct mtd_info *mtd,
>>                                       struct device_node *node,
>> @@ -44,5 +54,7 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
>>        pp = NULL;
>>        i = 0;
>>        while ((pp = of_get_next_child(node, pp))) {
>> -               const u32 *reg;
>> +               u_int64_t xoffset, xsize;
>>     
>
> The names u64 and u32 are preferred for kernel internal things.
> Certainly not u_int64_t which isn't even the C99 standard name.
>   

Already fixed.

>   
>> +               const u_int32_t *propval;
>> +               u_int32_t addrcells = 0, sizecells = 0;
>>                int len;
>>
>> -               reg = of_get_property(pp, "reg", &len);
>> -               if (!reg || (len != 2 * sizeof(u32))) {
>> +               /*
>> +                * Determine the layout of a "reg" entry based on the parent
>> +                * node's properties, if it hasn't been done already.
>> +                */
>> +
>> +               if (addrcells == 0)
>>     
>
> Redundant 'if'; you've just initialized this variable to zero.
>   

The intention is that the body of the "if" should only be executed
once during the loop, since the parent node is the same for all children.

>   
>> +                       addrcells = of_n_addr_cells(pp);
>> +               if (sizecells == 0)
>> +                       sizecells = of_n_size_cells(pp);
>> +
>> +               propval = of_get_property(pp, "reg", &len);
>> +
>> +               /*
>> +                * Handle the possibility of a broken device tree that
>> +                * doesn't define #address-cells and #size-cells properly.
>> +                 * In a standard device tree, if the address portion of
>> +                 * "reg" is one cell, the direct parent should have a
>> +                 * #address-cells property with value 1.
>> +                */
>> +               if (propval && (len == 2 * sizeof(u32)))
>> +                       addrcells = sizecells = 1;
>> +
>> +               /* Error checks */
>> +
>> +               if (addrcells < 1 || addrcells > 2) {
>> +                       of_node_put(pp);
>> +                       dev_err(dev, "Invalid #address_cells %d on %s\n",
>> +                               addrcells, node->full_name);
>> +                       kfree(*pparts);
>> +                       *pparts = NULL;
>> +                       return -EINVAL;
>> +               }
>> +
>> +               if (sizecells < 1 || sizecells > 2) {
>> +                       of_node_put(pp);
>> +                       dev_err(dev, "Invalid #size-cells %d on %s\n",
>> +                               sizecells, node->full_name);
>> +                       kfree(*pparts);
>> +                       *pparts = NULL;
>> +                       return -EINVAL;
>> +               }
>> +
>> +               if (!propval || (len != (addrcells+sizecells) *  
>> sizeof(u32))) {
>>                        of_node_put(pp);
>>                        dev_err(dev, "Invalid 'reg' on %s\n",  
>> node->full_name);
>>                        kfree(*pparts);
>>                        *pparts = NULL;
>>                        return -EINVAL;
>>                }
>> -               (*pparts)[i].offset = reg[0];
>> -               (*pparts)[i].size = reg[1];
>> +
>> +               /* Accumulate the base address and size into 64-bit  
>> numbers */
>> +               xoffset = (u_int64_t)ntohl(propval[0]);
>>     
>
> You shouldn't use the ntohl() names outside of networking code.
> Instead use be32_to_cpu() and the like.
>   

That whole code block has been replaced by a call to of_read_number()

>   
>> +               if (addrcells > 1) {
>> +                       xoffset <<= 32;
>> +                       xoffset += ntohl(propval[1]);
>> +               }
>> +               xsize = (u_int64_t)ntohl(propval[addrcells]);
>> +               if (sizecells > 1) {
>> +                       xsize <<= 32;
>> +                       xsize += ntohl(propval[addrcells+1]);
>> +               }
>> +
>> +               (*pparts)[i].offset = xoffset;
>> +               (*pparts)[i].size = xsize;
>>
>>                partname = of_get_property(pp, "label", &len);
>>                if (!partname)
>>     
>
>   
