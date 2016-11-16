Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0082.outbound.protection.outlook.com [104.47.32.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4F10rBzDvXg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:44 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 04/17] soc/qbman: Fix resource leak on portal probing error
 path
Date: Wed, 16 Nov 2016 16:40:17 +0200
Message-ID: <1479307230-16650-5-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
References: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In case init_pcfg() returns with error the CI region
must be unmapped too.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/bman_portal.c | 17 ++++++++++++-----
 drivers/soc/fsl/qbman/qman_portal.c | 17 ++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 6579cc1..dd3f5d7 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -146,15 +146,19 @@ static int bman_portal_probe(struct platform_device *pdev)
 	pcfg->irq = irq;
 
 	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
-	if (!va)
+	if (!va) {
+		dev_err(dev, "ioremap::CE failed\n");
 		goto err_ioremap1;
+	}
 
 	pcfg->addr_virt[DPAA_PORTAL_CE] = va;
 
 	va = ioremap_prot(addr_phys[1]->start, resource_size(addr_phys[1]),
 			  _PAGE_GUARDED | _PAGE_NO_CACHE);
-	if (!va)
+	if (!va) {
+		dev_err(dev, "ioremap::CI failed\n");
 		goto err_ioremap2;
+	}
 
 	pcfg->addr_virt[DPAA_PORTAL_CI] = va;
 
@@ -170,8 +174,10 @@ static int bman_portal_probe(struct platform_device *pdev)
 	spin_unlock(&bman_lock);
 	pcfg->cpu = cpu;
 
-	if (!init_pcfg(pcfg))
-		goto err_ioremap2;
+	if (!init_pcfg(pcfg)) {
+		dev_err(dev, "portal init failed\n");
+		goto err_portal_init;
+	}
 
 	/* clear irq affinity if assigned cpu is offline */
 	if (!cpu_online(cpu))
@@ -179,10 +185,11 @@ static int bman_portal_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_portal_init:
+	iounmap(pcfg->addr_virt[DPAA_PORTAL_CI]);
 err_ioremap2:
 	iounmap(pcfg->addr_virt[DPAA_PORTAL_CE]);
 err_ioremap1:
-	dev_err(dev, "ioremap failed\n");
 	return -ENXIO;
 }
 
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index 0c3e8ad..6651168 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -280,15 +280,19 @@ static int qman_portal_probe(struct platform_device *pdev)
 	pcfg->irq = irq;
 
 	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
-	if (!va)
+	if (!va) {
+		dev_err(dev, "ioremap::CE failed\n");
 		goto err_ioremap1;
+	}
 
 	pcfg->addr_virt[DPAA_PORTAL_CE] = va;
 
 	va = ioremap_prot(addr_phys[1]->start, resource_size(addr_phys[1]),
 			  _PAGE_GUARDED | _PAGE_NO_CACHE);
-	if (!va)
+	if (!va) {
+		dev_err(dev, "ioremap::CI failed\n");
 		goto err_ioremap2;
+	}
 
 	pcfg->addr_virt[DPAA_PORTAL_CI] = va;
 
@@ -306,8 +310,10 @@ static int qman_portal_probe(struct platform_device *pdev)
 	spin_unlock(&qman_lock);
 	pcfg->cpu = cpu;
 
-	if (!init_pcfg(pcfg))
-		goto err_ioremap2;
+	if (!init_pcfg(pcfg)) {
+		dev_err(dev, "portal init failed\n");
+		goto err_portal_init;
+	}
 
 	/* clear irq affinity if assigned cpu is offline */
 	if (!cpu_online(cpu))
@@ -315,10 +321,11 @@ static int qman_portal_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_portal_init:
+	iounmap(pcfg->addr_virt[DPAA_PORTAL_CI]);
 err_ioremap2:
 	iounmap(pcfg->addr_virt[DPAA_PORTAL_CE]);
 err_ioremap1:
-	dev_err(dev, "ioremap failed\n");
 	return -ENXIO;
 }
 
-- 
1.7.11.7
