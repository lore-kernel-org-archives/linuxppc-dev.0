Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C6C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Oct 2021 15:46:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468476054E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Oct 2021 15:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 468476054E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQsxY0Bm0z3f6m
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 02:46:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQsqy0JMcz3cCb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Oct 2021 02:41:49 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HQsq92Qb3z9sSr;
 Fri,  8 Oct 2021 17:41:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40U-NAdmfXtO; Fri,  8 Oct 2021 17:41:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HQspy08rZz9sSs;
 Fri,  8 Oct 2021 17:40:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E2ACC8B763;
 Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 7R_tDk9sfTSP; Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D8E598B792;
 Fri,  8 Oct 2021 17:40:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198Fem4k1129660
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 8 Oct 2021 17:40:48 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198FemJJ1129659;
 Fri, 8 Oct 2021 17:40:48 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 05/16] powerpc/kuap: Remove __kuap_assert_locked()
Date: Fri,  8 Oct 2021 17:40:33 +0200
Message-Id: <dc7fe22e41fe381ad5cc186ac1f9fbb71ca6c546.1633707305.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633707305.git.christophe.leroy@csgroup.eu>
References: <cover.1633707305.git.christophe.leroy@csgroup.eu>
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

__kuap_assert_locked() is redundant with
__kuap_get_and_assert_locked().

Move the verification of CONFIG_PPC_KUAP_DEBUG in kuap_assert_locked()
and make it call __kuap_get_and_assert_locked() directly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h     | 5 -----
 arch/powerpc/include/asm/book3s/64/kup.h     | 6 ------
 arch/powerpc/include/asm/kup.h               | 3 ++-
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 6 ------
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index f1617ba85068..e273a6d3b6ad 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -120,11 +120,6 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
 	return kuap;
 }
 
-static inline void __kuap_assert_locked(void)
-{
-	__kuap_get_and_assert_locked();
-}
-
 static __always_inline void __allow_user_access(void __user *to, const void __user *from,
 						u32 size, unsigned long dir)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 9f2099790658..503828709d55 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -298,12 +298,6 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
 	return amr;
 }
 
-static inline void __kuap_assert_locked(void)
-{
-	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
-		WARN_ON_ONCE(mfspr(SPRN_AMR) != AMR_KUAP_BLOCKED);
-}
-
 /*
  * We support individually allowing read or write, but we don't support nesting
  * because that would require an expensive read/modify write of the AMR.
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index ea70e6f1df1e..7f0d614c5b8b 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -89,7 +89,8 @@ static __always_inline void kuap_assert_locked(void)
 	if (kuap_is_disabled())
 		return;
 
-	__kuap_assert_locked();
+	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
+		__kuap_get_and_assert_locked();
 }
 
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 74f15c386476..37fe4b32b658 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -47,12 +47,6 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
 	return kuap;
 }
 
-static inline void __kuap_assert_locked(void)
-{
-	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
-		__kuap_get_and_assert_locked();
-}
-
 static inline void __allow_user_access(void __user *to, const void __user *from,
 				       unsigned long size, unsigned long dir)
 {
-- 
2.31.1

