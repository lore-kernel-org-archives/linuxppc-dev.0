Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404VjS6HPSzF1YG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 20:13:32 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2J99dsP183543
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 05:13:30 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gta3dgsh7-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 05:13:29 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 19 Mar 2018 09:13:27 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 sathnaga@linux.vnet.ibm.com
Subject: [PATCH 1/2] powerpc64/ftrace: Add a field in paca to disable ftrace
 in unsafe code paths
Date: Mon, 19 Mar 2018 14:43:00 +0530
In-Reply-To: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
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

Since KVM is the only user for this currently, we guard the
ftrace/mcount checks within CONFIG_KVM. This can later be removed
if/when there are other users.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h                |  1 +
 arch/powerpc/kernel/asm-offsets.c              |  1 +
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 13 +++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  6 ++++++
 4 files changed, 21 insertions(+)

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
index 3f3e81852422..fdf702b4df25 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -60,6 +60,19 @@ _GLOBAL(ftrace_caller)
 	mfxer   r10
 	mfcr	r11
 
+#ifdef CONFIG_KVM
+	lbz	r3, PACA_FTRACE_DISABLED(r13)
+	cmpdi	r3, 0
+	beq	1f
+	mflr	r3
+	mtctr	r3
+	REST_GPR(3, r1)
+	addi	r1, r1, SWITCH_FRAME_SIZE
+	mtlr	r0
+	bctr
+1:
+#endif
+
 	/* Get the _mcount() call site out of LR */
 	mflr	r7
 	/* Save it as pt_regs->nip */
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.S b/arch/powerpc/kernel/trace/ftrace_64_pg.S
index f095358da96e..5b2a99129322 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.S
@@ -16,6 +16,12 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 _GLOBAL_TOC(ftrace_caller)
+#ifdef CONFIG_KVM
+	lbz	r3, PACA_FTRACE_DISABLED(r13)
+	cmpdi	r3, 0
+	bnelr
+#endif
+
 	/* Taken from output of objdump from lib64/glibc */
 	mflr	r3
 	ld	r11, 0(r1)
-- 
2.16.2
