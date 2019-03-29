Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96E0C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 14:33:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FB02173C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 14:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FB02173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W43M2XBgzDqTR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 01:33:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W3WR67LKzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:09:07 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F52D1A012B;
 Fri, 29 Mar 2019 15:00:21 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 227821A00A7;
 Fri, 29 Mar 2019 15:00:21 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net
 (fsr-ub1864-101.ea.freescale.net [10.171.74.120])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 865FD20606;
 Fri, 29 Mar 2019 15:00:20 +0100 (CET)
From: laurentiu.tudor@nxp.com
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
 camelia.groza@nxp.com, leoyang.li@nxp.com
Subject: [PATCH 06/13] soc/fsl/qbman_portals: add APIs to retrieve the probing
 status
Date: Fri, 29 Mar 2019 16:00:07 +0200
Message-Id: <20190329140014.8126-7-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a couple of new APIs to check the probing status of the required
cpu bound qman and bman portals:
 'int bman_portals_probed()' and 'int qman_portals_probed()'.
They return the following values.
 *  1 if qman/bman portals were all probed correctly
 *  0 if qman/bman portals were not yet probed
 * -1 if probing of qman/bman portals failed
Portals are considered successful probed if no error occurred during
the probing of any of the portals and if enough portals were probed
to have one available for each cpu.
The error handling paths were slightly rearranged in order to fit this
new functionality without being too intrusive.
Drivers that use qman/bman portal driver services are required to use
these APIs before calling any functions exported by these drivers or
otherwise they will crash the kernel.
First user will be the dpaa1 ethernet driver, coming in a subsequent
patch.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/bman_portal.c | 22 ++++++++++++++++++----
 drivers/soc/fsl/qbman/qman_portal.c | 23 +++++++++++++++++++----
 include/soc/fsl/bman.h              |  8 ++++++++
 include/soc/fsl/qman.h              |  9 +++++++++
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 2c95cf59f3e7..7819bc29936d 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -32,6 +32,7 @@
 
 static struct bman_portal *affine_bportals[NR_CPUS];
 static struct cpumask portal_cpus;
+static int __bman_portals_probed;
 /* protect bman global registers and global data shared among portals */
 static DEFINE_SPINLOCK(bman_lock);
 
@@ -87,6 +88,12 @@ static int bman_online_cpu(unsigned int cpu)
 	return 0;
 }
 
+int bman_portals_probed(void)
+{
+	return __bman_portals_probed;
+}
+EXPORT_SYMBOL_GPL(bman_portals_probed);
+
 static int bman_portal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -104,8 +111,10 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
-	if (!pcfg)
+	if (!pcfg) {
+		__bman_portals_probed = -1;
 		return -ENOMEM;
+	}
 
 	pcfg->dev = dev;
 
