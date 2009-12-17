Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24050B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 16:41:51 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBH5fn4r015832 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Dec 2009 22:41:49 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBH5kB5L014949
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Dec 2009 23:46:11 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: benh@kernel.crashing.org
Subject: [PATCH] mpic: fix problem that affinity is not updated
Date: Thu, 17 Dec 2009 14:18:11 +0800
Message-Id: <1261030691-1946-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jiajun Wu <b06378@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 57b150cce8e004ddd36330490a68bfb59b7271e9, desc->affinity
of an irq is changed after calling desc->chip->set_affinity.
Therefore we need to fix the irq_choose_cpu() not to depend on the
desc->affinity for new mask.

Signed-off-by: Jiajun Wu <b06378@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 30c44e6..54ef5cd 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -567,12 +567,11 @@ static void __init mpic_scan_ht_pics(struct mpic *mpic)
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 #ifdef CONFIG_SMP
-static int irq_choose_cpu(unsigned int virt_irq)
+static int irq_choose_cpu(const cpumask_t *cpumask)
 {
-	cpumask_t mask;
+	cpumask_t mask = *cpumask;
 	int cpuid;
 
-	cpumask_copy(&mask, irq_desc[virt_irq].affinity);
 	if (cpus_equal(mask, CPU_MASK_ALL)) {
 		static int irq_rover;
 		static DEFINE_SPINLOCK(irq_rover_lock);
@@ -607,7 +606,7 @@ static int irq_choose_cpu(unsigned int virt_irq)
 	return get_hard_smp_processor_id(cpuid);
 }
 #else
-static int irq_choose_cpu(unsigned int virt_irq)
+static int irq_choose_cpu(const cpumask_t *cpumask)
 {
 	return hard_smp_processor_id();
 }
@@ -816,7 +815,7 @@ int mpic_set_affinity(unsigned int irq, const struct cpumask *cpumask)
 	unsigned int src = mpic_irq_to_hw(irq);
 
 	if (mpic->flags & MPIC_SINGLE_DEST_CPU) {
-		int cpuid = irq_choose_cpu(irq);
+		int cpuid = irq_choose_cpu(cpumask);
 
 		mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION), 1 << cpuid);
 	} else {
-- 
1.6.6-rc1.GIT
