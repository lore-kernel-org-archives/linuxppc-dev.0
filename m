Return-Path: <anton@samba.org>
Date: Sat, 26 Mar 2011 08:32:39 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, tsenglin@us.ibm.com
Subject: [PATCH] powerpc: Add Initiate Coprocessor Store Word (icswx) support
Message-ID: <20110326083239.1437c843@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>

Icswx is a PowerPC instruction to send data to a co-processor. On Book-S
processors the LPAR_ID and process ID (PID) of the owning process are
registered in the window context of the co-processor at initialization
time. When the icswx instruction is executed the L2 generates a cop-reg
transaction on PowerBus. The transaction has no address and the
processor does not perform an MMU access to authenticate the transaction.
The co-processor compares the LPAR_ID and the PID included in the
transaction and the LPAR_ID and PID held in the window context to
determine if the process is authorized to generate the transaction.

The OS needs to assign a 16-bit PID for the process. This cop-PID needs
to be updated during context switch. The cop-PID needs to be destroyed
when the context is destroyed.

Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---

This is the v4 patch with a few changes:

- Remove the lazy option. If we see overhead in the context switch path
  we can add it back in once we have the basic patch working and merged.

- Remove comment and ifdef around spinlock forward declaration. We don't
  wrap forward declarations in ifdefs and they are common enough that we
  don't need to explain them individually.

- Check for CPU_FTR_ICSWX in drop_cop. Even though we shouldn't enter with
  mm == active_mm, we export the function and we should avoid doing writes
  to model specific SPRs in any circumstance.

- Convert WARN_ON -> WARN_ON_ONCE in drop_cop.

- Fix comments to be docbook compliant

- Update the Kconfig help text to read a bit better

Index: powerpc.git/arch/powerpc/include/asm/cputable.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/cputable.h	2011-03-22 18:19:30.171445251 +1100
+++ powerpc.git/arch/powerpc/include/asm/cputable.h	2011-03-26 08:15:44.284009603 +1100
@@ -202,6 +202,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0200000000000000)
 #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
+#define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -421,7 +422,8 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
+	    CPU_FTR_ICSWX)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
Index: powerpc.git/arch/powerpc/include/asm/mmu-hash64.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/mmu-hash64.h	2011-03-22 18:19:30.201446386 +1100
+++ powerpc.git/arch/powerpc/include/asm/mmu-hash64.h	2011-03-26 08:15:44.284009603 +1100
@@ -408,6 +408,7 @@ static inline void subpage_prot_init_new
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
 
 typedef unsigned long mm_context_id_t;
