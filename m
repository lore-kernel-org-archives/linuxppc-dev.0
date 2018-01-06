Return-Path: <festevam@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zDMf92FRtzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jan 2018 00:22:40 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id m193so935644qke.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jan 2018 05:22:40 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: leoyang.li@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org, yangbo.lu@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] soc/fsl/guts: Add a NULL check for devm_kasprintf()
Date: Sat,  6 Jan 2018 11:22:34 -0200
Message-Id: <1515244954-8374-1-git-send-email-festevam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Fabio Estevam <fabio.estevam@nxp.com>

devm_kasprintf() may fail, so we should better add a NULL check
and propagate an error on failure.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index d89a6a8..82251b4 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -167,10 +167,16 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	} else {
 		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL, "QorIQ");
 	}
+	if (!soc_dev_attr.family)
+		return -ENOMEM;
 	soc_dev_attr.soc_id = devm_kasprintf(dev, GFP_KERNEL,
 					     "svr:0x%08x", svr);
+	if (!soc_dev_attr.soc_id)
+		return -ENOMEM;
 	soc_dev_attr.revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
 					       (svr >>  4) & 0xf, svr & 0xf);
+	if (!soc_dev_attr.revision)
+		return -ENOMEM;
 
 	soc_dev = soc_device_register(&soc_dev_attr);
 	if (IS_ERR(soc_dev))
-- 
2.7.4
