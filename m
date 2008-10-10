Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDB00DE0BD
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 06:44:37 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m9AJiXCj023499
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:44:34 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: Make ppc32 actually respect the boot cpu id for
	!CONFIG_SMP
Date: Fri, 10 Oct 2008 14:44:33 -0500
Message-Id: <1223667873-5559-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previosly the FDT header field boot_cpuid_phys wasn't actually used
on ppc32.  Instead the physical boot cpuid was assumed to be 0 for
!CONFIG_SMP.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

set boot_cpuid_phys to phys, not logical

- k

 arch/powerpc/include/asm/smp.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index c092f84..1866cec 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -93,7 +93,7 @@ extern void __cpu_die(unsigned int cpu);
 
 #else
 /* for UP */
-#define hard_smp_processor_id()		0
+#define hard_smp_processor_id()		get_hard_smp_processor_id(0)
 #define smp_setup_cpu_maps()
 
 #endif /* CONFIG_SMP */
@@ -122,6 +122,7 @@ static inline int get_hard_smp_processor_id(int cpu)
 
 static inline void set_hard_smp_processor_id(int cpu, int phys)
 {
+	boot_cpuid_phys = phys;
 }
 #endif /* !CONFIG_SMP */
 #endif /* !CONFIG_PPC64 */
-- 
1.5.5.1
