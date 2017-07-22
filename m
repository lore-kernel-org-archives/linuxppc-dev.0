Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDzsC6Bk7zDqpV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 17:33:51 +1000 (AEST)
Date: Sat, 22 Jul 2017 10:33:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] fsl/qe: NULL dereference on error in ucc_of_parse_tdm()
Message-ID: <20170722073335.tb6byaaarqvloh3a@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If "pdev = of_find_device_by_node(np2);" fails then it would lead to a
NULL dereference.  This function is called from probe() and we're using
managed resources so we can just return without doing a manual cleanup.

Fixes: 35ef1c20fdb2 ("fsl/qe: Add QE TDM lib")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f744c214f680..ec7a853053c3 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -139,32 +139,25 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	of_node_put(np2);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	utdm->si_regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(utdm->si_regs)) {
-		ret = PTR_ERR(utdm->si_regs);
-		goto err_miss_siram_property;
-	}
+	if (IS_ERR(utdm->si_regs))
+		return PTR_ERR(utdm->si_regs);
 
 	np2 = of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-siram");
-	if (!np2) {
-		ret = -EINVAL;
-		goto err_miss_siram_property;
-	}
+	if (!np2)
+		return -EINVAL;
 
 	pdev = of_find_device_by_node(np2);
 	if (!pdev) {
-		ret = -EINVAL;
 		pr_err("%s: failed to lookup pdev\n", np2->name);
 		of_node_put(np2);
-		goto err_miss_siram_property;
+		return -EINVAL;
 	}
 
 	of_node_put(np2);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	utdm->siram = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(utdm->siram)) {
-		ret = PTR_ERR(utdm->siram);
-		goto err_miss_siram_property;
-	}
+	if (IS_ERR(utdm->siram))
+		return PTR_ERR(utdm->siram);
 
 	if (siram_init_flag == 0) {
 		memset_io(utdm->siram, 0,  resource_size(res));
@@ -172,10 +165,6 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	}
 
 	return ret;
-
-err_miss_siram_property:
-	devm_iounmap(&pdev->dev, utdm->si_regs);
-	return ret;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
 
