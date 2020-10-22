Return-Path: <SRS0=xaUg=D5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75E5C4363A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 09:32:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36D421481
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 09:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36D421481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CH2G12cSWzDqrZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 20:32:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CH2BJ1MCMzDqg3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2020 20:29:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CH2B64pPTz9tx11;
 Thu, 22 Oct 2020 11:29:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id LVNi8__7y1oz; Thu, 22 Oct 2020 11:29:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CH2B63ydhzB09bQ;
 Thu, 22 Oct 2020 11:29:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B63638B769;
 Thu, 22 Oct 2020 11:29:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id TPw1l00OW4rb; Thu, 22 Oct 2020 11:29:19 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 601B28B807;
 Thu, 22 Oct 2020 11:29:19 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 179756680D; Thu, 22 Oct 2020 09:29:19 +0000 (UTC)
Message-Id: <25e6fca46fda3e2a4298448edbf654f64756eee7.1603358942.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 1/3] powerpc/uaccess: Don't use "m<>" constraint with GCC
 4.9
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 mathieu.desnoyers@efficios.com
Date: Thu, 22 Oct 2020 09:29:19 +0000 (UTC)
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

GCC 4.9 sometimes fails to build with "m<>" constraint in
inline assembly.

  CC      lib/iov_iter.o
In file included from ./arch/powerpc/include/asm/cmpxchg.h:6:0,
                 from ./arch/powerpc/include/asm/atomic.h:11,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/crypto.h:15,
                 from ./include/crypto/hash.h:11,
                 from lib/iov_iter.c:2:
lib/iov_iter.c: In function 'iovec_from_user.part.30':
./arch/powerpc/include/asm/uaccess.h:287:2: error: 'asm' operand has impossible constraints
  __asm__ __volatile__(    \
  ^
./include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
 # define unlikely(x) __builtin_expect(!!(x), 0)
                                          ^
./arch/powerpc/include/asm/uaccess.h:583:34: note: in expansion of macro 'unsafe_op_wrap'
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
                                  ^
./arch/powerpc/include/asm/uaccess.h:329:10: note: in expansion of macro '__get_user_asm'
  case 4: __get_user_asm(x, (u32 __user *)ptr, retval, "lwz"); break; \
          ^
./arch/powerpc/include/asm/uaccess.h:363:3: note: in expansion of macro '__get_user_size_allowed'
   __get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err); \
   ^
./arch/powerpc/include/asm/uaccess.h:100:2: note: in expansion of macro '__get_user_nocheck'
  __get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
  ^
./arch/powerpc/include/asm/uaccess.h:583:49: note: in expansion of macro '__get_user_allowed'
 #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
                                                 ^
lib/iov_iter.c:1663:3: note: in expansion of macro 'unsafe_get_user'
   unsafe_get_user(len, &uiov[i].iov_len, uaccess_end);
   ^
make[1]: *** [scripts/Makefile.build:283: lib/iov_iter.o] Error 1

Define a UPD_CONSTR macro that is "<>" by default and
only "" with GCC prior to GCC 5.

Fixes: fcf1f26895a4 ("powerpc/uaccess: Add pre-update addressing to __put_user_asm_goto()")
Fixes: 2f279eeb68b8 ("powerpc/uaccess: Add pre-update addressing to __get_user_asm() and __put_user_asm()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
---
v2: Moved UPD_CONSTR to asm-const.h to avoid circular inclusion issues with patch 3.
---
 arch/powerpc/include/asm/asm-const.h | 13 +++++++++++++
 arch/powerpc/include/asm/uaccess.h   |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-const.h b/arch/powerpc/include/asm/asm-const.h
index 082c1538c562..0ce2368bd20f 100644
--- a/arch/powerpc/include/asm/asm-const.h
+++ b/arch/powerpc/include/asm/asm-const.h
@@ -11,4 +11,17 @@
 #  define __ASM_CONST(x)	x##UL
 #  define ASM_CONST(x)		__ASM_CONST(x)
 #endif
+
+/*
+ * Inline assembly memory constraint
+ *
+ * GCC 4.9 doesn't properly handle pre update memory constraint "m<>"
+ *
+ */
+#if defined(GCC_VERSION) && GCC_VERSION < 50000
+#define UPD_CONSTR ""
+#else
+#define UPD_CONSTR "<>"
+#endif
+
 #endif /* _ASM_POWERPC_ASM_CONST_H */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 604d705f1bb8..8f27ea48fadb 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -223,7 +223,7 @@ do {								\
 		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		:						\
-		: "r" (x), "m<>" (*addr)				\
+		: "r" (x), "m"UPD_CONSTR (*addr)		\
 		:						\
 		: label)
 
@@ -294,7 +294,7 @@ extern long __get_user_bad(void);
 		".previous\n"				\
 		EX_TABLE(1b, 3b)			\
 		: "=r" (err), "=r" (x)			\
-		: "m<>" (*addr), "i" (-EFAULT), "0" (err))
+		: "m"UPD_CONSTR (*addr), "i" (-EFAULT), "0" (err))
 
 #ifdef __powerpc64__
 #define __get_user_asm2(x, addr, err)			\
-- 
2.25.0

