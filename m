Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/pseries: Allow firmware features to match partial
 strings
Date: Wed,  7 Nov 2012 11:49:15 +1100
Message-Id: <1352249356-29671-1-git-send-email-mikey@neuling.org>
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

This allows firmware_features_table names to add a '*' at the end so that only
partial strings are matched.

When a '*' is added, only upto the '*' is matched when setting firmware feature
bits.

This is useful for the matching best energy feature.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
---
 arch/powerpc/platforms/pseries/firmware.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 0b0eff0..448c053 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -33,6 +33,11 @@ typedef struct {
     char * name;
 } firmware_feature_t;
 
+/*
+ * The names in this table match names in rtas/ibm,hypertas-functions.  If the
+ * entry ends in a '*', only upto the '*' is matched.  Otherwise the entire
+ * string must match.
+ */
 static __initdata firmware_feature_t
 firmware_features_table[FIRMWARE_MAX_FEATURES] = {
 	{FW_FEATURE_PFT,		"hcall-pft"},
@@ -71,9 +76,20 @@ void __init fw_feature_init(const char *hypertas, unsigned long len)
 
 	for (s = hypertas; s < hypertas + len; s += strlen(s) + 1) {
 		for (i = 0; i < FIRMWARE_MAX_FEATURES; i++) {
+			const char *name = firmware_features_table[i].name;
+			size_t size;
 			/* check value against table of strings */
-			if (!firmware_features_table[i].name ||
-			    strcmp(firmware_features_table[i].name, s))
+			if (!name)
+				continue;
+			/*
+			 * If there is a '*' at the end of name, only check
+			 * upto there
+			 */
+			size = strlen(name);
+			if (size && name[size - 1] == '*') {
+				if (strncmp(name, s, size - 1))
+					continue;
+			} else if (strcmp(name, s))
 				continue;
 
 			/* we have a match */
-- 
1.7.9.5
