Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A79FA1A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 20:21:56 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Geoff Levand <geoff@infradead.org>,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ps3-vuart: BUG_ON on null drv before dereferencing it on
 dev_dbg
Date: Tue,  1 Sep 2015 11:21:16 +0100
Message-Id: <1441102876-26978-1-git-send-email-colin.king@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

On the unlikely event that drv is null, the current code will
perform a null pointer dereference with it when printing a dev_dbg
message.  Instead, the BUG_ON check on drv should be performed
before we emit the dev_dbg message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ps3/ps3-vuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index d6db822..632701a 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -1000,12 +1000,11 @@ static int ps3_vuart_probe(struct ps3_system_bus_device *dev)
 	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
 
 	drv = ps3_system_bus_dev_to_vuart_drv(dev);
+	BUG_ON(!drv);
 
 	dev_dbg(&dev->core, "%s:%d: (%s)\n", __func__, __LINE__,
 		drv->core.core.name);
 
-	BUG_ON(!drv);
-
 	if (dev->port_number >= PORT_COUNT) {
 		BUG();
 		return -EINVAL;
-- 
2.5.0
