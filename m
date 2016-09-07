Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTdZ21fp7zDrvR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 19:33:30 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u879WSiP043840
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 05:33:28 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25a2xyn2hw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 05:33:28 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 19:33:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BA9313578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 19:33:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u879XMkj3735928
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 19:33:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u879XLa3009788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 19:33:22 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: [PATCH 1/3] arch/powerpc : Add detour buffer support for optprobes
Date: Wed,  7 Sep 2016 15:03:10 +0530
In-Reply-To: <1473240792-10596-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1473240792-10596-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1473240792-10596-2-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Detour buffer contains instructions to create an in memory pt_regs.
After the execution of prehandler a call is made for instruction emulation.
The NIP is decided after the probed instruction is executed. Hence a branch
instruction is created to the NIP returned by emulate_step().

Instruction slot for detour buffer is allocated from the reserved area.
For the time being 64KB is reserved in memory for this purpose.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h   |  24 +++++++
 arch/powerpc/kernel/optprobes_head.S | 119 +++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 arch/powerpc/kernel/optprobes_head.S

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 2c9759bd..2109ce03 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -38,7 +38,25 @@ struct pt_regs;
 struct kprobe;
 
 typedef ppc_opcode_t kprobe_opcode_t;
+
+extern kprobe_opcode_t optinsn_slot;
+/* Optinsn template address */
+extern kprobe_opcode_t optprobe_template_entry[];
+extern kprobe_opcode_t optprobe_template_call_handler[];
+extern kprobe_opcode_t optprobe_template_call_emulate[];
+extern kprobe_opcode_t optprobe_template_ret[];
+extern kprobe_opcode_t optprobe_template_insn[];
+extern kprobe_opcode_t optprobe_template_kp_addr[];
+extern kprobe_opcode_t optprobe_template_op_address1[];
+extern kprobe_opcode_t optprobe_template_end[];
+
 #define MAX_INSN_SIZE 1
+#define MAX_OPTIMIZED_LENGTH	4
+#define MAX_OPTINSN_SIZE				\
+	(((unsigned long)&optprobe_template_end -	\
+	(unsigned long)&optprobe_template_entry) /	\
+	sizeof(kprobe_opcode_t))
+#define RELATIVEJUMP_SIZE	4
 
 #ifdef PPC64_ELF_ABI_v2
 /* PPC64 ABIv2 needs local entry point */
@@ -124,6 +142,12 @@ struct kprobe_ctlblk {
 	struct prev_kprobe prev_kprobe;
 };
 
+struct arch_optimized_insn {
+	kprobe_opcode_t copied_insn[1];
+	/* detour buffer */
+	kprobe_opcode_t *insn;
+};
+
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 					unsigned long val, void *data);
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
new file mode 100644
index 0000000..73db1df
--- /dev/null
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -0,0 +1,119 @@
+/*
+ * Code to prepare detour buffer for optprobes in Kernel.
+ *
+ * Copyright 2016, Anju T, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/ptrace.h>
+#include <asm/asm-offsets.h>
+
+#define	OPT_SLOT_SIZE	65536
+
+.balign	2
+.global optinsn_slot
+optinsn_slot:
+	/* Reserve an area to allocate slots for detour buffer */
+	.space	OPT_SLOT_SIZE
+
+/* Create an in-memory pt_regs */
+.global optprobe_template_entry
+optprobe_template_entry:
+	stdu	r1,-INT_FRAME_SIZE(r1)
+	SAVE_GPR(0,r1)
+	/* Save the previous SP into stack */
+	addi	r0,r1,INT_FRAME_SIZE
+	std	r0,GPR1(r1)
+	SAVE_10GPRS(2,r1)
+	SAVE_10GPRS(12,r1)
+	SAVE_10GPRS(22,r1)
+	/* Save SPRS */
+	mfmsr	r5
+	std	r5,_MSR(r1)
+	li	r5,0
+	std	r5,ORIG_GPR3(r1)
+	std	r5,_TRAP(r1)
+	std	r5,RESULT(r1)
+	mfctr	r5
+	std	r5,_CTR(r1)
+	mflr	r5
+	std	r5,_LINK(r1)
+	mfspr	r5,SPRN_XER
+	std	r5,_XER(r1)
+	mfcr	r5
+	std	r5,_CCR(r1)
+	lbz     r5,PACASOFTIRQEN(r13)
+	std     r5,SOFTE(r1)
+	mfdar	r5
+	std	r5,_DAR(r1)
+	mfdsisr	r5
+	std	r5,_DSISR(r1)
+
+/* Save p->addr into stack */
+.global optprobe_template_kp_addr
+optprobe_template_kp_addr:
+	nop
+	nop
+	nop
+	nop
+	nop
+	std	r3,_NIP(r1)
+
+/* Pass parameters for optimized_callback */
+.global optprobe_template_op_address1
+optprobe_template_op_address1:
+	nop
+	nop
+	nop
+	nop
+	nop
+	addi	r4,r1,STACK_FRAME_OVERHEAD
+
+/* Branch to optimized_callback() */
+.global optprobe_template_call_handler
+optprobe_template_call_handler:
+	nop
+	/* Pass parameters for instruction emulation */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+.global optprobe_template_insn
+optprobe_template_insn:
+	nop
+	nop
+
+/* Branch to instruction emulation  */
+.global optprobe_template_call_emulate
+optprobe_template_call_emulate:
+	nop
+	/* Restore the registers */
+	ld	r5,_MSR(r1)
+	mtmsr	r5
+	ld	r5,_CTR(r1)
+	mtctr	r5
+	ld	r5,_LINK(r1)
+	mtlr	r5
+	ld	r5,_XER(r1)
+	mtxer	r5
+	ld	r5,_CCR(r1)
+	mtcr	r5
+	ld	r5,_DAR(r1)
+	mtdar	r5
+	ld	r5,_DSISR(r1)
+	mtdsisr	r5
+	REST_GPR(0,r1)
+	REST_10GPRS(2,r1)
+	REST_10GPRS(12,r1)
+	REST_10GPRS(22,r1)
+	/* Restore the previous SP */
+	addi	r1,r1,INT_FRAME_SIZE
+
+/* Jump back to the normal workflow from trampoline */
+.global optprobe_template_ret
+optprobe_template_ret:
+	nop
+.global optprobe_template_end
+optprobe_template_end:
-- 
1.8.3.1
