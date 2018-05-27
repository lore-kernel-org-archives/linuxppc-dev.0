Return-Path: <srs1=mqwm=kernel.org==ri55=io=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40v1bN5hPkzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:50:40 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40v1bN4b94z8tG1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 23:50:40 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40v1bM70clz9s1d
 for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2018 23:50:39 +1000 (AEST)
Subject: Patch "powerpc: Add security feature flags for Spectre/Meltdown" has
 been added to the 4.14-stable tree
To: greg@kroah.com, gregkh@linuxfoundation.org, linuxppc-dev@ozlabs.org,
 mpe@ellerman.id.au, tglx@linutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 27 May 2018 15:49:52 +0200
In-Reply-To: <20180526042749.5324-11-mpe@ellerman.id.au>
Message-ID: <15274289925163@kroah.com>
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

    powerpc: Add security feature flags for Spectre/Meltdown

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-add-security-feature-flags-for-spectre-meltdown.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sun May 27 15:47:18 CEST 2018
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 26 May 2018 14:27:36 +1000
Subject: powerpc: Add security feature flags for Spectre/Meltdown
To: greg@kroah.com
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Message-ID: <20180526042749.5324-11-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

commit 9a868f634349e62922c226834aa23e3d1329ae7f upstream.

This commit adds security feature flags to reflect the settings we
receive from firmware regarding Spectre/Meltdown mitigations.

The feature names reflect the names we are given by firmware on bare
metal machines. See the hostboot source for details.

Arguably these could be firmware features, but that then requires them
to be read early in boot so they're available prior to asm feature
patching, but we don't actually want to use them for patching. We may
also want to dynamically update them in future, which would be
incompatible with the way firmware features work (at the moment at
least). So for now just make them separate flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/security_features.h |   65 +++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile                 |    2 
 arch/powerpc/kernel/security.c               |   15 ++++++
 3 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/security_features.h
 create mode 100644 arch/powerpc/kernel/security.c

--- /dev/null
+++ b/arch/powerpc/include/asm/security_features.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Security related feature bit definitions.
+ *
+ * Copyright 2018, Michael Ellerman, IBM Corporation.
+ */
+
+#ifndef _ASM_POWERPC_SECURITY_FEATURES_H
+#define _ASM_POWERPC_SECURITY_FEATURES_H
+
+
+extern unsigned long powerpc_security_features;
+
+static inline void security_ftr_set(unsigned long feature)
+{
+	powerpc_security_features |= feature;
+}
+
+static inline void security_ftr_clear(unsigned long feature)
+{
+	powerpc_security_features &= ~feature;
+}
+
+static inline bool security_ftr_enabled(unsigned long feature)
+{
+	return !!(powerpc_security_features & feature);
+}
+
+
+// Features indicating support for Spectre/Meltdown mitigations
+
+// The L1-D cache can be flushed with ori r30,r30,0
+#define SEC_FTR_L1D_FLUSH_ORI30		0x0000000000000001ull
+
+// The L1-D cache can be flushed with mtspr 882,r0 (aka SPRN_TRIG2)
+#define SEC_FTR_L1D_FLUSH_TRIG2		0x0000000000000002ull
+
+// ori r31,r31,0 acts as a speculation barrier
+#define SEC_FTR_SPEC_BAR_ORI31		0x0000000000000004ull
+
+// Speculation past bctr is disabled
+#define SEC_FTR_BCCTRL_SERIALISED	0x0000000000000008ull
+
+// Entries in L1-D are private to a SMT thread
+#define SEC_FTR_L1D_THREAD_PRIV		0x0000000000000010ull
+
+// Indirect branch prediction cache disabled
+#define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
+
+
+// Features indicating need for Spectre/Meltdown mitigations
+
+// The L1-D cache should be flushed on MSR[HV] 1->0 transition (hypervisor to guest)
+#define SEC_FTR_L1D_FLUSH_HV		0x0000000000000040ull
+
+// The L1-D cache should be flushed on MSR[PR] 0->1 transition (kernel to userspace)
+#define SEC_FTR_L1D_FLUSH_PR		0x0000000000000080ull
+
+// A speculation barrier should be used for bounds checks (Spectre variant 1)
+#define SEC_FTR_BNDS_CHK_SPEC_BAR	0x0000000000000100ull
+
+// Firmware configuration indicates user favours security over performance
+#define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
+
+#endif /* _ASM_POWERPC_SECURITY_FEATURES_H */
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
--- /dev/null
+++ b/arch/powerpc/kernel/security.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Security related flags and so on.
+//
+// Copyright 2018, Michael Ellerman, IBM Corporation.
+
+#include <linux/kernel.h>
+#include <asm/security_features.h>
+
+
+unsigned long powerpc_security_features __read_mostly = \
+	SEC_FTR_L1D_FLUSH_HV | \
+	SEC_FTR_L1D_FLUSH_PR | \
+	SEC_FTR_BNDS_CHK_SPEC_BAR | \
+	SEC_FTR_FAVOUR_SECURITY;


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
