Return-Path: <bgill@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D7A5E68A15
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 14:27:38 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k183Zfvp022670
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 20:35:41 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k183WhxB008542
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:32:44 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (cde-tx32-ldt329 [10.82.19.206])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	k183OFkY022246
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:24:15 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (localhost [127.0.0.1])
	by cde-tx32-ldt329.sps.mot.com (Postfix) with ESMTP id 7E20AC2DD7
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2006 21:27:34 -0600 (CST)
Received: from localhost (bgill@localhost)
	by cde-tx32-ldt329.sps.mot.com (8.12.11/8.12.11/Submit) with ESMTP id
	k183RYfc003984
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:27:34 -0600
Date: Tue, 7 Feb 2006 21:27:34 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: rename mpc85xx.c to misc.c
Message-ID: <Pine.LNX.4.61.0602072122550.3872@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename mpc85xx.c to misc.c to match the pattern established by the
8349 port - consistency is a good thing.  Also run Lindent on the
file to clean it up.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 45b8d5cae619e9dc58ccf5d880999d7517e82b58
tree 0a1b2b8fc7b3133fa877449639017df9335e9f03
parent f0a2dc035ebf50418e699f789f5c7523092ff553
author Becky Bruce <becky.bruce@freescale.com> Tue, 07 Feb 2006 21:00:56 -0600
committer Becky Bruce <becky.bruce@freescale.com> Tue, 07 Feb 2006 21:00:56 -0600

 arch/powerpc/platforms/85xx/Makefile  |    2 +-
 arch/powerpc/platforms/85xx/misc.c    |   31 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx.c |   31 -------------------------------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index b443206..70e1190 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -1,4 +1,4 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
-obj-$(CONFIG_PPC_85xx)	+= mpc85xx.o mpc85xx_ads.o
+obj-$(CONFIG_PPC_85xx)	+= misc.o mpc85xx_ads.o
diff --git a/arch/powerpc/platforms/85xx/misc.c b/arch/powerpc/platforms/85xx/misc.c
new file mode 100644
index 0000000..26c5e82
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/misc.c
@@ -0,0 +1,31 @@
+/*
+ * MPC85xx generic code.
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <asm/irq.h>
+
+extern void abort(void);
+
+void mpc85xx_restart(char *cmd)
+{
+	local_irq_disable();
+	abort();
+}
+
+/* For now this is a pass through */
+phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
+{
+	return addr;
+};
+
+EXPORT_SYMBOL(fixup_bigphys_addr);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.c b/arch/powerpc/platforms/85xx/mpc85xx.c
deleted file mode 100644
index 8251038..0000000
--- a/arch/powerpc/platforms/85xx/mpc85xx.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * MPC85xx generic code.
- *
- * Maintained by Kumar Gala (see MAINTAINERS for contact information)
- *
- * Copyright 2005 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/irq.h>
-#include <linux/module.h>
-#include <asm/irq.h>
-
-extern void abort(void);
-
-void
-mpc85xx_restart(char *cmd)
-{
-	local_irq_disable();
-	abort();
-}
-
-/* For now this is a pass through */
-phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
-{
-	return addr;
-};
-EXPORT_SYMBOL(fixup_bigphys_addr);
