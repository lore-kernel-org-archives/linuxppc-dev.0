Return-Path: <SRS0=tyeE=KO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A557C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 14:45:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15826105A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 14:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15826105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FlbJb25YYz3cP7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 00:45:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FlbGl0hTwz3btB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 00:43:59 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FlbGF23TLz9sWZ;
 Wed, 19 May 2021 16:43:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 92Rab5616n9s; Wed, 19 May 2021 16:43:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FlbGF17XKz9sWQ;
 Wed, 19 May 2021 16:43:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 08EAB8B7F5;
 Wed, 19 May 2021 16:43:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KkyQeilSit6h; Wed, 19 May 2021 16:43:32 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B47A08B7E0;
 Wed, 19 May 2021 16:43:32 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 9269564C3A; Wed, 19 May 2021 14:43:32 +0000 (UTC)
Message-Id: <c97509c8a3efb4d673bdc8a601620cf32fcba22b.1621435024.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621435024.git.christophe.leroy@csgroup.eu>
References: <cover.1621435024.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 05/12] powerpc: Do not dereference code as 'struct
 ppc_inst' (uprobe, code-patching, feature-fixups)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Date: Wed, 19 May 2021 14:43:32 +0000 (UTC)
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

'struct ppc_inst' is an internal structure to represent an instruction,
it is not directly the representation of that instruction in text code.
It is not meant to map and dereference code.

Dereferencing code directly through 'struct ppc_inst' has two main issues:
- On powerpc, structs are expected to be 8 bytes aligned while code is
spread every 4 byte.
- Should a non prefixed instruction lie at the end of the page and the
following page not be mapped, it would generate a page fault.

In-memory code must be accessed with ppc_inst_read().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/uprobes.c     | 2 +-
 arch/powerpc/lib/code-patching.c  | 8 ++++----
 arch/powerpc/lib/feature-fixups.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index 186f69b11e94..46971bb41d05 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -42,7 +42,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
 		return -EINVAL;
 
 	if (cpu_has_feature(CPU_FTR_ARCH_31) &&
-	    ppc_inst_prefixed(auprobe->insn) &&
+	    ppc_inst_prefixed(ppc_inst_read(&auprobe->insn)) &&
 	    (addr & 0x3f) == 60) {
 		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
 		return -EINVAL;
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 870b30d9be2f..0308429b0d1a 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -329,13 +329,13 @@ static unsigned long branch_iform_target(const struct ppc_inst *instr)
 {
 	signed long imm;
 
-	imm = ppc_inst_val(*instr) & 0x3FFFFFC;
+	imm = ppc_inst_val(ppc_inst_read(instr)) & 0x3FFFFFC;
 
 	/* If the top bit of the immediate value is set this is negative */
 	if (imm & 0x2000000)
 		imm -= 0x4000000;
 
-	if ((ppc_inst_val(*instr) & BRANCH_ABSOLUTE) == 0)
+	if ((ppc_inst_val(ppc_inst_read(instr)) & BRANCH_ABSOLUTE) == 0)
 		imm += (unsigned long)instr;
 
 	return (unsigned long)imm;
@@ -345,13 +345,13 @@ static unsigned long branch_bform_target(const struct ppc_inst *instr)
 {
 	signed long imm;
 
-	imm = ppc_inst_val(*instr) & 0xFFFC;
+	imm = ppc_inst_val(ppc_inst_read(instr)) & 0xFFFC;
 
 	/* If the top bit of the immediate value is set this is negative */
 	if (imm & 0x8000)
 		imm -= 0x10000;
 
-	if ((ppc_inst_val(*instr) & BRANCH_ABSOLUTE) == 0)
+	if ((ppc_inst_val(ppc_inst_read(instr)) & BRANCH_ABSOLUTE) == 0)
 		imm += (unsigned long)instr;
 
 	return (unsigned long)imm;
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index fe26f2fa0f3f..8905b53109bc 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -51,7 +51,7 @@ static int patch_alt_instruction(struct ppc_inst *src, struct ppc_inst *dest,
 
 	instr = ppc_inst_read(src);
 
-	if (instr_is_relative_branch(*src)) {
+	if (instr_is_relative_branch(ppc_inst_read(src))) {
 		struct ppc_inst *target = (struct ppc_inst *)branch_target(src);
 
 		/* Branch within the section doesn't need translating */
-- 
2.25.0

