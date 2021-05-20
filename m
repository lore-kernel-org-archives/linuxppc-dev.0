Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE96C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 13:52:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F104A611AB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 13:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F104A611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmB5L53hVz3clk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 23:52:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmB3F54Rsz3bxQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 23:51:05 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FmB2z0sFzz9sV2;
 Thu, 20 May 2021 15:50:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDVBm8-iu04O; Thu, 20 May 2021 15:50:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FmB2q4d8cz9sTM;
 Thu, 20 May 2021 15:50:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 71AA88B817;
 Thu, 20 May 2021 15:50:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id k3dLpxm9xnWy; Thu, 20 May 2021 15:50:43 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.105])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E9648B813;
 Thu, 20 May 2021 15:50:43 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 43D7564C40; Thu, 20 May 2021 13:50:43 +0000 (UTC)
Message-Id: <5f6b9c8c83170ed310953eac2f5b14539bfc964a.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 06/12] powerpc/lib/code-patching: Make
 instr_is_branch_to_addr() static
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Date: Thu, 20 May 2021 13:50:43 +0000 (UTC)
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