+struct spinlock;
 
 typedef struct {
 	mm_context_id_t id;
@@ -423,6 +424,11 @@ typedef struct {
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 	struct subpage_prot_table spt;
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
+#ifdef CONFIG_ICSWX
+	struct spinlock *cop_lockp; /* guard acop and cop_pid */
+	unsigned long acop;	/* mask of enabled coprocessor types */
+	unsigned int cop_pid;	/* pid value used with coprocessors */
+#endif /* CONFIG_ICSWX */
 } mm_context_t;
 
 
Index: powerpc.git/arch/powerpc/include/asm/mmu_context.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/mmu_context.h	2011-03-22 18:19:30.181445622 +1100
+++ powerpc.git/arch/powerpc/include/asm/mmu_context.h	2011-03-26 08:15:44.284009603 +1100
@@ -32,6 +32,10 @@ extern void __destroy_context(unsigned l
 extern void mmu_context_init(void);
 #endif
 
+extern void switch_cop(struct mm_struct *next);
+extern int use_cop(unsigned long acop, struct mm_struct *mm);
+extern void drop_cop(unsigned long acop, struct mm_struct *mm);
+
 /*
  * switch_mm is the entry point called from the architecture independent
  * code in kernel/sched.c
@@ -55,6 +59,12 @@ static inline void switch_mm(struct mm_s
 	if (prev == next)
 		return;
 
+#ifdef CONFIG_ICSWX
+	/* Switch coprocessor context only if prev or next uses a coprocessor */
+	if (prev->context.acop || next->context.acop)
+		switch_cop(next);
+#endif /* CONFIG_ICSWX */
+
 	/* We must stop all altivec streams before changing the HW
 	 * context
 	 */
Index: powerpc.git/arch/powerpc/include/asm/reg.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/reg.h	2011-03-22 18:19:30.211446759 +1100
+++ powerpc.git/arch/powerpc/include/asm/reg.h	2011-03-26 08:15:44.284009603 +1100
@@ -182,6 +182,7 @@
 
 #define SPRN_CTR	0x009	/* Count Register */
 #define SPRN_DSCR	0x11
+#define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
 #define   CTRL_CT	0xc0000000	/* current thread */
Index: powerpc.git/arch/powerpc/mm/mmu_context_hash64.c
===================================================================
--- powerpc.git.orig/arch/powerpc/mm/mmu_context_hash64.c	2011-03-22 18:19:30.161444868 +1100
+++ powerpc.git/arch/powerpc/mm/mmu_context_hash64.c	2011-03-26 08:15:44.284009603 +1100
@@ -20,9 +20,166 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/slab.h>
 
 #include <asm/mmu_context.h>
 
+#ifdef CONFIG_ICSWX
+/*
+ * The processor and its L2 cache cause the icswx instruction to
+ * generate a COP_REQ transaction on PowerBus. The transaction has
+ * no address, and the processor does not perform an MMU access
+ * to authenticate the transaction. The command portion of the
+ * PowerBus COP_REQ transaction includes the LPAR_ID (LPID) and
+ * the coprocessor Process ID (PID), which the coprocessor compares
+ * to the authorized LPID and PID held in the coprocessor, to determine
+ * if the process is authorized to generate the transaction.
+ * The data of the COP_REQ transaction is 128-byte or less and is
+ * placed in cacheable memory on a 128-byte cache line boundary.
+ *
+ * The task to use a coprocessor should use use_cop() to allocate
+ * a coprocessor PID before executing icswx instruction. use_cop()
+ * also enables the coprocessor context switching. Drop_cop() is
+ * used to free the coprocessor PID.
+ *
+ * Example:
+ * Host Fabric Interface (HFI) is a PowerPC network coprocessor.
+ * Each HFI have multiple windows. Each HFI window serves as a
+ * network device sending to and receiving from HFI network.
+ * HFI immediate send function uses icswx instruction. The immediate
+ * send function allows small (single cache-line) packets be sent
+ * without using the regular HFI send FIFO and doorbell, which are
+ * much slower than immediate send.
+ *
+ * For each task intending to use HFI immediate send, the HFI driver
+ * calls use_cop() to obtain a coprocessor PID for the task.
+ * The HFI driver then allocate a free HFI window and save the
+ * coprocessor PID to the HFI window to allow the task to use the
+ * HFI window.
+ *
+ * The HFI driver repeatedly creates immediate send packets and
+ * issues icswx instruction to send data through the HFI window.
+ * The HFI compares the coprocessor PID in the CPU PID register
+ * to the PID held in the HFI window to determine if the transaction
+ * is allowed.
+ *
+ * When the task to release the HFI window, the HFI driver calls
+ * drop_cop() to release the coprocessor PID.
+ */
+
+#define COP_PID_NONE 0
+#define COP_PID_MIN (COP_PID_NONE + 1)
+#define COP_PID_MAX (0xFFFF)
+
+static DEFINE_SPINLOCK(mmu_context_acop_lock);
+static DEFINE_IDA(cop_ida);
+
+void switch_cop(struct mm_struct *next)
+{
+	mtspr(SPRN_PID, next->context.cop_pid);
+	mtspr(SPRN_ACOP, next->context.acop);
+}
+
+static int new_cop_pid(struct ida *ida, int min_id, int max_id,
+		       spinlock_t *lock)
+{
+	int index;
+	int err;
+
+again:
+	if (!ida_pre_get(ida, GFP_KERNEL))
+		return -ENOMEM;
+
+	spin_lock(lock);
+	err = ida_get_new_above(ida, min_id, &index);
+	spin_unlock(lock);
+
+	if (err == -EAGAIN)
+		goto again;
+	else if (err)
+		return err;
+
+	if (index > max_id) {
+		spin_lock(lock);
+		ida_remove(ida, index);
+		spin_unlock(lock);
+		return -ENOMEM;
+	}
+
+	return index;
+}
+
+/**
+ * Start using a coprocessor.
+ * @acop: mask of coprocessor to be used.
+ * @mm: The mm the coprocessor to associate with. Most likely current mm.
+ *
+ * Return a positive PID if successful. Negative errno otherwise.
+ * The returned PID will be fed to the coprocessor to determine if an
+ * icswx transaction is authenticated.
+ */
+int use_cop(unsigned long acop, struct mm_struct *mm)
+{
+	if (!cpu_has_feature(CPU_FTR_ICSWX))
+		return -ENODEV;
+
+	if (!mm || !acop)
+		return -EINVAL;
+
+	spin_lock(mm->context.cop_lockp);
+	if (mm->context.cop_pid == COP_PID_NONE) {
+		int cop_pid;
+
+		cop_pid = new_cop_pid(&cop_ida, COP_PID_MIN, COP_PID_MAX,
+				      &mmu_context_acop_lock);
+		if (cop_pid < 0) {
+			spin_unlock(mm->context.cop_lockp);
+			return cop_pid;
+		}
+		mm->context.cop_pid = cop_pid;
+		if (mm == current->active_mm)
+			mtspr(SPRN_PID, mm->context.cop_pid);
+	}
+	mm->context.acop |= acop;
+	if (mm == current->active_mm)
+		mtspr(SPRN_ACOP, mm->context.acop);
+	spin_unlock(mm->context.cop_lockp);
+
+	return mm->context.cop_pid;
+}
+EXPORT_SYMBOL_GPL(use_cop);
+
+/**
+ * Stop using a coprocessor.
+ * @acop: mask of coprocessor to be stopped.
+ * @mm: The mm the coprocessor associated with.
+ */
+void drop_cop(unsigned long acop, struct mm_struct *mm)
+{
+	if (!cpu_has_feature(CPU_FTR_ICSWX))
+		return;
+
+	if (WARN_ON_ONCE(!mm))
+		return;
+
+	spin_lock(mm->context.cop_lockp);
+	mm->context.acop &= ~acop;
+	if (mm == current->active_mm)
+		mtspr(SPRN_ACOP, mm->context.acop);
+	if ((!mm->context.acop) && (mm->context.cop_pid != COP_PID_NONE)) {
+		spin_lock(&mmu_context_acop_lock);
+		ida_remove(&cop_ida, mm->context.cop_pid);
+		spin_unlock(&mmu_context_acop_lock);
+		mm->context.cop_pid = COP_PID_NONE;
+		if (mm == current->active_mm)
+			mtspr(SPRN_PID, mm->context.cop_pid);
+	}
+	spin_unlock(mm->context.cop_lockp);
+}
+EXPORT_SYMBOL_GPL(drop_cop);
+
+#endif /* CONFIG_ICSWX */
+
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
@@ -79,6 +236,16 @@ int init_new_context(struct task_struct
 		slice_set_user_psize(mm, mmu_virtual_psize);
 	subpage_prot_init_new_context(mm);
 	mm->context.id = index;
+#ifdef CONFIG_ICSWX
+	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
+	if (!mm->context.cop_lockp) {
+		__destroy_context(index);
+		subpage_prot_free(mm);
+		mm->context.id = NO_CONTEXT;
+		return -ENOMEM;
+	}
+	spin_lock_init(mm->context.cop_lockp);
+#endif /* CONFIG_ICSWX */
 
 	return 0;
 }
@@ -93,6 +260,11 @@ EXPORT_SYMBOL_GPL(__destroy_context);
 
 void destroy_context(struct mm_struct *mm)
 {
+#ifdef CONFIG_ICSWX
+	drop_cop(mm->context.acop, mm);
+	kfree(mm->context.cop_lockp);
+	mm->context.cop_lockp = NULL;
+#endif /* CONFIG_ICSWX */
 	__destroy_context(mm->context.id);
 	subpage_prot_free(mm);
 	mm->context.id = NO_CONTEXT;
Index: powerpc.git/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/Kconfig.cputype	2011-03-22 18:19:30.231447511 +1100
+++ powerpc.git/arch/powerpc/platforms/Kconfig.cputype	2011-03-26 08:30:51.589270860 +1100
@@ -226,6 +226,24 @@ config VSX
 
 	  If in doubt, say Y here.
 
+config ICSWX
+	bool "Support for PowerPC icswx coprocessor instruction"
+	depends on POWER4
+	default n
+	---help---
+
+	  This option enables kernel support for the PowerPC Initiate
+	  Coprocessor Store Word (icswx) coprocessor instruction on POWER7
+	  or newer processors.
+
+	  This option is only useful if you have a processor that supports
+	  the icswx coprocessor instruction. It does not have any effect
+	  on processors without the icswx coprocessor instruction.
+
+	  This option slightly increases kernel memory usage.
+
+	  If in doubt, say N here.
+
 config SPE
 	bool "SPE Support"
 	depends on E200 || (E500 && !PPC_E500MC)
