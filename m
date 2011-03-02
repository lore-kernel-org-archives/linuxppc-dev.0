Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 16324B715F
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2011 04:20:58 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p22HFj9A011785
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 10:15:45 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p22HKuUE117198
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 10:20:56 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p22HKt1V002930
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Mar 2011 10:20:55 -0700
Subject: [PATCH v4 2/2] add icswx support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 11:20:54 -0600
Message-ID: <1299086454.28840.10.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Icswx is a PowerPC co-processor instruction to send data to a
co-processor. On Book-S processors the LPAR_ID and process ID (PID) of
the owning process are registered in the window context of the
co-processor at initial time. When the icswx instruction is executed,
the L2 generates a cop-reg transaction on PowerBus. The transaction has
no address and the processor does not perform an MMU access to
authenticate the transaction. The coprocessor compares the LPAR_ID and
the PID included in the transaction and the LPAR_ID and PID held in the
window context to determine if the process is authorized to generate the
transaction.

The OS needs to assign a 16-bit PID for the process. This cop-PID needs
to be updated during context switch. The cop-PID needs to be destroied
when the context is destroied.

Change log from V3:
- Rebase to linux/kernel/git/next/linux-next.git 2011-02-28
- Move the SPRN_PID changes into a separate patch.
- (Unchanged) Not to make icswx a cpu_user_feature as the icswx support
  is to be used by coprocessor drivers only.

arch/powerpc/platforms/Kconfig.cputype:
- Add ICSWX_LAZY_SWITCH

arch/powerpc/include/asm/mmu_context.h:
- Call switch_cop() in switch_mm() only if prev or next uses a coprocessor.

arch/powerpc/include/asm/mmu-hash64.h:
- Add cop_lock to mm_context_t
- Rename HASH64_MAX_PID to COP_PID_MAX and move to mmu_context_hash64.c

arch/powerpc/mm/mmu_context_hash64.c:
- Add a comment block to describe the usage of the icswx support code
- Define COP_PID_NONE, COP_PID_MIN, COP_PID_MAX for id allocation
- Define mtspr_acop() to make lazy switching a config option.
- change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL.
- Remove EXPORT_SYMBOL(switch_cop) as it is only used in switch_mm().
- use_cop(): make id allocation code into new new_cop_pid().
- use_cop/drop_cop(): Use cop_lock to guard acop and cop_pid accesses
  between threads in the same process. Init sop_lock in init_new_context().
- Remove unnecessary cpu_has_feature() check from drop_cop() and switch_cop().
- Call drop_cop() instead of destroy_acop() in destroy_context().
- Remove unused destroy_acop() function.

Change log from v2:
- Make the code a CPU feature and return -NODEV if CPU doesn't have
  icswx co-processor instruction.
- Change the goto loop in use_cop() into a do-while loop.
- Change context destroy code into a new destroy_context_acop() function
  and #define it based on CONFIG_ICSWX.
- Remove mmput() from drop_cop().
- Fix some TAB/space problems.

Change log from V1:
- Change 2'nd parameter of use_cop() from struct task_struct *task
  to struct mm_struct *mm.
- Check for mm == current->active_mm before calling mtspr().
- Add a lock to guard acop related operations.
- Check for POWER7 CPU.
- Move the definition of SPRN_PID from reg_booke.h to avoid
  defining SPRN_PID in two different files.
- Rename pid to acop_pid.
- Change function name disuse_cop() to drop_cop().
- Add a comment to describe the two new fields in mm_context_t.
- Moving CONFIG_ICSWX from arch/powerpc/platforms/pseries/Kconfig
  to arch/powerpc/platforms/Kconfig.cputype.

Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>

---
 arch/powerpc/include/asm/cputable.h    |    4 +-
 arch/powerpc/include/asm/mmu-hash64.h  |   13 +++
 arch/powerpc/include/asm/mmu_context.h |   12 ++
 arch/powerpc/include/asm/reg.h         |    1 +
 arch/powerpc/mm/mmu_context_hash64.c   |  177 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |   43 ++++++++
 6 files changed, 249 insertions(+), 1 deletions(-)

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
index acac35d..b0c2549 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -409,6 +409,14 @@ static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
 
 typedef unsigned long mm_context_id_t;
 
