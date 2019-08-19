Return-Path: <SRS0=1Kal=WP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E44C3A5A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 13:12:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB89D20843
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 13:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YW6lay7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB89D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BvTx57fhzDqTP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 23:12:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="YW6lay7c"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BvMF60vdzDqHS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2019 23:06:32 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46BvM41JzHz9v0nT;
 Mon, 19 Aug 2019 15:06:24 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=YW6lay7c; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CBp78g9ItGyf; Mon, 19 Aug 2019 15:06:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46BvM402DHz9v0nR;
 Mon, 19 Aug 2019 15:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1566219984; bh=WQuwx7YlnB93+CPuHKoWP9rgc1cSC0MKUZb/xbdrYeg=;
 h=From:Subject:To:Cc:Date:From;
 b=YW6lay7cttRTenTWMU/GDgf3hMaryTq2zo/YiEUrnqPyr5hcZmzHB5PYNOCKPM03T
 UqoDRjWE9SK7iV+efC1jRVQ/wa3Xs9X10hVnTwuUkoy3efzCsI4mlkPXTqNlYTTTz+
 yCUpJLcq5SPhNrD0P3Gcb8V53LOxAju++4g0P0vQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CD168B7B7;
 Mon, 19 Aug 2019 15:06:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id sBAC9x2uK6nf; Mon, 19 Aug 2019 15:06:29 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.101])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D1328B7B6;
 Mon, 19 Aug 2019 15:06:29 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 125006B708; Mon, 19 Aug 2019 13:06:28 +0000 (UTC)
Message-Id: <a6781075192afe0c909ce7d091de7931183a5d93.1566219503.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc: don't use __WARN() for WARN_ON()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 segher@kernel.crashing.org, Drew Davenport <ddavenport@chromium.org>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 19 Aug 2019 13:06:28 +0000 (UTC)
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

__WARN() used to just call __WARN_TAINT(TAINT_WARN)

But a call to printk() has been added in the commit identified below
to print a "---- cut here ----" line.

This change only applies to warnings using __WARN(), which means
WARN_ON() where the condition is constant at compile time.
For WARN_ON() with a non constant condition, the additional line is
not printed.

In addition, adding a call to printk() forces GCC to add a stack frame
and save volatile registers. Powerpc has been using traps to implement
warnings in order to avoid that.

So, call __WARN_TAINT(TAINT_WARN) directly instead of using __WARN()
in order to restore the previous behaviour.

If one day powerpc wants the decorative "---- cut here ----" line, it
has to be done in the trap handler, not in the WARN_ON() macro.

Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index fed7e6241349..3928fdaebb71 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -99,7 +99,7 @@
 	int __ret_warn_on = !!(x);				\
 	if (__builtin_constant_p(__ret_warn_on)) {		\
 		if (__ret_warn_on)				\
-			__WARN();				\
+			__WARN_TAINT(TAINT_WARN);		\
 	} else {						\
 		__asm__ __volatile__(				\
 		"1:	"PPC_TLNEI"	%4,0\n"			\
-- 
2.13.3

