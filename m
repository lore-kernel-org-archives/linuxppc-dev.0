Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B380FB70CB
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 14:57:42 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9C3rU5A003246
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2010 21:53:30 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o9C3vdGS175330
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2010 21:57:39 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9C3vdnA021081
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2010 21:57:39 -0600
Received: from [9.53.40.45] (flin.austin.ibm.com [9.53.40.45])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o9C3vdAG021076
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2010 21:57:39 -0600
Subject: [PATCH] add icswx support v2
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Oct 2010 22:45:08 -0500
Message-ID: <1286855108.14049.8.camel@flin.austin.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

icswx is a PowerPC co-processor instruction to send data to a
co-processor. On Book-S processors the LPAR_ID and process ID (PID) of
the owning process are registered in the window context of the
co-processor at initial time. When the icswx instruction is executed,
the L2 generates a cop-reg transaction on PowerBus. The transaction has
no address and the processor does not perform an MMU access to
authenticate the transaction. The coprocessor compares the LPAR_ID and
the PID included in the transaction and the LPAR_ID and PID held in the
window context to determine if the process is authorized to generate the
transaction.

This patch adds icswx co-processor instruction support.

Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h  |    5 ++
 arch/powerpc/include/asm/mmu_context.h |    6 ++
 arch/powerpc/include/asm/reg.h         |   12 ++++
 arch/powerpc/include/asm/reg_booke.h   |    3 -
 arch/powerpc/mm/mmu_context_hash64.c   |  105
++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |   16 +++++
 6 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h
b/arch/powerpc/include/asm/mmu-hash64.h
index acac35d..6c1ab90 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -423,6 +423,11 @@ typedef struct {
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 	struct subpage_prot_table spt;
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
+#ifdef CONFIG_ICSWX
+	unsigned long acop;	/* mask of enabled coprocessor types */
+#define HASH64_MAX_PID (0xFFFF)
+	unsigned int acop_pid;	/* pid value used with coprocessors */
+#endif /* CONFIG_ICSWX */
 } mm_context_t;
 
 
