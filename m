Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810ECC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:48:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E0E2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MKAFwXc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E0E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Q852kzwzDqB2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 04:48:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="MKAFwXc1"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444PjZ4hlVzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 04:29:22 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444PjR62Tlz9v0gH;
 Wed, 20 Feb 2019 18:29:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=MKAFwXc1; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8eW-tfHpw8Vt; Wed, 20 Feb 2019 18:29:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444PjR509Cz9v0g0;
 Wed, 20 Feb 2019 18:29:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550683755; bh=6+UN/pZUxlGcDtKNcykeJgXkzYMi9CIgcgeN2UqrbQg=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=MKAFwXc1/Z/EDUIAItzSwnU79zAGcVfKLt2jc5l2YGqF1KYFhHEGenf+g+25/6TVy
 MprPh3K4j4OKAy3FDEuwL8O6s+aT4VwyMlZHpXECIJRMi3PYbEZdYdafxqew2pahHb
 MvbgQ4E49qDZilbXv4/HjFLqL0tTRdec/geCOyUo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B92B8B84F;
 Wed, 20 Feb 2019 18:29:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cO4eFyGk4znt; Wed, 20 Feb 2019 18:29:17 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3AF278B84A;
 Wed, 20 Feb 2019 18:29:17 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 3082A6E85E; Wed, 20 Feb 2019 17:29:17 +0000 (UTC)
Message-Id: <279ade651dd1976b4c56dee80a399c857bd9b81c.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 10/16] powerpc/kconfig: define PAGE_SHIFT inside Kconfig
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Wed, 20 Feb 2019 17:29:17 +0000 (UTC)
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

This patch defined CONFIG_PPC_PAGE_SHIFT in order
to be able to use PAGE_SHIFT value inside Kconfig.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig            |  7 +++++++
 arch/powerpc/include/asm/page.h | 13 ++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 849b0d5ac3d1..417e52a27f63 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -708,6 +708,13 @@ config PPC_256K_PAGES
 
 endchoice
 
+config PPC_PAGE_SHIFT
+	int
+	default 18 if PPC_256K_PAGES
+	default 16 if PPC_64K_PAGES
+	default 14 if PPC_16K_PAGES
+	default 12
+
 config THREAD_SHIFT
 	int "Thread shift" if EXPERT
 	range 13 15
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index aa4497175bd3..ed870468ef6f 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -20,20 +20,11 @@
 
 /*
  * On regular PPC32 page size is 4K (but we support 4K/16K/64K/256K pages
- * on PPC44x). For PPC64 we support either 4K or 64K software
+ * on PPC44x and 4K/16K on 8xx). For PPC64 we support either 4K or 64K software
  * page size. When using 64K pages however, whether we are really supporting
  * 64K pages in HW or not is irrelevant to those definitions.
  */
-#if defined(CONFIG_PPC_256K_PAGES)
-#define PAGE_SHIFT		18
-#elif defined(CONFIG_PPC_64K_PAGES)
-#define PAGE_SHIFT		16
-#elif defined(CONFIG_PPC_16K_PAGES)
-#define PAGE_SHIFT		14
-#else
-#define PAGE_SHIFT		12
-#endif
-
+#define PAGE_SHIFT		CONFIG_PPC_PAGE_SHIFT
 #define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
-- 
2.13.3

