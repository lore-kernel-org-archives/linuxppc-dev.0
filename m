Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D4F82DE183
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 05:21:40 +1100 (EST)
Date: Fri, 14 Dec 2007 21:24:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH 1/3] [libata] pata_platform: make probe and remove functions
	device type neutral
Message-ID: <20071214182429.GA1017@localhost.localdomain>
References: <20071214182109.GA858@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071214182109.GA858@localhost.localdomain>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Split pata_platform_{probe,remove} into two pieces:
1. pata_platform_{probe,remove} -- platform_device-dependant bits;
2. __ptata_platform_{probe,remove} -- device type neutral bits.

This is done to not duplicate code for the OF-platform driver.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 drivers/ata/pata_platform.c   |  144 ++++++++++++++++++++++++----------------
 include/linux/pata_platform.h |    9 +++
 2 files changed, 95 insertions(+), 58 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index ac03a90..224bb6c 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -93,14 +93,9 @@ static struct ata_port_operations pata_platform_port_ops = {
 };
 
 static void pata_platform_setup_port(struct ata_ioports *ioaddr,
-				     struct pata_platform_info *info)
+				     unsigned int shift)
 {
-	unsigned int shift = 0;
-
 	/* Fixup the port shift for platforms that need it */
-	if (info && info->ioport_shift)
-		shift = info->ioport_shift;
-
 	ioaddr->data_addr	= ioaddr->cmd_addr + (ATA_REG_DATA    << shift);
 	ioaddr->error_addr	= ioaddr->cmd_addr + (ATA_REG_ERR     << shift);
 	ioaddr->feature_addr	= ioaddr->cmd_addr + (ATA_REG_FEATURE << shift);
@@ -114,8 +109,13 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
 }
 
 /**
- *	pata_platform_probe		-	attach a platform interface
- *	@pdev: platform device
+ *	__pata_platform_probe		-	attach a platform interface
+ *	@dev: device
+ *	@io_res: Resource representing I/O base
+ *	@ctl_res: Resource representing CTL base
+ *	@irq_res: Resource representing IRQ and its flags
+ *	@ioport_shift: I/O port shift
+ *	@__pio_mask: PIO mask
  *
  *	Register a platform bus IDE interface. Such interfaces are PIO and we
  *	assume do not support IRQ sharing.
@@ -135,42 +135,18 @@ static void pata_platform_setup_port(struct ata_ioports *ioaddr,
  *
  *	If no IRQ resource is present, PIO polling mode is used instead.
  */
