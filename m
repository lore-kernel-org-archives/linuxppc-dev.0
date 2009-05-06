Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1E870DDDA2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:15:24 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/12] fs_enet: Use defines to set driver tunables.
Date: Wed,  6 May 2009 22:15:08 +0200
Message-Id: <1241640919-4650-2-git-send-email-wd@denx.de>
In-Reply-To: <1241640919-4650-1-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
Cc: netdev@vger.kernel.org, Piotr Ziecik <kosmo@semihalf.com>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Piotr Ziecik <kosmo@semihalf.com>

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: <netdev@vger.kernel.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 drivers/net/fs_enet/fs_enet-main.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index a9cbc31..f996a1a 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -46,6 +46,15 @@
 
 #include "fs_enet.h"
 
+/* Driver tunables */
+
+#define ENET_RX_RING_SIZE	32
+#define ENET_TX_RING_SIZE	32
+#define ENET_RX_COPYBREAK	240
+
+#define ENET_USE_NAPI		1
+#define ENET_NAPI_WEIGHT	17
+
 /*************************************************/
 
 MODULE_AUTHOR("Pantelis Antoniou <panto@intracom.gr>");
@@ -1057,11 +1066,11 @@ static int __devinit fs_enet_probe(struct of_device *ofdev,
 		fpi->cp_command = *data;
 	}
 
-	fpi->rx_ring = 32;
-	fpi->tx_ring = 32;
-	fpi->rx_copybreak = 240;
-	fpi->use_napi = 1;
-	fpi->napi_weight = 17;
+	fpi->rx_ring = ENET_RX_RING_SIZE;
+	fpi->tx_ring = ENET_TX_RING_SIZE;
+	fpi->rx_copybreak = ENET_RX_COPYBREAK;
+	fpi->use_napi = ENET_USE_NAPI;
+	fpi->napi_weight = ENET_NAPI_WEIGHT;
 
 	ret = find_phy(ofdev->node, fpi);
 	if (ret)
-- 
1.6.0.6
