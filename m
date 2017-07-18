Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtwV4VmWzDrK3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:44:26 +1000 (AEST)
Received: by mail-pg0-f65.google.com with SMTP id v190so4353505pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:44:26 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>, Peter Rosin <peda@axentia.se>,
 linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH] i2c: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:43:06 -0500
Message-Id: <20170718214339.7774-26-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/i2c/busses/i2c-gpio.c         |  4 ++--
 drivers/i2c/busses/i2c-powermac.c     | 10 ++++------
 drivers/i2c/busses/i2c-sun6i-p2wi.c   |  4 ++--
 drivers/i2c/i2c-core-of.c             | 24 +++++++++++-------------
 drivers/i2c/muxes/i2c-demux-pinctrl.c |  4 ++--
 5 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 34cfc0ebdcb9..0ef8fcc6ac3a 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -98,8 +98,8 @@ static int of_i2c_gpio_get_pins(struct device_node *np,
 		return -EPROBE_DEFER;

 	if (!gpio_is_valid(*sda_pin) || !gpio_is_valid(*scl_pin)) {
-		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
-		       np->full_name, *sda_pin, *scl_pin);
+		pr_err("%pOF: invalid GPIO pins, sda=%d/scl=%d\n",
+		       np, *sda_pin, *scl_pin);
 		return -ENODEV;
 	}

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index b0d9dee14a7e..ef9c858fe1d4 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -234,7 +234,7 @@ static u32 i2c_powermac_get_addr(struct i2c_adapter *adap,
 	else if (!strcmp(node->name, "deq"))
 		return 0x34;

-	dev_warn(&adap->dev, "No i2c address for %s\n", node->full_name);
+	dev_warn(&adap->dev, "No i2c address for %pOF\n", node);

 	return 0xffffffff;
 }
@@ -315,8 +315,7 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 		}
 	}

-	dev_err(&adap->dev, "i2c-powermac: modalias failure"
-		" on %s\n", node->full_name);
+	dev_err(&adap->dev, "i2c-powermac: modalias failure on %pOF\n", node);
 	return false;
 }

@@ -348,8 +347,7 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 		if (!pmac_i2c_match_adapter(node, adap))
 			continue;

-		dev_dbg(&adap->dev, "i2c-powermac: register %s\n",
-			node->full_name);
+		dev_dbg(&adap->dev, "i2c-powermac: register %pOF\n", node);

 		/*
 		 * Keep track of some device existence to handle
@@ -372,7 +370,7 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 		newdev = i2c_new_device(adap, &info);
 		if (!newdev) {
 			dev_err(&adap->dev, "i2c-powermac: Failure to register"
-				" %s\n", node->full_name);
+				" %pOF\n", node);
 			of_node_put(node);
 			/* We do not dispose of the interrupt mapping on
 			 * purpose. It's not necessary (interrupt cannot be
diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 7668e2e9b8fd..8a24464dc337 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -223,8 +223,8 @@ static int p2wi_probe(struct platform_device *pdev)
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &slave_addr);
 		if (ret) {
-			dev_err(dev, "invalid slave address on node %s\n",
-				childnp->full_name);
+			dev_err(dev, "invalid slave address on node %pOF\n",
+				childnp);
 			return -EINVAL;
 		}

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index ccf82fdbcd8e..8d474bb1dc15 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -32,18 +32,17 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	u32 addr;
 	int len;

-	dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
+	dev_dbg(&adap->dev, "of_i2c: register %pOF\n", node);

 	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
-		dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
-			node->full_name);
+		dev_err(&adap->dev, "of_i2c: modalias failure on %pOF\n",
+			node);
 		return ERR_PTR(-EINVAL);
 	}

 	addr_be = of_get_property(node, "reg", &len);
 	if (!addr_be || (len < sizeof(*addr_be))) {
-		dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
-			node->full_name);
+		dev_err(&adap->dev, "of_i2c: invalid reg on %pOF\n", node);
 		return ERR_PTR(-EINVAL);
 	}

@@ -59,8 +58,8 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	}

 	if (i2c_check_addr_validity(addr, info.flags)) {
-		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
-			addr, node->full_name);
+		dev_err(&adap->dev, "of_i2c: invalid addr=%x on %pOF\n",
+			addr, node);
 		return ERR_PTR(-EINVAL);
 	}

@@ -76,8 +75,7 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,

 	result = i2c_new_device(adap, &info);
 	if (result == NULL) {
-		dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
-			node->full_name);
+		dev_err(&adap->dev, "of_i2c: Failure registering %pOF\n", node);
 		of_node_put(node);
 		return ERR_PTR(-EINVAL);
 	}
@@ -106,8 +104,8 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 		client = of_i2c_register_device(adap, node);
 		if (IS_ERR(client)) {
 			dev_warn(&adap->dev,
-				 "Failed to create I2C device for %s\n",
-				 node->full_name);
+				 "Failed to create I2C device for %pOF\n",
+				 node);
 			of_node_clear_flag(node, OF_POPULATED);
 		}
 	}
@@ -243,8 +241,8 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
 		put_device(&adap->dev);

 		if (IS_ERR(client)) {
-			dev_err(&adap->dev, "failed to create client for '%s'\n",
-				 rd->dn->full_name);
+			dev_err(&adap->dev, "failed to create client for '%pOF'\n",
+				 rd->dn);
 			of_node_clear_flag(rd->dn, OF_POPULATED);
 			return notifier_from_errno(PTR_ERR(client));
 		}
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 3e6fe1760d82..33ce032cb701 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -167,8 +167,8 @@ static ssize_t available_masters_show(struct device *dev,
 	int count = 0, i;

 	for (i = 0; i < priv->num_chan && count < PAGE_SIZE; i++)
-		count += scnprintf(buf + count, PAGE_SIZE - count, "%d:%s%c",
-				   i, priv->chan[i].parent_np->full_name,
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%d:%pOF%c",
+				   i, priv->chan[i].parent_np,
 				   i == priv->num_chan - 1 ? '\n' : ' ');

 	return count;
--
2.11.0
