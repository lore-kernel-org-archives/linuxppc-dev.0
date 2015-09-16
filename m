Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x234.google.com (mail-ob0-x234.google.com
 [IPv6:2607:f8b0:4003:c01::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E93E1A069B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 01:50:07 +1000 (AEST)
Received: by obbzf10 with SMTP id zf10so96800095obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 08:50:04 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 1/7] atomics: Add test for atomic operations with _relaxed
 variants
Date: Wed, 16 Sep 2015 23:49:29 +0800
Message-Id: <1442418575-12297-2-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some atomic operations now have _{relaxed, acquire, release} variants,
this patch then adds some trivial tests for two purpose:

1.	test the behavior of these new operations in single-CPU
	environment.
2.	make their code generated before we actually use them somewhere,
	so that we can examine their assembly code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/atomic64_test.c | 91 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 32 deletions(-)

diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index 83c33a5b..0484437 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -27,6 +27,50 @@ do {								\
 		(unsigned long long)r);				\
 } while (0)
 
+#define TEST_RETURN(bit, op, c_op, val)				\
+do {								\
+	atomic##bit##_set(&v, v0);				\
+	r = v0;							\
+	r c_op val;						\
+	BUG_ON(atomic##bit##_##op(val, &v) != r);		\
+	BUG_ON(atomic##bit##_read(&v) != r);			\
+} while (0)
+
+#define TEST_RETURN_FAMILY(bit, op, c_op, val)			\
+do {								\
+	TEST_RETURN(bit, op, c_op, val);			\
+	TEST_RETURN(bit, op##_acquire, c_op, val);		\
+	TEST_RETURN(bit, op##_release, c_op, val);		\
+	TEST_RETURN(bit, op##_relaxed, c_op, val);		\
+} while (0)
+
+#define TEST_ARGS(bit, op, init, ret, expect, args...)		\
+do {								\
+	atomic##bit##_set(&v, init);				\
+	BUG_ON(atomic##bit##_##op(&v, args) != ret);		\
+	BUG_ON(atomic##bit##_read(&v) != expect);		\
+} while (0)
+
+#define TEST_XCHG_FAMILY(bit, init, new)			\
+do {								\
+	TEST_ARGS(bit, xchg, init, init, new, new);		\
+	TEST_ARGS(bit, xchg_acquire, init, init, new, new);	\
+	TEST_ARGS(bit, xchg_release, init, init, new, new);	\
+	TEST_ARGS(bit, xchg_relaxed, init, init, new, new);	\
+} while (0)
+
+#define TEST_CMPXCHG_FAMILY(bit, init, new, wrong)			\
+do {									\
+	TEST_ARGS(bit, cmpxchg, init, init, new, init, new);		\
+	TEST_ARGS(bit, cmpxchg, init, init, init, wrong, new);		\
+	TEST_ARGS(bit, cmpxchg_acquire, init, init, new, init, new);	\
+	TEST_ARGS(bit, cmpxchg_acquire, init, init, init, wrong, new);	\
+	TEST_ARGS(bit, cmpxchg_release, init, init, new, init, new);	\
+	TEST_ARGS(bit, cmpxchg_release, init, init, init, wrong, new);	\
+	TEST_ARGS(bit, cmpxchg_relaxed, init, init, new, init, new);	\
+	TEST_ARGS(bit, cmpxchg_relaxed, init, init, init, wrong, new);	\
+} while (0)
+
 static __init void test_atomic(void)
 {
 	int v0 = 0xaaa31337;
@@ -45,6 +89,15 @@ static __init void test_atomic(void)
 	TEST(, and, &=, v1);
 	TEST(, xor, ^=, v1);
 	TEST(, andnot, &= ~, v1);
+
+	TEST_RETURN_FAMILY(, add_return, +=, onestwos);
+	TEST_RETURN_FAMILY(, add_return, +=, -one);
+	TEST_RETURN_FAMILY(, sub_return, -=, onestwos);
+	TEST_RETURN_FAMILY(, sub_return, -=, -one);
+
+	TEST_XCHG_FAMILY(, v0, v1);
+	TEST_CMPXCHG_FAMILY(, v0, v1, onestwos);
+
 }
 
 #define INIT(c) do { atomic64_set(&v, c); r = c; } while (0)
@@ -74,25 +127,10 @@ static __init void test_atomic64(void)
 	TEST(64, xor, ^=, v1);
 	TEST(64, andnot, &= ~, v1);
 
-	INIT(v0);
-	r += onestwos;
-	BUG_ON(atomic64_add_return(onestwos, &v) != r);
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	r += -one;
-	BUG_ON(atomic64_add_return(-one, &v) != r);
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	r -= onestwos;
-	BUG_ON(atomic64_sub_return(onestwos, &v) != r);
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	r -= -one;
-	BUG_ON(atomic64_sub_return(-one, &v) != r);
-	BUG_ON(v.counter != r);
+	TEST_RETURN_FAMILY(64, add_return, +=, onestwos);
+	TEST_RETURN_FAMILY(64, add_return, +=, -one);
+	TEST_RETURN_FAMILY(64, sub_return, -=, onestwos);
+	TEST_RETURN_FAMILY(64, sub_return, -=, -one);
 
 	INIT(v0);
 	atomic64_inc(&v);
@@ -114,19 +152,8 @@ static __init void test_atomic64(void)
 	BUG_ON(atomic64_dec_return(&v) != r);
 	BUG_ON(v.counter != r);
 
-	INIT(v0);
-	BUG_ON(atomic64_xchg(&v, v1) != v0);
-	r = v1;
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	BUG_ON(atomic64_cmpxchg(&v, v0, v1) != v0);
-	r = v1;
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	BUG_ON(atomic64_cmpxchg(&v, v2, v1) != v0);
-	BUG_ON(v.counter != r);
+	TEST_XCHG_FAMILY(64, v0, v1);
+	TEST_CMPXCHG_FAMILY(64, v0, v1, v2);
 
 	INIT(v0);
 	BUG_ON(atomic64_add_unless(&v, one, v0));
-- 
2.5.1
