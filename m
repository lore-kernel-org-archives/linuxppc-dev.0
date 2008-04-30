Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DF38DDF53
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 07:58:40 +1000 (EST)
Date: Wed, 30 Apr 2008 16:54:09 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3] [POWERPC] devres: Add devm_ioremap_prot()
Message-ID: <Pine.LNX.4.64.0804301653230.10570@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, htejun@gmail.com,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
	Emilian.Medve@Freescale.com, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Emil Medve <Emilian.Medve@Freescale.com>

We provide an ioremap_flags so provide a corresponding devm_ioremap_prot.
The slight name difference is at Ben Herrenschmidt request as he plans
on changing ioremap_flags to ioremap_prot in the future.

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Renamed at BenH's request to devm_ioremap_prot.

 arch/powerpc/lib/Makefile |    1 +
 arch/powerpc/lib/devres.c |   33 +++++++++++++++++++++++++++++++++
 include/asm-powerpc/io.h  |    8 +++++++-
 include/linux/io.h        |    1 +
 lib/devres.c              |    2 +-
 5 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/lib/devres.c

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 4bb023f..f1d2cdc 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_SMP)	+= locks.o
 endif

 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
+obj-$(CONFIG_HAS_IOMEM)	+= devres.o
diff --git a/arch/powerpc/lib/devres.c b/arch/powerpc/lib/devres.c
new file mode 100644
index 0000000..b290845
--- /dev/null
+++ b/arch/powerpc/lib/devres.c
@@ -0,0 +1,33 @@
+#include <linux/device.h>	/* devres_*(), devm_ioremap_release() */
+#include <linux/io.h>		/* ioremap_flags() */
+#include <linux/module.h>	/* EXPORT_SYMBOL() */
+
+/**
+ * devm_ioremap_prot - Managed ioremap_flags()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ * @flags: Page flags
+ *
+ * Managed ioremap_prot().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_ioremap_prot(struct device *dev, resource_size_t offset,
+				 size_t size, unsigned long flags)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_flags(offset, size, flags);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_prot);
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index afae069..e0062d7 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -2,7 +2,7 @@
 #define _ASM_POWERPC_IO_H
 #ifdef __KERNEL__

-/*
+/*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
@@ -18,6 +18,9 @@ extern int check_legacy_ioport(unsigned long base_port);
 #define _PNPWRP		0xa79
 #define PNPBIOS_BASE	0xf000

+#include <linux/device.h>
+#include <linux/io.h>
+
 #include <linux/compiler.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
@@ -744,6 +747,9 @@ static inline void * bus_to_virt(unsigned long address)

 #define clrsetbits_8(addr, clear, set) clrsetbits(8, addr, clear, set)

+void __iomem *devm_ioremap_prot(struct device *dev, resource_size_t offset,
+				size_t size, unsigned long flags);
+
 #endif /* __KERNEL__ */

 #endif /* _ASM_POWERPC_IO_H */
diff --git a/include/linux/io.h b/include/linux/io.h
index 831f57c..7a390cf 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -58,6 +58,7 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 }
 #endif

+void devm_ioremap_release(struct device *dev, void *res);
 void __iomem * devm_ioremap(struct device *dev, resource_size_t offset,
 			    unsigned long size);
 void __iomem * devm_ioremap_nocache(struct device *dev, resource_size_t offset,
diff --git a/lib/devres.c b/lib/devres.c
index 26c87c4..72c8909 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -2,7 +2,7 @@
 #include <linux/io.h>
 #include <linux/module.h>

-static void devm_ioremap_release(struct device *dev, void *res)
+void devm_ioremap_release(struct device *dev, void *res)
 {
 	iounmap(*(void __iomem **)res);
 }
-- 
1.5.4.1
