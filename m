Return-Path: <SRS0=qhKb=K5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14239C47098
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jun 2021 08:45:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87107613DA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jun 2021 08:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87107613DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fwfcg5Dkqz3c3Y
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jun 2021 18:45:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FwfXm2MKYz3c1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jun 2021 18:42:32 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4FwfWx1WHHzBC5d;
 Thu,  3 Jun 2021 10:41:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FlT9pYvmYXFK; Thu,  3 Jun 2021 10:41:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FwfWw4HxrzBC5k;
 Thu,  3 Jun 2021 10:41:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F3E08B848;
 Thu,  3 Jun 2021 10:41:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id wha_UTCAQizN; Thu,  3 Jun 2021 10:41:48 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F6FE8B767;
 Thu,  3 Jun 2021 10:41:48 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 09EFF64BD2; Thu,  3 Jun 2021 08:41:48 +0000 (UTC)
Message-Id: <b7113662fd2c26e4c33e9d705de324bd3860822e.1622708530.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1622708530.git.christophe.leroy@csgroup.eu>
References: <cover.1622708530.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 12/12] powerpc/kuap: Remove to/from/size parameters of
 prevent_user_access()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu,  3 Jun 2021 08:41:48 +0000 (UTC)
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

prevent_user_access() doesn't use anymore to/from/size parameters.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h     |  3 +--
 arch/powerpc/include/asm/book3s/64/kup.h     |  3 +--
 arch/powerpc/include/asm/kup.h               | 15 +++++++--------
 arch/powerpc/include/asm/nohash/32/kup-8xx.h |  3 +--
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index eb5ef59a406b..64201125a287 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -153,8 +153,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 	kuap_unlock_one((__force u32)to);
 }
 
-static __always_inline void prevent_user_access(void __user *to, const void __user *from,
-						u32 size, unsigned long dir)
+static __always_inline void prevent_user_access(unsigned long dir)
 {
 	u32 kuap = current->thread.kuap;
 
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 9700da3a4093..a1cc73a88710 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -398,8 +398,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 
 #endif /* !CONFIG_PPC_KUAP */
 
-static inline void prevent_user_access(void __user *to, const void __user *from,
-				       unsigned long size, unsigned long dir)
+static inline void prevent_user_access(unsigned long dir)
 {
 	set_kuap(AMR_KUAP_BLOCKED);
 	if (static_branch_unlikely(&uaccess_flush_key))
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 2c47feee9482..0202a7e84a49 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -72,8 +72,7 @@ static inline unsigned long kuap_get_and_assert_locked(void)
 #ifndef CONFIG_PPC_BOOK3S_64
 static inline void allow_user_access(void __user *to, const void __user *from,
 				     unsigned long size, unsigned long dir) { }
-static inline void prevent_user_access(void __user *to, const void __user *from,
-				       unsigned long size, unsigned long dir) { }
+static inline void prevent_user_access(unsigned long dir) { }
 static inline unsigned long prevent_user_access_return(void) { return 0UL; }
 static inline void restore_user_access(unsigned long flags) { }
 #endif /* CONFIG_PPC_BOOK3S_64 */
@@ -105,33 +104,33 @@ static inline void allow_read_write_user(void __user *to, const void __user *fro
 
 static inline void prevent_read_from_user(const void __user *from, unsigned long size)
 {
-	prevent_user_access(NULL, from, size, KUAP_READ);
+	prevent_user_access(KUAP_READ);
 }
 
 static inline void prevent_write_to_user(void __user *to, unsigned long size)
 {
-	prevent_user_access(to, NULL, size, KUAP_WRITE);
+	prevent_user_access(KUAP_WRITE);
 }
 
 static inline void prevent_read_write_user(void __user *to, const void __user *from,
 					   unsigned long size)
 {
-	prevent_user_access(to, from, size, KUAP_READ_WRITE);
+	prevent_user_access(KUAP_READ_WRITE);
 }
 
 static inline void prevent_current_access_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_READ_WRITE);
+	prevent_user_access(KUAP_READ_WRITE);
 }
 
 static inline void prevent_current_read_from_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_READ);
+	prevent_user_access(KUAP_READ);
 }
 
 static inline void prevent_current_write_to_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_WRITE);
+	prevent_user_access(KUAP_WRITE);
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 295ef5639609..61333e3b5d2b 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -48,8 +48,7 @@ static inline void allow_user_access(void __user *to, const void __user *from,
 	mtspr(SPRN_MD_AP, MD_APG_INIT);
 }
 
-static inline void prevent_user_access(void __user *to, const void __user *from,
-				       unsigned long size, unsigned long dir)
+static inline void prevent_user_access(unsigned long dir)
 {
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
-- 
2.25.0

