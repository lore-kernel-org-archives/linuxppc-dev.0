Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B877E1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 18:48:24 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 6 Nov 2015 17:48:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0E9E82CE8065
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 18:48:14 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA67m5NX35848388
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 18:48:14 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA67ldMe002056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 18:47:41 +1100
Subject: Re: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
 <20151106025844.GA28859@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Message-ID: <563C5AFD.9040102@linux.vnet.ibm.com>
Date: Fri, 6 Nov 2015 13:17:09 +0530
MIME-Version: 1.0
In-Reply-To: <20151106025844.GA28859@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 06 November 2015 08:28 AM, Sukadev Bhattiprolu wrote:
> Peter Zijlstra [peterz@infradead.org] wrote:
> | On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
> | > Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
> | > and adds offsetof macro for the same. It extends perf_reg_value()
> | > to use reg idx to decide on struct to return value from.
> | 
> | Why; what's in those regs?
>
> Those are PMU control registers/counters (in Patch 2) that are of
> interest only in the context of a PMU interrupt and not relevant
> to ptrace itself.

Yes. Thats right.

> Could we add those registers to 'struct pt_regs' anyway?

I would prefer not to. Since as you mentioned, these are
not relevant to ptrace. Currently patch 2, adds only few
pmu registers, but would like to include more.
 
> We do have 'struct perf_regs' but that seems to be arch nuetral.
> If architectures could override that, maybe we could add these
> new registers there without touching 'struct pt_regs'.

Exactly, idea here is to capture more data using perf_sample_reg_intr
without extending pt_regs structure.

Maddy

> Even so, lot of perf code depends on 'struct pt_regs'.
>
> Sukadev
