Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E951C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 17:54:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC1264F3B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 17:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC1264F3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmgQj67H7z3f2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 04:54:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmgLY0KD9z3ckp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 04:50:44 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DmgLR6F12z9v1BC;
 Thu, 25 Feb 2021 18:50:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 9Jsce-AnIQyj; Thu, 25 Feb 2021 18:50:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLR5TlDz9v19y;
 Thu, 25 Feb 2021 18:50:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 954088B895;
 Thu, 25 Feb 2021 18:50:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iZayMdJjEipo; Thu, 25 Feb 2021 18:50:41 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5505E8B88B;
 Thu, 25 Feb 2021 18:50:41 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 303EB67442; Thu, 25 Feb 2021 17:50:41 +0000 (UTC)
Message-Id: <ecb5aa9ad0806366c87db35669e44bc6458ae624.1614275314.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 11/15] powerpc/uaccess: Rename __get/put_user_check/nocheck
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 25 Feb 2021 17:50:41 +0000 (UTC)
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

__get_user_check() becomes get_user()
__put_user_check() becomes put_user()
__get_user_nocheck() becomes __get_user()
__put_user_nocheck() becomes __put_user()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 678651a615c3..616a3a7928c2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -43,16 +43,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
  * exception handling means that it's no longer "just"...)
  *
  */
-#define get_user(x, ptr) \
-	__get_user_check((x), (ptr), sizeof(*(ptr)))
-#define put_user(x, ptr) \
-	__put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
-
-#define __get_user(x, ptr) \
-	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
-#define __put_user(x, ptr) \
-	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
-
 #define __put_user_size(x, ptr, size, retval)			\
 do {								\
 	__label__ __pu_failed;					\
@@ -68,12 +58,12 @@ __pu_failed:							\
 	prevent_write_to_user(ptr, size);			\
 } while (0)
 
-#define __put_user_nocheck(x, ptr, size)			\
+#define __put_user(x, ptr)					\
 ({								\
 	long __pu_err;						\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
-	__typeof__(*(ptr)) __pu_val = (x);			\
-	__typeof__(size) __pu_size = (size);			\
+	__typeof__(*(ptr)) __pu_val = (__typeof__(*(ptr)))(x);	\
+	__typeof__(sizeof(*(ptr))) __pu_size = sizeof(*(ptr));	\
 								\
 	might_fault();						\
 	__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err);	\
@@ -81,12 +71,12 @@ __pu_failed:							\
 	__pu_err;						\
 })
 
-#define __put_user_check(x, ptr, size)					\
+#define put_user(x, ptr)						\
 ({									\
 	long __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
-	__typeof__(*(ptr)) __pu_val = (x);				\
-	__typeof__(size) __pu_size = (size);				\
+	__typeof__(*(ptr)) __pu_val = (__typeof__(*(ptr)))(x);		\
+	__typeof__(sizeof(*(ptr))) __pu_size = sizeof(*(ptr));		\
 									\
 	might_fault();							\
 	if (access_ok(__pu_addr, __pu_size))				\
@@ -216,12 +206,12 @@ do {								\
 #define __long_type(x) \
 	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 
-#define __get_user_nocheck(x, ptr, size)			\
+#define __get_user(x, ptr)					\
 ({								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
-	__typeof__(size) __gu_size = (size);			\
+	__typeof__(sizeof(*(ptr))) __gu_size = sizeof(*(ptr));	\
 								\
 	might_fault();					\
 	__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err);	\
@@ -230,12 +220,12 @@ do {								\
 	__gu_err;						\
 })
 
-#define __get_user_check(x, ptr, size)					\
+#define get_user(x, ptr)						\
 ({									\
 	long __gu_err = -EFAULT;					\
 	__long_type(*(ptr)) __gu_val = 0;				\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
-	__typeof__(size) __gu_size = (size);				\
+	__typeof__(sizeof(*(ptr))) __gu_size = sizeof(*(ptr));		\
 									\
 	might_fault();							\
 	if (access_ok(__gu_addr, __gu_size))				\
-- 
2.25.0

