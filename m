Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB7342C014D
 for <linuxppc-dev@ozlabs.org>; Mon, 19 Aug 2013 23:18:37 +1000 (EST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: powermac: fix return path on error
Date: Mon, 19 Aug 2013 15:18:15 +0200
Message-Id: <1376918295-6961-1-git-send-email-wsa@the-dreams.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to bail out immediately if i2c_add_adapter failed and not try to
register child nodes with a nilled adapter structure.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-powermac.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 8dc90da..bb81773 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -446,6 +446,7 @@ static int i2c_powermac_probe(struct platform_device *dev)
 		printk(KERN_ERR "i2c-powermac: Adapter %s registration "
 		       "failed\n", adapter->name);
 		memset(adapter, 0, sizeof(*adapter));
+		return rc;
 	}
 
 	printk(KERN_INFO "PowerMac i2c bus %s registered\n", adapter->name);
@@ -455,7 +456,7 @@ static int i2c_powermac_probe(struct platform_device *dev)
 	 */
 	i2c_powermac_register_devices(adapter, bus);
 
-	return rc;
+	return 0;
 }
 
 static struct platform_driver i2c_powermac_driver = {
-- 
1.7.10.4
