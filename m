Return-Path: <srs1=ml38=kernel.org==wfse=ik=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rfWj1yKJzF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:24:17 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40rfWj0R7hz8tLb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:24:17 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40rfWh1xk4z9rxs
 for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2018 03:24:16 +1000 (AEST)
Subject: Patch "powerpc/pseries: Set or clear security feature flags" has been
 added to the 4.16-stable tree
To: greg@kroah.com, gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 mpe@ellerman.id.au, tglx@linutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 23 May 2018 19:23:13 +0200
In-Reply-To: <20180522144125.10345-5-mpe@ellerman.id.au>
Message-ID: <15270961936933@kroah.com>
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

    powerpc/pseries: Set or clear security feature flags

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-pseries-set-or-clear-security-feature-flags.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed May 23 19:18:22 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 23 May 2018 00:41:15 +1000
Subject: powerpc/pseries: Set or clear security feature flags
To: greg@kroah.com
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Message-ID: <20180522144125.10345-5-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit f636c14790ead6cc22cf62279b1f8d7e11a67116 upstream.

Now that we have feature flags for security related things, set or
clear them based on what we receive from the hypercall.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -68,6 +68,7 @@
 #include <asm/plpar_wrappers.h>
 #include <asm/kexec.h>
 #include <asm/isa-bridge.h>
+#include <asm/security_features.h>
 
 #include "pseries.h"
 
@@ -459,6 +460,40 @@ static void __init find_and_init_phbs(vo
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
 static void pseries_setup_rfi_flush(void)
 {
 	struct h_cpu_char_result result;
@@ -472,6 +507,8 @@ static void pseries_setup_rfi_flush(void
 
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS) {
+		init_cpu_char_feature_flags(&result);
+
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
 			types |= L1D_FLUSH_MTTRIG;
 		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
@@ -482,6 +519,12 @@ static void pseries_setup_rfi_flush(void
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
