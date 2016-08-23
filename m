Return-Path: <haokexin@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJDN53tzRzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 12:07:17 +1000 (AEST)
Received: by mail-yw0-x241.google.com with SMTP id r9so4420822ywg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:07:17 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/5] of/platform: introduce arch_want_default_of_probe()
Date: Tue, 23 Aug 2016 10:06:55 +0800
Message-Id: <1471918019-19472-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
References: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit fc520f8b4fa3 ("of/platform: disable the
of_platform_default_populate_init() for all the ppc boards"), we
disable the default of probe for ppc in order to fix some broken boards.
But we do want to leverage the default of probe function on ppc arch.
So introduce a weak function arch_want_default_of_probe(), we can
override it in arch specific code to enable/disable the default of probe
per board.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/of_platform.c | 5 +++++
 drivers/of/platform.c             | 9 ++++++---
 include/linux/of_platform.h       | 1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index b60a67d92ebd..ace7fe132b6f 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -122,3 +122,8 @@ static __init int of_pci_phb_init(void)
 device_initcall(of_pci_phb_init);
 
 #endif /* CONFIG_PPC_OF_PLATFORM_PCI */
+
+bool __init arch_want_default_of_probe(void)
+{
+	return false;
+}
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f39ccd5aa701..6aaa1438c9cd 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -497,12 +497,16 @@ int of_platform_default_populate(struct device_node *root,
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
-#ifndef CONFIG_PPC
+bool __init __weak arch_want_default_of_probe(void)
+{
+	return true;
+}
+
 static int __init of_platform_default_populate_init(void)
 {
 	struct device_node *node;
 
-	if (!of_have_populated_dt())
+	if (!arch_want_default_of_probe() || !of_have_populated_dt())
 		return -ENODEV;
 
 	/*
@@ -522,7 +526,6 @@ static int __init of_platform_default_populate_init(void)
 	return 0;
 }
 arch_initcall_sync(of_platform_default_populate_init);
-#endif
 
 static int of_platform_device_destroy(struct device *dev, void *data)
 {
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 956a1006aefc..02cf1fdaa3d0 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -76,6 +76,7 @@ extern int of_platform_default_populate(struct device_node *root,
 					const struct of_dev_auxdata *lookup,
 					struct device *parent);
 extern void of_platform_depopulate(struct device *parent);
+extern bool arch_want_default_of_probe(void);
 #else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
-- 
2.5.5
