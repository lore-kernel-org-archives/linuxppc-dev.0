Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92877DDDFD
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Oct 2008 17:01:07 +1100 (EST)
Date: Sun, 12 Oct 2008 07:47:32 +0200
From: Nick Piggin <npiggin@suse.de>
To: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org
Subject: [patch] powerpc: implement optimised mutex fastpaths
Message-ID: <20081012054732.GB12535@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081012054634.GA12535@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Implement a more optimal mutex fastpath for powerpc, making use of acquire
and release barrier semantics. This takes the mutex lock+unlock benchmark
from 203 to 173 cycles on a G5.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/powerpc/include/asm/mutex.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/mutex.h
+++ linux-2.6/arch/powerpc/include/asm/mutex.h
@@ -1,9 +1,136 @@
 /*
- * Pull in the generic implementation for the mutex fastpath.
+ * Optimised mutex implementation of include/asm-generic/mutex-dec.h algorithm
+ */
+#ifndef _ASM_POWERPC_MUTEX_H
+#define _ASM_POWERPC_MUTEX_H
+
+static inline int __mutex_cmpxchg_lock(atomic_t *v, int old, int new)
+{
+	int t;
+
+	__asm__ __volatile__ (
+"1:	lwarx	%0,0,%1		# mutex trylock\n\
+	cmpw	0,%0,%2\n\
+	bne-	2f\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%3,0,%1\n\
+	bne-	1b"
+	ISYNC_ON_SMP
+	"\n\
+2:"
+	: "=&r" (t)
+	: "r" (&v->counter), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return t;
+}
+
+static inline int __mutex_dec_return_lock(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%1		# mutex lock\n\
+	addic	%0,%0,-1\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1\n\
+	bne-	1b"
+	ISYNC_ON_SMP
+	: "=&r" (t)
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+static inline int __mutex_inc_return_unlock(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+	LWSYNC_ON_SMP
+"1:	lwarx	%0,0,%1		# mutex unlock\n\
+	addic	%0,%0,1\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1 \n\
+	bne-	1b"
+	: "=&r" (t)
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+/**
+ *  __mutex_fastpath_lock - try to take the lock by moving the count
+ *                          from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fail_fn> if
+ * it wasn't 1 originally. This function MUST leave the value lower than
+ * 1 even when the "1" assertion wasn't true.
+ */
+static inline void
+__mutex_fastpath_lock(atomic_t *count, void (*fail_fn)(atomic_t *))
+{
+	if (unlikely(__mutex_dec_return_lock(count) < 0))
+		fail_fn(count);
+}
+
+/**
+ *  __mutex_fastpath_lock_retval - try to take the lock by moving the count
+ *                                 from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fail_fn> if
+ * it wasn't 1 originally. This function returns 0 if the fastpath succeeds,
+ * or anything the slow path function returns.
+ */
+static inline int
+__mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	if (unlikely(__mutex_dec_return_lock(count) < 0))
+		return fail_fn(count);
+	return 0;
+}
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the count from 0 to 1
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 0
+ *
+ * Try to promote the count from 0 to 1. If it wasn't 0, call <fail_fn>.
+ * In the failure case, this function is allowed to either set the value to
+ * 1, or to set it to a value lower than 1.
+ */
+static inline void
+__mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
+{
+	if (unlikely(__mutex_inc_return_unlock(count) <= 0))
+		fail_fn(count);
+}
+
+#define __mutex_slowpath_needs_to_unlock()		1
+
+/**
+ * __mutex_fastpath_trylock - try to acquire the mutex, without waiting
+ *
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: fallback function
  *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or pick the atomic_xchg() based generic
- * implementation. (see asm-generic/mutex-xchg.h for details)
+ * Change the count from 1 to a value lower than 1, and return 0 (failure)
+ * if it wasn't 1 originally, or return 1 (success) otherwise. This function
+ * MUST leave the value lower than 1 even when the "1" assertion wasn't true.
+ * Additionally, if the value was < 0 originally, this function must not leave
+ * it to 0 on failure.
  */
+static inline int
+__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	if (likely(__mutex_cmpxchg_lock(count, 1, 0) == 1))
+		return 1;
+}
 
-#include <asm-generic/mutex-dec.h>
+#endif
