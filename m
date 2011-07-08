Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF0B61007D2
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jul 2011 07:15:12 +1000 (EST)
Received: from mail55-tx2 (localhost.localdomain [127.0.0.1])	by
	mail55-tx2-R.bigfish.com (Postfix) with ESMTP id 3D194C384F6	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 21:15:08 +0000 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.246])	by
	mail55-tx2.bigfish.com (Postfix) with ESMTP id E2CCC7600F3	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 21:12:47 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/mpic: add support for discontiguous cores
Date: Fri, 8 Jul 2011 16:12:42 -0500
Message-ID: <1310159562-13492-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is one place in the MPIC driver that assumes that the cores are numbered
from 0 to n-1.  However, this is not true if the CPUs are not numbered
sequentially.  This can happen on a eight-core SOC where cores two and three
are removed in the device tree.  So instead of blindly looping, we iterate
over the discovered CPUs and use the SMP ID as the index.

This means that we no longer ask the MPIC how many CPUs there are, so
we also delete mpic->num_cpus.

We also catch if the number of CPUs in the SOC exceeds the number that the
MPIC supports.  This should never happen, of course, but it's good to be
sure.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/mpic.h |    2 --
 arch/powerpc/sysdev/mpic.c      |   24 +++++++++++++++---------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index df18989..c447025 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -273,8 +273,6 @@ struct mpic
 	unsigned int		irq_count;
 	/* Number of sources */
 	unsigned int		num_sources;
-	/* Number of CPUs */
-	unsigned int		num_cpus;
 	/* default senses array */
 	unsigned char		*senses;
 	unsigned int		senses_count;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 58d7a53..5d80573 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1321,13 +1321,11 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 			   | MPIC_GREG_GCONF_MCK);
 
-	/* Read feature register, calculate num CPUs and, for non-ISU
-	 * MPICs, num sources as well. On ISU MPICs, sources are counted
-	 * as ISUs are added
+	/*
+	 * Read feature register.  For non-ISU MPICs, num sources as well. On
+	 * ISU MPICs, sources are counted as ISUs are added
 	 */
 	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
-	mpic->num_cpus = ((greg_feature & MPIC_GREG_FEATURE_LAST_CPU_MASK)
-			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
 	if (isu_size == 0) {
 		if (flags & MPIC_BROKEN_FRR_NIRQS)
 			mpic->num_sources = mpic->irq_count;
@@ -1337,10 +1335,18 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 				 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
 	}
 
+	/*
+	 * The MPIC driver will crash if there are more cores than we
+	 * can initialize, so we may as well catch that problem here.
+	 */
+	BUG_ON(num_possible_cpus() > MPIC_MAX_CPUS);
+
 	/* Map the per-CPU registers */
-	for (i = 0; i < mpic->num_cpus; i++) {
-		mpic_map(mpic, node, paddr, &mpic->cpuregs[i],
-			 MPIC_INFO(CPU_BASE) + i * MPIC_INFO(CPU_STRIDE),
+	for_each_possible_cpu(i) {
+		unsigned int cpu = get_hard_smp_processor_id(i);
+
+		mpic_map(mpic, node, paddr, &mpic->cpuregs[cpu],
+			 MPIC_INFO(CPU_BASE) + cpu * MPIC_INFO(CPU_STRIDE),
 			 0x1000);
 	}
 
@@ -1379,7 +1385,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	}
 	printk(KERN_INFO "mpic: Setting up MPIC \"%s\" version %s at %llx,"
 	       " max %d CPUs\n",
-	       name, vers, (unsigned long long)paddr, mpic->num_cpus);
+	       name, vers, (unsigned long long)paddr, num_possible_cpus());
 	printk(KERN_INFO "mpic: ISU size: %d, shift: %d, mask: %x\n",
 	       mpic->isu_size, mpic->isu_shift, mpic->isu_mask);
 
-- 
1.7.3.4
