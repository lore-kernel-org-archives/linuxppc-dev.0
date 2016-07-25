Return-Path: <qiang.zhao@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0067.outbound.protection.outlook.com [104.47.33.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryVpk4BTfzDrHc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 15:55:26 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <xiaobo.xie@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v5 2/2] QE: remove PPCisms for QE
Date: Mon, 25 Jul 2016 13:43:47 +0800
Message-ID: <1469425427-33883-2-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1469425427-33883-1-git-send-email-qiang.zhao@nxp.com>
References: <1469425427-33883-1-git-send-email-qiang.zhao@nxp.com>
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

QE was supported on PowerPC, and dependent on PPC,
Now it is supported on other platforms. so remove PPCisms.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- na
Changes for v3:
	- add NO_IRQ
Changes for v4:
	- modify spin_event_timeout to opencoded timeout loop
	- remove NO_IRQ
	- modify virq_to_hw to opencoed code
Changes for v5:
	- modify commit msg
	- modify depends of QUICC_ENGINE
	- add kerneldoc header for qe_issue_cmd

 drivers/irqchip/qe_ic.c       | 28 +++++++++------
 drivers/soc/fsl/qe/Kconfig    |  2 +-
 drivers/soc/fsl/qe/qe.c       | 80 ++++++++++++++++++++++++++-----------------
 drivers/soc/fsl/qe/qe_io.c    | 42 ++++++++++-------------
 drivers/soc/fsl/qe/qe_tdm.c   |  8 ++---
 drivers/soc/fsl/qe/ucc.c      | 10 +++---
 drivers/soc/fsl/qe/ucc_fast.c | 68 ++++++++++++++++++------------------
 include/soc/fsl/qe/qe.h       |  1 -
 include/soc/fsl/qe/qe_ic.h    | 12 +++----
 9 files changed, 133 insertions(+), 118 deletions(-)

diff --git a/drivers/irqchip/qe_ic.c b/drivers/irqchip/qe_ic.c
index 46652c0..32deb60 100644
--- a/drivers/irqchip/qe_ic.c
+++ b/drivers/irqchip/qe_ic.c
@@ -18,7 +18,10 @@
 #include <linux/of_address.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/errno.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -177,13 +180,13 @@ static struct qe_ic_info qe_ic_info[] = {
 
 static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
 {
-	return in_be32(base + (reg >> 2));
+	return ioread32be(base + (reg >> 2));
 }
 
 static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
 			       u32 value)
 {
-	out_be32(base + (reg >> 2), value);
+	iowrite32be(value, base + (reg >> 2));
 }
 
 static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
