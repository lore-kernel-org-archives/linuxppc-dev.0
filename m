Return-Path: <srs0=hhrr=3o=gmail.com=linus971@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzY4h2sgyzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 05:41:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzY4h2103z8syC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 05:41:56 +1000 (AEST)
Received: from mail-it0-x234.google.com (mail-it0-x234.google.com
 [IPv6:2607:f8b0:4001:c0b::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzY4g4dBJz9s7g
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 05:41:54 +1000 (AEST)
Received: by mail-it0-x234.google.com with SMTP id y18so32419641itc.1
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 12:41:54 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170406192342.GC3093@worktop>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com> <20170406141352.GF18204@arm.com>
 <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
 <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
 <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
 <20170406192342.GC3093@worktop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Apr 2017 12:41:52 -0700
Message-ID: <CA+55aFzvRiVx3dvXaQUpYwoHq0DnrV9RPXWnqSeb9b80DFosHA@mail.gmail.com>
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

On Thu, Apr 6, 2017 at 12:23 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like so then. According to the SDM mwait is a no-op if we do
> not execute monitor first. So this variant should get the first
> iteration without expensive instructions.

No, the problem is that we *would* have executed a prior monitor that
could still be pending - from a previous invocation of
smp_cond_load_acquire().

Especially with spinlocks, these things can very much happen back-to-back.

And it would be pending with a different address (the previous
spinlock) that might not have changed since then (and might not be
changing), so now we might actually be pausing in mwait waiting for
that *other* thing to change.

So it would probably need to do something complicated like

  #define smp_cond_load_acquire(ptr, cond_expr)                         \
  ({                                                                    \
        typeof(ptr) __PTR = (ptr);                                      \
        typeof(*ptr) VAL;                                               \
        do {                                                            \
                VAL = READ_ONCE(*__PTR);                                \
                if (cond_expr)                                          \
                        break;                                          \
                for (;;) {                                              \
                        ___monitor(__PTR, 0, 0);                        \
                        VAL = READ_ONCE(*__PTR);                        \
                        if (cond_expr) break;                           \
                        ___mwait(0xf0 /* C0 */, 0);                     \
                }                                                       \
        } while (0)                                                     \
        smp_acquire__after_ctrl_dep();                                  \
        VAL;                                                            \
  })

which might just generate nasty enough code to not be worth it.

I dunno

             Linus
