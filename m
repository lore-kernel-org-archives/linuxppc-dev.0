Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F706C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:46:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F65220827
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F65220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s6yr1sjTzF3RC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 04:46:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s6gw30FLzF3b9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 04:33:32 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42s6gk5079z9v0XQ;
 Fri,  9 Nov 2018 18:33:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uyVpYnVD5Y1y; Fri,  9 Nov 2018 18:33:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42s6gk4TLpz9v0XL;
 Fri,  9 Nov 2018 18:33:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DC6F8B899;
 Fri,  9 Nov 2018 18:33:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id L9-Mg3FuEuqH; Fri,  9 Nov 2018 18:33:28 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E0BE8B887;
 Fri,  9 Nov 2018 18:33:28 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2203469A2A; Fri,  9 Nov 2018 17:33:28 +0000 (UTC)
Message-Id: <d458fba7a7d83fb40a1d9784b1db97cf0fd15c9d.1541784640.git.christophe.leroy@c-s.fr>
In-Reply-To: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
References: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/9] powerpc/signal: Use code patching instead of hardcoding
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  9 Nov 2018 17:33:28 +0000 (UTC)
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

Instead of hardcoding code modifications, use code patching functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc-opcode.h |  1 +
 arch/powerpc/kernel/signal_32.c       | 12 ++++++------
 arch/powerpc/kernel/signal_64.c       |  7 ++++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index a6e9e314c707..7f693e0f7499 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -257,6 +257,7 @@
 #define PPC_INST_MTSPR_DSCR_USER_MASK	0xfc1ffffe
 #define PPC_INST_MFVSRD			0x7c000066
 #define PPC_INST_MTVSRD			0x7c000166
+#define PPC_INST_SC			0x44000002
 #define PPC_INST_SLBFEE			0x7c0007a7
 #define PPC_INST_SLBIA			0x7c0003e4
 
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index e6474a45cef5..9d39e0eb03ff 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -470,9 +470,9 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 		return 1;
 
 	if (sigret) {
-		/* Set up the sigreturn trampoline: li r0,sigret; sc */
-		if (__put_user(0x38000000UL + sigret, &frame->tramp[0])
-		    || __put_user(0x44000002UL, &frame->tramp[1]))
+		/* Set up the sigreturn trampoline: li 0,sigret; sc */
+		if (__put_user(PPC_INST_ADDI + sigret, &frame->tramp[0])
+		    || __put_user(PPC_INST_SC, &frame->tramp[1]))
 			return 1;
 		flush_icache_range((unsigned long) &frame->tramp[0],
 				   (unsigned long) &frame->tramp[2]);
@@ -619,9 +619,9 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	if (__put_user(msr, &frame->mc_gregs[PT_MSR]))
 		return 1;
 	if (sigret) {
-		/* Set up the sigreturn trampoline: li r0,sigret; sc */
-		if (__put_user(0x38000000UL + sigret, &frame->tramp[0])
-		    || __put_user(0x44000002UL, &frame->tramp[1]))
+		/* Set up the sigreturn trampoline: li 0,sigret; sc */
+		if (__put_user(PPC_INST_ADDI + sigret, &frame->tramp[0])
+		    || __put_user(PPC_INST_SC, &frame->tramp[1]))
 			return 1;
 		flush_icache_range((unsigned long) &frame->tramp[0],
 				   (unsigned long) &frame->tramp[2]);
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 83d51bf586c7..e53ad11be385 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -598,11 +598,12 @@ static long setup_trampoline(unsigned int syscall, unsigned int __user *tramp)
 	long err = 0;
 
 	/* addi r1, r1, __SIGNAL_FRAMESIZE  # Pop the dummy stackframe */
-	err |= __put_user(0x38210000UL | (__SIGNAL_FRAMESIZE & 0xffff), &tramp[0]);
+	err |= __put_user(PPC_INST_ADDI | __PPC_RT(R1) | __PPC_RA(R1) |
+			  (__SIGNAL_FRAMESIZE & 0xffff), &tramp[0]);
 	/* li r0, __NR_[rt_]sigreturn| */
-	err |= __put_user(0x38000000UL | (syscall & 0xffff), &tramp[1]);
+	err |= __put_user(PPC_INST_ADDI | (syscall & 0xffff), &tramp[1]);
 	/* sc */
-	err |= __put_user(0x44000002UL, &tramp[2]);
+	err |= __put_user(PPC_INST_SC, &tramp[2]);
 
 	/* Minimal traceback info */
 	for (i=TRAMP_TRACEBACK; i < TRAMP_SIZE ;i++)
-- 
2.13.3

