Return-Path: <SRS0=24Qs=OM=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 4C4C2DDE0A
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 21:52:53 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: i2c@lm-sensors.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH] i2c: devtree-aware iic support for PPC4xx
Date: Sun, 16 Sep 2007 13:52:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709161352.03459.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch reworks existing ibm-iic driver to an of_platform_device
and enables it to talk to device tree directly. The ocp quirks are
completely removed by this patch.

This is done to enable I2C support for the PPC4xx platforms now
being moved from arch/ppc (OCP) to arch/powerpc (of). The first board
using this driver will be the AMCC Sequoia (PPC440EPx).

Signed-off-by: Stefan Roese <sr@denx.de>

=2D--
2nd try with some cleanups. Please let me know if there still are some
problems.

Thanks.

commit 5748f81ff53277fa5c16de815b7d6b172ca284e9
tree 8284b3f1c836eb6eb06ee6882ee13b9e8f6cbb6b
parent d0174640eedc1cd756754f03afe2dbb3d56de74e
author Stefan Roese <sr@denx.de> Sun, 16 Sep 2007 13:46:40 +0200
committer Stefan Roese <sr@denx.de> Sun, 16 Sep 2007 13:46:40 +0200

 drivers/i2c/busses/Kconfig       |   12 -
 drivers/i2c/busses/Makefile      |    1=20
 drivers/i2c/busses/i2c-ibm_iic.h |    3=20
 drivers/i2c/busses/i2c-ibm_of.c  |  858 ++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 873 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 9f3a4cd..12453e2 100644
=2D-- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -220,7 +220,17 @@ config I2C_PIIX4
=20
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
=2D	depends on IBM_OCP
+	depends on !PPC_MERGE
+	help
+	  Say Y here if you want to use IIC peripheral found on=20
+	  embedded IBM PPC 4xx based systems.=20
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ibm_iic.
+
+config I2C_IBM_OF
+	tristate "IBM PPC 4xx on-chip I2C interface"
+	depends on PPC_MERGE
 	help
 	  Say Y here if you want to use IIC peripheral found on=20
 	  embedded IBM PPC 4xx based systems.=20
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 5b752e4..0cd0bac 100644
=2D-- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_I2C_HYDRA)		+=3D i2c-hydra.o
 obj-$(CONFIG_I2C_I801)		+=3D i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+=3D i2c-i810.o
 obj-$(CONFIG_I2C_IBM_IIC)	+=3D i2c-ibm_iic.o
+obj-$(CONFIG_I2C_IBM_OF)	+=3D i2c-ibm_of.o
 obj-$(CONFIG_I2C_IOP3XX)	+=3D i2c-iop3xx.o
 obj-$(CONFIG_I2C_IXP2000)	+=3D i2c-ixp2000.o
 obj-$(CONFIG_I2C_IXP4XX)	+=3D i2c-ixp4xx.o
diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_=
iic.h
index 59d7b43..485c72c 100644
=2D-- a/drivers/i2c/busses/i2c-ibm_iic.h
+++ b/drivers/i2c/busses/i2c-ibm_iic.h
@@ -23,6 +23,7 @@
 #define __I2C_IBM_IIC_H_
=20
 #include <linux/i2c.h>=20
