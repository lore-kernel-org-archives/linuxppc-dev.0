Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77F231A0E89
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 02:14:57 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 15:14:53 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 102AC1B08069
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 15:15:10 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB5FEpQS51839040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 15:14:51 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB5FEoEH017212
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 08:14:51 -0700
Subject: [PATCH 2 2/4] powerpc: drop smt_enabled_at_boot
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 05 Dec 2014 16:14:50 +0100
Message-ID: <20141205151440.11028.14017.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The paths using the smt_enabled_at_boot variable reveal the following
lifecycle:

initial value:                  int smt_enabled_at_boot = 1
                                        |
                                        |
check_smt_enabled():            smt_enabled_at_boot = threads_per_core
                                        |
                                        |
setup_tlb_core_data():          if (smt_enabled_at_boot >= 2
                                        |
                                        |
smp_generic_cpu_bootable():     if (!smt_enabled_at_boot
                                        |
                                if (smt_enabled_at_boot

It appears that smt_enabled_at_boot is just a duplicate of threads_per_core.
Let's drop it.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/smp.h |    2 --
 arch/powerpc/kernel/setup_64.c |   15 +--------------
 arch/powerpc/kernel/smp.c      |    8 +++-----
 3 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 5a6614a..fae8cad 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -174,8 +174,6 @@ static inline void set_hard_smp_processor_id(int cpu, int phys)
 #endif /* !CONFIG_SMP */
 #endif /* !CONFIG_PPC64 */
 
-extern int smt_enabled_at_boot;
-
 extern int smp_mpic_probe(void);
 extern void smp_mpic_setup_cpu(int cpu);
 extern int smp_generic_kick_cpu(int nr);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 29c1845..ba80480 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -114,7 +114,7 @@ static void setup_tlb_core_data(void)
 		 * or e6500 tablewalk mode, or else TLB handlers
 		 * will be racy and could produce duplicate entries.
 		 */
-		if (smt_enabled_at_boot >= 2 &&
+		if (threads_per_core >= 2 &&
 		    !mmu_has_feature(MMU_FTR_USE_TLBRSRV) &&
 		    book3e_htw_mode != PPC_HTW_E6500) {
 			/* Should we panic instead? */
@@ -129,18 +129,6 @@ static void setup_tlb_core_data(void)
 }
 #endif
 
-#ifdef CONFIG_SMP
-
-static void check_smt_enabled(void)
-{
-	/* Default to enabling all threads */
-	smt_enabled_at_boot = threads_per_core;
-}
-
-#else
-#define check_smt_enabled()
-#endif /* CONFIG_SMP */
-
 /** Fix up paca fields required for the boot cpu */
 static void fixup_boot_paca(void)
 {
@@ -462,7 +450,6 @@ void __init setup_system(void)
 	xmon_setup();
 
 	smp_setup_cpu_maps();
-	check_smt_enabled();
 	setup_tlb_core_data();
 
 	/*
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8b2d2dc..9577791 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -80,8 +80,6 @@ struct smp_ops_t *smp_ops;
 /* Can't be static due to PowerMac hackery */
 volatile unsigned int cpu_callin_map[NR_CPUS];
 
-int smt_enabled_at_boot = 1;
-
 static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
 
 /*
@@ -95,10 +93,10 @@ int smp_generic_cpu_bootable(unsigned int nr)
 	 * during boot if the user requests it.
 	 */
 	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
-		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
+		if (!threads_per_core && cpu_thread_in_core(nr) != 0)
 			return 0;
-		if (smt_enabled_at_boot
-		    && cpu_thread_in_core(nr) >= smt_enabled_at_boot)
+		if (threads_per_core
+		    && cpu_thread_in_core(nr) >= threads_per_core)
 			return 0;
 	}
 
