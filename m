Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D4F75DE35F
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 04:12:58 +1100 (EST)
Date: Thu, 16 Oct 2008 21:12:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] of: fill the archdata for I2C devices
Message-ID: <20081016171256.GC5515@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For I2C devices we just setting the the node pointer in the archdata.
This is needed so that the other code would know device's node.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/of_i2c.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..f9e18ed 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -24,6 +24,7 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 	for_each_child_of_node(adap_node, node) {
 		struct i2c_board_info info = {};
+		struct dev_archdata dev_ad = {};
 		const u32 *addr;
 		int len;
 
@@ -41,6 +42,9 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 		info.addr = *addr;
 
+		dev_archdata_set_node(&dev_ad, node);
+		info.archdata = &dev_ad;
+
 		request_module(info.type);
 
 		result = i2c_new_device(adap, &info);
@@ -51,6 +55,13 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 			irq_dispose_mapping(info.irq);
 			continue;
 		}
+
+		/*
+		 * Get the node to not lose the dev_archdata->of_node.
+		 * Currently there is no way to put it back, as well as no
+		 * of_unregister_i2c_devices() call.
+		 */
+		of_node_get(node);
 	}
 }
 EXPORT_SYMBOL(of_register_i2c_devices);
-- 
1.5.6.3