@@ -285,7 +288,7 @@ static const struct irq_domain_ops qe_ic_host_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 {
 	int irq;
@@ -296,12 +299,12 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 	irq = qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
 
 	if (irq == 0)
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 {
 	int irq;
@@ -312,7 +315,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	irq = qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
 
 	if (irq == 0)
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
@@ -355,7 +358,7 @@ static int __init qe_ic_init(unsigned int flags)
 	qe_ic->virq_high = irq_of_parse_and_map(node, 0);
 	qe_ic->virq_low = irq_of_parse_and_map(node, 1);
 
-	if (qe_ic->virq_low == NO_IRQ) {
+	if (qe_ic->virq_low == 0) {
 		pr_err("Failed to map QE_IC low IRQ\n");
 		ret = -ENOMEM;
 		goto err_domain_remove;
@@ -387,7 +390,7 @@ static int __init qe_ic_init(unsigned int flags)
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
 	irq_set_chained_handler(qe_ic->virq_low, qe_ic_cascade_low_mpic);
 
-	if (qe_ic->virq_high != NO_IRQ &&
+	if (qe_ic->virq_high != 0 &&
 			qe_ic->virq_high != qe_ic->virq_low) {
 		irq_set_handler_data(qe_ic->virq_high, qe_ic);
 		irq_set_chained_handler(qe_ic->virq_high,
@@ -407,7 +410,8 @@ err_put_node:
 void qe_ic_set_highest_priority(unsigned int virq, int high)
 {
 	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
 	u32 temp = 0;
 
 	temp = qe_ic_read(qe_ic->regs, QEIC_CICR);
@@ -425,7 +429,8 @@ void qe_ic_set_highest_priority(unsigned int virq, int high)
 int qe_ic_set_priority(unsigned int virq, unsigned int priority)
 {
 	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
 	u32 temp;
 
 	if (priority > 8 || priority == 0)
@@ -455,7 +460,8 @@ int qe_ic_set_priority(unsigned int virq, unsigned int priority)
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
 {
 	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
 	u32 temp, control_reg = QEIC_CICNR, shift = 0;
 
 	if (priority > 2 || priority == 0)
diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index 73a2e08..b26b643 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -4,7 +4,7 @@
 
 config QUICC_ENGINE
 	bool "Freescale QUICC Engine (QE) Support"
-	depends on FSL_SOC && PPC32
+	depends on OF && HAS_IOMEM
 	select GENERIC_ALLOCATOR
 	select CRC32
 	help
diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2707a82..2b53e85 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -33,8 +33,6 @@
 #include <asm/pgtable.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <soc/fsl/qe/qe.h>
-#include <asm/prom.h>
-#include <asm/rheap.h>
 
 static void qe_snums_init(void);
 static int qe_sdma_init(void);
@@ -109,15 +107,27 @@ void qe_reset(void)
 		panic("sdma init failed!");
 }
 
+/* issue commands to QE, return 0 on success while -EIO on error
+ *
+ * @cmd: the command code, should be QE_INIT_TX_RX, QE_STOP_TX and so on
+ * @device: which sub-block will run the command, QE_CR_SUBBLOCK_UCCFAST1 - 8
+ * , QE_CR_SUBBLOCK_UCCSLOW1 - 8, QE_CR_SUBBLOCK_MCC1 - 3,
+ * QE_CR_SUBBLOCK_IDMA1 - 4 and such on.
+ * @mcn_protocol: specifies mode for the command for non-MCC, should be
+ * QE_CR_PROTOCOL_HDLC_TRANSPARENT, QE_CR_PROTOCOL_QMC, QE_CR_PROTOCOL_UART
+ * and such on.
+ * @cmd_input: command related data.
+ */
 int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 {
 	unsigned long flags;
 	u8 mcn_shift = 0, dev_shift = 0;
-	u32 ret;
+	int ret;
+	int i;
 
 	spin_lock_irqsave(&qe_lock, flags);
 	if (cmd == QE_RESET) {
-		out_be32(&qe_immr->cp.cecr, (u32) (cmd | QE_CR_FLG));
+		iowrite32be((cmd | QE_CR_FLG), &qe_immr->cp.cecr);
 	} else {
 		if (cmd == QE_ASSIGN_PAGE) {
 			/* Here device is the SNUM, not sub-block */
@@ -134,20 +144,26 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 				mcn_shift = QE_CR_MCN_NORMAL_SHIFT;
 		}
 
-		out_be32(&qe_immr->cp.cecdr, cmd_input);
-		out_be32(&qe_immr->cp.cecr,
-			 (cmd | QE_CR_FLG | ((u32) device << dev_shift) | (u32)
-			  mcn_protocol << mcn_shift));
+		iowrite32be(cmd_input, &qe_immr->cp.cecdr);
+		iowrite32be((cmd | QE_CR_FLG | ((u32)device << dev_shift) |
+			    (u32)mcn_protocol << mcn_shift), &qe_immr->cp.cecr);
 	}
 
 	/* wait for the QE_CR_FLG to clear */
-	ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
-			   100, 0);
+	ret = -EIO;
+	for (i = 0; i < 100; i++) {
+		if ((ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0) {
+			ret = 0;
+			break;
+		}
+		udelay(1);
+	}
+
 	/* On timeout (e.g. failure), the expression will be false (ret == 0),
 	   otherwise it will be true (ret == 1). */
 	spin_unlock_irqrestore(&qe_lock, flags);
 
-	return ret == 1;
+	return ret;
 }
 EXPORT_SYMBOL(qe_issue_cmd);
 
@@ -166,8 +182,8 @@ static unsigned int brg_clk = 0;
 unsigned int qe_get_brg_clk(void)
 {
 	struct device_node *qe;
-	int size;
-	const u32 *prop;
+	u32 val;
+	int ret;
 
 	if (brg_clk)
 		return brg_clk;
@@ -179,9 +195,9 @@ unsigned int qe_get_brg_clk(void)
 			return brg_clk;
 	}
 
-	prop = of_get_property(qe, "brg-frequency", &size);
-	if (prop && size == sizeof(*prop))
-		brg_clk = *prop;
+	ret = of_property_read_u32(qe, "brg-frequency", &val);
+	if (!ret)
+		brg_clk = val;
 
 	of_node_put(qe);
 
@@ -221,7 +237,7 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
 	tempval = ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) |
 		QE_BRGC_ENABLE | div16;
 
-	out_be32(&qe_immr->brg.brgc[brg - QE_BRG1], tempval);
+	iowrite32be(tempval, &qe_immr->brg.brgc[brg - QE_BRG1]);
 
 	return 0;
 }
@@ -355,9 +371,9 @@ static int qe_sdma_init(void)
 			return -ENOMEM;
 	}
 
-	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
- 	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
- 					(0x1 << QE_SDMR_CEN_SHIFT)));
+	iowrite32be((u32)sdma_buf_offset & QE_SDEBCR_BA_MASK, &sdma->sdebcr);
+	iowrite32be((QE_SDMR_GLB_1_MSK | (0x1 << QE_SDMR_CEN_SHIFT)),
+		    &sdma->sdmr);
 
 	return 0;
 }
@@ -395,14 +411,14 @@ static void qe_upload_microcode(const void *base,
 			"uploading microcode '%s'\n", ucode->id);
 
 	/* Use auto-increment */
-	out_be32(&qe_immr->iram.iadd, be32_to_cpu(ucode->iram_offset) |
-		QE_IRAM_IADD_AIE | QE_IRAM_IADD_BADDR);
+	iowrite32be(be32_to_cpu(ucode->iram_offset) | QE_IRAM_IADD_AIE |
+		    QE_IRAM_IADD_BADDR, &qe_immr->iram.iadd);
 
 	for (i = 0; i < be32_to_cpu(ucode->count); i++)
-		out_be32(&qe_immr->iram.idata, be32_to_cpu(code[i]));
+		iowrite32be(be32_to_cpu(code[i]), &qe_immr->iram.idata);
 	
 	/* Set I-RAM Ready Register */
-	out_be32(&qe_immr->iram.iready, be32_to_cpu(QE_IRAM_READY));
+	iowrite32be(be32_to_cpu(QE_IRAM_READY), &qe_immr->iram.iready);
 }
 
 /*
@@ -487,7 +503,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	 * If the microcode calls for it, split the I-RAM.
 	 */
 	if (!firmware->split)
-		setbits16(&qe_immr->cp.cercr, QE_CP_CERCR_CIR);
+		qe_setbits16(&qe_immr->cp.cercr, QE_CP_CERCR_CIR);
 
 	if (firmware->soc.model)
 		printk(KERN_INFO
@@ -521,11 +537,11 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 			u32 trap = be32_to_cpu(ucode->traps[j]);
 
 			if (trap)
-				out_be32(&qe_immr->rsp[i].tibcr[j], trap);
+				iowrite32be(trap, &qe_immr->rsp[i].tibcr[j]);
 		}
 
 		/* Enable traps */
-		out_be32(&qe_immr->rsp[i].eccr, be32_to_cpu(ucode->eccr));
+		iowrite32be(be32_to_cpu(ucode->eccr), &qe_immr->rsp[i].eccr);
 	}
 
 	qe_firmware_uploaded = 1;
@@ -644,9 +660,9 @@ EXPORT_SYMBOL(qe_get_num_of_risc);
 unsigned int qe_get_num_of_snums(void)
 {
 	struct device_node *qe;
-	int size;
 	unsigned int num_of_snums;
-	const u32 *prop;
+	u32 val;
+	int ret;
 
 	num_of_snums = 28; /* The default number of snum for threads is 28 */
 	qe = of_find_compatible_node(NULL, NULL, "fsl,qe");
@@ -660,9 +676,9 @@ unsigned int qe_get_num_of_snums(void)
 			return num_of_snums;
 	}
 
-	prop = of_get_property(qe, "fsl,qe-num-snums", &size);
-	if (prop && size == sizeof(*prop)) {
-		num_of_snums = *prop;
+	ret = of_property_read_u32(qe, "fsl,qe-num-snums", &val);
+	if (!ret) {
+		num_of_snums = val;
 		if ((num_of_snums < 28) || (num_of_snums > QE_NUM_OF_SNUM)) {
 			/* No QE ever has fewer than 28 SNUMs */
 			pr_err("QE: number of snum is invalid\n");
diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 7ae59ab..8966e8b 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -22,8 +22,6 @@
 
 #include <asm/io.h>
 #include <soc/fsl/qe/qe.h>
-#include <asm/prom.h>
-#include <sysdev/fsl_soc.h>
 
 #undef DEBUG
 
@@ -61,16 +59,16 @@ void __par_io_config_pin(struct qe_pio_regs __iomem *par_io, u8 pin, int dir,
 	pin_mask1bit = (u32) (1 << (QE_PIO_PINS - (pin + 1)));
 
 	/* Set open drain, if required */
-	tmp_val = in_be32(&par_io->cpodr);
+	tmp_val = ioread32be(&par_io->cpodr);
 	if (open_drain)
-		out_be32(&par_io->cpodr, pin_mask1bit | tmp_val);
+		iowrite32be(pin_mask1bit | tmp_val, &par_io->cpodr);
 	else
-		out_be32(&par_io->cpodr, ~pin_mask1bit & tmp_val);
+		iowrite32be(~pin_mask1bit & tmp_val, &par_io->cpodr);
 
 	/* define direction */
 	tmp_val = (pin > (QE_PIO_PINS / 2) - 1) ?
-		in_be32(&par_io->cpdir2) :
-		in_be32(&par_io->cpdir1);
+		ioread32be(&par_io->cpdir2) :
+		ioread32be(&par_io->cpdir1);
 
 	/* get all bits mask for 2 bit per port */
 	pin_mask2bits = (u32) (0x3 << (QE_PIO_PINS -
@@ -82,34 +80,30 @@ void __par_io_config_pin(struct qe_pio_regs __iomem *par_io, u8 pin, int dir,
 
 	/* clear and set 2 bits mask */
 	if (pin > (QE_PIO_PINS / 2) - 1) {
-		out_be32(&par_io->cpdir2,
-			 ~pin_mask2bits & tmp_val);
+		iowrite32be(~pin_mask2bits & tmp_val, &par_io->cpdir2);
 		tmp_val &= ~pin_mask2bits;
-		out_be32(&par_io->cpdir2, new_mask2bits | tmp_val);
+		iowrite32be(new_mask2bits | tmp_val, &par_io->cpdir2);
 	} else {
-		out_be32(&par_io->cpdir1,
-			 ~pin_mask2bits & tmp_val);
+		iowrite32be(~pin_mask2bits & tmp_val, &par_io->cpdir1);
 		tmp_val &= ~pin_mask2bits;
-		out_be32(&par_io->cpdir1, new_mask2bits | tmp_val);
+		iowrite32be(new_mask2bits | tmp_val, &par_io->cpdir1);
 	}
 	/* define pin assignment */
 	tmp_val = (pin > (QE_PIO_PINS / 2) - 1) ?
-		in_be32(&par_io->cppar2) :
-		in_be32(&par_io->cppar1);
+		ioread32be(&par_io->cppar2) :
+		ioread32be(&par_io->cppar1);
 
 	new_mask2bits = (u32) (assignment << (QE_PIO_PINS -
 			(pin % (QE_PIO_PINS / 2) + 1) * 2));
 	/* clear and set 2 bits mask */
 	if (pin > (QE_PIO_PINS / 2) - 1) {
-		out_be32(&par_io->cppar2,
-			 ~pin_mask2bits & tmp_val);
+		iowrite32be(~pin_mask2bits & tmp_val, &par_io->cppar2);
 		tmp_val &= ~pin_mask2bits;
-		out_be32(&par_io->cppar2, new_mask2bits | tmp_val);
+		iowrite32be(new_mask2bits | tmp_val, &par_io->cppar2);
 	} else {
-		out_be32(&par_io->cppar1,
-			 ~pin_mask2bits & tmp_val);
+		iowrite32be(~pin_mask2bits & tmp_val, &par_io->cppar1);
 		tmp_val &= ~pin_mask2bits;
-		out_be32(&par_io->cppar1, new_mask2bits | tmp_val);
+		iowrite32be(new_mask2bits | tmp_val, &par_io->cppar1);
 	}
 }
 EXPORT_SYMBOL(__par_io_config_pin);
@@ -137,12 +131,12 @@ int par_io_data_set(u8 port, u8 pin, u8 val)
 	/* calculate pin location */
 	pin_mask = (u32) (1 << (QE_PIO_PINS - 1 - pin));
 
-	tmp_val = in_be32(&par_io[port].cpdata);
+	tmp_val = ioread32be(&par_io[port].cpdata);
 
 	if (val == 0)		/* clear */
-		out_be32(&par_io[port].cpdata, ~pin_mask & tmp_val);
+		iowrite32be(~pin_mask & tmp_val, &par_io[port].cpdata);
 	else			/* set */
-		out_be32(&par_io[port].cpdata, pin_mask | tmp_val);
+		iowrite32be(pin_mask | tmp_val, &par_io[port].cpdata);
 
 	return 0;
 }
diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index 5e48b14..974154f 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -227,10 +227,10 @@ void ucc_tdm_init(struct ucc_tdm *utdm, struct ucc_tdm_info *ut_info)
 				    &siram[siram_entry_id * 32 + 0x200 +  i]);
 	}
 
-	setbits16(&siram[(siram_entry_id * 32) + (utdm->num_of_ts - 1)],
-		  SIR_LAST);
-	setbits16(&siram[(siram_entry_id * 32) + 0x200 + (utdm->num_of_ts - 1)],
-		  SIR_LAST);
+	qe_setbits16(&siram[(siram_entry_id * 32) + (utdm->num_of_ts - 1)],
+		     SIR_LAST);
+	qe_setbits16(&siram[(siram_entry_id * 32) + 0x200 +
+		     (utdm->num_of_ts - 1)], SIR_LAST);
 
 	/* Set SIxMR register */
 	sixmr = SIMR_SAD(siram_entry_id);
diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
index c646d87..bc64b83 100644
--- a/drivers/soc/fsl/qe/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -39,7 +39,7 @@ int ucc_set_qe_mux_mii_mng(unsigned int ucc_num)
 		return -EINVAL;
 
 	spin_lock_irqsave(&cmxgcr_lock, flags);
-	clrsetbits_be32(&qe_immr->qmx.cmxgcr, QE_CMXGCR_MII_ENET_MNG,
+	qe_clrsetbits32(&qe_immr->qmx.cmxgcr, QE_CMXGCR_MII_ENET_MNG,
 		ucc_num << QE_CMXGCR_MII_ENET_MNG_SHIFT);
 	spin_unlock_irqrestore(&cmxgcr_lock, flags);
 
@@ -84,7 +84,7 @@ int ucc_set_type(unsigned int ucc_num, enum ucc_speed_type speed)
 		return -EINVAL;
 	}
 
-	clrsetbits_8(guemr, UCC_GUEMR_MODE_MASK,
+	qe_clrsetbits8(guemr, UCC_GUEMR_MODE_MASK,
 		UCC_GUEMR_SET_RESERVED3 | speed);
 
 	return 0;
@@ -113,9 +113,9 @@ int ucc_mux_set_grant_tsa_bkpt(unsigned int ucc_num, int set, u32 mask)
 	get_cmxucr_reg(ucc_num, &cmxucr, &reg_num, &shift);
 
 	if (set)
-		setbits32(cmxucr, mask << shift);
+		qe_setbits32(cmxucr, mask << shift);
 	else
-		clrbits32(cmxucr, mask << shift);
+		qe_clrbits32(cmxucr, mask << shift);
 
 	return 0;
 }
@@ -211,7 +211,7 @@ int ucc_set_qe_mux_rxtx(unsigned int ucc_num, enum qe_clock clock,
 	if (mode == COMM_DIR_RX)
 		shift += 4;
 
-	clrsetbits_be32(cmxucr, QE_CMXUCR_TX_CLK_SRC_MASK << shift,
+	qe_clrsetbits32(cmxucr, QE_CMXUCR_TX_CLK_SRC_MASK << shift,
 		clock_bits << shift);
 
 	return 0;
diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index 83d8d16..3a0224c 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -33,41 +33,41 @@ void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 	printk(KERN_INFO "Base address: 0x%p\n", uccf->uf_regs);
 
 	printk(KERN_INFO "gumr  : addr=0x%p, val=0x%08x\n",
-		  &uccf->uf_regs->gumr, in_be32(&uccf->uf_regs->gumr));
+	       &uccf->uf_regs->gumr, ioread32be(&uccf->uf_regs->gumr));
 	printk(KERN_INFO "upsmr : addr=0x%p, val=0x%08x\n",
-		  &uccf->uf_regs->upsmr, in_be32(&uccf->uf_regs->upsmr));
+		  &uccf->uf_regs->upsmr, ioread32be(&uccf->uf_regs->upsmr));
 	printk(KERN_INFO "utodr : addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->utodr, in_be16(&uccf->uf_regs->utodr));
+		  &uccf->uf_regs->utodr, ioread16be(&uccf->uf_regs->utodr));
 	printk(KERN_INFO "udsr  : addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->udsr, in_be16(&uccf->uf_regs->udsr));
+		  &uccf->uf_regs->udsr, ioread16be(&uccf->uf_regs->udsr));
 	printk(KERN_INFO "ucce  : addr=0x%p, val=0x%08x\n",
-		  &uccf->uf_regs->ucce, in_be32(&uccf->uf_regs->ucce));
+		  &uccf->uf_regs->ucce, ioread32be(&uccf->uf_regs->ucce));
 	printk(KERN_INFO "uccm  : addr=0x%p, val=0x%08x\n",
-		  &uccf->uf_regs->uccm, in_be32(&uccf->uf_regs->uccm));
+		  &uccf->uf_regs->uccm, ioread32be(&uccf->uf_regs->uccm));
 	printk(KERN_INFO "uccs  : addr=0x%p, val=0x%02x\n",
-		  &uccf->uf_regs->uccs, in_8(&uccf->uf_regs->uccs));
+		  &uccf->uf_regs->uccs, ioread8(&uccf->uf_regs->uccs));
 	printk(KERN_INFO "urfb  : addr=0x%p, val=0x%08x\n",
-		  &uccf->uf_regs->urfb, in_be32(&uccf->uf_regs->urfb));
+		  &uccf->uf_regs->urfb, ioread32be(&uccf->uf_regs->urfb));
 	printk(KERN_INFO "urfs  : addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->urfs, in_be16(&uccf->uf_regs->urfs));
+		  &uccf->uf_regs->urfs, ioread16be(&uccf->uf_regs->urfs));
 	printk(KERN_INFO "urfet : addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->urfet, in_be16(&uccf->uf_regs->urfet));
+		  &uccf->uf_regs->urfet, ioread16be(&uccf->uf_regs->urfet));
 	printk(KERN_INFO "urfset: addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->urfset, in_be16(&uccf->uf_regs->urfset));
+		  &uccf->uf_regs->urfset, ioread16be(&uccf->uf_regs->urfset));
 	printk(KERN_INFO "utfb  : addr=0x%p, val=0x%08x\n",
-		  &uccf->uf_regs->utfb, in_be32(&uccf->uf_regs->utfb));
+		  &uccf->uf_regs->utfb, ioread32be(&uccf->uf_regs->utfb));
 	printk(KERN_INFO "utfs  : addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->utfs, in_be16(&uccf->uf_regs->utfs));
+		  &uccf->uf_regs->utfs, ioread16be(&uccf->uf_regs->utfs));
 	printk(KERN_INFO "utfet : addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->utfet, in_be16(&uccf->uf_regs->utfet));
+		  &uccf->uf_regs->utfet, ioread16be(&uccf->uf_regs->utfet));
 	printk(KERN_INFO "utftt : addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->utftt, in_be16(&uccf->uf_regs->utftt));
+		  &uccf->uf_regs->utftt, ioread16be(&uccf->uf_regs->utftt));
 	printk(KERN_INFO "utpt  : addr=0x%p, val=0x%04x\n",
-		  &uccf->uf_regs->utpt, in_be16(&uccf->uf_regs->utpt));
+		  &uccf->uf_regs->utpt, ioread16be(&uccf->uf_regs->utpt));
 	printk(KERN_INFO "urtry : addr=0x%p, val=0x%08x\n",
-		  &uccf->uf_regs->urtry, in_be32(&uccf->uf_regs->urtry));
+		  &uccf->uf_regs->urtry, ioread32be(&uccf->uf_regs->urtry));
 	printk(KERN_INFO "guemr : addr=0x%p, val=0x%02x\n",
-		  &uccf->uf_regs->guemr, in_8(&uccf->uf_regs->guemr));
+		  &uccf->uf_regs->guemr, ioread8(&uccf->uf_regs->guemr));
 }
 EXPORT_SYMBOL(ucc_fast_dump_regs);
 
