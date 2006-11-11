Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 11 Nov 2006 17:24:48 +1100
Subject: [PATCH 5/32] Add arch specific dev_archdata to struct device
In-Reply-To: <1163226282.72526.823314634857.qpush@butch>
Message-Id: <20061111062519.484DE6811F@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds an arch specific struct dev_arch to struct device. This enables
architecture to add specific fields to every device in the system, like
DMA operation pointers, NUMA node ID, firmware specific data, etc...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 include/asm-alpha/device.h     |    7 +++++++
 include/asm-arm/device.h       |    7 +++++++
 include/asm-arm26/device.h     |    7 +++++++
 include/asm-avr32/device.h     |    7 +++++++
 include/asm-cris/device.h      |    7 +++++++
 include/asm-frv/device.h       |    7 +++++++
 include/asm-generic/device.h   |   12 ++++++++++++
 include/asm-h8300/device.h     |    7 +++++++
 include/asm-i386/device.h      |    7 +++++++
 include/asm-ia64/device.h      |    7 +++++++
 include/asm-m32r/device.h      |    7 +++++++
 include/asm-m68k/device.h      |    7 +++++++
 include/asm-m68knommu/device.h |    7 +++++++
 include/asm-mips/device.h      |    7 +++++++
 include/asm-parisc/device.h    |    7 +++++++
 include/asm-powerpc/device.h   |    7 +++++++
 include/asm-ppc/device.h       |    7 +++++++
 include/asm-s390/device.h      |    7 +++++++
 include/asm-sh/device.h        |    7 +++++++
 include/asm-sh64/device.h      |    7 +++++++
 include/asm-sparc/device.h     |    7 +++++++
 include/asm-sparc64/device.h   |    7 +++++++
 include/asm-um/device.h        |    7 +++++++
 include/asm-v850/device.h      |    7 +++++++
 include/asm-x86_64/device.h    |    7 +++++++
 include/asm-xtensa/device.h    |    7 +++++++
 include/linux/device.h         |    3 +++
 27 files changed, 190 insertions(+)

Index: linux-cell/include/asm-alpha/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-alpha/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-arm/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-arm/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-arm26/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-arm26/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-avr32/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-avr32/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-cris/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-cris/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-frv/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-frv/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-generic/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-generic/device.h	2006-11-11 14:29:36.000000000 +1100
@@ -0,0 +1,12 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef _ASM_GENERIC_DEVICE_H
+#define _ASM_GENERIC_DEVICE_H
+
+struct dev_archdata {
+};
+
+#endif /* _ASM_GENERIC_DEVICE_H */
Index: linux-cell/include/asm-h8300/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-h8300/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-i386/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-i386/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-ia64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-ia64/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-m32r/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m32r/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-m68k/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m68k/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-m68knommu/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m68knommu/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-mips/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-mips/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-parisc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-parisc/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-powerpc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-ppc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-ppc/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-s390/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-s390/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-sh/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sh/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-sh64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sh64/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-sparc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sparc/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-sparc64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sparc64/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-um/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-um/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-v850/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-v850/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-x86_64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-x86_64/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/asm-xtensa/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-xtensa/device.h	2006-11-11 14:28:46.000000000 +1100
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
Index: linux-cell/include/linux/device.h
===================================================================
--- linux-cell.orig/include/linux/device.h	2006-11-11 14:25:07.000000000 +1100
+++ linux-cell/include/linux/device.h	2006-11-11 14:30:00.000000000 +1100
@@ -21,6 +21,7 @@
 #include <linux/pm.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
+#include <asm/device.h>
 
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
@@ -382,6 +383,8 @@
 
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+	/* arch specific additions */
+	struct dev_archdata	archdata;
 
 	/* class_device migration path */
 	struct list_head	node;
