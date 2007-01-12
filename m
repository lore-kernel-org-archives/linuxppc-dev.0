Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02090DE0CB
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 12:11:15 +1100 (EST)
Date: Fri, 12 Jan 2007 10:11:10 +0900 (JST)
Message-Id: <200701120111.l0C1BBBI005513@toshiba.co.jp>
Subject: [PATCH 11/19] powerpc: setup usb host controller in SCC for Celleb
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

USB host controller in SCC requires enable sequence. It should be done
before USB host drivers start.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_uhc.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/scc_uhc.c:1.4
--- /dev/null	Thu Jan 11 22:03:27 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_uhc.c	Thu Jan 11 22:02:21 2007
@@ -0,0 +1,90 @@
+/*
+ * SCC (Super Companion Chip) UHC setup
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+
+#include "scc.h"
+
+#define UHC_RESET_WAIT_MAX 10000
+
+static inline int uhc_clkctrl_ready(u32 val)
+{
+	const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBCEN;
+	return((val & mask) == mask);
+}
+
+/*
+ * UHC(usb host controler) enable function.
+ * affect to both of OHCI and EHCI core module.
+ */
+static void enable_scc_uhc(struct pci_dev *dev)
+{
+	void __iomem *uhc_base;
+	u32 __iomem *uhc_clkctrl;
+	u32 __iomem *uhc_ecmode;
+	u32 val = 0;
+	int i;
+
+	uhc_base = ioremap(pci_resource_start(dev, 0),
+			   pci_resource_len(dev, 0));
+	if (!uhc_base) {
+		printk(KERN_ERR "failed to map UHC register base.\n");
+		return;
+	}
+	uhc_clkctrl = uhc_base + SCC_UHC_CKRCTRL; 
+	uhc_ecmode  = uhc_base + SCC_UHC_ECMODE; 
+
+	/* setup for normal mode */
+	val |= SCC_UHC_F48MCKLEN;
+	out_be32(uhc_clkctrl, val);
+	val |= SCC_UHC_PHY_SUSPEND_SEL;
+	out_be32(uhc_clkctrl, val);
+	udelay(10);
+	val |= SCC_UHC_PHYEN;
+	out_be32(uhc_clkctrl, val);
+	udelay(50);
+
+	/* disable reset */
+	val |= SCC_UHC_HCLKEN;
+	out_be32(uhc_clkctrl, val);
+	val |= (SCC_UHC_USBCEN | SCC_UHC_USBEN);
+	out_be32(uhc_clkctrl, val);
+	i = 0;
+	while (!uhc_clkctrl_ready(in_be32(uhc_clkctrl))) {
+		udelay(10);
+		if (i++ > UHC_RESET_WAIT_MAX) {
+			printk(KERN_ERR "Failed to disable UHC reset %x\n",
+			       in_be32(uhc_clkctrl));
+			break;
+		}
+	}
+
+	/* Endian Conversion Mode for Master ALL area */
+	out_be32(uhc_ecmode, SCC_UHC_ECMODE_BY_BYTE);
+
+	iounmap(uhc_base);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
+		 PCI_DEVICE_ID_TOSHIBA_SCC_USB, enable_scc_uhc);
