Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E83C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 18:52:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBBF206E9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 18:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBBF206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1WlT6zZLzDq9C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 04:52:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1WJK5bGnzDqpC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 04:32:32 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4B1WJB69kFz9v1HL;
 Tue,  7 Jul 2020 20:32:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 1NCa8ObR2Wbn; Tue,  7 Jul 2020 20:32:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4B1WJB5Jqsz9v1HK;
 Tue,  7 Jul 2020 20:32:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C334E8B7ED;
 Tue,  7 Jul 2020 20:32:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ndX5NHz7O5u9; Tue,  7 Jul 2020 20:32:26 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F1B718B7D7;
 Tue,  7 Jul 2020 20:32:25 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 816F965BB1; Tue,  7 Jul 2020 18:32:25 +0000 (UTC)
Message-Id: <810bd8840ef990a200f58c9dea9abe767ca02a3a.1594146723.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/signal64: Don't opencode page prefaulting
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue,  7 Jul 2020 18:32:25 +0000 (UTC)
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

Instead of doing a __get_user() from the first and last location
into a tmp var which won't be used, use fault_in_pages_readable()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_64.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 55e5f76554da..c451c47538e1 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
+#include <linux/pagemap.h>
 
 #include <asm/sigcontext.h>
 #include <asm/ucontext.h>
@@ -632,7 +633,6 @@ static long setup_trampoline(unsigned int syscall, unsigned int __user *tramp)
 SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 		struct ucontext __user *, new_ctx, long, ctx_size)
 {
-	unsigned char tmp;
 	sigset_t set;
 	unsigned long new_msr = 0;
 	int ctx_has_vsx_region = 0;
@@ -667,9 +667,8 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	}
 	if (new_ctx == NULL)
 		return 0;
-	if (!access_ok(new_ctx, ctx_size)
-	    || __get_user(tmp, (u8 __user *) new_ctx)
-	    || __get_user(tmp, (u8 __user *) new_ctx + ctx_size - 1))
+	if (!access_ok(new_ctx, ctx_size) ||
+	    fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
 		return -EFAULT;
 
 	/*
-- 
2.25.0

