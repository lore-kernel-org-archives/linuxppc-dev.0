Return-Path: <eha@doredevelopment.dk>
Received: from bq8.dotserv.com (bq8.dotserv.com [193.201.35.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EAA42DE0B8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 19:15:22 +1000 (EST)
Received: from [192.168.18.32] ([77.233.226.18]) (authenticated bits=0)
	by bq8.dotserv.com (8.13.1/8.13.1) with ESMTP id m5K99nU8027224
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 11:09:54 +0200
Message-ID: <485B73DC.8070707@doredevelopment.dk>
Date: Fri, 20 Jun 2008 11:09:48 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] CPM2 i2c driver
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

Here is an i2c driver for Freescale processors with CPM2. It is based on
previous work by Angelos Manousaridis which again were based on a driver
from Heiko Schocher.

I am using it on an in-house MPC8270 target, and don't have access to
any other boards with CPM2.  So if anybody is able to test this driver
with a supported board, I would by happy to help out.  It would be nice
to have it tested and integrated with one or more reference boards, and
have the needed dts changed included also.

Best regards,
Esben Haabendal

-------- Original Message --------
Subject: i2c-cpm2.patch
Date: Fri, 20 Jun 2008 11:02:3ga3 +0200
From: Esben Haabendal <esben@eha.doredevelopment.dk>
To: eha@doredevelopment.dk

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ca54563..662c076 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -537,6 +537,45 @@ static int __init fsl_i2c_of_init(void)
 		i++;
 	}

+	for_each_compatible_node(np, NULL, "fsl-cpm2-i2c") {
+		struct resource r[2];
+		struct fsl_i2c_platform_data i2c_data;
+		const unsigned char *flags = NULL;
+
+		printk(KERN_INFO "%s: fsl-cpm2-i2c node found\n", __FUNCTION__);
+
+		memset(&r, 0, sizeof(r));
+		memset(&i2c_data, 0, sizeof(i2c_data));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+		printk(KERN_INFO "%s: r[0] = %x %x\n",
+		       __FUNCTION__, r[0].start, r[0].end);
+
+		of_irq_to_resource(np, 0, &r[1]);
+		printk(KERN_INFO "%s: r[1] = %x %x\n",
+		       __FUNCTION__, r[1].start, r[2].end);
+
+		i2c_dev = platform_device_register_simple(
+			"fsl-cpm2-i2c", i, r, 2);
+		if (IS_ERR(i2c_dev)) {
+			ret = PTR_ERR(i2c_dev);
+			goto err;
+		}
+
+		i2c_data.device_flags = 0;
+
+		ret =
+		    platform_device_add_data(i2c_dev, &i2c_data,
+					     sizeof(struct
+						    fsl_i2c_platform_data));
+		if (ret)
+			goto unreg;
+
+		of_register_i2c_devices(np, i++);
+	}
+
 	return 0;

 unreg:
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 48438cc..3715d12 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -305,6 +305,16 @@ config I2C_MPC
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mpc.

+config I2C_CPM2
+	tristate "MPC CPM2"
+	depends on I2C && PPC32 && CPM2
+	help
+	  If you say yes to this option, support will be included for the
+	  I2C interface on PPC with CPM2
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-cpm2.
+
 config I2C_NFORCE2
 	tristate "Nvidia nForce2, nForce3 and nForce4"
 	depends on PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index e8c882a..544decb 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_I2C_CPM2)		+= i2c-cpm2.o

 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/busses/i2c-cpm2.c b/drivers/i2c/busses/i2c-cpm2.c
