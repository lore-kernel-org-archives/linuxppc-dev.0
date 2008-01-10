Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 17762DE005
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:17:27 +1100 (EST)
Message-ID: <47858E46.9010505@pikatech.com>
Date: Wed, 09 Jan 2008 22:17:26 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/5] Warp Base Platform
References: <47852C41.8000506@pikatech.com> <47852D16.2070906@pikatech.com>
	<20080110024926.GD17816@localhost.localdomain>
In-Reply-To: <20080110024926.GD17816@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Jan 09, 2008 at 03:22:46PM -0500, Sean MacLennan wrote:
>   
>> Basically the powerpc/boot directory files.
>>     
>
> [snip]
>   
>> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
>> +++ arch/powerpc/boot/cuboot-warp.c	2008-01-08 12:09:39.000000000 -0500
>> @@ -0,0 +1,25 @@
>> +/*
>> + * Copyright (c) 2008 PIKA Technologies
>> + *   Sean MacLennan <smaclennan@pikatech.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation.
>> + */
>> +
>> +#include "ops.h"
>> +#include "44x.h"
>> +#include "cuboot.h"
>> +
>> +#define TARGET_44x
>> +#include "ppcboot.h"
>> +
>> +static bd_t bd;
>> +
>> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>> +				   unsigned long r6, unsigned long r7)
>> +{
>> +	CUBOOT_INIT();
>> +
>> +	warp_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
>> +}
>> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
>> +++ arch/powerpc/boot/warp.c	2008-01-08 12:09:54.000000000 -0500
>>     
>
> Fold all this into cuboot-warp.c, unless you actually anticipate
> adding another wrapper for another firmware which will also use the
> functions in warp.c.
>
>   
Yes, there is still a plan to use the u-boot device tree. Although not 
in the near feature. I could roll them togeather for now and split them 
out later.

Cheers,
    Sean
