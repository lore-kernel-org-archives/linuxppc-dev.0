Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRf5PYfzF08c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:30 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id j9so12000727pgc.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 4/8] powerpc/64s: put io_sync bit into r14
Date: Thu, 21 Dec 2017 00:52:02 +1000
Message-Id: <20171220145206.12234-5-npiggin@gmail.com>
In-Reply-To: <20171220145206.12234-1-npiggin@gmail.com>
References: <20171220145206.12234-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This simplifies spin unlock code and mmio primitives. This
may not be the best use of an r14 bit, but it was a simple
first proof of concept after the per-cpu data_offset, and
so it can stay until we get low on bits.
---
 arch/powerpc/include/asm/io.h       | 11 ++++------
 arch/powerpc/include/asm/paca.h     | 44 ++++++++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/spinlock.h | 21 ++++++++++--------
 arch/powerpc/xmon/xmon.c            |  1 -
 4 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 422f99cf9924..c817f3a83fcc 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -104,8 +104,8 @@ extern bool isa_io_special;
  *
  */
 
-#ifdef CONFIG_PPC64
-#define IO_SET_SYNC_FLAG()	do { local_paca->io_sync = 1; } while(0)
+#if defined(CONFIG_PPC64) && defined(CONFIG_SMP)
+#define IO_SET_SYNC_FLAG()	do { r14_set_bits(R14_BIT_IO_SYNC); } while(0)
 #else
 #define IO_SET_SYNC_FLAG()
 #endif
@@ -673,11 +673,8 @@ static inline void name at					\
  */
 static inline void mmiowb(void)
 {
-	unsigned long tmp;
-
-	__asm__ __volatile__("sync; li %0,0; stb %0,%1(13)"
-	: "=&r" (tmp) : "i" (offsetof(struct paca_struct, io_sync))
-	: "memory");
+	__asm__ __volatile__("sync" : : : "memory");
+	r14_clear_bits(R14_BIT_IO_SYNC);
 }
 #endif /* !CONFIG_PPC32 */
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 4dd4ac69e84f..408fa079e00d 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -35,12 +35,55 @@
 
 register struct paca_struct *local_paca asm("r13");
 #ifdef CONFIG_PPC_BOOK3S
+
+#define R14_BIT_IO_SYNC	0x0001
+
 /*
  * The top 32-bits of r14 is used as the per-cpu offset, shifted by PAGE_SHIFT.
  * The per-cpu could be moved completely to vmalloc space if we had large
  * vmalloc page mapping? (no, must access it in real mode).
  */
 register u64 local_r14 asm("r14");
+
+/*
+ * r14 should not be modified by C code, because we can not guarantee it
+ * will be done with non-atomic (vs interrupts) read-modify-write sequences.
+ * All updates must be of the form `op r14,r14,xxx` or similar (i.e., atomic
+ * updates).
+ *
+ * Make asm statements have r14 for input and output so that the compiler
+ * does not re-order it with respect to other r14 manipulations.
+ */
+static inline void r14_set_bits(unsigned long mask)
+{
+	if (__builtin_constant_p(mask))
+		asm volatile("ori	%0,%0,%2\n"
+				: "=r" (local_r14)
+				: "0" (local_r14), "i" (mask));
+	else
+		asm volatile("or	%0,%0,%2\n"
+				: "=r" (local_r14)
+				: "0" (local_r14), "r" (mask));
+}
+
+static inline void r14_flip_bits(unsigned long mask)
+{
+	if (__builtin_constant_p(mask))
+		asm volatile("xori	%0,%0,%2\n"
+				: "=r" (local_r14)
+				: "0" (local_r14), "i" (mask));
+	else
+		asm volatile("xor	%0,%0,%2\n"
+				: "=r" (local_r14)
+				: "0" (local_r14), "r" (mask));
+}
+
+static inline void r14_clear_bits(unsigned long mask)
+{
+	asm volatile("andc	%0,%0,%2\n"
+			: "=r" (local_r14)
+			: "0" (local_r14), "r" (mask));
+}
 #endif
 
 #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
@@ -169,7 +212,6 @@ struct paca_struct {
 	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 irq_soft_mask;		/* mask for irq soft masking */
 	u8 irq_happened;		/* irq happened while soft-disabled */
-	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
 	u64 sprg_vdso;			/* Saved user-visible sprg */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index b9ebc3085fb7..182bb9304c79 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -40,16 +40,9 @@
 #endif
 
 #if defined(CONFIG_PPC64) && defined(CONFIG_SMP)
-#define CLEAR_IO_SYNC	(get_paca()->io_sync = 0)
-#define SYNC_IO		do {						\
-				if (unlikely(get_paca()->io_sync)) {	\
-					mb();				\
-					get_paca()->io_sync = 0;	\
-				}					\
-			} while (0)
+#define CLEAR_IO_SYNC	do { r14_clear_bits(R14_BIT_IO_SYNC); } while(0)
 #else
 #define CLEAR_IO_SYNC
-#define SYNC_IO
 #endif
 
 #ifdef CONFIG_PPC_PSERIES
@@ -165,9 +158,19 @@ void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	SYNC_IO;
+#if defined(CONFIG_PPC64) && defined(CONFIG_SMP)
+	bool io_sync = local_r14 & R14_BIT_IO_SYNC;
+	if (unlikely(io_sync)) {
+		mb();
+		CLEAR_IO_SYNC;
+	} else {
+		__asm__ __volatile__("# arch_spin_unlock\n\t"
+				PPC_RELEASE_BARRIER: : :"memory");
+	}
+#else
 	__asm__ __volatile__("# arch_spin_unlock\n\t"
 				PPC_RELEASE_BARRIER: : :"memory");
+#endif
 	lock->slock = 0;
 }
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a53454f61d09..40f0d02ae92d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2393,7 +2393,6 @@ static void dump_one_paca(int cpu)
 	DUMP(p, trap_save, "x");
 	DUMP(p, irq_soft_mask, "x");
 	DUMP(p, irq_happened, "x");
-	DUMP(p, io_sync, "x");
 	DUMP(p, irq_work_pending, "x");
 	DUMP(p, nap_state_lost, "x");
 	DUMP(p, sprg_vdso, "llx");
-- 
2.15.0
