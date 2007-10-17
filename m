Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id D7005DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 22:59:09 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 6C75414288
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 14:59:09 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04062-02 for <linuxppc-dev@ozlabs.org>;
	Wed, 17 Oct 2007 14:59:07 +0200 (CEST)
Message-ID: <47160709.5020002@semihalf.com>
Date: Wed, 17 Oct 2007 14:58:49 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] [POWERPC] Add mpc52xx_find_and_map_path(),
	refactor utility functions
References: <47160689.4020301@semihalf.com>
In-Reply-To: <47160689.4020301@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add helper routine mpc52xx_find_and_map_path(). Extract common code to
mpc52xx_map_node() and refactor mpc52xx_find_and_map().

Signed-off-by: Jan Wrobel <wrr@semihalf.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/mpc52xx_common.c |   21 +++++++++++++++++----
 include/asm-powerpc/mpc52xx.h                |    1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 3bc201e..74b4b41 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -19,14 +19,12 @@ #include <asm/prom.h>
 #include <asm/mpc52xx.h>
 
 
-void __iomem *
-mpc52xx_find_and_map(const char *compatible)
+static void __iomem *
+mpc52xx_map_node(struct device_node *ofn)
 {
-	struct device_node *ofn;
 	const u32 *regaddr_p;
 	u64 regaddr64, size64;
 
-	ofn = of_find_compatible_node(NULL, NULL, compatible);
 	if (!ofn)
 		return NULL;
 
@@ -42,8 +40,23 @@ mpc52xx_find_and_map(const char *compati
 
 	return ioremap((u32)regaddr64, (u32)size64);
 }
+
+void __iomem *
+mpc52xx_find_and_map(const char *compatible)
+{
+	return mpc52xx_map_node(
+		of_find_compatible_node(NULL, NULL, compatible));
+}
+
 EXPORT_SYMBOL(mpc52xx_find_and_map);
 
+void __iomem *
+mpc52xx_find_and_map_path(const char *path)
+{
+	return mpc52xx_map_node(of_find_node_by_path(path));
+}
+
+EXPORT_SYMBOL(mpc52xx_find_and_map_path);
 
 /**
  * 	mpc52xx_find_ipb_freq - Find the IPB bus frequency for a device
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index 24751df..9cf05f9 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -242,6 +242,7 @@ #endif /* __ASSEMBLY__ */
 #ifndef __ASSEMBLY__
 
 extern void __iomem * mpc52xx_find_and_map(const char *);
+extern void __iomem * mpc52xx_find_and_map_path(const char *path);
 extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
 extern void mpc5200_setup_xlb_arbiter(void);
 extern void mpc52xx_declare_of_platform_devices(void);
