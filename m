Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5ZSH67hwzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 16:05:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org, jolsa@kernel.org,
 peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: ak@linux.intel.com, kan.liang@intel.com, linuxppc-dev@lists.ozlabs.org,
 Linux-kernel@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
 yao.jin@intel.com
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
In-Reply-To: <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
Date: Mon, 10 Jul 2017 16:05:03 +1000
Message-ID: <87r2xoj08g.fsf@concordia.ellerman.id.au>
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

Hi Jin Yao,

Sorry I haven't commented until now, but it got lost in the flood of
patches.

Just a few nit-picks below ...

Jin Yao <yao.jin@linux.intel.com> writes:

> It is often useful to know the branch types while analyzing branch
> data. For example, a call is very different from a conditional branch.
>
> Currently we have to look it up in binary while the binary may later
> not be available and even the binary is available but user has to take
> some time. It is very useful for user to check it directly in perf
> report.
>
> Perf already has support for disassembling the branch instruction
> to get the x86 branch type.
>
> To keep consistent on kernel and userspace and make the classification
> more common, the patch adds the common branch type classification
> in perf_event.h.

Most of the code and doc uses "branch" but then a few these are called
"jump". Can we just stick with "branch"?

> PERF_BR_NONE      : unknown
> PERF_BR_JCC       : conditional jump
> PERF_BR_JMP       : jump
> PERF_BR_IND_JMP   : indirect jump

eg:

PERF_BR_COND    : conditional branch
PERF_BR_UNCOND  : unconditional branch
PERF_BR_IND     : indirect branch

> PERF_BR_CALL      : call
> PERF_BR_IND_CALL  : indirect call
> PERF_BR_RET       : return
> PERF_BR_SYSCALL   : syscall
> PERF_BR_SYSRET    : syscall return
> PERF_BR_IRQ       : hw interrupt/trap/fault
> PERF_BR_INT       : sw interrupt

I'm not sure what that means, I'm guessing on x86 it means someone
executed "int" ?

Is that sufficiently useful to use up a bit? I think we only have 3
free?

> PERF_BR_IRET      : return from interrupt
> PERF_BR_FAR_BRANCH: not generic far branch type

What is a "not generic far branch" ?

I don't know what that would mean on powerpc for example.


I think the only thing we have on powerpc that's commonly used and that
isn't covered above is branches that decrement a loop counter and then
branch based on the result.

It might be nice if we could separate those out from other conditional
branches. Whether it's worth using a bit for I'm not sure. Do other
arches have something similar?

Those branches do tend to be "backward conditional", so that may be
sufficient. But backward conditional also includes if bodies that have
been moved out of line and then branch back to the main body of the
function.

cheers
