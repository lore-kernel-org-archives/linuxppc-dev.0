Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 52113DDEB7
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:37:28 +1100 (EST)
Date: Fri, 21 Dec 2007 23:39:25 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] [POWERPC] FSL UPM: routines to manage FSL UPMs
Message-ID: <20071221203925.GA4829@localhost.localdomain>
References: <20071221203552.GA4738@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071221203552.GA4738@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are few routines needed to manage FSL UPMs. It doesn't include
UPM programming, yet. So far u-boot manages to program everything.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/Kconfig          |    3 +
 arch/powerpc/sysdev/Makefile  |    1 +
 arch/powerpc/sysdev/fsl_upm.c |   65 +++++++++++++++++++++++++++++
 include/asm-powerpc/fsl_upm.h |   90 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_upm.c
 create mode 100644 include/asm-powerpc/fsl_upm.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a4fa173..aab8106 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -463,6 +463,9 @@ config FSL_PCI
  	bool
 	select PPC_INDIRECT_PCI
 
+config FSL_UPM
+	bool
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 99a77d7..98dbfdd 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o
+obj-$(CONFIG_FSL_UPM)		+= fsl_upm.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 obj-$(CONFIG_PPC_BESTCOMM)	+= bestcomm/
diff --git a/arch/powerpc/sysdev/fsl_upm.c b/arch/powerpc/sysdev/fsl_upm.c
new file mode 100644
index 0000000..6e35bf4
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_upm.c
@@ -0,0 +1,65 @@
+/*
+ * Freescale UPM routines.
+ *
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <asm/fsl_upm.h>
+
+spinlock_t upm_lock = __SPIN_LOCK_UNLOCKED(upm_lock);
+unsigned long upm_lock_flags;
+
+int fsl_upm_get_for(struct device_node *node, const char *name,
+		    struct fsl_upm *upm)
+{
+	int ret;
+	struct device_node *lbus;
+	struct resource lbc_res;
+	ptrdiff_t mxmr_offs;
+
+	lbus = of_get_parent(node);
+	if (!lbus) {
+		pr_err("FSL UPM: can't get parent local bus node\n");
+		return -ENOENT;
+	}
+
+	ret = of_address_to_resource(lbus, 0, &lbc_res);
+	if (ret) {
+		pr_err("FSL UPM: can't get parent local bus base\n");
+		return -ENOMEM;
+	}
+
+	switch (name[0]) {
+	case 'A':
+		mxmr_offs = LBC_MAMR;
+		break;
+	case 'B':
+		mxmr_offs = LBC_MBMR;
+		break;
+	case 'C':
+		mxmr_offs = LBC_MCMR;
+		break;
+	default:
+		pr_err("FSL UPM: unknown UPM requested\n");
+		return -EINVAL;
+		break;
+	}
+
+	upm->lbc_base = ioremap_nocache(lbc_res.start,
+					lbc_res.end - lbc_res.start + 1);
+	if (!upm->lbc_base)
+		return -ENOMEM;
+
+	upm->mxmr = upm->lbc_base + mxmr_offs;
+	upm->mar = upm->lbc_base + LBC_MAR;
+
+	return 0;
+}
diff --git a/include/asm-powerpc/fsl_upm.h b/include/asm-powerpc/fsl_upm.h
new file mode 100644
index 0000000..fe5a5d9
--- /dev/null
+++ b/include/asm-powerpc/fsl_upm.h
@@ -0,0 +1,90 @@
+/*
+ * Freescale UPM routines.
+ *
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __ASM_POWERPC_FSL_UPM
+#define __ASM_POWERPC_FSL_UPM
+
+#include <linux/spinlock.h>
+#include <asm/io.h>
+
+#define LBC_MAR		0x68
+#define LBC_MAMR	0x70
+#define LBC_MBMR	0x74
+#define LBC_MCMR	0x78
+
+#define LBC_MXMR_RUNP	0x30000000
+
+struct fsl_upm {
+	void __iomem *lbc_base;
+	void __iomem *mxmr;
+	void __iomem *mar;
+};
+
+extern spinlock_t upm_lock;
+extern unsigned long upm_lock_flags;
+
+extern int fsl_upm_get_for(struct device_node *node, const char *name,
+			   struct fsl_upm *upm);
+
+static inline void fsl_upm_free(struct fsl_upm *upm)
+{
+	iounmap(upm->lbc_base);
+	upm->lbc_base = NULL;
+}
+
+static inline int fsl_upm_got(struct fsl_upm *upm)
+{
+	return !!upm->lbc_base;
+}
+
+static inline void fsl_upm_start_pattern(struct fsl_upm *upm, u32 pat_offset)
+{
+	spin_lock_irqsave(&upm_lock, upm_lock_flags);
+
+	out_be32(upm->mxmr, LBC_MXMR_RUNP | pat_offset);
+}
+
+static inline void fsl_upm_end_pattern(struct fsl_upm *upm)
+{
+	out_be32(upm->mxmr, 0x0);
+
+	while (in_be32(upm->mxmr) != 0x0)
+		cpu_relax();
+
+	spin_unlock_irqrestore(&upm_lock, upm_lock_flags);
+}
+
+static inline int fsl_upm_run_pattern(struct fsl_upm *upm,
+				      void __iomem *io_base,
+				      int width, u32 cmd)
+{
+	out_be32(upm->mar, cmd << (32 - width));
+
+	switch (width) {
+	case 8:
+		out_8(io_base, 0x0);
+		break;
+	case 16:
+		out_be16(io_base, 0x0);
+		break;
+	case 32:
+		out_be32(io_base, 0x0);
+		break;
+	default:
+		return -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+#endif /* __ASM_POWERPC_FSL_UPM */
-- 
1.5.2.2
