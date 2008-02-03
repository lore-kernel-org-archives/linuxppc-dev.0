Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E9D83DDFC3
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 04:10:29 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id ACCF38810
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 22:10:37 +0400 (SAMT)
Date: Sun, 3 Feb 2008 20:10:19 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/11] [POWERPC] qe_lib: implement QE GTM support
Message-ID: <20080203171019.GH28024@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080203170820.GA18520@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

GTM stands for General-purpose Timers Module and able to generate
timer{1,2,3,4} interrupts.

There are several limitations in this support:
1. Cascaded (32 bit) timers unimplemented (1-2, 3-4).
   This is straightforward to implement when needed, two timers should
   be marked as "requested" and configured as appropriate.
2. Super-cascaded (64 bit) timers unimplemented (1-2-3-4).
   This is also straightforward to implement when needed, all timers
   should be marked as "requested" and configured as appropriate.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/Kconfig  |    4 +
 arch/powerpc/sysdev/qe_lib/Makefile |    1 +
 arch/powerpc/sysdev/qe_lib/gtm.c    |  204 +++++++++++++++++++++++++++++++++++
 include/asm-powerpc/immap_qe.h      |    7 +-
 include/asm-powerpc/qe.h            |   22 ++++
 5 files changed, 236 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/sysdev/qe_lib/gtm.c

diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index adc6621..3966151 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -20,3 +20,7 @@ config UCC
 	bool
 	default y if UCC_FAST || UCC_SLOW
 
+config QE_GTM
+	bool
+	help
+	  QE General-Purpose Timers Module support
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
index 874fe1a..3297a52 100644
--- a/arch/powerpc/sysdev/qe_lib/Makefile
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_ic.o qe_io.o
 obj-$(CONFIG_UCC)	+= ucc.o
 obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
 obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
