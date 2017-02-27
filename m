Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWz7r5mrwzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:52:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH v3] powerpc/powernv: add hdat attribute to sysfs
In-Reply-To: <ec7f0ed8-58b5-cdfb-63a9-d91a7cb8022e@au1.ibm.com>
References: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
 <ec7f0ed8-58b5-cdfb-63a9-d91a7cb8022e@au1.ibm.com>
Date: Mon, 27 Feb 2017 21:52:55 +1100
Message-ID: <87o9xnrjlk.fsf@concordia.ellerman.id.au>
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

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> On 24/02/17 17:20, Matt Brown wrote:
>> The HDAT data area is consumed by skiboot and turned into a device-tree.
>> In some cases we would like to look directly at the HDAT, so this patch
>> adds a sysfs node to allow it to be viewed.  This is not possible through
>> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
>>
>> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
>
> Changes look good, thanks for addressing the comments! Still a couple of 
> minor points below, otherwise:
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> Stewart: this might need your ACK?

I don't see it in skiboot yet ?

>> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
>> index b5d98cb..9a0c9d6 100644
>> --- a/arch/powerpc/platforms/powernv/Makefile
>> +++ b/arch/powerpc/platforms/powernv/Makefile
>> @@ -3,6 +3,7 @@ obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>>  obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
>>  obj-y			+= opal-kmsg.o
>> +obj-y			+= opal-hdat.o
>
> Normally we keep putting new object files on the same line until it gets 
> long enough that we have to break it. This is very minor though :)

Yeah, please put it on the same line as opal-kmsg.o

>> diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c b/arch/powerpc/platforms/powernv/opal-hdat.c
>> new file mode 100644
>> index 0000000..3315dd3
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/powernv/opal-hdat.c
>> @@ -0,0 +1,65 @@
>> +/*
>> + * PowerNV OPAL HDAT interface
>> + *
>> + * Author: Matt Brown <matthew.brown.dev@gmail.com>
>> + *
>> + * Copyright 2017 IBM Corp.

I dislike email addresses in source files, they just end up being wrong
and needing to be updated. We have your email in the commit log anyway.

So I prefer:

 * Copyright 2017, Matt Brown, IBM Corp.

Which I believe is also blessed by the lawyers.

>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#include <asm/io.h>
>> +#include <asm/opal.h>
>> +#include <linux/of.h>
>> +#include <linux/types.h>

Preferred style is to put the linux includes first, before the asm ones.

>> +struct hdat_info {
>> +	char *base;
>> +	u64 size;
>> +};
>> +
>> +static struct hdat_info hdat_inf;
>
> As Oliver pointed out, we could do with a better name than hdat_inf - 
> it's only one character away from the name of the struct type. Hmm, 
> perhaps "hdat_location", or maybe Oliver has a better suggestion.

Why not hdat_info ?

In fact for bonus points, you can just do:

static struct {
	char *base;
	u64 size;
} hdat_info;

cheers
