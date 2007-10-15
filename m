Return-Path: <SRS0=UFNa=PJ=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 9842BDDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 23:28:39 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: i2c@lm-sensors.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] i2c: ibm_iic: Whitespace cleanup
Date: Mon, 15 Oct 2007 15:28:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710151528.55261.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
=2D--
 drivers/i2c/busses/i2c-ibm_iic.c |  192 +++++++++++++++++++---------------=
=2D---
 drivers/i2c/busses/i2c-ibm_iic.h |    8 +-
 2 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_=
iic.c
index e08baca..956b947 100644
=2D-- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2003, 2004 Zultys Technologies.
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
=2D * Based on original work by=20
+ * Based on original work by
  * 	Ian DaSilva  <idasilva@mvista.com>
  *      Armin Kuster <akuster@mvista.com>
  * 	Matt Porter  <mporter@mvista.com>
@@ -18,7 +18,7 @@
  *   	Copyright 1995-97 Simon G. Vogl
  *                1998-99 Hans Berglund
  *
=2D *   	With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>=20
+ *   	With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>
  *	and even Frodo Looijaard <frodol@dds.nl>
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -86,8 +86,8 @@ static void dump_iic_regs(const char* header, struct ibm_=
iic_private* dev)
 	       KERN_DEBUG "  sts      =3D 0x%02x, extsts =3D 0x%02x\n"
 	       KERN_DEBUG "  clkdiv   =3D 0x%02x, xfrcnt =3D 0x%02x\n"
 	       KERN_DEBUG "  xtcntlss =3D 0x%02x, directcntl =3D 0x%02x\n",
=2D		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts),=20
=2D		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt),=20
+		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts),
+		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt),
 		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
 }
 #  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
@@ -125,7 +125,7 @@ static inline void iic_interrupt_mode(struct ibm_iic_pr=
ivate* dev, int enable)
 {
 	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
 }
=2D=20
+
 /*
  * Initialize IIC interface.
  */
@@ -134,7 +134,7 @@ static void iic_dev_init(struct ibm_iic_private* dev)
 	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
=20
 	DBG("%d: init\n", dev->idx);
=2D=09
+
 	/* Clear master address */
 	out_8(&iic->lmadr, 0);
 	out_8(&iic->hmadr, 0);
@@ -160,7 +160,7 @@ static void iic_dev_init(struct ibm_iic_private* dev)
=20
 	/* Clear control register */
 	out_8(&iic->cntl, 0);
=2D=09
+
 	/* Enable interrupts if possible */
 	iic_interrupt_mode(dev, dev->irq >=3D 0);
=20
@@ -171,7 +171,7 @@ static void iic_dev_init(struct ibm_iic_private* dev)
 	DUMP_REGS("iic_init", dev);
 }
=20
=2D/*=20
+/*
  * Reset IIC interface
  */
 static void iic_dev_reset(struct ibm_iic_private* dev)
@@ -179,42 +179,42 @@ static void iic_dev_reset(struct ibm_iic_private* dev)
 	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
 	int i;
 	u8 dc;
=2D=09
+
 	DBG("%d: soft reset\n", dev->idx);
 	DUMP_REGS("reset", dev);
=2D=09
+
     	/* Place chip in the reset state */
 	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
=2D=09
+
 	/* Check if bus is free */
=2D	dc =3D in_8(&iic->directcntl);=09
+	dc =3D in_8(&iic->directcntl);
 	if (!DIRCTNL_FREE(dc)){
 		DBG("%d: trying to regain bus control\n", dev->idx);
=2D=09
+
 		/* Try to set bus free state */
=2D		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);=09
=2D=09
+		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+
 		/* Wait until we regain bus control */
 		for (i =3D 0; i < 100; ++i){
 			dc =3D in_8(&iic->directcntl);
 			if (DIRCTNL_FREE(dc))
 				break;
=2D		=09
+
 			/* Toggle SCL line */
 			dc ^=3D DIRCNTL_SCC;
 			out_8(&iic->directcntl, dc);
 			udelay(10);
 			dc ^=3D DIRCNTL_SCC;
 			out_8(&iic->directcntl, dc);
=2D		=09
+
 			/* be nice */
 			cond_resched();
 		}
 	}