-static int __devinit pata_platform_probe(struct platform_device *pdev)
+int __devinit __pata_platform_probe(struct device *dev,
+				    struct resource *io_res,
+				    struct resource *ctl_res,
+				    struct resource *irq_res,
+				    unsigned int ioport_shift,
+				    int __pio_mask)
 {
-	struct resource *io_res, *ctl_res;
 	struct ata_host *host;
 	struct ata_port *ap;
-	struct pata_platform_info *pp_info;
 	unsigned int mmio;
-	int irq;
-
-	/*
-	 * Simple resource validation ..
-	 */
-	if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
-		dev_err(&pdev->dev, "invalid number of resources\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Get the I/O base first
-	 */
-	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (io_res == NULL) {
-		io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (unlikely(io_res == NULL))
-			return -EINVAL;
-	}
-
-	/*
-	 * Then the CTL base
-	 */
-	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
-	if (ctl_res == NULL) {
-		ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		if (unlikely(ctl_res == NULL))
-			return -EINVAL;
-	}
+	int irq = 0;
+	int irq_flags = 0;
 
 	/*
 	 * Check for MMIO
@@ -181,20 +157,21 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 	/*
 	 * And the IRQ
 	 */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		irq = 0;	/* no irq */
+	if (irq_res && irq_res->start > 0) {
+		irq = irq_res->start;
+		irq_flags = irq_res->flags;
+	}
 
 	/*
 	 * Now that that's out of the way, wire up the port..
 	 */
-	host = ata_host_alloc(&pdev->dev, 1);
+	host = ata_host_alloc(dev, 1);
 	if (!host)
 		return -ENOMEM;
 	ap = host->ports[0];
 
 	ap->ops = &pata_platform_port_ops;
-	ap->pio_mask = pio_mask;
+	ap->pio_mask = __pio_mask;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
 	/*
@@ -209,25 +186,24 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 	 * Handle the MMIO case
 	 */
 	if (mmio) {
-		ap->ioaddr.cmd_addr = devm_ioremap(&pdev->dev, io_res->start,
+		ap->ioaddr.cmd_addr = devm_ioremap(dev, io_res->start,
 				io_res->end - io_res->start + 1);
-		ap->ioaddr.ctl_addr = devm_ioremap(&pdev->dev, ctl_res->start,
+		ap->ioaddr.ctl_addr = devm_ioremap(dev, ctl_res->start,
 				ctl_res->end - ctl_res->start + 1);
 	} else {
-		ap->ioaddr.cmd_addr = devm_ioport_map(&pdev->dev, io_res->start,
+		ap->ioaddr.cmd_addr = devm_ioport_map(dev, io_res->start,
 				io_res->end - io_res->start + 1);
-		ap->ioaddr.ctl_addr = devm_ioport_map(&pdev->dev, ctl_res->start,
+		ap->ioaddr.ctl_addr = devm_ioport_map(dev, ctl_res->start,
 				ctl_res->end - ctl_res->start + 1);
 	}
 	if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
-		dev_err(&pdev->dev, "failed to map IO/CTL base\n");
+		dev_err(dev, "failed to map IO/CTL base\n");
 		return -ENOMEM;
 	}
 
 	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
 
-	pp_info = pdev->dev.platform_data;
-	pata_platform_setup_port(&ap->ioaddr, pp_info);
+	pata_platform_setup_port(&ap->ioaddr, ioport_shift);
 
 	ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
 		      (unsigned long long)io_res->start,
@@ -235,26 +211,78 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 
 	/* activate */
 	return ata_host_activate(host, irq, irq ? ata_interrupt : NULL,
-				 pp_info ? pp_info->irq_flags : 0,
-				 &pata_platform_sht);
+				 irq_flags, &pata_platform_sht);
 }
+EXPORT_SYMBOL_GPL(__pata_platform_probe);
 
 /**
- *	pata_platform_remove	-	unplug a platform interface
- *	@pdev: platform device
+ *	__pata_platform_remove		-	unplug a platform interface
+ *	@dev: device
  *
  *	A platform bus ATA device has been unplugged. Perform the needed
  *	cleanup. Also called on module unload for any active devices.
  */
-static int __devexit pata_platform_remove(struct platform_device *pdev)
+int __devexit __pata_platform_remove(struct device *dev)
 {
-	struct device *dev = &pdev->dev;
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__pata_platform_remove);
+
+static int __devinit pata_platform_probe(struct platform_device *pdev)
+{
+	struct resource *io_res;
+	struct resource *ctl_res;
+	struct resource *irq_res;
+	struct pata_platform_info *pp_info = pdev->dev.platform_data;
+
+	/*
+	 * Simple resource validation ..
+	 */
+	if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get the I/O base first
+	 */
+	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (io_res == NULL) {
+		io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (unlikely(io_res == NULL))
+			return -EINVAL;
+	}
+
+	/*
+	 * Then the CTL base
+	 */
+	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
+	if (ctl_res == NULL) {
+		ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (unlikely(ctl_res == NULL))
+			return -EINVAL;
+	}
+
+	/*
+	 * And the IRQ
+	 */
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (irq_res)
+		irq_res->flags = pp_info ? pp_info->irq_flags : 0;
+
+	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
+				     pp_info ? pp_info->ioport_shift : 0,
+				     pio_mask);
+}
+
+static int __devexit pata_platform_remove(struct platform_device *pdev)
+{
+	return __pata_platform_remove(&pdev->dev);
+}
 
 static struct platform_driver pata_platform_driver = {
 	.probe		= pata_platform_probe,
diff --git a/include/linux/pata_platform.h b/include/linux/pata_platform.h
index 5799e8d..6a7a92d 100644
--- a/include/linux/pata_platform.h
+++ b/include/linux/pata_platform.h
@@ -15,4 +15,13 @@ struct pata_platform_info {
 	unsigned int irq_flags;
 };
 
+extern int __devinit __pata_platform_probe(struct device *dev,
+					   struct resource *io_res,
+					   struct resource *ctl_res,
+					   struct resource *irq_res,
+					   unsigned int ioport_shift,
+					   int __pio_mask);
+
+extern int __devexit __pata_platform_remove(struct device *dev);
+
 #endif /* __LINUX_PATA_PLATFORM_H */
-- 
1.5.2.2
