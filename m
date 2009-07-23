Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2916EB7D10
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:57 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:46 +1000
Subject: [PATCH 11/20] powerpc: Move definitions of secondary CPU spinloop to
	header file
Message-Id: <20090723055957.19D28DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Those definitions are currently declared extern in the .c file where
they are used, move them to a header file instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

 arch/powerpc/include/asm/smp.h |    5 +++++
 arch/powerpc/kernel/setup_64.c |    3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/smp.h	2009-07-22 16:38:32.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/smp.h	2009-07-22 16:46:59.000000000 +1000
@@ -148,6 +148,11 @@ extern struct smp_ops_t *smp_ops;
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi(cpumask_t mask);
 
+#ifdef CONFIG_PPC64
+extern void generic_secondary_smp_init(void);
+extern unsigned long __secondary_hold_spinloop;
+#endif /* CONFIG_PPC64 */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-07-22 16:38:12.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-07-22 16:46:59.000000000 +1000
@@ -230,9 +230,6 @@ void early_setup_secondary(void)
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
-extern unsigned long __secondary_hold_spinloop;
-extern void generic_secondary_smp_init(void);
-
 void smp_release_cpus(void)
 {
 	unsigned long *ptr;
