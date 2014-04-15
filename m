Return-Path: <Dongsheng.Wang@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 419C51400E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 15:56:22 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v2 1/2] fsl/corenet_generic: add a particular initialization
 for platform
Date: Tue, 15 Apr 2014 13:53:48 +0800
Message-ID: <1397541229-34383-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, haokexin@gmail.com, prabhakar@freescale.com,
 jason.jin@freescale.com, Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Corenet_generic is a generic platform initialization. Those based on
the corenet_generic board maybe need a particular initialize to
enable/set some IP-Blocks. So add "Fix Generic Initialization" to solve
this kind of special cases.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v2*
 1/ Split DIU code.
 2/ make fix.c as a independent driver.
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index c17aae8..fce2341 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -269,6 +269,17 @@ config CORENET_GENERIC
 	  The following boards are supported for both 32bit and 64bit kernel:
 	    P5020 DS and P5040 DS
 
+config FIX_GENERIC_PLATFORM_INIT
+	bool "Fix Generic Initialization"
+	depends on CORENET_GENERIC
+	default y
+	help
+	  This option will create a initialization that is a append initialization
+	  for a particular platfrom. And this particular platform also based on
+	  "Freescale CoreNet Generic".
+
+	  e.g. DIU need a special initialization at T104x platform.
+
 endif # FSL_SOC_BOOKE
 
 config TQM85xx
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 25cebe7..1162ac7 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
 obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
 obj-$(CONFIG_TWR_P102x)   += twr_p102x.o
 obj-$(CONFIG_CORENET_GENERIC)   += corenet_generic.o
+obj-$(CONFIG_FIX_GENERIC_PLATFORM_INIT) += fix/
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
diff --git a/arch/powerpc/platforms/85xx/fix/Makefile b/arch/powerpc/platforms/85xx/fix/Makefile
new file mode 100644
index 0000000..a8e8154
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/fix/Makefile
@@ -0,0 +1 @@
+obj-y += fix.o
diff --git a/arch/powerpc/platforms/85xx/fix/fix.c b/arch/powerpc/platforms/85xx/fix/fix.c
new file mode 100644
index 0000000..7b59a52
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/fix/fix.c
@@ -0,0 +1,26 @@
+/*
+ * Fix Different Boards Particular Initialization
+ *
+ * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/mpc85xx.h>
+#include <asm/reg.h>
+#include <asm/reg_booke.h>
+
+#include "fix.h"
+
+static int fix_platform_init(void)
+{
+	return 0;
+}
+early_initcall(fix_platform_init);
diff --git a/arch/powerpc/platforms/85xx/fix/fix.h b/arch/powerpc/platforms/85xx/fix/fix.h
new file mode 100644
index 0000000..5a8c80e3
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/fix/fix.h
@@ -0,0 +1,4 @@
+#ifndef __CORENET_GENERIC_FIX_H__
+#define __CORENET_GENERIC_FIX_H__
+
+#endif
-- 
1.8.5
