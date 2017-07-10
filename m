Return-Path: <yao.jin@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5dMm5KWdzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 18:16:20 +1000 (AEST)
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
To: Michael Ellerman <mpe@ellerman.id.au>, acme@kernel.org, jolsa@kernel.org,
 peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: ak@linux.intel.com, kan.liang@intel.com, linuxppc-dev@lists.ozlabs.org,
 Linux-kernel@vger.kernel.org, yao.jin@intel.com
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
 <87r2xoj08g.fsf@concordia.ellerman.id.au>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
Date: Mon, 10 Jul 2017 16:16:13 +0800
MIME-Version: 1.0
In-Reply-To: <87r2xoj08g.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 7/10/2017 2:05 PM, Michael Ellerman wrote:
> Hi Jin Yao,
>
> Sorry I haven't commented until now, but it got lost in the flood of
> patches.

Never mind, it's no problem. :)

> Just a few nit-picks below ...
> Jin Yao <yao.jin@linux.intel.com> writes:
>
>> It is often useful to know the branch types while analyzing branch
>> data. For example, a call is very different from a conditional branch.
>>
>> Currently we have to look it up in binary while the binary may later
>> not be available and even the binary is available but user has to take
>> some time. It is very useful for user to check it directly in perf
>> report.
>>
>> Perf already has support for disassembling the branch instruction
>> to get the x86 branch type.
>>
>> To keep consistent on kernel and userspace and make the classification
>> more common, the patch adds the common branch type classification
>> in perf_event.h.
> Most of the code and doc uses "branch" but then a few these are called
> "jump". Can we just stick with "branch"?
>
>> PERF_BR_NONE      : unknown
>> PERF_BR_JCC       : conditional jump
>> PERF_BR_JMP       : jump
>> PERF_BR_IND_JMP   : indirect jump
> eg:
>
> PERF_BR_COND    : conditional branch
> PERF_BR_UNCOND  : unconditional branch
> PERF_BR_IND     : indirect branch

Call and jump are all branches. If we want to figure out which one is 
jump and which one is call, we need the detail branch type definitions.

For example,  if we only say "PERF_BR_IND", we could not know if it's an 
indirect jump or indirect call.
>> PERF_BR_CALL      : call
>> PERF_BR_IND_CALL  : indirect call
>> PERF_BR_RET       : return
>> PERF_BR_SYSCALL   : syscall
>> PERF_BR_SYSRET    : syscall return
>> PERF_BR_IRQ       : hw interrupt/trap/fault
>> PERF_BR_INT       : sw interrupt
> I'm not sure what that means, I'm guessing on x86 it means someone
> executed "int" ?

PERF_BR_IRQ is for hw interrupt and PERF_BR_INT is for sw interrupt.

PERF_BR_CALL/PERF_BR_IND_CALL and PERF_BR_RET are for function call 
(direct call and indirect call) and return.

PERF_BR_SYSCALL/PERF_BR_SYSRET are for syscall and syscall return.

> Is that sufficiently useful to use up a bit? I think we only have 3
> free?

Do you means 3 bits? Each bit stands for one branch type? I guess what 
you mean is:

PERF_BR_COND    : conditional branch
PERF_BR_UNCOND  : unconditional branch
PERF_BR_IND     : indirect branch

But 3 branch types are not enough for us.

>> PERF_BR_IRET      : return from interrupt
>> PERF_BR_FAR_BRANCH: not generic far branch type
> What is a "not generic far branch" ?
>
> I don't know what that would mean on powerpc for example.

It's reserved for future using I think.

>
> I think the only thing we have on powerpc that's commonly used and that
> isn't covered above is branches that decrement a loop counter and then
> branch based on the result.
>
> It might be nice if we could separate those out from other conditional
> branches. Whether it's worth using a bit for I'm not sure. Do other
> arches have something similar?
>
> Those branches do tend to be "backward conditional", so that may be
> sufficient. But backward conditional also includes if bodies that have
> been moved out of line and then branch back to the main body of the
> function.
>
> cheers

Sorry, I'm not familiar with powerpc arch. Or could you add the branch 
type which powerpc needs?

For backward conditional and forward conditional, we compute them in 
userspace according to the from/to addresses.

Thanks
Jin Yao
