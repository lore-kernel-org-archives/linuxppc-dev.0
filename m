Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/pseries: Cleanup best_energy_hcall detection
Date: Wed,  7 Nov 2012 11:49:16 +1100
Message-Id: <1352249356-29671-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1352249356-29671-1-git-send-email-mikey@neuling.org>
References: <1352249356-29671-1-git-send-email-mikey@neuling.org>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we search for the best_energy hcall using a custom function.  Move
this to using the firmware_feature_table.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
---
 arch/powerpc/include/asm/firmware.h             |    4 ++-
 arch/powerpc/platforms/pseries/firmware.c       |    1 +
 arch/powerpc/platforms/pseries/pseries_energy.c |   37 ++---------------------
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index ad0b751..ecec46a 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -49,6 +49,7 @@
 #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
 #define FW_FEATURE_OPAL		ASM_CONST(0x0000000010000000)
 #define FW_FEATURE_OPALv2	ASM_CONST(0x0000000020000000)
+#define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000040000000)
 
 #ifndef __ASSEMBLY__
 
@@ -62,7 +63,8 @@ enum {
 		FW_FEATURE_VIO | FW_FEATURE_RDMA | FW_FEATURE_LLAN |
 		FW_FEATURE_BULK_REMOVE | FW_FEATURE_XDABR |
 		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
-		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO,
+		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO | 
+	        FW_FEATURE_BEST_ENERGY,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv2,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 448c053..5bc10cb 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -61,6 +61,7 @@ firmware_features_table[FIRMWARE_MAX_FEATURES] = {
 	{FW_FEATURE_MULTITCE,		"hcall-multi-tce"},
 	{FW_FEATURE_SPLPAR,		"hcall-splpar"},
 	{FW_FEATURE_VPHN,		"hcall-vphn"},
+	{FW_FEATURE_BEST_ENERGY,	"hcall-best-energy-1*"},
 };
 
 /* Build up the firmware features bitmask using the contents of
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index af281dc..a91e6da 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -21,6 +21,7 @@
 #include <asm/cputhreads.h>
 #include <asm/page.h>
 #include <asm/hvcall.h>
+#include <asm/firmware.h>
 
 
 #define MODULE_VERS "1.0"
@@ -32,40 +33,6 @@ static int sysfs_entries;
 
 /* Helper routines */
 
-/*
- * Routine to detect firmware support for hcall
- * return 1 if H_BEST_ENERGY is supported
- * else return 0
- */
-
-static int check_for_h_best_energy(void)
-{
-	struct device_node *rtas = NULL;
-	const char *hypertas, *s;
-	int length;
-	int rc = 0;
-
-	rtas = of_find_node_by_path("/rtas");
-	if (!rtas)
-		return 0;
-
-	hypertas = of_get_property(rtas, "ibm,hypertas-functions", &length);
-	if (!hypertas) {
-		of_node_put(rtas);
-		return 0;
-	}
-
-	/* hypertas will have list of strings with hcall names */
-	for (s = hypertas; s < hypertas + length; s += strlen(s) + 1) {
-		if (!strncmp("hcall-best-energy-1", s, 19)) {
-			rc = 1; /* Found the string */
-			break;
-		}
-	}
-	of_node_put(rtas);
-	return rc;
-}
-
 /* Helper Routines to convert between drc_index to cpu numbers */
 
 static u32 cpu_to_drc_index(int cpu)
@@ -262,7 +229,7 @@ static int __init pseries_energy_init(void)
 	int cpu, err;
 	struct device *cpu_dev;
 
-	if (!check_for_h_best_energy()) {
+	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY)) {
 		printk(KERN_INFO "Hypercall H_BEST_ENERGY not supported\n");
 		return 0;
 	}
-- 
1.7.9.5
