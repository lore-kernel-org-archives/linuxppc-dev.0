Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVdlX6c67zDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 10:45:12 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u890hgeB038114
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 20:45:10 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25bc2r7kg8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Sep 2016 20:45:09 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 9 Sep 2016 10:45:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 22F522CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 10:45:05 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u890j5DO5636380
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 10:45:05 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u890j3Ee023829
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 10:45:04 +1000
Subject: Re: [PATCH 01/13] perf/core: Add perf_arch_regs and mask to perf_regs
 structure
To: Peter Zijlstra <peterz@infradead.org>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472418058-28659-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20160901072629.GJ10153@twins.programming.kicks-ass.net>
 <750f1871-9efd-01d3-386d-be93908ca94a@linux.vnet.ibm.com>
 <20160906091042.GJ10153@twins.programming.kicks-ass.net>
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
Date: Fri, 9 Sep 2016 06:14:53 +0530
MIME-Version: 1.0
In-Reply-To: <20160906091042.GJ10153@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2bbb5bfe-d096-d82a-398e-0c2df4242d7b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 06 September 2016 02:40 PM, Peter Zijlstra wrote:
> On Tue, Sep 06, 2016 at 09:55:43AM +0530, Madhavan Srinivasan wrote:
>>
>> On Thursday 01 September 2016 12:56 PM, Peter Zijlstra wrote:
>>> On Mon, Aug 29, 2016 at 02:30:46AM +0530, Madhavan Srinivasan wrote:
>>>> It's a perennial request from hardware folks to be able to
>>>> see the raw values of the pmu registers. Partly it's so that
>>>> they can verify perf is doing what they want, and some
>>>> of it is that they're interested in some of the more obscure
>>>> info that isn't plumbed out through other perf interfaces.
>>> How much and what is that? Can't we try and get interfaces sorted?
>> We have bunch of registers which exports information regarding the
>> sampled instruction like SIER/SIAR/SDAR/MMCRA. Lot of bits in these
>> registers are not yet architected and incase of SIER register, some of
>> the bits are not plumbed out and we are working on getting some these
>> exposed via perf.
> What kind of information is this? I'm not familiar with the Power PMU
> all that much, so you'll have to spell it out, not just mention the
> registers its stuffed in.


Sure. When we profile for sample events,
SIER (Sampled Instruction Event Register) provides additional
information about the sampled event when PMI occurred.

SIER [41:42] indicates whether the SIAR(Sampled instruction address 
registers)
and SDAR (Sampled data address register) are valid for the sampled event.

SIER [46:48] indicates the type of intructions,

001 Load Instruction
010 Store instruction
011 Branch Instruction
100 Floating Point Instruction other than a Load or Store instruction
101 Fixed Point Instruction other than a Load or Store instruction
110 Condition Register or System Call Instruction

SIER[49:51] gives information on the source of the sampled
instruction like instruction came from primary, secondary,
tertiary cache or beyond.

SIER[52:55] provide information on branch type instructions
Like mispredict and cause of it.

SIER[56:59] provides information on translation and also
source of translation like TLB, secondary cache, tertiary
or beyond

SIER[60:62] provides the interesting data on the storage
access like L1/l2/L3... so on.

Most of these could be plumbed out through standard mechanisms
and it's all the other bits that are more interesting, but
these are not architected and not public.

Like wise, MMCRA (Monitor Mode Control Register A) is a
configuration register for sampling and thresholding events.
Provide data on various event configuration information.

Link to the PowerISA v2.07 and Chapters 9 describes in
detail on these registers.

https://www.power.org/wp-content/uploads/2013/05/PowerISA_V2.07_PUBLIC.pdf

Maddy


>
