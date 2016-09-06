Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sStnm2tH0zDrpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 14:26:04 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u864MxPT125871
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 00:26:01 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 259mjb4kru-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 00:26:01 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 14:25:58 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E08532CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 14:25:55 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u864Pt9U5374378
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 14:25:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u864PsPF018940
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 14:25:55 +1000
Subject: Re: [PATCH 01/13] perf/core: Add perf_arch_regs and mask to perf_regs
 structure
To: Peter Zijlstra <peterz@infradead.org>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472418058-28659-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20160901072629.GJ10153@twins.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 6 Sep 2016 09:55:43 +0530
MIME-Version: 1.0
In-Reply-To: <20160901072629.GJ10153@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <750f1871-9efd-01d3-386d-be93908ca94a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 01 September 2016 12:56 PM, Peter Zijlstra wrote:
> On Mon, Aug 29, 2016 at 02:30:46AM +0530, Madhavan Srinivasan wrote:
>> It's a perennial request from hardware folks to be able to
>> see the raw values of the pmu registers. Partly it's so that
>> they can verify perf is doing what they want, and some
>> of it is that they're interested in some of the more obscure
>> info that isn't plumbed out through other perf interfaces.
> How much and what is that? Can't we try and get interfaces sorted?

We have bunch of registers which exports information regarding the
sampled instruction like SIER/SIAR/SDAR/MMCRA. Lot of bits in these
registers are not yet architected and incase of SIER register, some of
the bits are not plumbed out and we are working on getting some these
exposed via perf.

>
>> Over the years internally have used various hack to get
>> the requested data out but this is an attempt to use a
>> somewhat standard mechanism (using PERF_SAMPLE_REGS_INTR).
> Not really liking that. It assumes too much and doesn't seem to cover
> about half the perf use-cases.
>
> It assumes the machine state can be captured by registers (this is false
> for things like Intel DS/PT, which have state in memory), it might
> assume <= 64 registers but I didn't look that closely, this too might
> become somewhat restrictive.
>
> Worse, it doesn't work for !sampling workloads, of which you also very
> much want to verify programming etc.

Yes, I agree, my bad. I did assume and implemented considering
pmu registers primarily, but we can extend with additional flags
on the content being copied. Good point that patchset not handling
!sampling case. Let me explore on this and also the tracing options.

Thanks for the comments.
Maddy

>
>> This would also be helpful for those of us working on the perf
>> hardware backends, to be able to verify that we're programming
>> things correctly, without resorting to debug printks etc.
> On x86 we can trace the MSR writes. No need to add debug printk()s.
> We could (and I have on occasion) added tracepoints (well trace_printk)
> to the Intel DS memory stores to see what was written there.
>
> Tracing is much more flexible for debugging this stuff.
>
> Can't you do something along those lines?
>
