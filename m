Return-Path: <jyoung5@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5EB80DDF4E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 09:43:15 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m33MhBOk029706
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 18:43:11 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m33MhBKw238310
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 18:43:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m33MhBL6017433
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 18:43:11 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Add idle wait support for 44x platforms
Message-Id: <7226bef216680748a503.1207262582@thinkpadL>
Date: Thu, 03 Apr 2008 17:43:02 -0500
From: Jerone Young <jyoung5@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

# HG changeset patch
# User Jerone Young <jyoung5@us.ibm.com>
# Date 1207262487 18000
# Node ID 7226bef216680748a50327900572c2fbc3e762b0
# Parent  a5b2aebbc6ebd2439c655f1c047ed7e3c1991ec1
Add idle wait support for 44x platforms

This patch adds the ability for the CPU to go into wait state while in cpu_idle loop. This helps virtulization solutions know when the guest Linux kernel is in an idle state. There are two ways to do it.

1) Command line
	idle=spin <-- CPU will spin (this is the default)
	idle=wait <-- set CPU into wait state when idle

2) The device tree will be checked for the "/hypervisor" node
   If this node is seen it will use "wait" for idle, so that
   the hypervisor can know when guest Linux kernel it is in
   an idle state.

This patch, unlike the last, isolates the code to 44x platforms.

Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

diff --git a/arch/powerpc/platforms/44x/44x.h b/arch/powerpc/platforms/44x/44x.h
--- a/arch/powerpc/platforms/44x/44x.h
+++ b/arch/powerpc/platforms/44x/44x.h
@@ -5,4 +5,6 @@ extern void as1_writeb(u8 data, volatile
 extern void as1_writeb(u8 data, volatile u8 __iomem *addr);
 extern void ppc44x_reset_system(char *cmd);
 
+extern int ppc44x_idle_init(void);
+
 #endif /* __POWERPC_PLATFORMS_44X_44X_H */
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,4 +1,5 @@ obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_44x)	:= misc_44x.o
+obj-$(CONFIG_44x)	+= idle.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_BAMBOO)	+= bamboo.o
diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
--- a/arch/powerpc/platforms/44x/bamboo.c
+++ b/arch/powerpc/platforms/44x/bamboo.c
@@ -61,3 +61,5 @@ define_machine(bamboo) {
 	.restart			= ppc44x_reset_system,
 	.calibrate_decr 	= generic_calibrate_decr,
 };
+
+machine_late_initcall(bamboo, ppc44x_idle_init);
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
--- a/arch/powerpc/platforms/44x/canyonlands.c
+++ b/arch/powerpc/platforms/44x/canyonlands.c
@@ -62,3 +62,5 @@ define_machine(canyonlands) {
 	.restart			= ppc44x_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
+
+machine_late_initcall(canyonlands, ppc44x_idle_init);
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -69,3 +69,5 @@ define_machine(ebony) {
 	.restart		= ppc44x_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
 };
+
+machine_late_initcall(ebony, ppc44x_idle_init);
diff --git a/arch/powerpc/platforms/44x/idle.c b/arch/powerpc/platforms/44x/idle.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/44x/idle.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2008 IBM Corp. 
+ *
+ * Added by: Jerone Young <jyoung5@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/of.h>
+#include <asm/machdep.h>
+
+static void ppc44x_idle(void);
+
+struct sleep_mode {
+	char *name;
+	void (*entry)(void);
+};
+
+static struct sleep_mode modes[] = {
+	{ .name = "spin", .entry = NULL },
+	{ .name = "wait", .entry = &ppc44x_idle },
+};
+
+static int current_mode = 0;
+
+static void ppc44x_idle(void)
+{
+	unsigned long msr_save;
+
+	msr_save = mfmsr();
+	/* set wait state MSR */
+	mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE);
+	/* return to initial state */
+	mtmsr(msr_save);
+}
+
+int __init ppc44x_idle_init(void)
+{
+	if(of_find_node_by_path("/hypervisor") != NULL) {
+		/* if we find /hypervisor node is in device tree,
+		   set idle mode to wait */
+		current_mode = 1; /* wait mode */
+	}
+
+	ppc_md.power_save = modes[current_mode].entry;
+	return 0;
+}
+
+static int __init idle_param(char *p)
+{ 
+	int i;
+
+	for (i = 0; i < sizeof(modes)/sizeof(struct sleep_mode); i++) {
+		if (!strcmp(modes[i].name, p)) {
+			current_mode = i;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+early_param("idle", idle_param);
diff --git a/arch/powerpc/platforms/44x/katmai.c b/arch/powerpc/platforms/44x/katmai.c
--- a/arch/powerpc/platforms/44x/katmai.c
+++ b/arch/powerpc/platforms/44x/katmai.c
@@ -61,3 +61,5 @@ define_machine(katmai) {
 	.restart			= ppc44x_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
+
+machine_late_initcall(katmai, ppc44x_idle_init);
diff --git a/arch/powerpc/platforms/44x/rainier.c b/arch/powerpc/platforms/44x/rainier.c
--- a/arch/powerpc/platforms/44x/rainier.c
+++ b/arch/powerpc/platforms/44x/rainier.c
@@ -60,3 +60,5 @@ define_machine(rainier) {
 	.restart			= ppc44x_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
+
+machine_late_initcall(rainier, ppc44x_idle_init);
diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
--- a/arch/powerpc/platforms/44x/sequoia.c
+++ b/arch/powerpc/platforms/44x/sequoia.c
@@ -61,3 +61,5 @@ define_machine(sequoia) {
 	.restart			= ppc44x_reset_system,
 	.calibrate_decr			= generic_calibrate_decr,
 };
+
+machine_late_initcall(sequoia, ppc44x_idle_init);
diff --git a/arch/powerpc/platforms/44x/taishan.c b/arch/powerpc/platforms/44x/taishan.c
--- a/arch/powerpc/platforms/44x/taishan.c
+++ b/arch/powerpc/platforms/44x/taishan.c
@@ -71,3 +71,5 @@ define_machine(taishan) {
 	.restart		= ppc44x_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
 };
+
+machine_late_initcall(taishan, ppc44x_idle_init);
