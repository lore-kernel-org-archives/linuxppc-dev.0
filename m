Return-Path: <ljaenicke@innominate.com>
Received: from home.innominate.com (home.innominate.com [77.245.32.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 049702C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 03:58:35 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by home.innominate.com (Postfix) with ESMTP id 5354E2248
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 19:49:16 +0200 (CEST)
Received: from home.innominate.com ([127.0.0.1])
 by localhost (innominate.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7hj0wOcXW6b5 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  1 Aug 2013 19:49:16 +0200 (CEST)
Received: from lutz.bln.innominate.local (lutz.bln.innominate.local
 [10.1.0.160])
 by home.innominate.com (Postfix) with ESMTP id 4553D2101
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 19:49:16 +0200 (CEST)
From: Lutz Jaenicke <ljaenicke@innominate.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] net/fsl_pq_mdio: fix handling of TBIPA register
Date: Thu,  1 Aug 2013 19:49:15 +0200
Message-Id: <1375379355-18594-1-git-send-email-ljaenicke@innominate.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TBIPA register is part of gianfar's full register set. When starting
from the MII registers, the start address of struct gfar needs to
be determined via container_of().
Experienced with mpc8313 and "fsl,gianfar-mdio" device tree entries.

Signed-off-by: Lutz Jaenicke <ljaenicke@innominate.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index c93a056..9485fdb 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -193,7 +193,8 @@ static int fsl_pq_mdio_reset(struct mii_bus *bus)
  */
 static uint32_t __iomem *get_gfar_tbipa(void __iomem *p)
 {
-	struct gfar __iomem *enet_regs = p;
+	struct gfar __iomem *enet_regs = 
+		container_of(p, struct gfar, gfar_mii_regs);
 
 	return &enet_regs->tbipa;
 }
-- 
1.7.10.4
