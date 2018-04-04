Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GFwD39W2zF1qF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 16:11:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Evans <matt@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Clear branch trap (MSR.BE) before delivering
 SIGTRAP
In-Reply-To: <71F58B2E-149D-41E4-A5BF-5A26E3491EA7@ozlabs.org>
References: <74EBF461-0D94-4C2D-ABA7-0B9BE010F173@ozlabs.org>
 <877epw3fu2.fsf@concordia.ellerman.id.au>
 <C8B54188-179A-475D-B06A-A25426EF6932@ozlabs.org>
 <71F58B2E-149D-41E4-A5BF-5A26E3491EA7@ozlabs.org>
Date: Wed, 04 Apr 2018 16:11:37 +1000
Message-ID: <87d0zfo606.fsf@concordia.ellerman.id.au>
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

Matt Evans <matt@ozlabs.org> writes:
>> On 28 Mar 2018, at 11:36, Matt Evans <matt@ozlabs.org> wrote:
>>> On 28 Mar 2018, at 06:54, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Matt Evans <matt@ozlabs.org> writes:
>>>> When using SIG_DBG_BRANCH_TRACING, MSR.BE is left enabled in the
>>>> user context when single_step_exception() prepares the SIGTRAP
>>>> delivery.  The resulting branch-trap-within-the-SIGTRAP-handler
>>>> isn't healthy.
>>>>=20
>>>> Commit 2538c2d08f46141550a1e68819efa8fe31c6e3dc broke this, by
>>>> replacing an MSR mask operation of ~(MSR_SE | MSR_BE) with a call
>>>> to clear_single_step() which only clears MSR_SE.
>>>>=20
>>>> This patch adds a new helper, clear_br_trace(), which clears the
>>>> debug trap before invoking the signal handler.  This helper is a
>>>> NOP for BookE as SIG_DBG_BRANCH_TRACING isn't supported on BookE.
>>>>=20
>>>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>>>=20
>>> Hi Matt!
>>>=20
>>> It seems we might not be regularly testing this code :}
>>=20
>> I know, rite? ;-)
>>=20
>>> How did you hit/find the bug? And do you have a test case by any chance?
>>>=20
>>> I found the test code at the bottom of:
>>> https://lwn.net/Articles/114587/
>>>=20
>>> But it didn't immediately work.
>>=20
>> I'm using this feature as part of a debug harness I wrote to log a
>> program=E2=80=99s control flow (to create a =E2=80=9Cknown good=E2=80=9D=
 pattern to compare a
>> PPC interpreter against). So at least the feature has /one/ user. ;-)

One is enough for us :)
=20
>> The symptoms of the bug are that if you use single-stepping you get a
>> sequence of SIGTRAPs representing each instruction completion (good),
>> but if you use branch tracing the process just dies with SIGTRAP
>> (looks like it=E2=80=99s never caught by the signal handler). What=E2=80=
=99s really
>> happening is that there /is/ a signal delivered to the handler, but
>> (because branch tracing is left on) that then causes a second debug
>> exception from the handler itself, i.e. whilst SIGTRAP=E2=80=99s masked.
>>=20
>> OK, let me have a dig to reduce my program to something very basic
>> and I=E2=80=99ll post something =E2=80=94 sorry, I should=E2=80=99ve got=
 a PoC ready before.
>> (I did start out inspired by that post you linked to, but IIRC I
>> don=E2=80=99t think it worked out of the box for me either.)
>
> I=E2=80=99ve put a simple SIG_DBG_BRANCH_TRACING test program here:
>
> 	http://ozlabs.org/~matt/files/sig_dbg_brtrace_test.c

Thanks.

> It=E2=80=99s commented regarding expected output. I=E2=80=99ve only teste=
d this on a
> G4 =E2=80=94 it should work on PPC64 too but the ISA says support for bra=
nch
> tracing is optional for an implementation. I=E2=80=99d be interested in w=
hat
> POWERx does. :)

I get no traps on any 64-bit machine I tried, including 970FX, Power6,
Power7, Power8, Power9.

So I guess it's never been implemented on "server" CPUs.

I'd be happy to turn your test program into a selftest, though it won't
actually catch bugs unless someone runs it on actual 32-bit systems :)

cheers
