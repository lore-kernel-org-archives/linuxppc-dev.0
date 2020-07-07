Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF59C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 12:36:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB78206F6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 12:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB78206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1MNz4B2FzDqsy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 22:36:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1MLC73XWzDqq8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 22:33:39 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4B1ML66Yk1z9tySw;
 Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id FNhIg905TvsU; Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4B1ML65mTqz9tySr;
 Tue,  7 Jul 2020 14:33:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E68E8B7E1;
 Tue,  7 Jul 2020 14:33:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Hn2tdZquK4Ew; Tue,  7 Jul 2020 14:33:36 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [10.25.210.22])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C8D08B7D7;
 Tue,  7 Jul 2020 14:33:36 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 73948658EB; Tue,  7 Jul 2020 12:33:36 +0000 (UTC)
Message-Id: <47a38df46cae5a5a88a558a64d71f75e9c4d9950.1594125164.git.christophe.leroy@csgroup.eu>
In-Reply-To: <173de3b659fa3a5f126a0eb170522cccd909950f.1594125164.git.christophe.leroy@csgroup.eu>
References: <173de3b659fa3a5f126a0eb170522cccd909950f.1594125164.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] powerpc/signal_32: Simplify loop in PPC64
 save_general_regs()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com
Date: Tue,  7 Jul 2020 12:33:36 +0000 (UTC)
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

save_general_regs() which does special handling when i == PT_SOFTE.

Rewrite it to minimise the specific part, especially the __put_user()
and associated error handling is the same so make it common.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 0fd59fbc6d49..aae31fa5e411 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -103,19 +103,14 @@ static inline int save_general_regs(struct pt_regs *regs,
 {
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
-	/* Force usr to alway see softe as 1 (interrupts enabled) */
-	elf_greg_t64 softe = 0x1;
 
 	WARN_ON(!FULL_REGS(regs));
 
 	for (i = 0; i <= PT_RESULT; i ++) {
-		if ( i == PT_SOFTE) {
-			if(__put_user((unsigned int)softe, &frame->mc_gregs[i]))
-				return -EFAULT;
-			else
-				continue;
-		}
-		if (__put_user((unsigned int)gregs[i], &frame->mc_gregs[i]))
+		/* Force usr to alway see softe as 1 (interrupts enabled) */
+		int val = (i == PT_SOFTE) ? 1 : gregs[i];
+
+		if (__put_user(val, &frame->mc_gregs[i]))
 			return -EFAULT;
 	}
 	return 0;
-- 
2.25.0

