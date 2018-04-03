Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G0dH02cpzF29s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 06:12:50 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33KBY88101214
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 16:12:48 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h4fuqhs7f-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 16:12:47 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 21:12:45 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH v4 01/10] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
Date: Wed,  4 Apr 2018 01:42:16 +0530
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <bff5845923c4bea9fa7ef9dcb31a138afe273302.1522784883.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have some C code that we call into from real mode where we cannot
take any exceptions. Though the C functions themselves are mostly safe,
if these functions are traced, there is a possibility that we may take
an exception. For instance, in certain conditions, the ftrace code uses
WARN(), which uses a 'trap' to do its job.

For such scenarios, introduce a new field in paca 'ftrace_enabled',
which is checked on ftrace entry before continuing. This field can then
be set to zero to disable/pause ftrace, and set to a non-zero value to
resume ftrace.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h                |  1 +
 arch/powerpc/kernel/asm-offsets.c              |  1 +
 arch/powerpc/kernel/setup_64.c                 |  3 +++
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 14 ++++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  4 ++++
 5 files changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 4185f1c96125..163f13f31255 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -223,6 +223,7 @@ struct paca_struct {
 	u8 hmi_event_available;		/* HMI event is available */
 	u8 hmi_p9_special_emu;		/* HMI P9 special emulation */
 #endif
+	u8 ftrace_enabled;		/* Hard disable ftrace */
 
 	/* Stuff for accurate time accounting */
 	struct cpu_accounting_data accounting;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6bee65f3cfd3..262c44a90ea1 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -180,6 +180,7 @@ int main(void)
 	OFFSET(PACAKMSR, paca_struct, kernel_msr);
 	OFFSET(PACAIRQSOFTMASK, paca_struct, irq_soft_mask);
 	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
+	OFFSET(PACA_FTRACE_ENABLED, paca_struct, ftrace_enabled);
 #ifdef CONFIG_PPC_BOOK3S
 	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
 #ifdef CONFIG_PPC_MM_SLICES
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 66f2b6299c40..a96ea3bab8f4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -252,6 +252,9 @@ static void cpu_ready_for_interrupts(void)
 
 	/* Set IR and DR in PACA MSR */
 	get_paca()->kernel_msr = MSR_KERNEL;
+
+	/* We are now ok to enable ftrace */
+	get_paca()->ftrace_enabled = 1;
 }
 
 unsigned long spr_default_dscr = 0;
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 3f3e81852422..ae1cbe783ab6 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -47,6 +47,12 @@ _GLOBAL(ftrace_caller)
 	/* Save all gprs to pt_regs */
 	SAVE_GPR(0, r1)
 	SAVE_10GPRS(2, r1)
+
+	/* Ok to continue? */
+	lbz	r3, PACA_FTRACE_ENABLED(r13)
+	cmpdi	r3, 0
+	beq	ftrace_no_trace
+
 	SAVE_10GPRS(12, r1)
 	SAVE_10GPRS(22, r1)
 
@@ -168,6 +174,14 @@ _GLOBAL(ftrace_graph_stub)
 _GLOBAL(ftrace_stub)
 	blr
 
+ftrace_no_trace:
+	mflr	r3
+	mtctr	r3
+	REST_GPR(3, r1)
+	addi	r1, r1, SWITCH_FRAME_SIZE
+	mtlr	r0
+	bctr
+
 #ifdef CONFIG_LIVEPATCH
 	/*
 	 * This function runs in the mcount context, between two functions. As
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.S b/arch/powerpc/kernel/trace/ftrace_64_pg.S
index f095358da96e..b7ba51a0f3b6 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.S
@@ -16,6 +16,10 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL_TOC(ftrace_caller)
+	lbz	r3, PACA_FTRACE_ENABLED(r13)
+	cmpdi	r3, 0
+	beqlr
+
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
 	ld	r11, 0(r1)
-- 
2.16.2
