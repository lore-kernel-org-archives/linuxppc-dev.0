Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6934BC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 13:38:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBBD61153
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 13:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EBBD61153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDzrX647Pz30BM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 23:38:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDzr350xdz2yHX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 23:37:36 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HDzqx2Yttz9sSc;
 Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zfoYlC92YagZ; Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HDzqx1ck8z9sSS;
 Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 22C1E8B775;
 Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5nqDyEowOTTE; Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EC4A98B763;
 Wed, 22 Sep 2021 15:37:32 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18MDbN9V1129358
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 22 Sep 2021 15:37:23 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18MDbM631129357;
 Wed, 22 Sep 2021 15:37:22 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/breakpoint: Cleanup
Date: Wed, 22 Sep 2021 15:37:18 +0200
Message-Id: <6184b08088312a7d787d450eb902584e4ae77f7a.1632317816.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
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

cache_op_size() does exactly the same as l1_dcache_bytes().

Remove it.

MSR_64BIT already exists, no need to enclode the check
around #ifdef __powerpc64__

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/hw_breakpoint_constraints.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint_constraints.c b/arch/powerpc/kernel/hw_breakpoint_constraints.c
index 675d1f66ab72..42b967e3d85c 100644
--- a/arch/powerpc/kernel/hw_breakpoint_constraints.c
+++ b/arch/powerpc/kernel/hw_breakpoint_constraints.c
@@ -127,15 +127,6 @@ bool wp_check_constraints(struct pt_regs *regs, struct ppc_inst instr,
 	return false;
 }
 
-static int cache_op_size(void)
-{
-#ifdef __powerpc64__
-	return ppc64_caches.l1d.block_size;
-#else
-	return L1_CACHE_BYTES;
-#endif
-}
-
 void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
 			 int *type, int *size, unsigned long *ea)
 {
@@ -147,14 +138,14 @@ void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
 	analyse_instr(&op, regs, *instr);
 	*type = GETTYPE(op.type);
 	*ea = op.ea;
-#ifdef __powerpc64__
+
 	if (!(regs->msr & MSR_64BIT))
 		*ea &= 0xffffffffUL;
-#endif
+
 
 	*size = GETSIZE(op.type);
 	if (*type == CACHEOP) {
-		*size = cache_op_size();
+		*size = l1_dcache_bytes();
 		*ea &= ~(*size - 1);
 	} else if (*type == LOAD_VMX || *type == STORE_VMX) {
 		*ea &= ~(*size - 1);
-- 
2.31.1

