Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB3A71A196A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:29 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: [RFC PATCH 07/17] powerpc/e6500: kexec: Handle hardware threads
Date: Sat, 18 Jul 2015 15:08:44 -0500
Message-ID: <1437250134-307-8-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
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

The new kernel will be expecting secondary threads to be disabled,
not spinning.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/head_64.S     | 16 +++++++++++++
 arch/powerpc/platforms/85xx/smp.c | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index d48125d..8b2bf0d 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -182,6 +182,8 @@ exception_marker:
 
 #ifdef CONFIG_PPC_BOOK3E
 _GLOBAL(fsl_secondary_thread_init)
+	mfspr	r4,SPRN_BUCSR
+
 	/* Enable branch prediction */
 	lis     r3,BUCSR_INIT@h
 	ori     r3,r3,BUCSR_INIT@l
@@ -196,10 +198,24 @@ _GLOBAL(fsl_secondary_thread_init)
 	 * number.  There are two threads per core, so shift everything
 	 * but the low bit right by two bits so that the cpu numbering is
 	 * continuous.
+	 *
+	 * If the old value of BUCSR is non-zero, this thread has run
+	 * before.  Thus, we assume we are coming from kexec or a similar
+	 * scenario, and PIR is already set to the correct value.  This
+	 * is a bit of a hack, but there are limited opportunities for
+	 * getting information into the thread and the alternatives
+	 * seemed like they'd be overkill.  We can't tell just by looking
+	 * at the old PIR value which state it's in, since the same value
+	 * could be valid for one thread out of reset and for a different
+	 * thread in Linux.
 	 */
+
 	mfspr	r3, SPRN_PIR
+	cmpwi	r4,0
+	bne	1f
 	rlwimi	r3, r3, 30, 2, 30
 	mtspr	SPRN_PIR, r3
+1:
 #endif
 
 _GLOBAL(generic_secondary_thread_init)
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 2e46684..5152289 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -374,9 +374,57 @@ static void mpc85xx_smp_kexec_down(void *arg)
 #else
 void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 {
+	int cpu = smp_processor_id();
+	int sibling = cpu_last_thread_sibling(cpu);
+	bool notified = false;
+	int disable_cpu;
+	int disable_threadbit = 0;
+	long start = mftb();
+	long now;
+
 	local_irq_disable();
 	hard_irq_disable();
 	mpic_teardown_this_cpu(secondary);
+
+	if (cpu == crashing_cpu && cpu_thread_in_core(cpu) != 0) {
+		/*
+		 * We enter the crash kernel on whatever cpu crashed,
+		 * even if it's a secondary thread.  If that's the case,
+		 * disable the corresponding primary thread.
+		 */
+		int tir = cpu_thread_in_core(cpu) ^ 1;
+
+		disable_threadbit = 1 << tir;
+		disable_cpu = cpu_first_thread_sibling(cpu) | tir;
+	} else if (sibling != crashing_cpu &&
+		   cpu_thread_in_core(cpu) == 0 &&
+		   cpu_thread_in_core(sibling) != 0) {
+		disable_threadbit = 2;
+		disable_cpu = sibling;
+	}
+
+	if (disable_threadbit) {
+		while (paca[disable_cpu].kexec_state < KEXEC_STATE_REAL_MODE) {
+			barrier();
+			now = mftb();
+			if (!notified && now - start > 1000000) {
+				pr_info("%s/%d: waiting for cpu %d to enter KEXEC_STATE_REAL_MODE (%d)\n",
+					__func__, smp_processor_id(),
+					disable_cpu,
+					paca[disable_cpu].kexec_state);
+				notified = true;
+			}
+		}
+
+		if (notified) {
+			pr_info("%s: cpu %d done waiting\n",
+				__func__, disable_cpu);
+		}
+
+		mtspr(SPRN_TENC, disable_threadbit);
+		while (mfspr(SPRN_TENSR) & disable_threadbit)
+			cpu_relax();
+	}
 }
 #endif
 
-- 
2.1.4
