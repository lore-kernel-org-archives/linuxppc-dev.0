Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7hYM6wjCzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 18:47:03 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v967l0ni141696
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 03:47:01 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2de3tfnqfr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 03:47:01 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 6 Oct 2017 17:46:59 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v967kvGs41615370
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 18:46:57 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v967kvYs000627
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 18:46:57 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 2/3] powerpc/tm: P9 disabled suspend mode workaround
Date: Fri,  6 Oct 2017 18:46:42 +1100
In-Reply-To: <20171006074643.25269-1-cyrilbur@gmail.com>
References: <20171006074643.25269-1-cyrilbur@gmail.com>
Message-Id: <20171006074643.25269-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[from Michael Neulings original patch]
Each POWER9 core is made of two super slices. Each super slice can
only have one thread at a time in TM suspend mode. The super slice
restricts ever entering a state where both threads are in suspend by
aborting transactions on tsuspend or exceptions into the kernel.

Unfortunately for context switch we need trechkpt which forces suspend
mode. If a thread is already in suspend and a second thread needs to
be restored that was suspended, the trechkpt must be executed.
Currently the trechkpt will hang in this case until the other thread
exits suspend. This causes problems for Linux resulting in hang and
RCU stall detectors going off.

To workaround this, we disable suspend in the core. This is done via a
firmware change which stops the hardware ever getting into suspend.
The hardware will always rollback a transaction on any tsuspend or
entry into the kernel.

[added by Cyril Bur]
As the no-suspend firmware change is novel and untested using it should
be opt in by users. Furthumore, currently the kernel has no method to
know if the firmware has applied the no-suspend workaround. This patch
extends the ppc_tm commandline option to allow users to opt-in if they
are sure that their firmware has been updated and they understand the
risks involed.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++--
 arch/powerpc/include/asm/cputable.h             |  6 ++++++
 arch/powerpc/include/asm/tm.h                   |  6 ++++--
 arch/powerpc/kernel/cputable.c                  | 12 ++++++++++++
 arch/powerpc/kernel/setup_64.c                  | 16 ++++++++++------
 5 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4e2b5d9078a0..a0f757f749cf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -805,8 +805,11 @@
 			Disable RADIX MMU mode on POWER9
 
 	ppc_tm=		[PPC]
-			Format: {"off"}
-			Disable Hardware Transactional Memory
+			Format: {"off" | "no-suspend"}
+			"Off" Will disable Hardware Transactional Memory.
+			"no-suspend" Informs the kernel that the
+			hardware will not transition into the kernel
+			with a suspended transaction.
 
 	disable_cpu_apicid= [X86,APIC,SMP]
 			Format: <int>
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a9bf921f4efc..e66101830af2 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -124,6 +124,12 @@ extern void identify_cpu_name(unsigned int pvr);
 extern void do_feature_fixups(unsigned long value, void *fixup_start,
 			      void *fixup_end);
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+extern bool tm_suspend_supported(void);
+#else
+static inline bool tm_suspend_supported(void) { return false; }
+#endif
+
 extern const char *powerpc_base_platform;
 
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
index eca1c866ca97..1fd0b5f72861 100644
--- a/arch/powerpc/include/asm/tm.h
+++ b/arch/powerpc/include/asm/tm.h
@@ -9,9 +9,11 @@
 
 #ifndef __ASSEMBLY__
 
-#define TM_STATE_ON	0
-#define TM_STATE_OFF	1
+#define TM_STATE_ON		0
+#define TM_STATE_OFF		1
+#define TM_STATE_NO_SUSPEND	2
 
+extern int ppc_tm_state;
 extern void tm_enable(void);
 extern void tm_reclaim(struct thread_struct *thread,
 		       unsigned long orig_msr, uint8_t cause);
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 760872916013..2cb01b48123a 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -22,6 +22,7 @@
 #include <asm/prom.h>		/* for PTRRELOC on ARCH=ppc */
 #include <asm/mmu.h>
 #include <asm/setup.h>
+#include <asm/tm.h>
 
 static struct cpu_spec the_cpu_spec __read_mostly;
 
@@ -2301,6 +2302,17 @@ void __init identify_cpu_name(unsigned int pvr)
 	}
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+bool tm_suspend_supported(void)
+{
+	if (cpu_has_feature(CPU_FTR_TM)) {
+		if (pvr_version_is(PVR_POWER9) && ppc_tm_state != TM_STATE_NO_SUSPEND)
+			return false;
+		return true;
+	}
+	return false;
+}
+#endif
 
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
 struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS] = {
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e37c26d2e54b..227ac600a1b7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -251,12 +251,14 @@ static void cpu_ready_for_interrupts(void)
 	get_paca()->kernel_msr = MSR_KERNEL;
 }
 
+int ppc_tm_state;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-static int ppc_tm_state;
 static int __init parse_ppc_tm(char *p)
 {
 	if (strcmp(p, "off") == 0)
 		ppc_tm_state = TM_STATE_OFF;
+	else if (strcmp(p, "no-suspend") == 0)
+		ppc_tm_state = TM_STATE_NO_SUSPEND;
 	else
 		printk(KERN_NOTICE "Unknown value to cmdline ppc_tm '%s'\n", p);
 	return 0;
@@ -265,11 +267,13 @@ early_param("ppc_tm", parse_ppc_tm);
 
 static void check_disable_tm(void)
 {
-	if (cpu_has_feature(CPU_FTR_TM) && ppc_tm_state == TM_STATE_OFF) {
-		printk(KERN_NOTICE "Disabling hardware transactional memory (HTM)\n");
-		cur_cpu_spec->cpu_user_features2 &=
-			~(PPC_FEATURE2_HTM_NOSC | PPC_FEATURE2_HTM);
-		cur_cpu_spec->cpu_features &= ~CPU_FTR_TM;
+	if (cpu_has_feature(CPU_FTR_TM)) {
+		if (ppc_tm_state == TM_STATE_OFF || (!tm_suspend_supported())) {
+			printk(KERN_NOTICE "Disabling hardware transactional memory (HTM)\n");
+			cur_cpu_spec->cpu_user_features2 &=
+				~(PPC_FEATURE2_HTM_NOSC | PPC_FEATURE2_HTM);
+			cur_cpu_spec->cpu_features &= ~CPU_FTR_TM;
+		}
 	}
 }
 #else
-- 
2.14.2
