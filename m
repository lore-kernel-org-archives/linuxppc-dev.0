Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 10ED9DDEE4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 20:59:51 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: netdev@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH] ibm_emac: Correctly detect old link speed
Date: Wed, 16 May 2007 13:00:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200705161300.08521.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a bug where the link speed change was not
detected correctly. This occured on a 440SPe (EMAC4) system
where the old link speed was 100Mbps and the new link speed
is 1000Mbps.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 1e2a6085bbb6bd384e0812b6e9c62d18d14e1c0f
tree f441a914c9d66fb00fcde1e4bd7e02effba20dc7
parent 7b104bcb8e460e45a1aebe3da9b86aacdb4cab12
author Stefan Roese <sr@denx.de> Wed, 16 May 2007 12:54:40 +0200
committer Stefan Roese <sr@denx.de> Wed, 16 May 2007 12:54:40 +0200

 drivers/net/ibm_emac/ibm_emac_core.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
index 50035eb..ab38727 100644
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -926,12 +926,18 @@ static int emac_link_differs(struct ocp_enet_private *dev)
 	int duplex = r & EMAC_MR1_FDE ? DUPLEX_FULL : DUPLEX_HALF;
 	int speed, pause, asym_pause;
 
-	if (r & (EMAC_MR1_MF_1000 | EMAC_MR1_MF_1000GPCS))
-		speed = SPEED_1000;
-	else if (r & EMAC_MR1_MF_100)
-		speed = SPEED_100;
-	else
-		speed = SPEED_10;
+	switch (r & EMAC_MR1_MF_MASK) {
+	case EMAC_MR1_MF_1000:
+	case EMAC_MR1_MF_1000GPCS:
+		speed = 1000;
+		break;
+	case EMAC_MR1_MF_10:
+		speed = 10;
+		break;
+	case EMAC_MR1_MF_100:
+	default:
+		speed = 100;
+	}
 
 	switch (r & (EMAC_MR1_EIFC | EMAC_MR1_APP)) {
 	case (EMAC_MR1_EIFC | EMAC_MR1_APP):
