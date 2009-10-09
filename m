Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CA99B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Oct 2009 08:28:00 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n99LRtUj021856
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 16:27:56 -0500
Subject: [PATCH] powerpc/pmac: Fix issues with sleep on some powerbooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <200906032200.55563.rjw@sisk.pl>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<200906031202.28916.rjw@sisk.pl>
	<877hzty0hm.fsf@scholz.fias.uni-frankfurt.de>
	<200906032200.55563.rjw@sisk.pl>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 10 Oct 2009 08:27:54 +1100
Message-Id: <1255123674.2861.14.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the change of how interrupts are disabled during suspend,
certain PowerBook models started exhibiting various issues during
suspend or resume from sleep.

I finally tracked it down to the code that runs various "platform"
functions (kind of little scripts extracted from the device-tree),
which uses our i2c and PMU drivers expecting interrutps to work,
and at a time where with the new scheme, they have been disabled.

This causes timeouts internally which for some reason results in
the PMU being unable to see the trackpad, among other issues, really
it depends on the machine. Most of the time, we fail to properly adjust
some clocks for suspend/resume so the results are not always
predictable.

This patch fixes it by using IRQF_TIMER for both the PMU and the I2C
interrupts. I prefer doing it this way than moving the call sites since
I really want those platform functions to still be called after all
drivers (and before sysdevs).

We also do a slight cleanup to via-pmu.c driver to make sure the
ADB autopoll mask is handled correctly when doing bus resets

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 21226b7..414ca98 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -540,8 +540,11 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	/* Make sure IRQ is disabled */
 	kw_write_reg(reg_ier, 0);
 
-	/* Request chip interrupt */
-	if (request_irq(host->irq, kw_i2c_irq, 0, "keywest i2c", host))
+	/* Request chip interrupt. We set IRQF_TIMER because we don't
+	 * want that interrupt disabled between the 2 passes of driver
+	 * suspend or we'll have issues running the pfuncs
+	 */
+	if (request_irq(host->irq, kw_i2c_irq, IRQF_TIMER, "keywest i2c", host))
 		host->irq = NO_IRQ;
 
 	printk(KERN_INFO "KeyWest i2c @0x%08x irq %d %s\n",
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index b40fb9b..6f308a4 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -405,7 +405,11 @@ static int __init via_pmu_start(void)
 		printk(KERN_ERR "via-pmu: can't map interrupt\n");
 		return -ENODEV;
 	}
-	if (request_irq(irq, via_pmu_interrupt, 0, "VIA-PMU", (void *)0)) {
+	/* We set IRQF_TIMER because we don't want the interrupt to be disabled
+	 * between the 2 passes of driver suspend, we control our own disabling
+	 * for that one
+	 */
+	if (request_irq(irq, via_pmu_interrupt, IRQF_TIMER, "VIA-PMU", (void *)0)) {
 		printk(KERN_ERR "via-pmu: can't request irq %d\n", irq);
 		return -ENODEV;
 	}
@@ -419,7 +423,7 @@ static int __init via_pmu_start(void)
 			gpio_irq = irq_of_parse_and_map(gpio_node, 0);
 
 		if (gpio_irq != NO_IRQ) {
-			if (request_irq(gpio_irq, gpio1_interrupt, 0,
+			if (request_irq(gpio_irq, gpio1_interrupt, IRQF_TIMER,
 					"GPIO1 ADB", (void *)0))
 				printk(KERN_ERR "pmu: can't get irq %d"
 				       " (GPIO1)\n", gpio_irq);
@@ -925,8 +929,7 @@ proc_write_options(struct file *file, const char __user *buffer,
 
 #ifdef CONFIG_ADB
 /* Send an ADB command */
-static int
-pmu_send_request(struct adb_request *req, int sync)
+static int pmu_send_request(struct adb_request *req, int sync)
 {
 	int i, ret;
 
@@ -1005,16 +1008,11 @@ pmu_send_request(struct adb_request *req, int sync)
 }
 
 /* Enable/disable autopolling */
-static int
-pmu_adb_autopoll(int devs)
+static int __pmu_adb_autopoll(int devs)
 {
 	struct adb_request req;
 
-	if ((vias == NULL) || (!pmu_fully_inited) || !pmu_has_adb)
-		return -ENXIO;
-
 	if (devs) {
-		adb_dev_map = devs;
 		pmu_request(&req, NULL, 5, PMU_ADB_CMD, 0, 0x86,
 			    adb_dev_map >> 8, adb_dev_map);
 		pmu_adb_flags = 2;
@@ -1027,9 +1025,17 @@ pmu_adb_autopoll(int devs)
 	return 0;
 }
 
+static int pmu_adb_autopoll(int devs)
+{
+	if ((vias == NULL) || (!pmu_fully_inited) || !pmu_has_adb)
+		return -ENXIO;
+
+	adb_dev_map = devs;
+	return __pmu_adb_autopoll(devs);
+}
+
 /* Reset the ADB bus */
-static int
-pmu_adb_reset_bus(void)
+static int pmu_adb_reset_bus(void)
 {
 	struct adb_request req;
 	int save_autopoll = adb_dev_map;
@@ -1038,13 +1044,13 @@ pmu_adb_reset_bus(void)
 		return -ENXIO;
 
 	/* anyone got a better idea?? */
-	pmu_adb_autopoll(0);
+	__pmu_adb_autopoll(0);
 
-	req.nbytes = 5;
+	req.nbytes = 4;
 	req.done = NULL;
 	req.data[0] = PMU_ADB_CMD;
-	req.data[1] = 0;
-	req.data[2] = ADB_BUSRESET;
+	req.data[1] = ADB_BUSRESET;
+	req.data[2] = 0;
 	req.data[3] = 0;
 	req.data[4] = 0;
 	req.reply_len = 0;
@@ -1056,7 +1062,7 @@ pmu_adb_reset_bus(void)
 	pmu_wait_complete(&req);
 
 	if (save_autopoll != 0)
-		pmu_adb_autopoll(save_autopoll);
+		__pmu_adb_autopoll(save_autopoll);
 
 	return 0;
 }
