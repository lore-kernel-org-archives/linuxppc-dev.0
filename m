Return-Path: <anton@samba.org>
Date: Mon, 18 Apr 2011 11:36:38 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, tsenglin@us.ibm.com
Subject: [PATCH] powerpc: Add Initiate Coprocessor Store Word (icswx) support
Message-ID: <20110418113638.29c0bc85@kryten>
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

Changes:

- By including linux/spinlock_types.h we can remove the dynamic allocation
  of the spinlock hack and simplify things a lot.

- We had a nasty bug with threaded applications. We weren't ensuring all
  running threads saw the updates from a use_cop or drop_cop call. We
  could even reuse an active PID if one threaded app did a drop_cop and had
  other running threads. In that case we return the PID to the pool even
  though some running threads are using it. We now call sync_cop() on all
  cpus if the app is threaded, ensuring everyone sees the updates of
  a use_cop or drop_cop call.

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index be3cdf9..c56e2df 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -202,6 +202,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0200000000000000)
 #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
+#define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -421,7 +422,8 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
+	    CPU_FTR_ICSWX)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index ae7b3ef..2d4266c 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -32,6 +32,8 @@
 #define STAB0_PHYS_ADDR	(STAB0_OFFSET + PHYSICAL_START)
 
 #ifndef __ASSEMBLY__
+#include <linux/spinlock_types.h>
+
 extern char initial_stab[];
 #endif /* ! __ASSEMBLY */
 
@@ -423,6 +425,11 @@ typedef struct {
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 	struct subpage_prot_table spt;
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
+#ifdef CONFIG_PPC_ICSWX
+	struct spinlock cop_lock; /* guard acop and cop_pid */
+	unsigned long acop;	/* mask of enabled coprocessor types */
+	unsigned int cop_pid;	/* pid value used with coprocessors */
+#endif /* CONFIG_PPC_ICSWX */
 } mm_context_t;
 
 
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 81fb412..d13ae21 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -32,6 +32,10 @@ extern void __destroy_context(unsigned long context_id);
 extern void mmu_context_init(void);
 #endif
 
+extern void switch_cop(struct mm_struct *next);
+extern int use_cop(unsigned long acop, struct mm_struct *mm);
+extern void drop_cop(unsigned long acop, struct mm_struct *mm);
+
 /*
  * switch_mm is the entry point called from the architecture independent
  * code in kernel/sched.c
@@ -55,6 +59,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	if (prev == next)
 		return;
 
+#ifdef CONFIG_PPC_ICSWX
+	/* Switch coprocessor context only if prev or next uses a coprocessor */
+	if (prev->context.acop || next->context.acop)
+		switch_cop(next);
+#endif /* CONFIG_PPC_ICSWX */
+
 	/* We must stop all altivec streams before changing the HW
 	 * context
 	 */
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7e4abeb..e9316bc 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -182,6 +182,7 @@
 
 #define SPRN_CTR	0x009	/* Count Register */
 #define SPRN_DSCR	0x11
+#define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
 #define   CTRL_CT	0xc0000000	/* current thread */
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 2535828..f21d5f5 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -20,9 +20,205 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/slab.h>
 
 #include <asm/mmu_context.h>
 
+#ifdef CONFIG_PPC_ICSWX
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
+static void sync_cop(void *arg)
+{
+	struct mm_struct *mm = arg;
+
+	if (mm == current->active_mm)
+		switch_cop(current->active_mm);
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
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_ICSWX))
+		return -ENODEV;
+
+	if (!mm || !acop)
+		return -EINVAL;
+
+	/* We need to make sure mm_users doesn't change */
+	down_read(&mm->mmap_sem);
+	spin_lock(&mm->context.cop_lock);
+
+	if (mm->context.cop_pid == COP_PID_NONE) {
+		ret = new_cop_pid(&cop_ida, COP_PID_MIN, COP_PID_MAX,
+				  &mmu_context_acop_lock);
+		if (ret < 0)
+			goto out;
+
+		mm->context.cop_pid = ret;
+	}
+	mm->context.acop |= acop;
+
+	sync_cop(mm);
+
+	/*
+	 * If this is a threaded process then there might be other threads
+	 * running. We need to send an IPI to force them to pick up any
+	 * change in PID and ACOP.
+	 */
+	if (atomic_read(&mm->mm_users) > 1)
+		smp_call_function(sync_cop, mm, 1);
+
+	ret = mm->context.cop_pid;
+
+out:
+	spin_unlock(&mm->context.cop_lock);
+	up_read(&mm->mmap_sem);
+
+	return ret;
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
+	int free_pid = COP_PID_NONE;
+
+	if (!cpu_has_feature(CPU_FTR_ICSWX))
+		return;
+
+	if (WARN_ON_ONCE(!mm))
+		return;
+
+	/* We need to make sure mm_users doesn't change */
+	down_read(&mm->mmap_sem);
+	spin_lock(&mm->context.cop_lock);
+
+	mm->context.acop &= ~acop;
+
+	if ((!mm->context.acop) && (mm->context.cop_pid != COP_PID_NONE)) {
+		free_pid = mm->context.cop_pid;
+		mm->context.cop_pid = COP_PID_NONE;
+	}
+
+	sync_cop(mm);
+
+	/*
+	 * If this is a threaded process then there might be other threads
+	 * running. We need to send an IPI to force them to pick up any
+	 * change in PID and ACOP.
+	 */
+	if (atomic_read(&mm->mm_users) > 1)
+		smp_call_function(sync_cop, mm, 1);
+
+	if (free_pid != COP_PID_NONE) {
+		spin_lock(&mmu_context_acop_lock);
+		ida_remove(&cop_ida, free_pid);
+		spin_unlock(&mmu_context_acop_lock);
+	}
+
+	spin_unlock(&mm->context.cop_lock);
+	up_read(&mm->mmap_sem);
+}
+EXPORT_SYMBOL_GPL(drop_cop);
+
+#endif /* CONFIG_PPC_ICSWX */
+
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
@@ -79,6 +275,9 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 		slice_set_user_psize(mm, mmu_virtual_psize);
 	subpage_prot_init_new_context(mm);
 	mm->context.id = index;
+#ifdef CONFIG_PPC_ICSWX
+	spin_lock_init(&mm->context.cop_lock);
+#endif /* CONFIG_PPC_ICSWX */
 
 	return 0;
 }
@@ -93,6 +292,9 @@ EXPORT_SYMBOL_GPL(__destroy_context);
 
 void destroy_context(struct mm_struct *mm)
 {
+#ifdef CONFIG_PPC_ICSWX
+	drop_cop(mm->context.acop, mm);
+#endif /* CONFIG_PPC_ICSWX */
 	__destroy_context(mm->context.id);
 	subpage_prot_free(mm);
 	mm->context.id = NO_CONTEXT;
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 111138c..1c1fb9a 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -226,6 +226,24 @@ config VSX
 
 	  If in doubt, say Y here.
 
+config PPC_ICSWX
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
