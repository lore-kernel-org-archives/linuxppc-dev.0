Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id 4941BDDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 02:40:11 +1100 (EST)
Date: Fri, 21 Dec 2007 10:40:09 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc85xx_ads: add in missing of_node_put()
Message-ID: <20071221154009.GB20661@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cpm2_pic_init() does its own of_node_get() so we should do an of_node_put()
before calling it. This and other coding style cleanups as suggested by
Stephen Rothwell.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index bccdc25..ea4886f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -52,9 +52,9 @@ static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	int cascade_irq;
 
-	while ((cascade_irq = cpm2_get_irq()) >= 0) {
+	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
-	}
+
 	desc->chip->eoi(irq);
 }
 
@@ -70,13 +70,12 @@ static void __init mpc85xx_ads_pic_init(void)
 #endif
 
 	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
+	if (!np) {
 		printk(KERN_ERR "Could not find open-pic node\n");
 		return;
 	}
 
-	if(of_address_to_resource(np, 0, &r)) {
+	if (of_address_to_resource(np, 0, &r)) {
 		printk(KERN_ERR "Could not map mpic register space\n");
 		of_node_put(np);
 		return;
@@ -98,6 +97,7 @@ static void __init mpc85xx_ads_pic_init(void)
 		return;
 	}
 	irq = irq_of_parse_and_map(np, 0);
+	of_node_put(np);
 
 	cpm2_pic_init(np);
 	set_irq_chained_handler(irq, cpm2_cascade);
@@ -112,7 +112,7 @@ struct cpm_pin {
 	int port, pin, flags;
 };
 
-static struct cpm_pin mpc8560_ads_pins[] = {
+static const struct cpm_pin mpc8560_ads_pins[] = {
 	/* SCC1 */
 	{3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
-- 
1.5.0.rc1.gf4b6c
