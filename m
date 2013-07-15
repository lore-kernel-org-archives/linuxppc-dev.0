Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02ACC2C01B6
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 13:03:32 +1000 (EST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6F33KdJ013377
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jul 2013 22:03:27 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] powerpc/powernv: Add PIO accessors for Power8 LPC bus
Date: Mon, 15 Jul 2013 13:03:11 +1000
Message-Id: <1373857395-2084-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
References: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This uses the hooks provided by CONFIG_PPC_INDIRECT_PIO to
implement a set of hooks for IO port access to use the LPC
bus via OPAL calls for the first 64K of IO space

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/io.h             |   8 ++
 arch/powerpc/include/asm/opal.h           |   2 +
 arch/powerpc/kernel/io.c                  |   3 +
 arch/powerpc/platforms/powernv/Kconfig    |   1 +
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/opal-lpc.c | 203 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/powernv.h  |   2 +
 arch/powerpc/platforms/powernv/setup.c    |   6 +
 8 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-lpc.c

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 6cc61a3..5a64757 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -69,6 +69,14 @@ extern unsigned long pci_dram_offset;
 
 extern resource_size_t isa_mem_base;
 
+/* Boolean set by platform if PIO accesses are suppored while _IO_BASE
+ * is not set or addresses cannot be translated to MMIO. This is typically
+ * set when the platform supports "special" PIO accesses via a non memory
+ * mapped mechanism, and allows things like the early udbg UART code to
+ * function.
+ */
+extern bool isa_io_special;
+
 #ifdef CONFIG_PPC32
 #if defined(CONFIG_PPC_INDIRECT_PIO) || defined(CONFIG_PPC_INDIRECT_MMIO)
 #error CONFIG_PPC_INDIRECT_{PIO,MMIO} are not yet supported on 32 bits
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index c701e2b..48ad678 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -687,6 +687,8 @@ extern int opal_machine_check(struct pt_regs *regs);
 
 extern void opal_shutdown(void);
 
