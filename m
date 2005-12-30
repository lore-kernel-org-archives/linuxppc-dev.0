Return-Path: <grant.likely@secretlab.ca>
Received: from localhost.localdomain (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8188668982
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 21:51:14 +1100 (EST)
In-Reply-To: <11359385973413-git-send-email-grant.likely@secretlab.ca>
Date: Fri, 30 Dec 2005 03:29:58 -0700
Message-Id: <1135938598335-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org, linuxppc-embedded@ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/8] Move xparameters.h into xilinx specific directory
Reply-To: Grant Likely <grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Move xparameters.h out of common include/asm-ppc into xilinx specific
platforms/4xx/xparameters directory.

This is preparing for work to remove xparameters from the dependancy tree
for most c files.  xparam changes should not cause a recompile of the world

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/platforms/4xx/virtex-ii_pro.h           |    2 +-
 arch/ppc/platforms/4xx/xparameters/xparameters.h |   18 ++++++++++++++++++
 arch/ppc/syslib/xilinx_pic.c                     |    2 +-
 include/asm-ppc/xparameters.h                    |   18 ------------------
 4 files changed, 20 insertions(+), 20 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters.h
 delete mode 100644 include/asm-ppc/xparameters.h

b7877de00f68dcca5c595edf387ac314c888d5e8
diff --git a/arch/ppc/platforms/4xx/virtex-ii_pro.h b/arch/ppc/platforms/4xx/virtex-ii_pro.h
index 9014c48..026130c 100644
--- a/arch/ppc/platforms/4xx/virtex-ii_pro.h
+++ b/arch/ppc/platforms/4xx/virtex-ii_pro.h
@@ -16,7 +16,7 @@
 #define __ASM_VIRTEXIIPRO_H__
 
 #include <linux/config.h>
-#include <asm/xparameters.h>
+#include <platforms/4xx/xparameters/xparameters.h>
 
 /* serial defines */
 
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/platforms/4xx/xparameters/xparameters.h
new file mode 100644
index 0000000..fe4eac6
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -0,0 +1,18 @@
+/*
+ * include/asm-ppc/xparameters.h
+ *
+ * This file includes the correct xparameters.h for the CONFIG'ed board
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2004 (c) MontaVista Software, Inc.  This file is licensed under the terms
+ * of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+
+#if defined(CONFIG_XILINX_ML300)
+#include <platforms/4xx/xparameters/xparameters_ml300.h>
+#endif
diff --git a/arch/ppc/syslib/xilinx_pic.c b/arch/ppc/syslib/xilinx_pic.c
index 2cbcad2..38416d7 100644
--- a/arch/ppc/syslib/xilinx_pic.c
+++ b/arch/ppc/syslib/xilinx_pic.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <asm/io.h>
-#include <asm/xparameters.h>
+#include <platforms/4xx/xparameters/xparameters.h>
 #include <asm/ibm4xx.h>
 
 /* No one else should require these constants, so define them locally here. */
diff --git a/include/asm-ppc/xparameters.h b/include/asm-ppc/xparameters.h
deleted file mode 100644
index fe4eac6..0000000
--- a/include/asm-ppc/xparameters.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * include/asm-ppc/xparameters.h
- *
- * This file includes the correct xparameters.h for the CONFIG'ed board
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2004 (c) MontaVista Software, Inc.  This file is licensed under the terms
- * of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#include <linux/config.h>
-
-#if defined(CONFIG_XILINX_ML300)
-#include <platforms/4xx/xparameters/xparameters_ml300.h>
-#endif
-- 
1.0.6-g58e3
