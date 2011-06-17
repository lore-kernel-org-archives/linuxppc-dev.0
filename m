Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D70BBB6FC8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 22:52:19 +1000 (EST)
Received: by wwi36 with SMTP id 36so1976565wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 05:52:15 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V3 1/2] Maple: register CPC925 EDAC device on all boards with
	CPC925
Date: Fri, 17 Jun 2011 16:51:46 +0400
Message-Id: <1308315107-29182-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1308315107-29182-1-git-send-email-dbaryshkov@gmail.com>
References: <1308315107-29182-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently Maple setup code creates cpc925_edac device only on
Motorola ATCA-6101 blade. Make setup code check bridge revision
and enable EDAC on all U3H bridges.

Verified on Momentum MapleD (ppc970fx kit) board.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/maple/setup.c |   41 +++++++++++++++------------------
 1 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index fe34c3d..5b3388b 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -338,35 +338,16 @@ define_machine(maple) {
 #ifdef CONFIG_EDAC
 /*
  * Register a platform device for CPC925 memory controller on
- * Motorola ATCA-6101 blade.
+ * all boards with U3H (CPC925) bridge.
  */
-#define MAPLE_CPC925_MODEL	"Motorola,ATCA-6101"
 static int __init maple_cpc925_edac_setup(void)
 {
 	struct platform_device *pdev;
 	struct device_node *np = NULL;
 	struct resource r;
-	const unsigned char *model;
 	int ret;
-
-	np = of_find_node_by_path("/");
-	if (!np) {
-		printk(KERN_ERR "%s: Unable to get root node\n", __func__);
-		return -ENODEV;
-	}
-
-	model = (const unsigned char *)of_get_property(np, "model", NULL);
-	if (!model) {
-		printk(KERN_ERR "%s: Unabel to get model info\n", __func__);
-		of_node_put(np);
-		return -ENODEV;
-	}
-
-	ret = strcmp(model, MAPLE_CPC925_MODEL);
-	of_node_put(np);
-
-	if (ret != 0)
-		return 0;
+	volatile void __iomem *mem;
+	u32 rev;
 
 	np = of_find_node_by_type(NULL, "memory-controller");
 	if (!np) {
@@ -384,6 +365,22 @@ static int __init maple_cpc925_edac_setup(void)
 		return -ENODEV;
 	}
 
+	mem = ioremap(r.start, resource_size(&r));
+	if (!mem) {
+		printk(KERN_ERR "%s: Unable to map memory-controller memory\n",
+				__func__);
+		return -ENOMEM;
+	}
+
+	rev = __raw_readl(mem);
+	iounmap(mem);
+
+	if (rev < 0x34 || rev > 0x3f) { /* U3H */
+		printk(KERN_ERR "%s: Non-CPC925(U3H) bridge revision: %02x\n",
+			__func__, rev);
+		return 0;
+	}
+
 	pdev = platform_device_register_simple("cpc925_edac", 0, &r, 1);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
-- 
1.7.5.3