=2D=09
+
 	/* Remove reset */
 	out_8(&iic->xtcntlss, 0);
=2D=09
+
 	/* Reinitialize interface */
 	iic_dev_init(dev);
 }
@@ -324,14 +324,14 @@ static irqreturn_t iic_handler(int irq, void *dev_id)
 {
 	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)dev_id;
 	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
=2D=09
=2D	DBG2("%d: irq handler, STS =3D 0x%02x, EXTSTS =3D 0x%02x\n",=20
+
+	DBG2("%d: irq handler, STS =3D 0x%02x, EXTSTS =3D 0x%02x\n",
 	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
=2D=09
+
 	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
 	out_8(&iic->sts, STS_IRQA | STS_SCMP);
 	wake_up_interruptible(&dev->wq);
=2D=09
+
 	return IRQ_HANDLED;
 }
=20
@@ -341,19 +341,19 @@ static irqreturn_t iic_handler(int irq, void *dev_id)
  */
 static int iic_xfer_result(struct ibm_iic_private* dev)
 {
=2D	volatile struct iic_regs __iomem *iic =3D dev->vaddr;=09
=2D=09
+	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
+
 	if (unlikely(in_8(&iic->sts) & STS_ERR)){
=2D		DBG("%d: xfer error, EXTSTS =3D 0x%02x\n", dev->idx,=20
+		DBG("%d: xfer error, EXTSTS =3D 0x%02x\n", dev->idx,
 			in_8(&iic->extsts));
=2D			=09
+
 		/* Clear errors and possible pending IRQs */
=2D		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD |=20
+		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD |
 			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
=2D		=09
+
 		/* Flush master data buffer */
 		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
=2D	=09
+
 		/* Is bus free?
 		 * If error happened during combined xfer
 		 * IIC interface is usually stuck in some strange
@@ -376,11 +376,11 @@ static void iic_abort_xfer(struct ibm_iic_private* de=
v)
 {
 	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
 	unsigned long x;
=2D=09
+
 	DBG("%d: iic_abort_xfer\n", dev->idx);
=2D=09
+
 	out_8(&iic->cntl, CNTL_HMT);
=2D=09
+
 	/*
 	 * Wait for the abort command to complete.
 	 * It's not worth to be optimized, just poll (timeout >=3D 1 tick)
@@ -405,13 +405,13 @@ static void iic_abort_xfer(struct ibm_iic_private* de=
v)
  * Returns the number of transferred bytes or error (<0)
  */
 static int iic_wait_for_tc(struct ibm_iic_private* dev){
=2D=09
+
 	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
 	int ret =3D 0;
=2D=09
+
 	if (dev->irq >=3D 0){
 		/* Interrupt mode */
=2D		ret =3D wait_event_interruptible_timeout(dev->wq,=20
+		ret =3D wait_event_interruptible_timeout(dev->wq,
 			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout * HZ);
=20
 		if (unlikely(ret < 0))
@@ -424,37 +424,37 @@ static int iic_wait_for_tc(struct ibm_iic_private* de=
v){
 	else {
 		/* Polling mode */
 		unsigned long x =3D jiffies + dev->adap.timeout * HZ;
=2D	=09
+
 		while (in_8(&iic->sts) & STS_PT){
 			if (unlikely(time_after(jiffies, x))){
 				DBG("%d: poll timeout\n", dev->idx);
 				ret =3D -ETIMEDOUT;
 				break;
 			}
=2D	=09
+
 			if (unlikely(signal_pending(current))){
 				DBG("%d: poll interrupted\n", dev->idx);
 				ret =3D -ERESTARTSYS;
 				break;
 			}
 			schedule();
=2D		}=09
+		}
 	}
=2D=09
+
 	if (unlikely(ret < 0))
 		iic_abort_xfer(dev);
 	else
 		ret =3D iic_xfer_result(dev);
=2D=09
+
 	DBG2("%d: iic_wait_for_tc -> %d\n", dev->idx, ret);
=2D=09
+
 	return ret;
 }
=20
 /*
  * Low level master transfer routine
  */
=2Dstatic int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* p=
m,=20
+static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 			  int combined_xfer)
 {
 	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
@@ -465,48 +465,48 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev=
, struct i2c_msg* pm,
 	u8 cntl =3D (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
 	if (pm->flags & I2C_M_RD)
 		cntl |=3D CNTL_RW;
=2D=09
+
 	loops =3D (len + 3) / 4;
 	for (i =3D 0; i < loops; ++i, len -=3D 4){
 		int count =3D len > 4 ? 4 : len;
 		u8 cmd =3D cntl | ((count - 1) << CNTL_TCT_SHIFT);
=2D	=09
+
 		if (!(cntl & CNTL_RW))
 			for (j =3D 0; j < count; ++j)
 				out_8((void __iomem *)&iic->mdbuf, *buf++);
=2D	=09
+
 		if (i < loops - 1)
 			cmd |=3D CNTL_CHT;
 		else if (combined_xfer)
 			cmd |=3D CNTL_RPST;
=2D	=09
+
 		DBG2("%d: xfer_bytes, %d, CNTL =3D 0x%02x\n", dev->idx, count, cmd);
=2D	=09
+
 		/* Start transfer */
 		out_8(&iic->cntl, cmd);
=2D	=09
+
 		/* Wait for completion */
 		ret =3D iic_wait_for_tc(dev);
=20
 		if (unlikely(ret < 0))
 			break;
 		else if (unlikely(ret !=3D count)){
=2D			DBG("%d: xfer_bytes, requested %d, transfered %d\n",=20
+			DBG("%d: xfer_bytes, requested %d, transfered %d\n",
 				dev->idx, count, ret);
=2D		=09
+
 			/* If it's not a last part of xfer, abort it */
 			if (combined_xfer || (i < loops - 1))
     				iic_abort_xfer(dev);
=2D			=09
+
 			ret =3D -EREMOTEIO;
=2D			break;			=09
+			break;
 		}
=2D	=09
+
 		if (cntl & CNTL_RW)
 			for (j =3D 0; j < count; ++j)
 				*buf++ =3D in_8((void __iomem *)&iic->mdbuf);
 	}
=2D=09
+
 	return ret > 0 ? 0 : ret;
 }
=20
@@ -517,10 +517,10 @@ static inline void iic_address(struct ibm_iic_private=
* dev, struct i2c_msg* msg)
 {
 	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
 	u16 addr =3D msg->addr;
=2D=09
=2D	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx,=20
+
+	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx,
 		addr, msg->flags & I2C_M_TEN ? 10 : 7);
=2D=09
+
 	if (msg->flags & I2C_M_TEN){
 	    out_8(&iic->cntl, CNTL_AMD);
 	    out_8(&iic->lmadr, addr);
@@ -537,15 +537,15 @@ static inline int iic_invalid_address(const struct i2=
c_msg* p)
 	return (p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN) && (p->addr > 0x7f));
 }
=20
=2Dstatic inline int iic_address_neq(const struct i2c_msg* p1,=20
+static inline int iic_address_neq(const struct i2c_msg* p1,
 				  const struct i2c_msg* p2)
 {
=2D	return (p1->addr !=3D p2->addr)=20
+	return (p1->addr !=3D p2->addr)
 		|| ((p1->flags & I2C_M_TEN) !=3D (p2->flags & I2C_M_TEN));
=2D}=20
+}
=20
 /*
=2D * Generic master transfer entrypoint.=20
+ * Generic master transfer entrypoint.
  * Returns the number of processed messages or error (<0)
  */
 static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int nu=
m)
@@ -553,20 +553,20 @@ static int iic_xfer(struct i2c_adapter *adap, struct =
i2c_msg *msgs, int num)
     	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)(i2c_get_ada=
pdata(adap));
 	volatile struct iic_regs __iomem *iic =3D dev->vaddr;
 	int i, ret =3D 0;
=2D=09
+
 	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
=2D=09
+
 	if (!num)
 		return 0;
=2D=09
+
 	/* Check the sanity of the passed messages.
 	 * Uhh, generic i2c layer is more suitable place for such code...
 	 */
 	if (unlikely(iic_invalid_address(&msgs[0]))){
=2D		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx,=20
+		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx,
 			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
 		return -EINVAL;
=2D	}	=09
+	}
 	for (i =3D 0; i < num; ++i){
 		if (unlikely(msgs[i].len <=3D 0)){
 			if (num =3D=3D 1 && !msgs[0].len){
@@ -576,7 +576,7 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2=
c_msg *msgs, int num)
 				 */
 				return iic_smbus_quick(dev, &msgs[0]);
 			}
=2D			DBG("%d: invalid len %d in msg[%d]\n", dev->idx,=20
+			DBG("%d: invalid len %d in msg[%d]\n", dev->idx,
 				msgs[i].len, i);
 			return -EINVAL;
 		}
@@ -585,34 +585,34 @@ static int iic_xfer(struct i2c_adapter *adap, struct =
i2c_msg *msgs, int num)
 			return -EINVAL;
 		}
 	}
=2D=09
+
 	/* Check bus state */
 	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE)=
){
 		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
=2D	=09
+
 		/* Usually it means something serious has happend.
 		 * We *cannot* have unfinished previous transfer
 		 * so it doesn't make any sense to try to stop it.
=2D		 * Probably we were not able to recover from the=20
+		 * Probably we were not able to recover from the
 		 * previous error.
 		 * The only *reasonable* thing I can think of here
 		 * is soft reset.  --ebs
 		 */
 		iic_dev_reset(dev);
=2D	=09
+
 		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE){
 			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
 			return -EREMOTEIO;
 		}
