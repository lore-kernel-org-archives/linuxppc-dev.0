Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA994DDF43
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 10:54:57 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1CNsrO9022808
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 17:54:53 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add support for using doorbells for SMP IPI
Date: Thu, 12 Feb 2009 17:54:53 -0600
Message-Id: <1234482893-17712-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The e500mc supports the new msgsnd/doorbell mechanisms that were added in
the Power ISA 2.05 architecture.  We use the normal level doorbell for
doing SMP IPIs at this point.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/cputable.h  |    4 ++-
 arch/powerpc/include/asm/dbell.h     |   43 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile         |    2 +-
 arch/powerpc/kernel/dbell.c          |   44 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_fsl_booke.S |    6 ++++-
 arch/powerpc/kernel/traps.c          |   21 ++++++++++++++++
 6 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/dbell.h
 create mode 100644 arch/powerpc/kernel/dbell.c

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 4911104..fca1611 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -145,6 +145,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_USE_TB			ASM_CONST(0x0000000000000040)
 #define CPU_FTR_L2CSR			ASM_CONST(0x0000000000000080)
 #define CPU_FTR_601			ASM_CONST(0x0000000000000100)
+#define CPU_FTR_DBELL			ASM_CONST(0x0000000000000200)
 #define CPU_FTR_CAN_NAP			ASM_CONST(0x0000000000000400)
 #define CPU_FTR_L3CR			ASM_CONST(0x0000000000000800)
 #define CPU_FTR_L3_DISABLE_NAP		ASM_CONST(0x0000000000001000)
@@ -373,7 +374,8 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
-	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE)
+	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
+	    CPU_FTR_DBELL)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
new file mode 100644
index 0000000..501189a
--- /dev/null
+++ b/arch/powerpc/include/asm/dbell.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2009 Freescale Semicondutor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * provides masks and opcode images for use by code generation, emulation
+ * and for instructions that older assemblers might not know about
+ */
+#ifndef _ASM_POWERPC_DBELL_H
+#define _ASM_POWERPC_DBELL_H
+
+#include <linux/smp.h>
+#include <linux/threads.h>
+
+#include <asm/ppc-opcode.h>
+
+#define PPC_DBELL_MSG_BRDCAST	(0x04000000)
+#define PPC_DBELL_TYPE(x)	(((x) & 0xf) << 28)
+enum ppc_dbell {
+	PPC_DBELL = 0,		/* doorbell */
+	PPC_DBELL_CRIT = 1,	/* critical doorbell */
+	PPC_G_DBELL = 2,	/* guest doorbell */
+	PPC_G_DBELL_CRIT = 3,	/* guest critical doorbell */
+	PPC_G_DBELL_MC = 4,	/* guest mcheck doorbell */
+};
+
+#ifdef CONFIG_SMP
+extern unsigned long dbell_smp_message[NR_CPUS];
+extern void smp_dbell_message_pass(int target, int msg);
+#endif
+
+static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
+{
+	u32 msg = PPC_DBELL_TYPE(type) | (flags & PPC_DBELL_MSG_BRDCAST) |
+			(tag & 0x07ffffff);
+
+	__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
+}
+
+#endif /* _ASM_POWERPC_DBELL_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index d159921..f420844 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -61,7 +61,7 @@ obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
 obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
 obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
-obj-$(CONFIG_FSL_BOOKE)		+= cpu_setup_fsl_booke.o
+obj-$(CONFIG_FSL_BOOKE)		+= cpu_setup_fsl_booke.o dbell.o
 
 extra-$(CONFIG_PPC_STD_MMU)	:= head_32.o
 extra-$(CONFIG_PPC64)		:= head_64.o
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
new file mode 100644
index 0000000..1493734
--- /dev/null
+++ b/arch/powerpc/kernel/dbell.c
@@ -0,0 +1,44 @@
+/*
+ * Author: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * Copyright 2009 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+
+#include <asm/dbell.h>
+
+#ifdef CONFIG_SMP
+unsigned long dbell_smp_message[NR_CPUS];
+
+void smp_dbell_message_pass(int target, int msg)
+{
+	int i;
+
+	if(target < NR_CPUS) {
+		set_bit(msg, &dbell_smp_message[target]);
+		ppc_msgsnd(PPC_DBELL, 0, target);
+	}
+	else if(target == MSG_ALL_BUT_SELF) {
+		for_each_online_cpu(i) {
+			if (i == smp_processor_id())
+				continue;
+			set_bit(msg, &dbell_smp_message[i]);
+			ppc_msgsnd(PPC_DBELL, 0, i);
+		}
+	}
+	else { /* target == MSG_ALL */
+		for_each_online_cpu(i)
+			set_bit(msg, &dbell_smp_message[i]);
+		ppc_msgsnd(PPC_DBELL, PPC_DBELL_MSG_BRDCAST, 0);
+	}
+}
+#endif
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 4ea6e1a..4c22620 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -698,7 +698,9 @@ interrupt_base:
 	/* Performance Monitor */
 	EXCEPTION(0x2060, PerformanceMonitor, performance_monitor_exception, EXC_XFER_STD)
 
-	EXCEPTION(0x2070, Doorbell, unknown_exception, EXC_XFER_STD)
+	EXCEPTION(0x2070, Doorbell, doorbell_exception, EXC_XFER_STD)
+
+	CRITICAL_EXCEPTION(0x2080, CriticalDoorbell, unknown_exception)
 
 	/* Debug Interrupt */
 	DEBUG_DEBUG_EXCEPTION
@@ -921,6 +923,8 @@ _GLOBAL(__setup_e500mc_ivors)
 	mtspr	SPRN_IVOR35,r3
 	li	r3,Doorbell@l
 	mtspr	SPRN_IVOR36,r3
+	li	r3,CriticalDoorbell@l
+	mtspr	SPRN_IVOR37,r3
 	sync
 	blr
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 970d66e..678fbff 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -53,6 +53,9 @@
 #endif
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
+#ifdef CONFIG_FSL_BOOKE
+#include <asm/dbell.h>
+#endif
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs);
@@ -1122,6 +1125,24 @@ void vsx_assist_exception(struct pt_regs *regs)
 #endif /* CONFIG_VSX */
 
 #ifdef CONFIG_FSL_BOOKE
+
+void doorbell_exception(struct pt_regs *regs)
+{
+#ifdef CONFIG_SMP
+	int cpu = smp_processor_id();
+	int msg;
+
+	if (num_online_cpus() < 2)
+		return;
+
+	for (msg = 0; msg < 4; msg++)
+		if (test_and_clear_bit(msg, &dbell_smp_message[cpu]))
+			smp_message_recv(msg);
+#else
+	printk(KERN_WARNING "Received doorbell on non-smp system\n");
+#endif
+}
+
 void CacheLockingException(struct pt_regs *regs, unsigned long address,
 			   unsigned long error_code)
 {
-- 
1.5.6.6
