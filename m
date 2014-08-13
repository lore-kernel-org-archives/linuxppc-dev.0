Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 282F91A01F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 23:55:36 +1000 (EST)
Message-ID: <53EB6E41.4040808@freescale.com>
Date: Wed, 13 Aug 2014 16:55:13 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl_msi: support vmpic msi with mpic 4.3
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new MSI block in MPIC 4.3 added the MSIIR1 register,
with a different layout, in order to support 16 MSIR
registers. The msi binding was also updated so that
the "reg" reflects the newly introduced MSIIR1 register.
Virtual machines advertise these msi nodes by using the
compatible "fsl,vmpic-msi-v4.3" so add support for it.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 77efbae..9fadc6e 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -180,7 +180,8 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	np = of_parse_phandle(hose->dn, "fsl,msi", 0);
 	if (np) {
 		if (of_device_is_compatible(np, "fsl,mpic-msi") ||
-		    of_device_is_compatible(np, "fsl,vmpic-msi"))
+		    of_device_is_compatible(np, "fsl,vmpic-msi") ||
+		    of_device_is_compatible(np, "fsl,vmpic-msi-v4.3"))
 			phandle = np->phandle;
 		else {
 			dev_err(&pdev->dev,
@@ -466,7 +467,8 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 
 	p = of_get_property(dev->dev.of_node, "msi-available-ranges", &len);
 
-	if (of_device_is_compatible(dev->dev.of_node, "fsl,mpic-msi-v4.3")) {
+	if (of_device_is_compatible(dev->dev.of_node, "fsl,mpic-msi-v4.3") ||
+	    of_device_is_compatible(dev->dev.of_node, "fsl,vmpic-msi-v4.3")) {
 		msi->srs_shift = MSIIR1_SRS_SHIFT;
 		msi->ibs_shift = MSIIR1_IBS_SHIFT;
 		if (p)
@@ -572,6 +574,10 @@ static const struct of_device_id fsl_of_msi_ids[] = {
 		.compatible = "fsl,vmpic-msi",
 		.data = &vmpic_msi_feature,
 	},
+	{
+		.compatible = "fsl,vmpic-msi-v4.3",
+		.data = &vmpic_msi_feature,
+	},
 #endif
 	{}
 };
-- 
1.9.2
