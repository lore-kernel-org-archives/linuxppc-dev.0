Return-Path: <nfont@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69A20B7B80
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 02:40:33 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9FFbXQm023427
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 11:37:33 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9FFeUfR251104
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 11:40:30 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9FFeTmF007874
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 11:40:29 -0400
Message-ID: <4AD74261.9040504@austin.ibm.com>
Date: Thu, 15 Oct 2009 10:40:17 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 5/5 v2] kernel handling of CPU DLPAR
References: <4AB39FB3.1020608@austin.ibm.com>	
	<4AB3A172.4090601@austin.ibm.com> <4AD4C3A3.5050103@austin.ibm.com>
	<1255473054.21871.39.camel@concordia>
In-Reply-To: <1255473054.21871.39.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2009-10-13 at 13:14 -0500, Nathan Fontenot wrote:
>> This adds the capability to DLPAR add and remove CPUs from the kernel. The
>> creates two new files /sys/devices/system/cpu/probe and
>> /sys/devices/system/cpu/release to handle the DLPAR addition and removal of
>> CPUs respectively.
> 
> How does this relate to the existing cpu hotplug mechanism? Or is this
> making the cpu exist (possible), vs marking it as online?

This update makes the cpu exist, it does not mark the cpu online.

> 
> Is some other platform going to want to do the same? ie. should the
> probe/release part be in generic code?

I thought about making this generic code, perhaps a follow-on patch to move
the creation of the probe/release files to generic code to see what the
community thinks.  I would assume there would still need to be a arch and/or
platforms specific callout to do the real work.

> 
>> Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
>> ===================================================================
>> --- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2009-10-13 13:08:22.000000000 -0500
>> +++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-10-13 13:09:00.000000000 -0500
>> @@ -1,11 +1,11 @@
>>  /*
>> - * dlpar.c - support for dynamic reconfiguration (including PCI
>> - * Hotplug and Dynamic Logical Partitioning on RPA platforms).
>> + * dlpar.c - support for dynamic reconfiguration (including PCI,
> 
> We know it's dlpar.c :)

heh! good point.  Consider it gone.

> 
>> + * Memory, and CPU Hotplug and Dynamic Logical Partitioning on
>> + * PAPR platforms).
>>   *
>>   * Copyright (C) 2009 Nathan Fontenot
>>   * Copyright (C) 2009 IBM Corporation
>>   *
>> - *
>>   * This program is free software; you can redistribute it and/or
>>   * modify it under the terms of the GNU General Public License version
>>   * 2 as published by the Free Software Foundation.
>> @@ -19,6 +19,7 @@
>>  #include <linux/memory_hotplug.h>
>>  #include <linux/sysdev.h>
>>  #include <linux/sysfs.h>
>> +#include <linux/cpu.h>
>>  
>>
>>  #include <asm/prom.h>
>> @@ -408,6 +409,82 @@
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static ssize_t cpu_probe_store(struct class *class, const char *buf,
>> +			       size_t count)
>> +{
>> +	struct device_node *dn;
>> +	unsigned long drc_index;
>> +	char *cpu_name;
>> +	int rc;
>> +
>> +	rc = strict_strtoul(buf, 0, &drc_index);
>> +	if (rc)
>> +		return -EINVAL;
>> +
>> +	rc = acquire_drc(drc_index);
>> +	if (rc)
>> +		return rc;
>> +
>> +	dn = configure_connector(drc_index);
>> +	if (!dn) {
>> +		release_drc(drc_index);
>> +		return rc;
>> +	}
>> +
>> +	/* fixup dn name */
>> +	cpu_name = kzalloc(strlen(dn->full_name) + strlen("/cpus/") + 1,
>> +			   GFP_KERNEL);
>> +	if (!cpu_name) {
>> +		free_cc_nodes(dn);
>> +		release_drc(drc_index);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	sprintf(cpu_name, "/cpus/%s", dn->full_name);
>> +	kfree(dn->full_name);
>> +	dn->full_name = cpu_name;
> 
> What was all that? Firmware gives us a bogus full name? But the parent
> is right?

Yeah, this has always been an oddity to me.  The name that is given to us
from firmware puts the cpu node in the root of the device tree as opposed
to /cpus.  Since cpu nodes are in /cpus, the name is fixed up to reflect this.

This name fixup has always been done by the drmgr userspace command, which is
where this functionality is being imported from.

> 
>> +	rc = add_device_tree_nodes(dn);
>> +	if (rc)
>> +		release_drc(drc_index);
>> +
>> +	return rc ? rc : count;
> 
> You're sure rc is < 0.
> 
Oh, good catch.

>> +}
>> +
>> +static ssize_t cpu_release_store(struct class *class, const char *buf,
>> +				 size_t count)
>> +{
>> +	struct device_node *dn;
>> +	u32 *drc_index;
>> +	int rc;
>> +
>> +	dn = of_find_node_by_path(buf);
>> +	if (!dn)
>> +		return -EINVAL;
>> +
>> +	drc_index = (u32 *)of_get_property(dn, "ibm,my-drc-index", NULL);
> 
> No cast required.

ok.

thanks for the review.

-Nathan

> 
>> +	if (!drc_index) {
>> +		of_node_put(dn);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = release_drc(*drc_index);
>> +	if (rc) {
>> +		of_node_put(dn);
>> +		return rc;
>> +	}
>> +
>> +	rc = remove_device_tree_nodes(dn);
>> +	if (rc)
>> +		acquire_drc(*drc_index);
>> +
>> +	of_node_put(dn);
>> +	return rc ? rc : count;
>> +}
> 
> 
> cheers
