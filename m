Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7xpl1F9MzDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 21:43:59 +1000 (AEST)
Subject: Re: [PATCH] powerpc/32: Move entry_32 functions just after HEAD
 functions.
To: Michael Ellerman <mpe@ellerman.id.au>,
 David Laight <David.Laight@ACULAB.COM>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
References: <20170418070126.A18EF67952@localhost.localdomain>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD56A5@AcuExch.aculab.com>
 <878tmv48yb.fsf@concordia.ellerman.id.au>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d1554d1f-de23-95a5-07ee-4c18f187cdf1@c-s.fr>
Date: Thu, 20 Apr 2017 13:43:54 +0200
MIME-Version: 1.0
In-Reply-To: <878tmv48yb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/04/2017 à 13:25, Michael Ellerman a écrit :
> David Laight <David.Laight@ACULAB.COM> writes:
>
>> From: Christophe Leroy
>>> By default, PPC8xx PINs an ITLB on the first 8M of memory in order
>>> to avoid any ITLB miss on kernel code.
>>> However, with some debug functions like DEBUG_PAGEALLOC and
>>> (soon to come) DEBUG_RODATA, the PINned TLB is invalidated soon
>>> after startup so ITLB missed start to happen also on the kernel code.
>>>
>>> In order to avoid any ITLB miss in a critical section, we have to
>>> ensure that their is no page boundary crossed between the setup of
>>> a new value in SRR0/SRR1 and the associated RFI. This cannot be done
>>> easily if entry_32 functions sits in the middle of other .text
>>> functions. By placing entry_32 just after the .head section (as already
>>> done for entry_64 on PPC64), we can more easily ensure the issue
>>> doesn't happen.
>>
>> Shouldn't this be done by putting all the functions that 'matter'
>> into a named section instead of relying on the order of the input files?
>> (Which is what I think this is doing.)
>
> Yeah that is fragile if there's nothing more to it.
>
> I'm not sure if we need a special section. If the functions that must
> not cross a page boundary are aligned to a page boundary (with .align)
> then that would also work wouldn't it?

Yes it would work, but we would also 'loose' some space (up to one page 
?), as I don't think 'ld' would fill the blanks with other functions.

Maybe we can find a lower alignment than a page boundary, I'll 
investigate that.

Christophe
