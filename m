Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGT5345mvzDrFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 03:34:15 +1000 (AEST)
Date: Mon, 24 Jul 2017 19:34:02 +0200
Message-ID: <20170724193402.Horde.6aHXbQVl2cfpW3l9leYB8Q2@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 23/24] powerpc/mm: Cleanup check for stack expansion
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-23-benh@kernel.crashing.org>
 <20170721185947.Horde.e8_0DAuKLUb1znI0Zfx-aQ2@messagerie.c-s.fr>
 <87pocqjemx.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pocqjemx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:

> LEROY Christophe <christophe.leroy@c-s.fr> writes:
>
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> a =C3=A9crit=C2=A0:
>>
>>> When hitting below a VM_GROWSDOWN vma (typically growing the stack),
>>> we check whether it's a valid stack-growing instruction and we
>>> check the distance to GPR1. This is largely open coded with lots
>>> of comments, so move it out to a helper.
>>
>> Did you have a look at the following patch ? It's been waiting for
>> application for some weeks now.
>> https://patchwork.ozlabs.org/patch/771869
>
> I actually merged it last merge window, but found I had no good way to
> test it, so I took it out again until I can write a test case for it.
>
> The way I realised it wasn't being tested was by removing all the
> store_updates_sp logic entirely and having my system run happily for
> several days :}

Which demonstrates how unlikely this is, hence doing that get_user()=20=20
at=20every fault is waste of time.

How do you plan to handle that in parralele to ben's serie ?

I'll be back from vacation next week and may help finding a way to=20=20
test=20that. (A test program using alloca() ?)

Christophe

>
> cheers
