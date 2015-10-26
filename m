Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D90071A0907
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 20:51:44 +1100 (AEDT)
Received: by oigi82 with SMTP id i82so8705354oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 02:51:42 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH tip/locking/core v5 2/6] atomics: Add test for atomic
 operations with _relaxed variants
Date: Mon, 26 Oct 2015 17:50:53 +0800
Message-Id: <1445853057-20735-3-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1445853057-20735-1-git-send-email-boqun.feng@gmail.com>
References: <1445853057-20735-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some atomic operations now have _relaxed/acquire/release variants, this
patch then adds some trivial tests for two purpose:

1.	test the behavior of these new operations in single-CPU
	environment.

2.	make their code generated before we actually use them somewhere,
	so that we can examine their assembly code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/atomic64_test.c | 120 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 79 insertions(+), 41 deletions(-)

diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index 83c33a5b..18e422b 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -27,6 +27,65 @@ do {								\
 		(unsigned long long)r);				\
 } while (0)
 
+/*
+ * Test for a atomic operation family,
+ * @test should be a macro accepting parameters (bit, op, ...)
+ */
+
+#define FAMILY_TEST(test, bit, op, args...)	\
+do {						\
+	test(bit, op, ##args);		\
+	test(bit, op##_acquire, ##args);	\
+	test(bit, op##_release, ##args);	\
+	test(bit, op##_relaxed, ##args);	\
+} while (0)
+
+#define TEST_RETURN(bit, op, c_op, val)				\
+do {								\
+	atomic##bit##_set(&v, v0);				\
+	r = v0;							\
+	r c_op val;						\
+	BUG_ON(atomic##bit##_##op(val, &v) != r);		\
+	BUG_ON(atomic##bit##_read(&v) != r);			\
+} while (0)
+
+#define RETURN_FAMILY_TEST(bit, op, c_op, val)			\
+do {								\
+	FAMILY_TEST(TEST_RETURN, bit, op, c_op, val);		\
+} while (0)
+
+#define TEST_ARGS(bit, op, init, ret, expect, args...)		\
+do {								\
+	atomic##bit##_set(&v, init);				\
+	BUG_ON(atomic##bit##_##op(&v, ##args) != ret);		\
+	BUG_ON(atomic##bit##_read(&v) != expect);		\
+} while (0)
+
+#define XCHG_FAMILY_TEST(bit, init, new)				\
+do {									\
+	FAMILY_TEST(TEST_ARGS, bit, xchg, init, init, new, new);	\
+} while (0)
+
+#define CMPXCHG_FAMILY_TEST(bit, init, new, wrong)			\
+do {									\
+	FAMILY_TEST(TEST_ARGS, bit, cmpxchg, 				\
+			init, init, new, init, new);			\
+	FAMILY_TEST(TEST_ARGS, bit, cmpxchg,				\
+			init, init, init, wrong, new);			\
+} while (0)
+
+#define INC_RETURN_FAMILY_TEST(bit, i)			\
+do {							\
+	FAMILY_TEST(TEST_ARGS, bit, inc_return,		\
+			i, (i) + one, (i) + one);	\
+} while (0)
+
+#define DEC_RETURN_FAMILY_TEST(bit, i)			\
+do {							\
+	FAMILY_TEST(TEST_ARGS, bit, dec_return,		\
+			i, (i) - one, (i) - one);	\
+} while (0)
+
 static __init void test_atomic(void)
 {
 	int v0 = 0xaaa31337;
@@ -45,6 +104,18 @@ static __init void test_atomic(void)
 	TEST(, and, &=, v1);
 	TEST(, xor, ^=, v1);
 	TEST(, andnot, &= ~, v1);
+
+	RETURN_FAMILY_TEST(, add_return, +=, onestwos);
+	RETURN_FAMILY_TEST(, add_return, +=, -one);
+	RETURN_FAMILY_TEST(, sub_return, -=, onestwos);
+	RETURN_FAMILY_TEST(, sub_return, -=, -one);
+
+	INC_RETURN_FAMILY_TEST(, v0);
+	DEC_RETURN_FAMILY_TEST(, v0);
+
+	XCHG_FAMILY_TEST(, v0, v1);
+	CMPXCHG_FAMILY_TEST(, v0, v1, onestwos);
+
 }
 
 #define INIT(c) do { atomic64_set(&v, c); r = c; } while (0)
@@ -74,25 +145,10 @@ static __init void test_atomic64(void)
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
+	RETURN_FAMILY_TEST(64, add_return, +=, onestwos);
+	RETURN_FAMILY_TEST(64, add_return, +=, -one);
+	RETURN_FAMILY_TEST(64, sub_return, -=, onestwos);
+	RETURN_FAMILY_TEST(64, sub_return, -=, -one);
 
 	INIT(v0);
 	atomic64_inc(&v);
@@ -100,33 +156,15 @@ static __init void test_atomic64(void)
 	BUG_ON(v.counter != r);
 
 	INIT(v0);
-	r += one;
-	BUG_ON(atomic64_inc_return(&v) != r);
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
 	atomic64_dec(&v);
 	r -= one;
 	BUG_ON(v.counter != r);
 
-	INIT(v0);
-	r -= one;
-	BUG_ON(atomic64_dec_return(&v) != r);
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	BUG_ON(atomic64_xchg(&v, v1) != v0);
-	r = v1;
-	BUG_ON(v.counter != r);
-
-	INIT(v0);
-	BUG_ON(atomic64_cmpxchg(&v, v0, v1) != v0);
-	r = v1;
-	BUG_ON(v.counter != r);
+	INC_RETURN_FAMILY_TEST(64, v0);
+	DEC_RETURN_FAMILY_TEST(64, v0);
 
-	INIT(v0);
-	BUG_ON(atomic64_cmpxchg(&v, v2, v1) != v0);
-	BUG_ON(v.counter != r);
+	XCHG_FAMILY_TEST(64, v0, v1);
+	CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
 
 	INIT(v0);
 	BUG_ON(atomic64_add_unless(&v, one, v0));
-- 
2.6.2
