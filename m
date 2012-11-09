Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 10/14] powerpc: Add set_mode hcall
Date: Fri,  9 Nov 2012 17:19:08 +1100
Message-Id: <1352441953-29096-11-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This new hcall in POWER8 is used to set various resource mode registers.
eg. it can set address translation mode on interrupt (note: partition wide
scope)

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/firmware.h             |    4 +++-
 arch/powerpc/include/asm/hvcall.h               |    3 ++-
 arch/powerpc/platforms/pseries/firmware.c       |    1 +
 arch/powerpc/platforms/pseries/plpar_wrappers.h |    6 ++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index ad0b751..973cc3b 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -49,6 +49,7 @@
 #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
 #define FW_FEATURE_OPAL		ASM_CONST(0x0000000010000000)
 #define FW_FEATURE_OPALv2	ASM_CONST(0x0000000020000000)
+#define FW_FEATURE_SET_MODE	ASM_CONST(0x0000000040000000)
 
 #ifndef __ASSEMBLY__
 
@@ -62,7 +63,8 @@ enum {
 		FW_FEATURE_VIO | FW_FEATURE_RDMA | FW_FEATURE_LLAN |
 		FW_FEATURE_BULK_REMOVE | FW_FEATURE_XDABR |
 		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
-		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO,
+		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
+		FW_FEATURE_SET_MODE,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv2,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 7a86706..a3d26d8 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -267,7 +267,8 @@
 #define H_RANDOM		0x300
 #define H_COP			0x304
 #define H_GET_MPP_X		0x314
-#define MAX_HCALL_OPCODE	H_GET_MPP_X
+#define H_SET_MODE		0x31C
+#define MAX_HCALL_OPCODE	H_SET_MODE
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 0b0eff0..7b56118 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -56,6 +56,7 @@ firmware_features_table[FIRMWARE_MAX_FEATURES] = {
 	{FW_FEATURE_MULTITCE,		"hcall-multi-tce"},
 	{FW_FEATURE_SPLPAR,		"hcall-splpar"},
 	{FW_FEATURE_VPHN,		"hcall-vphn"},
+	{FW_FEATURE_SET_MODE,		"hcall-set-mode"},
 };
 
 /* Build up the firmware features bitmask using the contents of
diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index 13e8cc4..44ad214 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -273,4 +273,10 @@ static inline long plpar_put_term_char(unsigned long termno, unsigned long len,
 			lbuf[1]);
 }
 
+/* Set various resource mode parameters */
+static inline long plpar_set_mode(unsigned long mflags, unsigned long resource,
+		unsigned long value1, unsigned long value2)
+{
+	return plpar_hcall_norets(H_SET_MODE, mflags, resource, value1, value2);
+}
 #endif /* _PSERIES_PLPAR_WRAPPERS_H */
-- 
1.7.9.5
