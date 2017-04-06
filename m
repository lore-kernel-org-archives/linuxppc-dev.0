Return-Path: <srs0=i0ht=3o=infradead.org=peterz@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzXgw477lzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 05:23:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzXgw3NN9z8syC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 05:23:56 +1000 (AEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzXgv16LBz9s7B
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 05:23:55 +1000 (AEST)
Date: Thu, 6 Apr 2017 21:23:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Miller <davem@davemloft.net>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Message-ID: <20170406192342.GC3093@worktop>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com>
 <20170406141352.GF18204@arm.com>
 <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
 <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
 <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 06, 2017 at 10:31:46AM -0700, Linus Torvalds wrote:
> And we'd probably want to make it even more strict, in that soem mwait
> implementations might simply not be very good for short waits.

Yeah, we need to find something that works; assuming its beneficial at
all on modern chips.

> > But it builds and boots, no clue if its better or worse. Changing mwait
> > eax to 0 would give us C1 and might also be worth a try I suppose.
> 
> Hmm. Also:
> 
> > +               ___mwait(0xf0 /* C0 */, 0x01 /* INT */);                \
> 
> Do you actually want that "INT" bit set? It's only meaningful if
> interrupts are _masked_, afaik. Which doesn't necessarily make sense
> for this case.

Correct, in fact its quite broken. Corrected.

> But maybe "monitor" is really cheap. I suspect it's microcoded,
> though, which implies "no".

Something like so then. According to the SDM mwait is a no-op if we do
not execute monitor first. So this variant should get the first
iteration without expensive instructions.

And this variant is actually quite amenable to alternative(), with which
we can pick between PAUSE and this.

---
 arch/x86/include/asm/barrier.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index bfb28ca..2b5d5a2 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -80,6 +80,36 @@ do {									\
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
 
+static inline void ___monitor(const void *eax, unsigned long ecx,
+			     unsigned long edx)
+{
+	/* "monitor %eax, %ecx, %edx;" */
+	asm volatile(".byte 0x0f, 0x01, 0xc8;"
+		     :: "a" (eax), "c" (ecx), "d"(edx));
+}
+
+static inline void ___mwait(unsigned long eax, unsigned long ecx)
+{
+	/* "mwait %eax, %ecx;" */
+	asm volatile(".byte 0x0f, 0x01, 0xc9;"
+		     :: "a" (eax), "c" (ecx));
+}
+
+#define smp_cond_load_acquire(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	typeof(*ptr) VAL;						\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		___mwait(0xf0 /* C0 */, 0);				\
+		___monitor(__PTR, 0, 0);				\
+	}								\
+	smp_acquire__after_ctrl_dep();					\
+	VAL;								\
+})
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_X86_BARRIER_H */
