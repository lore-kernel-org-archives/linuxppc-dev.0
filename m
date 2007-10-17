Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D838FDDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 05:58:06 +1000 (EST)
Date: Wed, 17 Oct 2007 23:57:46 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: leoli@freescale.com, jgarzik@pobox.com, paulus@samba.org
Subject: [PATCH][NET] gianfar: fix obviously wrong #ifdef CONFIG_GFAR_NAPI
	placement
Message-ID: <20071017195746.GA15592@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Erroneous #ifdef introduced by 293c8513398657f6263fcdb03c87f2760cf61be4
causing NAPI-less ethernet malfunctioning.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

if (...)
#if
	...;
#endif

good candidate for checkpatch?

 drivers/net/gianfar.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index cc288d8..38268d7 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -956,10 +956,12 @@ static int gfar_enet_open(struct net_device *dev)
 	}
 
 	err = startup_gfar(dev);
-	if (err)
+	if (err) {
 #ifdef CONFIG_GFAR_NAPI
 		napi_disable(&priv->napi);
 #endif
+		return err;
+	}
 
 	netif_start_queue(dev);
 
-- 
1.5.0.6