+#include <linux/of.h>
=20
 struct iic_regs {
 	u16 mdbuf;
@@ -50,6 +51,8 @@ struct ibm_iic_private {
 	int irq;
 	int fast_mode;
 	u8  clckdiv;
+	struct device_node *np;
+	phys_addr_t paddr;
 };
=20
 /* IICx_CNTL register */
diff --git a/drivers/i2c/busses/i2c-ibm_of.c b/drivers/i2c/busses/i2c-ibm_o=
f.c
new file mode 100644
index 0000000..5e5b3e5
=2D-- /dev/null
+++ b/drivers/i2c/busses/i2c-ibm_of.c
@@ -0,0 +1,858 @@
+/*
+ * drivers/i2c/busses/i2c-ibm_of.c
+ *
+ * Support for the IIC peripheral on IBM PPC 4xx
+ *
+ * Copyright (c) 2003, 2004 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by
+ * 	Ian DaSilva  <idasilva@mvista.com>
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Matt Porter  <mporter@mvista.com>
+ *
+ *      Copyright 2000-2003 MontaVista Software Inc.
+ *
+ * Original driver version was highly leveraged from i2c-elektor.c
+ *
+ *   	Copyright 1995-97 Simon G. Vogl
+ *                1998-99 Hans Berglund
+ *
+ *   	With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>
+ *	and even Frodo Looijaard <frodol@dds.nl>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+
+#include <linux/of_platform.h>
+
+#include "i2c-ibm_iic.h"
+
+#define DRIVER_VERSION "2.1"
+
+MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
+MODULE_LICENSE("GPL");
+
+static int device_idx =3D -1;
+
+static int iic_force_poll;
+module_param(iic_force_poll, bool, 0);
+MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
+
+static int iic_force_fast;
+module_param(iic_force_fast, bool, 0);
+MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
+
+#define DBG_LEVEL 0
+
+#ifdef DBG
+#undef DBG
+#endif
+
+#ifdef DBG2
+#undef DBG2
+#endif
+
+#if DBG_LEVEL > 0
+#  define DBG(f,x...)	printk(KERN_DEBUG "ibm-iic" f, ##x)
+#else
+#  define DBG(f,x...)	((void)0)
+#endif
+#if DBG_LEVEL > 1
+#  define DBG2(f,x...) 	DBG(f, ##x)
+#else
+#  define DBG2(f,x...) 	((void)0)
+#endif
+#if DBG_LEVEL > 2
+static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+	printk(KERN_DEBUG "ibm-iic(%s): %s\n", dev->np->full_name, header);
+	printk(KERN_DEBUG "  cntl     =3D 0x%02x, mdcntl =3D 0x%02x\n"
+	       KERN_DEBUG "  sts      =3D 0x%02x, extsts =3D 0x%02x\n"
+	       KERN_DEBUG "  clkdiv   =3D 0x%02x, xfrcnt =3D 0x%02x\n"
+	       KERN_DEBUG "  xtcntlss =3D 0x%02x, directcntl =3D 0x%02x\n",
+		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts),
+		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt),
+		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
+}
+#  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
+#else
+#  define DUMP_REGS(h,dev)	((void)0)
+#endif
+
+/* Bus timings (in ns) for bit-banging */
+static struct i2c_timings {
+	unsigned int hd_sta;
+	unsigned int su_sto;
+	unsigned int low;
+	unsigned int high;
+	unsigned int buf;
+} timings [] =3D {
+/* Standard mode (100 KHz) */
+{
+	.hd_sta	=3D 4000,
+	.su_sto	=3D 4000,
+	.low	=3D 4700,
+	.high	=3D 4000,
+	.buf	=3D 4700,
+},
+/* Fast mode (400 KHz) */
+{
+	.hd_sta =3D 600,
+	.su_sto	=3D 600,
+	.low 	=3D 1300,
+	.high 	=3D 600,
+	.buf	=3D 1300,
+}};
+
+/* Enable/disable interrupt generation */
+static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int ena=
ble)
+{
+	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
+}
+
+/*
+ * Initialize IIC interface.
+ */
+static void iic_dev_init(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+
+	DBG("%s: init\n", dev->np->full_name);
+
+	/* Clear master address */
+	out_8(&iic->lmadr, 0);
+	out_8(&iic->hmadr, 0);
+
+	/* Clear slave address */
+	out_8(&iic->lsadr, 0);
+	out_8(&iic->hsadr, 0);
+
+	/* Clear status & extended status */
+	out_8(&iic->sts, STS_SCMP | STS_IRQA);
+	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA
+			    | EXTSTS_ICT | EXTSTS_XFRA);
+
+	/* Set clock divider */
+	out_8(&iic->clkdiv, dev->clckdiv);
+
+	/* Clear transfer count */
+	out_8(&iic->xfrcnt, 0);
+
+	/* Clear extended control and status */
+	out_8(&iic->xtcntlss, XTCNTLSS_SRC | XTCNTLSS_SRS | XTCNTLSS_SWC
+			    | XTCNTLSS_SWS);
+
+	/* Clear control register */
+	out_8(&iic->cntl, 0);
+
+	/* Enable interrupts if possible */
+	iic_interrupt_mode(dev, dev->irq >=3D 0);
+
+	/* Set mode control */
+	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
+			    | (dev->fast_mode ? MDCNTL_FSM : 0));
+
+	DUMP_REGS("iic_init", dev);
+}
+
+/*
+ * Reset IIC interface
+ */
+static void iic_dev_reset(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+	int i;
+	u8 dc;
+
+	DBG("%s: soft reset\n", dev->np->full_name);
+	DUMP_REGS("reset", dev);
+
+    	/* Place chip in the reset state */
+	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
+
+	/* Check if bus is free */
+	dc =3D in_8(&iic->directcntl);
+	if (!DIRCTNL_FREE(dc)) {
+		DBG("%s: trying to regain bus control\n", dev->np->full_name);
+
+		/* Try to set bus free state */
+		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+
+		/* Wait until we regain bus control */
+		for (i =3D 0; i < 100; ++i) {
+			dc =3D in_8(&iic->directcntl);
+			if (DIRCTNL_FREE(dc))
+				break;
+
+			/* Toggle SCL line */
+			dc ^=3D DIRCNTL_SCC;
+			out_8(&iic->directcntl, dc);
+			udelay(10);
+			dc ^=3D DIRCNTL_SCC;
+			out_8(&iic->directcntl, dc);
+
+			/* be nice */
+			cond_resched();
+		}
+	}
+
+	/* Remove reset */
+	out_8(&iic->xtcntlss, 0);
+
+	/* Reinitialize interface */
+	iic_dev_init(dev);
+}
+
+/*
+ * Do 0-length transaction using bit-banging through IIC_DIRECTCNTL regist=
er.
+ */
+
+/* Wait for SCL and/or SDA to be high */
+static int iic_dc_wait(volatile struct iic_regs __iomem *iic, u8 mask)
+{
+	unsigned long x =3D jiffies + HZ / 28 + 2;
+	while ((in_8(&iic->directcntl) & mask) !=3D mask) {
+		if (unlikely(time_after(jiffies, x)))
+			return -1;
+		cond_resched();
+	}
+	return 0;
+}
+
+static int iic_smbus_quick(struct ibm_iic_private* dev, const struct i2c_m=
sg* p)
+{
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+	const struct i2c_timings* t =3D &timings[dev->fast_mode ? 1 : 0];
+	u8 mask, v, sda;
+	int i, res;
+
+	/* Only 7-bit addresses are supported */
+	if (unlikely(p->flags & I2C_M_TEN)) {
+		DBG("%s: smbus_quick - 10 bit addresses are not supported\n",
+			dev->np->full_name);
+		return -EINVAL;
+	}
+
+	DBG("%s: smbus_quick(0x%02x)\n", dev->np->full_name, p->addr);
+
+	/* Reset IIC interface */
+	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
+
+	/* Wait for bus to become free */
+	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSDA | DIRCNTL_MSC)))
+		goto err;
+	ndelay(t->buf);
+
+	/* START */
+	out_8(&iic->directcntl, DIRCNTL_SCC);
+	sda =3D 0;
+	ndelay(t->hd_sta);
+
+	/* Send address */
+	v =3D (u8)((p->addr << 1) | ((p->flags & I2C_M_RD) ? 1 : 0));
+	for (i =3D 0, mask =3D 0x80; i < 8; ++i, mask >>=3D 1) {
+		out_8(&iic->directcntl, sda);
+		ndelay(t->low / 2);
+		sda =3D (v & mask) ? DIRCNTL_SDAC : 0;
+		out_8(&iic->directcntl, sda);
+		ndelay(t->low / 2);
+
+		out_8(&iic->directcntl, DIRCNTL_SCC | sda);
+		if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
+			goto err;
+		ndelay(t->high);
+	}
+
+	/* ACK */
+	out_8(&iic->directcntl, sda);
+	ndelay(t->low / 2);
+	out_8(&iic->directcntl, DIRCNTL_SDAC);
+	ndelay(t->low / 2);
+	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
+		goto err;
+	res =3D (in_8(&iic->directcntl) & DIRCNTL_MSDA) ? -EREMOTEIO : 1;
+	ndelay(t->high);
+
+	/* STOP */
+	out_8(&iic->directcntl, 0);
+	ndelay(t->low);
+	out_8(&iic->directcntl, DIRCNTL_SCC);
+	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
+		goto err;
+	ndelay(t->su_sto);
+	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+
+	ndelay(t->buf);
+
+	DBG("%s: smbus_quick -> %s\n",
+			dev->np->full_name, res ? "NACK" : "ACK");
+out:
+	/* Remove reset */
+	out_8(&iic->xtcntlss, 0);
+
+	/* Reinitialize interface */
+	iic_dev_init(dev);
+
+	return res;
+err:
+	DBG("%s: smbus_quick - bus is stuck\n", dev->np->full_name);
+	res =3D -EREMOTEIO;
+	goto out;
+}
+
+/*
+ * IIC interrupt handler
+ */
+static irqreturn_t iic_handler(int irq, void *dev_id)
+{
+	struct ibm_iic_private* dev =3D dev_id;
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+
+	DBG2("%s: irq handler, STS =3D 0x%02x, EXTSTS =3D 0x%02x\n",
+	     dev->np->full_name, in_8(&iic->sts), in_8(&iic->extsts));
+
+	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
+	out_8(&iic->sts, STS_IRQA | STS_SCMP);
+	wake_up_interruptible(&dev->wq);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Get master transfer result and clear errors if any.
+ * Returns the number of actually transferred bytes or error (<0)
+ */
+static int iic_xfer_result(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+
+	if (unlikely(in_8(&iic->sts) & STS_ERR)) {
+		DBG("%s: xfer error, EXTSTS =3D 0x%02x\n", dev->np->full_name,
+			in_8(&iic->extsts));
+
+		/* Clear errors and possible pending IRQs */
+		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD |
+			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
+
+		/* Flush master data buffer */
+		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+
+		/* Is bus free?
+		 * If error happened during combined xfer
+		 * IIC interface is usually stuck in some strange
+		 * state, the only way out - soft reset.
+		 */
+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE) {
+			DBG("%s: bus is stuck, resetting\n",
+					dev->np->full_name);
+			iic_dev_reset(dev);
+		}
+		return -EREMOTEIO;
+	} else
+		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
+}
+
+/*
+ * Try to abort active transfer.
+ */
+static void iic_abort_xfer(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+	unsigned long x;
+
+	DBG("%s: iic_abost_xfer\n", dev->np->full_name);
+
+	out_8(&iic->cntl, CNTL_HMT);
+
+	/*
+	 * Wait for the abort command to complete.
+	 * It's not worth to be optimized, just poll (timeout >=3D 1 tick)
+	 */
+	x =3D jiffies + 2;
+	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE) {
+		if (time_after(jiffies, x)) {
+			DBG("%s: abort timeout, resetting...\n",
+					dev->np->full_name);
+			iic_dev_reset(dev);
+			return;
+		}
+		schedule();
+	}
+
+	/* Just to clear errors */
+	iic_xfer_result(dev);
+}
+
+/*
+ * Wait for master transfer to complete.
+ * It puts current process to sleep until we get interrupt or timeout expi=
res.
+ * Returns the number of transferred bytes or error (<0)
+ */
+static int iic_wait_for_tc(struct ibm_iic_private* dev) {
+
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+	int ret =3D 0;
+
+	if (dev->irq >=3D 0) {
+		/* Interrupt mode */
+		ret =3D wait_event_interruptible_timeout(dev->wq,
+			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout * HZ);
+
+		if (unlikely(ret < 0))
+			DBG("%s: wait interrupted\n", dev->np->full_name);
+		else if (unlikely(in_8(&iic->sts) & STS_PT)) {
+			DBG("%s: wait timeout\n", dev->np->full_name);
+			ret =3D -ETIMEDOUT;
+		}
+	} else {
+		/* Polling mode */
+		unsigned long x =3D jiffies + dev->adap.timeout * HZ;
+
+		while (in_8(&iic->sts) & STS_PT) {
+			if (unlikely(time_after(jiffies, x))) {
+				DBG("%s: poll timeout\n", dev->np->full_name);
+				ret =3D -ETIMEDOUT;
+				break;
+			}
+
+			if (unlikely(signal_pending(current))) {
+				DBG("%s: poll interrupted\n",
+						dev->np->full_name);
+				ret =3D -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+	}
+
+	if (unlikely(ret < 0))
+		iic_abort_xfer(dev);
+	else
+		ret =3D iic_xfer_result(dev);
+
+	DBG2("%s: iic_wait_for_tc -> %d\n", dev->np->full_name, ret);
+
+	return ret;
+}
+
+/*
+ * Low level master transfer routine
+ */
+static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
+			  int combined_xfer)
+{
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+	char* buf =3D pm->buf;
+	int i, j, loops, ret =3D 0;
+	int len =3D pm->len;
+
+	u8 cntl =3D (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
+	if (pm->flags & I2C_M_RD)
+		cntl |=3D CNTL_RW;
+
+	loops =3D (len + 3) / 4;
+	for (i =3D 0; i < loops; ++i, len -=3D 4) {
+		int count =3D len > 4 ? 4 : len;
+		u8 cmd =3D cntl | ((count - 1) << CNTL_TCT_SHIFT);
+
+		if (!(cntl & CNTL_RW))
+			for (j =3D 0; j < count; ++j)
+				out_8((void __iomem *)&iic->mdbuf, *buf++);
+
+		if (i < loops - 1)
+			cmd |=3D CNTL_CHT;
+		else if (combined_xfer)
+			cmd |=3D CNTL_RPST;
+
+		DBG2("%s: xfer_bytes, %d, CNTL =3D 0x%02x\n",
+				dev->np->full_name, count, cmd);
+
+		/* Start transfer */
+		out_8(&iic->cntl, cmd);
+
+		/* Wait for completion */
+		ret =3D iic_wait_for_tc(dev);
+
+		if (unlikely(ret < 0))
+			break;
+		else if (unlikely(ret !=3D count)) {
+			DBG("%s: xfer_bytes, requested %d, transfered %d\n",
+				dev->np->full_name, count, ret);
+
+			/* If it's not a last part of xfer, abort it */
+			if (combined_xfer || (i < loops - 1))
+    				iic_abort_xfer(dev);
+
+			ret =3D -EREMOTEIO;
+			break;
+		}
+
+		if (cntl & CNTL_RW)
+			for (j =3D 0; j < count; ++j)
+				*buf++ =3D in_8((void __iomem *)&iic->mdbuf);
+	}
+
+	return ret > 0 ? 0 : ret;
+}
+
+/*
+ * Set target slave address for master transfer
+ */
+static inline void iic_address(struct ibm_iic_private* dev, struct i2c_msg=
* msg)
+{
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+	u16 addr =3D msg->addr;
+
+	DBG2("%s: iic_address, 0x%03x (%d-bit)\n", dev->np->full_name,
+		addr, msg->flags & I2C_M_TEN ? 10 : 7);
+
+	if (msg->flags & I2C_M_TEN) {
+	    out_8(&iic->cntl, CNTL_AMD);
+	    out_8(&iic->lmadr, addr);
+	    out_8(&iic->hmadr, 0xf0 | ((addr >> 7) & 0x06));
+	} else {
+	    out_8(&iic->cntl, 0);
+	    out_8(&iic->lmadr, addr << 1);
+	}
+}
+
+static inline int iic_invalid_address(const struct i2c_msg* p)
+{
+	return (p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN) && (p->addr > 0x7f));
+}
+
+static inline int iic_address_neq(const struct i2c_msg* p1,
+				  const struct i2c_msg* p2)
+{
+	return (p1->addr !=3D p2->addr)
+		|| ((p1->flags & I2C_M_TEN) !=3D (p2->flags & I2C_M_TEN));
+}
+
+/*
+ * Generic master transfer entrypoint.
+ * Returns the number of processed messages or error (<0)
+ */
+static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int nu=
m)
+{
+    	struct ibm_iic_private* dev =3D i2c_get_adapdata(adap);
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+	int i, ret =3D 0;
+
+	DBG2("%s: iic_xfer, %d msg(s)\n", dev->np->full_name, num);
+
+	if (!num)
+		return 0;
+
+	/* Check the sanity of the passed messages.
+	 * Uhh, generic i2c layer is more suitable place for such code...
+	 */
+	if (unlikely(iic_invalid_address(&msgs[0]))) {
+		DBG("%s: invalid address 0x%03x (%d-bit)\n", dev->np->full_name,
+			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
+		return -EINVAL;
+	}
+	for (i =3D 0; i < num; ++i) {
+		if (unlikely(msgs[i].len <=3D 0)) {
+			if (num =3D=3D 1 && !msgs[0].len) {
+				/* Special case for I2C_SMBUS_QUICK emulation.
+				 * IBM IIC doesn't support 0-length transactions
+				 * so we have to emulate them using bit-banging.
+				 */
+				return iic_smbus_quick(dev, &msgs[0]);
+			}
+			DBG("%s: invalid len %d in msg[%d]\n",
+					dev->np->full_name,
+				msgs[i].len, i);
+			return -EINVAL;
+		}
+		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))) {
+			DBG("%s: invalid addr in msg[%d]\n",
+					dev->np->full_name, i);
+			return -EINVAL;
+		}
+	}
+
+	/* Check bus state */
+	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK)
+				!=3D EXTSTS_BCS_FREE)) {
+		DBG("%s: iic_xfer, bus is not free\n", dev->np->full_name);
+
+		/* Usually it means something serious has happend.
+		 * We *cannot* have unfinished previous transfer
+		 * so it doesn't make any sense to try to stop it.
+		 * Probably we were not able to recover from the
+		 * previous error.
+		 * The only *reasonable* thing I can think of here
+		 * is soft reset.  --ebs
+		 */
+		iic_dev_reset(dev);
+
+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE) {
+			DBG("%s: iic_xfer, bus is still not free\n",
+					dev->np->full_name);
+			return -EREMOTEIO;
+		}
+	} else {
+		/* Flush master data buffer (just in case) */
+		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+	}
+
+	/* Load slave address */
+	iic_address(dev, &msgs[0]);
+
+	/* Do real transfer */
+    	for (i =3D 0; i < num && !ret; ++i)
+		ret =3D iic_xfer_bytes(dev, &msgs[i], i < num - 1);
+
+	return ret < 0 ? ret : num;
+}
+
+static u32 iic_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
+}
+
+static const struct i2c_algorithm iic_algo =3D {
+	.master_xfer 	=3D iic_xfer,
+	.functionality	=3D iic_func
+};
+
+/*
+ * Calculates IICx_CLCKDIV value for a specific OPB clock frequency
+ */
+static inline u8 iic_clckdiv(unsigned int opb)
+{
+	/* Compatibility kludge, should go away after all cards
+	 * are fixed to fill correct value for opbfreq.
+	 * Previous driver version used hardcoded divider value 4,
+	 * it corresponds to OPB frequency from the range (40, 50] MHz
+	 */
+	if (!opb) {
+		printk(KERN_WARNING
+			"ibm-iic: using compatibility value for OPB freq,"
+			" fix your board specific setup\n");
+		opb =3D 50000000;
+	}
+
+	/* Convert to MHz */
+	opb /=3D 1000000;
+
+	if (opb < 20 || opb > 150) {
+		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
+			opb);
+		opb =3D opb < 20 ? 20 : 150;
+	}
+	return (u8)((opb + 9) / 10 - 1);
+}
+
+/*
+ * Register single IIC interface
+ */
+static int __devinit iic_probe (struct of_device *ofdev,
+				const struct of_device_id *match)
+{
+	struct ibm_iic_private* dev;
+	struct i2c_adapter* adap;
+	struct device_node *np;
+	int ret =3D -ENODEV;
+	int  irq, len;
+	const u32 *prop;
+	struct resource res;
+
+	np =3D ofdev->node;
+	if (!(dev =3D kzalloc(sizeof(*dev), GFP_KERNEL))) {
+		printk(KERN_CRIT "ibm-iic(%s): failed to allocate device data\n",
+				np->full_name);
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	dev->np =3D np;
+	irq =3D irq_of_parse_and_map(np, 0);
+
+	if (of_address_to_resource(np, 0, &res)) {
+		printk(KERN_ERR "ibd-iic(%s): Can't get registers address\n",
+				np->full_name);
+		goto fail1;
+	}
+	dev->paddr =3D res.start;
+
+	if (!request_mem_region(dev->paddr, sizeof(struct iic_regs),
+				"ibm_iic")) {
+		ret =3D -EBUSY;
+		goto fail1;
+	}
+	dev->vaddr =3D ioremap(dev->paddr, sizeof(struct iic_regs));
+
+	if (dev->vaddr =3D=3D NULL) {
+		printk(KERN_CRIT "ibm-iic(%s): failed to ioremap device regs\n",
+				dev->np->full_name);
+		ret =3D -ENXIO;
+		goto fail2;
+	}
+
+	init_waitqueue_head(&dev->wq);
+
+	dev->irq =3D iic_force_poll ? -1 : (irq =3D=3D NO_IRQ) ? -1 : irq;
+	if (dev->irq >=3D 0) {
+		/* Disable interrupts until we finish initialization,
+		   assumes level-sensitive IRQ setup...
+		 */
+		iic_interrupt_mode(dev, 0);
+		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)) {
+			printk(KERN_ERR "ibm-iic(%s): request_irq %d failed\n",
+					dev->np->full_name, dev->irq);
+			/* Fallback to the polling mode */
+			dev->irq =3D -1;
+		}
+	}
+
+	if (dev->irq < 0)
+		printk(KERN_WARNING "ibm-iic(%s): using polling mode\n",
+				dev->np->full_name);
+
+	/* Board specific settings */
+	prop =3D of_get_property(np, "iic-mode", &len);
+	/* use 400kHz only if stated in dts, 100kHz otherwise */
+	dev->fast_mode =3D (prop && (*prop =3D=3D 400));
+	/* clckdiv is the same for *all* IIC interfaces,
+	 * but I'd rather make a copy than introduce another global. --ebs
+	 */
+	/* Parent bus should have frequency filled */
+	prop =3D of_get_property(of_get_parent(np), "clock-frequency", &len);
+	if (prop =3D=3D NULL) {
+		printk(KERN_ERR
+			"ibm-iic(%s):no clock-frequency prop on parent bus!\n",
+			dev->np->full_name);
+		goto fail;
+	}
+
+	dev->clckdiv =3D iic_clckdiv(*prop);
+	DBG("%s: clckdiv =3D %d\n", dev->np->full_name, dev->clckdiv);
+
+	/* Initialize IIC interface */
+	iic_dev_init(dev);
+
+	/* Register it with i2c layer */
+	adap =3D &dev->adap;
+	adap->dev.parent =3D &ofdev->dev;
+	strcpy(adap->name, "IBM IIC");
+	i2c_set_adapdata(adap, dev);
+	adap->id =3D I2C_HW_OCP;
+	adap->class =3D I2C_CLASS_HWMON;
+	adap->algo =3D &iic_algo;
+	adap->client_register =3D NULL;
+	adap->client_unregister =3D NULL;
+	adap->timeout =3D 1;
+	adap->retries =3D 1;
+
+	adap->nr =3D ++device_idx;
+	if ((ret =3D i2c_add_numbered_adapter(adap)) < 0) {
+		printk(KERN_CRIT "ibm-iic(%s): failed to register i2c adapter\n",
+				dev->np->full_name);
+		goto fail;
+	}
+
+	printk(KERN_INFO "ibm-iic(%s): using %s mode\n", dev->np->full_name,
+			dev->fast_mode ?
+			"fast (400 kHz)" : "standard (100 kHz)");
+
+	return 0;
+
+fail:
+	if (dev->irq >=3D 0) {
+		iic_interrupt_mode(dev, 0);
+		free_irq(dev->irq, dev);
+	}
+
+	iounmap(dev->vaddr);
+fail2:
+	release_mem_region(dev->paddr, sizeof(struct iic_regs));
+fail1:
+	dev_set_drvdata(&ofdev->dev, NULL);
+	kfree(dev);
+
+	return ret;
+}
+
+/*
+ * Cleanup initialized IIC interface
+ */
+static int __devexit iic_remove(struct of_device *ofdev)
+{
+	struct ibm_iic_private *dev =3D dev_get_drvdata(&ofdev->dev);
+
+	BUG_ON(dev =3D=3D NULL);
+	if (i2c_del_adapter(&dev->adap)) {
+		printk(KERN_CRIT "ibm-iic(%s): failed to delete i2c adapter\n",
+		       dev->np->full_name);
+		/* That's *very* bad, just shutdown IRQ ... */
+		if (dev->irq >=3D 0) {
+			iic_interrupt_mode(dev, 0);
+			free_irq(dev->irq, dev);
+			dev->irq =3D -1;
+		}
+	} else {
+		if (dev->irq >=3D 0) {
+			iic_interrupt_mode(dev, 0);
+			free_irq(dev->irq, dev);
+		}
+		iounmap(dev->vaddr);
+		release_mem_region(dev->paddr, sizeof(struct iic_regs));
+		kfree(dev);
+	}
+
+	return 0;
+}
+
+static struct of_device_id ibm_iic_match[] =3D {
+	{
+		.type =3D "i2c",
+		.compatible =3D "ibm,iic",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ibm_iic_match);
+
+static struct of_platform_driver ibm_iic_driver =3D {
+	.name =3D "ibm-iic",
+	.match_table =3D ibm_iic_match,
+	.probe =3D iic_probe,
+	.remove =3D iic_remove,
+};
+
+static int __init iic_init(void)
+{
+	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
+	return of_register_platform_driver(&ibm_iic_driver);
+}
+
+static void __exit iic_exit(void)
+{
+	of_unregister_platform_driver(&ibm_iic_driver);
+}
+
+module_init(iic_init);
+module_exit(iic_exit);
