Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405mdd664XzF1Z9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 21:44:37 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LAiShk147252
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 06:44:35 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gukyxw54m-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 06:44:32 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 10:43:44 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
Subject: [PATCH v2 1/5] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
Date: Wed, 21 Mar 2018 16:13:18 +0530
In-Reply-To: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <b6aff6c7194bd7bb97828db63ca0c82ee4598918.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
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

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Changes since v1:
- Do not guard the paca field check within CONFIG_KVM.
- Move the early return code out of the usual path to optimize for 
  better cache performance in the normal case when ftrace is enabled.

 arch/powerpc/include/asm/paca.h                |  1 +
 arch/powerpc/kernel/asm-offsets.c              |  1 +
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 14 ++++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  4 ++++
 4 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index d2bf71dddbef..4f47adc2a408 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -211,6 +211,7 @@ struct paca_struct {
 	u16 in_mce;
 	u8 hmi_event_available;		/* HMI event is available */
 	u8 hmi_p9_special_emu;		/* HMI P9 special emulation */
+	u8 ftrace_disabled;
 #endif
 
 	/* Stuff for accurate time accounting */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ea5eb91b836e..8e4fc96ff6bc 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -240,6 +240,7 @@ int main(void)
 	OFFSET(PACA_RFI_FLUSH_FALLBACK_AREA, paca_struct, rfi_flush_fallback_area);
 	OFFSET(PACA_EXRFI, paca_struct, exrfi);
 	OFFSET(PACA_L1D_FLUSH_SIZE, paca_struct, l1d_flush_size);
+	OFFSET(PACA_FTRACE_DISABLED, paca_struct, ftrace_disabled);
 
 #endif
 	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 3f3e81852422..8f2380304ef1 100644
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
