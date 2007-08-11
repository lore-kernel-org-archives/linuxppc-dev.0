Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45F25DDE09
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 10:15:37 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Implement atomic{, 64}_{read,
	write}() without volatile
Date: Sat, 11 Aug 2007 02:15:30 +0200
Message-Id: <11867913303733-git-send-email-segher@kernel.crashing.org>
Message-Id: <d6775e129db48371cdf86e94ddfaa1d15617bb8f.1186773842.git.segher@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead, use asm() like all other atomic operations already do.

Also use inline functions instead of macros; this actually
improves code generation (some code becomes a little smaller,
probably because of improved alias information -- just a few
hundred bytes total on a default kernel build, nothing shocking).

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 include/asm-powerpc/atomic.h |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/asm-powerpc/atomic.h b/include/asm-powerpc/atomic.h
index c44810b..bc17506 100644
--- a/include/asm-powerpc/atomic.h
+++ b/include/asm-powerpc/atomic.h
@@ -5,7 +5,7 @@
  * PowerPC atomic operations
  */
 
-typedef struct { volatile int counter; } atomic_t;
+typedef struct { int counter; } atomic_t;
 
 #ifdef __KERNEL__
 #include <linux/compiler.h>
@@ -15,8 +15,19 @@ typedef struct { volatile int counter; } atomic_t;
 
 #define ATOMIC_INIT(i)		{ (i) }
 
-#define atomic_read(v)		((v)->counter)
-#define atomic_set(v,i)		(((v)->counter) = (i))
+static __inline__ int atomic_read(const atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
+
+	return t;
+}
+
+static __inline__ void atomic_set(atomic_t *v, int i)
+{
+	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
+}
 
 static __inline__ void atomic_add(int a, atomic_t *v)
 {
@@ -240,12 +251,23 @@ static __inline__ int atomic_dec_if_positive(atomic_t *v)
 
 #ifdef __powerpc64__
 
-typedef struct { volatile long counter; } atomic64_t;
+typedef struct { long counter; } atomic64_t;
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-#define atomic64_read(v)	((v)->counter)
-#define atomic64_set(v,i)	(((v)->counter) = (i))
+static __inline__ long atomic64_read(const atomic_t *v)
+{
+	long t;
+
+	__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
+
+	return t;
+}
+
+static __inline__ void atomic64_set(atomic_t *v, long i)
+{
+	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
+}
 
 static __inline__ void atomic64_add(long a, atomic64_t *v)
 {
-- 
1.5.2.1.144.gabc40-dirty
