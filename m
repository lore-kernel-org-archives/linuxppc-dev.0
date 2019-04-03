Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DED8C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:19:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD3220882
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HG8dSBfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD3220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZHVL5f8YzDqD9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 07:19:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="HG8dSBfj"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZHCQ0CJGzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 07:06:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ZHCF3H79z9v3pq;
 Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=HG8dSBfj; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Fsk3bO9Ujalu; Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCF2Cznz9v3pp;
 Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554321977; bh=970wlOaQpGtoCjkMZSnSrOj9AfwAnmYD5UEwoPtyWRU=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=HG8dSBfjDa0f2F5csZF/g3MENcLHldD3iFiP9wiiX6JqxAEJvG71WGUa/5sDKEhHJ
 X49NVaU9UL774zVS8zsG2s8tRxr1YgpXeKVEEYS974e3qTRF1HuPlYq7PFdi36rWWB
 rpVhe+3l524kesHpqD2unpiJkhxComS72NNRBhPc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CD5F8B905;
 Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Py1XGp7M8-qb; Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 476608B902;
 Wed,  3 Apr 2019 22:06:17 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 3336C655EC; Wed,  3 Apr 2019 20:06:17 +0000 (UTC)
Message-Id: <5acb0d752bf5dd936ec9ae1050b81d21a5a535a0.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 05/15] powerpc/mm: get rid of nohash/32/mmu.h and
 nohash/64/mmu.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed,  3 Apr 2019 20:06:17 +0000 (UTC)
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

Those files have no real added values, especially the 64 bit
which only includes the common book3e mmu.h which is also
included from 32 bits side.

So lets do the final inclusion directly from nohash/mmu.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu.h | 19 -------------------
 arch/powerpc/include/asm/nohash/64/mmu.h |  8 --------
 arch/powerpc/include/asm/nohash/mmu.h    | 16 ++++++++++++----
 3 files changed, 12 insertions(+), 31 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 delete mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h

diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
deleted file mode 100644
index af0e8b54876a..000000000000
--- a/arch/powerpc/include/asm/nohash/32/mmu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
-#define _ASM_POWERPC_NOHASH_32_MMU_H_
-
-#if defined(CONFIG_40x)
-/* 40x-style software loaded TLB */
-#include <asm/nohash/32/mmu-40x.h>
-#elif defined(CONFIG_44x)
-/* 44x-style software loaded TLB */
-#include <asm/nohash/32/mmu-44x.h>
-#elif defined(CONFIG_PPC_BOOK3E_MMU)
-/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#include <asm/nohash/mmu-book3e.h>
-#elif defined (CONFIG_PPC_8xx)
-/* Motorola/Freescale 8xx software loaded TLB */
-#include <asm/nohash/32/mmu-8xx.h>
-#endif
-
-#endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
deleted file mode 100644
index 87871d027b75..000000000000
--- a/arch/powerpc/include/asm/nohash/64/mmu.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
-#define _ASM_POWERPC_NOHASH_64_MMU_H_
-
-/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#include <asm/nohash/mmu-book3e.h>
-
-#endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/mmu.h b/arch/powerpc/include/asm/nohash/mmu.h
index a037cb1efb57..edc793e5f08f 100644
--- a/arch/powerpc/include/asm/nohash/mmu.h
+++ b/arch/powerpc/include/asm/nohash/mmu.h
@@ -2,10 +2,18 @@
 #ifndef _ASM_POWERPC_NOHASH_MMU_H_
 #define _ASM_POWERPC_NOHASH_MMU_H_
 
-#ifdef CONFIG_PPC64
-#include <asm/nohash/64/mmu.h>
-#else
-#include <asm/nohash/32/mmu.h>
+#if defined(CONFIG_40x)
+/* 40x-style software loaded TLB */
+#include <asm/nohash/32/mmu-40x.h>
+#elif defined(CONFIG_44x)
+/* 44x-style software loaded TLB */
+#include <asm/nohash/32/mmu-44x.h>
+#elif defined(CONFIG_PPC_BOOK3E_MMU)
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+#elif defined (CONFIG_PPC_8xx)
+/* Motorola/Freescale 8xx software loaded TLB */
+#include <asm/nohash/32/mmu-8xx.h>
 #endif
 
 #endif /* _ASM_POWERPC_NOHASH_MMU_H_ */
-- 
2.13.3