diff --git a/arch/powerpc/include/asm/mmu_context.h
b/arch/powerpc/include/asm/mmu_context.h
index 81fb412..88118de 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -80,6 +80,12 @@ static inline void switch_mm(struct mm_struct *prev,
struct mm_struct *next,
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
+#ifdef CONFIG_ICSWX
+extern void switch_cop(struct mm_struct *next);
+extern int use_cop(unsigned long acop, struct mm_struct *mm);
+extern void drop_cop(unsigned long acop, struct mm_struct *mm);
+#endif /* CONFIG_ICSWX */
+
 /*
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
diff --git a/arch/powerpc/include/asm/reg.h
b/arch/powerpc/include/asm/reg.h
index ff0005eec..9bbf178 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -170,8 +170,19 @@
 #define SPEFSCR_FRMC 	0x00000003	/* Embedded FP rounding mode control
*/
 
 /* Special Purpose Registers (SPRNs)*/
+
+#ifdef CONFIG_40x
+#define SPRN_PID	0x3B1	/* Process ID */
+#else
+#define	SPRN_PID	0x030	/* Process ID */
+#ifdef CONFIG_BOOKE
+#define	SPRN_PID0	SPRN_PID/* Process ID Register 0 */
+#endif
+#endif
+
 #define SPRN_CTR	0x009	/* Count Register */
 #define SPRN_DSCR	0x11
+#define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
 #define   CTRL_CT	0xc0000000	/* current thread */
@@ -879,6 +890,7 @@
 #define PV_POWER5	0x003A
 #define PV_POWER5p	0x003B
 #define PV_970FX	0x003C
+#define PV_POWER7	0x003F
 #define PV_630		0x0040
 #define PV_630p	0x0041
 #define PV_970MP	0x0044
diff --git a/arch/powerpc/include/asm/reg_booke.h
b/arch/powerpc/include/asm/reg_booke.h
index 667a498..5b0c781 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -150,8 +150,6 @@
  * or IBM 40x.
  */
 #ifdef CONFIG_BOOKE
-#define SPRN_PID	0x030	/* Process ID */
-#define SPRN_PID0	SPRN_PID/* Process ID Register 0 */
 #define SPRN_CSRR0	0x03A	/* Critical Save and Restore Register 0 */
 #define SPRN_CSRR1	0x03B	/* Critical Save and Restore Register 1 */
 #define SPRN_DEAR	0x03D	/* Data Error Address Register */
@@ -168,7 +166,6 @@
 #define SPRN_TCR	0x154	/* Timer Control Register */
 #endif /* Book E */
 #ifdef CONFIG_40x
-#define SPRN_PID	0x3B1	/* Process ID */
 #define SPRN_DBCR1	0x3BD	/* Debug Control Register 1 */		
 #define SPRN_ESR	0x3D4	/* Exception Syndrome Register */
 #define SPRN_DEAR	0x3D5	/* Data Error Address Register */
diff --git a/arch/powerpc/mm/mmu_context_hash64.c
b/arch/powerpc/mm/mmu_context_hash64.c
index 2535828..8f432b6 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <linux/idr.h>
+#include <linux/percpu.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
 
@@ -26,6 +27,103 @@
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
+#ifdef CONFIG_ICSWX
+static DEFINE_SPINLOCK(mmu_context_acop_lock);
+static DEFINE_IDA(cop_ida);
+
+/* Lazy switch the ACOP register */
+static DEFINE_PER_CPU(unsigned long, acop_reg);
+
+void switch_cop(struct mm_struct *next)
+{
+	if (!__is_processor(PV_POWER7))
+		return;
+
+	mtspr(SPRN_PID, next->context.acop_pid);
+	if (next->context.acop_pid &&
+	    __get_cpu_var(acop_reg) != next->context.acop) {
+		mtspr(SPRN_ACOP, next->context.acop);
+		__get_cpu_var(acop_reg) = next->context.acop;
+	}
+}
+EXPORT_SYMBOL(switch_cop);
+
+int use_cop(unsigned long acop, struct mm_struct *mm)
+{
+	int acop_pid;
+	int err;
+
+	if (!__is_processor(PV_POWER7))
+		return -ENOSYS;
+
+	if (!mm)
+		return -EINVAL;
+
+	if (!mm->context.acop_pid) {
+		if (!ida_pre_get(&cop_ida, GFP_KERNEL))
+			return -ENOMEM;
+again:
+		spin_lock(&mmu_context_acop_lock);
+		err = ida_get_new_above(&cop_ida, 1, &acop_pid);
+		spin_unlock(&mmu_context_acop_lock);
+
+		if (err == -EAGAIN)
+			goto again;
+		else if (err)
+			return err;
+
+		if (acop_pid > HASH64_MAX_PID) {
+			spin_lock(&mmu_context_acop_lock);
+			ida_remove(&cop_ida, acop_pid);
+			spin_unlock(&mmu_context_acop_lock);
+			return -EBUSY;
+		}
+		mm->context.acop_pid = acop_pid;
+		if (mm == current->active_mm)
+			mtspr(SPRN_PID,  mm->context.acop_pid);
+	}
+	spin_lock(&mmu_context_acop_lock);
+	mm->context.acop |= acop;
+	spin_unlock(&mmu_context_acop_lock);
+
+	get_cpu_var(acop_reg) = mm->context.acop;
+	if (mm == current->active_mm)
+		mtspr(SPRN_ACOP, mm->context.acop);
+	put_cpu_var(acop_reg);
+
+	return mm->context.acop_pid;
+}
+EXPORT_SYMBOL(use_cop);
+
+void drop_cop(unsigned long acop, struct mm_struct *mm)
+{
+	if (!__is_processor(PV_POWER7))
+		return;
+
+	if (WARN_ON(!mm))
+		return;
+
+	spin_lock(&mmu_context_acop_lock);
+	mm->context.acop &= ~acop;
+	spin_unlock(&mmu_context_acop_lock);
+	if (!mm->context.acop) {
+		spin_lock(&mmu_context_acop_lock);
+		ida_remove(&cop_ida, mm->context.acop_pid);
+		spin_unlock(&mmu_context_acop_lock);
+		mm->context.acop_pid = 0;
+		if (mm == current->active_mm)
+			mtspr(SPRN_PID, mm->context.acop_pid);
+	} else {
+		get_cpu_var(acop_reg) = mm->context.acop;
+		if (mm == current->active_mm)
+			mtspr(SPRN_ACOP, mm->context.acop);
+		put_cpu_var(acop_reg);
+	}
+	mmput(mm);
+}
+EXPORT_SYMBOL(drop_cop);
+#endif /* CONFIG_ICSWX */
+
 /*
  * The proto-VSID space has 2^35 - 1 segments available for user
mappings.
  * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
@@ -93,6 +191,13 @@ EXPORT_SYMBOL_GPL(__destroy_context);
 
 void destroy_context(struct mm_struct *mm)
 {
+#ifdef CONFIG_ICSWX
+	if (mm->context.acop_pid) {
+		spin_lock(&mmu_context_acop_lock);
+		ida_remove(&cop_ida, mm->context.acop_pid);
+		spin_unlock(&mmu_context_acop_lock);
+	}
+#endif /* CONFIG_ICSWX */
 	__destroy_context(mm->context.id);
 	subpage_prot_free(mm);
 	mm->context.id = NO_CONTEXT;
diff --git a/arch/powerpc/platforms/Kconfig.cputype
b/arch/powerpc/platforms/Kconfig.cputype
index d361f81..9674703 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -220,6 +220,22 @@ config VSX
 
 	  If in doubt, say Y here.
 
+config ICSWX
+	bool "Support for PowerPC icswx co-processor instruction"
+	depends on POWER4
+	default n
+	---help---
+
+	  Enabling this option to turn on the PowerPC icswx co-processor
+	  instruction support for POWER7 processors.
+	  This option is only useful if you have a processor that supports
+	  icswx co-processor instruction. It does not have any affect on
+	  processors without icswx co-processor instruction.
+
+	  This support slightly increases kernel memory usage.
+
+	  Say N if you do not have a POWER7 processor and a PowerPC
co-processor.
+
 config SPE
 	bool "SPE Support"
 	depends on E200 || (E500 && !PPC_E500MC)
