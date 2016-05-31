Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJr7p0stdzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:58:29 +1000 (AEST)
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4VAsipr035715
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 06:58:27 -0400
Message-Id: <201605311058.u4VAsipr035715@mx0a-001b2d01.pphosted.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2395tsnw8v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 06:58:27 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 31 May 2016 20:58:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 190B72CE8067
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:58:09 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4VAvl7I7143636
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:58:09 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4VAur6n029852
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:56:54 +1000
From: Anju T <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: anju@linux.vnet.ibm.com, ananth@in.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org, anjutsudhakar@gmail.com
Subject: [RFC PATCH v3 1/3] arch/powerpc : Add detour buffer support for
 optprobes
Date: Tue, 31 May 2016 16:26:29 +0530
In-Reply-To: <1464692191-1167-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1464692191-1167-1-git-send-email-anju@linux.vnet.ibm.com>
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

Instruction slot for detour buffer is allocated from
the reserved area. For the time being 64KB is reserved
in memory for this purpose.

Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h   |  27 +++++++
 arch/powerpc/kernel/optprobes_head.S | 136 +++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 arch/powerpc/kernel/optprobes_head.S

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 039b583..1cb2527 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -38,7 +38,27 @@ struct pt_regs;
 struct kprobe;
 
 typedef ppc_opcode_t kprobe_opcode_t;
+
+extern kprobe_opcode_t optinsn_slot;
+/* Optinsn template address */
+extern kprobe_opcode_t optprobe_template_entry[];
+extern kprobe_opcode_t optprobe_template_call_handler[];
+extern kprobe_opcode_t optprobe_template_call_emulate[];
+extern kprobe_opcode_t optprobe_template_ret_branch[];
+extern kprobe_opcode_t optprobe_template_ret[];
+extern kprobe_opcode_t optprobe_template_insn[];
+extern kprobe_opcode_t optprobe_template_kp_addr[];
+extern kprobe_opcode_t optprobe_template_op_address1[];
+extern kprobe_opcode_t optprobe_template_op_address2[];
+extern kprobe_opcode_t optprobe_template_end[];
+
 #define MAX_INSN_SIZE 1
+#define MAX_OPTIMIZED_LENGTH    4
+#define	MAX_OPTINSN_SIZE				\
+	(((unsigned long)&optprobe_template_end -	\
+	(unsigned long)&optprobe_template_entry) /	\
+	sizeof(kprobe_opcode_t))
+#define RELATIVEJUMP_SIZE       4
 
 #ifdef CONFIG_PPC64
 #if defined(_CALL_ELF) && _CALL_ELF == 2
@@ -129,5 +149,12 @@ struct kprobe_ctlblk {
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 					unsigned long val, void *data);
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+
+struct arch_optimized_insn {
+	kprobe_opcode_t copied_insn[1];
+	/* detour buffer */
+	kprobe_opcode_t *insn;
+};
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_KPROBES_H */
diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
new file mode 100644
index 0000000..b2536bc
--- /dev/null
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -0,0 +1,136 @@
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
+.align	2
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
+	std	0,GPR1(r1)
+	SAVE_2GPRS(2,r1)
+	SAVE_8GPRS(4,r1)
+	SAVE_10GPRS(12,r1)
+	SAVE_10GPRS(22,r1)
+	/* Save SPRS */
+	mfmsr	r5
+	std	r5,_MSR(r1)
+	li	r5,0
+	std	r5,ORIG_GPR3(r1)
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
+	li	r5,0
+	std	r5,_TRAP(r1)
+	mfdar	r5
+	std	r5,_DAR(r1)
+	mfdsisr	r5
+	std	r5,_DSISR(r1)
+	li	r5,0
+	std	r5,RESULT(r1)
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
+/* Branch to the prehandler */
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
+.global optprobe_template_op_address2
+optprobe_template_op_address2:
+	nop
+	nop
+	nop
+	nop
+	nop
+	addi	r4,r1,STACK_FRAME_OVERHEAD
+
+/* Branch to create_return_branch() function */
+.global optprobe_template_ret_branch
+optprobe_template_ret_branch:
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
+	REST_2GPRS(2,r1)
+	REST_8GPRS(4,r1)
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
2.1.0
