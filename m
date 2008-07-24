Return-Path: <dmitry.torokhov@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 851DADDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 13:38:04 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so892601anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 20:38:03 -0700 (PDT)
Date: Wed, 23 Jul 2008 23:37:58 -0400
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: driver updates based on review
Message-ID: <20080724033758.GA1286@anvil.corenet.prv>
References: <20080710193451.ED2B51D18066@mail97-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080710193451.ED2B51D18066@mail97-dub.bigfish.com>
Cc: Sadanand <sadanan@xilinx.com>, linuxppc-dev@ozlabs.org,
	linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi John,

On Thu, Jul 10, 2008 at 12:34:43PM -0700, John Linn wrote:
> Review comments were incorporated to improve the driver.
> 
> 1. Some data was eliminated that was not needed.
> 2. Renaming of variables for clarity.
> 3. Removed unneeded type casting.
> 4. Changed to use dev_err rather than other I/O.
> 5. Merged together some functions.
> 6. Added kerneldoc format to functions.
> 


There were some changes made to the original version of the patch that I
applied so this one did not patch cleanly. I think I fixed it up right
but if you could give it a look over before I commit it that would be
great.

Thanks!

-- 
Dmitry

Input: xilinx_ps2 - various cleanups

From: John Linn <john.linn@xilinx.com>

Review comments were incorporated to improve the driver.

1. Some data was eliminated that was not needed.
2. Renaming of variables for clarity.
3. Removed unneeded type casting.
4. Changed to use dev_err rather than other I/O.
5. Merged together some functions.
6. Added kerneldoc format to functions.

Signed-off-by: Sadanand <sadanan@xilinx.com>
Signed-off-by: John Linn <john.linn@xilinx.com>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/xilinx_ps2.c |  211 +++++++++++++++++++-------------------
 1 files changed, 108 insertions(+), 103 deletions(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 0ed044d..85515cf 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -58,23 +58,20 @@
 
 /* Mask for all the Receive Interrupts */
 #define XPS2_IPIXR_RX_ALL	(XPS2_IPIXR_RX_OVF | XPS2_IPIXR_RX_ERR |  \
-					XPS2_IPIXR_RX_FULL)
+				 XPS2_IPIXR_RX_FULL)
 
 /* Mask for all the Interrupts */
 #define XPS2_IPIXR_ALL		(XPS2_IPIXR_TX_ALL | XPS2_IPIXR_RX_ALL |  \
-					XPS2_IPIXR_WDT_TOUT)
+				 XPS2_IPIXR_WDT_TOUT)
 
 /* Global Interrupt Enable mask */
 #define XPS2_GIER_GIE_MASK	0x80000000
 
 struct xps2data {
 	int irq;
-	u32 phys_addr;
-	u32 remap_size;
 	spinlock_t lock;
-	u8 rxb;				/* Rx buffer */
 	void __iomem *base_address;	/* virt. address of control registers */
-	unsigned int dfl;
+	unsigned int flags;
 	struct serio serio;		/* serio */
 };
 