new file mode 100644
index 0000000..cca1eba
--- /dev/null
+++ b/drivers/i2c/busses/i2c-cpm2.c
@@ -0,0 +1,609 @@
+/*
+ * (C) Copyright 2005
+ * Heiko Schocher <hs@denx.de>
+ *
+ * (C) Copyright 2006
+ * Angelos Manousaridis <amanous@inaccessnetworks.com>
+ *
+ * (C) Copyright 2008
+ * Esben Haabendal <eha@doredevelopment.dk>
+ *
+ * This is a combined i2c adapter and algorithm driver for
+ * PPC with CPM2, based on initial work by first Heiko Schocher,
+ * reworked by Angelos Manousaridis, and finally reshaped a bit by
+ * Esben Haabendal.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <asm/fs_pd.h>
+#include <asm/cacheflush.h>
+
+#define CPM_MAX_READ	513
+
+struct cpm2_i2c {
+	struct i2c_adapter adap;
+	wait_queue_head_t queue;
+	u32 irq;
+	spinlock_t lock;
+	i2c_cpm2_t *regs;
+	u16 *base;
+	ushort dp_offset;
+	iic_t *dp_addr;
+	ushort rbdf_offset;
+	cbd_t *rbdf_addr;
+	ushort tbdf_offset;
+	cbd_t *tbdf_addr;
+	enum { I2C_IDLE, I2C_TX_WAIT, I2C_TX_DONE, I2C_TX_ERROR,
+	       I2C_RX_WAIT, I2C_RX_DONE, I2C_RX_ERROR } state;
+};
+
+
+static irqreturn_t cpm2_i2c_isr(int irq, void *dev_id)
+{
+	struct cpm2_i2c *i2c = dev_id;
+	unsigned short isr;
+	int oldstate = i2c->state;
+
+	spin_lock(&i2c->lock);
+
+	isr = in_8(&i2c->regs->i2c_i2cer);
+	/* Acknowledge all interrupts */
+	out_8(&i2c->regs->i2c_i2cer, 0xff);
+	/* Disable I2C */
+	clrbits8(&i2c->regs->i2c_i2mod, 0x01);
+	dev_dbg(&i2c->adap.dev, "INT isr %x state %d\n",
+		isr, i2c->state);
+
+	switch (i2c->state) {
+		case I2C_TX_WAIT:
+			if (isr & 0x02) { /* TX DONE */
+				i2c->state = I2C_TX_DONE;
+				udelay(20); // wait 2 character times (100 kHz)
+				wake_up_interruptible(&i2c->queue);
+			}
+			if (isr & 0x10) { /* TX ERROR */
+				i2c->state = I2C_TX_ERROR;
+				wake_up_interruptible(&i2c->queue);
+			}
+			break;
+		case I2C_RX_WAIT:
+			if (isr & 0x02) {
+				/* TX DONE (triggered when RX is done) */
+				i2c->state = I2C_RX_DONE;
+				wake_up_interruptible(&i2c->queue);
+			}
+			if (isr & 0x10) { /* TX ERROR */
+				i2c->state = I2C_RX_ERROR;
+				wake_up_interruptible(&i2c->queue);
+			}
+			break;
+		default:
+			/* Keep gcc happy */
+			break;
+	}
+
+	if (i2c->state == oldstate) {
+		dev_info(&i2c->adap.dev,
+			 "no state change. spurious interrupt?\n");
+	}
+
+	spin_unlock(&i2c->lock);
+	return IRQ_HANDLED;
+}
+
+
+static void
+cpm2_pin_init(struct cpm2_i2c *i2c)
+{
+	/* Make a stop condition */
+	cpm2_immr->im_ioport.iop_pdatd |= 0x00030000;
+	cpm2_immr->im_ioport.iop_ppard &= ~0x00030000;
+	cpm2_immr->im_ioport.iop_pdird |= 0x00030000;
+	cpm2_immr->im_ioport.iop_podrd |= 0x00030000;
+	cpm2_immr->im_ioport.iop_psord |= 0x00030000;
+	udelay(5);
+	cpm2_immr->im_ioport.iop_pdatd &= ~0x00020000;
+	udelay(5);
+	cpm2_immr->im_ioport.iop_pdatd |= 0x00030000;
+
+	/* Initialize Port D I2C pins */
+	cpm2_immr->im_ioport.iop_ppard |= 0x00030000;
+	cpm2_immr->im_ioport.iop_pdird &= ~0x00030000;
+	cpm2_immr->im_ioport.iop_podrd |= 0x00030000;
+	cpm2_immr->im_ioport.iop_psord |= 0x00030000;
+}
+
+
+static void
+cpm2_pram_init(struct cpm2_i2c *i2c)
+{
+	/* Set Rx/TxBD table base address */
+	i2c->dp_addr->iic_rbase = i2c->rbdf_offset;
+	i2c->dp_addr->iic_tbase = i2c->tbdf_offset;
+
+	/* Enable memory snooping and big endian byte ordering */
+	i2c->dp_addr->iic_rfcr = CPMFCR_GBL | CPMFCR_EB;
+	i2c->dp_addr->iic_tfcr = CPMFCR_GBL | CPMFCR_EB;
+
+	/* Set maximum receive buffer length */
+	i2c->dp_addr->iic_mrblr = CPM_MAX_READ;
+
+	/* Clear remaining parameters */
+	i2c->dp_addr->iic_rstate = 0;
+	i2c->dp_addr->iic_rdp = 0;
+	i2c->dp_addr->iic_rbptr = 0;
+	i2c->dp_addr->iic_rbc = 0;
+	i2c->dp_addr->iic_rxtmp = 0;
+	i2c->dp_addr->iic_tstate = 0;
+	i2c->dp_addr->iic_tdp = 0;
+	i2c->dp_addr->iic_tbptr = 0;
+	i2c->dp_addr->iic_tbc = 0;
+	i2c->dp_addr->iic_txtmp = 0;
+}
+
+
+static int
+cpm2_i2c_read(struct cpm2_i2c *i2c, u_char i2c_addr, char *buf, int count)
+{
+	u_char temp[CPM_MAX_READ];
+	ulong flags;
+
+	if (count >= CPM_MAX_READ)
+		return -EINVAL;
+
+	dev_info(&i2c->adap.dev, "read %d bytes from 0x%02x\n",
+		 count, i2c_addr);
+
+	/* setup a transmit buffer. First byte is slave address. Length is
+	 * count + 1. the rest of the bits are used for timing and are left
+	 * uninitialized */
+	temp[0] = i2c_addr;
+	out_be32(&i2c->tbdf_addr->cbd_bufaddr, virt_to_bus(temp));
+	out_be16(&i2c->tbdf_addr->cbd_datlen, count + 1);
+	out_be16(&i2c->tbdf_addr->cbd_sc,
+		 BD_I2C_READY | BD_I2C_LAST | BD_I2C_WRAP | BD_I2C_INTRPT);
+
+	/* setup receive buffer and read length */
+	i2c->dp_addr->iic_mrblr = count;
+	out_be32(&i2c->rbdf_addr->cbd_bufaddr, virt_to_bus(buf));
+	out_be16(&i2c->rbdf_addr->cbd_datlen, 0);
+	out_be16(&i2c->rbdf_addr->cbd_sc, BD_I2C_EMPTY | BD_I2C_WRAP);
+
+	wmb();
+	flush_dcache_range((ulong)temp, (ulong)(temp + 1));
+
+	i2c->state = I2C_RX_WAIT;
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	out_8(&i2c->regs->i2c_i2cmr, 0x12);	/* enable some interrupts */
+	out_8(&i2c->regs->i2c_i2cer, 0xff);
+	wmb();
+	setbits8(&i2c->regs->i2c_i2mod, 0x01);	/* enable */
+	wmb();
+	out_8(&i2c->regs->i2c_i2com, 0x81);	/* set master and start */
+	wmb();
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	/* Wait for I2C transfer */
+	if (wait_event_interruptible(i2c->queue,
+				     ((i2c->state==I2C_RX_DONE) ||
+				      (i2c->state==I2C_RX_ERROR))))
+		return -ERESTARTSYS;
+
+	invalidate_dcache_range((ulong)buf, (ulong)(buf + count));
+
+	if (i2c->state == I2C_RX_ERROR)
+		dev_info(&i2c->adap.dev, "RX error\n");
+
+	if (in_be16(&i2c->tbdf_addr->cbd_sc) & BD_I2C_NAK) {
+		dev_info(&i2c->adap.dev, "no ack in transmit\n");
+		return 0;
+	}
+	if (in_be16(&i2c->tbdf_addr->cbd_sc) & BD_I2C_OV) {
+		dev_info(&i2c->adap.dev, "write overrun\n");
+		return 0;
+	}
+	if (in_be16(&i2c->tbdf_addr->cbd_sc) & BD_I2C_CL) {
+		dev_info(&i2c->adap.dev, "write collision\n");
+		return 0;
+	}
+	if (in_be16(&i2c->rbdf_addr->cbd_sc) & BD_I2C_EMPTY) {
+		dev_info(&i2c->adap.dev, "read complete but rbuf empty\n");
+		return 0;
+	}
+	if (in_be16(&i2c->rbdf_addr->cbd_sc) & BD_I2C_OV) {
+		dev_info(&i2c->adap.dev, "read overrun\n");
+		return 0;
+	}
+
+	if (in_be16(&i2c->rbdf_addr->cbd_datlen) < count) {
+		dev_info(&i2c->adap.dev, "read short. wanted %d got %d\n",
+			 count, i2c->rbdf_addr->cbd_datlen);
+	}
+
+	return in_be16(&i2c->rbdf_addr->cbd_datlen);
+}
+
+
+static int
+cpm2_i2c_write(struct cpm2_i2c *i2c, u_char i2c_addr, char *buf, int count)
+{
+	u_char temp[CPM_MAX_READ];
+	ulong flags;
+
+	dev_info(&i2c->adap.dev, "write %d bytes to 0x%02x\n",
+		 count, i2c_addr);
+	dev_dbg(&i2c->adap.dev, "%s: %hx %p %u %hx %hx %hx\n", __FUNCTION__,
+		i2c_addr, buf, count, buf[0], buf[1], buf[2]);
+
+	/* setup transmit buffers. First buffer contains one byte, the slave
+	 * address. The second buffer contains the actual data */
+	temp[0] = i2c_addr;
+	out_be32(&i2c->tbdf_addr[0].cbd_bufaddr, virt_to_bus(temp));
+	out_be16(&i2c->tbdf_addr[0].cbd_datlen, 1);
+	out_be16(&i2c->tbdf_addr[0].cbd_sc, BD_I2C_READY | BD_I2C_START);
+	out_be32(&i2c->tbdf_addr[1].cbd_bufaddr, virt_to_bus(buf));
+	out_be16(&i2c->tbdf_addr[1].cbd_datlen, count);
+	out_be16(&i2c->tbdf_addr[1].cbd_sc,
+		 BD_I2C_READY | BD_I2C_INTRPT | BD_I2C_LAST | BD_I2C_WRAP);
+	out_be16(&i2c->rbdf_addr->cbd_sc, BD_I2C_WRAP);
+
+	dev_dbg(&i2c->adap.dev, "%s: pre-pram  "
+		"tbase=%08x tstate=%08x tptr=%08x tbptr=%04hx tcount=%d\n",
+		__FUNCTION__,
+		i2c->dp_addr->iic_tbase,
+		i2c->dp_addr->iic_tstate,
+		i2c->dp_addr->iic_tdp,
+		i2c->dp_addr->iic_tbptr,
+		i2c->dp_addr->iic_tbc);
+	dev_dbg(&i2c->adap.dev, "%s: pre-pram  "
+		"rbase=%08x rstate=%08x rptr=%08x rbptr=%04hx rcount=%d\n",
+		__FUNCTION__,
+		i2c->dp_addr->iic_rbase,
+		i2c->dp_addr->iic_rstate,
+		i2c->dp_addr->iic_rdp,
+		i2c->dp_addr->iic_rbptr,
+		i2c->dp_addr->iic_rbc);
+	dev_dbg(&i2c->adap.dev, "%s: pre-tbdf %08x %d %04hx %08x %d %04hx\n",
+		__FUNCTION__,
+		in_be32(&i2c->tbdf_addr[0].cbd_bufaddr),
+		in_be16(&i2c->tbdf_addr[0].cbd_datlen),
+		in_be16(&i2c->tbdf_addr[0].cbd_sc),
+		in_be32(&i2c->tbdf_addr[1].cbd_bufaddr),
+		in_be16(&i2c->tbdf_addr[1].cbd_datlen),
+		in_be16(&i2c->tbdf_addr[1].cbd_sc));
+	dev_dbg(&i2c->adap.dev, "%s: pre-rbdf %08x %d %04hx %08x %d %04hx\n",
+		__FUNCTION__,
+		in_be32(&i2c->rbdf_addr[0].cbd_bufaddr),
+		in_be16(&i2c->rbdf_addr[0].cbd_datlen),
+		in_be16(&i2c->rbdf_addr[0].cbd_sc),
+		in_be32(&i2c->rbdf_addr[1].cbd_bufaddr),
+		in_be16(&i2c->rbdf_addr[1].cbd_datlen),
+		in_be16(&i2c->rbdf_addr[1].cbd_sc));
+
+	wmb();
+	flush_dcache_range((ulong)temp, (ulong)(temp + 1));
+	flush_dcache_range((ulong)buf, (ulong)(buf + count));
+
+	i2c->state = I2C_TX_WAIT;
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	out_8(&i2c->regs->i2c_i2cmr, 0x12);	/* enable some interrupts */
+	out_8(&i2c->regs->i2c_i2cer, 0xff);
+	setbits8(&i2c->regs->i2c_i2mod, 0x01);	/* enable */
+	out_8(&i2c->regs->i2c_i2com, 0x81);	/* set master and start */
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	if (wait_event_interruptible(i2c->queue,
+				     ((i2c->state==I2C_TX_DONE) ||
+				      (i2c->state==I2C_TX_ERROR))))
+		return -ERESTARTSYS;
+
+	dev_dbg(&i2c->adap.dev, "%s: post-pram "
+		"tbase=%08x tstate=%08x tptr=%08x tbptr=%04hx tcount=%d\n",
+		__FUNCTION__,
+		i2c->dp_addr->iic_tbase,
+		i2c->dp_addr->iic_tstate,
+		i2c->dp_addr->iic_tdp,
+		i2c->dp_addr->iic_tbptr,
+		i2c->dp_addr->iic_tbc);
+	dev_dbg(&i2c->adap.dev, "%s: post-pram "
+		"rbase=%08x rstate=%08x rptr=%08x rbptr=%04hx rcount=%d\n",
+		__FUNCTION__,
+		i2c->dp_addr->iic_rbase,
+		i2c->dp_addr->iic_rstate,
+		i2c->dp_addr->iic_rdp,
+		i2c->dp_addr->iic_rbptr,
+		i2c->dp_addr->iic_rbc);
+	dev_dbg(&i2c->adap.dev, "%s: post-tbdf %08x %d %04hx %08x %d %04hx\n",
+		__FUNCTION__,
+		in_be32(&i2c->tbdf_addr[0].cbd_bufaddr),
+		in_be16(&i2c->tbdf_addr[0].cbd_datlen),
+		in_be16(&i2c->tbdf_addr[0].cbd_sc),
+		in_be32(&i2c->tbdf_addr[1].cbd_bufaddr),
+		in_be16(&i2c->tbdf_addr[1].cbd_datlen),
+		in_be16(&i2c->tbdf_addr[1].cbd_sc));
+	dev_dbg(&i2c->adap.dev, "%s: post-rbdf %08x %d %04hx %08x %d %04hx\n",
+		__FUNCTION__,
+		in_be32(&i2c->rbdf_addr[0].cbd_bufaddr),
+		in_be16(&i2c->rbdf_addr[0].cbd_datlen),
+		in_be16(&i2c->rbdf_addr[0].cbd_sc),
+		in_be32(&i2c->rbdf_addr[1].cbd_bufaddr),
+		in_be16(&i2c->rbdf_addr[1].cbd_datlen),
+		in_be16(&i2c->rbdf_addr[1].cbd_sc));
+
+	if (i2c->state == I2C_TX_ERROR)
+		dev_info(&i2c->adap.dev, "TX error\n");
+
+	dev_dbg(&i2c->adap.dev, "%s: %hx %p %u %hx %hx %hx\n", __FUNCTION__,
+		i2c_addr, buf, count, buf[0], buf[1], buf[2]);
+
+	if ((in_be16(&i2c->tbdf_addr[0].cbd_sc) & BD_I2C_NAK) ||
+	    (in_be16(&i2c->tbdf_addr[1].cbd_sc) & BD_I2C_NAK)) {
+		dev_info(&i2c->adap.dev, "no ack in transmit\n");
+		return 0;
+	}
+	if ((in_be16(&i2c->tbdf_addr[0].cbd_sc) & BD_I2C_OV) ||
+	    (in_be16(&i2c->tbdf_addr[1].cbd_sc) & BD_I2C_OV)) {
+		dev_info(&i2c->adap.dev, "write overrun\n");
+		return 0;
+	}
+	if ((in_be16(&i2c->tbdf_addr[0].cbd_sc) & BD_I2C_CL) ||
+	    (in_be16(&i2c->tbdf_addr[1].cbd_sc) & BD_I2C_CL)) {
+		dev_info(&i2c->adap.dev, "write collision\n");
+		return 0;
+	}
+	if ((in_be16(&i2c->tbdf_addr[0].cbd_sc) & BD_I2C_READY) ||
+	    (in_be16(&i2c->tbdf_addr[1].cbd_sc) & BD_I2C_READY)) {
+		dev_info(&i2c->adap.dev,
+			 "ready is still up in transmit buffer\n");
+		return 0;
+	}
+
+	return count;
+}
+
+static int cpm2_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
int num)
+{
+	struct i2c_msg *pmsg;
+	struct cpm2_i2c *cpm2_i2c = i2c_get_adapdata(adap);
+	int i;
+	int ret = 0;
+	u_char addr;
+
+	dev_dbg(&adap->dev, "%s: %p %d\n", __FUNCTION__, msgs, num);
+
+	for (i = 0; i < num; i++) {
+		pmsg = &msgs[i];
+		addr = pmsg->addr << 1;
+		if (pmsg->flags & I2C_M_RD)
+			addr |= 1;
+		if (pmsg->flags & I2C_M_REV_DIR_ADDR)
+			addr ^= 1;
+		dev_dbg(&adap->dev, "%s: %hx %hx %hu %p\n",
+			__FUNCTION__,
+			pmsg->addr, pmsg->flags, pmsg->len, pmsg->buf);
+		if (pmsg->flags & I2C_M_RD) {
+			/* read bytes into buffer*/
+			ret = cpm2_i2c_read(cpm2_i2c, addr,
+					    pmsg->buf, pmsg->len);
+			dev_dbg(&cpm2_i2c->adap.dev, "read %d bytes\n", ret);
+			if (ret < pmsg->len) {
+				return (ret<0) ? ret : -EREMOTEIO;
+			}
+		} else {
+			/* write bytes from buffer */
+			ret = cpm2_i2c_write(cpm2_i2c, addr,
+					     pmsg->buf, pmsg->len);
+			dev_dbg(&cpm2_i2c->adap.dev, "wrote %d\n", ret);
+			if (ret < pmsg->len) {
+				return (ret<0) ? ret : -EREMOTEIO;
+			}
+		}
+	}
+	return (ret < 0) ? ret : num;
+}
+
+static u32 cpm2_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm cpm2_algo = {
+	.master_xfer = cpm2_xfer,
+	.functionality = cpm2_functionality,
+};
+
+static struct i2c_adapter cpm2_ops = {
+	.owner = THIS_MODULE,
+	.name = "MPC CPM2 adapter",
+	.id = I2C_HW_CPM2,
+	.algo = &cpm2_algo,
+	.class = I2C_CLASS_HWMON,
+	.timeout = 1,
+	.retries = 1
+};
+
+static int cpm2_i2c_probe(struct platform_device *pdev)
+{
+	struct cpm2_i2c *i2c;
+	struct resource *r;
+	void *start;
+	int result = 0;
+
+	dev_info(&pdev->dev, "probed (id=%d)\n", pdev->id);
+
+	i2c = kmalloc(sizeof(*i2c), GFP_KERNEL);
+	if (i2c == NULL)
+		return -ENOMEM;
+	memset(i2c, 0, sizeof(*i2c));
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		dev_err(&pdev->dev, "register resource not found\n");
+		result = -EINVAL;
+		goto fail_map1;
+	}
+
+	start = ioremap((phys_addr_t)r->start, sizeof(i2c_cpm2_t));
+	if (start==NULL) {
+		dev_err(&pdev->dev, "ioremap for registers failed\n");
+		result = -ENOMEM;
+		goto fail_map1;
+	}
+	i2c->regs = start;
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	if (!i2c->irq) {
+		dev_err(&pdev->dev, "i2c irq resource not found\n");
+		result = -EINVAL;
+		goto fail_irq;
+	}
+
+	if ((result = request_irq(i2c->irq, cpm2_i2c_isr,
+				  IRQF_SHARED, "i2c-cpm2", i2c)) < 0 ) {
+		dev_err(&pdev->dev, "failed to attach interrupt\n");
+		goto fail_irq;
+	}
+
+	/* Allocate I2C parameter table and set base pointer */
+	i2c->base = (u16 *)cpm2_map_size(im_dprambase[PROFF_I2C_BASE], 2);
+	i2c->dp_offset = cpm_dpalloc(sizeof(iic_t), 64);
+	i2c->dp_addr = (iic_t *)cpm_dpram_addr(i2c->dp_offset);
+	*(i2c->base) = i2c->dp_offset;
+	
+	i2c->rbdf_offset = cpm_dpalloc(sizeof(cbd_t) * 2, 8);
+	i2c->tbdf_offset = cpm_dpalloc(sizeof(cbd_t) * 2, 8);
+	i2c->rbdf_addr = (cbd_t *)cpm_dpram_addr(i2c->rbdf_offset);
+	i2c->tbdf_addr = (cbd_t *)cpm_dpram_addr(i2c->tbdf_offset);
+
+	dev_dbg(&pdev->dev, "%s: dp_offset=%x rbdf_offset=%x tbdf_offset=%x\n",
+		__FUNCTION__,
+		i2c->dp_offset, i2c->rbdf_offset, i2c->tbdf_offset);
+
+	cpm2_pram_init(i2c);
+	cpm2_pin_init(i2c);
+
+	/* Initialize Tx/Rx parameters. */
+	{
+		volatile cpm_cpm2_t *cp = cpmp;
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_I2C_PAGE,
+				  CPM_CR_I2C_SBLOCK,
+				  0x00, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+		while (cp->cp_cpcr & CPM_CR_FLG);
+	}
+
+	/* Select an arbitrary address.  Just make sure it is unique. */
+	out_8(&i2c->regs->i2c_i2add, 0x34);
+	/* Pre-divider is BRGCLK/4 and enable clock filter */
+	out_8(&i2c->regs->i2c_i2mod, 0x0e);
+	/* Divider is 2 * ( 34 + 3 + 2 ) */
+	out_8(&i2c->regs->i2c_i2brg, 34);
+	/* Disable interrupts */
+	out_8(&i2c->regs->i2c_i2cmr, 0x12);
+	/* Acknowledge old interrupts */
+	out_8(&i2c->regs->i2c_i2cer, 0xff);
+
+	init_waitqueue_head(&i2c->queue);
+
+	i2c->state = I2C_IDLE;
+
+	platform_set_drvdata(pdev, i2c);
+	i2c->adap = cpm2_ops;
+	i2c_set_adapdata(&i2c->adap, i2c);
+	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.nr = pdev->id;
+	spin_lock_init(&i2c->lock);
+
+	result = i2c_add_numbered_adapter(&i2c->adap);
+	if (result < 0) {
+		dev_err(&pdev->dev, "failed to add adapter\n");
+		goto fail_add;
+	}
+
+	return result;
+
+fail_add:
+	free_irq(i2c->irq, NULL);
+	cpm_dpfree(i2c->rbdf_offset);
+	cpm_dpfree(i2c->tbdf_offset);
+	cpm_dpfree(i2c->dp_offset);
+	cpm2_unmap(i2c->base);
+fail_irq:
+	iounmap(i2c->regs);
+fail_map1:
+	kfree(i2c);
+	return result;
+};
+
+
+static void
+cpm2_i2c_shutdown(struct cpm2_i2c *i2c)
+{
+	/* Shut down I2C controller */
+	out_8(&i2c->regs->i2c_i2mod, 0);
+	out_8(&i2c->regs->i2c_i2cmr, 0);
+	out_8(&i2c->regs->i2c_i2cer, 0xff);
+}
+
+
+static int cpm2_i2c_remove(struct platform_device *pdev)
+{
+	struct cpm2_i2c *i2c = platform_get_drvdata(pdev);
+
+	cpm2_i2c_shutdown(i2c);
+
+	i2c_del_adapter(&i2c->adap);
+	platform_set_drvdata(pdev, NULL);
+
+	free_irq(i2c->irq, i2c);
+
+	cpm_dpfree(i2c->rbdf_offset);
+	cpm_dpfree(i2c->tbdf_offset);
+	cpm_dpfree(i2c->dp_offset);
+	cpm2_unmap(i2c->base);
+
+	iounmap(i2c->regs);
+	kfree(i2c);
+
+	return 0;
+};
+
+/* Structure for a device driver */
+static struct platform_driver cpm2_i2c_driver = {
+	.probe	= cpm2_i2c_probe,
+	.remove	= cpm2_i2c_remove,
+	.driver	= {
+		.owner = THIS_MODULE,
+		.name = "fsl-cpm2-i2c",
+	},
+};
+
+static int __init cpm2_i2c_init(void)
+{
+	return platform_driver_register(&cpm2_i2c_driver);
+}
+
+static void __exit cpm2_i2c_exit(void)
+{
+	platform_driver_unregister(&cpm2_i2c_driver);
+}
+
+module_init(cpm2_i2c_init);
+module_exit(cpm2_i2c_exit);
+
+MODULE_AUTHOR("Esben Haabendal <eha@doredevelopment.dk>");
+MODULE_DESCRIPTION("I2C-Bus adapter for MPC processors with CPM2");
+MODULE_LICENSE("GPL");
diff --git a/include/asm-powerpc/cpm.h b/include/asm-powerpc/cpm.h
index ede38ff..1f92c36 100644
--- a/include/asm-powerpc/cpm.h
+++ b/include/asm-powerpc/cpm.h
@@ -89,7 +89,18 @@ typedef struct cpm_buf_desc {

 /* Buffer descriptor control/status used by I2C.
  */
-#define BD_I2C_START		(0x0400)
+#define BD_I2C_EMPTY	(0x8000)	/* Receive buffer is empty */
+#define BD_I2C_READY	(0x8000)	/* Transmit buffer is ready */
+#define BD_I2C_WRAP	(0x2000)	/* Last buffer descriptor */
+#define BD_I2C_INTRPT	(0x1000)	/* Interrupt on event */
+#define BD_I2C_LAST	(0x0800)	/* Last buffer in frame */
+#define BD_I2C_START	(0x0400)	/* Generate start condition */
+#define BD_I2C_NAK	(0x0004)	/* No acknowledge */
+#define BD_I2C_OV	(0x0002)	/* Overrun */
+#define BD_I2C_UN	(0x0002)	/* Underrun */
+#define BD_I2C_CL	(0x0001)	/* Collision */
+
+

 int cpm_muram_init(void);
 unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 580acc9..9844953 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -133,6 +133,9 @@
 /* --- PowerPC on-chip adapters						*/
 #define I2C_HW_OCP		0x120000 /* IBM on-chip I2C adapter */

+/* --- MPC82xx PowerPC adapters						*/
+#define I2C_HW_CPM2		0x100002 /* MPC CPM2 I2C adapter */
+
 /* --- Broadcom SiByte adapters						*/
 #define I2C_HW_SIBYTE		0x150000

.

-- 
Esben Haabendal, Senior Software Consultant
DoréDevelopment ApS, Ved Stranden 1, 9560 Hadsund, DK-Denmark
Tlf: +45 51 92 53 93, mail: eha@doredevelopment.dk
WWW: http://www.doredevelopment.dk
