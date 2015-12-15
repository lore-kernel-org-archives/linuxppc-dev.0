Return-Path: <martin.roth@motorolasolutions.com>
Received: from mx0b-0019e102.pphosted.com (mx0b-0019e102.pphosted.com
 [67.231.157.237])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E2EB1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:29:02 +1100 (AEDT)
Received: from pps.filterd (m0074418.ppops.net [127.0.0.1])
 by mx0b-0019e102.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
 tBF2CrVB008403
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:18:04 -0600
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by mx0b-0019e102.pphosted.com with ESMTP id 1yt2n0h104-1
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:18:04 -0600
Received: by mail-wm0-f44.google.com with SMTP id n186so5024670wmn.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 18:18:04 -0800 (PST)
From: Martin Roth <martin.roth@motorolasolutions.com>
To: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Martin Roth <martin.roth@motorolasolutions.com>
Subject: [PATCH] 82xx: FCC: Fixing a bug causing to FCC port lock-up
Date: Tue, 15 Dec 2015 04:17:53 +0200
Message-Id: <1450145874-9750-1-git-send-email-martin.roth@motorolasolutions.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch fixes FCC port lock-up, which occurs as a result of a bug
during underrun/collision handling. Within the tx_startup() function
in mac-fcc.c, the address of last BD is not calculated correctly.
As a result of wrong calculation of the last BD address, the next
transmitted BD may be set to an area out of the transmit BD ring.
This actually causes to port lock-up and it is not recoverable.

Signed-off-by: Martin Roth <martin.roth@motorolasolutions.com>
---
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
index 08f5b91..52e0091 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
@@ -552,7 +552,7 @@ static void tx_restart(struct net_device *dev)
 	cbd_t __iomem *prev_bd;
 	cbd_t __iomem *last_tx_bd;
 
-	last_tx_bd = fep->tx_bd_base + (fpi->tx_ring * sizeof(cbd_t));
+	last_tx_bd = fep->tx_bd_base + ((fpi->tx_ring - 1) * sizeof(cbd_t));
 
 	/* get the current bd held in TBPTR  and scan back from this point */
 	recheck_bd = curr_tbptr = (cbd_t __iomem *)
-- 
1.7.9.5
