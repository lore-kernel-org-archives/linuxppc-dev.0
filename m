Return-Path: <SRS0=OS5J=KH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0245BC433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 08:36:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E716611F1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 08:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E716611F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fg7S26B49z3c80
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 18:36:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fg7Qf3BdXz305y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 May 2021 18:35:22 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Fg7QM1r1fz9sfC;
 Wed, 12 May 2021 10:35:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xN5JqW2ozEY9; Wed, 12 May 2021 10:35:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Fg7QK5lwQz9sf9;
 Wed, 12 May 2021 10:35:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A87038B7D9;
 Wed, 12 May 2021 10:35:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id eHs4-xWufSt8; Wed, 12 May 2021 10:35:05 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 62DE68B7D8;
 Wed, 12 May 2021 10:35:05 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 42BE5641A1; Wed, 12 May 2021 08:35:05 +0000 (UTC)
Message-Id: <653d26ca1008a56561a111e655bb97916c5e795a.1620808468.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e457f345843aa36c6f9ef8e6cb988428ae908df5.1620808468.git.christophe.leroy@csgroup.eu>
References: <e457f345843aa36c6f9ef8e6cb988428ae908df5.1620808468.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 4/5] powerpc/kuap: Remove KUAP_CURRENT_XXX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 12 May 2021 08:35:05 +0000 (UTC)
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

book3s/32 was the only user of KUAP_CURRENT_XXX.

After rework of book3s/32 KUAP, it is not used anymore.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h |  1 -
 arch/powerpc/include/asm/kup.h           | 14 +++-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index c67b91c1ca80..7b88f7bdd90f 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -102,7 +102,6 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 					      u32 size, unsigned long dir)
 {
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
-	BUILD_BUG_ON(dir & ~KUAP_READ_WRITE);
 	if (!(dir & KUAP_WRITE))
 		return;
 
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index ea83970734cf..aa93eb4e3be5 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -5,14 +5,6 @@
 #define KUAP_READ	1
 #define KUAP_WRITE	2
 #define KUAP_READ_WRITE	(KUAP_READ | KUAP_WRITE)
-/*
- * For prevent_user_access() only.
- * Use the current saved situation instead of the to/from/size params.
- * Used on book3s/32
- */
-#define KUAP_CURRENT_READ	4
-#define KUAP_CURRENT_WRITE	8
-#define KUAP_CURRENT		(KUAP_CURRENT_READ | KUAP_CURRENT_WRITE)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/kup.h>
@@ -139,17 +131,17 @@ static __always_inline void prevent_read_write_user(void __user *to, const void
 
 static __always_inline void prevent_current_access_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_READ_WRITE);
 }
 
 static __always_inline void prevent_current_read_from_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_READ);
 }
 
 static __always_inline void prevent_current_write_to_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_WRITE);
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.25.0

