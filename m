Return-Path: <srs1=mqwm=kernel.org==ri55=io=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40v1bp6pkSzDr41
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:51:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40v1bp50rvz8vHp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:51:02 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40v1bn5Cnxz9s1w
 for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2018 23:51:01 +1000 (AEST)
Subject: Patch "powerpc/pseries: Restore default security feature flags on
 setup" has been added to the 4.14-stable tree
To: greg@kroah.com, gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 mauricfo@linux.vnet.ibm.com, mpe@ellerman.id.au, tglx@linutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 27 May 2018 15:49:53 +0200
In-Reply-To: <20180526042749.5324-22-mpe@ellerman.id.au>
Message-ID: <1527428993158180@kroah.com>
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

    powerpc/pseries: Restore default security feature flags on setup

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-pseries-restore-default-security-feature-flags-on-setup.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sun May 27 15:47:18 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 26 May 2018 14:27:47 +1000
Subject: powerpc/pseries: Restore default security feature flags on setup
To: greg@kroah.com
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Message-ID: <20180526042749.5324-22-mpe@ellerman.id.au>

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit 6232774f1599028a15418179d17f7df47ede770a upstream.

After migration the security feature flags might have changed (e.g.,
destination system with unpatched firmware), but some flags are not
set/clear again in init_cpu_char_feature_flags() because it assumes
the security flags to be the defaults.

Additionally, if the H_GET_CPU_CHARACTERISTICS hypercall fails then
init_cpu_char_feature_flags() does not run again, which potentially
might leave the system in an insecure or sub-optimal configuration.

So, just restore the security feature flags to the defaults assumed
by init_cpu_char_feature_flags() so it can set/clear them correctly,
and to ensure safe settings are in place in case the hypercall fail.

Fixes: f636c14790ea ("powerpc/pseries: Set or clear security feature flags")
Depends-on: 19887d6a28e2 ("powerpc: Move default security feature flags")
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -462,6 +462,10 @@ static void __init find_and_init_phbs(vo
 
 static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
 {
+	/*
+	 * The features below are disabled by default, so we instead look to see
+	 * if firmware has *enabled* them, and set them if so.
+	 */
 	if (result->character & H_CPU_CHAR_SPEC_BAR_ORI31)
 		security_ftr_set(SEC_FTR_SPEC_BAR_ORI31);
 
@@ -501,6 +505,13 @@ void pseries_setup_rfi_flush(void)
 	bool enable;
 	long rc;
 
+	/*
+	 * Set features to the defaults assumed by init_cpu_char_feature_flags()
+	 * so it can set/clear again any features that might have changed after
+	 * migration, and in case the hypercall fails and it is not even called.
+	 */
+	powerpc_security_features = SEC_FTR_DEFAULT;
+
 	rc = plpar_get_cpu_characteristics(&result);
 	if (rc == H_SUCCESS)
 		init_cpu_char_feature_flags(&result);


Patches currently in stable-queue which might be from mpe@ellerman.id.au are

queue-4.14/powerpc-64s-clear-pcr-on-boot.patch
queue-4.14/powerpc-rfi-flush-differentiate-enabled-and-patched-flush-types.patch
queue-4.14/powerpc-64s-fix-section-mismatch-warnings-from-setup_rfi_flush.patch
queue-4.14/powerpc-pseries-fix-clearing-of-security-feature-flags.patch
queue-4.14/powerpc-powernv-set-or-clear-security-feature-flags.patch
queue-4.14/powerpc-64s-move-cpu_show_meltdown.patch
queue-4.14/powerpc-rfi-flush-call-setup_rfi_flush-after-lpm-migration.patch
queue-4.14/powerpc-pseries-set-or-clear-security-feature-flags.patch
queue-4.14/powerpc-rfi-flush-make-it-possible-to-call-setup_rfi_flush-again.patch
queue-4.14/powerpc-move-default-security-feature-flags.patch
queue-4.14/powerpc-powernv-use-the-security-flags-in-pnv_setup_rfi_flush.patch
queue-4.14/powerpc-add-security-feature-flags-for-spectre-meltdown.patch
queue-4.14/powerpc-pseries-use-the-security-flags-in-pseries_setup_rfi_flush.patch
queue-4.14/powerpc-64s-enhance-the-information-in-cpu_show_meltdown.patch
queue-4.14/powerpc-64s-improve-rfi-l1-d-cache-flush-fallback.patch
queue-4.14/powerpc-rfi-flush-always-enable-fallback-flush-on-pseries.patch
queue-4.14/powerpc-rfi-flush-move-the-logic-to-avoid-a-redo-into-the-debugfs-code.patch
queue-4.14/powerpc-pseries-restore-default-security-feature-flags-on-setup.patch
queue-4.14/powerpc-pseries-add-new-h_get_cpu_characteristics-flags.patch
queue-4.14/powerpc-64s-add-support-for-a-store-forwarding-barrier-at-kernel-entry-exit.patch
queue-4.14/powerpc-64s-wire-up-cpu_show_spectre_v1.patch
queue-4.14/powerpc-powernv-support-firmware-disable-of-rfi-flush.patch
queue-4.14/powerpc-pseries-support-firmware-disable-of-rfi-flush.patch
queue-4.14/powerpc-64s-wire-up-cpu_show_spectre_v2.patch
