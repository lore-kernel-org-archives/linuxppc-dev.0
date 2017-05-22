Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWQM20RDqzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 14:15:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com, mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64: Use tick accounting by default
In-Reply-To: <20170519144112.15649-1-anton@ozlabs.org>
References: <20170519144112.15649-1-anton@ozlabs.org>
Date: Mon, 22 May 2017 14:15:57 +1000
Message-ID: <87shjxsf0i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@ozlabs.org> writes:

> From: Anton Blanchard <anton@samba.org>
>
> ppc64 is the only architecture that turns on VIRT_CPU_ACCOUNTING_NATIVE
> by default. The overhead of this option is extremely high - a context
> switch microbenchmark using sched_yield() is almost 20% slower.

Running on what? It should all be nop'ed out unless you're on a platform
that needs it (SPLPAR).

> To get finer grained user/hardirq/softirq statitics, the
> IRQ_TIME_ACCOUNTING option can be used instead, which has much lower
> overhead.

Can it? We don't select HAVE_IRQ_TIME_ACCOUNTING, so AFAICS it can't be
enabled.

Doesn't dropping this mean we never count stolen time?

cheers
