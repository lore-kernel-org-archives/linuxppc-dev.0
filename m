Return-Path: <B13201@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21B2AB6F9C
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Feb 2012 21:05:12 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v3 1/3] KVM: PPC: epapr: Factor out the epapr init
Date: Fri, 10 Feb 2012 18:02:19 +0800
Message-ID: <1328868141-17364-1-git-send-email-yu.liu@freescale.com>
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
v3:
apply the epapr init for all ppc platform

 arch/powerpc/Kconfig                    |    4 +++
 arch/powerpc/include/asm/epapr_hcalls.h |    8 +++++
 arch/powerpc/kernel/Makefile            |    1 +
 arch/powerpc/kernel/epapr_para.c        |   46 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm.c               |   13 +++------
 arch/powerpc/kvm/Kconfig                |    1 +
 6 files changed, 64 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/kernel/epapr_para.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 47682b6..00bd508 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -196,6 +196,10 @@ config EPAPR_BOOT
 	  Used to allow a board to specify it wants an ePAPR compliant wrapper.
 	default n
 
+config EPAPR_PARA
+	bool
+	default n
+
 config DEFAULT_UIMAGE
 	bool
 	help
diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index f3b0c2c..c4b86e4 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -148,6 +148,14 @@
 #define EV_HCALL_CLOBBERS2 EV_HCALL_CLOBBERS3, "r5"
 #define EV_HCALL_CLOBBERS1 EV_HCALL_CLOBBERS2, "r4"
 
+extern u32 *epapr_hcall_insts;
+extern int epapr_hcall_insts_len;
+
+static inline void epapr_get_hcall_insts(u32 **instp, int *lenp)
+{
+	*instp = epapr_hcall_insts;
+	*lenp = epapr_hcall_insts_len;
+}
 
 /*
  * We use "uintptr_t" to define a register because it's guaranteed to be a
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ce4f7f1..1e41c76 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -134,6 +134,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
+obj-$(CONFIG_EPAPR_PARA)	+= epapr_para.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
 # Disable GCOV in odd or sensitive code
diff --git a/arch/powerpc/kernel/epapr_para.c b/arch/powerpc/kernel/epapr_para.c
new file mode 100644
index 0000000..7e1561a
--- /dev/null
+++ b/arch/powerpc/kernel/epapr_para.c
@@ -0,0 +1,46 @@
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
+u32 *epapr_hcall_insts;
+int epapr_hcall_insts_len;
+
+static int __init epapr_para_init(void)
+{
+	struct device_node *hyper_node;
+	u32 *insts;
+	int len;
+
+	hyper_node = of_find_node_by_path("/hypervisor");
+	if (!hyper_node)
+		return -ENODEV;
+
+	insts = (u32*)of_get_property(hyper_node, "hcall-instructions", &len);
+	if (!(len % 4) && (len >= (4 * 4))) {
+		epapr_hcall_insts = insts;
+		epapr_hcall_insts_len = len;
+	}
+
+	return 0;
+}
+
+early_initcall(epapr_para_init);
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index b06bdae..2e03ab8 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -28,6 +28,7 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/disassemble.h>
+#include <asm/epapr_hcalls.h>
 
 #define KVM_MAGIC_PAGE		(-4096L)
 #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
@@ -535,18 +536,12 @@ EXPORT_SYMBOL_GPL(kvm_hypercall);
 static int kvm_para_setup(void)
 {
 	extern u32 kvm_hypercall_start;
-	struct device_node *hyper_node;
 	u32 *insts;
 	int len, i;
 
-	hyper_node = of_find_node_by_path("/hypervisor");
-	if (!hyper_node)
-		return -1;
-
-	insts = (u32*)of_get_property(hyper_node, "hcall-instructions", &len);
-	if (len % 4)
-		return -1;
-	if (len > (4 * 4))
+	insts = epapr_hcall_insts;
+	len = epapr_hcall_insts_len;
+	if (insts == NULL)
 		return -1;
 
 	for (i = 0; i < (len / 4); i++)
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 78133de..cd1ee68 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -20,6 +20,7 @@ config KVM
 	bool
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
+	select EPAPR_PARA
 
 config KVM_BOOK3S_HANDLER
 	bool
-- 
1.7.0.4
