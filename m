Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHvTw65jzzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 20:27:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] powerpc/64s: Leave IRQs hard enabled over context
 switch
In-Reply-To: <1493800107.25766.352.camel@kernel.crashing.org>
References: <20170503073414.18776-1-npiggin@gmail.com>
 <1493800107.25766.352.camel@kernel.crashing.org>
Date: Wed, 03 May 2017 20:26:59 +1000
Message-ID: <87k25yutfw.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2017-05-03 at 17:34 +1000, Nicholas Piggin wrote:
>> Extending the soft IRQ disable to cover PMU interrupts will allow this
>> hard disable to be removed from hash based kernels too, but they will
>> still have to soft-disable PMU interrupts.
>>=20
>> - Q1: Can we do this? It gives nice profiles of context switch code
>> =C2=A0 rather than assigning it all to local_irq_enable.
>
> Probably ok with radix yes.
>
>> - Q2: What is the unrecoverable SLB miss on exception entry? Is there
>> =C2=A0 anywhere we access the kernel stack with RI disabled? Something e=
lse?
>
> Not sure what you mean by Q2, but the original problem is an occurrence
> of what we call the 'megabug' which hit us in different forms over the
> years, and happens when we get a kernel stack SLB entry wrong.
>
> Normally, the segment containing the current kernel stack is always
> bolted in the SLB in a specific slot. If we accidentally lose that
> "bolt", we can end up faulting it into the wrong slot, thus making it
> possible for it to get evicted later on etc...
>
> That in turns hits the exception return path which accesses the kernel
> stack after clearing RI and setting SRR0/1 to the return values.

Couldn't we avoid the whole problem by just having two bolted slots for
the stack, meaning we could have the current and next stack bolted at
all times.

That would mean we'd be using 4 slots for bolted entries, which is one
more than 3 - but it might be a good trade off.

Or we could make the SLB insertion algorithm smarter so that we could
later free the slot that was used for previous kernel stack.

cheers
