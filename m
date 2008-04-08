Return-Path: <jyoung5@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9B3CDDF50
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 02:49:23 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m38GlLOK010446
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 12:47:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m38GnKBK194456
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 10:49:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m38GnJrL030655
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 10:49:19 -0600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] [v5] Add idle wait support for 44x platforms
Message-Id: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
Date: Tue, 08 Apr 2008 11:49:14 -0500
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

2 files changed, 77 insertions(+), 1 deletion(-)
arch/powerpc/platforms/44x/Makefile |    2 
arch/powerpc/platforms/44x/idle.c   |   76 +++++++++++++++++++++++++++++++++++


Updates: Now setting MSR_WE is now default
         Tested on hardware platforms bamboo & sequioa and appears
         things are working fine on actually hardware!

This patch adds the ability for the CPU to go into wait state while in cpu_idle loop. This helps virtulization solutions know when the guest Linux kernel is in an idle state. There are two ways to do it.

Command line
	idle=spin <-- CPU will spin
	idle=wait <-- set CPU into wait state when idle (default)


Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,4 +1,4 @@ obj-$(CONFIG_44x)	:= misc_44x.o
-obj-$(CONFIG_44x)	:= misc_44x.o
+obj-$(CONFIG_44x)	:= misc_44x.o idle.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_BAMBOO)	+= bamboo.o
diff --git a/arch/powerpc/platforms/44x/idle.c b/arch/powerpc/platforms/44x/idle.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/44x/idle.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright 2008 IBM Corp. 
+ *
+ * Based on arch/powerpc/platforms/pasemi/idle.c: 
+ * Copyright (C) 2006-2007 PA Semi, Inc
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
+#include <linux/kernel.h>
+#include <asm/machdep.h>
+
+static int current_mode;
+
+struct sleep_mode {
+	char *name;
+	void (*entry)(void);
+};
+
+static void ppc44x_idle(void)
+{
+	unsigned long msr_save;
+
+	msr_save = mfmsr();
+	/* set wait state MSR */
+	mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE|MSR_DE);
+	isync();
+	/* return to initial state */
+	mtmsr(msr_save);
+	isync();
+}
+
+static struct sleep_mode modes[] = {
+	{ .name = "wait", .entry = &ppc44x_idle },
+	{ .name = "spin", .entry = NULL },
+};
+
+int __init ppc44x_idle_init(void)
+{
+	void *func = modes[current_mode].entry;
+	ppc_md.power_save = func;
+	return 0;
+}
+
+arch_initcall(ppc44x_idle_init);
+
+static int __init idle_param(char *p)
+{ 
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(modes); i++) {
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
