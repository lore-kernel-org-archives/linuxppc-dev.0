Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6LX33Rg3zDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:10:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [PATCH] powerpc/64: Fix atomic64_inc_not_zero() to return an int
Date: Tue, 11 Jul 2017 22:10:54 +1000
Message-Id: <1499775054-631-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although it's not documented anywhere, there is an expectation that
atomic64_inc_not_zero() returns a result which fits in an int. This is
the behaviour implemented on all arches except powerpc.

This has caused at least one bug in practice, in the percpu-refcount
code, where the long result from our atomic64_inc_not_zero() was
truncated to an int leading to lost references and stuck systems. That
was worked around in that code in commit 966d2b04e070 ("percpu-refcount:
fix reference leak during percpu-atomic transition").

To the best of my grepping abilities there are no other callers
in-tree which truncate the value, but we should fix it anyway. Because
the breakage is subtle and potentially very harmful I'm also tagging
it for stable.

Code generation is largely unaffected because in most cases the
callers are just using the result for a test anyway. In particular the
case of fget() that was mentioned in commit a6cf7ed5119f
("powerpc/atomic: Implement atomic*_inc_not_zero") generates exactly
the same code.

Fixes: a6cf7ed5119f ("powerpc/atomic: Implement atomic*_inc_not_zero")
Cc: stable@vger.kernel.org # v3.4
Noticed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/atomic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 2b90335194a7..a2cc8010cd72 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -560,7 +560,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
  * Atomically increments @v by 1, so long as @v is non-zero.
  * Returns non-zero if @v was non-zero, and zero otherwise.
  */
-static __inline__ long atomic64_inc_not_zero(atomic64_t *v)
+static __inline__ int atomic64_inc_not_zero(atomic64_t *v)
 {
 	long t1, t2;
 
@@ -579,7 +579,7 @@ static __inline__ long atomic64_inc_not_zero(atomic64_t *v)
 	: "r" (&v->counter)
 	: "cc", "xer", "memory");
 
-	return t1;
+	return t1 != 0;
 }
 
 #endif /* __powerpc64__ */
-- 
2.7.4
