Return-Path: <srs0=mudr=kw=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lGng2w9rzDqMh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 00:17:59 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41lGng24Bxz8t21
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 00:17:59 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41lGnf433Sz9s3x
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2018 00:17:58 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w77EGsT7025876
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2018 10:17:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kqcpb94e2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Aug 2018 10:17:56 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 7 Aug 2018 15:17:54 +0100
Subject: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery action
 on MCE.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 07 Aug 2018 19:47:49 +0530
In-Reply-To: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Introduce recovery action for recovered memory errors (MCEs). There are
soft memory errors like SLB Multihit, which can be a result of a bad
hardware OR software BUG. Kernel can easily recover from these soft errors
by flushing SLB contents. After the recovery kernel can still continue to
function without any issue. But in some scenario's we may keep getting
these soft errors until the root cause is fixed. To be able to analyze and
find the root cause, best way is to gather enough data and system state at
the time of MCE. Hence this patch introduces a sysctl knob where user can
decide either to continue after recovery or panic the kernel to capture the
dump. This will allow one to configure a kernel to capture a dump on MCE
and then toggle back to recovery while dump is being analyzed.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h         |    2 +
 arch/powerpc/kernel/mce.c              |   58 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/traps.c            |    3 +-
 arch/powerpc/platforms/powernv/setup.c |    4 ++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 3a1226e9b465..d46e1903878d 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -202,6 +202,8 @@ struct mce_error_info {
 #define MCE_EVENT_RELEASE	true
 #define MCE_EVENT_DONTRELEASE	false
 
+extern int recover_on_mce;
+
 extern void save_mce_event(struct pt_regs *regs, long handled,
 			   struct mce_error_info *mce_err, uint64_t nip,
 			   uint64_t addr, uint64_t phys_addr);
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index ae17d8aa60c4..5e2ab5cade81 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -28,6 +28,7 @@
 #include <linux/percpu.h>
 #include <linux/export.h>
 #include <linux/irq_work.h>
+#include <linux/moduleparam.h>
 
 #include <asm/machdep.h>
 #include <asm/mce.h>
@@ -631,3 +632,60 @@ long hmi_exception_realmode(struct pt_regs *regs)
 
 	return 1;
 }
+
+/*
+ * Recovery action for recovered memory errors.
+ *
+ * There are soft memory errors like SLB Multihit, which can be a result of
+ * a bad hardware OR software BUG. Kernel can easily recover from these
+ * soft errors by flushing SLB contents. After the recovery kernel can
+ * still continue to function without any issue. But in some scenario's we
+ * may keep getting these soft errors until the root cause is fixed. To be
+ * able to analyze and find the root cause, best way is to gather enough
+ * data and system state at the time of MCE. Introduce a sysctl knob where
+ * user can decide either to continue after recovery or panic the kernel
+ * to capture the dump. This will allow one to configure a kernel to capture
+ * dump on MCE and then toggle back to recovery while dump is being analyzed.
+ *
+ * recover_on_mce == 0
+ *	panic/crash the kernel to trigger dump capture.
+ *
+ * recover_on_mce == 1
+ *	continue after MCE recovery. (no panic)
+ */
+int recover_on_mce;
+
+#ifdef CONFIG_SYSCTL
+/*
+ * Register the sysctl to define memory error recovery action.
+ */
+static struct ctl_table machine_check_ctl_table[] = {
+	{
+		.procname	= "recover_on_mce",
+		.data		= &recover_on_mce,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{}
+};
+
+static struct ctl_table machine_check_sysctl_root[] = {
+	{
+		.procname	= "kernel",
+		.mode		= 0555,
+		.child		= machine_check_ctl_table,
+	},
+	{}
+};
+
+static int __init register_machine_check_sysctl(void)
+{
+	register_sysctl_table(machine_check_sysctl_root);
+
+	return 0;
+}
+__initcall(register_machine_check_sysctl);
+#endif /* CONFIG_SYSCTL */
+
+core_param(recover_on_mce, recover_on_mce, int, 0644);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0e17dcb48720..246477c790e8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -70,6 +70,7 @@
 #include <asm/hmi.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/kprobes.h>
+#include <asm/mce.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -727,7 +728,7 @@ void machine_check_exception(struct pt_regs *regs)
 	else if (cur_cpu_spec->machine_check)
 		recover = cur_cpu_spec->machine_check(regs);
 
-	if (recover > 0)
+	if ((recover > 0) && recover_on_mce)
 		goto bail;
 
 	if (debugger_fault_handler(regs))
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index b74c93bc2e55..d13278029a94 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -39,6 +39,7 @@
 #include <asm/tm.h>
 #include <asm/setup.h>
 #include <asm/security_features.h>
+#include <asm/mce.h>
 
 #include "powernv.h"
 
@@ -147,6 +148,9 @@ static void __init pnv_setup_arch(void)
 	/* Enable NAP mode */
 	powersave_nap = 1;
 
+	/* Recovery action on recovered MCE. By default enable it on PowerNV */
+	recover_on_mce = 1;
+
 	/* XXX PMCS */
 }
 
