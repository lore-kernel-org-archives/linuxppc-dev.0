Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66E562C0212
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 14:25:40 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 08:55:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C8947E0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 08:59:15 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s253PV1057540652
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 08:55:31 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s253PZTa003960
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 08:55:35 +0530
Message-ID: <5316992D.3090300@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 08:55:33 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/powernv Platform dump interface
References: <1393393321-9902-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1393802742-3891-1-git-send-email-stewart@linux.vnet.ibm.com>
 <5315C592.4050605@linux.vnet.ibm.com> <87y50pjto7.fsf@river.au.ibm.com>
In-Reply-To: <87y50pjto7.fsf@river.au.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05/2014 07:25 AM, Stewart Smith wrote:
> Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
>>> index 0000000..32fe7f5
>>> --- /dev/null
>>> +++ b/Documentation/ABI/stable/sysfs-firmware-opal-dump
>>> @@ -0,0 +1,41 @@
>>> +What:		/sys/firmware/opal/dump
>>> +Date:		Feb 2014
>>> +Contact:	Stewart Smith <stewart@linux.vnet.ibm.com>
>>> +Description:
>>> +		This directory exposes interfaces for interacting with
>>> +		the FSP and platform dumps through OPAL firmware interface.
>>> +
>>> +		This is only for the powerpc/powernv platform.
>>> +
>>> +		initiate_dump:	When '1' is written to it,
>>> +				we will initiate a dump.
>>
>> initiate FSP dump
>
> ack. I can send subsequent patch that fixes up these bits.
>
>>> --- /dev/null
>>> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
>>> @@ -0,0 +1,525 @@
>>> +/*
>>> + * PowerNV OPAL Dump Interface
>>> + *
>>> + * Copyright 2013,2014 IBM Corp.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * as published by the Free Software Foundation; either version
>>> + * 2 of the License, or (at your option) any later version.
>>> + */
>>> +
>>> +#include <linux/kobject.h>
>>> +#include <linux/mm.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/vmalloc.h>
>>> +#include <linux/pagemap.h>
>>> +#include <linux/delay.h>
>>> +
>>> +#include <asm/opal.h>
>>> +
>>> +#define DUMP_TYPE_FSP	0x01
>>
>> Better define other dump type (sysdump etc) here and use it below ?
>
> Likely yes, Is there a definitive list somewhere?

List is depending on what OPAL gives to Linux...For now

#define DUMP_TYPE_FSP	0x01
#define DUMP_TYPE_SYS   0x02
#define DUMP_TYPE_SMA   0x03


>
>>> +static ssize_t init_dump_store(struct dump_obj *dump_obj,
>>> +			       struct dump_attribute *attr,
>>> +			       const char *buf,
>>> +			       size_t count)
>>> +{
>>> +	dump_fips_init(DUMP_TYPE_FSP);
>>> +	pr_info("%s: Initiated FSP dump\n", __func__);
>>
>> This might mislead if OPAL fails to initiate FSP dump.. Better move this to
>> dump_fips_init () ?
>
> good point. I don't think we actually process the response of FSP dump
> init, which IIRC may actually be able to tell us if it failed to
> initiate a dump.
>

Yes..

-Vasant
