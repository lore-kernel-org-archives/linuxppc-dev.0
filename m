Return-Path: <nfont@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FC6DB7B71
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 00:45:34 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8HEhU0p003636
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 10:43:30 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8HEjS0S684182
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 10:45:28 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8HEjSqs032599
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 08:45:28 -0600
Message-ID: <4AB24B84.8030503@austin.ibm.com>
Date: Thu, 17 Sep 2009 09:45:24 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/5] dynamic logical partitioning infrastructure
References: <4AAABC55.4070207@austin.ibm.com>	
	<4AAABCE3.5090702@austin.ibm.com>
	<1253064816.5600.103.camel@concordia>
In-Reply-To: <1253064816.5600.103.camel@concordia>
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
> On Fri, 2009-09-11 at 16:10 -0500, Nathan Fontenot wrote:
>> This patch provides the kernel DLPAR infrastructure in a new filed named
>> dlpar.c.  The functionality provided is for acquiring and releasing a 
>> resource from firmware and the parsing of information returned from the
>> ibm,configure-connector rtas call.  Additionally this exports the 
>> pSeries reconfiguration notifier chain so that it can be invoked when
>> device tree updates are made.
>>
>> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
>> ---
>>
>> Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
>> ===================================================================
>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-09-11 12:51:52.000000000 -0500
>> @@ -0,0 +1,416 @@
>> +/*
>> + * dlpar.c - support for dynamic reconfiguration (including PCI
>> + * Hotplug and Dynamic Logical Partitioning on RPA platforms).
>> + *
>> + * Copyright (C) 2009 Nathan Fontenot
>> + * Copyright (C) 2009 IBM Corporation
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License version
>> + * 2 as published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/kref.h>
>> +#include <linux/notifier.h>
>> +#include <linux/proc_fs.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include <asm/prom.h>
>> +#include <asm/machdep.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/rtas.h>
>> +#include <asm/pSeries_reconfig.h>
>> +
>> +#define CFG_CONN_WORK_SIZE	4096
>> +static char workarea[CFG_CONN_WORK_SIZE];
>> +spinlock_t workarea_lock;
>> +
>> +static struct property *parse_cc_property(char *workarea)
>> +{
>> +	struct property *prop;
>> +	u32 *work_ints;
>> +	char *name;
>> +	char *value;
>> +
>> +	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
>> +	if (!prop)
>> +		return NULL;
>> +
>> +	work_ints = (u32 *)workarea;
>> +	name = workarea + work_ints[2];
>> +	prop->name = kzalloc(strlen(name) + 1, GFP_KERNEL);
>> +	if (!prop->name) {
>> +		kfree(prop);
>> +		return NULL;
>> +	}
>> +
>> +	strcpy(prop->name, name);
>> +
>> +	prop->length = work_ints[3];
>> +	value = workarea + work_ints[4];
>> +	prop->value = kzalloc(prop->length, GFP_KERNEL);
> 
> 
> The use of work_ints is a bit opaque, it might be clearer if you define
> a struct, something like:
> 
> struct cc_prop {
> 	u32 ?;
> 	u32 ?;
> 	u32 name_offset;
> 	u32 length;
> 	u32 value_offset;
> };
> 
> cc = (struct cc_prop *)workarea;
> 
> name = workarea + cc->name_offset;
> ..
> prop->length = cc->length;
> value = workarea + cc->value_offset;
> 

Good idea, and I agree that the use of the workarea/work_ints is a bit vague.
The current way works because sometimes its easier to think of the workarea
as a char buffer and sometimes as a int buffer.

I'll try to come up with something to make the parsing of the workarea buffer
easier to understand.

-Nathan Fontenot
 
> etc.
> 
> 
> Also I don't see any checking of the offsets into workarea (for name &
> value), vs the size of workarea.
> 
> cheers
> 
