Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z8Gpj6TZ4zDqgs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Dec 2017 08:30:51 +1100 (AEDT)
To: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Zhao Qiang <qiang.zhao@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] wan/fsl_ucc_hdlc: Delete an error message for a failed memory
 allocation in ucc_hdlc_probe()
Message-ID: <92380576-f944-6240-eba7-ed0e084ba65a@users.sourceforge.net>
Date: Sat, 30 Dec 2017 22:30:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 30 Dec 2017 22:25:44 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 33df76405b86..98f8be206bae 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1082,7 +1082,6 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 		utdm = kzalloc(sizeof(*utdm), GFP_KERNEL);
 		if (!utdm) {
 			ret = -ENOMEM;
-			dev_err(&pdev->dev, "No mem to alloc ucc tdm data\n");
 			goto free_uhdlc_priv;
 		}
 		uhdlc_priv->utdm = utdm;
-- 
2.15.1
