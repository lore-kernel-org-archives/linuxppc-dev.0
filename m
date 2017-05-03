Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHrsF0BTYzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 18:28:32 +1000 (AEST)
Message-ID: <1493800107.25766.352.camel@kernel.crashing.org>
Subject: Re: [RFC][PATCH] powerpc/64s: Leave IRQs hard enabled over context
 switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard
 <anton@samba.org>, Paul Mackerras <paulus@ozlabs.org>
Date: Wed, 03 May 2017 10:28:27 +0200
In-Reply-To: <20170503073414.18776-1-npiggin@gmail.com>
References: <20170503073414.18776-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-03 at 17:34 +1000, Nicholas Piggin wrote:
> Extending the soft IRQ disable to cover PMU interrupts will allow this
> hard disable to be removed from hash based kernels too, but they will
> still have to soft-disable PMU interrupts.
> 
> - Q1: Can we do this? It gives nice profiles of context switch code
>   rather than assigning it all to local_irq_enable.

Probably ok with radix yes.

> - Q2: What is the unrecoverable SLB miss on exception entry? Is there
>   anywhere we access the kernel stack with RI disabled? Something else?

Not sure what you mean by Q2, but the original problem is an occurrence
of what we call the 'megabug' which hit us in different forms over the
years, and happens when we get a kernel stack SLB entry wrong.

Normally, the segment containing the current kernel stack is always
bolted in the SLB in a specific slot. If we accidentally lose that
"bolt", we can end up faulting it into the wrong slot, thus making it
possible for it to get evicted later on etc...

That in turns hits the exception return path which accesses the kernel
stack after clearing RI and setting SRR0/1 to the return values.

Cheers,
Ben.
