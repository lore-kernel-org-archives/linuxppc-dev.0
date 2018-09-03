Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 423qWK5QjDzF37Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 22:47:54 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 joakim.tjernlund@infinera.com
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH v3 1/6] net/wan/fsl_ucc_hdlc: allow ucc index up to 7
Date: Mon,  3 Sep 2018 14:47:25 +0200
Message-Id: <20180903124730.1551-2-david.gounaris@infinera.com>
In-Reply-To: <20180903124730.1551-1-david.gounaris@infinera.com>
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180903124730.1551-1-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a need to allow higher indexes to be
able to support MPC83xx platforms. (UCC1-UCC8)

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 33df76405b86..485764c537d9 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1016,7 +1016,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	}
 
 	ucc_num = val - 1;
-	if ((ucc_num > 3) || (ucc_num < 0)) {
+	if (ucc_num > (UCC_MAX_NUM - 1) || ucc_num < 0) {
 		dev_err(&pdev->dev, ": Invalid UCC num\n");
 		return -EINVAL;
 	}
-- 
2.13.6
