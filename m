Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfCzS75LlzDsjB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 18:51:48 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id hi10so2020816pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 01:51:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] percpu: improve generic percpu modify-return implementation
Date: Wed, 21 Sep 2016 18:51:37 +1000
Message-Id: <20160921085137.862-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some architectures require an additional load to find the address of
percpu pointers. In some implemenatations, the C aliasing rules do not
allow the result of that load to be kept over the store that modifies
the percpu variable, which causes additional loads.

Work around this by finding the pointer first, then operating on that.

It's also possible to mark things as restrict and those kind of games,
but that can require larger and arch specific changes.

On powerpc, __this_cpu_inc_return compiles to:

        ld 10,48(13)
        ldx 9,3,10
        addi 9,9,1
        stdx 9,3,10
        ld 9,48(13)
        ldx 3,9,3

With this patch it saves 2 loads:

        ld 10,48(13)
        ldx 9,3,10
        addi 9,9,1
        stdx 9,3,10

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/asm-generic/percpu.h | 54 +++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 4d9f233..3fe18fe 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -65,6 +65,11 @@ extern void setup_per_cpu_areas(void);
 #define PER_CPU_DEF_ATTRIBUTES
 #endif
 
+#define raw_cpu_generic_read(pcp)					\
+({									\
+	*raw_cpu_ptr(&(pcp));						\
+})
+
 #define raw_cpu_generic_to_op(pcp, val, op)				\
 do {									\
 	*raw_cpu_ptr(&(pcp)) op val;					\
@@ -72,34 +77,39 @@ do {									\
 
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	raw_cpu_add(pcp, val);						\
-	raw_cpu_read(pcp);						\
+	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+									\
+	*__p += val;							\
+	*__p;								\
 })
 
 #define raw_cpu_generic_xchg(pcp, nval)					\
 ({									\
+	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
 	typeof(pcp) __ret;						\
-	__ret = raw_cpu_read(pcp);					\
-	raw_cpu_write(pcp, nval);					\
+	__ret = *__p;							\
+	*__p = nval;							\
 	__ret;								\
 })
 
 #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
+	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
 	typeof(pcp) __ret;						\
-	__ret = raw_cpu_read(pcp);					\
+	__ret = *__p;							\
 	if (__ret == (oval))						\
-		raw_cpu_write(pcp, nval);				\
+		*__p = nval;						\
 	__ret;								\
 })
 
 #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 ({									\
+	typeof(&(pcp1)) __p1 = raw_cpu_ptr(&(pcp1));			\
+	typeof(&(pcp2)) __p2 = raw_cpu_ptr(&(pcp2));			\
 	int __ret = 0;							\
-	if (raw_cpu_read(pcp1) == (oval1) &&				\
-			 raw_cpu_read(pcp2)  == (oval2)) {		\
-		raw_cpu_write(pcp1, nval1);				\
-		raw_cpu_write(pcp2, nval2);				\
+	if (*__p1 == (oval1) && *__p2  == (oval2)) {			\
+		*__p1 = nval1;						\
+		*__p2 = nval2;						\
 		__ret = 1;						\
 	}								\
 	(__ret);							\
@@ -109,7 +119,7 @@ do {									\
 ({									\
 	typeof(pcp) __ret;						\
 	preempt_disable();						\
-	__ret = *this_cpu_ptr(&(pcp));					\
+	__ret = raw_cpu_generic_read(pcp);				\
 	preempt_enable();						\
 	__ret;								\
 })
@@ -118,17 +128,18 @@ do {									\
 do {									\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
-	*raw_cpu_ptr(&(pcp)) op val;					\
+	raw_cpu_generic_to_op(pcp, val, op);				\
 	raw_local_irq_restore(__flags);					\
 } while (0)
 
+
 #define this_cpu_generic_add_return(pcp, val)				\
 ({									\
+	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
 	typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
-	raw_cpu_add(pcp, val);						\
-	__ret = raw_cpu_read(pcp);					\
+	__ret = raw_cpu_generic_add_return(pcp, val);			\
 	raw_local_irq_restore(__flags);					\
 	__ret;								\
 })
@@ -138,8 +149,7 @@ do {									\
 	typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
-	__ret = raw_cpu_read(pcp);					\
-	raw_cpu_write(pcp, nval);					\
+	__ret = raw_cpu_generic_xchg(pcp);				\
 	raw_local_irq_restore(__flags);					\
 	__ret;								\
 })
@@ -149,9 +159,7 @@ do {									\
 	typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
-	__ret = raw_cpu_read(pcp);					\
-	if (__ret == (oval))						\
-		raw_cpu_write(pcp, nval);				\
+	__ret = raw_cpu_generic_cmpxchg(pcp, oval, nval);		\
 	raw_local_irq_restore(__flags);					\
 	__ret;								\
 })
@@ -168,16 +176,16 @@ do {									\
 })
 
 #ifndef raw_cpu_read_1
-#define raw_cpu_read_1(pcp)		(*raw_cpu_ptr(&(pcp)))
+#define raw_cpu_read_1(pcp)		raw_cpu_generic_read(pcp)
 #endif
 #ifndef raw_cpu_read_2
-#define raw_cpu_read_2(pcp)		(*raw_cpu_ptr(&(pcp)))
+#define raw_cpu_read_2(pcp)		raw_cpu_generic_read(pcp)
 #endif
 #ifndef raw_cpu_read_4
-#define raw_cpu_read_4(pcp)		(*raw_cpu_ptr(&(pcp)))
+#define raw_cpu_read_4(pcp)		raw_cpu_generic_read(pcp)
 #endif
 #ifndef raw_cpu_read_8
-#define raw_cpu_read_8(pcp)		(*raw_cpu_ptr(&(pcp)))
+#define raw_cpu_read_8(pcp)		raw_cpu_generic_read(pcp)
 #endif
 
 #ifndef raw_cpu_write_1
-- 
2.9.3
