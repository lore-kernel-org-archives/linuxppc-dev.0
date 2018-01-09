Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGGMd4RX9zF0cn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 02:31:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 John Sperbeck <jsperbeck@google.com>, Shriya <shriyak@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Sleep in preempt_disable on powernv with 'cat /proc/cpuinfo' on
 v4.15
In-Reply-To: <1515483825.541.40.camel@kernel.crashing.org>
References: <CAFNjLiW4Dc9J_Q6L0zOT1f+AyNYOLWFPk1iXb7JNTPaqpozkCQ@mail.gmail.com>
 <1515483825.541.40.camel@kernel.crashing.org>
Date: Wed, 10 Jan 2018 02:31:40 +1100
Message-ID: <87incbkq03.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2018-01-08 at 21:30 -0800, John Sperbeck wrote:
>> The pnv_get_proc_freq() function was recently changed to call
>> cpufreq_get(), instead of cpufreq_quick_get(), in order to fetch
>> a more up-to-date value for the CPU frequency:
>> 
>>    cd77b5ce208c153260ed7882d8910f2395bfaabd
>>    powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo
>> 
>> Unfortunately, this function is called from show_cpuinfo() in
>> arch/powerpc/kernel/setup-common.c with preemption disabled.  The
>> cpufreq_get() function might do a down_read(), which can sleep.
>> 
>> With CONFIG_DEBUG_KERNEL and CONFIG_DEBUG_ATOMIC_SLEEP set, a warning
>> like the following is generated when running 'cat /proc/cpuinfo':

This was reported by Nick back in November just a few days after the
patch went in, so it's a little disappointing that it's still broken.

> We could just either remove the preempt_disable completely like
> x86 and keep it racy, or stick a cpus_read_lock around it. I dont think
> we need that preempt_disable, it's definitely overkill.
>
> Michael, what do you think ? I'm keen on sync'ing with x86 here...

Yeah I think we can drop it. The cpufreq seems to have some locking that
looks like it'll probably work - famous last words.

Who's writing the patch?

cheers
