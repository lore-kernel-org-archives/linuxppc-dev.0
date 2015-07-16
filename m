Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AF891A0784
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 09:14:39 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <scottwood@freescale.com>, Tang Yuantian
 <Yuantian.Tang@freescale.com>
Subject: [PATCH] powerpc/fsl-booke-64: Allow booting from the secondary thread
Date: Thu, 16 Jul 2015 18:14:11 -0500
Message-ID: <1437088451-4010-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to Yuantian, this is needed for forthcoming power management
patches -- IIRC, for resuming from certain deep sleep states.

This also allows SMP kernels to work as kdump crash kernels.  While
crash kernels don't really need to be SMP, this prevents things from
breaking if a user does it anyway (which is not something you want to
only find out once the main kernel has crashed in the field, especially
if whether it works or not depends on which cpu crashed).

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>
---
I'm sending this before the rest of the kexec patches, since Yuantian
needs it as a prerequisite.  Yuantian, if you explain the issue more I
can improve the commit message of this patch.
---
 arch/powerpc/platforms/85xx/smp.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index b8b8216..c2ded03 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -173,15 +173,22 @@ static inline u32 read_spin_table_addr_l(void *spin_table)
 static void wake_hw_thread(void *info)
 {
 	void fsl_secondary_thread_init(void);
-	unsigned long imsr1, inia1;
+	unsigned long imsr, inia;
 	int nr = *(const int *)info;
 
-	imsr1 = MSR_KERNEL;
-	inia1 = *(unsigned long *)fsl_secondary_thread_init;
-
-	mttmr(TMRN_IMSR1, imsr1);
-	mttmr(TMRN_INIA1, inia1);
-	mtspr(SPRN_TENS, TEN_THREAD(1));
+	imsr = MSR_KERNEL;
+	inia = *(unsigned long *)fsl_secondary_thread_init;
+
+	if (cpu_thread_in_core(nr) == 0) {
+		/* For when we boot on a secondary thread with kdump */
+		mttmr(TMRN_IMSR0, imsr);
+		mttmr(TMRN_INIA0, inia);
+		mtspr(SPRN_TENS, TEN_THREAD(0));
+	} else {
+		mttmr(TMRN_IMSR1, imsr);
+		mttmr(TMRN_INIA1, inia);
+		mtspr(SPRN_TENS, TEN_THREAD(1));
+	}
 
 	smp_generic_kick_cpu(nr);
 }
@@ -224,6 +231,12 @@ static int smp_85xx_kick_cpu(int nr)
 
 		smp_call_function_single(primary, wake_hw_thread, &nr, 0);
 		return 0;
+	} else if (cpu_thread_in_core(boot_cpuid) != 0 &&
+		   cpu_first_thread_sibling(boot_cpuid) == nr) {
+		if (WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_SMT)))
+			return -ENOENT;
+
+		smp_call_function_single(boot_cpuid, wake_hw_thread, &nr, 0);
 	}
 #endif
 
-- 
2.1.4
