Return-Path: <srs0=hhrr=3o=gmail.com=linus971@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzVBY2MZrzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 03:31:49 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzVBY173hz8sxT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 03:31:49 +1000 (AEST)
Received: from mail-io0-x22f.google.com (mail-io0-x22f.google.com
 [IPv6:2607:f8b0:4001:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzVBX2LBrz9s84
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 03:31:48 +1000 (AEST)
Received: by mail-io0-x22f.google.com with SMTP id l7so34233718ioe.3
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 10:31:48 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com> <20170406141352.GF18204@arm.com>
 <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
 <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Apr 2017 10:31:46 -0700
Message-ID: <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Miller <davem@davemloft.net>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 6, 2017 at 9:36 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like the below, which is ugly (because I couldn't be bothered
> to resolve the header recursion and thus duplicates the monitor/mwait
> functions) and broken (because it hard assumes the hardware can do
> monitor/mwait).

Yeah, I think it needs to be conditional not just om mwait support,
but on the "new" mwait support (ie "CPUID.05H:ECX[bit 1] = 1").

And we'd probably want to make it even more strict, in that soem mwait
implementations might simply not be very good for short waits.

Because I think the latency was hundreds of cycles at some point (but
that may have been the original version that wouldn't have had the
"new mwait" bit set), and there are also issues with virtualization
(ie we may not want to do this in a guest because it causes a VM
exit).

> But it builds and boots, no clue if its better or worse. Changing mwait
> eax to 0 would give us C1 and might also be worth a try I suppose.

Hmm. Also:

> +               ___mwait(0xf0 /* C0 */, 0x01 /* INT */);                \

Do you actually want that "INT" bit set? It's only meaningful if
interrupts are _masked_, afaik. Which doesn't necessarily make sense
for this case.

If interrupts would actually get delivered to software, mwait will
exit regardless.

So I think __mwait(0,0) might be the rigth thing at least in some
cases. Or at least worth timing at some point.

Of course, we really shouldn't have very many places that actually
need this. We currently use it in three places, I think:

 - spinlocks. This is likely the the big case.

 - the per-cpu cross-cpu calling (call_single_data) exclusivity waiting

 - the magical on_cpu waiting in ttwu. I'm not sure how often this
actually triggers, the original argument for this was to avoid an
expensive barrier - the loop itself probably very seldom actually
triggers.

It may be, for example, that just the fact that your implementation
does the "__monitor()" part before doing the load and test, might be
already too expensive for the (common) cases where we don't expect to
loop.

But maybe "monitor" is really cheap. I suspect it's microcoded,
though, which implies "no".

                      Linus
