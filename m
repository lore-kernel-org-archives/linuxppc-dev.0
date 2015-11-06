Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC6BA1A0D64
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 14:01:25 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 20:01:23 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 93C9C3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 20:01:21 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA631LKj28311662
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 20:01:21 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA631IAj003424
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 20:01:21 -0700
Date: Thu, 5 Nov 2015 18:58:45 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH  0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
Message-ID: <20151106025844.GA28859@us.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151105130716.GC3604@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
| > Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
| > and adds offsetof macro for the same. It extends perf_reg_value()
| > to use reg idx to decide on struct to return value from.
| 
| Why; what's in those regs?

Those are PMU control registers/counters (in Patch 2) that are of
interest only in the context of a PMU interrupt and not relevant
to ptrace itself.

Could we add those registers to 'struct pt_regs' anyway?

We do have 'struct perf_regs' but that seems to be arch nuetral.
If architectures could override that, maybe we could add these
new registers there without touching 'struct pt_regs'.

Even so, lot of perf code depends on 'struct pt_regs'.

Sukadev
