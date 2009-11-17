Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f215.google.com (mail-fx0-f215.google.com
	[209.85.220.215]) by ozlabs.org (Postfix) with ESMTP id C8610B7B78
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 02:42:39 +1100 (EST)
Received: by fxm7 with SMTP id 7so111947fxm.9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 07:42:37 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 2/5] mcu_mpc8349emitx: port to new of gpio interface
Date: Tue, 17 Nov 2009 18:42:23 +0300
Message-Id: <1258472546-31343-3-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index 82a9bcb..4ba8b16 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -36,7 +36,7 @@ struct mcu {
 	struct mutex lock;
 	struct device_node *np;
 	struct i2c_client *client;
-	struct of_gpio_chip of_gc;
+	struct gpio_chip gc;
 	u8 reg_ctrl;
 };
 
@@ -55,8 +55,7 @@ static void mcu_power_off(void)
 
 static void mcu_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
-	struct of_gpio_chip *of_gc = to_of_gpio_chip(gc);
-	struct mcu *mcu = container_of(of_gc, struct mcu, of_gc);
+	struct mcu *mcu = container_of(gc, struct mcu, gc);
 	u8 bit = 1 << (4 + gpio);
 
 	mutex_lock(&mcu->lock);
@@ -78,8 +77,8 @@ static int mcu_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 static int mcu_gpiochip_add(struct mcu *mcu)
 {
 	struct device_node *np;
-	struct of_gpio_chip *of_gc = &mcu->of_gc;
-	struct gpio_chip *gc = &of_gc->gc;
+	struct gpio_chip *gc = &mcu->gc;
+	struct of_gpio_chip *of_gc = &gc->of_gc;
 	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,mcu-mpc8349emitx");
@@ -113,7 +112,7 @@ static int mcu_gpiochip_remove(struct mcu *mcu)
 {
 	int ret;
 
-	ret = gpiochip_remove(&mcu->of_gc.gc);
+	ret = gpiochip_remove(&mcu->gc);
 	if (ret)
 		return ret;
 	of_node_put(mcu->np);
-- 
1.6.5
