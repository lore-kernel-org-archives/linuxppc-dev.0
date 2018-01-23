Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQmNq24NqzDr21
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:32:11 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0NBTUDF047843
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:32:08 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fp1ajquer-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:32:08 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 11:32:06 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH v2 10/13] ocxl: Add Makefile and Kconfig
Date: Tue, 23 Jan 2018 12:31:45 +0100
In-Reply-To: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20180123113148.6024-11-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OCXL_BASE triggers the platform support needed by the driver.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/Kconfig       |  1 +
 drivers/misc/Makefile      |  1 +
 drivers/misc/ocxl/Kconfig  | 31 +++++++++++++++++++++++++++++++
 drivers/misc/ocxl/Makefile | 11 +++++++++++
 4 files changed, 44 insertions(+)
 create mode 100644 drivers/misc/ocxl/Kconfig
 create mode 100644 drivers/misc/ocxl/Makefile

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f1a5c2357b14..0534f338c84a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -508,4 +508,5 @@ source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
+source "drivers/misc/ocxl/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 5ca5f64df478..73326d54e246 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
+obj-$(CONFIG_OCXL)		+= ocxl/
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
diff --git a/drivers/misc/ocxl/Kconfig b/drivers/misc/ocxl/Kconfig
new file mode 100644
index 000000000000..4bbdb0d3c8ee
--- /dev/null
+++ b/drivers/misc/ocxl/Kconfig
@@ -0,0 +1,31 @@
+#
+# Open Coherent Accelerator (OCXL) compatible devices
+#
+
+config OCXL_BASE
+	bool
+	default n
+	select PPC_COPRO_BASE
+
+config OCXL
+	tristate "OpenCAPI coherent accelerator support"
+	depends on PPC_POWERNV && PCI && EEH
+	select OCXL_BASE
+	default m
+	help
+	  Select this option to enable the ocxl driver for Open
+	  Coherent Accelerator Processor Interface (OpenCAPI) devices.
+
+	  OpenCAPI allows FPGA and ASIC accelerators to be coherently
+	  attached to a CPU over an OpenCAPI link.
+
+	  The ocxl driver enables userspace programs to access these
+	  accelerators through devices in /dev/ocxl/.
+
+	  For more information, see http://opencapi.org.
+
+	  This is not to be confused with the support for IBM CAPI
+	  accelerators (CONFIG_CXL), which are PCI-based instead of a
+	  dedicated OpenCAPI link, and don't follow the same protocol.
+
+	  If unsure, say N.
diff --git a/drivers/misc/ocxl/Makefile b/drivers/misc/ocxl/Makefile
new file mode 100644
index 000000000000..5229dcda8297
--- /dev/null
+++ b/drivers/misc/ocxl/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
+
+ocxl-y				+= main.o pci.o config.o file.o pasid.o
+ocxl-y				+= link.o context.o afu_irq.o sysfs.o trace.o
+obj-$(CONFIG_OCXL)		+= ocxl.o
+
+# For tracepoints to include our trace.h from tracepoint infrastructure:
+CFLAGS_trace.o := -I$(src)
+
+# ccflags-y += -DDEBUG
-- 
2.14.1