+obj-$(CONFIG_QE_GTM)	+= gtm.o
diff --git a/arch/powerpc/sysdev/qe_lib/gtm.c b/arch/powerpc/sysdev/qe_lib/gtm.c
new file mode 100644
index 0000000..8f5b422
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/gtm.c
@@ -0,0 +1,204 @@
+/*
+ * QE General-Purpose Timers Module
+ *
+ * Copyright (c) Freescale Semicondutor, Inc. 2006.
+ *               Shlomi Gridish <gridish@freescale.com>
+ *               Jerry Huang <Chang-Ming.Huang@freescale.com>
+ * Copyright (c) MontaVista Software, Inc. 2008.
+ *               Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+struct gtm_timer {
+	unsigned int irq;
+	bool requested;
+
+	u8 __iomem *gtcfr;
+	u16 __iomem *gtmdr;
+	u16 __iomem *gtpsr;
+	u16 __iomem *gtcnr;
+	u16 __iomem *gtrfr;
+	u16 __iomem *gtevr;
+};
+
+static struct gtm_timer timers[4];
+static struct qe_timers __iomem *qet;
+static spinlock_t gtm_lock = __SPIN_LOCK_UNLOCKED(gtm_lock);
+
+static int __init qe_init_gtm(void)
+{
+	struct device_node *gtm;
+	int i;
+
+	gtm = of_find_compatible_node(NULL, NULL, "fsl,qe-gtm");
+	if (!gtm)
+		return -ENODEV;
+
+	for (i = 0; i < 3; i++) {
+		int ret;
+		struct resource irq;
+
+		ret = of_irq_to_resource(gtm, i, &irq);
+		if (ret == NO_IRQ) {
+			pr_err("%s: not enough interrupts specified\n",
+			       gtm->full_name);
+			of_node_put(gtm);
+			return -EINVAL;
+		}
+		timers[i].irq = irq.start;
+	}
+
+	qet = of_iomap(gtm, 0);
+	of_node_put(gtm);
+	if (!qet) {
+		pr_err("%s: unable to iomap registers\n", gtm->full_name);
+		return -EINVAL;
+	}
+
+	/*
+	 * Yeah, I don't like this either, but timers' registers a bit messed,
+	 * so we have to provide shortcuts to write timer independent code.
+	 */
+	timers[0].gtcfr = &qet->gtcfr1;
+	timers[0].gtmdr = &qet->gtmdr1;
+	timers[0].gtpsr = &qet->gtpsr1;
+	timers[0].gtcnr = &qet->gtcnr1;
+	timers[0].gtrfr = &qet->gtrfr1;
+	timers[0].gtevr = &qet->gtevr1;
+
+	timers[1].gtcfr = &qet->gtcfr1;
+	timers[1].gtmdr = &qet->gtmdr2;
+	timers[1].gtpsr = &qet->gtpsr2;
+	timers[1].gtcnr = &qet->gtcnr2;
+	timers[1].gtrfr = &qet->gtrfr2;
+	timers[1].gtevr = &qet->gtevr2;
+
+	timers[2].gtcfr = &qet->gtcfr2;
+	timers[2].gtmdr = &qet->gtmdr3;
+	timers[2].gtpsr = &qet->gtpsr3;
+	timers[2].gtcnr = &qet->gtcnr3;
+	timers[2].gtrfr = &qet->gtrfr3;
+	timers[2].gtevr = &qet->gtevr3;
+
+	timers[3].gtcfr = &qet->gtcfr2;
+	timers[3].gtmdr = &qet->gtmdr4;
+	timers[3].gtpsr = &qet->gtpsr4;
+	timers[3].gtcnr = &qet->gtcnr4;
+	timers[3].gtrfr = &qet->gtrfr4;
+	timers[3].gtevr = &qet->gtevr4;
+
+	return 0;
+}
+arch_initcall(qe_init_gtm);
+
+int qe_get_timer(int width, unsigned int *irq)
+{
+	int i;
+
+	BUG_ON(!irq);
+	if (!qet)
+		return -ENODEV;
+	if (width != 16)
+		return -ENOSYS;
+
+	spin_lock_irq(&gtm_lock);
+
+	for (i = 0; i < 3; i++) {
+		if (!timers[i].requested) {
+			timers[i].requested = true;
+			*irq = timers[i].irq;
+			return i;
+		}
+	}
+
+	spin_unlock_irq(&gtm_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(qe_get_timer);
+
+void qe_put_timer(int num)
+{
+	spin_lock_irq(&gtm_lock);
+
+	timers[num].requested = false;
+
+	spin_unlock_irq(&gtm_lock);
+}
+EXPORT_SYMBOL(qe_put_timer);
+
+int qe_reset_ref_timer_16(int num, unsigned int hz, u16 ref)
+{
+	struct gtm_timer *tmr = &timers[num];
+	unsigned long flags;
+	unsigned int prescaler;
+	u8 psr;
+	u8 sps;
+
+	prescaler = qe_get_brg_clk() / hz;
+
+	/*
+	 * We have two 8 bit prescalers -- primary and secondary (psr, sps),
+	 * so total prescale value is (psr + 1) * (sps + 1).
+	 */
+	if (prescaler > 256 * 256) {
+		return -EINVAL;
+	} else if (prescaler > 256) {
+		psr = 256 - 1;
+		sps = prescaler / 256 - 1;
+	} else {
+		psr = prescaler - 1;
+		sps = 1 - 1;
+	}
+
+	spin_lock_irqsave(&gtm_lock, flags);
+
+	/*
+	 * Properly reset timers: stop, reset, set up prescalers, reference
+	 * value and clear event register.
+	 */
+	clrsetbits_8(tmr->gtcfr, ~(QE_GTCFR_STP(num) | QE_GTCFR_RST(num)),
+				 QE_GTCFR_STP(num) | QE_GTCFR_RST(num));
+
+	setbits8(tmr->gtcfr, QE_GTCFR_STP(num));
+
+	out_be16(tmr->gtpsr, psr);
+	setbits16(tmr->gtmdr, QE_GTMDR_SPS(sps) | QE_GTMDR_ICLK_QERF |
+			      QE_GTMDR_ORI);
+	out_be16(tmr->gtcnr, 0);
+	out_be16(tmr->gtrfr, ref);
+	out_be16(tmr->gtevr, 0xFFFF);
+
+	/* Let it be. */
+	clrbits8(tmr->gtcfr, QE_GTCFR_STP(num));
+
+	spin_unlock_irqrestore(&gtm_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(qe_reset_ref_timer_16);
+
+void qe_stop_timer(int num)
+{
+	struct gtm_timer *tmr = &timers[num];
+	unsigned long flags;
+
+	spin_lock_irqsave(&gtm_lock, flags);
+
+	setbits8(tmr->gtcfr, QE_GTCFR_STP(num));
+
+	spin_unlock_irqrestore(&gtm_lock, flags);
+}
+EXPORT_SYMBOL(qe_stop_timer);
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 82a4526..cfa0d86 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -128,8 +128,11 @@ struct qe_timers {
 	__be16	gtevr2;		/* Timer 2 event register */
 	__be16	gtevr3;		/* Timer 3 event register */
 	__be16	gtevr4;		/* Timer 4 event register */
-	__be16	gtps;		/* Timer 1 prescale register */
-	u8 res2[0x46];
+	__be16	gtpsr1;		/* Timer 1 prescale register */
+	__be16	gtpsr2;		/* Timer 2 prescale register */
+	__be16	gtpsr3;		/* Timer 3 prescale register */
+	__be16	gtpsr4;		/* Timer 4 prescale register */
+	u8 res2[0x40];
 } __attribute__ ((packed));
 
 /* BRG */
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 3487f50..3664aaa 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -153,6 +153,12 @@ struct qe_firmware_info {
 /* Upload a firmware to the QE */
 int qe_upload_firmware(const struct qe_firmware *firmware);
 
+/* QE GTM */
+extern int qe_get_timer(int width, unsigned int *irq);
+extern void qe_put_timer(int num);
+extern int qe_reset_ref_timer_16(int num, unsigned int hz, u16 ref);
+extern void qe_stop_timer(int num);
+
 /* Obtain information on the uploaded firmware */
 struct qe_firmware_info *qe_get_firmware_info(void);
 
@@ -255,6 +261,11 @@ enum comm_dir {
 #define QE_CMXGCR_MII_ENET_MNG_SHIFT	12
 #define QE_CMXGCR_USBCS			0x0000000f
 
+#define QE_CMXGCR_TIMERCS	0x00300000
+#define QE_CMXGCR_TIMERCS_CLK11	0x00000000
+#define QE_CMXGCR_TIMERCS_CLK12	0x00100000
+#define QE_CMXGCR_TIMERCS_BRG11	0x00300000
+
 /* QE CECR Commands.
 */
 #define QE_CR_FLG			0x00010000
@@ -367,6 +378,17 @@ enum comm_dir {
 #define QE_GTCFR1_STP1	0x02
 #define QE_GTCFR1_RST1	0x01
 
+#define QE_GTCFR_STP(x)	((x) & 1 ? 1 << 5 : 1 << 1)
+#define QE_GTCFR_RST(x)	((x) & 1 ? 1 << 4 : 1 << 0)
+
+#define QE_GTMDR_ICLK_MASK	(3 << 1)
+#define QE_GTMDR_ICLK_ICAS	(0 << 1)
+#define QE_GTMDR_ICLK_QERF	(1 << 1)
+#define QE_GTMDR_ICLK_SLGO	(2 << 1)
+#define QE_GTMDR_ORI		(1 << 4)
+#define QE_GTMDR_SPS_MASK	(0xFF << 8)
+#define QE_GTMDR_SPS(x)		((x) << 8)
+
 /* SDMA registers */
 #define QE_SDSR_BER1	0x02000000
 #define QE_SDSR_BER2	0x01000000
-- 
1.5.2.2
