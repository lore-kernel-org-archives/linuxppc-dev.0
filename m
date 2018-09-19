Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FxXn08F4zDrcY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 09:54:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>,
 segher@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] sched: move stack_canary field at the top of
 task_struct
In-Reply-To: <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
 <20180919115836.GE24124@hirez.programming.kicks-ass.net>
 <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
Date: Thu, 20 Sep 2018 09:54:16 +1000
Message-ID: <875zz1avrr.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 19/09/2018 =C3=A0 13:58, Peter Zijlstra a =C3=A9crit=C2=A0:
>> On Wed, Sep 19, 2018 at 11:14:43AM +0000, Christophe Leroy wrote:
>>> In order to allow the use of non global stack protector canary,
>>> the stack canary needs to be located at a know offset defined
>>> in Makefile via -mstack-protector-guard-offset.
>>>
>>> On powerpc/32, register r2 points to current task_struct at
>>> all time, the stack_canary located inside task_struct can be
>>> used directly if it is located in a known place.
>>>
>>> In order to allow that, this patch moves the stack_canary field
>>> out of the randomized area of task_struct.
>>=20
>> And you cannot use something like asm-offsets to extract this?
>
> I have not been able to find a way to define the compilation flags AFTER=
=20
> building asm-offsets.h, see https://patchwork.ozlabs.org/patch/971521/
>
> If you have a suggestion, it is welcomed.

Hmm, that's something of a hard problem.

But the stack canary is one of the things we really *do* want to be
randomised, so we should probably try to come up with a solution.

cheers
