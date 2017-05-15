Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRLVM6Tn5zDqQJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 23:08:11 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FD3onB059688
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:03 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afc2xtwrt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:02 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Mon, 15 May 2017 14:08:00 +0100
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@ozlabs.au.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/4] arch/powerpc/44x/fsp2: platform support for fsp2(476fpe)
 board
Date: Mon, 15 May 2017 16:07:51 +0300
Message-Id: <20170515130754.59363-2-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add platform code support for FSP2 (476fpe) board.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig  |   12 +++++++
 arch/powerpc/platforms/44x/Makefile |    1 +
 arch/powerpc/platforms/44x/fsp2.c   |   62 +++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/fsp2.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 9b0afe9..01cb109 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -199,6 +199,18 @@ config CURRITUCK
 	help
 	  This option enables support for the IBM Currituck (476fpe) evaluation board
 
+config FSP2
+	bool "IBM FSP2 (476fpe) Support"
+	depends on PPC_47x
+	default n
+	select 476FPE
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_RGMII if IBM_EMAC
+	select COMMON_CLK
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the IBM FSP2 (476fpe) board
+
 config AKEBONO
 	bool "IBM Akebono (476gtr) Support"
 	depends on PPC_47x
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 26d35b5..72b8241 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_ISS4xx)	+= iss4xx.o
 obj-$(CONFIG_CANYONLANDS)+= canyonlands.o
 obj-$(CONFIG_CURRITUCK)	+= ppc476.o
 obj-$(CONFIG_AKEBONO)	+= ppc476.o
+obj-$(CONFIG_FSP2)	+= fsp2.o
diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
new file mode 100644
index 0000000..92e9804
--- /dev/null
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -0,0 +1,62 @@
+/*
+ * FSP-2 board specific routines
+ *
+ * Based on earlier code:
+ *    Matt Porter <mporter@kernel.crashing.org>
+ *    Copyright 2002-2005 MontaVista Software Inc.
+ *
+ *    Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *    Copyright (c) 2003-2005 Zultys Technologies
+ *
+ *    Rewritten and ported to the merged powerpc tree:
+ *    Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/rtc.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/ppc4xx.h>
+
+static __initdata struct of_device_id fsp2_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,plb6", },
+	{ .compatible = "ibm,opb", },
+	{},
+};
+
+static int __init fsp2_device_probe(void)
+{
+	of_platform_bus_probe(NULL, fsp2_of_bus, NULL);
+	return 0;
+}
+machine_device_initcall(fsp2, fsp2_device_probe);
+
+static int __init fsp2_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,fsp2"))
+		return 0;
+	return 1;
+}
+
+define_machine(fsp2) {
+	.name			= "FSP-2",
+	.probe			= fsp2_probe,
+	.progress		= udbg_progress,
+	.init_IRQ		= uic_init_tree,
+	.get_irq		= uic_get_irq,
+	.restart		= ppc4xx_reset_system,
+	.calibrate_decr		= generic_calibrate_decr,
+};
-- 
1.7.1
