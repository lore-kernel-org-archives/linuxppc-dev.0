Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3A08DE373
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 03:57:23 +1100 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l9UGu6mM022102
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 19:56:06 +0300
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l9UGu6Sn022099
	for linuxppc-dev@ozlabs.org; Tue, 30 Oct 2007 19:56:06 +0300
Date: Tue, 30 Oct 2007 19:56:06 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] PowerPC: 440GRx Rainier bootwrapper.
Message-ID: <20071030165606.GA22028@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071030164511.GA21973@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bootwrapper code for PowerPC 440GRx Rainier board.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/Makefile         |    3 +
 arch/powerpc/boot/cuboot-rainier.c |   56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff -pruN linux-2.6.orig/arch/powerpc/boot/cuboot-rainier.c linux-2.6/arch/powerpc/boot/cuboot-rainier.c
--- linux-2.6.orig/arch/powerpc/boot/cuboot-rainier.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/arch/powerpc/boot/cuboot-rainier.c	2007-10-30 18:00:15.000000000 +0300
@@ -0,0 +1,56 @@
+/*
+ * Old U-boot compatibility for Rainier
+ *
+ * Valentine Barshak <vbarshak@ru.mvista.com>
+ * Copyright 2007 MontaVista Software, Inc
+ *
+ * Based on Ebony code by David Gibson <david@gibson.dropbear.id.au>
+ * Copyright IBM Corporation, 2007
+ *
+ * Based on Bamboo code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright IBM Corporation, 2007
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the License
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_4xx
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+
+static void rainier_fixups(void)
+{
+	unsigned long sysclk = 33333333;
+
+	ibm440ep_fixup_clocks(sysclk, 11059200);
+	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
+	ibm4xx_denali_fixup_memsize();
+	dt_fixup_mac_addresses(&bd.bi_enetaddr, &bd.bi_enet1addr);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	platform_ops.fixups = rainier_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	ft_init(_dtb_start, 0, 32);
+	serial_console_init();
+}
diff -pruN linux-2.6.orig/arch/powerpc/boot/Makefile linux-2.6/arch/powerpc/boot/Makefile
--- linux-2.6.orig/arch/powerpc/boot/Makefile	2007-10-30 17:44:27.000000000 +0300
+++ linux-2.6/arch/powerpc/boot/Makefile	2007-10-30 18:00:15.000000000 +0300
@@ -56,7 +56,7 @@ src-plat := of.c cuboot-52xx.c cuboot-83
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c
+		fixed-head.S ep88xc.c cuboot-hpc2.c cuboot-rainier.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -158,6 +158,7 @@ image-$(CONFIG_MPC7448HPC2)		+= cuImage.
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
+image-$(CONFIG_RAINIER)			+= cuImage.rainier
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 endif
 
