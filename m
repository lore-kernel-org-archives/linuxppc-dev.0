Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 2A317DDEED
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 10:52:49 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 2BD951432E
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 00:53:24 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30930-03 for <linuxppc-dev@ozlabs.org>;
	Sun,  4 Nov 2007 00:53:23 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id D1C5D142CC
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 00:53:22 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v2 05/12] [POWERPC] Export mpc52xx_map_node() routine symbol
To: linuxppc-dev@ozlabs.org
Date: Sun, 04 Nov 2007 00:52:40 +0100
Message-ID: <20071103235240.31906.93311.stgit@hekate.izotz.org>
In-Reply-To: <20071103235210.31906.83423.stgit@hekate.izotz.org>
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>
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

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    4 +++-
 include/asm-powerpc/mpc52xx.h                |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 2df97c5..14e20ce 100644
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
@@ -48,6 +48,8 @@ mpc52xx_map_node(struct device_node *ofn)
 	return ioremap((u32)regaddr64, (u32)size64);
 }
 
+EXPORT_SYMBOL(mpc52xx_map_node);
+
 void __iomem *
 mpc52xx_find_and_map(const char *compatible)
 {
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
