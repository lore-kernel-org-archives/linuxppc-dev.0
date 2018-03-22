Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406N9X3qvpzF1sl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 21:25:52 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MAP8in138545
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:25:48 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gv5e04hdk-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:25:47 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 10:25:44 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
Subject: [PATCH v3 1/6] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
Date: Thu, 22 Mar 2018 15:55:21 +0530
In-Reply-To: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <fa3e12766e7dd9e28ebea36a7eadab1e2782515c.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
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

For such scenarios, introduce a new field in paca 'ftrace_disabled',
which is checked on ftrace entry before continuing. This field can then
be set to a non-zero value to disable/pause ftrace, and reset to zero to
resume ftrace.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Changes since v2:
- Move paca->ftrace_disabled out of CONFIG_BOOK3S_64.
- Disable tracing when asked for, not the other way around.


 arch/powerpc/include/asm/paca.h                |  1 +
 arch/powerpc/kernel/asm-offsets.c              |  1 +
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 14 ++++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  4 ++++
 4 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index d2bf71dddbef..5be57c20c8c5 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -164,6 +164,7 @@ struct paca_struct {
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
+	u8 ftrace_disabled;		/* Hard disable ftrace */
 	u64 sprg_vdso;			/* Saved user-visible sprg */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
	u64 tm_scratch;                 /* TM scratch area for reclaim 
*/
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ea5eb91b836e..775c847f0e33 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -180,6 +180,7 @@ int main(void)
 	OFFSET(PACAKMSR, paca_struct, kernel_msr);
 	OFFSET(PACAIRQSOFTMASK, paca_struct, irq_soft_mask);
 	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
+	OFFSET(PACA_FTRACE_DISABLED, paca_struct, ftrace_disabled);
 #ifdef CONFIG_PPC_BOOK3S
 	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
 #ifdef CONFIG_PPC_MM_SLICES
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 3f3e81852422..9d234835e1e6 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -47,6 +47,12 @@ _GLOBAL(ftrace_caller)
 	/* Save all gprs to pt_regs */
 	SAVE_GPR(0, r1)
 	SAVE_10GPRS(2, r1)
+
+	/* Ok to continue? */
+	lbz	r3, PACA_FTRACE_DISABLED(r13)
+	cmpdi	r3, 0
+	bne	ftrace_no_trace
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
index f095358da96e..3d8186832a34 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.S
@@ -16,6 +16,10 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL_TOC(ftrace_caller)
+	lbz	r3, PACA_FTRACE_DISABLED(r13)
+	cmpdi	r3, 0
+	bnelr
+
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
 	ld	r11, 0(r1)
-- 
2.16.2
