Return-Path: <SRS0=tyeE=KO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C1C43461
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 14:45:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CEC6105A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 May 2021 14:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CEC6105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FlbJw4yL9z3clx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 00:45:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FlbGq3Cq2z3bvb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 00:44:03 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FlbGH2KGpz9sWQ;
 Wed, 19 May 2021 16:43:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yf9JZc7iPBdr; Wed, 19 May 2021 16:43:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FlbGG2RyQz9sWd;
 Wed, 19 May 2021 16:43:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 351648B7F5;
 Wed, 19 May 2021 16:43:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zVOjQBeh0yZF; Wed, 19 May 2021 16:43:34 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D1B598B7E0;
 Wed, 19 May 2021 16:43:33 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A71BD64C3A; Wed, 19 May 2021 14:43:33 +0000 (UTC)
Message-Id: <24b14702124210d9a6820100a1af1aa2a4cc44da.1621435024.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621435024.git.christophe.leroy@csgroup.eu>
References: <cover.1621435024.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 06/12] powerpc/lib/code-patching: Make
 instr_is_branch_to_addr() static
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Date: Wed, 19 May 2021 14:43:33 +0000 (UTC)
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

instr_is_branch_to_addr() is only used in code-patching.c

Make it static.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h |  1 -
 arch/powerpc/lib/code-patching.c         | 18 +++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index f1d029bf906e..f9bd1397b696 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -59,7 +59,6 @@ static inline int modify_instruction_site(s32 *site, unsigned int clr, unsigned
 
 int instr_is_relative_branch(struct ppc_inst instr);
 int instr_is_relative_link_branch(struct ppc_inst instr);
-int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr);
 unsigned long branch_target(const struct ppc_inst *instr);
 int translate_branch(struct ppc_inst *instr, const struct ppc_inst *dest,
 		     const struct ppc_inst *src);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 0308429b0d1a..82f2c1edb498 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -367,15 +367,6 @@ unsigned long branch_target(const struct ppc_inst *instr)
 	return 0;
 }
 
-int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr)
-{
-	if (instr_is_branch_iform(ppc_inst_read(instr)) ||
-	    instr_is_branch_bform(ppc_inst_read(instr)))
-		return branch_target(instr) == addr;
-
-	return 0;
-}
-
 int translate_branch(struct ppc_inst *instr, const struct ppc_inst *dest,
 		     const struct ppc_inst *src)
 {
@@ -410,6 +401,15 @@ void __patch_exception(int exc, unsigned long addr)
 
 #ifdef CONFIG_CODE_PATCHING_SELFTEST
 
+static int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr)
+{
+	if (instr_is_branch_iform(ppc_inst_read(instr)) ||
+	    instr_is_branch_bform(ppc_inst_read(instr)))
+		return branch_target(instr) == addr;
+
+	return 0;
+}
+
 static void __init test_trampoline(void)
 {
 	asm ("nop;\n");
-- 
2.25.0

