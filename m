Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id C7191DE0E6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:05:42 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id F1B6414399
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:06:33 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29693-01 for <linuxppc-dev@ozlabs.org>;
	Tue,  6 Nov 2007 21:06:32 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 8D9D414377
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:06:32 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v3 05/13] [POWERPC] Export mpc52xx_map_node() routine symbol
To: linuxppc-dev@ozlabs.org
Date: Tue, 06 Nov 2007 21:05:30 +0100
Message-ID: <20071106200530.10913.5759.stgit@hekate.izotz.org>
In-Reply-To: <20071106200446.10913.29338.stgit@hekate.izotz.org>
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make, so far static, mpc52xx_map_node() routine
symbol available for general use.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    3 ++-
 include/asm-powerpc/mpc52xx.h                |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 2df97c5..7224bfe 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -26,7 +26,7 @@
  */
 static volatile struct mpc52xx_gpt *mpc52xx_wdt = NULL;
 
-static void __iomem *
+void __iomem *
 mpc52xx_map_node(struct device_node *ofn)
 {
 	const u32 *regaddr_p;
@@ -47,6 +47,7 @@ mpc52xx_map_node(struct device_node *ofn)
 
 	return ioremap((u32)regaddr64, (u32)size64);
 }
+EXPORT_SYMBOL_GPL(mpc52xx_map_node);
 
 void __iomem *
 mpc52xx_find_and_map(const char *compatible)
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index d7efbe0..1887b13 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -248,6 +248,7 @@ struct mpc52xx_cdm {
 
 #ifndef __ASSEMBLY__
 
+extern void __iomem * mpc52xx_map_node(struct device_node *);
 extern void __iomem * mpc52xx_find_and_map(const char *);
 extern void __iomem * mpc52xx_find_and_map_path(const char *path);
 extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
