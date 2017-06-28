Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyRPF3ngjzDr3q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 01:22:41 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2] powerpc/powernv: Tell OPAL about our MMU mode
Date: Wed, 28 Jun 2017 10:22:35 -0500
Message-Id: <20170628152235.31310-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

That will allow OPAL to configure the CPU in an optimal way.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
v2:
  Always set the hash bit since we always need hash for KVM guests.
---
 arch/powerpc/include/asm/opal-api.h    |  9 +++++++++
 arch/powerpc/platforms/powernv/opal.c  | 17 +++++++++++++++--
 arch/powerpc/platforms/powernv/setup.c |  6 +++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index cb3e6242a7..85e6d8817f 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -805,6 +805,15 @@ struct OpalIoPhb3ErrorData {
 enum {
 	OPAL_REINIT_CPUS_HILE_BE	= (1 << 0),
 	OPAL_REINIT_CPUS_HILE_LE	= (1 << 1),
+
+	/* These two define the base MMU mode of the host on P9
+	 *
+	 * On P9 Nimbus DD2.0 and Cumlus (and later), KVM can still
+	 * create hash guests in "radix" mode with care (full core
+	 * switch only).
+	 */
+	OPAL_REINIT_CPUS_MMU_HASH	= (1 << 2),
+	OPAL_REINIT_CPUS_MMU_RADIX	= (1 << 3),
 };
 
 typedef struct oppanel_line {
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 59684b4af4..955265bea9 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -59,6 +59,8 @@ static struct task_struct *kopald_tsk;
 
 void opal_configure_cores(void)
 {
+	uint64_t reinit_flags = 0;
+
 	/* Do the actual re-init, This will clobber all FPRs, VRs, etc...
 	 *
 	 * It will preserve non volatile GPRs and HSPRG0/1. It will
@@ -66,11 +68,22 @@ void opal_configure_cores(void)
 	 * but it might clobber a bunch.
 	 */
 #ifdef __BIG_ENDIAN__
-	opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);
+	reinit_flags |= OPAL_REINIT_CPUS_HILE_BE;
 #else
-	opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_LE);
+	reinit_flags |= OPAL_REINIT_CPUS_HILE_LE;
 #endif
 
+	/*
+	 * POWER ISA says we always support running hash:
+	 *  ie. Host hash  supports  hash guests
+	 *      Host radix supports  hash/radix guests
+	 */
+	reinit_flags |= OPAL_REINIT_CPUS_MMU_HASH;
+	if (early_radix_enabled())
+		reinit_flags |= OPAL_REINIT_CPUS_MMU_RADIX;
+
+	opal_reinit_cpus(reinit_flags);
+
 	/* Restore some bits */
 	if (cur_cpu_spec->cpu_restore)
 		cur_cpu_spec->cpu_restore();
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 2dc7e5fb86..d1cef70bc7 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -254,8 +254,12 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 		 * We might be running as little-endian - now that interrupts
 		 * are disabled, reset the HILE bit to big-endian so we don't
 		 * take interrupts in the wrong endian later
+		 *
+		 * We also switch to radix mode on P9 as this is compatible
+		 * with hash and will allow earlier kernels to boot.
 		 */
-		opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);
+		opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE |
+				 OPAL_REINIT_CPUS_MMU_RADIX);
 	}
 }
 #endif /* CONFIG_KEXEC_CORE */
-- 
2.11.0
