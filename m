Return-Path: <srs0=zfgn=3p=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzy2s1j91zDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 21:26:45 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzy2s0nydz8swH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 21:26:45 +1000 (AEST)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzy2q41sXz9s7C
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 21:26:43 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id g2so14924772pge.2
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Apr 2017 04:26:43 -0700 (PDT)
Date: Fri, 7 Apr 2017 21:26:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will.deacon@arm.com>, David Miller <davem@davemloft.net>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard
 <anton@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Message-ID: <20170407212626.59f68530@roar.ozlabs.ibm.com>
In-Reply-To: <20170407094349.f4hdqibbgl36s776@hirez.programming.kicks-ass.net>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com>
 <20170406141352.GF18204@arm.com>
 <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
 <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
 <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
 <20170407094349.f4hdqibbgl36s776@hirez.programming.kicks-ass.net>
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

On Fri, 7 Apr 2017 11:43:49 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 06, 2017 at 10:31:46AM -0700, Linus Torvalds wrote:
> > But maybe "monitor" is really cheap. I suspect it's microcoded,
> > though, which implies "no".  
> 
> On my IVB-EP (will also try on something newer):
> 
> MONITOR	~332 cycles
> MWAIT	~224 cycles (C0, explicitly invalidated MONITOR)
> 
> So yes, expensive.

Interestingly, Intel optimization manual says:

  The latency of PAUSE instruction in prior generation microarchitecture
  is about 10 cycles, whereas on Skylake microarchitecture it has been
  extended to as many as 140 cycles.

In another part this is claimed for efficiency improvement. Still much
cheaper than your monitor+mwait on your IVB but if skylake is a bit
faster it might become worth it.
