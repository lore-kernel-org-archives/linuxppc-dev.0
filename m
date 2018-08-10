Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mnz434B3zDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 11:46:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v02] powerpc/mobility: Fix node detach/rename problem
In-Reply-To: <19f9e274-26ae-2ae5-de9f-c0fcd6c00570@linux.vnet.ibm.com>
References: <b3f658d9-efc5-e532-e8d4-162494b88194@linux.vnet.ibm.com>
 <87zhxx9cs7.fsf@concordia.ellerman.id.au>
 <19f9e274-26ae-2ae5-de9f-c0fcd6c00570@linux.vnet.ibm.com>
Date: Fri, 10 Aug 2018 11:46:23 +1000
Message-ID: <87zhxv8040.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> On 08/08/2018 09:02 AM, Michael Ellerman wrote:
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>>> index e245a88..efc9442 100644
>>> --- a/arch/powerpc/platforms/pseries/mobility.c
>>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>>> @@ -22,6 +22,9 @@
>>>  #include <asm/rtas.h>
>>>  #include "pseries.h"
>>>  
>>> +extern int of_free_phandle_cache(void);
>>> +extern void of_populate_phandle_cache(void);
>> 
>> We don't do that, they should be in a header.
>> 
>> But that's a minor problem given that the patch doesn't compile, because
>> both those functions are static.
>
> I am building against the latest 'linux-ppc' kernel.  It includes patch

OK you must be using the master branch.

> Commit b9952b5218added5577e4a3443969bc20884cea9 Mon Sep 17 00:00:00 2001
> From: Frank Rowand <frank.rowand@sony.com>
> Date: Thu, 12 Jul 2018 14:00:07 -0700
> Subject: of: overlay: update phandle cache on overlay apply and remove

That only landed in v4.18-rc6, so it's not in my next branch which is
where patches like this targeted for the next release are applied.

> which makes the functions static.  I will rebuild and test with an
> earlier version if you will specify which one.

No that's fine it will just have to wait until next and master are
merged before it can go in.

cheers
