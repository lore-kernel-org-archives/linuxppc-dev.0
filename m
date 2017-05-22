Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWRdV64BVzDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 15:13:34 +1000 (AEST)
Date: Mon, 22 May 2017 15:13:13 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 mikey@neuling.org, cyrilbur@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64: Use tick accounting by default
Message-ID: <20170522151313.3f60aca2@kryten>
In-Reply-To: <87shjxsf0i.fsf@concordia.ellerman.id.au>
References: <20170519144112.15649-1-anton@ozlabs.org>
 <87shjxsf0i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> > ppc64 is the only architecture that turns on
> > VIRT_CPU_ACCOUNTING_NATIVE by default. The overhead of this option
> > is extremely high - a context switch microbenchmark using
> > sched_yield() is almost 20% slower.  
> 
> Running on what? It should all be nop'ed out unless you're on a
> platform that needs it (SPLPAR).

POWERNV native. We don't nop out all the vtime_account_* gunk do we? It
is all those functions that are a large part of the problem.

> > To get finer grained user/hardirq/softirq statitics, the
> > IRQ_TIME_ACCOUNTING option can be used instead, which has much lower
> > overhead.  
> 
> Can it? We don't select HAVE_IRQ_TIME_ACCOUNTING, so AFAICS it can't
> be enabled.

I have a separate patch to enable it.

> Doesn't dropping this mean we never count stolen time?

Perhaps. Do we have any applications left that care?

Anton
