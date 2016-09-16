Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb8Lv1zx7zDsZk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 18:57:59 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id vz6so3240256pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 01:57:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Fri, 16 Sep 2016 18:57:36 +1000
Message-Id: <20160916085736.7857-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implementing busy wait loops with cpu_relax() in callers poses
some difficulties for powerpc.

First, we want to put our SMT thread into a low priority mode for the
duration of the loop, but then return to normal priority after exiting
the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
cpu_relax() does may have HMT_medium take effect before HMT_low made
any (or much) difference.

Second, it can be beneficial for some implementations to spin on the
exit condition with a statically predicted-not-taken branch (i.e.,
always predict the loop will exit).

This is a quick RFC with a couple of users converted to see what
people think. I don't use a C branch with hints, because we don't want
the compiler moving the loop body out of line, which makes it a bit
messy unfortunately. If there's a better way to do it, I'm all ears.

I would not propose to switch all callers immediately, just some
core synchronisation primitives.

---
 arch/powerpc/include/asm/processor.h | 22 ++++++++++++++++++++++
 include/asm-generic/barrier.h        |  7 ++-----
 include/linux/bit_spinlock.h         |  5 ++---
 include/linux/cgroup.h               |  7 ++-----
 include/linux/seqlock.h              | 10 ++++------
 5 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 68e3bf5..e10aee2 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -402,6 +402,28 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #ifdef CONFIG_PPC64
 #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+
+#define spin_do						\
+do {							\
+	HMT_low();					\
+	__asm__ __volatile__ (	"1010:");
+
+#define spin_while(cond)				\
+	barrier();					\
+	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
+				"beq-	1010b	\n\t"	\
+				: : "r" (cond));	\
+	HMT_medium();					\
+} while (0)
+
+#define spin_until(cond)				\
+	barrier();					\
+	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
+				"bne-	1010b	\n\t"	\
+				: : "r" (cond));	\
+	HMT_medium();					\
+} while (0)
+
 #else
 #define cpu_relax()	barrier()
 #endif
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index fe297b5..4c53b3a 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -235,12 +235,9 @@ do {									\
 #define smp_cond_load_acquire(ptr, cond_expr) ({		\
 	typeof(ptr) __PTR = (ptr);				\
 	typeof(*ptr) VAL;					\
-	for (;;) {						\
+	spin_do {						\
 		VAL = READ_ONCE(*__PTR);			\
-		if (cond_expr)					\
-			break;					\
-		cpu_relax();					\
-	}							\
+	} spin_until (cond_expr);				\
 	smp_acquire__after_ctrl_dep();				\
 	VAL;							\
 })
diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index 3b5bafc..695743c 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -25,9 +25,8 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
 		preempt_enable();
-		do {
-			cpu_relax();
-		} while (test_bit(bitnum, addr));
+		spin_do {
+		} spin_while (test_bit(bitnum, addr));
 		preempt_disable();
 	}
 #endif
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 984f73b..e7d395f 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -450,12 +450,9 @@ task_get_css(struct task_struct *task, int subsys_id)
 	struct cgroup_subsys_state *css;
 
 	rcu_read_lock();
-	while (true) {
+	spin_do {
 		css = task_css(task, subsys_id);
-		if (likely(css_tryget_online(css)))
-			break;
-		cpu_relax();
-	}
+	} spin_until (likely(css_tryget_online(css)));
 	rcu_read_unlock();
 	return css;
 }
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index ead9765..93ed609 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -108,12 +108,10 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret;
 
-repeat:
-	ret = READ_ONCE(s->sequence);
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
+	spin_do {
+		ret = READ_ONCE(s->sequence);
+	} spin_while (unlikely(ret & 1));
+
 	return ret;
 }
 
-- 
2.9.3
