Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5lwt6717zDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 23:11:58 +1000 (AEST)
Date: Mon, 10 Jul 2017 08:10:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, acme@kernel.org, jolsa@kernel.org,
 peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, kan.liang@intel.com,
 ak@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 Linux-kernel@vger.kernel.org, yao.jin@intel.com
Subject: Re: [PATCH v6 1/7] perf/core: Define the common branch type
 classification
Message-ID: <20170710131049.GA13471@gate.crashing.org>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-2-git-send-email-yao.jin@linux.intel.com>
 <87r2xoj08g.fsf@concordia.ellerman.id.au>
 <820424b8-d7b3-56cc-2b97-ec570d44ec25@linux.intel.com>
 <87h8ykvayi.fsf@concordia.ellerman.id.au>
 <dadaf750-1096-3e4b-1d97-b3d39e66dba8@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dadaf750-1096-3e4b-1d97-b3d39e66dba8@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Mon, Jul 10, 2017 at 07:46:17PM +0800, Jin, Yao wrote:
> 1. We all agree these definitions:
> 
> +	PERF_BR_COND		= 1,	/* conditional */
> +	PERF_BR_UNCOND		= 2,	/* unconditional */
> +	PERF_BR_IND		= 3,	/* indirect */
> +	PERF_BR_CALL		= 4,	/* call */
> +	PERF_BR_IND_CALL	= 5,	/* indirect call */
> +	PERF_BR_RET		= 6,	/* return */
> +	PERF_BR_SYSCALL		= 7,	/* syscall */
> +	PERF_BR_SYSRET		= 8,	/* syscall return */
> +	PERF_BR_IRET		= 11,	/* return from interrupt */

Do we?  It does not map very well to PowerPC branch types.

> 2. I wish to keep following definitions for x86.
> 
> +	PERF_BR_IRQ		= 9,	/* hw interrupt/trap/fault */
> +	PERF_BR_INT		= 10,	/* sw interrupt */
> 
> PERF_BR_INT is triggered by instruction "int" .
> PERF_BR_IRQ is triggered by interrupts, traps, faults (the ring 0,3 
> transition).

So your "PERF_BR_INT" is a system call?  And PERF_BR_IRQ is not an
interrupt request (as its name suggests), not what we call an "external
interrupt" either; instead it is every interrupt that is not a system
call?

It also does not follow the lines of "software caused interrupt" vs.
the rest.

> 4. I'd like to add following types for powerpc.
> 
> 	PERF_BR_COND_CALL	/* Conditional call */
> 	PERF_BR_COND_RET	/* Condition return */

Almost all PowerPC branches have a "conditional" version (only "syscall"
and "sysret/iret" do not -- and those last two are the same, just like
PERF_BR_INT seems to be the same as PERF_BR_SYSCALL).

So how should those PERF_BR_* be used?  It cannot be used in an
architecture-neutral interface the way you define it now.


Segher
