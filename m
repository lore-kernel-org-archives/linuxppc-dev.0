Return-Path: <bgat@billgatliff.com>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 3558FB6EF0
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 14:51:22 +1100 (EST)
Received: by yxe11 with SMTP id 11so14592287yxe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 19:51:20 -0800 (PST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] Create a struct of_i2c_gpio_chip,
	for i2c-based GPIO devices
Date: Tue,  5 Jan 2010 21:51:37 -0600
Message-Id: <1262749898-19197-2-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262749898-19197-1-git-send-email-bgat@billgatliff.com>
References: <1262749898-19197-1-git-send-email-bgat@billgatliff.com>
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
 include/linux/of_gpio.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index fc2472c..0c39242 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -102,4 +102,27 @@ static inline int of_get_gpio(struct device_node *np, int index)
 	return of_get_gpio_flags(np, index, NULL);
 }
 
+
+
+
+/*
+ * OF GPIO chip for I2C-based devices
+ */
+struct of_i2c_gpio_chip {
+	struct of_gpio_chip of_gc;
+};
+
+static inline struct of_i2c_gpio_chip *to_of_i2c_gpio_chip(struct gpio_chip *gc)
+{
+	struct of_gpio_chip *of_gc = to_of_gpio_chip(gc);
+
+	return container_of(of_gc, struct of_i2c_gpio_chip, of_gc);
+}
+
+extern int of_i2c_gpiochip_add(struct device_node *np,
+			       struct of_i2c_gpio_chip *gc);
+
+
+
+
 #endif /* __LINUX_OF_GPIO_H */
-- 
1.6.5
