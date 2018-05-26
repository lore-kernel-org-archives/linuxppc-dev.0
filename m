Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40t98j249GzDqsx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 14:28:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 v2 11/23] powerpc/pseries: Set or clear security
 feature flags
Date: Sat, 26 May 2018 14:27:37 +1000
Message-Id: <20180526042749.5324-12-mpe@ellerman.id.au>
In-Reply-To: <20180526042749.5324-1-mpe@ellerman.id.au>
References: <20180526042749.5324-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit f636c14790ead6cc22cf62279b1f8d7e11a67116 upstream.

Now that we have feature flags for security related things, set or
clear them based on what we receive from the hypercall.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b2d99b384089..65b157a35161 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -68,6 +68,7 @@
 #include <asm/plpar_wrappers.h>
 #include <asm/kexec.h>
 #include <asm/isa-bridge.h>
+#include <asm/security_features.h>
 
 #include "pseries.h"
 
@@ -459,6 +460,40 @@ static void __init find_and_init_phbs(void)
 	of_pci_check_probe_only();
 }
 
+static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
+{
+	if (result->character & H_CPU_CHAR_SPEC_BAR_ORI31)
+		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (result->character & H_CPU_CHAR_BCCTRL_SERIALISED)
+		security_ftr_set(SEC_FTR_BCCTRL_SERIALISED);
+
+	if (result->character & H_CPU_CHAR_L1D_FLUSH_ORI30)
+		security_ftr_set(SEC_FTR_L1D_FLUSH_ORI30);
+
+	if (result->character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
+		security_ftr_set(SEC_FTR_L1D_FLUSH_TRIG2);
+
+	if (result->character & H_CPU_CHAR_L1D_THREAD_PRIV)
+		security_ftr_set(SEC_FTR_L1D_THREAD_PRIV);
+
+	if (result->character & H_CPU_CHAR_COUNT_CACHE_DISABLED)
+		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
+
+	/*
+	 * The features below are enabled by default, so we instead look to see
+	 * if firmware has *disabled* them, and clear them if so.
+	 */
+	if (!(result->character & H_CPU_BEHAV_FAVOUR_SECURITY))
+		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
+
+	if (!(result->character & H_CPU_BEHAV_L1D_FLUSH_PR))
+		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
+
+	if (!(result->character & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
+		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
+}
+
 void pseries_setup_rfi_flush(void)
 {
 	struct h_cpu_char_result result;
@@ -472,6 +507,8 @@ void pseries_setup_rfi_flush(void)
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
+		init_cpu_char_feature_flags(&result);
+
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
 			types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
@@ -482,6 +519,12 @@ void pseries_setup_rfi_flush(void)
 			enable = false;
 	}
 
+	/*
+	 * We're the guest so this doesn't apply to us, clear it to simplify
+	 * handling of it elsewhere.
+	 */
+	security_ftr_clear(SEC_FTR_L1D_FLUSH_HV);
+
 	setup_rfi_flush(types, enable);
 }
 
-- 
2.14.1
