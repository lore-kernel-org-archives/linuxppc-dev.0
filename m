Return-Path: <SRS0=iVLG=KC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6575DC433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 07:05:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB69F613C9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 07:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB69F613C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fc1fq1kYKz300T
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 17:05:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fc1d522zmz306Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 May 2021 17:03:37 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Fc1ck5k6Dz9sZW;
 Fri,  7 May 2021 09:03:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U3k5b2q0CRK9; Fri,  7 May 2021 09:03:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Fc1cj0fjsz9sZQ;
 Fri,  7 May 2021 09:03:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B293F8B81A;
 Fri,  7 May 2021 09:03:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id g3WkuwK_Hg4C; Fri,  7 May 2021 09:03:16 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 533F48B764;
 Fri,  7 May 2021 09:03:16 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 32C1964909; Fri,  7 May 2021 07:03:16 +0000 (UTC)
Message-Id: <7192b82166cf45a20493c2f03e19789db7b5949f.1620370984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <9c5f23642ac5900c8e83da795afac7041bf87cf6.1620370984.git.christophe.leroy@csgroup.eu>
References: <9c5f23642ac5900c8e83da795afac7041bf87cf6.1620370984.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 5/5] powerpc/32s: Simplify calculation of segment register
 content
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  7 May 2021 07:03:16 +0000 (UTC)
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

segment register has VSID on bits 8-31.
Bits 4-7 are reserved, there is no requirement to set them to 0.

VSIDs are calculated from VSID of SR0 by adding 0x111.

Even with highest possible VSID which would be 0xFFFFF0,
adding 16 times 0x111 results in 0x1001100.

So, the reserved bits are never overflowed, no need to clear
the reserved bits after each calculation.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h | 37 ++++++++++---------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index cc0284bbac86..6f83dbfc7cfa 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -105,28 +105,31 @@ extern s32 patch__flush_hash_B;
 #include <asm/reg.h>
 #include <asm/task_size_32.h>
 
-#define UPDATE_TWO_USER_SEGMENTS(n) do {		\
+#define UPDATE_USER_SEGMENT(n, val) do {		\
 	if (TASK_SIZE > ((n) << 28))			\
-		mtsr(val1, (n) << 28);			\
-	if (TASK_SIZE > (((n) + 1) << 28))		\
-		mtsr(val2, ((n) + 1) << 28);		\
-	val1 = (val1 + 0x222) & 0xf0ffffff;		\
-	val2 = (val2 + 0x222) & 0xf0ffffff;		\
+		mtsr(val + (n) * 0x111, (n) << 28);	\
 } while (0)
 
 static __always_inline void update_user_segments(u32 val)
 {
-	int val1 = val;
-	int val2 = (val + 0x111) & 0xf0ffffff;
-
-	UPDATE_TWO_USER_SEGMENTS(0);
-	UPDATE_TWO_USER_SEGMENTS(2);
-	UPDATE_TWO_USER_SEGMENTS(4);
-	UPDATE_TWO_USER_SEGMENTS(6);
-	UPDATE_TWO_USER_SEGMENTS(8);
-	UPDATE_TWO_USER_SEGMENTS(10);
-	UPDATE_TWO_USER_SEGMENTS(12);
-	UPDATE_TWO_USER_SEGMENTS(14);
+	val &= 0xf0ffffff;
+
+	UPDATE_USER_SEGMENT(0, val);
+	UPDATE_USER_SEGMENT(1, val);
+	UPDATE_USER_SEGMENT(2, val);
+	UPDATE_USER_SEGMENT(3, val);
+	UPDATE_USER_SEGMENT(4, val);
+	UPDATE_USER_SEGMENT(5, val);
+	UPDATE_USER_SEGMENT(6, val);
+	UPDATE_USER_SEGMENT(7, val);
+	UPDATE_USER_SEGMENT(8, val);
+	UPDATE_USER_SEGMENT(9, val);
+	UPDATE_USER_SEGMENT(10, val);
+	UPDATE_USER_SEGMENT(11, val);
+	UPDATE_USER_SEGMENT(12, val);
+	UPDATE_USER_SEGMENT(13, val);
+	UPDATE_USER_SEGMENT(14, val);
+	UPDATE_USER_SEGMENT(15, val);
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.25.0

