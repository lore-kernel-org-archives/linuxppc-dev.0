Return-Path: <srs1=dmfv=kernel.org==e1is=iu=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40yj1d4g7MzF18L
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:37:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40yj1d24x3z8tGk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:37:41 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40yj1c3bxLz9s08
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2018 23:37:40 +1000 (AEST)
Subject: Patch "powerpc/rfi-flush: Move out of HARDLOCKUP_DETECTOR #ifdef" has
 been added to the 4.9-stable tree
To: gregkh@linuxfoundation.org,linuxppc-dev@ozlabs.org,mpe@ellerman.id.au
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 02 Jun 2018 15:35:42 +0200
In-Reply-To: <20180602110908.29773-2-mpe@ellerman.id.au>
Message-ID: <1527946542904@kroah.com>
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

    powerpc/rfi-flush: Move out of HARDLOCKUP_DETECTOR #ifdef

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-rfi-flush-move-out-of-hardlockup_detector-ifdef.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sat Jun  2 15:29:05 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat,  2 Jun 2018 21:08:46 +1000
Subject: powerpc/rfi-flush: Move out of HARDLOCKUP_DETECTOR #ifdef
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-ID: <20180602110908.29773-2-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

The backport of the RFI flush support, done by me, has a minor bug in
that the code is inside an #ifdef CONFIG_HARDLOCKUP_DETECTOR, which is
incorrect.

This doesn't matter with common configs because we enable
HARDLOCKUP_DETECTOR, but with future patches it will break the build.
So fix it.

Fixes: c3b82ebee6e0 ("powerpc/64s: Add support for RFI flush of L1-D cache")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/setup_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -679,6 +679,7 @@ static int __init disable_hardlockup_det
 	return 0;
 }
 early_initcall(disable_hardlockup_detector);
+#endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 #ifdef CONFIG_PPC_BOOK3S_64
 static enum l1d_flush_type enabled_flush_types;
@@ -806,4 +807,3 @@ ssize_t cpu_show_meltdown(struct device
 	return sprintf(buf, "Vulnerable\n");
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
-#endif


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
