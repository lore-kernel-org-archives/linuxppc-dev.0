Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWR221cSczDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 14:46:18 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id n23so17207423pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 21:46:18 -0700 (PDT)
Date: Mon, 22 May 2017 14:46:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mikey@neuling.org, cyrilbur@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64: Use tick accounting by default
Message-ID: <20170522144605.587fb632@roar.ozlabs.ibm.com>
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

On Mon, 22 May 2017 14:15:57 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Anton Blanchard <anton@ozlabs.org> writes:
> 
> > From: Anton Blanchard <anton@samba.org>
> >
> > ppc64 is the only architecture that turns on VIRT_CPU_ACCOUNTING_NATIVE
> > by default. The overhead of this option is extremely high - a context
> > switch microbenchmark using sched_yield() is almost 20% slower.  
> 
> Running on what? It should all be nop'ed out unless you're on a platform
> that needs it (SPLPAR).

Not ACCOUNT_CPU_USER_ENTRY/EXIT, which adds a fair cost to kernel
entry/exit (my notes say ~70 cycles on getppid() out of 3-4 hundred).

> 
> > To get finer grained user/hardirq/softirq statitics, the
> > IRQ_TIME_ACCOUNTING option can be used instead, which has much lower
> > overhead.  
> 
> Can it? We don't select HAVE_IRQ_TIME_ACCOUNTING, so AFAICS it can't be
> enabled.
> 
> Doesn't dropping this mean we never count stolen time?
> 
> cheers
