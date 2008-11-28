Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8B077DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 06:13:46 +1100 (EST)
Date: Fri, 28 Nov 2008 22:13:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2] of/i2c: Fill the archdata for I2C devices
Message-ID: <20081128191345.GB27260@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For I2C devices we just setting the node pointer in the archdata. This
is needed so that the I2C devices could find their OF tree nodes.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/of/of_i2c.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 24bbef7..e1b0ad6 100644
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
 		request_module("%s", info.type);
 
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
1.5.6.5
