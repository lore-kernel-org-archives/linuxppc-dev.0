Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5nrw3hBqzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 00:38:40 +1000 (AEST)
Date: Mon, 10 Jul 2017 09:37:42 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, acme@kernel.org,
 jolsa@kernel.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 kan.liang@intel.com, ak@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 Linux-kernel@vger.kernel.org, yao.jin@intel.com
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
Message-ID: <20170710143737.GC13471@gate.crashing.org>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
 <87r2xoj08g.fsf@concordia.ellerman.id.au>
 <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
 <87h8ykvayi.fsf@concordia.ellerman.id.au>
 <dadaf750-1096-3e4b-1d97-b3d39e66dba8@linux.intel.com>
 <20170710131049.GA13471@gate.crashing.org>
 <20170710134658.k44bpa7tra2woyiu@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170710134658.k44bpa7tra2woyiu@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On Mon, Jul 10, 2017 at 03:46:58PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 10, 2017 at 08:10:50AM -0500, Segher Boessenkool wrote:
> 
> > > PERF_BR_INT is triggered by instruction "int" .
> > > PERF_BR_IRQ is triggered by interrupts, traps, faults (the ring 0,3 
> > > transition).
> > 
> > So your "PERF_BR_INT" is a system call? 
> 
> The "INT" thing has indeed been used as system call mechanism (typically
> INT 80). But these days we have special purpose syscall instructions.
> 
> It could maybe be compared to the PPC "Unconditional TRAP with
> immediate" where you use the immediate value as an index into a handler
> vector.

If we would do that, yes :-)  (We just generate a SIGTRAP instead).

> > And PERF_BR_IRQ is not an interrupt request (as its name suggests),
> > not what we call an "external interrupt" either; instead it is every
> > interrupt that is not a system call?
> 
> It is actual interrupts, but also faults, traps and all the other
> exceptions not caused by "INT" I think.

Ah, right, exceptions == interrupts for PowerPC, more terminological
confusion :-)


Segher
