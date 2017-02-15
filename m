Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNLD91bcKzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 11:45:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] powerpc/mm/autonuma: Switch ppc64 to its own
 implementeation of saved write
In-Reply-To: <87d1elufej.fsf@skywalker.in.ibm.com>
References: <1487050314-3892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487050314-3892-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87y3x9kp8e.fsf@concordia.ellerman.id.au>
 <87d1elufej.fsf@skywalker.in.ibm.com>
Date: Wed, 15 Feb 2017 11:45:12 +1100
Message-ID: <87efz0l1t3.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> index 0735d5a8049f..8720a406bbbe 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> @@ -16,6 +16,9 @@
>>>  #include <asm/page.h>
>>>  #include <asm/bug.h>
>>>  
>>> +#ifndef __ASSEMBLY__
>>> +#include <linux/mmdebug.h>
>>> +#endif
>>
>> I assume that's for the VM_BUG_ON() you add below. But if so wouldn't
>> the #include be better placed in book3s/64/pgtable.h also?
>
> mmu-hash.h has got a hack that is explained below
>
> #ifndef __ASSEMBLY__
> #include <linux/mmdebug.h>
> #endif
> /*
>  * This is necessary to get the definition of PGTABLE_RANGE which we
>  * need for various slices related matters. Note that this isn't the
>  * complete pgtable.h but only a portion of it.
>  */
> #include <asm/book3s/64/pgtable.h>
>
> This is the only place where we do that book3s/64/pgtable.h include this
> way. Everybody should include asm/pgable.h which picks the righ version
> based on different config option.

I don't understand how that is related.

If you're adding a VM_BUG_ON() in book3s/64/pgtable.h, why isn't the
include of mmdebug.h in that file also?

cheers
