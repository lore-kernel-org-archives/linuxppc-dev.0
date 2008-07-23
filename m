Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2122BDDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 18:36:54 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6N8al0j115080
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:36:47 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6N8alvx4157494
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6N8alUa021856
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
From: ehrhardt@linux.vnet.ibm.com
To: kvm-ppc@vger.kernel.org, embedded-hypervisor@power.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 1/6] kvmppc: read device tree hypervisor node infrastructure
Date: Wed, 23 Jul 2008 10:36:42 +0200
Message-Id: <1216802207-32675-2-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This patch adds the guest portion of the device tree based host->guest
communication. Using the device tree infrastructure this patch implements
kvm_para_available and kvm_arch_para_features (in this patch just the
infrastructure, no specific feature registered).

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 arch/powerpc/kernel/Makefile       |    2 ++
 arch/powerpc/kernel/kvm.c          |   30 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c     |    3 +++
 arch/powerpc/platforms/44x/Kconfig |    7 +++++++
 include/asm-powerpc/kvm_para.h     |   37 ++++++++++++++++++++++++++++++++++---
 5 files changed, 76 insertions(+), 3 deletions(-)

[diff]

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -80,6 +80,8 @@
 
 obj-$(CONFIG_8XX_MINIMAL_FPEMU) += softemu8xx.o
 
+obj-$(CONFIG_KVM_GUEST)		+= kvm.o
+
 ifneq ($(CONFIG_PPC_INDIRECT_IO),y)
 obj-y				+= iomap.o
 endif
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/kernel/kvm.c
@@ -0,0 +1,30 @@
+/*
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
+ * Copyright IBM Corp. 2008
+ *
+ * Authors:
+ * 	Hollis Blanchard <hollisb@us.ibm.com>
+ * 	Christian Ehrhardt <ehrhardt@de.ibm.com>
+ */
+
+#include <linux/percpu.h>
+#include <linux/mm.h>
+#include <linux/kvm_para.h>
+
+void __init kvm_guest_init(void)
+{
+	if (!kvm_para_available())
+		return;
+}
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/console.h>
 #include <linux/lmb.h>
+#include <linux/kvm_para.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -319,5 +320,7 @@
 		ppc_md.setup_arch();
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
 
+	kvm_guest_init();
+
 	paging_init();
 }
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -152,3 +152,10 @@
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
+
+config KVM_GUEST
+	bool "KVM Guest support"
+	depends on EXPERIMENTAL
+	help
+	This option enables various optimizations for running under the KVM
+	hypervisor.
diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
--- a/include/asm-powerpc/kvm_para.h
+++ b/include/asm-powerpc/kvm_para.h
@@ -14,7 +14,9 @@
  *
  * Copyright IBM Corp. 2008
  *
- * Authors: Hollis Blanchard <hollisb@us.ibm.com>
+ * Authors:
+ * 	Hollis Blanchard <hollisb@us.ibm.com>
+ * 	Christian Ehrhardt <ehrhardt@de.ibm.com>
  */
 
 #ifndef __POWERPC_KVM_PARA_H__
@@ -22,15 +24,44 @@
 
 #ifdef __KERNEL__
 
+#include <linux/of.h>
+
+static struct kvmppc_para_features {
+	char *dtcell;
+	int feature;
+} para_features[] = {
+};
+
 static inline int kvm_para_available(void)
 {
-	return 0;
+	struct device_node *dn;
+
+	dn = of_find_node_by_path("/hypervisor");
+
+	return !!dn;
 }
 
 static inline unsigned int kvm_arch_para_features(void)
 {
-	return 0;
+	struct device_node *dn;
+	const int *dtval;
+	unsigned int features = 0;
+	int i;
+
+	dn = of_find_node_by_path("/hypervisor");
+	if (!dn)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(para_features)-1; i++) {
+		dtval = of_get_property(dn, para_features[i].dtcell, NULL);
+		if (dtval && *dtval == 1)
+			features |= (1 << para_features[i].feature);
+	}
+
+	return features;
 }
+
+void kvm_guest_init(void);
 
 #endif /* __KERNEL__ */
 