+#ifdef CONFIG_ICSWX
+/*
+ * Use forward declearation to avoid including linux/spinlock_types.h
+ * which breaks kernel build.
+ */
+struct spinlock;
+#endif /* CONFIG_ICSWX */
+
 typedef struct {
 	mm_context_id_t id;
 	u16 user_psize;		/* page size index */
@@ -423,6 +431,11 @@ typedef struct {
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 	struct subpage_prot_table spt;
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
+#ifdef CONFIG_ICSWX
+	struct spinlock *cop_lockp; /* guard acop and cop_pid */
+	unsigned long acop;	/* mask of enabled coprocessor types */
+	unsigned int cop_pid;	/* pid value used with coprocessors */
+#endif /* CONFIG_ICSWX */
 } mm_context_t;
 
 
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 81fb412..fe0a09a 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -32,6 +32,12 @@ extern void __destroy_context(unsigned long context_id);
 extern void mmu_context_init(void);
 #endif
 
+#ifdef CONFIG_ICSWX
+extern void switch_cop(struct mm_struct *next);
+extern int use_cop(unsigned long acop, struct mm_struct *mm);
+extern void drop_cop(unsigned long acop, struct mm_struct *mm);
+#endif /* CONFIG_ICSWX */
+
 /*
  * switch_mm is the entry point called from the architecture independent
  * code in kernel/sched.c
@@ -55,6 +61,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
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
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 125fc1a..51585eb 100644
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
index 2535828..43d66cc 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -18,11 +18,177 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <linux/idr.h>
+#include <linux/percpu.h>
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
+#ifdef CONFIG_ICSWX_LAZY_SWITCH
+static DEFINE_PER_CPU(unsigned long, acop_reg);
+#define mtspr_acop(val) \
+	if (__get_cpu_var(acop_reg) != val) { \
+		get_cpu_var(acop_reg) = val; \
+		mtspr(SPRN_ACOP, val); \
+		put_cpu_var(acop_reg); \
+	}
+#else
+#define mtspr_acop(val) mtspr(SPRN_ACOP, val)
+#endif /* CONFIG_ICSWX_LAZY_SWITCH */
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
+	mtspr_acop(next->context.acop);
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
+/*
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
+	int cop_pid;
+
+	if (!cpu_has_feature(CPU_FTR_ICSWX))
+		return -ENODEV;
+
+	if (!mm || !acop)
+		return -EINVAL;
+
+	spin_lock(mm->context.cop_lockp);
+	if (mm->context.cop_pid == COP_PID_NONE) {
+		cop_pid = new_cop_pid(&cop_ida, COP_PID_MIN, COP_PID_MAX,
+				      &mmu_context_acop_lock);
+		if (cop_pid < 0) {
+			spin_unlock(mm->context.cop_lockp);
+			return cop_pid;
+		}
+		mm->context.cop_pid = cop_pid;
+		if (mm == current->active_mm)
+			mtspr(SPRN_PID,  mm->context.cop_pid);
+	}
+	mm->context.acop |= acop;
+	if (mm == current->active_mm)
+		mtspr_acop(mm->context.acop);
+	spin_unlock(mm->context.cop_lockp);
+	return mm->context.cop_pid;
+}
+EXPORT_SYMBOL_GPL(use_cop);
+
+/*
+ * Stop using a coprocessor.
+ * @acop: mask of coprocessor to be stopped.
+ * @mm: The mm the coprocessor associated with.
+ */
+void drop_cop(unsigned long acop, struct mm_struct *mm)
+{
+	if (WARN_ON(!mm))
+		return;
+
+	spin_lock(mm->context.cop_lockp);
+	mm->context.acop &= ~acop;
+	if (mm == current->active_mm)
+		mtspr_acop(mm->context.acop);
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
 
@@ -79,6 +245,12 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 		slice_set_user_psize(mm, mmu_virtual_psize);
 	subpage_prot_init_new_context(mm);
 	mm->context.id = index;
+#ifdef CONFIG_ICSWX
+	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
+	if (! mm->context.cop_lockp)
+		return -ENOMEM;
+	spin_lock_init(mm->context.cop_lockp);
+#endif /* CONFIG_ICSWX */
 
 	return 0;
 }
@@ -93,6 +265,11 @@ EXPORT_SYMBOL_GPL(__destroy_context);
 
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
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 111138c..0007b66 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -226,6 +226,49 @@ config VSX
 
 	  If in doubt, say Y here.
 
+config ICSWX
+	bool "Support for PowerPC icswx coprocessor instruction"
+	depends on POWER4
+	default n
+	---help---
+
+	  Enabling this option to turn on the PowerPC Initiate Coprocessor
+	  Store Word (icswx) coprocessor instruction support for POWER7
+	  or newer processors.
+
+	  This option is only useful if you have a processor that supports
+	  icswx coprocessor instruction. It does not have any effect on
+	  processors without icswx coprocessor instruction.
+
+	  This option slightly increases kernel memory usage.
+
+	  Say N if you do not have a PowerPC processor supporting icswx
+	  instruction and a PowerPC coprocessor.
+
+config ICSWX_LAZY_SWITCH
+	bool "Lazy switching coprocessor type registers at context switching"
+	depends on ICSWX
+	default y
+	---help---
+
+	  Coprocessor type register is part of process context. It needs
+	  to be switched at context switching.
+
+	  As most machines have a very small number (most likely <= 1)
+	  of coprocessors, there is a good chance that the value of the
+	  coprocessor type register is the same between many processes.
+	  We do not need to change coprocessor type register at context
+	  switching unless the task to switch to has a different value.
+	
+	  Accessing CPU special purpose registers is far more expensive
+	  than accessing memory. This option uses a per-CPU variable
+	  to track the value of coprocessor type register. The variable
+	  is checked before updating coprocessor type register. The saving
+	  for one access is small but could turn big with the high
+	  frequency of context switching.
+	
+	  Say Y unless you have multiple coprocessors.
+
 config SPE
 	bool "SPE Support"
 	depends on E200 || (E500 && !PPC_E500MC)
