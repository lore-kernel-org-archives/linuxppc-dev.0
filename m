Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwjq635x0zDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 06:05:38 +1000 (AEST)
Message-ID: <1498421118.31581.110.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/powernv: Tell OPAL about our MMU mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Michael Neuling
 <michael.neuling@au1.ibm.com>
Date: Sun, 25 Jun 2017 15:05:18 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

That will allow OPAL to configure the CPU in an optimal way.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

The matching OPAL change has been sent to the skiboot list.

Setting those bits in the reinit() call with an older OPAL
will result in the call returning an error which Linux ignores
but it will still work in the sense that it will still honor
the other flags it understands (the endian switch ones).

 arch/powerpc/include/asm/opal-api.h    |  9 +++++++++
 arch/powerpc/platforms/powernv/opal.c  | 14 ++++++++++++--
 arch/powerpc/platforms/powernv/setup.c |  6 +++++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index cb3e624..85e6d88 100644
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
index 59684b4..e522d6b 100644
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
@@ -66,11 +68,19 @@ void opal_configure_cores(void)
 	 * but it might clobber a bunch.
 	 */
 #ifdef __BIG_ENDIAN__
-	opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);
+	reinit_flags |= OPAL_REINIT_CPUS_HILE_BE;
 #else
-	opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_LE);
+	reinit_flags |= OPAL_REINIT_CPUS_HILE_LE;
 #endif
 
+	/* Radix MMU */
+	if (early_radix_enabled())
+		reinit_flags |= OPAL_REINIT_CPUS_MMU_RADIX;
+	else
+		reinit_flags |= OPAL_REINIT_CPUS_MMU_HASH;
+
+	opal_reinit_cpus(reinit_flags);
+
 	/* Restore some bits */
 	if (cur_cpu_spec->cpu_restore)
 		cur_cpu_spec->cpu_restore();
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 2dc7e5f..d1cef70 100644
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
