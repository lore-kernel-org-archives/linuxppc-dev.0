Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ADAC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 13:40:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818AE2184A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 13:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HaMHkhYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818AE2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zP0s3XkPzDqNv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 00:40:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="HaMHkhYR"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zNx419FdzDqMC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 00:36:55 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43zNwz2k9qz9v1GC;
 Tue, 12 Feb 2019 14:36:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=HaMHkhYR; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id YAWdEZZZY065; Tue, 12 Feb 2019 14:36:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43zNwz1czTz9v1G9;
 Tue, 12 Feb 2019 14:36:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549978611; bh=um9yCYwOJ1SkZMPifhMErWXIPjN8RMbQWLCsWKAg55E=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=HaMHkhYRpvv8PNS5nTJcvoPiEbwzUkYtZ1YJlQeRsrZ3caNGnSuRwaY0LJYuOAXzE
 2FciwvVub4kOTbakUEBzhWbnbVv1D8kMEEz5M8nbt2EuXy5ZGn5XOpWm7Tid9gY4Sc
 Y6S912uMyzP0QFiNDp+PCzx0Z5XA74jBEhehEzas=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 93DF08B7F9;
 Tue, 12 Feb 2019 14:36:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XzRvIDk9t5pI; Tue, 12 Feb 2019 14:36:52 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FB3D8B7EB;
 Tue, 12 Feb 2019 14:36:52 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4A7196899C; Tue, 12 Feb 2019 13:36:52 +0000 (UTC)
Message-Id: <4c121392c84d696738798e118f2c52192e2c792e.1549935250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1549935247.git.christophe.leroy@c-s.fr>
References: <cover.1549935247.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 1/3] powerpc/mm: prepare kernel for KAsan on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Tue, 12 Feb 2019 13:36:52 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In kernel/cputable.c, explicitly use memcpy() in order
to allow GCC to replace it with __memcpy() when KASAN is
selected.

Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz once cache is
enabled"), memset() can be used before activation of the cache,
so no need to use memset_io() for zeroing the BSS.

Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/cputable.c | 13 ++++++++++---
 arch/powerpc/kernel/setup_32.c |  6 ++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1eab54bc6ee9..cd12f362b61f 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2147,7 +2147,11 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
 	struct cpu_spec *t = &the_cpu_spec;
 
 	t = PTRRELOC(t);
-	*t = *s;
+	/*
+	 * use memcpy() instead of *t = *s so that GCC replaces it
+	 * by __memcpy() when KASAN is active
+	 */
+	memcpy(t, s, sizeof(*t));
 
 	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
 }
@@ -2161,8 +2165,11 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 	t = PTRRELOC(t);
 	old = *t;
 
-	/* Copy everything, then do fixups */
-	*t = *s;
+	/*
+	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
+	 * so that GCC replaces it by __memcpy() when KASAN is active
+	 */
+	memcpy(t, s, sizeof(*t));
 
 	/*
 	 * If we are overriding a previous value derived from the real
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 947f904688b0..5e761eb16a6d 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -73,10 +73,8 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
 {
 	unsigned long offset = reloc_offset();
 
-	/* First zero the BSS -- use memset_io, some platforms don't have
-	 * caches on yet */
-	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
-			__bss_stop - __bss_start);
+	/* First zero the BSS */
+	memset(PTRRELOC(&__bss_start), 0, __bss_stop - __bss_start);
 
 	/*
 	 * Identify the CPU type and fix up code sections
-- 
2.13.3

