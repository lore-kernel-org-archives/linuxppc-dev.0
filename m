Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0080.outbound.protection.outlook.com [104.47.36.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGyJP4035zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 07:30:29 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>, <robin.murphy@arm.com>
CC: <madalin.bucur@nxp.com>, <roy.pledge@nxp.com>
Subject: [PATCH v3 07/11] soc/fsl/qbman: Rework ioremap() calls for ARM/PPC
Date: Mon, 1 May 2017 17:30:09 -0400
Message-ID: <1493674213-963-8-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

Rework ioremap() for PPC and ARM. The PPC devices require a
non-coherent mapping while ARM will work with a non-cachable/write
combine mapping.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman_portal.c | 12 +++++++++---
 drivers/soc/fsl/qbman/qman_portal.c | 12 +++++++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 8354d4d..d37f563 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -125,7 +125,14 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 	pcfg->irq = irq;
 
-	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
+#ifdef CONFIG_PPC
+	/* PPC requires a cacheable/non-coherent mapping of the portal */
+	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),
+			  (pgprot_val(PAGE_KERNEL) & ~_PAGE_COHERENT));
+#else
+	/* For ARM we can use write combine mapping. */
+	va = ioremap_wc(addr_phys[0]->start, resource_size(addr_phys[0]));
+#endif
 	if (!va) {
 		dev_err(dev, "ioremap::CE failed\n");
 		goto err_ioremap1;
@@ -133,8 +140,7 @@ static int bman_portal_probe(struct platform_device *pdev)
 
 	pcfg->addr_virt[DPAA_PORTAL_CE] = va;
 
-	va = ioremap_prot(addr_phys[1]->start, resource_size(addr_phys[1]),
-			  _PAGE_GUARDED | _PAGE_NO_CACHE);
+	va = ioremap(addr_phys[1]->start, resource_size(addr_phys[1]));
 	if (!va) {
 		dev_err(dev, "ioremap::CI failed\n");
 		goto err_ioremap2;
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index adbaa30..b5463e4 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -265,7 +265,14 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 	pcfg->irq = irq;
 
-	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
+#ifdef CONFIG_PPC
+	/* PPC requires a cacheable/non-coherent mapping of the portal */
+	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),
+			  (pgprot_val(PAGE_KERNEL) & ~_PAGE_COHERENT));
+#else
+	/* For ARM we can use write combine mapping. */
+	va = ioremap_wc(addr_phys[0]->start, resource_size(addr_phys[0]));
+#endif
 	if (!va) {
 		dev_err(dev, "ioremap::CE failed\n");
 		goto err_ioremap1;
@@ -273,8 +280,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 
 	pcfg->addr_virt[DPAA_PORTAL_CE] = va;
 
-	va = ioremap_prot(addr_phys[1]->start, resource_size(addr_phys[1]),
-			  _PAGE_GUARDED | _PAGE_NO_CACHE);
+	va = ioremap(addr_phys[1]->start, resource_size(addr_phys[1]));
 	if (!va) {
 		dev_err(dev, "ioremap::CI failed\n");
 		goto err_ioremap2;
-- 
2.7.4