@@ -89,7 +89,7 @@ EXPORT_SYMBOL(ucc_fast_get_qe_cr_subblock);
 
 void ucc_fast_transmit_on_demand(struct ucc_fast_private * uccf)
 {
-	out_be16(&uccf->uf_regs->utodr, UCC_FAST_TOD);
+	iowrite16be(UCC_FAST_TOD, &uccf->uf_regs->utodr);
 }
 EXPORT_SYMBOL(ucc_fast_transmit_on_demand);
 
@@ -101,7 +101,7 @@ void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode)
 	uf_regs = uccf->uf_regs;
 
 	/* Enable reception and/or transmission on this UCC. */
-	gumr = in_be32(&uf_regs->gumr);
+	gumr = ioread32be(&uf_regs->gumr);
 	if (mode & COMM_DIR_TX) {
 		gumr |= UCC_FAST_GUMR_ENT;
 		uccf->enabled_tx = 1;
@@ -110,7 +110,7 @@ void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode)
 		gumr |= UCC_FAST_GUMR_ENR;
 		uccf->enabled_rx = 1;
 	}
-	out_be32(&uf_regs->gumr, gumr);
+	iowrite32be(gumr, &uf_regs->gumr);
 }
 EXPORT_SYMBOL(ucc_fast_enable);
 
