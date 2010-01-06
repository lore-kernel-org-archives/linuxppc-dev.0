Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id 37D25B6EF4
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 14:51:22 +1100 (EST)
Received: by iwn11 with SMTP id 11so12644754iwn.17
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 19:51:20 -0800 (PST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] Create an of_i2c_gpiochip_add()
Date: Tue,  5 Jan 2010 21:51:38 -0600
Message-Id: <1262749898-19197-3-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262749898-19197-2-git-send-email-bgat@billgatliff.com>
References: <1262749898-19197-1-git-send-email-bgat@billgatliff.com>
	<1262749898-19197-2-git-send-email-bgat@billgatliff.com>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 drivers/of/gpio.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index 6eea601..56b438a 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -217,3 +217,58 @@ err0:
 	return ret;
 }
 EXPORT_SYMBOL(of_mm_gpiochip_add);
+
+/**
+ * of_i2c_gpiochip_add - Add memory I2C-based GPIO chip
+ * @np:		device node of the GPIO chip
+ * @gc:		pointer to the of_i2c_gpio_chip allocated structure
+ *
+ * To use this function you should allocate and fill gc with:
+ *
+ * 1) In the gpio_chip structure:
+ *    - all the callbacks
+ *
+ * 2) In the of_gpio_chip structure:
+ *    - gpio_cells
+ *    - xlate callback (optional)
+ *
+ * If succeeded, this function will do something useful...
+ */
+int of_i2c_gpiochip_add(struct device_node *np,
+			struct of_i2c_gpio_chip *i2c_gc)
+{
+	int ret = -ENOMEM;
+	struct of_gpio_chip *of_gc = &i2c_gc->of_gc;
+	struct gpio_chip *gc = &of_gc->gc;
+
+	gc->label = kstrdup(np->full_name, GFP_KERNEL);
+	if (!gc->label)
+		goto err0;
+
+	gc->base = -1;
+
+	if (!of_gc->xlate)
+		of_gc->xlate = of_gpio_simple_xlate;
+
+	np->data = of_gc;
+
+	ret = gpiochip_add(gc);
+	if (ret)
+		goto err2;
+
+	/* We don't want to lose the node and its ->data */
+	of_node_get(np);
+
+	pr_debug("%s: registered as generic GPIO chip, base is %d\n",
+		 np->full_name, gc->base);
+	return 0;
+err2:
+	np->data = NULL;
+err1:
+	kfree(gc->label);
+err0:
+	pr_err("%s: GPIO chip registration failed with status %d\n",
+	       np->full_name, ret);
+	return ret;
+}
+EXPORT_SYMBOL(of_i2c_gpiochip_add);
-- 
1.6.5
