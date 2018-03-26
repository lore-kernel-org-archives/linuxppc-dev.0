Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408pLy65qrzF1yn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 20:12:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/10] powerpc/pseries: Use the security flags in
 pseries_setup_rfi_flush()
Date: Mon, 26 Mar 2018 20:12:13 +1100
Message-Id: <20180326091215.7784-8-mpe@ellerman.id.au>
In-Reply-To: <20180326091215.7784-1-mpe@ellerman.id.au>
References: <20180326091215.7784-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have the security flags we can simplify the code in
pseries_setup_rfi_flush() because the security flags have pessimistic
defaults.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 39 ++++++++++++++--------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9e1cfe84b77a..8757003da24c 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -501,38 +501,31 @@ static void pseries_setup_rfi_flush(void)
 	bool enable;
 	long rc;
 
-	/* Enable by default */
-	enable = true;
-
 	rc = plpar_get_cpu_characteristics(&result);
-	if (rc == H_SUCCESS) {
+	if (rc == H_SUCCESS)
 		init_cpu_char_feature_flags(&result);
 
-		types = L1D_FLUSH_NONE;
-
-		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
-			types |= L1D_FLUSH_MTTRIG;
-		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
-			types |= L1D_FLUSH_ORI;
-
-		/* Use fallback if nothing set in hcall */
-		if (types == L1D_FLUSH_NONE)
-			types = L1D_FLUSH_FALLBACK;
-
-		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
-		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
-			enable = false;
-	} else {
-		/* Default to fallback if case hcall is not available */
-		types = L1D_FLUSH_FALLBACK;
-	}
-
 	/*
 	 * We're the guest so this doesn't apply to us, clear it to simplify
 	 * handling of it elsewhere.
 	 */
 	security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
 
+	types = L1D_FLUSH_NONE;
+
+	if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_TRIG2))
+		types |= L1D_FLUSH_MTTRIG;
+
+	if (security_ftr_enabled(SEC_FTR_L1D_FLUSH_ORI30))
+		types |= L1D_FLUSH_ORI;
+
+	/* Use fallback if nothing set in hcall */
+	if (types == L1D_FLUSH_NONE)
+		types = L1D_FLUSH_FALLBACK;
+
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) && \
+		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
+
 	setup_rfi_flush(types, enable);
 }
 
-- 
2.14.1
