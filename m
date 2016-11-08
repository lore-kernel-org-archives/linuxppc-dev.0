Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCj9L6zhXzDvPF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 19:27:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] ppc: cpufreq: disable preemption while checking CPU
 throttling state
In-Reply-To: <20161108031720.GB24936@in.ibm.com>
References: <1478257718-14923-1-git-send-email-kda@linux-powerpc.org>
 <87fun3n3lt.fsf@concordia.ellerman.id.au>
 <CAOJe8K1Cb_UH+yRb8_hYB3T9i8EqteS_nTgWWNcA-EtZvm-wNg@mail.gmail.com>
 <87k2celt30.fsf@concordia.ellerman.id.au> <20161108031720.GB24936@in.ibm.com>
Date: Tue, 08 Nov 2016 19:27:33 +1100
Message-ID: <87vavyjs0a.fsf@concordia.ellerman.id.au>
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

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Tue, Nov 08, 2016 at 11:21:23AM +1100, Michael Ellerman wrote:
>> Denis Kirjanov <kda@linux-powerpc.org> writes:
>> > On 11/7/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >> Denis Kirjanov <kda@linux-powerpc.org> writes:
>> >>>     [   67.700897] BUG: using smp_processor_id() in preemptible [00000000] code: cat/7343
>> >>>     [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
>> >>
>> >> When did this break?
>> >
>> > I think that problem exists since commit
>> > 09a972d1620934142d30cfda455ffe429af751c4 ("cpufreq: powernv: Report
>> > cpu frequency throttling") but I can be wrong
>> 
>> Yep that looks right to me, thanks.
>> 
>> Gautham, how bad is the bug here, do we want to send this to stable?
>
> Not so bad that it needs to be sent to stable immediately.
>
> On CONFIG_PREEMPT enabled systems, if task executing
> powernv_cpufreq_throttle_check can be switched to a CPU on a different
> chip, then we will end up incorrectly attributing the throttle
> statistics of the new chip to the chip where it previously ran. These
> throttle statistics aren't used inside the kernel for any computation,
> but are reported to the user via /sysfs for them to account for any
> variance during a benchmark run.

OK.

> It would be good to include this in the 4.9 fixes though. 

Normally I'd say by about rc5 that if it's not important enough for
stable then it can wait for next (or it fixes a bug introduced in the
current release).

But I just realised it's actually in drivers/cpufreq/powernv-cpufreq.c,
which goes via Raphael, so it's up to him.

And he's not on CC :/

Denis can you resend and CC the cpufreq folks:

rjw@rjwysocki.net
viresh.kumar@linaro.org
linux-pm@vger.kernel.org


And add:

Fixes: 09a972d16209 ("cpufreq: powernv: Report cpu frequency throttling")

And fixup the subject to be:

cpufreq, powernv: Disable preemption while checking CPU throttling state


Thanks.

cheers
