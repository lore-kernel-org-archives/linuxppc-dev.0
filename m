Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:52:12 +1000
Subject: [PATCH 5/7] iseries: Make HvLpConfig_get(Primary)LpIndex functions
In-Reply-To: <1152777121.430402.3949688126.qpush@concordia>
Message-Id: <20060713075216.E834A67B8F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

HvLpConfig_get(Primary)LpIndex are currently static inlines that return
fields from the itLpNaca, if we make them real functions we can make the
itLpNaca private to iSeries.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/hvlpconfig.c |   13 +++++++++++++
 arch/powerpc/platforms/iseries/setup.c      |    1 +
 include/asm-powerpc/iseries/hv_lp_config.h  |   13 ++-----------
 3 files changed, 16 insertions(+), 11 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/hvlpconfig.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/hvlpconfig.c
+++ to-merge/arch/powerpc/platforms/iseries/hvlpconfig.c
@@ -18,9 +18,22 @@
 
 #include <linux/module.h>
 #include <asm/iseries/hv_lp_config.h>
+#include <asm/iseries/it_lp_naca.h>
 
 HvLpIndex HvLpConfig_getLpIndex_outline(void)
 {
 	return HvLpConfig_getLpIndex();
 }
 EXPORT_SYMBOL(HvLpConfig_getLpIndex_outline);
+
+HvLpIndex HvLpConfig_getLpIndex(void)
+{
+	return itLpNaca.xLpIndex;
+}
+EXPORT_SYMBOL(HvLpConfig_getLpIndex);
+
+HvLpIndex HvLpConfig_getPrimaryLpIndex(void)
+{
+	return itLpNaca.xPrimaryLpIndex;
+}
+EXPORT_SYMBOL_GPL(HvLpConfig_getPrimaryLpIndex);
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -48,6 +48,7 @@
 #include <asm/iseries/hv_call_event.h>
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/it_lp_queue.h>
+#include <asm/iseries/it_lp_naca.h>
 #include <asm/iseries/mf.h>
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/lpar_map.h>
Index: to-merge/include/asm-powerpc/iseries/hv_lp_config.h
===================================================================
--- to-merge.orig/include/asm-powerpc/iseries/hv_lp_config.h
+++ to-merge/include/asm-powerpc/iseries/hv_lp_config.h
@@ -25,7 +25,6 @@
 
 #include <asm/iseries/hv_call_sc.h>
 #include <asm/iseries/hv_types.h>
-#include <asm/iseries/it_lp_naca.h>
 
 enum {
 	HvCallCfg_Cur	= 0,
@@ -44,16 +43,8 @@ enum {
 #define HvCallCfgGetHostingLpIndex			HvCallCfg + 32
 
 extern HvLpIndex HvLpConfig_getLpIndex_outline(void);
-
-static inline HvLpIndex	HvLpConfig_getLpIndex(void)
-{
-	return itLpNaca.xLpIndex;
-}
-
-static inline HvLpIndex	HvLpConfig_getPrimaryLpIndex(void)
-{
-	return itLpNaca.xPrimaryLpIndex;
-}
+extern HvLpIndex HvLpConfig_getLpIndex(void);
+extern HvLpIndex HvLpConfig_getPrimaryLpIndex(void);
 
 static inline u64 HvLpConfig_getMsChunks(void)
 {
