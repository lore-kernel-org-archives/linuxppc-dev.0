Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EACCC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:24:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC240214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="jx5YFrWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC240214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p6j50NnGzDqJf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 22:24:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="jx5YFrWl"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p6Q6614XzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 22:11:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43p6Px0H8xz9v1q7;
 Mon, 28 Jan 2019 12:11:17 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=jx5YFrWl; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id KIDgJJsegvyA; Mon, 28 Jan 2019 12:11:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Pw6J8Mz9v1q3;
 Mon, 28 Jan 2019 12:11:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548673876; bh=AyYBnkRz/4MvD/VSD+gQXAbGVtQY9ZhLw8i+wuSRQ50=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=jx5YFrWlghVceATbzJmMeolYPPvAgVf05duup3oxY7LSMUvyzlZlVAqwAk4xTmnVJ
 TWmSiaqF32J0x+D+uprhCJBRWdSYyIew9B50LH79L6j+4KGeC9LvR901ANopYUvGuI
 Kpft34pltlsYEf6KjFs9ADj0Htd8tFN7SWMJe3HM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 45FFD8B79D;
 Mon, 28 Jan 2019 12:11:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id HgsHI-kOFg-5; Mon, 28 Jan 2019 12:11:23 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 248BC8B796;
 Mon, 28 Jan 2019 12:11:23 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 1D4EE72DE6; Mon, 28 Jan 2019 11:11:23 +0000 (UTC)
Message-Id: <0ae6391c8794df0526d8e3fefba5863675028d5a.1548673552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 06/11] powerpc/32: move LOAD_MSR_KERNEL() into head_32.h and
 use it
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 28 Jan 2019 11:11:23 +0000 (UTC)
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

As preparation for using head_32.h for head_40x.S, move
LOAD_MSR_KERNEL() there and use it to load r10 with MSR_KERNEL value.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S |  9 +--------
 arch/powerpc/kernel/head_32.h  | 11 ++++++++++-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3f83e71ae43f..24d93231665b 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -37,14 +37,7 @@
 #include <asm/feature-fixups.h>
 #include <asm/barrier.h>
 
-/*
- * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
- */
-#if MSR_KERNEL >= 0x10000
-#define LOAD_MSR_KERNEL(r, x)	lis r,(x)@h; ori r,r,(x)@l
-#else
-#define LOAD_MSR_KERNEL(r, x)	li r,(x)
-#endif
+#include "head_32.h"
 
 /*
  * Align to 4k in order to ensure that all functions modyfing srr0/srr1
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index f77f13142410..e302afd40d0a 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -13,6 +13,15 @@
 #endif
 
 /*
+ * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
+ */
+#if MSR_KERNEL >= 0x10000
+#define LOAD_MSR_KERNEL(r, x)	lis r,(x)@h; ori r,r,(x)@l
+#else
+#define LOAD_MSR_KERNEL(r, x)	li r,(x)
+#endif
+
+/*
  * Exception entry code.  This code runs with address translation
  * turned off, i.e. using physical addresses.
  * We assume sprg3 has the physical address of the current
@@ -86,7 +95,7 @@
 #define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
-	li	r10,MSR_KERNEL;					\
+	LOAD_MSR_KERNEL(r10, MSR_KERNEL);			\
 	copyee(r10, r9);					\
 	bl	tfer;						\
 i##n:								\
-- 
2.13.3

