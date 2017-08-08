Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPrn3p5GzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:39:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/9] powerpc/4xx: Move machine_check_4xx() into platforms/4xx
Date: Tue,  8 Aug 2017 16:39:21 +1000
Message-Id: <1502174365-8293-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
References: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have 4xx platform directory we can move the 4xx machine
check handler in there. Again we drop get_mc_reason() and replace it
with regs->dsisr directly (which is actually SPRN_ESR).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c                | 18 +-----------------
 arch/powerpc/platforms/4xx/Makefile        |  2 +-
 arch/powerpc/platforms/4xx/machine_check.c | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 18 deletions(-)
 create mode 100644 arch/powerpc/platforms/4xx/machine_check.c

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 84f228aefb84..c1ecc4193c3f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -426,23 +426,7 @@ static inline int check_io_access(struct pt_regs *regs)
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif
 
-#if defined(CONFIG_4xx)
-int machine_check_4xx(struct pt_regs *regs)
-{
-	unsigned long reason = get_mc_reason(regs);
-
-	if (reason & ESR_IMCP) {
-		printk("Instruction");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-	} else
-		printk("Data");
-	printk(" machine check in kernel mode.\n");
-
-	return 0;
-}
-
-
-#elif defined(CONFIG_E500)
+#if defined(CONFIG_E500)
 int machine_check_e500mc(struct pt_regs *regs)
 {
 	unsigned long mcsr = mfspr(SPRN_MCSR);
diff --git a/arch/powerpc/platforms/4xx/Makefile b/arch/powerpc/platforms/4xx/Makefile
index 0d4b65c88d66..9779c32db34e 100644
--- a/arch/powerpc/platforms/4xx/Makefile
+++ b/arch/powerpc/platforms/4xx/Makefile
@@ -1,4 +1,4 @@
-obj-y				+= uic.o
+obj-y				+= uic.o machine_check.o
 obj-$(CONFIG_PPC4xx_OCM)	+= ocm.o
 obj-$(CONFIG_4xx_SOC)		+= soc.o
 obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/powerpc/platforms/4xx/machine_check.c b/arch/powerpc/platforms/4xx/machine_check.c
new file mode 100644
index 000000000000..aa039dfaf82f
--- /dev/null
+++ b/arch/powerpc/platforms/4xx/machine_check.c
@@ -0,0 +1,26 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/ptrace.h>
+
+#include <asm/reg.h>
+
+int machine_check_4xx(struct pt_regs *regs)
+{
+	unsigned long reason = regs->dsisr;
+
+	if (reason & ESR_IMCP) {
+		printk("Instruction");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+	} else
+		printk("Data");
+	printk(" machine check in kernel mode.\n");
+
+	return 0;
+}
-- 
2.7.4
