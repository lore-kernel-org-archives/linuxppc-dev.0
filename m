Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 4730ADE046
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 05:05:00 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so3193781wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 11:04:58 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 2/2] powerpc/5200: add LocalPlus bus FIFO device driver
To: linuxppc-dev@ozlabs.org
Date: Tue, 24 Mar 2009 12:04:55 -0600
Message-ID: <20090324180455.31372.56524.stgit@localhost.localdomain>
In-Reply-To: <20090324180248.31372.22557.stgit@localhost.localdomain>
References: <20090324180248.31372.22557.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jean-philippe.jacquemin@barco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This is a driver for the LocalPlus bus FIFO device

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/include/asm/mpc52xx.h            |   11 +
 arch/powerpc/platforms/52xx/Kconfig           |    4 
 arch/powerpc/platforms/52xx/Makefile          |    1 
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |  285 +++++++++++++++++++++++++
 4 files changed, 301 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c


diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 9eac3d9..ded652a 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -283,6 +283,17 @@ extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int period,
                             int continuous);
 extern void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
 
+/* mpc52xx_lpbfifo.c */
+extern int mpc52xx_lpbfifo_write(void *src, unsigned int cs,
+				 size_t offset, size_t size, int flags,
+				 void (*callback)(void *, size_t, int),
+				 void *callback_data);
+extern int mpc52xx_lpbfifo_read(void *dest, unsigned int cs,
+				size_t offset, size_t size, int flags,
+				void (*callback)(void *, size_t, int),
+				void *callback_data);
+extern void mpc52xx_lpbfifo_abort(void *callback_data);
+
 /* mpc52xx_pic.c */
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 75f82ab..ba1348e 100644
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
index 0000000..0d51515
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -0,0 +1,285 @@
+/*
+ * LocalPlus Bus FIFO driver for the Freescale MPC52xx.
+ *
+ * Copyright (C) 2009 Secret Lab Technologies Ltd.
+ *
+ * This file is released under the GPLv2
+ *
+ * Todo:
+ * - Implement mpc52xx_lpbfifo_write
+ * - Add Bestcomm DMA support
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
+	void __iomem *regs;
+	int irq;
+	spinlock_t lock;
+
+	/* Current transfer data */
+	void *data;
+	int cs;
+	size_t offset;
+	size_t size;
+	size_t remaining;
+	void (*callback)(void *, size_t, int);
+	void *callback_data;
+};
+
+/* The MPC5200 has only one fifo, so only need one instance structure */
+static struct mpc52xx_lpbfifo lpbfifo;
+
+/**
+ * mpc52xx_lpbfifo_kick - Trigger the next block of data to be transfered
+ */
+static void mpc52xx_lpbfifo_kick(void)
+{
+	size_t transfer_size = lpbfifo.remaining;
+
+	/* While the FIFO can be setup for transfer sizes as large as 16M-1,
+	 * the FIFO itself is only 512 bytes deep and it does not generate
+	 * interrupts for FIFO full events (only transfer complete will
+	 * raise an IRQ).  Therefore when not using Bestcomm to drive the
+	 * FIFO it needs to either be polled, or transfers need to constrained
+	 * to the size of the fifo.
+	 *
+	 * Here we choose to restrict the size of the transfer
+	 */
+	if (transfer_size > 512)
+		transfer_size = 512;
+
+	/* Set and clear the reset bits; is good practice in User Manual */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x00000301);
+
+	/* Set transfer size, width, chip select and READ mode */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_START_ADDRESS, lpbfifo.offset);
+	out_be32(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, transfer_size);
+	out_be32(lpbfifo.regs + LPBFIFO_REG_CONTROL,
+		 lpbfifo.cs << 24 | 0x00010008);
+
+	/* Kick it off */
+	out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
+}
+
+/**
+ * mpc52xx_lpbfifo_irq - IRQ handler for LPB FIFO
+ */
+static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *dev_id)
+{
+	u8 status = in_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS);
+	u32 *data;
+	int count, i;
+	void (*callback)(void *, size_t, int);
+	void *callback_data;
+
+	spin_lock(&lpbfifo.lock);
+
+	if (status & 0x10) { /* check abort bit */
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+	} else if (status & 0x01) { /* check transaction done bit */
+		/* Read result from hardware */
+		count = in_be32(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS);
+		count &= 0x00ffffff;
+
+		data = lpbfifo.data;
+		for (i = 0; i < count; i += 4)
+			*data++ = in_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_DATA);
+
+		/* Update transfer position and count */
+		lpbfifo.remaining -= count;
+		lpbfifo.offset += count;
+		lpbfifo.data += count;
+
+		/* Clear the IRQ */
+		out_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS, 0x01);
+
+		if (lpbfifo.remaining) {
+			/* More work to do.  Kick of the next block and exit */
+			mpc52xx_lpbfifo_kick();
+			spin_unlock(&lpbfifo.lock);
+			return IRQ_HANDLED;
+		}
+	}
+
+	/* Mark the FIFO as idle */
+	lpbfifo.data = NULL;
+	callback = lpbfifo.callback;
+	callback_data = lpbfifo.callback_data;
+	count = lpbfifo.size - lpbfifo.remaining;
+
+	/* Release the lock before calling out to the callback. */
+	spin_unlock(&lpbfifo.lock);
+
+	/* If control reaches this point then the transfer is finished,
+	 * either normal completion or due to abort */
+	callback(callback_data, count, (status & 0x10) != 0);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * mpc52xx_lpbfifo_read - Initiate an LPB fifo READ transaction
+ * @data: location to copy data into
+ * @cs: LocalPlus bus chip select number for transfer
+ * @offset: Location of data to read as an offset from the CS base address
+ * @size: Size of transfer in bytes
+ * @callback: Callback function for FIFO events.  Will be called when the
+ *            FIFO high watermark is reached, when the transfer finishes,
+ *            and if a FIFO error occurs.
+ * @data: Private data pointer to be passed to callback function.
+ */
+int mpc52xx_lpbfifo_read(void *dest, unsigned int cs,
+			 size_t offset, size_t size, int mode_flags,
+			 void (*callback)(void *, size_t, int),
+			 void *callback_data)
+{
+	int rc = -EBUSY;
+	unsigned long flags;
+
+	if (!lpbfifo.regs)
+		return -ENODEV;
+
+	spin_lock_irqsave(&lpbfifo.lock, flags);
+	/* If the data pointer is already set then a transfer is in progress */
+	if (lpbfifo.data)
+		goto out;
+
+	/* Setup the transfer */
+	lpbfifo.data = dest;
+	lpbfifo.cs = cs;
+	lpbfifo.offset = offset;
+	lpbfifo.remaining = lpbfifo.size = size;
+	lpbfifo.callback = callback;
+	lpbfifo.callback_data = callback_data;
+
+	mpc52xx_lpbfifo_kick();
+	rc = 0;
+
+ out:
+	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL(mpc52xx_lpbfifo_read);
+
+void mpc52xx_lpbfifo_abort(void *callback_data)
+{
+	unsigned long flags;
+
+	if (lpbfifo.callback_data != callback_data)
+		return;
+
+	spin_lock_irqsave(&lpbfifo.lock, flags);
+	/* Put it into reset and clear the state */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+	lpbfifo.data = NULL;
+	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+}
+EXPORT_SYMBOL(mpc52xx_lpbfifo_abort);
+
+static int __devinit
+mpc52xx_lpbfifo_probe(struct of_device *op, const struct of_device_id *match)
+{
+	int rc;
+
+	if (lpbfifo.dev != NULL)
+		return -ENOSPC;
+
+	lpbfifo.regs = of_iomap(op->node, 0);
+	if (!lpbfifo.regs)
+		return -ENOMEM;
+
+	lpbfifo.irq = irq_of_parse_and_map(op->node, 0);
+	if (!lpbfifo.irq) {
+		lpbfifo.regs = NULL;
+		iounmap(lpbfifo.regs);
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&lpbfifo.lock);
+
+	/* Put FIFO into reset */
+	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+
+	/* Register the interrupt handler */
+	rc = request_irq(lpbfifo.irq, mpc52xx_lpbfifo_irq, 0,
+			 "mpc52xx-lpbfifo", &lpbfifo);
+	if (rc) {
+		pr_err("request_irq() failed.  rc=%i\n", rc);
+		lpbfifo.regs = NULL;
+		free_irq(lpbfifo.irq, &lpbfifo);
+		iounmap(lpbfifo.regs);
+	}
+
+	lpbfifo.dev = &op->dev;
+	pr_info("LPB FIFO ready; regs=%p irq=%i\n", lpbfifo.regs, lpbfifo.irq);
+	return 0;
+}
+
+
+static int __devexit mpc52xx_lpbfifo_remove(struct of_device *op)
+{
+	if (lpbfifo.dev == &op->dev) {
+		/* Put FIFO in reset */
+		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+		lpbfifo.regs = NULL;
+		free_irq(lpbfifo.irq, &lpbfifo);
+		iounmap(lpbfifo.regs);
+		lpbfifo.dev = NULL;
+	}
+	return 0;
+}
+
+static struct of_device_id mpc52xx_lpbfifo_match[] __devinitdata = {
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
