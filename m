Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id BEABDDDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 02:12:19 +1100 (EST)
Date: Thu, 19 Mar 2009 18:12:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH -next] gianfar: Fix build with CONFIG_PM enabled
Message-ID: <20090319151217.GA11465@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: netdev@vger.kernel.org, Andy Fleming <afleming@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit 4826857f1bf07f9c0f1495e9b05d125552c88a85 ("gianfar: pass the
proper dev to DMA ops") introduced this build breakage:

  CC      drivers/net/gianfar.o
drivers/net/gianfar.c: In function 'gfar_suspend':
drivers/net/gianfar.c:552: error: 'struct gfar_private' has no member named 'dev'
drivers/net/gianfar.c: In function 'gfar_resume':
drivers/net/gianfar.c:601: error: 'struct gfar_private' has no member named 'dev'
make[2]: *** [drivers/net/gianfar.o] Error 1

Fix this by converting suspend and resume routines to use
gfar_private->ndev.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/gianfar.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 8659833..8a51df0 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -549,7 +549,7 @@ static int gfar_remove(struct of_device *ofdev)
 static int gfar_suspend(struct of_device *ofdev, pm_message_t state)
 {
 	struct gfar_private *priv = dev_get_drvdata(&ofdev->dev);
-	struct net_device *dev = priv->dev;
+	struct net_device *dev = priv->ndev;
 	unsigned long flags;
 	u32 tempval;
 
@@ -598,7 +598,7 @@ static int gfar_suspend(struct of_device *ofdev, pm_message_t state)
 static int gfar_resume(struct of_device *ofdev)
 {
 	struct gfar_private *priv = dev_get_drvdata(&ofdev->dev);
-	struct net_device *dev = priv->dev;
+	struct net_device *dev = priv->ndev;
 	unsigned long flags;
 	u32 tempval;
 	int magic_packet = priv->wol_en &&
-- 
1.5.6.5
