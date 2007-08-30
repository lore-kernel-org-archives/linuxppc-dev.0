Return-Path: <grant.likely@secretlab.ca>
Date: Thu, 30 Aug 2007 14:57:40 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] mpc5200: add cuimage support for mpc5200 boards
To: tnt@246tnt.com, scottwood@freescale.com, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.com
Message-id: <20070830205550.11315.98506.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/Makefile          |    5 +-
 arch/powerpc/boot/cuboot-52xx.c     |   49 +++++++++++++++++++
 arch/powerpc/boot/mpc52xx-psc.c     |   89 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ops.h             |    1 
 arch/powerpc/boot/serial.c          |    2 +
 arch/powerpc/platforms/52xx/Kconfig |    1 
 6 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index cd7c057..45be0e5 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -45,8 +45,8 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
-		cpm-serial.c
-src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
+		cpm-serial.c mpc52xx-psc.c
+src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c cuboot-pq2.c
 src-boot := $(src-wlib) $(src-plat) empty.c
@@ -142,6 +142,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_8xx)			+= cuImage.8xx
 image-$(CONFIG_8260)			+= cuImage.pq2
+image-$(CONFIG_PPC_MPC52xx)		+= cuImage.52xx
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
diff --git a/arch/powerpc/boot/cuboot-52xx.c b/arch/powerpc/boot/cuboot-52xx.c
new file mode 100644
index 0000000..42650b4
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-52xx.c
@@ -0,0 +1,49 @@
+/*
+ * Old U-boot compatibility for 8200
+ *
+ * Author: Grant Likely <grant.likely@secretlab.ca>
+ *
+ * Copyright (c) 2007 Secret Lab Technologies Ltd.
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "cuboot.h"
+
+#define TARGET_PPC_MPC52xx
+#include "ppcboot.h"
+
+static bd_t bd;
+
+static void platform_fixups(void)
+{
+	void *soc;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_addresses(bd.bi_enetaddr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
+
+	/* Unfortunately, the specific model number is encoded in the
+	 * soc node name in existing dts files -- once that is fixed,
+	 * this can do a simple path lookup.
+	 */
+	soc = find_node_by_devtype(NULL, "soc");
+	if (soc) {
+		setprop(soc, "bus-frequency", &bd.bi_busfreq,
+		        sizeof(bd.bi_ipbfreq));
+	}
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/boot/mpc52xx-psc.c b/arch/powerpc/boot/mpc52xx-psc.c
new file mode 100644
index 0000000..46eecf0
--- /dev/null
+++ b/arch/powerpc/boot/mpc52xx-psc.c
@@ -0,0 +1,89 @@
+/*
+ * CPM serial console support.
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * It is assumed that the firmware (or the platform file) has already set
+ * up the port.
+ */
+
+#include "types.h"
+#include "io.h"
+#include "ops.h"
+
+/* Programmable Serial Controller (PSC) status register bits */
+#define MPC52xx_PSC_SR		0x04
+#define MPC52xx_PSC_SR_CDE		0x0080
+#define MPC52xx_PSC_SR_RXRDY		0x0100
+#define MPC52xx_PSC_SR_RXFULL		0x0200
+#define MPC52xx_PSC_SR_TXRDY		0x0400
+#define MPC52xx_PSC_SR_TXEMP		0x0800
+#define MPC52xx_PSC_SR_OE		0x1000
+#define MPC52xx_PSC_SR_PE		0x2000
+#define MPC52xx_PSC_SR_FE		0x4000
+#define MPC52xx_PSC_SR_RB		0x8000
+
+/* PSC Command values */
+#define MPC52xx_PSC_COMMAND	0x08
+#define MPC52xx_PSC_RX_ENABLE		0x0001
+#define MPC52xx_PSC_RX_DISABLE		0x0002
+#define MPC52xx_PSC_TX_ENABLE		0x0004
+#define MPC52xx_PSC_TX_DISABLE		0x0008
+#define MPC52xx_PSC_SEL_MODE_REG_1	0x0010
+#define MPC52xx_PSC_RST_RX		0x0020
+#define MPC52xx_PSC_RST_TX		0x0030
+#define MPC52xx_PSC_RST_ERR_STAT	0x0040
+#define MPC52xx_PSC_RST_BRK_CHG_INT	0x0050
+#define MPC52xx_PSC_START_BRK		0x0060
+#define MPC52xx_PSC_STOP_BRK		0x0070
+
+#define MPC52xx_PSC_BUFFER	0x0C
+
+static void *psc;
+
+static int psc_open(void)
+{
+	out_8(psc + MPC52xx_PSC_COMMAND, MPC52xx_PSC_SEL_MODE_REG_1
+					| MPC52xx_PSC_RX_ENABLE
+					| MPC52xx_PSC_TX_ENABLE);
+
+	return 0;	/* ignored */
+}
+
+static void psc_putc(unsigned char c)
+{
+	while (!(in_be16(psc + MPC52xx_PSC_SR) & MPC52xx_PSC_SR_TXRDY)) ;
+	out_8(psc + MPC52xx_PSC_BUFFER, c);
+}
+
+static unsigned char psc_tstc(void)
+{
+	return (in_be16(psc + MPC52xx_PSC_SR) & MPC52xx_PSC_SR_RXRDY) != 0;
+}
+
+static unsigned char psc_getc(void)
+{
+	while (!(in_be16(psc + MPC52xx_PSC_SR) & MPC52xx_PSC_SR_RXRDY)) ;
+
+	return in_8(psc + MPC52xx_PSC_BUFFER);
+}
+
+int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp)
+{
+	int n;
+
+	/* Get the base address of the psc registers */
+	n = getprop(devp, "virtual-reg", &psc, sizeof(psc));
+	if (n != sizeof(psc)) {
+		if (!dt_xlate_reg(devp, 0, (void *)&psc, NULL))
+			return -1;
+	}
+
+	scdp->open = psc_open;
+	scdp->putc = psc_putc;
+	scdp->getc = psc_getc;
+	scdp->tstc = psc_tstc;
+
+	return 0;
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 45c2268..5ab9b51 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -83,6 +83,7 @@ int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 int mpsc_console_init(void *devp, struct serial_console_data *scdp);
 int cpm_console_init(void *devp, struct serial_console_data *scdp);
+int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, unsigned long heap_size,
 			unsigned long granularity, unsigned long max_allocs);
 extern void flush_cache(void *, unsigned long);
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index d47f8e0..95e08e4 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -126,6 +126,8 @@ int serial_console_init(void)
 	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
 		rc = cpm_console_init(devp, &serial_cd);
+	else if (dt_is_compatible(devp, "mpc5200-psc-uart"))
+		rc = mpc5200_psc_console_init(devp, &serial_cd);
 
 	/* Add other serial console driver calls here */
 
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 3ffaa06..9ddf251 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -30,6 +30,7 @@ config PPC_EFIKA
 config PPC_LITE5200
 	bool "Freescale Lite5200 Eval Board"
 	depends on PPC_MULTIPLATFORM && PPC32
+	select WANT_DEVICE_TREE
 	select PPC_MPC5200
 	default n
 
