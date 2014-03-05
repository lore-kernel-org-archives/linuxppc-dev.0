Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96CC32C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 12:55:31 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 11:55:28 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4C33F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 12:55:25 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s251ZWf17143776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 12:35:32 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s251tOwX011840
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 12:55:24 +1100
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/powernv Platform dump interface
In-Reply-To: <5315C592.4050605@linux.vnet.ibm.com>
References: <1393393321-9902-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1393802742-3891-1-git-send-email-stewart@linux.vnet.ibm.com>
 <5315C592.4050605@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 12:55:20 +1100
Message-ID: <87y50pjto7.fsf@river.au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
>> index 0000000..32fe7f5
>> --- /dev/null
>> +++ b/Documentation/ABI/stable/sysfs-firmware-opal-dump
>> @@ -0,0 +1,41 @@
>> +What:		/sys/firmware/opal/dump
>> +Date:		Feb 2014
>> +Contact:	Stewart Smith <stewart@linux.vnet.ibm.com>
>> +Description:
>> +		This directory exposes interfaces for interacting with
>> +		the FSP and platform dumps through OPAL firmware interface.
>> +
>> +		This is only for the powerpc/powernv platform.
>> +
>> +		initiate_dump:	When '1' is written to it,
>> +				we will initiate a dump.
>
> initiate FSP dump

ack. I can send subsequent patch that fixes up these bits.

>> --- /dev/null
>> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
>> @@ -0,0 +1,525 @@
>> +/*
>> + * PowerNV OPAL Dump Interface
>> + *
>> + * Copyright 2013,2014 IBM Corp.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#include <linux/kobject.h>
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/pagemap.h>
>> +#include <linux/delay.h>
>> +
>> +#include <asm/opal.h>
>> +
>> +#define DUMP_TYPE_FSP	0x01
>
> Better define other dump type (sysdump etc) here and use it below ?

Likely yes, Is there a definitive list somewhere?

>> +static ssize_t init_dump_store(struct dump_obj *dump_obj,
>> +			       struct dump_attribute *attr,
>> +			       const char *buf,
>> +			       size_t count)
>> +{
>> +	dump_fips_init(DUMP_TYPE_FSP);
>> +	pr_info("%s: Initiated FSP dump\n", __func__);
>
> This might mislead if OPAL fails to initiate FSP dump.. Better move this to 
> dump_fips_init () ?

good point. I don't think we actually process the response of FSP dump
init, which IIRC may actually be able to tell us if it failed to
initiate a dump.
