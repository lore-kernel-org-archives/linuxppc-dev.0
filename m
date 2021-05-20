Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC268C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 10:27:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5773E6101D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 10:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5773E6101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm5Wm0wm2z3dnX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 20:27:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fm5S54cSPz30GS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 20:23:49 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Fm5RQ2v8gz9sVm;
 Thu, 20 May 2021 12:23:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dn2kJFgc0MQA; Thu, 20 May 2021 12:23:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5RM6twqz9sVn;
 Thu, 20 May 2021 12:23:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C927A8B811;
 Thu, 20 May 2021 12:23:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hK2vq42UamoL; Thu, 20 May 2021 12:23:11 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.105])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AE8B8B80D;
 Thu, 20 May 2021 12:23:11 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8361B64C44; Thu, 20 May 2021 10:23:11 +0000 (UTC)
Message-Id: <ad46c195ca1b8572629ef07ba6bfe247585239a6.1621506159.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 12/12] powerpc: Replace PPC_INST_NOP by PPC_RAW_NOP()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Date: Thu, 20 May 2021 10:23:11 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On the road to removing all PPC_INST_xx defines in
asm/ppc-opcodes.h, change PPC_INST_NOP to PPC_RAW_NOP().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 3 +--
 arch/powerpc/kernel/crash_dump.c      | 2 +-
 arch/powerpc/kernel/jump_label.c      | 2 +-
 arch/powerpc/kernel/setup_32.c        | 2 +-
 arch/powerpc/lib/test_emulate_step.c  | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 2e428ed7511a..f32fb4852b94 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -261,7 +261,6 @@
 #define PPC_INST_MFSPR_PVR		0x7c1f42a6
 #define PPC_INST_MFSPR_PVR_MASK		0xfc1ffffe
 #define PPC_INST_MTMSRD			0x7c000164
-#define PPC_INST_NOP			0x60000000
 #define PPC_INST_POPCNTB		0x7c0000f4
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
 #define PPC_INST_RFEBB			0x4c000124
@@ -475,7 +474,7 @@
 #define PPC_RAW_ADD_DOT(t, a, b)	(PPC_INST_ADD | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | 0x1)
 #define PPC_RAW_ADDC(t, a, b)		(0x7c000014 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_ADDC_DOT(t, a, b)	(0x7c000014 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | 0x1)
-#define PPC_RAW_NOP()			(PPC_INST_NOP)
+#define PPC_RAW_NOP()			PPC_RAW_ORI(0, 0, 0)
 #define PPC_RAW_BLR()			(0x4e800020)
 #define PPC_RAW_BLRL()			(0x4e800021)
 #define PPC_RAW_MTLR(r)			(0x7c0803a6 | ___PPC_RT(r))
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 735e89337398..adb39da684be 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -45,7 +45,7 @@ static void __init create_trampoline(unsigned long addr)
 	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
 	 * two instructions it doesn't require any registers.
 	 */
-	patch_instruction(p, ppc_inst(PPC_INST_NOP));
+	patch_instruction(p, ppc_inst(PPC_RAW_NOP()));
 	patch_branch((void *)p + 4, addr + PHYSICAL_START, 0);
 }
 
diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
index ce87dc5ea23c..90c97246384c 100644
--- a/arch/powerpc/kernel/jump_label.c
+++ b/arch/powerpc/kernel/jump_label.c
@@ -16,5 +16,5 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	if (type == JUMP_LABEL_JMP)
 		patch_branch(addr, jump_entry_target(entry), 0);
 	else
-		patch_instruction(addr, ppc_inst(PPC_INST_NOP));
+		patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
 }
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index d7c1f92152af..a369fb27ccaa 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -85,7 +85,7 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
-	patch_instruction_site(&patch__memcpy_nocache, ppc_inst(PPC_INST_NOP));
+	patch_instruction_site(&patch__memcpy_nocache, ppc_inst(PPC_RAW_NOP()));
 
 	create_cond_branch(&insn, addr, branch_target(addr), 0x820000);
 	patch_instruction(addr, insn);	/* replace b by bne cr0 */
diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index f7c74f4f684b..f0ebb5349f58 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -920,7 +920,7 @@ static struct compute_test compute_tests[] = {
 		.subtests = {
 			{
 				.descr = "R0 = LONG_MAX",
-				.instr = ppc_inst(PPC_INST_NOP),
+				.instr = ppc_inst(PPC_RAW_NOP()),
 				.regs = {
 					.gpr[0] = LONG_MAX,
 				}
-- 
2.25.0

