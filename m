Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXx16LZ4zDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:58:45 +1000 (AEST)
Message-Id: <3d39290f4a49b8cedd6306513b1b2999d1aeb053.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 02/12] powerpc/8xx: Move 8xx machine check handlers into
 platforms/8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:42 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the same spirit as what was done for 4xx and 44x, move
the 8xx machine check into platforms/8xx

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/traps.c                | 25 --------------------
 arch/powerpc/platforms/8xx/Makefile        |  2 +-
 arch/powerpc/platforms/8xx/machine_check.c | 37 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 26 deletions(-)
 create mode 100644 arch/powerpc/platforms/8xx/machine_check.c

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9107f7f86058..b328ca2aef9c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -558,31 +558,6 @@ int machine_check_e200(struct pt_regs *regs)
 
 	return 0;
 }
-#elif defined(CONFIG_PPC_8xx)
-int machine_check_8xx(struct pt_regs *regs)
-{
-	unsigned long reason = regs->msr;
-
-	pr_err("Machine check in kernel mode.\n");
-	pr_err("Caused by (from SRR1=%lx): ", reason);
-	if (reason & 0x40000000)
-		pr_err("Fetch error at address %lx\n", regs->nip);
-	else
-		pr_err("Data access error at address %lx\n", regs->dar);
-
-#ifdef CONFIG_PCI
-	/* the qspan pci read routines can cause machine checks -- Cort
-	 *
-	 * yuck !!! that totally needs to go away ! There are better ways
-	 * to deal with that than having a wart in the mcheck handler.
-	 * -- BenH
-	 */
-	bad_page_fault(regs, regs->dar, SIGBUS);
-	return 1;
-#else
-	return 0;
-#endif
-}
 #elif defined(CONFIG_PPC32)
 int machine_check_generic(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
index 161f367ebf1e..756be8345868 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the PowerPC 8xx linux kernel.
 #
-obj-y			+= m8xx_setup.o
+obj-y			+= m8xx_setup.o machine_check.o
 obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
 obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
diff --git a/arch/powerpc/platforms/8xx/machine_check.c b/arch/powerpc/platforms/8xx/machine_check.c
new file mode 100644
index 000000000000..402016705a39
--- /dev/null
+++ b/arch/powerpc/platforms/8xx/machine_check.c
@@ -0,0 +1,37 @@
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
+int machine_check_8xx(struct pt_regs *regs)
+{
+	unsigned long reason = regs->msr;
+
+	pr_err("Machine check in kernel mode.\n");
+	pr_err("Caused by (from SRR1=%lx): ", reason);
+	if (reason & 0x40000000)
+		pr_err("Fetch error at address %lx\n", regs->nip);
+	else
+		pr_err("Data access error at address %lx\n", regs->dar);
+
+#ifdef CONFIG_PCI
+	/* the qspan pci read routines can cause machine checks -- Cort
+	 *
+	 * yuck !!! that totally needs to go away ! There are better ways
+	 * to deal with that than having a wart in the mcheck handler.
+	 * -- BenH
+	 */
+	bad_page_fault(regs, regs->dar, SIGBUS);
+	return 1;
+#else
+	return 0;
+#endif
+}
-- 
2.13.3
