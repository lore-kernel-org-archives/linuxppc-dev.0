Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0103.outbound.protection.outlook.com [157.56.110.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7416D1A0F58
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 02:51:35 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v2 04/10] powerpc/mpc85xx: Add platform support for the
 Freescale DPAA QMan
Date: Mon, 16 Feb 2015 09:46:15 -0600
Message-ID: <1424101581-22109-5-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Geoff Thorpe <Geoff.Thorpe@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Geoff Thorpe <Geoff.Thorpe@freescale.com>

Change-Id: I59de17c040cdd304f86306336fcf89f130f7db2d
Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 8 +++++++-
 arch/powerpc/platforms/85xx/p1023_rdb.c       | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 74faab7..20b8f9a 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -198,15 +198,21 @@ static int __init corenet_generic_probe(void)
 }
 
 /* Early setup is required for large chunks of contiguous (and coarsely-aligned)
- * memory. The following shoe-horns Bman "init_early" calls into the
+ * memory. The following shoe-horns Q/Bman "init_early" calls into the
  * platform setup to let them parse their CCSR nodes early on.
  */
+#ifdef CONFIG_FSL_QMAN_CONFIG
+void __init qman_init_early(void);
+#endif
 #ifdef CONFIG_FSL_BMAN_CONFIG
 void __init bman_init_early(void);
 #endif
 
 __init void corenet_ds_init_early(void)
 {
+#ifdef CONFIG_FSL_QMAN_CONFIG
+	qman_init_early();
+#endif
 #ifdef CONFIG_FSL_BMAN_CONFIG
 	bman_init_early();
 #endif
diff --git a/arch/powerpc/platforms/85xx/p1023_rdb.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
index 624d3d6..dc69801 100644
--- a/arch/powerpc/platforms/85xx/p1023_rdb.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -106,14 +106,20 @@ static int __init p1023_rdb_probe(void)
 }
 
 /* Early setup is required for large chunks of contiguous (and coarsely-aligned)
- * memory. The following shoe-horns Bman "init_early" calls into the
+ * memory. The following shoe-horns Q/Bman "init_early" calls into the
  * platform setup to let them parse their CCSR nodes early on. */
+#ifdef CONFIG_FSL_QMAN_CONFIG
+void __init qman_init_early(void);
+#endif
 #ifdef CONFIG_FSL_BMAN_CONFIG
 void __init bman_init_early(void);
 #endif
 
 static __init void p1023_rdb_init_early(void)
 {
+#ifdef CONFIG_FSL_QMAN_CONFIG
+	qman_init_early();
+#endif
 #ifdef CONFIG_FSL_BMAN_CONFIG
 	bman_init_early();
 #endif
-- 
2.3.0
