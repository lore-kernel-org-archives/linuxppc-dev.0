Return-Path: <SRS0=tbgD=FI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB9C4361A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 10:14:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6474E22519
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 10:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6474E22519
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CnT8q5XLszDqll
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 21:14:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CnT6c3W6YzDrQv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2020 21:12:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CnT6W5xRcz9v9xH;
 Fri,  4 Dec 2020 11:12:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3RsIa8cf7USA; Fri,  4 Dec 2020 11:12:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CnT6W1zSvz9v9xF;
 Fri,  4 Dec 2020 11:12:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 670B08B7FF;
 Fri,  4 Dec 2020 11:12:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 11bCbFc5qUcZ; Fri,  4 Dec 2020 11:12:52 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 33E3B8B7FE;
 Fri,  4 Dec 2020 11:12:52 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id EB85166914; Fri,  4 Dec 2020 10:12:51 +0000 (UTC)
Message-Id: <c10b263668e137236c71d76648b03cf2cd1ee66f.1607076733.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/process: Remove target specific __set_dabr()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  4 Dec 2020 10:12:51 +0000 (UTC)
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

__set_dabr() are simple functions that can be inline directly
inside set_dabr() and using IS_ENABLED() instead of #ifdef

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 37 ++++++++++++-----------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d421a2c7f822..5ef99138b696 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -807,29 +807,6 @@ static void switch_hw_breakpoint(struct task_struct *new)
 #endif /* !CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
 
-#ifdef CONFIG_PPC_ADV_DEBUG_REGS
-static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
-{
-	mtspr(SPRN_DAC1, dabr);
-	if (IS_ENABLED(CONFIG_PPC_47x))
-		isync();
-	return 0;
-}
-#elif defined(CONFIG_PPC_BOOK3S)
-static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
-{
-	mtspr(SPRN_DABR, dabr);
-	if (cpu_has_feature(CPU_FTR_DABRX))
-		mtspr(SPRN_DABRX, dabrx);
-	return 0;
-}
-#else
-static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
-{
-	return -EINVAL;
-}
-#endif
-
 static inline int set_dabr(struct arch_hw_breakpoint *brk)
 {
 	unsigned long dabr, dabrx;
@@ -840,7 +817,19 @@ static inline int set_dabr(struct arch_hw_breakpoint *brk)
 	if (ppc_md.set_dabr)
 		return ppc_md.set_dabr(dabr, dabrx);
 
-	return __set_dabr(dabr, dabrx);
+	if (IS_ENABLED(CONFIG_PPC_ADV_DEBUG_REGS)) {
+		mtspr(SPRN_DAC1, dabr);
+		if (IS_ENABLED(CONFIG_PPC_47x))
+			isync();
+		return 0;
+	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S)) {
+		mtspr(SPRN_DABR, dabr);
+		if (cpu_has_feature(CPU_FTR_DABRX))
+			mtspr(SPRN_DABRX, dabrx);
+		return 0;
+	} else {
+		return -EINVAL;
+	}
 }
 
 static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
-- 
2.25.0

