Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zsGh5l9czDrRN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 11:53:16 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so1480oig.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:53:16 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:22 -0500
Message-Id: <20180828015252.28511-21-robh@kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
 drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f2a2067525ef..b706fd136ca5 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
 	struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
 	struct device_node *parent = NULL;
 	struct i2c_adapter *adapter;
-	const char *basename;
 	int rc;
 
 	if (bus == NULL)
@@ -407,23 +406,25 @@ static int i2c_powermac_probe(struct platform_device *dev)
 		parent = of_get_parent(pmac_i2c_get_controller(bus));
 		if (parent == NULL)
 			return -EINVAL;
-		basename = parent->name;
+		snprintf(adapter->name, sizeof(adapter->name), "%pOFn %d", 
+			 parent,
+			 pmac_i2c_get_channel(bus));
+		of_node_put(parent);
 		break;
 	case pmac_i2c_bus_pmu:
-		basename = "pmu";
+		snprintf(adapter->name, sizeof(adapter->name), "pmu %d",
+			 pmac_i2c_get_channel(bus));
 		break;
 	case pmac_i2c_bus_smu:
 		/* This is not what we used to do but I'm fixing drivers at
 		 * the same time as this change
 		 */
-		basename = "smu";
+		snprintf(adapter->name, sizeof(adapter->name), "smu %d",
+			 pmac_i2c_get_channel(bus));
 		break;
 	default:
 		return -EINVAL;
 	}
-	snprintf(adapter->name, sizeof(adapter->name), "%s %d", basename,
-		 pmac_i2c_get_channel(bus));
-	of_node_put(parent);
 
 	platform_set_drvdata(dev, adapter);
 	adapter->algo = &i2c_powermac_algorithm;
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index 92cf5f48afe6..f60b670deff7 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -120,8 +120,8 @@ static int i2c_mux_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32(child, "reg", &chan);
 		if (ret < 0) {
-			dev_err(dev, "no reg property for node '%s'\n",
-				child->name);
+			dev_err(dev, "no reg property for node '%pOFn'\n",
+				child);
 			goto err_children;
 		}
 
-- 
2.17.1
