Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5hP36tYszDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 20:32:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Jin\, Yao" <yao.jin@linux.intel.com>, acme@kernel.org, jolsa@kernel.org,
 peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: ak@linux.intel.com, kan.liang@intel.com, linuxppc-dev@lists.ozlabs.org,
 Linux-kernel@vger.kernel.org, yao.jin@intel.com
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
In-Reply-To: <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
 <87r2xoj08g.fsf@concordia.ellerman.id.au>
 <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
Date: Mon, 10 Jul 2017 20:32:37 +1000
Message-ID: <87h8ykvayi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Jin, Yao" <yao.jin@linux.intel.com> writes:
> On 7/10/2017 2:05 PM, Michael Ellerman wrote:
>> Jin Yao <yao.jin@linux.intel.com> writes:
>>
>>> It is often useful to know the branch types while analyzing branch
>>> data. For example, a call is very different from a conditional branch.
>>>
...
>>> To keep consistent on kernel and userspace and make the classification
>>> more common, the patch adds the common branch type classification
>>> in perf_event.h.
>>
>> Most of the code and doc uses "branch" but then a few these are called
>> "jump". Can we just stick with "branch"?
>>
>>> PERF_BR_NONE      : unknown
>>> PERF_BR_JCC       : conditional jump
>>> PERF_BR_JMP       : jump
>>> PERF_BR_IND_JMP   : indirect jump
>> eg:
>>
>> PERF_BR_COND    : conditional branch
>> PERF_BR_UNCOND  : unconditional branch
>> PERF_BR_IND     : indirect branch
>
> Call and jump are all branches. If we want to figure out which one is 
> jump and which one is call, we need the detail branch type definitions.

Yeah I'm not saying we don't need the different types, I'm saying I'd
rather we just called them "branch" not "jump". Just because "jump" can
mean different things on different arches.

> For example,  if we only say "PERF_BR_IND", we could not know if it's an 
> indirect jump or indirect call.

Yes we can, PERF_BR_IND is an indirect branch, which is not a call,
because if it was a call then it would be PERF_BR_IND_CALL.

>>> PERF_BR_CALL      : call
>>> PERF_BR_IND_CALL  : indirect call
>>> PERF_BR_RET       : return
>>> PERF_BR_SYSCALL   : syscall
>>> PERF_BR_SYSRET    : syscall return
>>> PERF_BR_IRQ       : hw interrupt/trap/fault
>>> PERF_BR_INT       : sw interrupt
>> I'm not sure what that means, I'm guessing on x86 it means someone
>> executed "int" ?
>
> PERF_BR_IRQ is for hw interrupt and PERF_BR_INT is for sw interrupt.

OK, but I still don't know what that means :)

What's an example of an instruction that is PERF_BR_IRQ and PERF_BR_INT ?

> PERF_BR_CALL/PERF_BR_IND_CALL and PERF_BR_RET are for function call 
> (direct call and indirect call) and return.

Yep makes sense.

> PERF_BR_SYSCALL/PERF_BR_SYSRET are for syscall and syscall return.

Yep OK.

>> Is that sufficiently useful to use up a bit? I think we only have 3
>> free?
>
> Do you means 3 bits? Each bit stands for one branch type? I guess what 
> you mean is:
>
> PERF_BR_COND    : conditional branch
> PERF_BR_UNCOND  : unconditional branch
> PERF_BR_IND     : indirect branch
>
> But 3 branch types are not enough for us.

What I meant was you're using 4 bits for the type, so you have 16
possible values, and you've defined 13 of them. Meaning there are only 3
types free.

So we should try to only define branch types that are really useful, and
keep some free for future use.

Maybe PERF_BR_INT is really common on x86 and so it's important to count
it, but like I said above I don't know what it is.

>>> PERF_BR_IRET      : return from interrupt
>>> PERF_BR_FAR_BRANCH: not generic far branch type
>> What is a "not generic far branch" ?
>>
>> I don't know what that would mean on powerpc for example.
>
> It's reserved for future using I think.

OK so let's not put it in the Linux API until it's defined?

>> I think the only thing we have on powerpc that's commonly used and that
>> isn't covered above is branches that decrement a loop counter and then
>> branch based on the result.
...
>
> Sorry, I'm not familiar with powerpc arch. Or could you add the branch 
> type which powerpc needs?

These are good:

+	PERF_BR_COND		= 1,	/* conditional */
+	PERF_BR_UNCOND		= 2,	/* unconditional */
+	PERF_BR_IND		= 3,	/* indirect */
+	PERF_BR_CALL		= 4,	/* call */
+	PERF_BR_IND_CALL	= 5,	/* indirect call */
+	PERF_BR_RET		= 6,	/* return */

These we wouldn't use currently, but make sense:

+	PERF_BR_SYSCALL		= 7,	/* syscall */
+	PERF_BR_SYSRET		= 8,	/* syscall return */
+	PERF_BR_IRET		= 11,	/* return from interrupt */

These I'm not so sure about, I don't really know what they would map to
for us:

+	PERF_BR_IRQ		= 9,	/* hw interrupt/trap/fault */
+	PERF_BR_INT		= 10,	/* sw interrupt */

And sounds like this should be dropped for now:

+	PERF_BR_FAR_BRANCH	= 12,	/* not generic far branch type */

The branch types you haven't covered which might be useful for us are:

	PERF_BR_COND_CALL	/* Conditional call */
	PERF_BR_COND_RET	/* Condition return */


cheers