+extern void opal_lpc_init(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/kernel/io.c b/arch/powerpc/kernel/io.c
index 886381f..2a2b4ae 100644
--- a/arch/powerpc/kernel/io.c
+++ b/arch/powerpc/kernel/io.c
@@ -25,6 +25,9 @@
 #include <asm/firmware.h>
 #include <asm/bug.h>
 
+/* See definition in io.h */
+bool isa_io_special;
+
 void _insb(const volatile u8 __iomem *port, void *buf, long count)
 {
 	u8 *tbuf = buf;
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index c24684c..6529587 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -7,6 +7,7 @@ config PPC_POWERNV
 	select PPC_P7_NAP
 	select PPC_PCI_CHOICE if EMBEDDED
 	select EPAPR_BOOT
+	select PPC_INDIRECT_PIO
 	default y
 
 config POWERNV_MSI
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 7fe5951..300c437 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,5 +1,5 @@
 obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o
-obj-y			+= opal-rtc.o opal-nvram.o
+obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
new file mode 100644
index 0000000..a7614bb
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -0,0 +1,203 @@
+/*
+ * PowerNV LPC bus handling.
+ *
+ * Copyright 2013 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/bug.h>
+
+#include <asm/machdep.h>
+#include <asm/firmware.h>
+#include <asm/xics.h>
+#include <asm/opal.h>
+
+static int opal_lpc_chip_id = -1;
+
+static u8 opal_lpc_inb(unsigned long port)
+{
+	int64_t rc;
+	uint32_t data;
+
+	if (opal_lpc_chip_id < 0 || port > 0xffff)
+		return 0xff;
+	rc = opal_lpc_read(opal_lpc_chip_id, OPAL_LPC_IO, port, &data, 1);
+	return rc ? 0xff : data;
+}
+
+static __le16 __opal_lpc_inw(unsigned long port)
+{
+	int64_t rc;
+	uint32_t data;
+
+	if (opal_lpc_chip_id < 0 || port > 0xfffe)
+		return 0xffff;
+	if (port & 1)
+		return (__le16)opal_lpc_inb(port) << 8 | opal_lpc_inb(port + 1);
+	rc = opal_lpc_read(opal_lpc_chip_id, OPAL_LPC_IO, port, &data, 2);
+	return rc ? 0xffff : data;
+}
+static u16 opal_lpc_inw(unsigned long port)
+{
+	return le16_to_cpu(__opal_lpc_inw(port));
+}
+
+static __le32 __opal_lpc_inl(unsigned long port)
+{
+	int64_t rc;
+	uint32_t data;
+
+	if (opal_lpc_chip_id < 0 || port > 0xfffc)
+		return 0xffffffff;
+	if (port & 3)
+		return (__le32)opal_lpc_inb(port    ) << 24 |
+		       (__le32)opal_lpc_inb(port + 1) << 16 |
+		       (__le32)opal_lpc_inb(port + 2) <<  8 |
+			       opal_lpc_inb(port + 3);
+	rc = opal_lpc_read(opal_lpc_chip_id, OPAL_LPC_IO, port, &data, 4);
+	return rc ? 0xffffffff : data;
+}
+
+static u32 opal_lpc_inl(unsigned long port)
+{
+	return le32_to_cpu(__opal_lpc_inl(port));
+}
+
+static void opal_lpc_outb(u8 val, unsigned long port)
+{
+	if (opal_lpc_chip_id < 0 || port > 0xffff)
+		return;
+	opal_lpc_write(opal_lpc_chip_id, OPAL_LPC_IO, port, val, 1);
+}
+
+static void __opal_lpc_outw(__le16 val, unsigned long port)
+{
+	if (opal_lpc_chip_id < 0 || port > 0xfffe)
+		return;
+	if (port & 1) {
+		opal_lpc_outb(val >> 8, port);
+		opal_lpc_outb(val     , port + 1);
+		return;
+	}
+	opal_lpc_write(opal_lpc_chip_id, OPAL_LPC_IO, port, val, 2);
+}
+
+static void opal_lpc_outw(u16 val, unsigned long port)
+{
+	__opal_lpc_outw(cpu_to_le16(val), port);
+}
+
+static void __opal_lpc_outl(__le32 val, unsigned long port)
+{
+	if (opal_lpc_chip_id < 0 || port > 0xfffc)
+		return;
+	if (port & 3) {
+		opal_lpc_outb(val >> 24, port);
+		opal_lpc_outb(val >> 16, port + 1);
+		opal_lpc_outb(val >>  8, port + 2);
+		opal_lpc_outb(val      , port + 3);
+		return;
+	}
+	opal_lpc_write(opal_lpc_chip_id, OPAL_LPC_IO, port, val, 4);
+}
+
+static void opal_lpc_outl(u32 val, unsigned long port)
+{
+	__opal_lpc_outl(cpu_to_le32(val), port);
+}
+
+static void opal_lpc_insb(unsigned long p, void *b, unsigned long c)
+{
+	u8 *ptr = b;
+
+	while(c--)
+		*(ptr++) = opal_lpc_inb(p);
+}
+
+static void opal_lpc_insw(unsigned long p, void *b, unsigned long c)
+{
+	__le16 *ptr = b;
+
+	while(c--)
+		*(ptr++) = __opal_lpc_inw(p);
+}
+
+static void opal_lpc_insl(unsigned long p, void *b, unsigned long c)
+{
+	__le32 *ptr = b;
+
+	while(c--)
+		*(ptr++) = __opal_lpc_inl(p);
+}
+
+static void opal_lpc_outsb(unsigned long p, const void *b, unsigned long c)
+{
+	const u8 *ptr = b;
+
+	while(c--)
+		opal_lpc_outb(*(ptr++), p);
+}
+
+static void opal_lpc_outsw(unsigned long p, const void *b, unsigned long c)
+{
+	const __le16 *ptr = b;
+
+	while(c--)
+		__opal_lpc_outw(*(ptr++), p);
+}
+
+static void opal_lpc_outsl(unsigned long p, const void *b, unsigned long c)
+{
+	const __le32 *ptr = b;
+
+	while(c--)
+		__opal_lpc_outl(*(ptr++), p);
+}
+
+static const struct ppc_pci_io opal_lpc_io = {
+	.inb	= opal_lpc_inb,
+	.inw	= opal_lpc_inw,
+	.inl	= opal_lpc_inl,
+	.outb	= opal_lpc_outb,
+	.outw	= opal_lpc_outw,
+	.outl	= opal_lpc_outl,
+	.insb	= opal_lpc_insb,
+	.insw	= opal_lpc_insw,
+	.insl	= opal_lpc_insl,
+	.outsb	= opal_lpc_outsb,
+	.outsw	= opal_lpc_outsw,
+	.outsl	= opal_lpc_outsl,
+};
+
+void opal_lpc_init(void)
+{
+	struct device_node *np;
+
+	/*
+	 * Look for a Power8 LPC bus tagged as "primary",
+	 * we currently support only one though the OPAL APIs
+	 * support any number.
+	 */
+	for_each_compatible_node(np, NULL, "ibm,power8-lpc") {
+		if (!of_device_is_available(np))
+			continue;
+		if (!of_get_property(np, "primary", NULL))
+			continue;
+		opal_lpc_chip_id = of_get_ibm_chip_id(np);
+		break;
+	}
+	if (opal_lpc_chip_id < 0)
+		return;
+
+	/* Setup special IO ops */
+	ppc_pci_io = opal_lpc_io;
+	isa_io_special = true;
+
+	pr_info("OPAL: Power8 LPC bus found, chip ID %d\n", opal_lpc_chip_id);
+}
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index a1c6f83..de6819b 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -15,4 +15,6 @@ static inline void pnv_pci_init(void) { }
 static inline void pnv_pci_shutdown(void) { }
 #endif
 
+extern void pnv_lpc_init(void);
+
 #endif /* _POWERNV_H */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 84438af..4ddb339 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -54,6 +54,12 @@ static void __init pnv_setup_arch(void)
 
 static void __init pnv_init_early(void)
 {
+	/*
+	 * Initialize the LPC bus now so that legacy serial
+	 * ports can be found on it
+	 */
+	opal_lpc_init();
+
 #ifdef CONFIG_HVC_OPAL
 	if (firmware_has_feature(FW_FEATURE_OPAL))
 		hvc_opal_init_early();
-- 
1.8.1.2
