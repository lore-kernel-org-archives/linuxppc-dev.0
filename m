Return-Path: <geoff@infradead.org>
Message-Id: <497c718e763173b28ffe4e50258cb257c362d404.1442259101.git.geoff@infradead.org>
In-Reply-To: <cover.1442259101.git.geoff@infradead.org>
References: <cover.1442259101.git.geoff@infradead.org>
From: Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 2/3] drivers/ps3: Fix ps3-vuart null dereference
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 cbe-oss-dev@lists.ozlabs.org, Colin Ian King <colin.king@canonical.com>
Sender: Geoff Levand <geoff@infradead.org>
Date: Mon, 14 Sep 2015 19:35:04 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the unlikely event that drv is null, the current code will
perform a null pointer dereference with it when printing a dev_dbg
message.  Instead, the BUG_ON check on drv should be performed
before we emit the dev_dbg message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Geoff Levand <geoff@infradead.org>
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
2.1.0
