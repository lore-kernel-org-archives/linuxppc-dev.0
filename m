Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 23 Mar 2006 23:33:03 +1100
Subject: [PATCH 2/4] powerpc: Change firmware_has_feature() to a macro
In-Reply-To: <1143117144.850591.48752080269.qpush@concordia>
Message-Id: <20060323123339.F055967B39@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So that we can use firmware_has_feature() in a BUG_ON() and have the compiler
elide the code entirely if the feature can never be set, change
firmware_has_feature to a macro. Unfortunate, but necessary at least until
GCC bug #26724 is fixed.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/asm-powerpc/firmware.h |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

Index: to-merge/include/asm-powerpc/firmware.h
===================================================================
--- to-merge.orig/include/asm-powerpc/firmware.h
+++ to-merge/include/asm-powerpc/firmware.h
@@ -84,11 +84,9 @@ enum {
  */
 extern unsigned long	ppc64_firmware_features;
 
-static inline unsigned long firmware_has_feature(unsigned long feature)
-{
-	return (FW_FEATURE_ALWAYS & feature) ||
-		(FW_FEATURE_POSSIBLE & ppc64_firmware_features & feature);
-}
+#define firmware_has_feature(feature)					\
+	((FW_FEATURE_ALWAYS & (feature)) ||				\
+		(FW_FEATURE_POSSIBLE & ppc64_firmware_features & (feature)))
 
 extern void system_reset_fwnmi(void);
 extern void machine_check_fwnmi(void);
