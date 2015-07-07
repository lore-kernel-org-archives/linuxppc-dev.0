Return-Path: <xerofoify@gmail.com>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88DEB1A115F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 04:07:21 +1000 (AEST)
Received: by iecvh10 with SMTP id vh10so140038709iec.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2015 11:07:18 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: leoli@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] freescale:Make receive and transmit functions have a return
 type of void
Date: Tue,  7 Jul 2015 14:07:12 -0400
Message-Id: <1436292432-1933-1-git-send-email-xerofoify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes various receive and transmit functions that always run
successfully to be declared to have a return of void for the driver
file, ucc_geth.c.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 4dd40e0..78ebd73 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1398,7 +1398,7 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 	return 0;
 }
 
-static int ugeth_graceful_stop_tx(struct ucc_geth_private *ugeth)
+static void ugeth_graceful_stop_tx(struct ucc_geth_private *ugeth)
 {
 	struct ucc_fast_private *uccf;
 	u32 cecr_subblock;
@@ -1424,11 +1424,9 @@ static int ugeth_graceful_stop_tx(struct ucc_geth_private *ugeth)
 	} while (!(temp & UCC_GETH_UCCE_GRA) && --i);
 
 	uccf->stopped_tx = 1;
-
-	return 0;
 }
 
-static int ugeth_graceful_stop_rx(struct ucc_geth_private *ugeth)
+static void ugeth_graceful_stop_rx(struct ucc_geth_private *ugeth)
 {
 	struct ucc_fast_private *uccf;
 	u32 cecr_subblock;
@@ -1456,11 +1454,9 @@ static int ugeth_graceful_stop_rx(struct ucc_geth_private *ugeth)
 	} while (!(temp & GRACEFUL_STOP_ACKNOWLEDGE_RX) && --i);
 
 	uccf->stopped_rx = 1;
-
-	return 0;
 }
 
-static int ugeth_restart_tx(struct ucc_geth_private *ugeth)
+static void ugeth_restart_tx(struct ucc_geth_private *ugeth)
 {
 	struct ucc_fast_private *uccf;
 	u32 cecr_subblock;
@@ -1471,8 +1467,6 @@ static int ugeth_restart_tx(struct ucc_geth_private *ugeth)
 	    ucc_fast_get_qe_cr_subblock(ugeth->ug_info->uf_info.ucc_num);
 	qe_issue_cmd(QE_RESTART_TX, cecr_subblock, QE_CR_PROTOCOL_ETHERNET, 0);
 	uccf->stopped_tx = 0;
-
-	return 0;
 }
 
 static int ugeth_restart_rx(struct ucc_geth_private *ugeth)
-- 
2.1.4
