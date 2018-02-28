Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrz8P0cYGzF1by
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 01:53:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 4/6] powerpc/powernv: Set or clear security feature flags
Date: Thu,  1 Mar 2018 01:53:14 +1100
Message-Id: <20180228145316.11347-4-mpe@ellerman.id.au>
In-Reply-To: <20180228145316.11347-1-mpe@ellerman.id.au>
References: <20180228145316.11347-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have feature flags for security related things, set or
clear them based on what we see in the device tree provided by
firmware.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 092715b9674b..5f242b1bab01 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -38,9 +38,63 @@
 #include <asm/smp.h>
 #include <asm/tm.h>
 #include <asm/setup.h>
+#include <asm/security_features.h>
 
 #include "powernv.h"
 
+
+static bool fw_feature_is(const char *state, const char *name,
+			  struct device_node *fw_features)
+{
+       struct device_node *np;
+       bool rc = false;
+
+       np = of_get_child_by_name(fw_features, name);
+       if (np) {
+               rc = of_property_read_bool(np, state);
+               of_node_put(np);
+       }
+
+       return rc;
+}
+
+static void init_fw_feat_flags(struct device_node *np)
+{
+	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (fw_feature_is("enabled", "fw-bcctrl-serialized", np))
+		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
+
+	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
+
+	if (fw_feature_is("enabled", "inst-l1d-flush-trig2", np))
+		security_ftr_set(SEC_FTR_L1D_FLUSH_TRIG2);
+
+	if (fw_feature_is("enabled", "fw-l1d-thread-split", np))
+		security_ftr_set(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (fw_feature_is("enabled", "fw-count-cache-disabled", np))
+		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
+
+	/*
+	 * The features below are enabled by default, so we instead look to see
+	 * if firmware has *disabled* them, and clear them if so.
+	 */
+	if (fw_feature_is("disabled", "speculation-policy-favor-security", np))
+		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
+
+	if (fw_feature_is("disabled", "needs-l1d-flush-msr-pr-0-to-1", np))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
+
+	if (fw_feature_is("disabled", "needs-l1d-flush-msr-hv-1-to-0", np))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
+
+	if (fw_feature_is("disabled", "needs-spec-barrier-for-bound-checks", np))
+		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
+}
+
 static void pnv_setup_rfi_flush(void)
 {
 	struct device_node *np, *fw_features;
@@ -56,6 +110,8 @@ static void pnv_setup_rfi_flush(void)
 	of_node_put(np);
 
 	if (fw_features) {
+		init_fw_feat_flags(fw_features);
+
 		np = of_get_child_by_name(fw_features, "inst-l1d-flush-trig2");
 		if (np && of_property_read_bool(np, "enabled"))
 			type = L1D_FLUSH_MTTRIG;
-- 
2.14.1
