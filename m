Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D2C871400AE
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:44 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 28 Mar 2014 12:36:43 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 838D32BB0054
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2S2aRxX1966436
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:27 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2S2aesi015016
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:40 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/7] powerpc/ppc64: Gracefully handle early interrupts
Date: Fri, 28 Mar 2014 13:36:29 +1100
Message-Id: <1395974192-820-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
References: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we take an interrupt such as a trap caused by a BUG_ON before the
MMU has been setup, the interrupt handlers try to enable virutal mode
and cause a recursive crash, making the original problem very hard
to debug.

This fixes it by adjusting the "kernel_msr" value in the PACA so that
it only has MSR_IR and MSR_DR (translation for instruction and data)
set after the MMU has been initialized for the processor.

We may still not have a console yet but at least we don't get into
a recursive fault (and early debug console or memory dump via JTAG
of the kernel buffer *will* give us the proper error).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/paca.c     |  3 ++-
 arch/powerpc/kernel/setup_64.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index bf0aada..ad302f8 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -152,7 +152,8 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	new_paca->paca_index = cpu;
 	new_paca->kernel_toc = kernel_toc;
 	new_paca->kernelbase = (unsigned long) _stext;
-	new_paca->kernel_msr = MSR_KERNEL;
+	/* Only set MSR:IR/DR when MMU is initialized */
+	new_paca->kernel_msr = MSR_KERNEL & ~(MSR_IR | MSR_DR);
 	new_paca->hw_cpu_id = 0xffff;
 	new_paca->kexec_state = KEXEC_STATE_NONE;
 	new_paca->__current = &init_task;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d8aabbd..1d33e81 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -261,6 +261,14 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu();
 
+	/*
+	 * At this point, we can let interrupts switch to virtual mode
+	 * (the MMU has been setup), so adjust the MSR in the PACA to
+	 * have IR and DR set.
+	 */
+	get_paca()->kernel_msr = MSR_KERNEL;
+
+	/* Reserve large chunks of memory for use by CMA for KVM */
 	kvm_cma_reserve();
 
 	/*
@@ -293,6 +301,13 @@ void early_setup_secondary(void)
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
+
+	/*
+	 * At this point, we can let interrupts switch to virtual mode
+	 * (the MMU has been setup), so adjust the MSR in the PACA to
+	 * have IR and DR set.
+	 */
+	get_paca()->kernel_msr = MSR_KERNEL;
 }
 
 #endif /* CONFIG_SMP */
-- 
1.8.3.2
