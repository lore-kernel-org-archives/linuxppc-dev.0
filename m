Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 8D5E1100A5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:43 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <521be31d7a4cbf75c0cd016f0486338b25dd67a5.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:17 -0500
Subject: [PATCH 13/37] powerpc/mpic: simplify ipi cpu mask handling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that MSG_ALL and MSG_ALL_BUT_SELF have been eliminated,
smp_mpic_mesage_pass no longer needs to lookup the cpumask just to
have mpic_send_ipi extract part of it and recode it in a NR_CPUS loop
by mpic_physmask.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I chose stepwise refinement but this could be merged into the ALL_BUT_SELF
removal patch.
---
 arch/powerpc/sysdev/mpic.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 68ea50c..53121f6 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1613,30 +1613,28 @@ void mpic_request_ipis(void)
 	}
 }
 
-static void mpic_send_ipi(unsigned int ipi_no, const struct cpumask *cpu_mask)
+void smp_mpic_message_pass(int cpu, int msg)
 {
 	struct mpic *mpic = mpic_primary;
+	u32 physmask;
 
 	BUG_ON(mpic == NULL);
 
-#ifdef DEBUG_IPI
-	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
-#endif
-
-	mpic_cpu_write(MPIC_INFO(CPU_IPI_DISPATCH_0) +
-		       ipi_no * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE),
-		       mpic_physmask(cpumask_bits(cpu_mask)[0]));
-}
-
-void smp_mpic_message_pass(int cpu, int msg)
-{
 	/* make sure we're sending something that translates to an IPI */
 	if ((unsigned int)msg > 3) {
 		printk("SMP %d: smp_message_pass: unknown msg %d\n",
 		       smp_processor_id(), msg);
 		return;
 	}
-	mpic_send_ipi(msg, cpumask_of(cpu));
+
+#ifdef DEBUG_IPI
+	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, msg);
+#endif
+
+	physmask = 1 << get_hard_smp_processor_id(cpu);
+
+	mpic_cpu_write(MPIC_INFO(CPU_IPI_DISPATCH_0) +
+		       msg * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE), physmask);
 }
 
 int __init smp_mpic_probe(void)
-- 
1.7.0.4
