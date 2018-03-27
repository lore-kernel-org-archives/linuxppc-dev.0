Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409V4T4D9pzF2Bt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:02:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mauricfo@linux.vnet.ibm.com
Subject: [PATCH v2 07/10] powerpc/powernv: Use the security flags in
 pnv_setup_rfi_flush()
Date: Tue, 27 Mar 2018 23:01:50 +1100
Message-Id: <20180327120153.31612-7-mpe@ellerman.id.au>
In-Reply-To: <20180327120153.31612-1-mpe@ellerman.id.au>
References: <20180327120153.31612-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have the security flags we can significantly simplify the
code in pnv_setup_rfi_flush(), because we can use the flags instead of
checking device tree properties and because the security flags have
pessimistic defaults.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 41 +++++++++-------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 5f242b1bab01..a90e995e5cc1 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -66,7 +66,7 @@ static void init_fw_feat_flags(struct device_node *np)
 	if (fw_feature_is("enabled", "fw-bcctrl-serialized", np))
 		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
 
-	if (fw_feature_is("enabled", "inst-spec-barrier-ori31,31,0", np))
+	if (fw_feature_is("enabled", "inst-l1d-flush-ori30,30,0", np))
 		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
 
 	if (fw_feature_is("enabled", "inst-l1d-flush-trig2", np))
@@ -99,11 +99,10 @@ static void pnv_setup_rfi_flush(void)
 {
 	struct device_node *np, *fw_features;
 	enum l1d_flush_type type;
-	int enable;
+	bool enable;
 
 	/* Default to fallback in case fw-features are not available */
 	type = L1D_FLUSH_FALLBACK;
-	enable = 1;
 
 	np = of_find_node_by_name(NULL, "ibm,opal");
 	fw_features = of_get_child_by_name(np, "fw-features");
@@ -111,40 +110,20 @@ static void pnv_setup_rfi_flush(void)
 
 	if (fw_features) {
 		init_fw_feat_flags(fw_features);
+		of_node_put(fw_features);
 
-		np = of_get_child_by_name(fw_features, "inst-l1d-flush-trig2");
-		if (np && of_property_read_bool(np, "enabled"))
+		if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_TRIG2))
 			type = L1D_FLUSH_MTTRIG;
 
-		of_node_put(np);
-
-		np = of_get_child_by_name(fw_features, "inst-l1d-flush-ori30,30,0");
-		if (np && of_property_read_bool(np, "enabled"))
+		if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_ORI30))
 			type = L1D_FLUSH_ORI;
-
-		of_node_put(np);
-
-		/* Enable unless firmware says NOT to */
-		enable = 2;
-		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-hv-1-to-0");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable--;
-
-		of_node_put(np);
-
-		np = of_get_child_by_name(fw_features, "needs-l1d-flush-msr-pr-0-to-1");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable--;
-
-		np = of_get_child_by_name(fw_features, "speculation-policy-favor-security");
-		if (np && of_property_read_bool(np, "disabled"))
-			enable = 0;
-
-		of_node_put(np);
-		of_node_put(fw_features);
 	}
 
-	setup_rfi_flush(type, enable > 0);
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) && \
+		 (security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR)   || \
+		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
+
+	setup_rfi_flush(type, enable);
 }
 
 static void __init pnv_setup_arch(void)
-- 
2.14.1
