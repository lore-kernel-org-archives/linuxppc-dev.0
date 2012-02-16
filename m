Return-Path: <B13201@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 80DD3100DAA
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 20:31:35 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v4 1/3] KVM: PPC: epapr: Factor out the epapr init
Date: Thu, 16 Feb 2012 17:26:00 +0800
Message-ID: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Liu Yu <yu.liu@freescale.com>,
 B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

from the kvm guest paravirt init code.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
v4:
1. code cleanup
2. move kvm_hypercall_start() to epapr_hypercall_start()

 arch/powerpc/Kconfig                    |    4 ++
 arch/powerpc/include/asm/epapr_hcalls.h |    2 +
 arch/powerpc/kernel/Makefile            |    1 +
 arch/powerpc/kernel/epapr.S             |   25 ++++++++++++++++
 arch/powerpc/kernel/epapr_para.c        |   49 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm.c               |   28 ++----------------
 arch/powerpc/kernel/kvm_emul.S          |   10 ------
 arch/powerpc/kvm/Kconfig                |    1 +
 8 files changed, 85 insertions(+), 35 deletions(-)
 create mode 100644 arch/powerpc/kernel/epapr.S
 create mode 100644 arch/powerpc/kernel/epapr_para.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1919634..1262b43 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -202,6 +202,10 @@ config EPAPR_BOOT
 	  Used to allow a board to specify it wants an ePAPR compliant wrapper.
 	default n
 
+config EPAPR_PARAVIRT
+	bool
+	default n
+
 config DEFAULT_UIMAGE
 	bool
 	help
diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index f3b0c2c..0ff3f24 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -148,6 +148,8 @@
 #define EV_HCALL_CLOBBERS2 EV_HCALL_CLOBBERS3, "r5"
 #define EV_HCALL_CLOBBERS1 EV_HCALL_CLOBBERS2, "r4"
 
+extern bool epapr_para_enabled;
+extern u32 epapr_hypercall_start[];
 
 /*
  * We use "uintptr_t" to define a register because it's guaranteed to be a
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ee728e4..9e807f3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -136,6 +136,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
+obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_para.o epapr.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
 # Disable GCOV in odd or sensitive code
diff --git a/arch/powerpc/kernel/epapr.S b/arch/powerpc/kernel/epapr.S
new file mode 100644
index 0000000..697b390
--- /dev/null
+++ b/arch/powerpc/kernel/epapr.S
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/threads.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+/* Hypercall entry point. Will be patched with device tree instructions. */
+.global epapr_hypercall_start
+epapr_hypercall_start:
+	li	r3, -1
+	nop
+	nop
+	nop
+	blr
diff --git a/arch/powerpc/kernel/epapr_para.c b/arch/powerpc/kernel/epapr_para.c
new file mode 100644
index 0000000..ea13cac
--- /dev/null
+++ b/arch/powerpc/kernel/epapr_para.c
@@ -0,0 +1,49 @@
+/*
+ * ePAPR para-virtualization support.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ */
+
+#include <linux/of.h>
+#include <asm/epapr_hcalls.h>
+#include <asm/cacheflush.h>
+
+bool epapr_para_enabled = false;
+
+static int __init epapr_para_init(void)
+{
+	struct device_node *hyper_node;
+	const u32 *insts;
+	int len, i;
+
+	hyper_node = of_find_node_by_path("/hypervisor");
+	if (!hyper_node)
+		return -ENODEV;
+
+	insts = of_get_property(hyper_node, "hcall-instructions", &len);
+	if (!(len % 4) && (len >= (4 * 4))) {
+		for (i = 0; i < (len / 4); i++)
+			epapr_hypercall_start[i] = insts[i];
+		flush_icache_range((ulong)epapr_hypercall_start,
+		                   (ulong)epapr_hypercall_start + len);
+
+		epapr_para_enabled = true;
+	}
+
+	return 0;
+}
+
+early_initcall(epapr_para_init);
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 62bdf23..9dfc24a 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -31,6 +31,7 @@
 #include <asm/cacheflush.h>
 #include <asm/disassemble.h>
 #include <asm/ppc-opcode.h>
+#include <asm/epapr_hcalls.h>
 
 #define KVM_MAGIC_PAGE		(-4096L)
 #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
@@ -726,7 +727,7 @@ unsigned long kvm_hypercall(unsigned long *in,
 	unsigned long register r11 asm("r11") = nr;
 	unsigned long register r12 asm("r12");
 
-	asm volatile("bl	kvm_hypercall_start"
+	asm volatile("bl	epapr_hypercall_start"
 		     : "=r"(r0), "=r"(r3), "=r"(r4), "=r"(r5), "=r"(r6),
 		       "=r"(r7), "=r"(r8), "=r"(r9), "=r"(r10), "=r"(r11),
 		       "=r"(r12)
@@ -747,29 +748,6 @@ unsigned long kvm_hypercall(unsigned long *in,
 }
 EXPORT_SYMBOL_GPL(kvm_hypercall);
 
-static int kvm_para_setup(void)
-{
-	extern u32 kvm_hypercall_start;
-	struct device_node *hyper_node;
-	u32 *insts;
-	int len, i;
-
-	hyper_node = of_find_node_by_path("/hypervisor");
-	if (!hyper_node)
-		return -1;
-
-	insts = (u32*)of_get_property(hyper_node, "hcall-instructions", &len);
-	if (len % 4)
-		return -1;
-	if (len > (4 * 4))
-		return -1;
-
-	for (i = 0; i < (len / 4); i++)
-		kvm_patch_ins(&(&kvm_hypercall_start)[i], insts[i]);
-
-	return 0;
-}
-
 static __init void kvm_free_tmp(void)
 {
 	unsigned long start, end;
@@ -791,7 +769,7 @@ static int __init kvm_guest_init(void)
 	if (!kvm_para_available())
 		goto free_tmp;
 
-	if (kvm_para_setup())
+	if (!epapr_para_enabled)
 		goto free_tmp;
 
 	if (kvm_para_has_feature(KVM_FEATURE_MAGIC_PAGE))
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index e291cf3..62ceb2a 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -24,16 +24,6 @@
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
 
-/* Hypercall entry point. Will be patched with device tree instructions. */
-
-.global kvm_hypercall_start
-kvm_hypercall_start:
-	li	r3, -1
-	nop
-	nop
-	nop
-	blr
-
 #define KVM_MAGIC_PAGE		(-4096)
 
 #ifdef CONFIG_64BIT
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 8f64709..9bb9d18 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -20,6 +20,7 @@ config KVM
 	bool
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
+	select EPAPR_PARAVIRT
 
 config KVM_BOOK3S_HANDLER
 	bool
-- 
1.7.0.4
