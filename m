Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07516C3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 14:24:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E80922CED
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 14:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E80922CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NmKY4HQ3zDqw6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 00:24:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NmD120snzDqcS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 00:19:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46NmCz51kqz8t3b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 00:19:27 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46NmCz2jDxz9sPp; Thu,  5 Sep 2019 00:19:27 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=gcc1-power7.osuosl.org (client-ip=140.211.15.137;
 helo=gcc1-power7.osuosl.org; envelope-from=segher@gcc1-power7.osuosl.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
X-Greylist: delayed 487 seconds by postgrey-1.36 at bilbo;
 Thu, 05 Sep 2019 00:19:25 AEST
Received: from gcc1-power7.osuosl.org (gcc1-power7.osuosl.org [140.211.15.137])
 by ozlabs.org (Postfix) with ESMTP id 46NmCx6YLlz9s3Z
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Sep 2019 00:19:25 +1000 (AEST)
Received: by gcc1-power7.osuosl.org (Postfix, from userid 10019)
 id 472351240C2E; Wed,  4 Sep 2019 14:11:15 +0000 (UTC)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add attributes for setjmp/longjmp
Date: Wed,  4 Sep 2019 14:11:07 +0000
Message-Id: <c02ce4a573f3bac907e2c70957a2d1275f910013.1567605586.git.segher@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The setjmp function should be declared as "returns_twice", or bad
things can happen[1].  This does not actually change generated code
in my testing.

The longjmp function should be declared as "noreturn", so that the
compiler can optimise calls to it better.  This makes the generated
code a little shorter.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

[1] See https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-returns_005ftwice-function-attribute
---
 arch/powerpc/include/asm/setjmp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/setjmp.h b/arch/powerpc/include/asm/setjmp.h
index d995061..e9f81bb 100644
--- a/arch/powerpc/include/asm/setjmp.h
+++ b/arch/powerpc/include/asm/setjmp.h
@@ -7,7 +7,7 @@
 
 #define JMP_BUF_LEN    23
 
-extern long setjmp(long *);
-extern void longjmp(long *, long);
+extern long setjmp(long *) __attribute__((returns_twice));
+extern void longjmp(long *, long) __attribute__((noreturn));
 
 #endif /* _ASM_POWERPC_SETJMP_H */
-- 
1.8.3.1

