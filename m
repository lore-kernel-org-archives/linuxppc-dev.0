Return-Path: <SRS0=GP0G=II=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DF0C28D13
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 17:47:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A603864F49
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 17:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A603864F49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DwffK1nR7z3dKT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Mar 2021 04:47:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dwfdy1Sg1z30N6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Mar 2021 04:46:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4Dwfdq17RJz9tytT;
 Wed, 10 Mar 2021 18:46:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vXkdbFcQnlKL; Wed, 10 Mar 2021 18:46:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwfdp6xP6z9tytQ;
 Wed, 10 Mar 2021 18:46:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C78718B78D;
 Wed, 10 Mar 2021 18:46:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VZHKbDJcEICP; Wed, 10 Mar 2021 18:46:40 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9469D8B77E;
 Wed, 10 Mar 2021 18:46:40 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 73BD867568; Wed, 10 Mar 2021 17:46:40 +0000 (UTC)
Message-Id: <439179c5e54c18f2cb8bdf1eea13ea0ef6b98375.1615398265.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 01/15] powerpc/uaccess: Remove __get_user_allowed() and
 unsafe_op_wrap()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 10 Mar 2021 17:46:40 +0000 (UTC)
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

Those two macros have only one user which is unsafe_get_user().

Put everything in one place and remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 78e2a3990eab..8cbf3e3874f1 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -53,9 +53,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
 #define __put_user(x, ptr) \
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
-#define __get_user_allowed(x, ptr) \
-	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
-
 #define __get_user_inatomic(x, ptr) \
 	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
 #define __put_user_inatomic(x, ptr) \
@@ -482,8 +479,11 @@ user_write_access_begin(const void __user *ptr, size_t len)
 #define user_write_access_begin	user_write_access_begin
 #define user_write_access_end		prevent_current_write_to_user
 
-#define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
-#define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
+#define unsafe_get_user(x, p, e) do {					\
+	if (unlikely(__get_user_nocheck((x), (p), sizeof(*(p)), false)))\
+		goto e;							\
+} while (0)
+
 #define unsafe_put_user(x, p, e) \
 	__unsafe_put_user_goto((__typeof__(*(p)))(x), (p), sizeof(*(p)), e)
 
-- 
2.25.0

