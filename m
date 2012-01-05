Return-Path: <B13201@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D2DAF1007D7
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2012 20:57:30 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/3] KVM: PPC: epapr: Factor out the epapr init
Date: Thu, 5 Jan 2012 17:06:51 +0800
Message-ID: <1325754412-29963-1-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
 Liu Yu <yu.liu@freescale.com>, timur@freescale.com
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
 arch/powerpc/include/asm/epapr_hcalls.h |    8 +++++
 arch/powerpc/kernel/Makefile            |    1 +
 arch/powerpc/kernel/epapr_para.c        |   45 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm.c               |    9 +++++-
 4 files changed, 62 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/kernel/epapr_para.c

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
index ce4f7f1..1052bbc 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -134,6 +134,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
+obj-$(CONFIG_BOOKE)		+= epapr_para.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
 # Disable GCOV in odd or sensitive code
diff --git a/arch/powerpc/kernel/epapr_para.c b/arch/powerpc/kernel/epapr_para.c
new file mode 100644
index 0000000..714dcb3
--- /dev/null
+++ b/arch/powerpc/kernel/epapr_para.c
@@ -0,0 +1,45 @@
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
index b06bdae..82a9137 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -28,6 +28,7 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/disassemble.h>
+#include <asm/epapr_hcalls.h>
 
 #define KVM_MAGIC_PAGE		(-4096L)
 #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct kvm_vcpu_arch_shared, x)
@@ -535,9 +536,10 @@ EXPORT_SYMBOL_GPL(kvm_hypercall);
 static int kvm_para_setup(void)
 {
 	extern u32 kvm_hypercall_start;
-	struct device_node *hyper_node;
 	u32 *insts;
 	int len, i;
+#ifndef CONFIG_BOOKE
+	struct device_node *hyper_node;
 
 	hyper_node = of_find_node_by_path("/hypervisor");
 	if (!hyper_node)
@@ -548,6 +550,11 @@ static int kvm_para_setup(void)
 		return -1;
 	if (len > (4 * 4))
 		return -1;
+#else
+	epapr_get_hcall_insts(&insts, &len);
+	if (insts == NULL)
+		return -1;
+#endif	/* !BOOKE */
 
 	for (i = 0; i < (len / 4); i++)
 		kvm_patch_ins(&(&kvm_hypercall_start)[i], insts[i]);
-- 
1.6.4
