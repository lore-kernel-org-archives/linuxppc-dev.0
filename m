Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPv2h1NQpzDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 17:26:52 +1000 (AEST)
Date: Thu, 1 Sep 2016 09:26:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/13] perf/core: Add perf_arch_regs and mask to
 perf_regs structure
Message-ID: <20160901072629.GJ10153@twins.programming.kicks-ass.net>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472418058-28659-2-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472418058-28659-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 29, 2016 at 02:30:46AM +0530, Madhavan Srinivasan wrote:
> It's a perennial request from hardware folks to be able to
> see the raw values of the pmu registers. Partly it's so that
> they can verify perf is doing what they want, and some
> of it is that they're interested in some of the more obscure
> info that isn't plumbed out through other perf interfaces.

How much and what is that? Can't we try and get interfaces sorted?

> Over the years internally have used various hack to get
> the requested data out but this is an attempt to use a
> somewhat standard mechanism (using PERF_SAMPLE_REGS_INTR).

Not really liking that. It assumes too much and doesn't seem to cover
about half the perf use-cases.

It assumes the machine state can be captured by registers (this is false
for things like Intel DS/PT, which have state in memory), it might
assume <= 64 registers but I didn't look that closely, this too might
become somewhat restrictive.

Worse, it doesn't work for !sampling workloads, of which you also very
much want to verify programming etc.

> This would also be helpful for those of us working on the perf
> hardware backends, to be able to verify that we're programming
> things correctly, without resorting to debug printks etc.

On x86 we can trace the MSR writes. No need to add debug printk()s.
We could (and I have on occasion) added tracepoints (well trace_printk)
to the Intel DS memory stores to see what was written there.

Tracing is much more flexible for debugging this stuff.

Can't you do something along those lines?
