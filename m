Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 23 Mar 2006 23:33:11 +1100
Subject: [PATCH 3/4] powerpc: Rename and export ppc64_firmware_features
In-Reply-To: <1143117144.850591.48752080269.qpush@concordia>
Message-Id: <20060323123348.4815367C10@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to export ppc64_firmware_features for modules. Before we do that
I think we should probably rename it to powerpc_firmware_features.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/firmware.c            |    2 +-
 arch/powerpc/platforms/iseries/setup.c    |    4 ++--
 arch/powerpc/platforms/pseries/firmware.c |    2 +-
 arch/powerpc/platforms/pseries/setup.c    |    2 +-
 include/asm-powerpc/firmware.h            |    5 +++--
 5 files changed, 8 insertions(+), 7 deletions(-)

Index: to-merge/arch/powerpc/kernel/firmware.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/firmware.c
+++ to-merge/arch/powerpc/kernel/firmware.c
@@ -17,4 +17,4 @@
 
 #include <asm/firmware.h>
 
-unsigned long ppc64_firmware_features;
+unsigned long powerpc_firmware_features;
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -680,8 +680,8 @@ static int __init iseries_probe(int plat
 	if (PLATFORM_ISERIES_LPAR != platform)
 		return 0;
 
-	ppc64_firmware_features |= FW_FEATURE_ISERIES;
-	ppc64_firmware_features |= FW_FEATURE_LPAR;
+	powerpc_firmware_features |= FW_FEATURE_ISERIES;
+	powerpc_firmware_features |= FW_FEATURE_LPAR;
 
 	return 1;
 }
Index: to-merge/arch/powerpc/platforms/pseries/firmware.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/firmware.c
+++ to-merge/arch/powerpc/platforms/pseries/firmware.c
@@ -91,7 +91,7 @@ void __init fw_feature_init(void)
 				continue;
 
 			/* we have a match */
-			ppc64_firmware_features |=
+			powerpc_firmware_features |=
 				firmware_features_table[i].val;
 			break;
 		}
Index: to-merge/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/setup.c
+++ to-merge/arch/powerpc/platforms/pseries/setup.c
@@ -386,7 +386,7 @@ static int __init pSeries_probe(int plat
 	 */
 
 	if (platform == PLATFORM_PSERIES_LPAR)
-		ppc64_firmware_features |= FW_FEATURE_LPAR;
+		powerpc_firmware_features |= FW_FEATURE_LPAR;
 
 	return 1;
 }
Index: to-merge/include/asm-powerpc/firmware.h
===================================================================
--- to-merge.orig/include/asm-powerpc/firmware.h
+++ to-merge/include/asm-powerpc/firmware.h
@@ -82,11 +82,12 @@ enum {
 /* This is used to identify firmware features which are available
  * to the kernel.
  */
-extern unsigned long	ppc64_firmware_features;
+extern unsigned long	powerpc_firmware_features;
+EXPORT_SYMBOL_GPL(powerpc_firmware_features);
 
 #define firmware_has_feature(feature)					\
 	((FW_FEATURE_ALWAYS & (feature)) ||				\
-		(FW_FEATURE_POSSIBLE & ppc64_firmware_features & (feature)))
+		(FW_FEATURE_POSSIBLE & powerpc_firmware_features & (feature)))
 
 extern void system_reset_fwnmi(void);
 extern void machine_check_fwnmi(void);
