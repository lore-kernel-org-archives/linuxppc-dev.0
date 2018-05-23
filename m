Return-Path: <srs1=ml38=kernel.org==wfse=ik=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rfWm1zsvzF13P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:24:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40rfWm1HpXz8tLb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:24:20 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40rfWl2Ld7z9s15
 for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2018 03:24:19 +1000 (AEST)
Subject: Patch "powerpc/powernv: Set or clear security feature flags" has been
 added to the 4.16-stable tree
To: greg@kroah.com, gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 mpe@ellerman.id.au, tglx@linutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 23 May 2018 19:23:13 +0200
In-Reply-To: <20180522144125.10345-6-mpe@ellerman.id.au>
Message-ID: <15270961931498@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    powerpc/powernv: Set or clear security feature flags

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-powernv-set-or-clear-security-feature-flags.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed May 23 19:18:22 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 23 May 2018 00:41:16 +1000
Subject: powerpc/powernv: Set or clear security feature flags
To: greg@kroah.com
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Message-ID: <20180522144125.10345-6-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit 77addf6e95c8689e478d607176b399a6242a777e upstream.

Now that we have feature flags for security related things, set or
clear them based on what we see in the device tree provided by
firmware.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/setup.c |   56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

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
+	struct device_node *np;
+	bool rc = false;
+
+	np = of_get_child_by_name(fw_features, name);
+	if (np) {
+		rc = of_property_read_bool(np, state);
+		of_node_put(np);
+	}
+
+	return rc;
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


Patches currently in stable-queue which might be from mpe@ellerman.id.au are

queue-4.16/powerpc-pseries-fix-clearing-of-security-feature-flags.patch
queue-4.16/powerpc-powernv-set-or-clear-security-feature-flags.patch
queue-4.16/powerpc-64s-move-cpu_show_meltdown.patch
queue-4.16/powerpc-pseries-set-or-clear-security-feature-flags.patch
queue-4.16/powerpc-move-default-security-feature-flags.patch
queue-4.16/powerpc-powernv-use-the-security-flags-in-pnv_setup_rfi_flush.patch
queue-4.16/powerpc-add-security-feature-flags-for-spectre-meltdown.patch
queue-4.16/powerpc-pseries-use-the-security-flags-in-pseries_setup_rfi_flush.patch
queue-4.16/powerpc-64s-enhance-the-information-in-cpu_show_meltdown.patch
queue-4.16/powerpc-rfi-flush-always-enable-fallback-flush-on-pseries.patch
queue-4.16/powerpc-pseries-add-new-h_get_cpu_characteristics-flags.patch
queue-4.16/powerpc-64s-add-support-for-a-store-forwarding-barrier-at-kernel-entry-exit.patch
queue-4.16/powerpc-64s-wire-up-cpu_show_spectre_v1.patch
queue-4.16/powerpc-64s-wire-up-cpu_show_spectre_v2.patch
