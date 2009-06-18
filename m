Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE829B741F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 12:40:01 +1000 (EST)
Received: from mail-pz0-f193.google.com (mail-pz0-f193.google.com
	[209.85.222.193]) by ozlabs.org (Postfix) with ESMTP id 201B5DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 12:40:00 +1000 (EST)
Received: by mail-pz0-f193.google.com with SMTP id 31so795732pzk.17
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 19:40:00 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3] powerpc/5200: add LocalPlus bus FIFO device driver
To: linuxppc-dev@ozlabs.org
Date: Wed, 17 Jun 2009 20:39:58 -0600
Message-ID: <20090618023957.11976.59147.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This is a driver for the LocalPlus bus FIFO device

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/include/asm/mpc52xx.h            |   36 ++
 arch/powerpc/platforms/52xx/Kconfig           |    4 
 arch/powerpc/platforms/52xx/Makefile          |    1 
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |  458 +++++++++++++++++++++++++
 4 files changed, 499 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c


diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 6716850..974fc8f 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -283,6 +283,42 @@ extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int period,
                             int continuous);
 extern void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
 
+/* mpc52xx_lpbfifo.c */
+#define MPC52XX_LPBFIFO_FLAG_READ		(0)
+#define MPC52XX_LPBFIFO_FLAG_WRITE		(1<<0)
+#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT	(1<<1)
+#define MPC52XX_LPBFIFO_FLAG_NO_DMA		(1<<2)
+#define MPC52XX_LPBFIFO_FLAG_POLL_DMA		(1<<3)
+
+struct mpc52xx_lpbfifo_request {
+	struct list_head list;
+
+	/* localplus bus address */
+	unsigned int cs;
+	size_t offset;
+
+	/* Memory address */
+	void *data;
+	phys_addr_t data_phys;
+
+	/* Details of transfer */
+	size_t size;
+	size_t pos;	/* current position of transfer */
+	int flags;
+
+	/* What to do when finished */
+	void (*callback)(struct mpc52xx_lpbfifo_request *);
+
+	void *priv;		/* Driver private data */
+
+	/* statistics */
+	int irq_count;
+	int irq_ticks;
+};
+
+extern int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req);
+extern void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req);
+
 /* mpc52xx_pic.c */
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 8b8e956..d64783e 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -62,3 +62,7 @@ config PPC_MPC5200_GPIO
 	select GENERIC_GPIO
 	help
 	  Enable gpiolib support for mpc5200 based boards
+
+config PPC_MPC5200_LPBFIFO
+	tristate "MPC5200 LocalPlus bus FIFO driver"
+	depends on PPC_MPC52xx
diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index bfd4f52..2bc8cd0 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -15,3 +15,4 @@ ifeq ($(CONFIG_PPC_LITE5200),y)
 endif
 
 obj-$(CONFIG_PPC_MPC5200_GPIO)	+= mpc52xx_gpio.o
