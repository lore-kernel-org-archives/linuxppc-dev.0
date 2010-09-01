Return-Path: <dvhltc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1A00BB711A
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 01:10:21 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o81Eu8j5027233
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Sep 2010 10:56:08 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o81FAIcQ116088
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Sep 2010 11:10:18 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o81FA9rG009309
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Sep 2010 11:10:18 -0400
Message-ID: <4C7E6CCC.8090700@us.ibm.com>
Date: Wed, 01 Sep 2010 08:10:04 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com> <1283320481.32679.32.camel@concordia>
In-Reply-To: <1283320481.32679.32.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Ankita Garg <ankita@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/31/2010 10:54 PM, Michael Ellerman wrote:
> On Tue, 2010-08-31 at 00:12 -0700, Darren Hart wrote:
> ..
>>
>> When running with the function plugin I had to stop the trace
>> immediately before entering start_secondary after an online or my traces
>> would not include the pseries_mach_cpu_die function, nor the tracing I
>> added there (possibly buffer size, I am using 2048). The following trace
>> was collected using "trace-cmd record -p function -e irq -e sched" and
>> has been filtered to only show CPU [001] (the CPU undergoing the
>> offline/online test, and the one seeing preempt_count (pcnt) go to
>> ffffffff after cede. The function tracer does not indicate anything
>> running on the CPU other than the HCALL - unless the __trace_hcall*
>> commands might be to blame. 
> 
> It's not impossible. Though normally they're disabled right, so the only
> reason they're running is because you're tracing. So if they are causing
> the bug then that doesn't explain why you see it normally.
> 
> Still, might be worth disabling just the hcall tracepoints just to be
> 100% sure.

A couple of updates. I was working from tip/rt/head, which has been
stale for some months now. I switched to tip/rt/2.6.33 and the
preempt_count() change over cede went away. I now see the live hang that
Will has reported.

Before I dive into the live hang, I want to understand what fixed the
preempt_count() change. That might start pointing us in the right
direction for the live hang.

I did an inverted git bisect between tip/rt/head and tip/rt/2.6.33 to
try and locate the fix. I've narrowed it down to the 2.6.33.6 merge:

# git show 7e1af1172bbd4109d09ac515c5d376f633da7cff
commit 7e1af1172bbd4109d09ac515c5d376f633da7cff
Merge: d8e94db 9666790
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Jul 13 16:01:16 2010 +0200

    Merge
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.33.y

    Conflicts:
        Makefile

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Visual inspection yields two patches of interest:

f8b67691828321f5c85bb853283aa101ae673130
powerpc/pseries: Make query-cpu-stopped callable outside hotplug cpu

aef40e87d866355ffd279ab21021de733242d0d5
powerpc/pseries: Only call start-cpu when a CPU is stopped

I'm going to try reverting these today and see if they addressed the
issue indirectly.


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
