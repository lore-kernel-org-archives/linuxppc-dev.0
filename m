Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id C0C7667A78
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 06:49:15 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 31 Mar 2005 13:49:13 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050331204913.GB29785@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.10-rc2] ppc32: Add platform data definition used by
	ohci-ppc-soc.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This structure allows for callbacks into platform-specific code when the
driver is started or stopped.  This file is currently included by
drivers/usb/host/ohci-ppc-soc.c, so it's needed for USB on the stb04xxx,
mpc52xx, and 440EP.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-usb-405/include/asm-ppc/usb.h
===================================================================
--- /dev/null
+++ linux-2.5-usb-405/include/asm-ppc/usb.h
@@ -0,0 +1,13 @@
+/*
+ * ppc/usb.h:
+ *
+ */
+#ifndef _PPC_USB_H
+#define _PPC_USB_H
+
+struct usb_hcd_platform_data {
+	int (*start) (struct platform_device *pdev);
+	void (*stop) (struct platform_device *pdev);
+};
+
+#endif /* !(_PPC_USB_H) */