@@ -113,14 +122,14 @@ static int bman_portal_probe(struct platform_device *pdev)
 					     DPAA_PORTAL_CE);
 	if (!addr_phys[0]) {
 		dev_err(dev, "Can't get %pOF property 'reg::CE'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 
 	addr_phys[1] = platform_get_resource(pdev, IORESOURCE_MEM,
 					     DPAA_PORTAL_CI);
 	if (!addr_phys[1]) {
 		dev_err(dev, "Can't get %pOF property 'reg::CI'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 
 	pcfg->cpu = -1;
@@ -128,7 +137,7 @@ static int bman_portal_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(dev, "Can't get %pOF IRQ'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 	pcfg->irq = irq;
 
@@ -156,6 +165,9 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 
 	cpumask_set_cpu(cpu, &portal_cpus);
+	if (!__bman_portals_probed &&
+	    cpumask_weight(&portal_cpus) == num_online_cpus())
+		__bman_portals_probed = 1;
 	spin_unlock(&bman_lock);
 	pcfg->cpu = cpu;
 
@@ -175,6 +187,8 @@ static int bman_portal_probe(struct platform_device *pdev)
 err_ioremap2:
 	memunmap(pcfg->addr_virt_ce);
 err_ioremap1:
+	 __bman_portals_probed = -1;
+
 	return -ENXIO;
 }
 
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index bce56da2b01f..11ba6c77c0d6 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -39,6 +39,7 @@ EXPORT_SYMBOL(qman_dma_portal);
 #define CONFIG_FSL_DPA_PIRQ_FAST  1
 
 static struct cpumask portal_cpus;
+static int __qman_portals_probed;
 /* protect qman global registers and global data shared among portals */
 static DEFINE_SPINLOCK(qman_lock);
 
@@ -221,6 +222,12 @@ static int qman_online_cpu(unsigned int cpu)
 	return 0;
 }
 
+int qman_portals_probed(void)
+{
+	return __qman_portals_probed;
+}
+EXPORT_SYMBOL_GPL(qman_portals_probed);
+
 static int qman_portal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -240,8 +247,10 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
-	if (!pcfg)
+	if (!pcfg) {
+		__qman_portals_probed = -1;
 		return -ENOMEM;
+	}
 
 	pcfg->dev = dev;
 
@@ -249,19 +258,20 @@ static int qman_portal_probe(struct platform_device *pdev)
 					     DPAA_PORTAL_CE);
 	if (!addr_phys[0]) {
 		dev_err(dev, "Can't get %pOF property 'reg::CE'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 
 	addr_phys[1] = platform_get_resource(pdev, IORESOURCE_MEM,
 					     DPAA_PORTAL_CI);
 	if (!addr_phys[1]) {
 		dev_err(dev, "Can't get %pOF property 'reg::CI'\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 
 	err = of_property_read_u32(node, "cell-index", &val);
 	if (err) {
 		dev_err(dev, "Can't get %pOF property 'cell-index'\n", node);
+		__qman_portals_probed = -1;
 		return err;
 	}
 	pcfg->channel = val;
@@ -269,7 +279,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(dev, "Can't get %pOF IRQ\n", node);
-		return -ENXIO;
+		goto err_ioremap1;
 	}
 	pcfg->irq = irq;
 
@@ -314,6 +324,9 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 
 	cpumask_set_cpu(cpu, &portal_cpus);
+	if (!__qman_portals_probed &&
+	    cpumask_weight(&portal_cpus) == num_online_cpus())
+		__qman_portals_probed = 1;
 	spin_unlock(&qman_lock);
 	pcfg->cpu = cpu;
 
@@ -338,6 +351,8 @@ static int qman_portal_probe(struct platform_device *pdev)
 err_ioremap2:
 	memunmap(pcfg->addr_virt_ce);
 err_ioremap1:
+	__qman_portals_probed = -1;
+
 	return -ENXIO;
 }
 
diff --git a/include/soc/fsl/bman.h b/include/soc/fsl/bman.h
index 5b99cb2ea5ef..173e4049d963 100644
--- a/include/soc/fsl/bman.h
+++ b/include/soc/fsl/bman.h
@@ -133,5 +133,13 @@ int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num);
  * failed to probe or 0 if the bman driver did not probed yet.
  */
 int bman_is_probed(void);
+/**
+ * bman_portals_probed - Check if all cpu bound bman portals are probed
+ *
+ * Returns 1 if all the required cpu bound bman portals successfully probed,
+ * -1 if probe errors appeared or 0 if the bman portals did not yet finished
+ * probing.
+ */
+int bman_portals_probed(void);
 
 #endif	/* __FSL_BMAN_H */
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 5cc7af06c1ba..aa31c05a103a 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -1194,6 +1194,15 @@ int qman_release_cgrid(u32 id);
  */
 int qman_is_probed(void);
 
+/**
+ * qman_portals_probed - Check if all cpu bound qman portals are probed
+ *
+ * Returns 1 if all the required cpu bound qman portals successfully probed,
+ * -1 if probe errors appeared or 0 if the qman portals did not yet finished
+ * probing.
+ */
+int qman_portals_probed(void);
+
 /**
  * qman_dqrr_get_ithresh - Get coalesce interrupt threshold
  * @portal: portal to get the value for
-- 
2.17.1

