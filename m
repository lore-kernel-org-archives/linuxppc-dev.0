Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5mjS0ZhrzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 23:47:08 +1000 (AEST)
Date: Mon, 10 Jul 2017 15:46:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, acme@kernel.org,
 jolsa@kernel.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, kan.liang@intel.com,
 ak@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 Linux-kernel@vger.kernel.org, yao.jin@intel.com
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
Message-ID: <20170710134658.k44bpa7tra2woyiu@hirez.programming.kicks-ass.net>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
 <87r2xoj08g.fsf@concordia.ellerman.id.au>
 <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
 <87h8ykvayi.fsf@concordia.ellerman.id.au>
 <dadaf750-1096-3e4b-1d97-b3d39e66dba8@linux.intel.com>
 <20170710131049.GA13471@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170710131049.GA13471@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2017 at 08:10:50AM -0500, Segher Boessenkool wrote:

> > PERF_BR_INT is triggered by instruction "int" .
> > PERF_BR_IRQ is triggered by interrupts, traps, faults (the ring 0,3 
> > transition).
> 
> So your "PERF_BR_INT" is a system call? 

The "INT" thing has indeed been used as system call mechanism (typically
INT 80). But these days we have special purpose syscall instructions.

It could maybe be compared to the PPC "Unconditional TRAP with
immediate" where you use the immediate value as an index into a handler
vector.

> And PERF_BR_IRQ is not an interrupt request (as its name suggests),
> not what we call an "external interrupt" either; instead it is every
> interrupt that is not a system call?

It is actual interrupts, but also faults, traps and all the other
exceptions not caused by "INT" I think.