@@ -122,7 +122,7 @@ void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode)
 	uf_regs = uccf->uf_regs;
 
 	/* Disable reception and/or transmission on this UCC. */
-	gumr = in_be32(&uf_regs->gumr);
+	gumr = ioread32be(&uf_regs->gumr);
 	if (mode & COMM_DIR_TX) {
 		gumr &= ~UCC_FAST_GUMR_ENT;
 		uccf->enabled_tx = 0;
@@ -131,7 +131,7 @@ void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode)
 		gumr &= ~UCC_FAST_GUMR_ENR;
 		uccf->enabled_rx = 0;
 	}
-	out_be32(&uf_regs->gumr, gumr);
+	iowrite32be(gumr, &uf_regs->gumr);
 }
 EXPORT_SYMBOL(ucc_fast_disable);
 
@@ -263,7 +263,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	gumr |= uf_info->tenc;
 	gumr |= uf_info->tcrc;
 	gumr |= uf_info->mode;
-	out_be32(&uf_regs->gumr, gumr);
+	iowrite32be(gumr, &uf_regs->gumr);
 
 	/* Allocate memory for Tx Virtual Fifo */
 	uccf->ucc_fast_tx_virtual_fifo_base_offset =
@@ -290,15 +290,15 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	}
 
 	/* Set Virtual Fifo registers */
