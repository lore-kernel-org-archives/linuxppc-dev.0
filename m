Return-Path: <B13201@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7EE13B6EEE
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2012 20:27:49 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v6 1/4] KVM: PPC: epapr: Factor out the epapr init
Date: Thu, 23 Feb 2012 17:22:19 +0800
Message-ID: <1329988942-19610-1-git-send-email-yu.liu@freescale.com>
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
v6:
1. rename epapr_para to epapr_paravirt
2. remove redundant warnings
3. remove unnecessary init

 arch/powerpc/include/asm/epapr_hcalls.h |    2 +
 arch/powerpc/kernel/Makefile            |    1 +
 arch/powerpc/kernel/epapr_hcalls.S      |   25 ++++++++++++++
 arch/powerpc/kernel/epapr_paravirt.c    |   54 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm.c               |   28 ++--------------
 arch/powerpc/kernel/kvm_emul.S          |   10 ------
 arch/powerpc/platforms/Kconfig          |    9 +++++
 7 files changed, 94 insertions(+), 35 deletions(-)
 create mode 100644 arch/powerpc/kernel/epapr_hcalls.S
 create mode 100644 arch/powerpc/kernel/epapr_paravirt.c

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index f3b0c2c..2173d4c 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -148,6 +148,8 @@
 #define EV_HCALL_CLOBBERS2 EV_HCALL_CLOBBERS3, "r5"
 #define EV_HCALL_CLOBBERS1 EV_HCALL_CLOBBERS2, "r4"
 
+extern bool epapr_paravirt_enabled;
+extern u32 epapr_hypercall_start[];
 
 /*
  * We use "uintptr_t" to define a register because it's guaranteed to be a
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ee728e4..ba8fa43 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -136,6 +136,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
+obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
 # Disable GCOV in odd or sensitive code
diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
new file mode 100644
index 0000000..697b390
--- /dev/null
+++ b/arch/powerpc/kernel/epapr_hcalls.S
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
diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
new file mode 100644
index 0000000..45eb439
--- /dev/null
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -0,0 +1,54 @@
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
+#include <asm/code-patching.h>
+
+bool epapr_paravirt_enabled;
+
+static int __init epapr_paravirt_init(void)
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
+	if (!insts)
+		return 0;
+
+	if (!(len % 4) && len <= (4 * 4)) {
+		for (i = 0; i < (len / 4); i++)
+			patch_instruction(epapr_hypercall_start + i, insts[i]);
+
+		epapr_paravirt_enabled = true;
+	} else {
+		printk(KERN_WARNING
+		       "ePAPR paravirt: hcall-instructions format error\n");
+	}
+
+	return 0;
+}
+
+early_initcall(epapr_paravirt_init);
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 62bdf23..1c13307 100644
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
+	if (!epapr_paravirt_enabled)
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
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 0cfb46d..845690f 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -26,6 +26,7 @@ source "arch/powerpc/platforms/wsp/Kconfig"
 config KVM_GUEST
 	bool "KVM Guest support"
 	default n
+	select EPAPR_PARAVIRT
 	---help---
 	  This option enables various optimizations for running under the KVM
 	  hypervisor. Overhead for the kernel when not running inside KVM should
@@ -33,6 +34,14 @@ config KVM_GUEST
 
 	  In case of doubt, say Y
 
+config EPAPR_PARAVIRT
+	bool "ePAPR para-virtualization support"
+	default n
+	help
+	  Used to enalbe ePAPR complied para-virtualization support for guest.
+
+	  In case of doubt, say Y
+
 config PPC_NATIVE
 	bool
 	depends on 6xx || PPC64
-- 
1.7.0.4
