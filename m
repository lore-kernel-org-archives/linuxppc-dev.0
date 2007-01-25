Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 3BBCBDDFD4
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 11:18:47 +1100 (EST)
Date: Wed, 24 Jan 2007 18:18:43 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] move pSeries nvram code to neutral location
Message-ID: <20070125001843.GI16486@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move arch/powerpc/platforms/pseries/nvram.c to
arch/powerpc/sysdev/rtas_nvram.c so other platforms with RTAS support
for manipulating nvram can use it.

Add a RTAS_NVRAM Kconfig option which triggers the build of
arch/powerpc/sysdev/rtas_nvram.o.

Select RTAS_NVRAM for pSeries and Maple platforms.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/Kconfig                    |    6 ++
 arch/powerpc/platforms/pseries/Makefile |    5 +-
 arch/powerpc/platforms/pseries/nvram.c  |  149 -------------------------------
 arch/powerpc/sysdev/Makefile            |    1 +
 arch/powerpc/sysdev/rtas_nvram.c        |  149 +++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+), 152 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0855d55..e7b06f5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -406,6 +406,7 @@ config PPC_PSERIES
 	select RTAS_ERROR_LOGGING
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+	select RTAS_NVRAM
 	default y
 
 config PPC_ISERIES
@@ -484,6 +485,7 @@ config PPC_MAPLE
 	select PPC_970_NAP
 	select PPC_NATIVE
 	select PPC_RTAS
+	select RTAS_NVRAM
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
@@ -577,6 +579,10 @@ config MMIO_NVRAM
 	bool
 	default n
 
+config RTAS_NVRAM
+	bool
+	default n
+
 config MPIC_BROKEN_U3
 	bool
 	depends on PPC_MAPLE
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 69590fb..da0a349 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -2,9 +2,8 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
 
