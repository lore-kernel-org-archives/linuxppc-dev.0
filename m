Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 67481B7FED
	for <linuxppc-dev@ozlabs.org>; Sat, 15 May 2010 00:52:55 +1000 (EST)
Date: Fri, 14 May 2010 18:27:36 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] gianfar: Remove legacy PM callbacks
Message-ID: <20100514142736.GB13137@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These callbacks were needed because dev_pm_ops support for OF
platform devices was in the powerpc tree, and the patch that
added dev_pm_ops for gianfar driver was in the netdev tree. Now
that netdev and powerpc trees have merged into Linus' tree, we
can remove the legacy hooks.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/net/gianfar.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 5d3763f..fb23f04 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1288,21 +1288,9 @@ static struct dev_pm_ops gfar_pm_ops = {
 
 #define GFAR_PM_OPS (&gfar_pm_ops)
 
-static int gfar_legacy_suspend(struct of_device *ofdev, pm_message_t state)
-{
-	return gfar_suspend(&ofdev->dev);
-}
-
-static int gfar_legacy_resume(struct of_device *ofdev)
-{
-	return gfar_resume(&ofdev->dev);
-}
-
 #else
 
 #define GFAR_PM_OPS NULL
-#define gfar_legacy_suspend NULL
-#define gfar_legacy_resume NULL
 
 #endif
 
@@ -3055,8 +3043,6 @@ static struct of_platform_driver gfar_driver = {
 
 	.probe = gfar_probe,
 	.remove = gfar_remove,
-	.suspend = gfar_legacy_suspend,
-	.resume = gfar_legacy_resume,
 	.driver.pm = GFAR_PM_OPS,
 };
 
-- 
1.7.0.5
