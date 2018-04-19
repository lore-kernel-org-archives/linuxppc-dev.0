Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RVNd3zkKzF22y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 17:04:49 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3J74STU014476
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:04:47 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2henp8a0b3-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 03:04:46 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 19 Apr 2018 08:04:44 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: [PATCH v5 04/10] powerpc64/ftrace: Delay enabling ftrace on secondary
 cpus
Date: Thu, 19 Apr 2018 12:34:03 +0530
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <b31df0301885f024ba009badf324d532580ef336.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the boot cpu, though we enable paca->ftrace_enabled in early_setup()
(via cpu_ready_for_interrupts()), we don't start tracing until much
later since ftrace is not initialized yet and since we only support
DYNAMIC_FTRACE on powerpc. However, it is possible that ftrace has been
initialized by the time some of the secondary cpus start up. In this
case, we will try to trace some of the early boot code which can cause
problems.

To address this, move setting paca->ftrace_enabled from
cpu_ready_for_interrupts() to early_setup() for the boot cpu, and towards
the end of start_secondary() for secondary cpus.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup_64.c | 10 +++++++---
 arch/powerpc/kernel/smp.c      |  4 ++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 313136006d1c..7a7ce8ad455e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -252,9 +252,6 @@ static void cpu_ready_for_interrupts(void)
 
 	/* Set IR and DR in PACA MSR */
 	get_paca()->kernel_msr = MSR_KERNEL;
-
-	/* We are now ok to enable ftrace */
-	get_paca()->ftrace_enabled = 1;
 }
 
 unsigned long spr_default_dscr = 0;
@@ -349,6 +346,13 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	cpu_ready_for_interrupts();
 
+	/*
+	 * We enable ftrace here, but since we only support DYNAMIC_FTRACE, it
+	 * will only actually get enabled on the boot cpu much later once
+	 * ftrace itself has been initialized.
+	 */
+	this_cpu_enable_ftrace();
+
 	DBG(" <- early_setup()\n");
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e16ec7b3b427..c4f5dfb686ca 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -59,6 +59,7 @@
 #include <asm/kexec.h>
 #include <asm/asm-prototypes.h>
 #include <asm/cpu_has_feature.h>
+#include <asm/ftrace.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -1031,6 +1032,9 @@ void start_secondary(void *unused)
 
 	local_irq_enable();
 
+	/* We can enable ftrace for secondary cpus now */
+	this_cpu_enable_ftrace();
+
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 
 	BUG();
-- 
2.17.0