-obj-y			:= pci.o lpar.o hvCall.o nvram.o reconfig.o \
-			   setup.o iommu.o ras.o rtasd.o pci_dlpar.o \
-			   firmware.o
+obj-y			:= pci.o lpar.o hvCall.o reconfig.o setup.o \
+			   iommu.o ras.o rtasd.o pci_dlpar.o firmware.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
deleted file mode 100644
index 45cce8c..0000000
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ /dev/null
@@ -1,149 +0,0 @@
-/*
- *  c 2001 PPC 64 Team, IBM Corp
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- *
- * /dev/nvram driver for PPC64
- *
- * This perhaps should live in drivers/char
- */
-
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <asm/uaccess.h>
-#include <asm/nvram.h>
-#include <asm/rtas.h>
-#include <asm/prom.h>
-#include <asm/machdep.h>
-
-static unsigned int nvram_size;
-static int nvram_fetch, nvram_store;
-static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
-static DEFINE_SPINLOCK(nvram_lock);
-
-
-static ssize_t rtas_nvram_read(char *buf, size_t count, loff_t *index)
-{
-	unsigned int i;
-	unsigned long len;
-	int done;
-	unsigned long flags;
-	char *p = buf;
-
-
-	if (nvram_size == 0 || nvram_fetch == RTAS_UNKNOWN_SERVICE)
-		return -ENODEV;
-
-	if (*index >= nvram_size)
-		return 0;
-
-	i = *index;
-	if (i + count > nvram_size)
-		count = nvram_size - i;
-
-	spin_lock_irqsave(&nvram_lock, flags);
-
-	for (; count != 0; count -= len) {
-		len = count;
-		if (len > NVRW_CNT)
-			len = NVRW_CNT;
-		
-		if ((rtas_call(nvram_fetch, 3, 2, &done, i, __pa(nvram_buf),
-			       len) != 0) || len != done) {
-			spin_unlock_irqrestore(&nvram_lock, flags);
-			return -EIO;
-		}
-		
-		memcpy(p, nvram_buf, len);
-
-		p += len;
-		i += len;
-	}
-
-	spin_unlock_irqrestore(&nvram_lock, flags);
-	
-	*index = i;
-	return p - buf;
-}
-
-static ssize_t rtas_nvram_write(char *buf, size_t count, loff_t *index)
-{
-	unsigned int i;
-	unsigned long len;
-	int done;
-	unsigned long flags;
-	const char *p = buf;
-
-	if (nvram_size == 0 || nvram_store == RTAS_UNKNOWN_SERVICE)
-		return -ENODEV;
-
-	if (*index >= nvram_size)
-		return 0;
-
-	i = *index;
-	if (i + count > nvram_size)
-		count = nvram_size - i;
-
-	spin_lock_irqsave(&nvram_lock, flags);
-
-	for (; count != 0; count -= len) {
-		len = count;
-		if (len > NVRW_CNT)
-			len = NVRW_CNT;
-
-		memcpy(nvram_buf, p, len);
-
-		if ((rtas_call(nvram_store, 3, 2, &done, i, __pa(nvram_buf),
-			       len) != 0) || len != done) {
-			spin_unlock_irqrestore(&nvram_lock, flags);
-			return -EIO;
-		}
-		
-		p += len;
-		i += len;
-	}
-	spin_unlock_irqrestore(&nvram_lock, flags);
-	
-	*index = i;
-	return p - buf;
-}
-
-static ssize_t rtas_nvram_get_size(void)
-{
-	return nvram_size ? nvram_size : -ENODEV;
-}
-
-int __init rtas_nvram_init(void)
-{
-	struct device_node *nvram;
-	const unsigned int *nbytes_p;
-	unsigned int proplen;
-
-	nvram = of_find_node_by_type(NULL, "nvram");
-	if (nvram == NULL)
-		return -ENODEV;
-
-	nbytes_p = get_property(nvram, "#bytes", &proplen);
-	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
-		return -EIO;
-
-	nvram_size = *nbytes_p;
-
-	nvram_fetch = rtas_token("nvram-fetch");
-	nvram_store = rtas_token("nvram-store");
-	printk(KERN_INFO "PPC64 nvram contains %d bytes\n", nvram_size);
-	of_node_put(nvram);
-
-	ppc_md.nvram_read	= rtas_nvram_read;
-	ppc_md.nvram_write	= rtas_nvram_write;
-	ppc_md.nvram_size	= rtas_nvram_get_size;
-
-	return 0;
-}
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 2621a7e..fddae64 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
+obj-$(CONFIG_RTAS_NVRAM)	+= rtas_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
diff --git a/arch/powerpc/sysdev/rtas_nvram.c b/arch/powerpc/sysdev/rtas_nvram.c
new file mode 100644
index 0000000..45cce8c
--- /dev/null
+++ b/arch/powerpc/sysdev/rtas_nvram.c
@@ -0,0 +1,149 @@
+/*
+ *  c 2001 PPC 64 Team, IBM Corp
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ * /dev/nvram driver for PPC64
+ *
+ * This perhaps should live in drivers/char
+ */
+
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <asm/uaccess.h>
+#include <asm/nvram.h>
+#include <asm/rtas.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+
+static unsigned int nvram_size;
+static int nvram_fetch, nvram_store;
+static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
+static DEFINE_SPINLOCK(nvram_lock);
+
+
+static ssize_t rtas_nvram_read(char *buf, size_t count, loff_t *index)
+{
+	unsigned int i;
+	unsigned long len;
+	int done;
+	unsigned long flags;
+	char *p = buf;
+
+
+	if (nvram_size == 0 || nvram_fetch == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
+
+	if (*index >= nvram_size)
+		return 0;
+
+	i = *index;
+	if (i + count > nvram_size)
+		count = nvram_size - i;
+
+	spin_lock_irqsave(&nvram_lock, flags);
+
+	for (; count != 0; count -= len) {
+		len = count;
+		if (len > NVRW_CNT)
+			len = NVRW_CNT;
+		
+		if ((rtas_call(nvram_fetch, 3, 2, &done, i, __pa(nvram_buf),
+			       len) != 0) || len != done) {
+			spin_unlock_irqrestore(&nvram_lock, flags);
+			return -EIO;
+		}
+		
+		memcpy(p, nvram_buf, len);
+
+		p += len;
+		i += len;
+	}
+
+	spin_unlock_irqrestore(&nvram_lock, flags);
+	
+	*index = i;
+	return p - buf;
+}
+
+static ssize_t rtas_nvram_write(char *buf, size_t count, loff_t *index)
+{
+	unsigned int i;
+	unsigned long len;
+	int done;
+	unsigned long flags;
+	const char *p = buf;
+
+	if (nvram_size == 0 || nvram_store == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
+
+	if (*index >= nvram_size)
+		return 0;
+
+	i = *index;
+	if (i + count > nvram_size)
+		count = nvram_size - i;
+
+	spin_lock_irqsave(&nvram_lock, flags);
+
+	for (; count != 0; count -= len) {
+		len = count;
+		if (len > NVRW_CNT)
+			len = NVRW_CNT;
+
+		memcpy(nvram_buf, p, len);
+
+		if ((rtas_call(nvram_store, 3, 2, &done, i, __pa(nvram_buf),
+			       len) != 0) || len != done) {
+			spin_unlock_irqrestore(&nvram_lock, flags);
+			return -EIO;
+		}
+		
+		p += len;
+		i += len;
+	}
+	spin_unlock_irqrestore(&nvram_lock, flags);
+	
+	*index = i;
+	return p - buf;
+}
+
+static ssize_t rtas_nvram_get_size(void)
+{
+	return nvram_size ? nvram_size : -ENODEV;
+}
+
+int __init rtas_nvram_init(void)
+{
+	struct device_node *nvram;
+	const unsigned int *nbytes_p;
+	unsigned int proplen;
+
+	nvram = of_find_node_by_type(NULL, "nvram");
+	if (nvram == NULL)
+		return -ENODEV;
+
+	nbytes_p = get_property(nvram, "#bytes", &proplen);
+	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
+		return -EIO;
+
+	nvram_size = *nbytes_p;
+
+	nvram_fetch = rtas_token("nvram-fetch");
+	nvram_store = rtas_token("nvram-store");
+	printk(KERN_INFO "PPC64 nvram contains %d bytes\n", nvram_size);
+	of_node_put(nvram);
+
+	ppc_md.nvram_read	= rtas_nvram_read;
+	ppc_md.nvram_write	= rtas_nvram_write;
+	ppc_md.nvram_size	= rtas_nvram_get_size;
+
+	return 0;
+}
-- 
1.4.4.3
