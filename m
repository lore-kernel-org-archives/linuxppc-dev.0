Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408yHT6dJbzF210
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 02:09:57 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id f23-v6so12111484plr.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 08:09:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH] powerpc/xmon: Use OPAL_DEBUG to debug srest in OPAL
Date: Tue, 27 Mar 2018 01:09:46 +1000
Message-Id: <20180326150946.23555-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xmon can be entered via sreset NMI (from a management sreset, or an
NMI IPI), which can interrupt OPAL. Add checks to xmon to see if pc
or sp are within OPAL memory, and if so, then use OPAL_DEBUG to
print the opal stack and return the Linux stack, which can then be
dumped by xmon

The OPAL side of this, with sample xmon output is here:

https://lists.ozlabs.org/pipermail/skiboot/2018-March/010856.html

This could be plumed into the oops printing code as well.

Thanks,
Nick
---
 arch/powerpc/include/asm/opal.h                |  4 ++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/opal.c          |  5 +++++
 arch/powerpc/xmon/xmon.c                       | 27 ++++++++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 12e70fb58700..afcc0c5ed5b0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -27,6 +27,8 @@ extern struct kobject *opal_kobj;
 /* /ibm,opal */
 extern struct device_node *opal_node;
 
+bool in_opal_text_heap_stack(u64 address);
+
 /* API functions */
 int64_t opal_invalid_call(void);
 int64_t opal_npu_destroy_context(uint64_t phb_id, uint64_t pid, uint64_t bdf);
@@ -289,6 +291,8 @@ int opal_sensor_group_clear(u32 group_hndl, int token);
 
 s64 opal_signal_system_reset(s32 cpu);
 
+s64 opal_debug(u32 debug_type, u64 r1);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 1b2936ba6040..78b9ae003553 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -323,3 +323,4 @@ OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
 OPAL_CALL(opal_npu_spa_setup,			OPAL_NPU_SPA_SETUP);
 OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
 OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
+OPAL_CALL(opal_debug,				167);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index c15182765ff5..0b7ff5fb18f8 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -64,6 +64,11 @@ static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static uint32_t opal_heartbeat;
 static struct task_struct *kopald_tsk;
 
+bool in_opal_text_heap_stack(u64 address)
+{
+	return (address >= opal.base && address < opal.base + opal.size);
+}
+
 void opal_configure_cores(void)
 {
 	u64 reinit_flags = 0;
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 82e1a3ee6e0f..ade1adcc1ab8 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -452,6 +452,15 @@ static inline int unrecoverable_excp(struct pt_regs *regs)
 #endif
 }
 
+static bool in_opal(unsigned long addr)
+{
+	if (firmware_has_feature(FW_FEATURE_OPAL))
+		if (in_opal_text_heap_stack(addr))
+			return true;
+
+	return false;
+}
+
 static int xmon_core(struct pt_regs *regs, int fromipi)
 {
 	int cmd = 0;
@@ -510,6 +519,9 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 
 	xmon_fault_jmp[cpu] = recurse_jmp;
 
+	if (in_opal(regs->nip))
+		printf("xmon: cpu 0x%x stopped in OPAL!\n", cpu);
+
 	bp = NULL;
 	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT))
 		bp = at_breakpoint(regs->nip);
@@ -1484,8 +1496,23 @@ static void xmon_show_stack(unsigned long sp, unsigned long lr,
 	unsigned long marker;
 	struct pt_regs regs;
 
+	if (in_opal(sp)) {
+		struct debug_struct {
+			unsigned long nip;
+			unsigned long r1;
+			unsigned long r1_caller;
+		} db;
+		printf("SP is in OPAL, calling OPAL to dump stack\n");
+		db.nip = cpu_to_be64(pc);
+		db.r1 = cpu_to_be64(sp);
+		opal_debug(1, (unsigned long)&db);
+		sp = be64_to_cpu(db.r1_caller);
+	}
+
 	while (max_to_print--) {
 		if (!is_kernel_addr(sp)) {
+			if (in_opal(pc) && in_opal(sp))
+				printf("SP (%lx) is in OPAL\n", sp);
 			if (sp != 0)
 				printf("SP (%lx) is in userspace\n", sp);
 			break;
-- 
2.16.1