=2D	}=20
+	}
 	else {
 		/* Flush master data buffer (just in case) */
 		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
 	}
=2D=09
+
 	/* Load slave address */
 	iic_address(dev, &msgs[0]);
=2D=09
+
 	/* Do real transfer */
     	for (i =3D 0; i < num && !ret; ++i)
 		ret =3D iic_xfer_bytes(dev, &msgs[i], i < num - 1);
@@ -648,7 +648,7 @@ static inline u8 iic_clckdiv(unsigned int opb)
=20
 	/* Convert to MHz */
 	opb /=3D 1000000;
=2D=09
+
 	if (opb < 20 || opb > 150){
 		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
 			opb);
@@ -666,7 +666,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 	struct i2c_adapter* adap;
 	struct ocp_func_iic_data* iic_data =3D ocp->def->additions;
 	int ret;
=2D=09
+
 	if (!iic_data)
 		printk(KERN_WARNING"ibm-iic%d: missing additional data!\n",
 			ocp->def->index);
@@ -679,7 +679,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
=20
 	dev->idx =3D ocp->def->index;
 	ocp_set_drvdata(ocp, dev);
=2D=09
+
 	if (!request_mem_region(ocp->def->paddr, sizeof(struct iic_regs),
 				"ibm_iic")) {
 		ret =3D -EBUSY;
@@ -692,7 +692,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 		ret =3D -ENXIO;
 		goto fail2;
 	}
