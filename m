Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGwkZ33z7zDqm7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 21:19:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 23/24] powerpc/mm: Cleanup check for stack expansion
In-Reply-To: <20170724193402.Horde.6aHXbQVl2cfpW3l9leYB8Q2@messagerie.c-s.fr>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-23-benh@kernel.crashing.org>
 <20170721185947.Horde.e8_0DAuKLUb1znI0Zfx-aQ2@messagerie.c-s.fr>
 <87pocqjemx.fsf@concordia.ellerman.id.au>
 <20170724193402.Horde.6aHXbQVl2cfpW3l9leYB8Q2@messagerie.c-s.fr>
Date: Tue, 25 Jul 2017 21:19:47 +1000
Message-ID: <87379k7oh8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LEROY Christophe <christophe.leroy@c-s.fr> writes:

> Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:
>
>> LEROY Christophe <christophe.leroy@c-s.fr> writes:
>>
>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> a =C3=A9crit=C2=A0:
>>>
>>>> When hitting below a VM_GROWSDOWN vma (typically growing the stack),
>>>> we check whether it's a valid stack-growing instruction and we
>>>> check the distance to GPR1. This is largely open coded with lots
>>>> of comments, so move it out to a helper.
>>>
>>> Did you have a look at the following patch ? It's been waiting for
>>> application for some weeks now.
>>> https://patchwork.ozlabs.org/patch/771869
>>
>> I actually merged it last merge window, but found I had no good way to
>> test it, so I took it out again until I can write a test case for it.
>>
>> The way I realised it wasn't being tested was by removing all the
>> store_updates_sp logic entirely and having my system run happily for
>> several days :}
>
> Which demonstrates how unlikely this is, hence doing that get_user()=20=20
> at every fault is waste of time.

Yes I agree.

> How do you plan to handle that in parralele to ben's serie ?

Not sure :)

> I'll be back from vacation next week and may help finding a way to=20=20
> test that. (A test program using alloca() ?)

I was thinking hand-crafted asm, but that might be a pain to get working
for 32 & 64-bit, in which case alloca() might work.

cheers
