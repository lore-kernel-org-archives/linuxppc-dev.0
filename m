Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18706.29951.370276.543442@cargo.ozlabs.ibm.com>
Date: Thu, 6 Nov 2008 15:39:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Tell gcc when we clobber the carry in inline asm
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have several instances of inline assembly code that use the addic
or addic. instructions, which set the carry bit, but don't include XER
in the list of clobbers (the carry bit is in the XER register).

This adds "xer" to the list of clobbers for those inline asm
statements that use addic or addic. and didn't already have it.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index f3fc733..499be5b 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -111,7 +111,7 @@ static __inline__ void atomic_inc(atomic_t *v)
 	bne-	1b"
 	: "=&r" (t), "+m" (v->counter)
 	: "r" (&v->counter)
-	: "cc");
+	: "cc", "xer");
 }
 
 static __inline__ int atomic_inc_return(atomic_t *v)
@@ -128,7 +128,7 @@ static __inline__ int atomic_inc_return(atomic_t *v)
 	ISYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "memory");
+	: "cc", "xer", "memory");
 
 	return t;
 }
@@ -155,7 +155,7 @@ static __inline__ void atomic_dec(atomic_t *v)
 	bne-	1b"
 	: "=&r" (t), "+m" (v->counter)
 	: "r" (&v->counter)
-	: "cc");
+	: "cc", "xer");
 }
 
 static __inline__ int atomic_dec_return(atomic_t *v)
@@ -172,7 +172,7 @@ static __inline__ int atomic_dec_return(atomic_t *v)
 	ISYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "memory");
+	: "cc", "xer", "memory");
 
 	return t;
 }
@@ -346,7 +346,7 @@ static __inline__ void atomic64_inc(atomic64_t *v)
 	bne-	1b"
 	: "=&r" (t), "+m" (v->counter)
 	: "r" (&v->counter)
-	: "cc");
+	: "cc", "xer");
 }
 
 static __inline__ long atomic64_inc_return(atomic64_t *v)
@@ -362,7 +362,7 @@ static __inline__ long atomic64_inc_return(atomic64_t *v)
 	ISYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "memory");
+	: "cc", "xer", "memory");
 
 	return t;
 }
@@ -388,7 +388,7 @@ static __inline__ void atomic64_dec(atomic64_t *v)
 	bne-	1b"
 	: "=&r" (t), "+m" (v->counter)
 	: "r" (&v->counter)
-	: "cc");
+	: "cc", "xer");
 }
 
 static __inline__ long atomic64_dec_return(atomic64_t *v)
@@ -404,7 +404,7 @@ static __inline__ long atomic64_dec_return(atomic64_t *v)
 	ISYNC_ON_SMP
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "memory");
+	: "cc", "xer", "memory");
 
 	return t;
 }
@@ -431,7 +431,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 	"\n\
 2:"	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "memory");
+	: "cc", "xer", "memory");
 
 	return t;
 }
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index 612d832..84b457a 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -67,7 +67,7 @@ static __inline__ long local_inc_return(local_t *l)
 	bne-	1b"
 	: "=&r" (t)
 	: "r" (&(l->a.counter))
-	: "cc", "memory");
+	: "cc", "xer", "memory");
 
 	return t;
 }
@@ -94,7 +94,7 @@ static __inline__ long local_dec_return(local_t *l)
 	bne-	1b"
 	: "=&r" (t)
 	: "r" (&(l->a.counter))
-	: "cc", "memory");
+	: "cc", "xer", "memory");
 
 	return t;
 }
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index f56a843..3686436 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -277,7 +277,7 @@ static inline void __raw_read_unlock(raw_rwlock_t *rw)
 	bne-		1b"
 	: "=&r"(tmp)
 	: "r"(&rw->lock)
-	: "cr0", "memory");
+	: "cr0", "xer", "memory");
 }
 
 static inline void __raw_write_unlock(raw_rwlock_t *rw)
