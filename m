Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFD831A0D81
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 18:28:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 6 Nov 2015 17:28:27 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4E8622CE805F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 18:28:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA67SD7e61145174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 18:28:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA67RmiL003299
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 18:27:49 +1100
Subject: Re: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
To: Peter Zijlstra <peterz@infradead.org>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Message-ID: <563C5655.3000605@linux.vnet.ibm.com>
Date: Fri, 6 Nov 2015 12:57:17 +0530
MIME-Version: 1.0
In-Reply-To: <20151105130716.GC3604@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 05 November 2015 06:37 PM, Peter Zijlstra wrote:
> On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
>> Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
>> and adds offsetof macro for the same. It extends perf_reg_value()
>> to use reg idx to decide on struct to return value from.
> Why; what's in those regs?

Was out and did not have access to mail, so missed to respond in time.

In current implementation of patch 2, have added 
few pmu control/status and counter registers,
which give additional information about the PMU context
for the sample.

These pmu registers are not relevant for ptrace and did not
want to overload pt_regs struct.

Adding these arch specific regs in perf_regs will break the "arch
neutral" part, and
other arch can also use this new struct in perf_regs to add more data
using perf_sample_regs_intr without extending the pt_regs.

Maddy