+obj-$(CONFIG_PPC_MPC5200_LPBFIFO)	+= mpc52xx_lpbfifo.o
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
new file mode 100644
index 0000000..fe32ae5
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -0,0 +1,458 @@
+/*
+ * LocalPlus Bus FIFO driver for the Freescale MPC52xx.
+ *
+ * Copyright (C) 2009 Secret Lab Technologies Ltd.
+ *
+ * This file is released under the GPLv2
+ *
+ * Todo:
+ * - Add support for multiple requests to be queued.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/mpc52xx.h>
+#include <asm/time.h>
+
+#include <sysdev/bestcomm/bestcomm.h>
+#include <sysdev/bestcomm/bestcomm_priv.h>
+#include <sysdev/bestcomm/gen_bd.h>
+
+MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
+MODULE_DESCRIPTION("MPC5200 LocalPlus FIFO device driver");
+MODULE_LICENSE("GPL");
+
+#define LPBFIFO_REG_PACKET_SIZE		(0x00)
+#define LPBFIFO_REG_START_ADDRESS	(0x04)
+#define LPBFIFO_REG_CONTROL		(0x08)
+#define LPBFIFO_REG_ENABLE		(0x0C)
+#define LPBFIFO_REG_BYTES_DONE_STATUS	(0x14)
+#define LPBFIFO_REG_FIFO_DATA		(0x40)
+#define LPBFIFO_REG_FIFO_STATUS		(0x44)
+#define LPBFIFO_REG_FIFO_CONTROL	(0x48)
+#define LPBFIFO_REG_FIFO_ALARM		(0x4C)
+
+struct mpc52xx_lpbfifo {
+	struct device *dev;
+	phys_addr_t regs_phys;
+	void __iomem *regs;
+	int irq;
+	spinlock_t lock;
+
+	struct bcom_task *bcom_tx_task;
+	struct bcom_task *bcom_rx_task;
+	struct bcom_task *bcom_cur_task;
+
+	/* Current state data */
+	struct mpc52xx_lpbfifo_request *req;
+};
+
+/* The MPC5200 has only one fifo, so only need one instance structure */
+static struct mpc52xx_lpbfifo lpbfifo;
+
+/**
+ * mpc52xx_lpbfifo_kick - Trigger the next block of data to be transfered
+ */
+static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_request *req)
+{
+	size_t transfer_size = req->size - req->pos;
+	struct bcom_bd *bd;
+	void __iomem *reg;
+	u32 *data;
+	int i;
+
+	/* Set and clear the reset bits; is good practice in User Manual */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+
+	if (req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA) {
+		/* While the FIFO can be setup for transfer sizes as large as
+		 * 16M-1, the FIFO itself is only 512 bytes deep and it does
+		 * not generate interrupts for FIFO full events (only transfer
+		 * complete will raise an IRQ).  Therefore when not using
+		 * Bestcomm to drive the FIFO it needs to either be polled, or
+		 * transfers need to constrained to the size of the fifo.
+		 *
+		 * This driver restricts the size of the transfer
+		 */
+		if (transfer_size > 512)
+			transfer_size = 512;
+
+		/* Load the FIFO with data */
+		if (req->flags & MPC52XX_LPBFIFO_FLAG_WRITE) {
+			reg = lpbfifo.regs + LPBFIFO_REG_FIFO_DATA;
+			data = req->data + req->pos;
+			for (i = 0; i < transfer_size; i += 4)
+				out_be32(reg, *data++);
+		}
+
+		/* Unmask both error and completion irqs */
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x00000301);
+	} else {
+		/* Choose the correct direction */
+		if (req->flags & MPC52XX_LPBFIFO_FLAG_WRITE)
+			lpbfifo.bcom_cur_task = lpbfifo.bcom_tx_task;
+		else
+			lpbfifo.bcom_cur_task = lpbfifo.bcom_rx_task;
+
+		bd = bcom_prepare_next_buffer(lpbfifo.bcom_cur_task);
+		bd->status = transfer_size;
+		transfer_size += 4; /* BLECH! */
+		bd->data[0] = req->data_phys + req->pos;
+		bcom_submit_next_buffer(lpbfifo.bcom_cur_task, NULL);
+
+		/* Unmask error irq */
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x00000201);
+	}
+
+	/* Set transfer size, width, chip select and READ mode */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_START_ADDRESS,
+		 req->offset + req->pos);
+	out_be32(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, transfer_size);
+	out_be32(lpbfifo.regs + LPBFIFO_REG_CONTROL, req->cs << 24 | 0x010008);
+
+	/* Kick it off */
+	out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
+	if (!(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA))
+		bcom_enable(lpbfifo.bcom_cur_task);
+}
+
+/**
+ * mpc52xx_lpbfifo_irq - IRQ handler for LPB FIFO
+ */
+static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *dev_id)
+{
+	struct mpc52xx_lpbfifo_request *req;
+	u8 status = in_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS);
+	void __iomem *reg;
+	u32 *data;
+	int count, i;
+	int do_callback = 0;
+	u32 ts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lpbfifo.lock, flags);
+	ts = get_tbl();
+
+	req = lpbfifo.req;
+	if (!req) {
+		spin_unlock_irqrestore(&lpbfifo.lock, flags);
+		pr_err("bogus LPBFIFO IRQ\n");
+		return IRQ_HANDLED;
+	}
+
+	/*
+	 * This is a tricky bit of code.  There are 4 exit conditions:
+	 * 1. FIFO abort
+	 * 2. FIFO complete without DMA; more data to do
+	 * 3. FIFO complete without DMA; all data transfered
+	 * 4. FIFO complete using DMA
+	 *
+	 * Condition 1 can occur regardless of whether or not DMA is used.
+	 * It requires executing the callback to report the error and exiting
+	 * immediately.
+	 *
+	 * Condition 2 requires programming the FIFO with the next block of data
+	 *
+	 * Condition 3 requires executing the callback to report completion
+	 *
+	 * Condition 4 means the same as 3, except the callback must *not* be
+	 * executed.  Instead, execution of the callback is deferred to the DMA
+	 * interrupt handler.
+	 *
+	 * To make things trickier, the spinlock must be dropped before
+	 * executing the callback, otherwise we could end up with a deadlock
+	 * or nested spinlock condition.  The out path is non-trivial, so
+	 * extra fiddling is done to make sure all paths lead to the same
+	 * outbound code.
+	 */
+
+	/* check abort bit */
+	if (status & 0x10) {
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+		do_callback = 1;
+		goto out;
+	}
+
+	/* If using DMA, we should not be at this point */
+	if (!(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA)) {
+		pr_err("bad IRQ mask? mask:%.8x status:%.8x flags=%x\n",
+		       in_be32(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS),
+		       status, req->flags);
+		goto out;
+	}
+
+	/* If the transaction done bit is *not* set; then why are we here? */
+	if ((status & 0x01) == 0) {
+		pr_err("spurious IRQ? %x\n", status);
+		goto out;
+	}
+
+	/* Read result from hardware */
+	count = in_be32(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS);
+	count &= 0x00ffffff;
+
+	/* copy the data out of the FIFO */
+	if (!(req->flags & MPC52XX_LPBFIFO_FLAG_WRITE)) {
+		reg = lpbfifo.regs + LPBFIFO_REG_FIFO_DATA;
+		data = req->data + req->pos;
+		for (i = 0; i < count; i += 4)
+			*data++ = in_be32(reg);
+	}
+
+	/* Update transfer position and count */
+	req->pos += count;
+
+	/* Decide what to do next */
+	if (req->size - req->pos)
+		mpc52xx_lpbfifo_kick(req); /* more work to do */
+	else
+		do_callback = 1;
+
+ out:
+	/* Clear the IRQ */
+	out_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS, 0x01);
+
+	/* When the do_callback flag is set; it means the transfer is finished
+	 * so set the FIFO as idle */
+	if (do_callback)
+		lpbfifo.req = NULL;
+
+	/* Release the lock before calling out to the callback. */
+	req->irq_count++;
+	req->irq_ticks += get_tbl() - ts;
+	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+
+	/* Spinlock is released; it is now safe to call the callback */
+	if (do_callback && req->callback)
+		req->callback(req);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * mpc52xx_lpbfifo_bcom_irq - IRQ handler for LPB FIFO Bestcomm task
+ */
+static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, void *dev_id)
+{
+	struct mpc52xx_lpbfifo_request *req;
+	unsigned long flags;
+	u32 status;
+	u32 ts;
+
+	spin_lock_irqsave(&lpbfifo.lock, flags);
+	ts = get_tbl();
+
+	req = lpbfifo.req;
+	if (!req) {
+		spin_unlock_irqrestore(&lpbfifo.lock, flags);
+		WARN_ONCE(1, "bogus Bestcomm IRQ\n");
+		return IRQ_HANDLED;
+	}
+
+	bcom_retrieve_buffer(lpbfifo.bcom_cur_task, &status, NULL);
+
+	req->pos = status & 0x00ffffff;
+
+	/* Mark the FIFO as idle */
+	lpbfifo.req = NULL;
+
+	/* Release the lock before calling out to the callback. */
+	req->irq_count++;
+	req->irq_ticks += get_tbl() - ts;
+	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+
+	if (req->callback)
+		req->callback(req);
+
+	return IRQ_HANDLED;
+}
+
+
+/**
+ * mpc52xx_lpbfifo_submit - Submit an LPB FIFO transfer request.
+ * @req: Pointer to request structure
+ */
+int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req)
+{
+	unsigned long flags;
+
+	if (!lpbfifo.regs)
+		return -ENODEV;
+
+	spin_lock_irqsave(&lpbfifo.lock, flags);
+
+	/* If the req pointer is already set, then a transfer is in progress */
+	if (lpbfifo.req) {
+		spin_unlock_irqrestore(&lpbfifo.lock, flags);
+		return -EBUSY;
+	}
+
+	/* Setup the transfer */
+	lpbfifo.req = req;
+	req->irq_count = 0;
+	req->irq_ticks = 0;
+	req->pos = 0;
+
+	mpc52xx_lpbfifo_kick(req);
+	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(mpc52xx_lpbfifo_submit);
+
+void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req)
+{
+	unsigned long flags;
+
+	if (lpbfifo.req != req)
+		return;
+
+	spin_lock_irqsave(&lpbfifo.lock, flags);
+	/* Put it into reset and clear the state */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+	lpbfifo.req = NULL;
+	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+}
+EXPORT_SYMBOL(mpc52xx_lpbfifo_abort);
+
+static int __devinit
+mpc52xx_lpbfifo_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct resource res;
+	int rc = -ENOMEM;
+
+	if (lpbfifo.dev != NULL)
+		return -ENOSPC;
+
+	lpbfifo.irq = irq_of_parse_and_map(op->node, 0);
+	if (!lpbfifo.irq)
+		return -ENODEV;
+
+	if (of_address_to_resource(op->node, 0, &res))
+		return -ENODEV;
+	lpbfifo.regs_phys = res.start;
+	lpbfifo.regs = of_iomap(op->node, 0);
+	if (!lpbfifo.regs)
+		return -ENOMEM;
+
+	spin_lock_init(&lpbfifo.lock);
+
+	/* Put FIFO into reset */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+
+	/* Configure the watermarks so DMA will always complete correctly.
+	 * It may be worth experimenting with the ALARM value to see if
+	 * there is a performance impacit.  However, if it is wrong there
+	 * is a risk of DMA not transferring the last chunk of data */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM, 0x1ff);
+	out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL, 0);
+
+	/* Register the interrupt handler */
+	rc = request_irq(lpbfifo.irq, mpc52xx_lpbfifo_irq, 0,
+			 "mpc52xx-lpbfifo", &lpbfifo);
+	if (rc)
+		goto err_irq;
+
+	/* Request the Bestcomm receive (fifo --> memory) task and IRQ */
+	lpbfifo.bcom_rx_task =
+		bcom_gen_bd_rx_init(2, res.start + LPBFIFO_REG_FIFO_DATA,
+				    BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
+				    16*1024*1024);
+	if (!lpbfifo.bcom_rx_task)
+		goto err_bcom_rx;
+
+	rc = request_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task),
+			 mpc52xx_lpbfifo_bcom_irq, 0,
+			 "mpc52xx-lpbfifo-rx", &lpbfifo);
+	if (rc)
+		goto err_bcom_rx_irq;
+
+	/* Request the Bestcomm transmit (memory --> fifo) task and IRQ */
+	lpbfifo.bcom_tx_task =
+		bcom_gen_bd_tx_init(2, res.start + LPBFIFO_REG_FIFO_DATA,
+				    BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC);
+	if (!lpbfifo.bcom_tx_task)
+		goto err_bcom_tx;
+
+	rc = request_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task),
+			 mpc52xx_lpbfifo_bcom_irq, 0,
+			 "mpc52xx-lpbfifo-tx", &lpbfifo);
+	if (rc)
+		goto err_bcom_tx_irq;
+
+	lpbfifo.dev = &op->dev;
+	return 0;
+
+ err_bcom_tx_irq:
+	bcom_gen_bd_tx_release(lpbfifo.bcom_tx_task);
+ err_bcom_tx:
+	free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo);
+ err_bcom_rx_irq:
+	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
+ err_bcom_rx:
+ err_irq:
+	iounmap(lpbfifo.regs);
+	lpbfifo.regs = NULL;
+
+	dev_err(&op->dev, "mpc52xx_lpbfifo_probe() failed\n");
+	return -ENODEV;
+}
+
+
+static int __devexit mpc52xx_lpbfifo_remove(struct of_device *op)
+{
+	if (lpbfifo.dev != &op->dev)
+		return 0;
+
+	/* Put FIFO in reset */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+
+	/* Release the bestcomm transmit task */
+	free_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task), &lpbfifo);
+	bcom_gen_bd_tx_release(lpbfifo.bcom_tx_task);
+	
+	/* Release the bestcomm receive task */
+	free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo);
+	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
+
+	free_irq(lpbfifo.irq, &lpbfifo);
+	iounmap(lpbfifo.regs);
+	lpbfifo.regs = NULL;
+	lpbfifo.dev = NULL;
+
+	return 0;
+}
+
+static struct of_device_id mpc52xx_lpbfifo_match[] __devinitconst = {
+	{ .compatible = "fsl,mpc5200-lpbfifo", },
+	{},
+};
+
+static struct of_platform_driver mpc52xx_lpbfifo_driver = {
+	.owner = THIS_MODULE,
+	.name = "mpc52xx-lpbfifo",
+	.match_table = mpc52xx_lpbfifo_match,
+	.probe = mpc52xx_lpbfifo_probe,
+	.remove = __devexit_p(mpc52xx_lpbfifo_remove),
+};
+
+/***********************************************************************
+ * Module init/exit
+ */
+static int __init mpc52xx_lpbfifo_init(void)
+{
+	pr_debug("Registering LocalPlus bus FIFO driver\n");
+	return of_register_platform_driver(&mpc52xx_lpbfifo_driver);
+}
+module_init(mpc52xx_lpbfifo_init);
+
+static void __exit mpc52xx_lpbfifo_exit(void)
+{
+	pr_debug("Unregistering LocalPlus bus FIFO driver\n");
+	of_unregister_platform_driver(&mpc52xx_lpbfifo_driver);
+}
+module_exit(mpc52xx_lpbfifo_exit);
