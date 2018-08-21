Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 41vv6w4dY1zF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 01:02:46 +1000 (AEST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] i2c: remove deprecated attach_adapter callback
Date: Tue, 21 Aug 2018 17:02:40 +0200
Message-Id: <20180821150240.19964-3-wsa@the-dreams.de>
In-Reply-To: <20180821150240.19964-1-wsa@the-dreams.de>
References: <20180821150240.19964-1-wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There aren't any users left. Remove this callback from the 2.4 times.
Phew, finally, that took years to reach...

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-base.c | 11 +----------
 include/linux/i2c.h         |  6 ------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5a937109a289..f15737763608 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -62,7 +62,7 @@
 
 /*
  * core_lock protects i2c_adapter_idr, and guarantees that device detection,
- * deletion of detected devices, and attach_adapter calls are serialized
+ * deletion of detected devices are serialized
  */
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
@@ -1124,15 +1124,6 @@ static int i2c_do_add_adapter(struct i2c_driver *driver,
 	/* Detect supported devices on that bus, and instantiate them */
 	i2c_detect(adap, driver);
 
-	/* Let legacy drivers scan this bus for matching devices */
-	if (driver->attach_adapter) {
-		dev_warn(&adap->dev, "%s: attach_adapter method is deprecated\n",
-			 driver->driver.name);
-		dev_warn(&adap->dev,
-			 "Please use another way to instantiate your i2c_client\n");
-		/* We ignore the return code; if it fails, too bad */
-		driver->attach_adapter(adap);
-	}
 	return 0;
 }
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 36f357ecdf67..b79387fd57da 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -231,7 +231,6 @@ enum i2c_alert_protocol {
 /**
  * struct i2c_driver - represent an I2C device driver
  * @class: What kind of i2c device we instantiate (for detect)
- * @attach_adapter: Callback for bus addition (deprecated)
  * @probe: Callback for device binding - soon to be deprecated
  * @probe_new: New callback for device binding
  * @remove: Callback for device unbinding
@@ -268,11 +267,6 @@ enum i2c_alert_protocol {
 struct i2c_driver {
 	unsigned int class;
 
-	/* Notifies the driver that a new bus has appeared. You should avoid
-	 * using this, it will be removed in a near future.
-	 */
-	int (*attach_adapter)(struct i2c_adapter *) __deprecated;
-
 	/* Standard driver model interfaces */
 	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
 	int (*remove)(struct i2c_client *);
-- 
2.11.0
