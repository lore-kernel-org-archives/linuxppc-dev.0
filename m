Return-Path: <glikely@secretlab.ca>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 62DAC100810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 07:14:34 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so4265362vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 12:14:30 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.olzabs.org
Subject: [PATCH 1/4] gpio/microblaze: Eliminate duplication of
 of_get_named_gpio_flags()
Date: Mon, 12 Dec 2011 13:14:09 -0700
Message-Id: <1323720852-26311-2-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1323720852-26311-1-git-send-email-grant.likely@secretlab.ca>
References: <1323720852-26311-1-git-send-email-grant.likely@secretlab.ca>
Cc: microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_reset_gpio_handle() is largely a cut-and-paste copy of
of_get_named_gpio_flags(). There really isn't any reason for the
split, so this patch deletes the duplicate function

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/reset.c |   43 +--------------------------------------
 1 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/arch/microblaze/kernel/reset.c b/arch/microblaze/kernel/reset.c
index bd8ccab..88a0163 100644
--- a/arch/microblaze/kernel/reset.c
+++ b/arch/microblaze/kernel/reset.c
@@ -19,50 +19,11 @@
 static int handle; /* reset pin handle */
 static unsigned int reset_val;
 
-static int of_reset_gpio_handle(void)
-{
-	int ret; /* variable which stored handle reset gpio pin */
-	struct device_node *root; /* root node */
-	struct device_node *gpio; /* gpio node */
-	struct gpio_chip *gc;
-	u32 flags;
-	const void *gpio_spec;
-
-	/* find out root node */
-	root = of_find_node_by_path("/");
-
-	/* give me handle for gpio node to be possible allocate pin */
-	ret = of_parse_phandles_with_args(root, "hard-reset-gpios",
-				"#gpio-cells", 0, &gpio, &gpio_spec);
-	if (ret) {
-		pr_debug("%s: can't parse gpios property\n", __func__);
-		goto err0;
-	}
-
-	gc = of_node_to_gpiochip(gpio);
-	if (!gc) {
-		pr_debug("%s: gpio controller %s isn't registered\n",
-			 root->full_name, gpio->full_name);
-		ret = -ENODEV;
-		goto err1;
-	}
-
-	ret = gc->of_xlate(gc, root, gpio_spec, &flags);
-	if (ret < 0)
-		goto err1;
-
-	ret += gc->base;
-err1:
-	of_node_put(gpio);
-err0:
-	pr_debug("%s exited with status %d\n", __func__, ret);
-	return ret;
-}
-
 void of_platform_reset_gpio_probe(void)
 {
 	int ret;
-	handle = of_reset_gpio_handle();
+	handle = of_get_named_gpio(of_find_node_by_path("/"),
+				   "hard-reset-gpios", 0);
 
 	if (!gpio_is_valid(handle)) {
 		printk(KERN_INFO "Skipping unavailable RESET gpio %d (%s)\n",
-- 
1.7.5.4
