Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25386C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 06:42:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A9A613FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 06:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A9A613FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3zJy3qlYz3cL6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 16:42:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3zHN6x96z3bvm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 16:41:20 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G3zH21dXgzB9CC;
 Tue, 15 Jun 2021 08:41:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dzEpTriwX5Bz; Tue, 15 Jun 2021 08:41:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G3zH20pPHzB9BM;
 Tue, 15 Jun 2021 08:41:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CC08A8B7A3;
 Tue, 15 Jun 2021 08:41:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id fa3HmGORbATw; Tue, 15 Jun 2021 08:41:01 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 97E9E8B7A2;
 Tue, 15 Jun 2021 08:41:01 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 709556627B; Tue, 15 Jun 2021 06:41:01 +0000 (UTC)
Message-Id: <684939dcfef612fac573d1b983a977215b71f64d.1623739212.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 5/7] signal: Add unsafe_copy_siginfo_to_user()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 15 Jun 2021 06:41:01 +0000 (UTC)
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
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In the same spirit as commit fb05121fd6a2 ("signal: Add
unsafe_get_compat_sigset()"), implement an 'unsafe' version of
copy_siginfo_to_user() in order to use it within user access blocks.

For that, also add an 'unsafe' version of clear_user().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/signal.h  | 15 +++++++++++++++
 include/linux/uaccess.h |  1 +
 kernel/signal.c         |  5 -----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 201f88e3738b..beac7b5e4acc 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -35,6 +35,21 @@ static inline void copy_siginfo_to_external(siginfo_t *to,
 int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from);
 int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from);
 
+static __always_inline char __user *si_expansion(const siginfo_t __user *info)
+{
+	return ((char __user *)info) + sizeof(struct kernel_siginfo);
+}
+
+#define unsafe_copy_siginfo_to_user(to, from, label) do {		\
+	siginfo_t __user *__ucs_to = to;				\
+	const kernel_siginfo_t *__ucs_from = from;			\
+	char __user *__ucs_expansion = si_expansion(__ucs_to);		\
+									\
+	unsafe_copy_to_user(__ucs_to, __ucs_from,			\
+			    sizeof(struct kernel_siginfo), label);	\
+	unsafe_clear_user(__ucs_expansion, SI_EXPANSION_SIZE, label);	\
+} while (0)
+
 enum siginfo_layout {
 	SIL_KILL,
 	SIL_TIMER,
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index c05e903cef02..37073caac474 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -398,6 +398,7 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
 #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,s,l),e)
 #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
+#define unsafe_clear_user(d, l, e) unsafe_op_wrap(__clear_user(d, l), e)
 static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long flags) { }
 #endif
diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffcbd044..7a366331d2b7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3286,11 +3286,6 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 	return layout;
 }
 
-static inline char __user *si_expansion(const siginfo_t __user *info)
-{
-	return ((char __user *)info) + sizeof(struct kernel_siginfo);
-}
-
 int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from)
 {
 	char __user *expansion = si_expansion(to);
-- 
2.25.0

