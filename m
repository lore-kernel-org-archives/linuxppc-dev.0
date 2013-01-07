Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 17EE22C0098
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2013 23:39:20 +1100 (EST)
Message-ID: <50EAB99C.6000205@linutronix.de>
Date: Mon, 07 Jan 2013 13:03:40 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] kprobes/powerpc: Do not disable External interrupts
 during single step
References: <20121203150438.7727.74924.stgit@suzukikp>
 <20121203150720.7727.91582.stgit@suzukikp> <50C6C930.90206@in.ibm.com>
 <1357274575.2500.23.camel@pasglop>
In-Reply-To: <1357274575.2500.23.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, oleg@redhat.com, linuxppc-dev@ozlabs.org,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, anton@redhat.com, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/04/2013 05:42 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-12-11 at 11:18 +0530, Suzuki K. Poulose wrote:
>> On 12/03/2012 08:37 PM, Suzuki K. Poulose wrote:
>>> From: Suzuki K. Poulose<suzuki@in.ibm.com>
>>>
>>> External/Decrement exceptions have lower priority than the Debug Exception.
>>> So, we don't have to disable the External interrupts before a single step.
>>> However, on BookE, Critical Input Exception(CE) has higher priority than a
>>> Debug Exception. Hence we mask them.
>
> I'm not sure about that one ...
>
>> From memory, 4xx has that interesting issue which is that if you have
> single step enabled and an interrupt (of *any kind* occurs), the
> processor *will* step into the first instruction of the interrupt
> handler. (In fact, some silicons have a bug where it can even be the
> *second* instruction of the handler, which can be problematic when the
> first one is a branch).
>
> This is why you may notice that whole business we have in the handling
> of debug/crit interrupts where we try to figure out if that happened,
> and return with DE off if it did.
>
> Now, the above mentioned workaround means we might not need to disable
> EE indeed.
>
> However, in any case, I don't see what your patch fixes or improves, nor
> do I understand what you mean by "it is possible we'd get the single
> step reported for CE". Please explain in more details and describe the
> problematic scenario.

This change is probably my fault to some degree so let me explain. I've
been looking over the patch in first place and noticed that Suzuki
disables EE while enabling single stepping. After looking into the
manual I did not find a reason why this is done.

_If_ an external interrupt is pending and we enable EE and DE at the 
same time (via rfi) then we should never land in the external interrupt 
handler but always in the debug exception handler (and EE is disabled on 
all interrupts by the CPU). So why disable EE here?

_If_ the instruction in problem state triggers an DTLB exception then
we land in the TLB exception handler with DE bit set in MSR. I would say 
that this isn't uncommon (same goes probably for the syscall
opcode). After executing the first in instruction in kernel the CPU
should disable the DE (and CE) bit in the MSR and invoke the critical
exception handler. The critical debug exception handler seems to handle
this case. So disable DE, let the previous handler continue and exit to
problem state with DE enabled. From the uprobe point of view, we won't
stop over kernel code but only know once a problem state instruction is
over.

Based on this I did not see a reason why we should disable EE (or CE)
upfront. And for CE, it should be harmless if the code notices that we
debug problem state and continue the non-critical exception with
DE-disabled.

Now, if you come along with some CPU erratas on the 4xx CPUs where we
have to disable CE/EE because the CPU doesn't do what is expected then
I think that this should be explained in the comment :)

> Cheers,
> Ben.

Sebastian
