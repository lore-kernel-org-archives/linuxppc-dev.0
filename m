Return-Path: <srs1=mqwm=kernel.org==ri55=io=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40v1c821x5zDr7s
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:51:20 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40v1c76dRSz8tG1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:51:19 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40v1c72hKQz9s02
 for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2018 23:51:19 +1000 (AEST)
Subject: Patch "powerpc/rfi-flush: Make it possible to call setup_rfi_flush()
 again" has been added to the 4.14-stable tree
To: greg@kroah.com, gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 mauricfo@linux.vnet.ibm.com, mpe@ellerman.id.au, tglx@linutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 27 May 2018 15:49:54 +0200
In-Reply-To: <20180526042749.5324-6-mpe@ellerman.id.au>
Message-ID: <152742899453189@kroah.com>
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

    powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-rfi-flush-make-it-possible-to-call-setup_rfi_flush-again.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sun May 27 15:47:18 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 26 May 2018 14:27:31 +1000
Subject: powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again
To: greg@kroah.com
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Message-ID: <20180526042749.5324-6-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit abf110f3e1cea40f5ea15e85f5d67c39c14568a7 upstream.

For PowerVM migration we want to be able to call setup_rfi_flush()
again after we've migrated the partition.

To support that we need to check that we're not trying to allocate the
fallback flush area after memblock has gone away (i.e., boot-time only).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/setup.h |    2 +-
 arch/powerpc/kernel/setup_64.c   |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -49,7 +49,7 @@ enum l1d_flush_type {
 	L1D_FLUSH_MTTRIG	= 0x8,
 };
 
-void __init setup_rfi_flush(enum l1d_flush_type, bool enable);
+void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
 
 #endif /* !__ASSEMBLY__ */
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -836,6 +836,10 @@ static void init_fallback_flush(void)
 	u64 l1d_size, limit;
 	int cpu;
 
+	/* Only allocate the fallback flush area once (at boot time). */
+	if (l1d_flush_fallback_area)
+		return;
+
 	l1d_size = ppc64_caches.l1d.size;
 	limit = min(safe_stack_limit(), ppc64_rma_size);
 
@@ -853,7 +857,7 @@ static void init_fallback_flush(void)
 	}
 }
 
-void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
+void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 {
 	if (types & L1D_FLUSH_FALLBACK) {
 		pr_info("rfi-flush: Using fallback displacement flush\n");


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
