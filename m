Return-Path: <xenidis@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB28EB6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Sep 2011 01:57:52 +1000 (EST)
Received: by iabn5 with SMTP id n5so4462407iab.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Sep 2011 08:57:43 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3 v2] powerpc: Split ICSWX ACOP and PID processing
Date: Fri, 23 Sep 2011 10:59:52 -0500
Message-Id: <1316793594-22407-1-git-send-email-jimix@pobox.com>
Cc: anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some processors, like embedded, that already have a PID register that
is managed by the system.  This patch separates the ACOP and PID
processing into separate files so that the ACOP code can be shared.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>

---
Re: galak@kernel.crashing.org
    Fix typo in arch/powerpc/mm/Makefile

Re: anton@samba.org
    merge in: powerpc: Fix deadlock in icswx code
---
 arch/powerpc/mm/Makefile               |    2 +
 arch/powerpc/mm/icswx.c                |  162 ++++++++++++++++++++++++++
 arch/powerpc/mm/icswx.h                |   34 ++++++
 arch/powerpc/mm/icswx_pid.c            |   87 ++++++++++++++
 arch/powerpc/mm/mmu_context_hash64.c   |  195 --------------------------------
 arch/powerpc/platforms/Kconfig.cputype |   10 ++-
 6 files changed, 294 insertions(+), 196 deletions(-)
 create mode 100644 arch/powerpc/mm/icswx.c
 create mode 100644 arch/powerpc/mm/icswx.h
 create mode 100644 arch/powerpc/mm/icswx_pid.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index bdca46e..fb7976f 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -21,6 +21,8 @@ obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
 				   tlb_hash$(CONFIG_WORD_SIZE).o \
 				   mmu_context_hash$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_PPC_ICSWX)		+= icswx.o
+obj-$(CONFIG_PPC_ICSWX_PID)	+= icswx_pid.o
 obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
