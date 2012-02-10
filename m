Return-Path: <B13201@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92B63B7267
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Feb 2012 21:05:17 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v3 3/3] KVM: PPC: epapr: install ev_idle hcall for e500 guest
Date: Fri, 10 Feb 2012 18:02:21 +0800
Message-ID: <1328868141-17364-3-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1328868141-17364-2-git-send-email-yu.liu@freescale.com>
References: <1328868141-17364-1-git-send-email-yu.liu@freescale.com>
 <1328868141-17364-2-git-send-email-yu.liu@freescale.com>
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

If the guest hypervisor node contains "has-idle" property.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
v3:
1. apply the hcall idle for all ppc platform
2. add a loop to prevent spurious wakeups

 arch/powerpc/kernel/Makefile     |    2 +-
 arch/powerpc/kernel/epapr.S      |   47 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/epapr_para.c |   14 ++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/kernel/epapr.S

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1e41c76..65e24be 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -134,7 +134,7 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
-obj-$(CONFIG_EPAPR_PARA)	+= epapr_para.o
+obj-$(CONFIG_EPAPR_PARA)	+= epapr_para.o epapr.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
 # Disable GCOV in odd or sensitive code
diff --git a/arch/powerpc/kernel/epapr.S b/arch/powerpc/kernel/epapr.S
new file mode 100644
index 0000000..34cc54f
--- /dev/null
+++ b/arch/powerpc/kernel/epapr.S
@@ -0,0 +1,47 @@
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
+#define HC_VENDOR_EPAPR		(1 << 16)
+#define HC_EV_IDLE		16
+
+_GLOBAL(epapr_ev_idle)
+epapr_ev_idle:
+#ifdef CONFIG_E500
+	rlwinm	r3,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
+	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
+	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
+#endif
+	wrteei	1
+
+idle_loop:
+	LOAD_REG_IMMEDIATE(r11, HC_VENDOR_EPAPR | HC_EV_IDLE)
+
+/* Hypercall entry point. Will be patched with device tree instructions. */
+.global epapr_hypercall_start
+epapr_hypercall_start:
+	li	r3, -1
+	nop
+	nop
+	nop
+
+	/*
+	 * Guard against spurious wakeups (e.g. from a hypervisor) --
+	 * any real interrupt will cause us to return to LR due to
+	 * _TLF_NAPPING.
+	 */
+	b	idle_loop
diff --git a/arch/powerpc/kernel/epapr_para.c b/arch/powerpc/kernel/epapr_para.c
index 7e1561a..ff8fb78 100644
--- a/arch/powerpc/kernel/epapr_para.c
+++ b/arch/powerpc/kernel/epapr_para.c
@@ -20,6 +20,10 @@
 #include <linux/of.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/cacheflush.h>
+#include <asm/machdep.h>
+
+extern void epapr_ev_idle(void);
+extern u32 epapr_hypercall_start[];
 
 u32 *epapr_hcall_insts;
 int epapr_hcall_insts_len;
@@ -28,7 +32,7 @@ static int __init epapr_para_init(void)
 {
 	struct device_node *hyper_node;
 	u32 *insts;
-	int len;
+	int len, i;
 
 	hyper_node = of_find_node_by_path("/hypervisor");
 	if (!hyper_node)
@@ -38,8 +42,16 @@ static int __init epapr_para_init(void)
 	if (!(len % 4) && (len >= (4 * 4))) {
 		epapr_hcall_insts = insts;
 		epapr_hcall_insts_len = len;
+
+		for (i = 0; i < (len / 4); i++)
+			epapr_hypercall_start[i] = insts[i];
+		flush_icache_range((ulong)epapr_hypercall_start,
+		                   (ulong)epapr_hypercall_start + len);
 	}
 
+	if (of_get_property(hyper_node, "has-idle", NULL))
+		ppc_md.power_save = epapr_ev_idle;
+
 	return 0;
 }
 
-- 
1.7.0.4
