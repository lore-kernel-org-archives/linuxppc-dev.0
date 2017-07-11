Return-Path: <yao.jin@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x66KV2tYyzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 13:01:01 +1000 (AEST)
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
To: Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, kan.liang@intel.com, ak@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, Linux-kernel@vger.kernel.org,
 yao.jin@intel.com
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
 <87r2xoj08g.fsf@concordia.ellerman.id.au>
 <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
 <87h8ykvayi.fsf@concordia.ellerman.id.au>
 <dadaf750-1096-3e4b-1d97-b3d39e66dba8@linux.intel.com>
 <20170710131049.GA13471@gate.crashing.org>
 <20170710134658.k44bpa7tra2woyiu@hirez.programming.kicks-ass.net>
 <b8ff5062-6477-01a2-b626-1ea3c286d272@linux.intel.com>
 <87shi37lmp.fsf@concordia.ellerman.id.au>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cb4c3646-d4ff-a0d0-3f34-b68795e5eabb@linux.intel.com>
Date: Tue, 11 Jul 2017 11:00:55 +0800
MIME-Version: 1.0
In-Reply-To: <87shi37lmp.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 7/11/2017 10:28 AM, Michael Ellerman wrote:
> "Jin, Yao" <yao.jin@linux.intel.com> writes:
>
>> On 7/10/2017 9:46 PM, Peter Zijlstra wrote:
>>> On Mon, Jul 10, 2017 at 08:10:50AM -0500, Segher Boessenkool wrote:
>>>
>>>>> PERF_BR_INT is triggered by instruction "int" .
>>>>> PERF_BR_IRQ is triggered by interrupts, traps, faults (the ring 0,3
>>>>> transition).
>>>> So your "PERF_BR_INT" is a system call?
>>> The "INT" thing has indeed been used as system call mechanism (typically
>>> INT 80). But these days we have special purpose syscall instructions.
>>>
>>> It could maybe be compared to the PPC "Unconditional TRAP with
>>> immediate" where you use the immediate value as an index into a handler
>>> vector.
>>>
>>>> And PERF_BR_IRQ is not an interrupt request (as its name suggests),
>>>> not what we call an "external interrupt" either; instead it is every
>>>> interrupt that is not a system call?
>>> It is actual interrupts, but also faults, traps and all the other
>>> exceptions not caused by "INT" I think.
>>>
>> Yes. It's interrupt, traps, faults. If from is in the user space and to
>> is in the kernel, it indicates the ring3 -> ring0 transition.
>>
>> If the from instruction is not syscall or other ring transition
>> instruction, it should be interrupt, traps and faults. That's how we get
>> the PERF_BR_IRQ on x86.
>>
>> Anyway, maybe we just use a minimum but the most common set of branch
>> types now, it could be a good start and acceptable on all architectures.
>>
>> PERF_BR_COND        = 1,    /* conditional */
>> PERF_BR_UNCOND        = 2,    /* unconditional */
>> PERF_BR_IND        = 3,    /* indirect */
>> PERF_BR_CALL        = 4,    /* call */
>> PERF_BR_IND_CALL    = 5,    /* indirect call */
>> PERF_BR_RET        = 6,    /* return */
> That would be fine by me, if you're sick of talking about it and just
> want to get it merged :)
:)
>
> I think you could expand it a bit, this list would cover the vast bulk
> of branch types for us:
>
>    PERF_BR_COND		/* Conditional */
>    PERF_BR_UNCOND	/* Unconditional */
>    PERF_BR_IND		/* Indirect */
>    PERF_BR_CALL		/* Function call */
>    PERF_BR_IND_CALL	/* Indirect function call */
>    PERF_BR_RET		/* Function return */
>    PERF_BR_SYSCALL	/* Syscall */
>    PERF_BR_SYSRET	/* Syscall return */
>    PERF_BR_COND_CALL	/* Conditional function call */
>    PERF_BR_COND_RET	/* Conditional function return */
>
> cheers

OK, accept! Use 4 bits for above branch types and we can reserve 5 for 
potential future types.

Thanks
Jin Yao