=2D=09
+
 	init_waitqueue_head(&dev->wq);
=20
 	dev->irq =3D iic_force_poll ? -1 : ocp->def->irq;
@@ -702,29 +702,29 @@ static int __devinit iic_probe(struct ocp_device *ocp=
){
 		 */
 		iic_interrupt_mode(dev, 0);
 		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
=2D			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n",=20
+			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n",
 				dev->idx, dev->irq);
=2D			/* Fallback to the polling mode */=09
+			/* Fallback to the polling mode */
 			dev->irq =3D -1;
 		}
 	}
=2D=09
+
 	if (dev->irq < 0)
=2D		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",=20
+		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",
 			dev->idx);
=2D	=09
+
 	/* Board specific settings */
 	dev->fast_mode =3D iic_force_fast ? 1 : (iic_data ? iic_data->fast_mode :=
 0);
=2D=09
=2D	/* clckdiv is the same for *all* IIC interfaces,=20
+
+	/* clckdiv is the same for *all* IIC interfaces,
 	 * but I'd rather make a copy than introduce another global. --ebs
 	 */
 	dev->clckdiv =3D iic_clckdiv(ocp_sys_info.opb_bus_freq);
 	DBG("%d: clckdiv =3D %d\n", dev->idx, dev->clckdiv);
