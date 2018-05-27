Return-Path: <srs1=mqwm=kernel.org==ri55=io=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40v1c02FNCzDr43
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:51:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40v1bz6XfFz8tG1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:51:11 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40v1bv1BCHz9s1p
 for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2018 23:51:07 +1000 (AEST)
Subject: Patch "powerpc/pseries: Support firmware disable of RFI flush" has
 been added to the 4.14-stable tree
To: greg@kroah.com, gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 mpe@ellerman.id.au, tglx@linutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 27 May 2018 15:49:53 +0200
In-Reply-To: <20180526042749.5324-3-mpe@ellerman.id.au>
Message-ID: <152742899310426@kroah.com>
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

    powerpc/pseries: Support firmware disable of RFI flush

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-pseries-support-firmware-disable-of-rfi-flush.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sun May 27 15:47:18 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 26 May 2018 14:27:28 +1000
Subject: powerpc/pseries: Support firmware disable of RFI flush
To: greg@kroah.com
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Message-ID: <20180526042749.5324-3-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit 582605a429e20ae68fd0b041b2e840af296edd08 upstream.

Some versions of firmware will have a setting that can be configured
to disable the RFI flush, add support for it.

Fixes: 8989d56878a7 ("powerpc/pseries: Query hypervisor for RFI flush settings")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -482,7 +482,8 @@ static void pseries_setup_rfi_flush(void
 		if (types == L1D_FLUSH_NONE)
 			types = L1D_FLUSH_FALLBACK;
 
-		if (!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
+		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
+		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
 			enable = false;
 	} else {
 		/* Default to fallback if case hcall is not available */


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
