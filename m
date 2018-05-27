Return-Path: <srs1=mqwm=kernel.org==ri55=io=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40v1bj6gxxzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:50:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40v1bh5PcSz8vHp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:50:56 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40v1bg6NtMz9s28
 for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2018 23:50:55 +1000 (AEST)
Subject: Patch "powerpc/pseries: Fix clearing of security feature flags" has
 been added to the 4.14-stable tree
To: greg@kroah.com, gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 mauricfo@linux.vnet.ibm.com, mpe@ellerman.id.au, tglx@linutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 27 May 2018 15:49:53 +0200
In-Reply-To: <20180526042749.5324-20-mpe@ellerman.id.au>
Message-ID: <1527428993253222@kroah.com>
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

    powerpc/pseries: Fix clearing of security feature flags

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-pseries-fix-clearing-of-security-feature-flags.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sun May 27 15:47:18 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 26 May 2018 14:27:45 +1000
Subject: powerpc/pseries: Fix clearing of security feature flags
To: greg@kroah.com
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Message-ID: <20180526042749.5324-20-mpe@ellerman.id.au>

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit 0f9bdfe3c77091e8704d2e510eb7c2c2c6cde524 upstream.

The H_CPU_BEHAV_* flags should be checked for in the 'behaviour' field
of 'struct h_cpu_char_result' -- 'character' is for H_CPU_CHAR_*
flags.

Found by playing around with QEMU's implementation of the hypercall:

  H_CPU_CHAR=0xf000000000000000
  H_CPU_BEHAV=0x0000000000000000

  This clears H_CPU_BEHAV_FAVOUR_SECURITY and H_CPU_BEHAV_L1D_FLUSH_PR
  so pseries_setup_rfi_flush() disables 'rfi_flush'; and it also
  clears H_CPU_CHAR_L1D_THREAD_PRIV flag. So there is no RFI flush
  mitigation at all for cpu_show_meltdown() to report; but currently
  it does:

  Original kernel:

    # cat /sys/devices/system/cpu/vulnerabilities/meltdown
    Mitigation: RFI Flush

  Patched kernel:

    # cat /sys/devices/system/cpu/vulnerabilities/meltdown
    Not affected

  H_CPU_CHAR=0x0000000000000000
  H_CPU_BEHAV=0xf000000000000000

  This sets H_CPU_BEHAV_BNDS_CHK_SPEC_BAR so cpu_show_spectre_v1() should
  report vulnerable; but currently it doesn't:

  Original kernel:

    # cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
    Not affected

  Patched kernel:

    # cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
    Vulnerable

Brown-paper-bag-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: f636c14790ea ("powerpc/pseries: Set or clear security feature flags")
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -484,13 +484,13 @@ static void init_cpu_char_feature_flags(
 	 * The features below are enabled by default, so we instead look to see
 	 * if firmware has *disabled* them, and clear them if so.
 	 */
-	if (!(result->character & H_CPU_BEHAV_FAVOUR_SECURITY))
+	if (!(result->behaviour & H_CPU_BEHAV_FAVOUR_SECURITY))
 		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
 
-	if (!(result->character & H_CPU_BEHAV_L1D_FLUSH_PR))
+	if (!(result->behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
 		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
 
-	if (!(result->character & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
+	if (!(result->behaviour & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
 		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
 }
 


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
