Return-Path: <SRS0=zi2C=LT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3036C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 11:13:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F2761466
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 11:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F2761466
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GBDs52PShz3bxC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 21:13:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GBDrl0Qxjz309N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 21:13:24 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GBDrZ1xnvzBBh0;
 Fri, 25 Jun 2021 13:13:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qizscpcGZpPC; Fri, 25 Jun 2021 13:13:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GBDrY124DzBBft;
 Fri, 25 Jun 2021 13:13:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C3AB8B802;
 Fri, 25 Jun 2021 13:13:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qjDWOupUbZba; Fri, 25 Jun 2021 13:13:16 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B9B3D8B7FF;
 Fri, 25 Jun 2021 13:13:16 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 49CB566377; Fri, 25 Jun 2021 11:13:16 +0000 (UTC)
Message-Id: <49f4fb051a3e1cb69f7305d5b6768aec14727c32.1624619582.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/ptrace: Move set_return_regs_changed() before
 regs_set_return_{msr/ip}
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 25 Jun 2021 11:13:16 +0000 (UTC)
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

regs_set_return_msr() and regs_set_return_ip() have a copy
of the code of set_return_regs_changed().

Move up set_return_regs_changed() so it can be reused by
regs_set_return_{msr/ip}

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ptrace.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index fcf63f559344..14b8105a1e27 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -135,26 +135,26 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 long do_syscall_trace_enter(struct pt_regs *regs);
 void do_syscall_trace_leave(struct pt_regs *regs);
 
-static inline void regs_set_return_ip(struct pt_regs *regs, unsigned long ip)
+static inline void set_return_regs_changed(void)
 {
-	regs->nip = ip;
 #ifdef CONFIG_PPC_BOOK3S_64
 	local_paca->hsrr_valid = 0;
 	local_paca->srr_valid = 0;
 #endif
 }
 
-static inline void regs_set_return_msr(struct pt_regs *regs, unsigned long msr)
+static inline void regs_set_return_ip(struct pt_regs *regs, unsigned long ip)
 {
-	regs->msr = msr;
+	regs->nip = ip;
 #ifdef CONFIG_PPC_BOOK3S_64
 	local_paca->hsrr_valid = 0;
 	local_paca->srr_valid = 0;
 #endif
 }
 
-static inline void set_return_regs_changed(void)
+static inline void regs_set_return_msr(struct pt_regs *regs, unsigned long msr)
 {
+	regs->msr = msr;
 #ifdef CONFIG_PPC_BOOK3S_64
 	local_paca->hsrr_valid = 0;
 	local_paca->srr_valid = 0;
-- 
2.25.0

