Return-Path: <SRS0=EPkL=OK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25577C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 06:23:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DFE60F23
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 06:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30DFE60F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HCZJL6KL4z3brd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 16:23:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HCZHY5JBXz2yR8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2021 16:23:05 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HCZHL4V0Dz9sSk;
 Mon, 20 Sep 2021 08:22:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wlp_3kevbmPU; Mon, 20 Sep 2021 08:22:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HCZHK1R5Rz9sSm;
 Mon, 20 Sep 2021 08:22:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 106F48B775;
 Mon, 20 Sep 2021 08:22:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id CbjVdiYK0ByM; Mon, 20 Sep 2021 08:22:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E60B28B773;
 Mon, 20 Sep 2021 08:22:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18K6MmwF944817
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Sep 2021 08:22:48 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18K6MmZJ944816;
 Mon, 20 Sep 2021 08:22:48 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 3/3] powerpc/inst: Define ppc_inst_t as u32 on PPC32
Date: Mon, 20 Sep 2021 08:22:44 +0200
Message-Id: <a1bea9a1e31b2d800b4fb4a09132b139e4d0fc70.1632118950.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <9607dfbecab2ecccb712bbd25d2d5da882239d4c.1632118950.git.christophe.leroy@csgroup.eu>
References: <9607dfbecab2ecccb712bbd25d2d5da882239d4c.1632118950.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Unlike PPC64 ABI, PPC32 uses the stack to pass a parameter defined
as a struct, even when the struct has a single simple element.

To avoid that, define ppc_inst_t as u32 on PPC32.

Keep it as 'struct ppc_inst' when __CHECKER__ is defined so that
sparse can perform type checking.

Also revert commit 511eea5e2ccd ("powerpc/kprobes: Fix Oops by passing
ppc_inst as a pointer to emulate_step() on ppc32") as now the
instruction to be emulated is passed as a register to emulate_step().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Make it work with kprobes
---
 arch/powerpc/include/asm/inst.h | 15 +++++++++++++--
 arch/powerpc/kernel/optprobes.c |  8 ++------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 055de1fa5d46..5c503816ebc0 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -34,6 +34,7 @@
  * Instruction data type for POWER
  */
 
+#if defined(CONFIG_PPC64) || defined(__CHECKER__)
 typedef struct {
 	u32 val;
 #ifdef CONFIG_PPC64
@@ -46,13 +47,23 @@ static inline u32 ppc_inst_val(ppc_inst_t x)
 	return x.val;
 }
 
+#define ppc_inst(x) ((ppc_inst_t){ .val = (x) })
+
+#else
+typedef u32 ppc_inst_t;
+
+static inline u32 ppc_inst_val(ppc_inst_t x)
+{
+	return x;
+}
+#define ppc_inst(x) (x)
+#endif
+
 static inline int ppc_inst_primary_opcode(ppc_inst_t x)
 {
 	return ppc_inst_val(x) >> 26;
 }
 
-#define ppc_inst(x) ((ppc_inst_t){ .val = (x) })
-
 #ifdef CONFIG_PPC64
 #define ppc_inst_prefix(x, y) ((ppc_inst_t){ .val = (x), .suffix = (y) })
 
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 04b540c12800..7ab7f65fa6c6 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -228,12 +228,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 3. load instruction to be emulated into relevant register, and
 	 */
-	if (IS_ENABLED(CONFIG_PPC64)) {
-		temp = ppc_inst_read(p->ainsn.insn);
-		patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
-	} else {
-		patch_imm_load_insns((unsigned long)p->ainsn.insn, 4, buff + TMPL_INSN_IDX);
-	}
+	temp = ppc_inst_read(p->ainsn.insn);
+	patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
 
 	/*
 	 * 4. branch back from trampoline
-- 
2.31.1

