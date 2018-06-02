Return-Path: <srs1=dmfv=kernel.org==e1is=iu=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40yj0g398WzF15H
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:36:51 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40yj0g1MZMz8tGk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:36:51 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40yj0f1bj6z9s1B
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2018 23:36:50 +1000 (AEST)
Subject: Patch "powerpc/64s: Move cpu_show_meltdown()" has been added to the
 4.9-stable tree
To: gregkh@linuxfoundation.org,linuxppc-dev@ozlabs.org,mpe@ellerman.id.au
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 02 Jun 2018 15:35:39 +0200
In-Reply-To: <20180602110908.29773-14-mpe@ellerman.id.au>
Message-ID: <1527946539245120@kroah.com>
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

    powerpc/64s: Move cpu_show_meltdown()

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-64s-move-cpu_show_meltdown.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sat Jun  2 15:29:05 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat,  2 Jun 2018 21:08:58 +1000
Subject: powerpc/64s: Move cpu_show_meltdown()
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-ID: <20180602110908.29773-14-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit 8ad33041563a10b34988800c682ada14b2612533 upstream.

This landed in setup_64.c for no good reason other than we had nowhere
else to put it. Now that we have a security-related file, that is a
better place for it so move it.

[mpe: Add extern for rfi_flush to fix bisection break]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/security_features.h |    1 +
 arch/powerpc/kernel/security.c               |   11 +++++++++++
 arch/powerpc/kernel/setup_64.c               |    8 --------
 3 files changed, 12 insertions(+), 8 deletions(-)

--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -10,6 +10,7 @@
 
 
 extern unsigned long powerpc_security_features;
+extern bool rfi_flush;
 
 static inline void security_ftr_set(unsigned long feature)
 {
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -5,6 +5,8 @@
 // Copyright 2018, Michael Ellerman, IBM Corporation.
 
 #include <linux/kernel.h>
+#include <linux/device.h>
+
 #include <asm/security_features.h>
 
 
@@ -13,3 +15,12 @@ unsigned long powerpc_security_features
 	SEC_FTR_L1D_FLUSH_PR | \
 	SEC_FTR_BNDS_CHK_SPEC_BAR | \
 	SEC_FTR_FAVOUR_SECURITY;
+
+
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (rfi_flush)
+		return sprintf(buf, "Mitigation: RFI Flush\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -805,12 +805,4 @@ static __init int rfi_flush_debugfs_init
 }
 device_initcall(rfi_flush_debugfs_init);
 #endif
-
-ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	if (rfi_flush)
-		return sprintf(buf, "Mitigation: RFI Flush\n");
-
-	return sprintf(buf, "Vulnerable\n");
-}
 #endif /* CONFIG_PPC_BOOK3S_64 */


Patches currently in stable-queue which might be from mpe@ellerman.id.au are

queue-4.9/powerpc-64s-clear-pcr-on-boot.patch
queue-4.9/powerpc-rfi-flush-differentiate-enabled-and-patched-flush-types.patch
queue-4.9/powerpc-64s-fix-section-mismatch-warnings-from-setup_rfi_flush.patch
queue-4.9/powerpc-pseries-fix-clearing-of-security-feature-flags.patch
queue-4.9/powerpc-powernv-set-or-clear-security-feature-flags.patch
queue-4.9/powerpc-64s-move-cpu_show_meltdown.patch
queue-4.9/powerpc-rfi-flush-call-setup_rfi_flush-after-lpm-migration.patch
queue-4.9/powerpc-pseries-set-or-clear-security-feature-flags.patch
queue-4.9/powerpc-rfi-flush-make-it-possible-to-call-setup_rfi_flush-again.patch
queue-4.9/powerpc-move-default-security-feature-flags.patch
queue-4.9/powerpc-powernv-use-the-security-flags-in-pnv_setup_rfi_flush.patch
queue-4.9/powerpc-add-security-feature-flags-for-spectre-meltdown.patch
queue-4.9/powerpc-pseries-use-the-security-flags-in-pseries_setup_rfi_flush.patch
queue-4.9/powerpc-64s-enhance-the-information-in-cpu_show_meltdown.patch
queue-4.9/powerpc-rfi-flush-move-out-of-hardlockup_detector-ifdef.patch
queue-4.9/powerpc-rfi-flush-always-enable-fallback-flush-on-pseries.patch
queue-4.9/powerpc-rfi-flush-move-the-logic-to-avoid-a-redo-into-the-debugfs-code.patch
queue-4.9/powerpc-pseries-restore-default-security-feature-flags-on-setup.patch
queue-4.9/powerpc-pseries-add-new-h_get_cpu_characteristics-flags.patch
queue-4.9/powerpc-64s-add-support-for-a-store-forwarding-barrier-at-kernel-entry-exit.patch
queue-4.9/powerpc-64s-wire-up-cpu_show_spectre_v1.patch
queue-4.9/powerpc-powernv-support-firmware-disable-of-rfi-flush.patch
queue-4.9/powerpc-pseries-support-firmware-disable-of-rfi-flush.patch
queue-4.9/powerpc-64s-wire-up-cpu_show_spectre_v2.patch
