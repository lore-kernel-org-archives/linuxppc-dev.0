Return-Path: <mikey@neuling.org>
Message-Id: <20101206234050.138910004@neuling.org>
Date: Tue, 07 Dec 2010 10:40:46 +1100
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC/PATCH 3/7] powerpc: Reorganise powerpc include files to make
	call_single_data
References: <20101206234043.083045003@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to put struct call_single_data in the powerpc thread_struct,
but can't without this.  

In processor.h this moves up the prefetch() functions before the
#include of types.h to ensure __builtin_prefetch doesn't get defined
twice.

Similarly in hw_irq.h move arch_irqs_disabled_flags() to before the
#include of processor.h to ensure it's correctly found when hw_irq.h
has already been included somewhere earlier

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hw_irq.h    |   21 ++++++++------
 arch/powerpc/include/asm/processor.h |   52 ++++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 33 deletions(-)

Index: linux-lazy/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/hw_irq.h
+++ linux-lazy/arch/powerpc/include/asm/hw_irq.h
@@ -8,10 +8,6 @@
 
 #include <linux/errno.h>
 #include <linux/compiler.h>
-#include <asm/ptrace.h>
-#include <asm/processor.h>
-
-extern void timer_interrupt(struct pt_regs *);
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -81,6 +77,8 @@
 
 #else /* CONFIG_PPC64 */
 
+#include <asm/reg.h>
+
 #define SET_MSR_EE(x)	mtmsr(x)
 
 static inline unsigned long arch_local_save_flags(void)
@@ -108,6 +106,16 @@
 	return flags;
 }
 
+static inline bool arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (flags & MSR_EE) == 0;
+}
+
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+
+extern void timer_interrupt(struct pt_regs *);
+
 static inline void arch_local_irq_disable(void)
 {
 #ifdef CONFIG_BOOKE
@@ -127,11 +135,6 @@
 #endif
 }
 
-static inline bool arch_irqs_disabled_flags(unsigned long flags)
-{
-	return (flags & MSR_EE) == 0;
-}
-
 static inline bool arch_irqs_disabled(void)
 {
 	return arch_irqs_disabled_flags(arch_local_save_flags());
Index: linux-lazy/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-lazy.orig/arch/powerpc/include/asm/processor.h
+++ linux-lazy/arch/powerpc/include/asm/processor.h
@@ -20,6 +20,34 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
+
+struct thread_struct;
+
+/*
+ * Prefetch macros.
+ */
+#define ARCH_HAS_PREFETCH
+#define ARCH_HAS_PREFETCHW
+#define ARCH_HAS_SPINLOCK_PREFETCH
+
+static inline void prefetch(const void *x)
+{
+	if (unlikely(!x))
+		return;
+
+	__asm__ __volatile__ ("dcbt 0,%0" : : "r" (x));
+}
+
+static inline void prefetchw(const void *x)
+{
+	if (unlikely(!x))
+		return;
+
+	__asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
+}
+
+#define spin_lock_prefetch(x)	prefetchw(x)
+
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
@@ -327,30 +355,6 @@
 int validate_sp(unsigned long sp, struct task_struct *p,
                        unsigned long nbytes);
 
-/*
- * Prefetch macros.
- */
-#define ARCH_HAS_PREFETCH
-#define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
-
-static inline void prefetch(const void *x)
-{
-	if (unlikely(!x))
-		return;
-
-	__asm__ __volatile__ ("dcbt 0,%0" : : "r" (x));
-}
-
-static inline void prefetchw(const void *x)
-{
-	if (unlikely(!x))
-		return;
-
-	__asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
-}
-
-#define spin_lock_prefetch(x)	prefetchw(x)
 
 #ifdef CONFIG_PPC64
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
