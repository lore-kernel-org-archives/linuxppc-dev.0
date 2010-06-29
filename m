Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0BE5B71FB
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 05:40:16 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5TJeEfj023425
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 12:40:14 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/mpic: Add ability to reset a core via MPIC
Date: Tue, 29 Jun 2010 14:42:26 -0500
Message-Id: <1277840547-19007-1-git-send-email-msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need the ability to reset cores for use with kexec/kdump for
SMP systems. Calling this function with the specific core you want
to reset will cause the CPU to spin in reset.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |   18 ++++++++++++++++++
 arch/powerpc/sysdev/mpic.h |    1 +
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 20b73c0..7c13426 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1636,6 +1636,24 @@ void __devinit smp_mpic_setup_cpu(int cpu)
 {
 	mpic_setup_this_cpu();
 }
+
+void mpic_reset_core(int cpu)
+{
+	struct mpic *mpic = mpic_primary;
+	u32 pir;
+	int cpuid = get_hard_smp_processor_id(cpu);
+
+	/* Set target bit for core reset */
+	pir = mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
+	pir |= (1 << cpuid);
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT), pir);
+	mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
+
+	/* Restore target bit after reset complete */
+	pir &= ~(1 << cpuid);
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT), pir);
+	mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
+}
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PM
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index eff433c..e4a6df7 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -37,5 +37,6 @@ static inline int mpic_pasemi_msi_init(struct mpic *mpic)
 extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
 extern void mpic_set_vector(unsigned int virq, unsigned int vector);
 extern int mpic_set_affinity(unsigned int irq, const struct cpumask *cpumask);
+extern void mpic_reset_core(int cpu);
 
 #endif /* _POWERPC_SYSDEV_MPIC_H */
-- 
1.6.6.1
