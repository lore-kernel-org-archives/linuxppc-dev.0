Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLcrR21ctzDsSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 21:37:43 +1000 (AEST)
Subject: Re: [PATCH 23/24] powerpc/mm: Cleanup check for stack expansion
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-23-benh@kernel.crashing.org>
 <20170721185947.Horde.e8_0DAuKLUb1znI0Zfx-aQ2@messagerie.c-s.fr>
 <87pocqjemx.fsf@concordia.ellerman.id.au>
 <20170724193402.Horde.6aHXbQVl2cfpW3l9leYB8Q2@messagerie.c-s.fr>
 <87379k7oh8.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <05ff40cc-0247-1be9-9b68-f8c6c1e740f7@c-s.fr>
Date: Mon, 31 Jul 2017 13:37:37 +0200
MIME-Version: 1.0
In-Reply-To: <87379k7oh8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/07/2017 à 13:19, Michael Ellerman a écrit :
> LEROY Christophe <christophe.leroy@c-s.fr> writes:
> 
>> Michael Ellerman <mpe@ellerman.id.au> a écrit :
>>
>>> LEROY Christophe <christophe.leroy@c-s.fr> writes:
>>>
>>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> a écrit :
>>>>
>>>>> When hitting below a VM_GROWSDOWN vma (typically growing the stack),
>>>>> we check whether it's a valid stack-growing instruction and we
>>>>> check the distance to GPR1. This is largely open coded with lots
>>>>> of comments, so move it out to a helper.
>>>>
>>>> Did you have a look at the following patch ? It's been waiting for
>>>> application for some weeks now.
>>>> https://patchwork.ozlabs.org/patch/771869
>>>
>>> I actually merged it last merge window, but found I had no good way to
>>> test it, so I took it out again until I can write a test case for it.
>>>
>>> The way I realised it wasn't being tested was by removing all the
>>> store_updates_sp logic entirely and having my system run happily for
>>> several days :}
>>
>> Which demonstrates how unlikely this is, hence doing that get_user()
>> at every fault is waste of time.
> 
> Yes I agree.
> 
>> How do you plan to handle that in parralele to ben's serie ?
> 
> Not sure :)
> 
>> I'll be back from vacation next week and may help finding a way to
>> test that. (A test program using alloca() ?)
> 
> I was thinking hand-crafted asm, but that might be a pain to get working
> for 32 & 64-bit, in which case alloca() might work.

No need of very sofisticated thing indeed.
The following app makes the trick. If I modify store_updates_sp() to 
always return 0, the app gets a SIGSEGV.

#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
	char buf[1024 * 1025];

	sprintf(buf, "Hello world !\n");
	printf(buf);

	exit(0);
}

Christophe

> 
> cheers
> 