-	out_be16(&uf_regs->urfs, uf_info->urfs);
-	out_be16(&uf_regs->urfet, uf_info->urfet);
-	out_be16(&uf_regs->urfset, uf_info->urfset);
-	out_be16(&uf_regs->utfs, uf_info->utfs);
-	out_be16(&uf_regs->utfet, uf_info->utfet);
-	out_be16(&uf_regs->utftt, uf_info->utftt);
+	iowrite16be(uf_info->urfs, &uf_regs->urfs);
+	iowrite16be(uf_info->urfet, &uf_regs->urfet);
+	iowrite16be(uf_info->urfset, &uf_regs->urfset);
+	iowrite16be(uf_info->utfs, &uf_regs->utfs);
+	iowrite16be(uf_info->utfet, &uf_regs->utfet);
+	iowrite16be(uf_info->utftt, &uf_regs->utftt);
 	/* utfb, urfb are offsets from MURAM base */
-	out_be32(&uf_regs->utfb, uccf->ucc_fast_tx_virtual_fifo_base_offset);
-	out_be32(&uf_regs->urfb, uccf->ucc_fast_rx_virtual_fifo_base_offset);
+	iowrite32be(uccf->ucc_fast_tx_virtual_fifo_base_offset, &uf_regs->utfb);
+	iowrite32be(uccf->ucc_fast_rx_virtual_fifo_base_offset, &uf_regs->urfb);
 
 	/* Mux clocking */
 	/* Grant Support */
@@ -366,14 +366,14 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	}
 
 	/* Set interrupt mask register at UCC level. */
-	out_be32(&uf_regs->uccm, uf_info->uccm_mask);
+	iowrite32be(uf_info->uccm_mask, &uf_regs->uccm);
 
 	/* First, clear anything pending at UCC level,
 	 * otherwise, old garbage may come through
 	 * as soon as the dam is opened. */
 
 	/* Writing '1' clears */
-	out_be32(&uf_regs->ucce, 0xffffffff);
+	iowrite32be(0xffffffff, &uf_regs->ucce);
 
 	*uccf_ret = uccf;
 	return 0;
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 70339d7..f7a14f2 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -21,7 +21,6 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <asm/cpm.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 6113699..863cfec 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -76,7 +76,7 @@ static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 }
 
@@ -85,7 +85,7 @@ static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 }
 
@@ -95,7 +95,7 @@ static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
@@ -107,7 +107,7 @@ static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
@@ -120,10 +120,10 @@ static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	cascade_irq = qe_ic_get_high_irq(qe_ic);
-	if (cascade_irq == NO_IRQ)
+	if (cascade_irq == 0)
 		cascade_irq = qe_ic_get_low_irq(qe_ic);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
-- 
2.1.0.27.g96db324