=2D=09
+
 	/* Initialize IIC interface */
 	iic_dev_init(dev);
=2D=09
+
 	/* Register it with i2c layer */
 	adap =3D &dev->adap;
 	adap->dev.parent =3D &ocp->dev;
@@ -750,24 +750,24 @@ static int __devinit iic_probe(struct ocp_device *ocp=
){
 			dev->idx);
 		goto fail;
 	}
=2D=09
+
 	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
 		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
=20
 	return 0;
=20
=2Dfail:=09
+fail:
 	if (dev->irq >=3D 0){
 		iic_interrupt_mode(dev, 0);
 		free_irq(dev->irq, dev);
=2D	}=09
+	}
=20
 	iounmap(dev->vaddr);
=2Dfail2:=09
+fail2:
 	release_mem_region(ocp->def->paddr, sizeof(struct iic_regs));
 fail1:
 	ocp_set_drvdata(ocp, NULL);
=2D	kfree(dev);=09
+	kfree(dev);
 	return ret;
 }
=20
@@ -783,13 +783,13 @@ static void __devexit iic_remove(struct ocp_device *o=
cp)
 			dev->idx);
 		/* That's *very* bad, just shutdown IRQ ... */
 		if (dev->irq >=3D 0){
=2D		    iic_interrupt_mode(dev, 0);=09
+		    iic_interrupt_mode(dev, 0);
 		    free_irq(dev->irq, dev);
 		    dev->irq =3D -1;
 		}
 	} else {
 		if (dev->irq >=3D 0){
=2D		    iic_interrupt_mode(dev, 0);=09
+		    iic_interrupt_mode(dev, 0);
 		    free_irq(dev->irq, dev);
 		}
 		iounmap(dev->vaddr);
@@ -798,7 +798,7 @@ static void __devexit iic_remove(struct ocp_device *ocp)
 	}
 }
=20
=2Dstatic struct ocp_device_id ibm_iic_ids[] __devinitdata =3D=20
+static struct ocp_device_id ibm_iic_ids[] __devinitdata =3D
 {
 	{ .vendor =3D OCP_VENDOR_IBM, .function =3D OCP_FUNC_IIC },
 	{ .vendor =3D OCP_VENDOR_INVALID }
diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_=
iic.h
index 59d7b43..fdaa482 100644
=2D-- a/drivers/i2c/busses/i2c-ibm_iic.h
+++ b/drivers/i2c/busses/i2c-ibm_iic.h
@@ -2,11 +2,11 @@
  * drivers/i2c/busses/i2c-ibm_iic.h
  *
  * Support for the IIC peripheral on IBM PPC 4xx
=2D *=20
+ *
  * Copyright (c) 2003 Zultys Technologies.
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
=2D * Based on original work by=20
+ * Based on original work by
  * 	Ian DaSilva  <idasilva@mvista.com>
  *      Armin Kuster <akuster@mvista.com>
  * 	Matt Porter  <mporter@mvista.com>
@@ -22,7 +22,7 @@
 #ifndef __I2C_IBM_IIC_H_
 #define __I2C_IBM_IIC_H_
=20
=2D#include <linux/i2c.h>=20
+#include <linux/i2c.h>
=20
 struct iic_regs {
 	u16 mdbuf;
@@ -58,7 +58,7 @@ struct ibm_iic_private {
 #define CNTL_TCT_MASK	0x30
 #define CNTL_TCT_SHIFT	4
 #define CNTL_RPST	0x08
=2D#define CNTL_CHT	0x04=20
+#define CNTL_CHT	0x04
 #define CNTL_RW		0x02
 #define CNTL_PT		0x01
=20
=2D-=20
1.5.3.4
