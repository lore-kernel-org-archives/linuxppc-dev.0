Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F18C81A0D15
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 21:25:49 +1100 (AEDT)
Date: Fri, 6 Nov 2015 11:25:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
Message-ID: <20151106102540.GR3604@twins.programming.kicks-ass.net>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
 <563C5655.3000605@linux.vnet.ibm.com>
 <20151106092430.GO3604@twins.programming.kicks-ass.net>
 <1446804240.21859.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446804240.21859.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 06, 2015 at 09:04:00PM +1100, Michael Ellerman wrote:
> It's a perrenial request from our hardware PMU folks to be able to see the raw
> values of the PMU registers.
> 
> I think partly it's so that they can verify that perf is doing what they want,
> and some of it is that they're interested in some of the more obscure info that
> isn't plumbed out through other perf interfaces.
> 
> We've used various internal hacks over the years to keep them happy. This is an
> attempt to use a somewhat standard mechanism.
> 
> It would also be helpful for those of us working on the perf hardware backends,
> to be able to verify that we're programming things correctly, without resorting
> to debug printks etc.
> 
> Basically we want to sample regs at the time of the perf interrupt, so we
> though PERF_SAMPLE_REGS_INTR made senes :)
> 
> But if you think this is the wrong mechanism within perf, then please let us
> know.
> 
> I know perf's mission is to abstract as much of the arcane hardware details
> into a generic interface and make PMUs actually useful for normal folks, and we
> are committed to that, but it would also be useful to be able to get the raw
> values for a different type of user.
> 
> Maddy's patch only exports PMC1-6 and MMCR0/1. I think we also need to export
> some others, in particular MMCRA has a lot of stuff in it, half of which is not
> even architected. So that would have to be exported as "POWER8_MMCRA". And then
> there's the SIAR/SDAR/SIER which contain a bunch of info on sampled
> instructions that is not currently plumbed out.

OK, no objections then. But this is useful information and should be
included in the patch set.
