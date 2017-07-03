Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2f5SbjzDr4L
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:02:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 04/10] powerpc/kprobes/optprobes: Use patch_instruction()
Date: Mon,  3 Jul 2017 23:01:48 +1000
Message-Id: <1499086914-25695-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

So that we can implement STRICT_RWX, use patch_instruction() in
optprobes.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/optprobes.c | 53 +++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index ec60ed0d4aad..6f8273f5e988 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -158,12 +158,13 @@ void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
 void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
 {
 	/* addis r4,0,(insn)@h */
-	*addr++ = PPC_INST_ADDIS | ___PPC_RT(4) |
-		  ((val >> 16) & 0xffff);
+	patch_instruction(addr, PPC_INST_ADDIS | ___PPC_RT(4) |
+			  ((val >> 16) & 0xffff));
+	addr++;
 
 	/* ori r4,r4,(insn)@l */
-	*addr = PPC_INST_ORI | ___PPC_RA(4) | ___PPC_RS(4) |
-		(val & 0xffff);
+	patch_instruction(addr, PPC_INST_ORI | ___PPC_RA(4) |
+			  ___PPC_RS(4) | (val & 0xffff));
 }
 
 /*
@@ -173,24 +174,28 @@ void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
 void patch_imm64_load_insns(unsigned long val, kprobe_opcode_t *addr)
 {
 	/* lis r3,(op)@highest */
-	*addr++ = PPC_INST_ADDIS | ___PPC_RT(3) |
-		  ((val >> 48) & 0xffff);
+	patch_instruction(addr, PPC_INST_ADDIS | ___PPC_RT(3) |
+			  ((val >> 48) & 0xffff));
+	addr++;
 
 	/* ori r3,r3,(op)@higher */
-	*addr++ = PPC_INST_ORI | ___PPC_RA(3) | ___PPC_RS(3) |
-		  ((val >> 32) & 0xffff);
+	patch_instruction(addr, PPC_INST_ORI | ___PPC_RA(3) |
+			  ___PPC_RS(3) | ((val >> 32) & 0xffff));
+	addr++;
 
 	/* rldicr r3,r3,32,31 */
-	*addr++ = PPC_INST_RLDICR | ___PPC_RA(3) | ___PPC_RS(3) |
-		  __PPC_SH64(32) | __PPC_ME64(31);
+	patch_instruction(addr, PPC_INST_RLDICR | ___PPC_RA(3) |
+			  ___PPC_RS(3) | __PPC_SH64(32) | __PPC_ME64(31));
+	addr++;
 
 	/* oris r3,r3,(op)@h */
-	*addr++ = PPC_INST_ORIS | ___PPC_RA(3) | ___PPC_RS(3) |
-		  ((val >> 16) & 0xffff);
+	patch_instruction(addr, PPC_INST_ORIS | ___PPC_RA(3) |
+			  ___PPC_RS(3) | ((val >> 16) & 0xffff));
+	addr++;
 
 	/* ori r3,r3,(op)@l */
-	*addr = PPC_INST_ORI | ___PPC_RA(3) | ___PPC_RS(3) |
-		(val & 0xffff);
+	patch_instruction(addr, PPC_INST_ORI | ___PPC_RA(3) |
+			  ___PPC_RS(3) | (val & 0xffff));
 }
 
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
@@ -198,7 +203,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	kprobe_opcode_t *buff, branch_op_callback, branch_emulate_step;
 	kprobe_opcode_t *op_callback_addr, *emulate_step_addr;
 	long b_offset;
-	unsigned long nip;
+	unsigned long nip, size;
+	int rc, i;
 
 	kprobe_ppc_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
 
@@ -231,8 +237,14 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 		goto error;
 
 	/* Setup template */
-	memcpy(buff, optprobe_template_entry,
-			TMPL_END_IDX * sizeof(kprobe_opcode_t));
+	/* We can optimize this via patch_instruction_window later */
+	size = (TMPL_END_IDX * sizeof(kprobe_opcode_t)) / sizeof(int);
+	pr_devel("Copying template to %p, size %lu\n", buff, size);
+	for (i = 0; i < size; i++) {
+		rc = patch_instruction(buff + i, *(optprobe_template_entry + i));
+		if (rc < 0)
+			goto error;
+	}
 
 	/*
 	 * Fixup the template with instructions to:
@@ -261,8 +273,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	if (!branch_op_callback || !branch_emulate_step)
 		goto error;
 
-	buff[TMPL_CALL_HDLR_IDX] = branch_op_callback;
-	buff[TMPL_EMULATE_IDX] = branch_emulate_step;
+	patch_instruction(buff + TMPL_CALL_HDLR_IDX, branch_op_callback);
+	patch_instruction(buff + TMPL_EMULATE_IDX, branch_emulate_step);
 
 	/*
 	 * 3. load instruction to be emulated into relevant register, and
@@ -272,8 +284,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 4. branch back from trampoline
 	 */
-	buff[TMPL_RET_IDX] = create_branch((unsigned int *)buff + TMPL_RET_IDX,
-				(unsigned long)nip, 0);
+	patch_branch(buff + TMPL_RET_IDX, (unsigned long)nip, 0);
 
 	flush_icache_range((unsigned long)buff,
 			   (unsigned long)(&buff[TMPL_END_IDX]));
-- 
2.7.4
