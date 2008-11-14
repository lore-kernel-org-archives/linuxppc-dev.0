Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 6C594DDDE6
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 15:53:09 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1257403rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 20:53:07 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/virtex: fix various format/casting printk mismatches
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, jwboyer@gmail.com
Date: Thu, 13 Nov 2008 21:53:04 -0700
Message-ID: <20081114045304.15077.72430.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Various printk format string in code used by the Xilinx Virtex platform
are not 32-bit/64-bit safe.  Add correct casting to fix the bugs.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/xilinx_intc.c          |    4 ++--
 drivers/char/xilinx_hwicap/xilinx_hwicap.c |    9 +++++----
 drivers/serial/uartlite.c                  |    4 ++--
 drivers/video/xilinxfb.c                   |    5 +++--
 4 files changed, 12 insertions(+), 10 deletions(-)


diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index b7aefd0..a22e1a2 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -107,8 +107,8 @@ xilinx_intc_init(struct device_node *np)
 	}
 	regs = ioremap(res.start, 32);
 
-	printk(KERN_INFO "Xilinx intc at 0x%08LX mapped to 0x%p\n",
-		res.start, regs);
+	printk(KERN_INFO "Xilinx intc at 0x%08llx mapped to 0x%p\n",
+		(unsigned long long) res.start, regs);
 
 	/* Setup interrupt controller */
 	out_be32(regs + XINTC_IER, 0); /* disable all irqs */
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index ed132fe..d161319 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -626,7 +626,7 @@ static int __devinit hwicap_setup(struct device *dev, int id,
 	if (!request_mem_region(drvdata->mem_start,
 					drvdata->mem_size, DRIVER_NAME)) {
 		dev_err(dev, "Couldn't lock memory region at %Lx\n",
-			regs_res->start);
+			(unsigned long long) regs_res->start);
 		retval = -EBUSY;
 		goto failed1;
 	}
@@ -645,9 +645,10 @@ static int __devinit hwicap_setup(struct device *dev, int id,
 	mutex_init(&drvdata->sem);
 	drvdata->is_open = 0;
 
-	dev_info(dev, "ioremap %lx to %p with size %Lx\n",
-		 (unsigned long int)drvdata->mem_start,
-			drvdata->base_address, drvdata->mem_size);
+	dev_info(dev, "ioremap %llx to %p with size %llx\n",
+		 (unsigned long long) drvdata->mem_start,
+		 drvdata->base_address,
+		 (unsigned long long) drvdata->mem_size);
 
 	cdev_init(&drvdata->cdev, &hwicap_fops);
 	drvdata->cdev.owner = THIS_MODULE;
diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 6a3f8fb..3317148 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -286,8 +286,8 @@ static void ulite_release_port(struct uart_port *port)
 
 static int ulite_request_port(struct uart_port *port)
 {
-	pr_debug("ulite console: port=%p; port->mapbase=%x\n",
-		 port, port->mapbase);
+	pr_debug("ulite console: port=%p; port->mapbase=%llx\n",
+		 port, (unsigned long long) port->mapbase);
 
 	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
 		dev_err(port->dev, "Memory region busy\n");
diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 5da3d24..40a3a2a 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -298,8 +298,9 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 
 	/* Put a banner in the log (for DEBUG) */
 	dev_dbg(dev, "regs: phys=%lx, virt=%p\n", physaddr, drvdata->regs);
-	dev_dbg(dev, "fb: phys=%p, virt=%p, size=%x\n",
-		(void*)drvdata->fb_phys, drvdata->fb_virt, fbsize);
+	dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
+		(unsigned long long) drvdata->fb_phys, drvdata->fb_virt,
+		fbsize);
 
 	return 0;	/* success */
 
