Return-Path: <xypron.glpk@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2KkQ4TtQzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 21:19:58 +1000 (AEST)
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] wan/fsl_ucc_hdlc: avoid possible NULL pointer dereference
Date: Sun, 31 Jul 2016 13:14:23 +0200
Message-Id: <1469963663-3005-1-git-send-email-xypron.glpk@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All assignments to components of priv should only
occur after the check if prif is NULL.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 2fc50ec..6f04445 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -862,7 +862,7 @@ static int uhdlc_suspend(struct device *dev)
 static int uhdlc_resume(struct device *dev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(dev);
-	struct ucc_tdm *utdm = priv->utdm;
+	struct ucc_tdm *utdm;
 	struct ucc_tdm_info *ut_info;
 	struct ucc_fast __iomem *uf_regs;
 	struct ucc_fast_private *uccf;
@@ -877,6 +877,7 @@ static int uhdlc_resume(struct device *dev)
 	if (!netif_running(priv->ndev))
 		return 0;
 
+	utdm = priv->utdm;
 	ut_info = priv->ut_info;
 	uf_info = &ut_info->uf_info;
 	uf_regs = priv->uf_regs;
-- 
2.8.1
