Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G0dZ13J8zF298
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 06:13:05 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33KAdEM014121
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 16:13:02 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h4fur1vx3-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 16:13:01 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 21:12:59 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 05/10] powerpc64/ftrace: Delay enabling ftrace on secondary
 cpus
Date: Wed,  4 Apr 2018 01:42:20 +0530
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <5a98bdd70f8a175fe8a136647e93a545fe88d15b.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
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
index a96ea3bab8f4..625833f4099a 100644
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
index cfc08b099c49..d90195dddc57 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -59,6 +59,7 @@
 #include <asm/kexec.h>
 #include <asm/asm-prototypes.h>
 #include <asm/cpu_has_feature.h>
+#include <asm/ftrace.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -1022,6 +1023,9 @@ void start_secondary(void *unused)
 
 	local_irq_enable();
 
+	/* We can enable ftrace for secondary cpus now */
+	this_cpu_enable_ftrace();
+
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 
 	BUG();
-- 
2.16.2
