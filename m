Return-Path: <roy.pledge@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A702F1A1D30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 06:15:08 +1000 (AEST)
From: Roy Pledge <Roy.Pledge@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v2 01/11] powerpc: re-add devm_ioremap_prot()
Date: Wed, 12 Aug 2015 16:14:47 -0400
Message-ID: <1439410497-19039-2-git-send-email-Roy.Pledge@freescale.com>
In-Reply-To: <1439410497-19039-1-git-send-email-Roy.Pledge@freescale.com>
References: <1439410497-19039-1-git-send-email-Roy.Pledge@freescale.com>
Reply-To: <Roy.Pledge@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Emil Medve <Emilian.Medve@Freescale.com>

devm_ioremap_prot() was removed in commit dedd24a12,
and was introduced in commit b41e5fffe8.

This reverts commit dedd24a12fe6735898feeb06184ee346907abb5d.

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/include/asm/io.h |    3 +++
 arch/powerpc/lib/Makefile     |    1 +
 arch/powerpc/lib/devres.c     |   43 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 arch/powerpc/lib/devres.c

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index a8d2ef3..9eaf301 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -855,6 +855,9 @@ static inline void * bus_to_virt(unsigned long address)
 
 #define clrsetbits_8(addr, clear, set) clrsetbits(8, addr, clear, set)
 
+void __iomem *devm_ioremap_prot(struct device *dev, resource_size_t offset,
+				size_t size, unsigned long flags);
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_IO_H */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index a47e142..7ae60f0 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -13,6 +13,7 @@ obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
 	 feature-fixups.o
 
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
+obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj64-y	+= copypage_64.o copyuser_64.o usercopy_64.o mem_64.o hweight_64.o \
 	   copyuser_power7.o string_64.o copypage_power7.o memcpy_power7.o \
diff --git a/arch/powerpc/lib/devres.c b/arch/powerpc/lib/devres.c
new file mode 100644
index 0000000..8df55fc
--- /dev/null
+++ b/arch/powerpc/lib/devres.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2008 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/device.h>	/* devres_*(), devm_ioremap_release() */
+#include <linux/gfp.h>
+#include <linux/io.h>		/* ioremap_prot() */
+#include <linux/export.h>	/* EXPORT_SYMBOL() */
+
+/**
+ * devm_ioremap_prot - Managed ioremap_prot()
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
+	addr = ioremap_prot(offset, size, flags);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_prot);
-- 
1.7.9.5
