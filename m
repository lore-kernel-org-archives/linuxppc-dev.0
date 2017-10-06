Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7hYL71lSzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 18:47:01 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v967ir46029828
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 03:47:00 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2de41cn730-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 03:46:59 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 6 Oct 2017 17:46:57 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v967ktN013566038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 18:46:55 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v967ktPe000590
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 18:46:55 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 1/3] powerpc/tm: Add commandline option to disable hardware
 transactional memory
Date: Fri,  6 Oct 2017 18:46:41 +1100
Message-Id: <20171006074643.25269-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kernel relies on firmware to inform it whether or not the
CPU supports HTM and as long as the kernel was built with
CONFIG_PPC_TRANSACTIONAL_MEM=y then it will allow userspace to make use
of the facility.

There may be situations where it would be advantageous for the kernel
to not allow userspace to use HTM, currently the only way to achieve
this is to recompile the kernel with CONFIG_PPC_TRANSACTIONAL_MEM=n.

This patch adds a simple commandline option so that HTM can be disabled
at boot time.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/powerpc/include/asm/tm.h                   |  3 +++
 arch/powerpc/kernel/setup_64.c                  | 28 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 05496622b4ef..4e2b5d9078a0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -804,6 +804,10 @@
 	disable_radix	[PPC]
 			Disable RADIX MMU mode on POWER9
 
+	ppc_tm=		[PPC]
+			Format: {"off"}
+			Disable Hardware Transactional Memory
+
 	disable_cpu_apicid= [X86,APIC,SMP]
 			Format: <int>
 			The number of initial APIC ID for the
diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
index 82e06ca3a49b..eca1c866ca97 100644
--- a/arch/powerpc/include/asm/tm.h
+++ b/arch/powerpc/include/asm/tm.h
@@ -9,6 +9,9 @@
 
 #ifndef __ASSEMBLY__
 
+#define TM_STATE_ON	0
+#define TM_STATE_OFF	1
+
 extern void tm_enable(void);
 extern void tm_reclaim(struct thread_struct *thread,
 		       unsigned long orig_msr, uint8_t cause);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b89c6aac48c9..e37c26d2e54b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,6 +68,7 @@
 #include <asm/livepatch.h>
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
+#include <asm/tm.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -250,6 +251,31 @@ static void cpu_ready_for_interrupts(void)
 	get_paca()->kernel_msr = MSR_KERNEL;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static int ppc_tm_state;
+static int __init parse_ppc_tm(char *p)
+{
+	if (strcmp(p, "off") == 0)
+		ppc_tm_state = TM_STATE_OFF;
+	else
+		printk(KERN_NOTICE "Unknown value to cmdline ppc_tm '%s'\n", p);
+	return 0;
+}
+early_param("ppc_tm", parse_ppc_tm);
+
+static void check_disable_tm(void)
+{
+	if (cpu_has_feature(CPU_FTR_TM) && ppc_tm_state == TM_STATE_OFF) {
+		printk(KERN_NOTICE "Disabling hardware transactional memory (HTM)\n");
+		cur_cpu_spec->cpu_user_features2 &=
+			~(PPC_FEATURE2_HTM_NOSC | PPC_FEATURE2_HTM);
+		cur_cpu_spec->cpu_features &= ~CPU_FTR_TM;
+	}
+}
+#else
+static void check_disable_tm(void) { }
+#endif
+
 /*
  * Early initialization entry point. This is called by head.S
  * with MMU translation disabled. We rely on the "feature" of
@@ -299,6 +325,8 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	early_init_devtree(__va(dt_ptr));
 
+	check_disable_tm();
+
 	/* Now we know the logical id of our boot cpu, setup the paca. */
 	setup_paca(&paca[boot_cpuid]);
 	fixup_boot_paca();
-- 
2.14.2