diff --git a/arch/powerpc/mm/icswx.c b/arch/powerpc/mm/icswx.c
new file mode 100644
index 0000000..2f1dd29
--- /dev/null
+++ b/arch/powerpc/mm/icswx.c
@@ -0,0 +1,162 @@
+/*
+ *  ICSWX and ACOP Management
+ *
+ *  Copyright (C) 2011 Anton Blanchard, IBM Corp. <anton@samba.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include "icswx.h"
+
+
+/*
+ * The processor and its L2 cache cause the icswx instruction to
+ * generate a COP_REQ transaction on PowerBus. The transaction has no
+ * address, and the processor does not perform an MMU access to
+ * authenticate the transaction. The command portion of the PowerBus
+ * COP_REQ transaction includes the LPAR_ID (LPID) and the coprocessor
+ * Process ID (PID), which the coprocessor compares to the authorized
+ * LPID and PID held in the coprocessor, to determine if the process
+ * is authorized to generate the transaction.  The data of the COP_REQ
+ * transaction is cache block or less, typically 64 or 128 bytes in
+ * size, and is placed in cacheable memory on a 128-byte boundary
+ * _always_.
+ *
+ * The task to use a coprocessor should use use_cop() mark the use of
+ * the coprocessor type (CT) and context swithing.  On a server
+ * processor the PID register is used only for coprocessor management
+ * and so a coprocessor PID is allocated before executing icswx
+ * instruction. Drop_cop() is used to free the resources created by
+ * use_cop().
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
+void switch_cop(struct mm_struct *next)
+{
+#ifdef CONFIG_ICSWX_PID
+	mtspr(SPRN_PID, next->context.cop_pid);
+#endif
+	mtspr(SPRN_ACOP, next->context.acop);
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
+	/* The page_table_lock ensures mm_users won't change under us */
+	spin_lock(&mm->page_table_lock);
+	spin_lock(mm->context.cop_lockp);
+
+	ret = get_cop_pid(mm);
+	if (ret < 0)
+		goto out;
+
+	/* update acop */
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
+out:
+	spin_unlock(mm->context.cop_lockp);
+	spin_unlock(&mm->page_table_lock);
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
+	int free_pid;
+
+	if (!cpu_has_feature(CPU_FTR_ICSWX))
+		return;
+
+	if (WARN_ON_ONCE(!mm))
+		return;
+
+	/* The page_table_lock ensures mm_users won't change under us */
+	spin_lock(&mm->page_table_lock);
+	spin_lock(mm->context.cop_lockp);
+
+	mm->context.acop &= ~acop;
+
+	free_pid = disable_cop_pid(mm);
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
+	if (free_pid != COP_PID_NONE)
+		free_cop_pid(free_pid);
+
+	spin_unlock(mm->context.cop_lockp);
+	spin_unlock(&mm->page_table_lock);
+}
+EXPORT_SYMBOL_GPL(drop_cop);
diff --git a/arch/powerpc/mm/icswx.h b/arch/powerpc/mm/icswx.h
new file mode 100644
index 0000000..5121ddd
--- /dev/null
+++ b/arch/powerpc/mm/icswx.h
@@ -0,0 +1,34 @@
+/*
+ *  ICSWX and ACOP Management
+ *
+ *  Copyright (C) 2011 Anton Blanchard, IBM Corp. <anton@samba.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/mmu_context.h>
+
+/* also used to denote that PIDs are not used */
+#define COP_PID_NONE 0
+
+static inline void sync_cop(void *arg)
+{
+	struct mm_struct *mm = arg;
+
+	if (mm == current->active_mm)
+		switch_cop(current->active_mm);
+}
+
+#ifdef CONFIG_PPC_ICSWX_PID
+extern int get_cop_pid(struct mm_struct *mm);
+extern int disable_cop_pid(struct mm_struct *mm);
+extern void free_cop_pid(int free_pid);
+#else
+#define get_cop_pid(m) (COP_PID_NONE)
+#define disable_cop_pid(m) (COP_PID_NONE)
+#define free_cop_pid(p)
+#endif
diff --git a/arch/powerpc/mm/icswx_pid.c b/arch/powerpc/mm/icswx_pid.c
new file mode 100644
index 0000000..91e30eb
--- /dev/null
+++ b/arch/powerpc/mm/icswx_pid.c
@@ -0,0 +1,87 @@
+/*
+ *  ICSWX and ACOP/PID Management
+ *
+ *  Copyright (C) 2011 Anton Blanchard, IBM Corp. <anton@samba.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+#include "icswx.h"
+
+#define COP_PID_MIN (COP_PID_NONE + 1)
+#define COP_PID_MAX (0xFFFF)
+
+static DEFINE_SPINLOCK(mmu_context_acop_lock);
+static DEFINE_IDA(cop_ida);
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
+int get_cop_pid(struct mm_struct *mm)
+{
+	int pid;
+
+	if (mm->context.cop_pid == COP_PID_NONE) {
+		pid = new_cop_pid(&cop_ida, COP_PID_MIN, COP_PID_MAX,
+				  &mmu_context_acop_lock);
+		if (pid >= 0)
+			mm->context.cop_pid = pid;
+	}
+	return mm->context.cop_pid;
+}
+
+int disable_cop_pid(struct mm_struct *mm)
+{
+	int free_pid = COP_PID_NONE;
+
+	if ((!mm->context.acop) && (mm->context.cop_pid != COP_PID_NONE)) {
+		free_pid = mm->context.cop_pid;
+		mm->context.cop_pid = COP_PID_NONE;
+	}
+	return free_pid;
+}
+
+void free_cop_pid(int free_pid)
+{
+	spin_lock(&mmu_context_acop_lock);
+	ida_remove(&cop_ida, free_pid);
+	spin_unlock(&mmu_context_acop_lock);
+}
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 3bafc3d..a75832c 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -24,201 +24,6 @@
 
 #include <asm/mmu_context.h>
 
-#ifdef CONFIG_PPC_ICSWX
-/*
- * The processor and its L2 cache cause the icswx instruction to
- * generate a COP_REQ transaction on PowerBus. The transaction has
- * no address, and the processor does not perform an MMU access
- * to authenticate the transaction. The command portion of the
- * PowerBus COP_REQ transaction includes the LPAR_ID (LPID) and
- * the coprocessor Process ID (PID), which the coprocessor compares
- * to the authorized LPID and PID held in the coprocessor, to determine
- * if the process is authorized to generate the transaction.
- * The data of the COP_REQ transaction is 128-byte or less and is
- * placed in cacheable memory on a 128-byte cache line boundary.
- *
- * The task to use a coprocessor should use use_cop() to allocate
- * a coprocessor PID before executing icswx instruction. use_cop()
- * also enables the coprocessor context switching. Drop_cop() is
- * used to free the coprocessor PID.
- *
- * Example:
- * Host Fabric Interface (HFI) is a PowerPC network coprocessor.
- * Each HFI have multiple windows. Each HFI window serves as a
- * network device sending to and receiving from HFI network.
- * HFI immediate send function uses icswx instruction. The immediate
- * send function allows small (single cache-line) packets be sent
- * without using the regular HFI send FIFO and doorbell, which are
- * much slower than immediate send.
- *
- * For each task intending to use HFI immediate send, the HFI driver
- * calls use_cop() to obtain a coprocessor PID for the task.
- * The HFI driver then allocate a free HFI window and save the
- * coprocessor PID to the HFI window to allow the task to use the
- * HFI window.
- *
- * The HFI driver repeatedly creates immediate send packets and
- * issues icswx instruction to send data through the HFI window.
- * The HFI compares the coprocessor PID in the CPU PID register
- * to the PID held in the HFI window to determine if the transaction
- * is allowed.
- *
- * When the task to release the HFI window, the HFI driver calls
- * drop_cop() to release the coprocessor PID.
- */
-
-#define COP_PID_NONE 0
-#define COP_PID_MIN (COP_PID_NONE + 1)
-#define COP_PID_MAX (0xFFFF)
-
-static DEFINE_SPINLOCK(mmu_context_acop_lock);
-static DEFINE_IDA(cop_ida);
-
-void switch_cop(struct mm_struct *next)
-{
-	mtspr(SPRN_PID, next->context.cop_pid);
-	mtspr(SPRN_ACOP, next->context.acop);
-}
-
-static int new_cop_pid(struct ida *ida, int min_id, int max_id,
-		       spinlock_t *lock)
-{
-	int index;
-	int err;
-
-again:
-	if (!ida_pre_get(ida, GFP_KERNEL))
-		return -ENOMEM;
-
-	spin_lock(lock);
-	err = ida_get_new_above(ida, min_id, &index);
-	spin_unlock(lock);
-
-	if (err == -EAGAIN)
-		goto again;
-	else if (err)
-		return err;
-
-	if (index > max_id) {
-		spin_lock(lock);
-		ida_remove(ida, index);
-		spin_unlock(lock);
-		return -ENOMEM;
-	}
-
-	return index;
-}
-
-static void sync_cop(void *arg)
-{
-	struct mm_struct *mm = arg;
-
-	if (mm == current->active_mm)
-		switch_cop(current->active_mm);
-}
-
-/**
- * Start using a coprocessor.
- * @acop: mask of coprocessor to be used.
- * @mm: The mm the coprocessor to associate with. Most likely current mm.
- *
- * Return a positive PID if successful. Negative errno otherwise.
- * The returned PID will be fed to the coprocessor to determine if an
- * icswx transaction is authenticated.
- */
-int use_cop(unsigned long acop, struct mm_struct *mm)
-{
-	int ret;
-
-	if (!cpu_has_feature(CPU_FTR_ICSWX))
-		return -ENODEV;
-
-	if (!mm || !acop)
-		return -EINVAL;
-
-	/* We need to make sure mm_users doesn't change */
-	down_read(&mm->mmap_sem);
-	spin_lock(mm->context.cop_lockp);
-
-	if (mm->context.cop_pid == COP_PID_NONE) {
-		ret = new_cop_pid(&cop_ida, COP_PID_MIN, COP_PID_MAX,
-				  &mmu_context_acop_lock);
-		if (ret < 0)
-			goto out;
-
-		mm->context.cop_pid = ret;
-	}
-	mm->context.acop |= acop;
-
-	sync_cop(mm);
-
-	/*
-	 * If this is a threaded process then there might be other threads
-	 * running. We need to send an IPI to force them to pick up any
-	 * change in PID and ACOP.
-	 */
-	if (atomic_read(&mm->mm_users) > 1)
-		smp_call_function(sync_cop, mm, 1);
-
-	ret = mm->context.cop_pid;
-
-out:
-	spin_unlock(mm->context.cop_lockp);
-	up_read(&mm->mmap_sem);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(use_cop);
-
-/**
- * Stop using a coprocessor.
- * @acop: mask of coprocessor to be stopped.
- * @mm: The mm the coprocessor associated with.
- */
-void drop_cop(unsigned long acop, struct mm_struct *mm)
-{
-	int free_pid = COP_PID_NONE;
-
-	if (!cpu_has_feature(CPU_FTR_ICSWX))
-		return;
-
-	if (WARN_ON_ONCE(!mm))
-		return;
-
-	/* We need to make sure mm_users doesn't change */
-	down_read(&mm->mmap_sem);
-	spin_lock(mm->context.cop_lockp);
-
-	mm->context.acop &= ~acop;
-
-	if ((!mm->context.acop) && (mm->context.cop_pid != COP_PID_NONE)) {
-		free_pid = mm->context.cop_pid;
-		mm->context.cop_pid = COP_PID_NONE;
-	}
-
-	sync_cop(mm);
-
-	/*
-	 * If this is a threaded process then there might be other threads
-	 * running. We need to send an IPI to force them to pick up any
-	 * change in PID and ACOP.
-	 */
-	if (atomic_read(&mm->mm_users) > 1)
-		smp_call_function(sync_cop, mm, 1);
-
-	if (free_pid != COP_PID_NONE) {
-		spin_lock(&mmu_context_acop_lock);
-		ida_remove(&cop_ida, free_pid);
-		spin_unlock(&mmu_context_acop_lock);
-	}
-
-	spin_unlock(mm->context.cop_lockp);
-	up_read(&mm->mmap_sem);
-}
-EXPORT_SYMBOL_GPL(drop_cop);
-
-#endif /* CONFIG_PPC_ICSWX */
-
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e06e395..3cd22e5 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -234,7 +234,7 @@ config VSX
 
 config PPC_ICSWX
 	bool "Support for PowerPC icswx coprocessor instruction"
-	depends on POWER4
+	depends on POWER4 || PPC_A2
 	default n
 	---help---
 
@@ -250,6 +250,14 @@ config PPC_ICSWX
 
 	  If in doubt, say N here.
 
+config PPC_ICSWX_PID
+	bool "icswx requires direct PID management"
+	depends on PPC_ICSWX && POWER4
+	default y
+	---help---
+	  PID register in server is used explicitly for ICSWX.  In
+	  embedded systems PID managment is done by the system.
+
 config SPE
 	bool "SPE Support"
 	depends on E200 || (E500 && !PPC_E500MC)
-- 
1.7.0.4