@@ -82,8 +79,13 @@ struct xps2data {
 /* XPS PS/2 data transmission calls */
 /************************************/
 
-/*
- * xps2_recv() will attempt to receive a byte of data from the PS/2 port.
+/**
+ * xps2_recv() - attempts to receive a byte from the PS/2 port.
+ * @drvdata:	pointer to ps2 device private data structure
+ * @byte:	address where the read data will be copied
+ *
+ * If there is any data available in the PS/2 receiver, this functions reads
+ * the data, otherwise it returns error.
  */
 static int xps2_recv(struct xps2data *drvdata, u8 *byte)
 {
@@ -116,33 +118,27 @@ static irqreturn_t xps2_interrupt(int irq, void *dev_id)
 
 	/* Check which interrupt is active */
 	if (intr_sr & XPS2_IPIXR_RX_OVF)
-		printk(KERN_WARNING "%s: receive overrun error\n",
-			drvdata->serio.name);
+		dev_warn(drvdata->serio.dev.parent, "receive overrun error\n");
 
 	if (intr_sr & XPS2_IPIXR_RX_ERR)
-		drvdata->dfl |= SERIO_PARITY;
+		drvdata->flags |= SERIO_PARITY;
 
 	if (intr_sr & (XPS2_IPIXR_TX_NOACK | XPS2_IPIXR_WDT_TOUT))
-		drvdata->dfl |= SERIO_TIMEOUT;
+		drvdata->flags |= SERIO_TIMEOUT;
 
 	if (intr_sr & XPS2_IPIXR_RX_FULL) {
-		status = xps2_recv(drvdata, &drvdata->rxb);
+		status = xps2_recv(drvdata, &c);
 
 		/* Error, if a byte is not received */
 		if (status) {
-			printk(KERN_ERR
-				"%s: wrong rcvd byte count (%d)\n",
-				drvdata->serio.name, status);
+			dev_err(drvdata->serio.dev.parent,
+				"wrong rcvd byte count (%d)\n", status);
 		} else {
-			c = drvdata->rxb;
-			serio_interrupt(&drvdata->serio, c, drvdata->dfl);
-			drvdata->dfl = 0;
+			serio_interrupt(&drvdata->serio, c, drvdata->flags);
+			drvdata->flags = 0;
 		}
 	}
 
-	if (intr_sr & XPS2_IPIXR_TX_ACK)
-		drvdata->dfl = 0;
-
 	return IRQ_HANDLED;
 }
 
@@ -150,8 +146,15 @@ static irqreturn_t xps2_interrupt(int irq, void *dev_id)
 /* serio callbacks */
 /*******************/
 
-/*
- * sxps2_write() sends a byte out through the PS/2 interface.
+/**
+ * sxps2_write() - sends a byte out through the PS/2 port.
+ * @pserio:	pointer to the serio structure of the PS/2 port
+ * @c:		data that needs to be written to the PS/2 port
+ *
+ * This function checks if the PS/2 transmitter is empty and sends a byte.
+ * Otherwise it returns error. Transmission fails only when nothing is connected
+ * to the PS/2 port. Thats why, we do not try to resend the data in case of a
+ * failure.
  */
 static int sxps2_write(struct serio *pserio, unsigned char c)
 {
@@ -174,33 +177,39 @@ static int sxps2_write(struct serio *pserio, unsigned char c)
 	return status;
 }
 
-/*
- * sxps2_open() is called when a port is open by the higher layer.
+/**
+ * sxps2_open() - called when a port is opened by the higher layer.
+ * @pserio:	pointer to the serio structure of the PS/2 device
+ *
+ * This function requests irq and enables interrupts for the PS/2 device.
  */
 static int sxps2_open(struct serio *pserio)
 {
 	struct xps2data *drvdata = pserio->port_data;
-	int retval;
+	int error;
+	u8 c;
 
-	retval = request_irq(drvdata->irq, &xps2_interrupt, 0,
+	error = request_irq(drvdata->irq, &xps2_interrupt, 0,
 				DRIVER_NAME, drvdata);
-	if (retval) {
-		printk(KERN_ERR
-			"%s: Couldn't allocate interrupt %d\n",
-			drvdata->serio.name, drvdata->irq);
-		return retval;
+	if (error) {
+		dev_err(drvdata->serio.dev.parent,
+			"Couldn't allocate interrupt %d\n", drvdata->irq);
+		return error;
 	}
 
 	/* start reception by enabling the interrupts */
 	out_be32(drvdata->base_address + XPS2_GIER_OFFSET, XPS2_GIER_GIE_MASK);
 	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, XPS2_IPIXR_RX_ALL);
-	(void)xps2_recv(drvdata, &drvdata->rxb);
+	(void)xps2_recv(drvdata, &c);
 
 	return 0;		/* success */
 }
 
-/*
- * sxps2_close() frees the interrupt.
+/**
+ * sxps2_close() - frees the interrupt.
+ * @pserio:	pointer to the serio structure of the PS/2 device
+ *
+ * This function frees the irq and disables interrupts for the PS/2 device.
  */
 static void sxps2_close(struct serio *pserio)
 {
@@ -212,24 +221,41 @@ static void sxps2_close(struct serio *pserio)
 	free_irq(drvdata->irq, drvdata);
 }
 
-/*********************/
-/* Device setup code */
-/*********************/
-
-static int xps2_setup(struct device *dev, struct resource *regs_res,
-		      struct resource *irq_res)
+/**
+ * xps2_of_probe - probe method for the PS/2 device.
+ * @of_dev:	pointer to OF device structure
+ * @match:	pointer to the stucture used for matching a device
+ *
+ * This function probes the PS/2 device in the device tree.
+ * It initializes the driver data structure and the hardware.
+ * It returns 0, if the driver is bound to the PS/2 device, or a negative
+ * value if there is an error.
+ */
+static int __devinit xps2_of_probe(struct of_device *ofdev,
+				   const struct of_device_id *match)
 {
+	struct resource r_irq; /* Interrupt resources */
+	struct resource r_mem; /* IO mem resources */
 	struct xps2data *drvdata;
 	struct serio *serio;
-	unsigned long remap_size;
-	int retval;
+	struct device *dev = &ofdev->dev;
+	resource_size_t remap_size, phys_addr;
+	int error;
 
-	if (!dev)
-		return -EINVAL;
+	dev_info(dev, "Device Tree Probing \'%s\'\n",
+			ofdev->node->name);
 
-	if (!regs_res || !irq_res) {
-		dev_err(dev, "IO resource(s) not found\n");
-		return -EINVAL;
+	/* Get iospace for the device */
+	error = of_address_to_resource(ofdev->node, 0, &r_mem);
+	if (error) {
+		dev_err(dev, "invalid address\n");
+		return error;
+	}
+
+	/* Get IRQ for the device */
+	if (of_irq_to_resource(ofdev->node, 0, &r_irq) == NO_IRQ) {
+		dev_err(dev, "no IRQ found\n");
+		return -ENODEV;
 	}
 
 	drvdata = kzalloc(sizeof(struct xps2data), GFP_KERNEL);
@@ -241,24 +267,23 @@ static int xps2_setup(struct device *dev, struct resource *regs_res,
 	dev_set_drvdata(dev, drvdata);
 
 	spin_lock_init(&drvdata->lock);
-	drvdata->irq = irq_res->start;
+	drvdata->irq = r_irq.start;
 
-	remap_size = regs_res->end - regs_res->start + 1;
-	if (!request_mem_region(regs_res->start, remap_size, DRIVER_NAME)) {
+	phys_addr = r_mem.start;
+	remap_size = r_mem.end - r_mem.start + 1;
+	if (!request_mem_region(phys_addr, remap_size, DRIVER_NAME)) {
 		dev_err(dev, "Couldn't lock memory region at 0x%08X\n",
-			(unsigned int)regs_res->start);
-		retval = -EBUSY;
+			(unsigned int)phys_addr);
+		error = -EBUSY;
 		goto failed1;
 	}
 
 	/* Fill in configuration data and add them to the list */
-	drvdata->phys_addr = regs_res->start;
-	drvdata->remap_size = remap_size;
-	drvdata->base_address = ioremap(regs_res->start, remap_size);
+	drvdata->base_address = ioremap(phys_addr, remap_size);
 	if (drvdata->base_address == NULL) {
 		dev_err(dev, "Couldn't ioremap memory at 0x%08X\n",
-			(unsigned int)regs_res->start);
-		retval = -EFAULT;
+			(unsigned int)phys_addr);
+		error = -EFAULT;
 		goto failed2;
 	}
 
@@ -270,7 +295,8 @@ static int xps2_setup(struct device *dev, struct resource *regs_res,
 	out_be32(drvdata->base_address + XPS2_SRST_OFFSET, XPS2_SRST_RESET);
 
 	dev_info(dev, "Xilinx PS2 at 0x%08X mapped to 0x%08X, irq=%d\n",
-		drvdata->phys_addr, (u32)drvdata->base_address, drvdata->irq);
+		 (unsigned int)phys_addr, (u32)drvdata->base_address,
+		 drvdata->irq);
 
 	serio = &drvdata->serio;
 	serio->id.type = SERIO_8042;
@@ -280,71 +306,50 @@ static int xps2_setup(struct device *dev, struct resource *regs_res,
 	serio->port_data = drvdata;
 	serio->dev.parent = dev;
 	snprintf(serio->name, sizeof(serio->name),
-		 "Xilinx XPS PS/2 at %08X", drvdata->phys_addr);
+		 "Xilinx XPS PS/2 at %08X", (unsigned int)phys_addr);
 	snprintf(serio->phys, sizeof(serio->phys),
-		 "xilinxps2/serio at %08X", drvdata->phys_addr);
+		 "xilinxps2/serio at %08X", (unsigned int)phys_addr);
 	serio_register_port(serio);
 
 	return 0;		/* success */
 
 failed2:
-	release_mem_region(regs_res->start, remap_size);
+	release_mem_region(phys_addr, remap_size);
 failed1:
 	kfree(drvdata);
 	dev_set_drvdata(dev, NULL);
 
-	return retval;
-}
-
-/***************************/
-/* OF Platform Bus Support */
-/***************************/
-
-static int __devinit xps2_of_probe(struct of_device *ofdev, const struct
-				   of_device_id * match)
-{
-	struct resource r_irq; /* Interrupt resources */
-	struct resource r_mem; /* IO mem resources */
-	int rc = 0;
-
-	printk(KERN_INFO "Device Tree Probing \'%s\'\n",
-			ofdev->node->name);
-
-	/* Get iospace for the device */
-	rc = of_address_to_resource(ofdev->node, 0, &r_mem);
-	if (rc) {
-		dev_err(&ofdev->dev, "invalid address\n");
-		return rc;
-	}
-
-	/* Get IRQ for the device */
-	rc = of_irq_to_resource(ofdev->node, 0, &r_irq);
-	if (rc == NO_IRQ) {
-		dev_err(&ofdev->dev, "no IRQ found\n");
-		return rc;
-	}
-
-	return xps2_setup(&ofdev->dev, &r_mem, &r_irq);
+	return error;
 }
 
+/**
+ * xps2_of_remove - unbinds the driver from the PS/2 device.
+ * @of_dev:	pointer to OF device structure
+ *
+ * This function is called if a device is physically removed from the system or
+ * if the driver module is being unloaded. It frees any resources allocated to
+ * the device.
+ */
 static int __devexit xps2_of_remove(struct of_device *of_dev)
 {
 	struct device *dev = &of_dev->dev;
-	struct xps2data *drvdata;
-
-	if (!dev)
-		return -EINVAL;
-
-	drvdata = dev_get_drvdata(dev);
+	struct xps2data *drvdata = dev_get_drvdata(dev);
+	struct resource r_mem; /* IO mem resources */
 
 	serio_unregister_port(&drvdata->serio);
 	iounmap(drvdata->base_address);
-	release_mem_region(drvdata->phys_addr, drvdata->remap_size);
+
+	/* Get iospace of the device */
+	if (of_address_to_resource(of_dev->node, 0, &r_mem))
+		dev_err(dev, "invalid address\n");
+	else
+		release_mem_region(r_mem.start, r_mem.end - r_mem.start + 1);
+
 	kfree(drvdata);
 
 	dev_set_drvdata(dev, NULL);
 
-	return 0;		/* success */
+	return 0;
 }
 
 /* Match table for of_platform binding */
