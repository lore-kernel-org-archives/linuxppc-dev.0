Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv6NX2LjPzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 15:25:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V3] cxl: Export library to support IBM XSL
In-Reply-To: <0ae158b6-3e80-0730-83ae-15bccf40d113@linux.vnet.ibm.com>
References: <1498039393-10656-1-git-send-email-clombard@linux.vnet.ibm.com>
 <0ae158b6-3e80-0730-83ae-15bccf40d113@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2017 15:25:29 +1000
Message-ID: <877f03qnqu.fsf@concordia.ellerman.id.au>
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

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>> diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
>> new file mode 100644
>> index 0000000..4f4c5ca
>> --- /dev/null
>> +++ b/drivers/misc/cxl/cxllib.c
>> @@ -0,0 +1,246 @@
>> +/*
>> + * Copyright 2017 IBM Corp.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#include <asm/pnv-pci.h>
>> +#include <linux/hugetlb.h>
>> +#include <linux/sched/mm.h>
>> +#include <misc/cxllib.h>
>
> Maybe somebody can comment on this, but I believe the usual order is the 
> 'linux' headers first, then the 'asm'. Though I don't know if there's a 
> valid reason behind it, or just tradition...

AFAIK it's mainly tradition.

In general if there's a linux/foo.h and an asm/foo.h you're usually
supposed to include the linux version, and then that will include
asm/foo.h appropriately.

In some cases you might have an asm header that relies on something
defined in the linux version, meaning including the asm one first
doesn't build.

Outside of arch it's slightly dubious to be including asm/ headers
directly, because you require all arches to have that header.

None of which really answers your question :)

cheers
