Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB9FC43218
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:45:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC9E2081C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="DGjRY1gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC9E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qg2b4dtKzDqZG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:45:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="DGjRY1gx"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qfhZ55YQzDqZX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:29:32 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44qfhR4HD4z9v06g;
 Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=DGjRY1gx; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uO3-pXg7tSn6; Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhR3BMXz9v06V;
 Thu, 25 Apr 2019 16:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556202567; bh=Qhx8/SU8t6fwdaGfhg4qR3CfzF0RJnLZe1YqN9ckqjc=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=DGjRY1gxHE3SQ6yDxwK0QpLSFh/k6ZDxROWx26KukYvZsb2q7/G2fr/qrSIk0STgo
 oXr+QVq/vLxWkAN6C2a8+BEE5Krj3yZtTlA4ClEypSuc1M9iMJI0MeqRRmiwnCKUH+
 xLfPjlB+2t+BNXD1ULwU58k635TcGuiahwKxrS6I=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EC3298B931;
 Thu, 25 Apr 2019 16:29:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Xv7Of_l3GwBZ; Thu, 25 Apr 2019 16:29:28 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C45B28B923;
 Thu, 25 Apr 2019 16:29:28 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 9814A66276; Thu, 25 Apr 2019 14:29:28 +0000 (UTC)
Message-Id: <97938d4257ac4b7b5690fdaf38c31c4e12f0a73c.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 02/11] powerpc/mm: no slice for nohash/64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Thu, 25 Apr 2019 14:29:28 +0000 (UTC)
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

Only nohash/32 and book3s/64 support mm slices.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/64/slice.h | 12 ------------
 arch/powerpc/include/asm/slice.h           |  4 +---
 arch/powerpc/platforms/Kconfig.cputype     |  4 ++++
 3 files changed, 5 insertions(+), 15 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/64/slice.h

diff --git a/arch/powerpc/include/asm/nohash/64/slice.h b/arch/powerpc/include/asm/nohash/64/slice.h
deleted file mode 100644
index ad0d6e3cc1c5..000000000000
--- a/arch/powerpc/include/asm/nohash/64/slice.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_NOHASH_64_SLICE_H
-#define _ASM_POWERPC_NOHASH_64_SLICE_H
-
-#ifdef CONFIG_PPC_64K_PAGES
-#define get_slice_psize(mm, addr)	MMU_PAGE_64K
-#else /* CONFIG_PPC_64K_PAGES */
-#define get_slice_psize(mm, addr)	MMU_PAGE_4K
-#endif /* !CONFIG_PPC_64K_PAGES */
-#define slice_set_user_psize(mm, psize)	do { BUG(); } while (0)
-
-#endif /* _ASM_POWERPC_NOHASH_64_SLICE_H */
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index 44816cbc4198..be8af667098f 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -4,9 +4,7 @@
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/slice.h>
-#elif defined(CONFIG_PPC64)
-#include <asm/nohash/64/slice.h>
-#elif defined(CONFIG_PPC_MMU_NOHASH)
+#elif defined(CONFIG_PPC_MMU_NOHASH_32)
 #include <asm/nohash/32/slice.h>
 #endif
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 00b2bb536c74..04915f51f447 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -391,6 +391,10 @@ config PPC_MMU_NOHASH
 	def_bool y
 	depends on !PPC_BOOK3S
 
+config PPC_MMU_NOHASH_32
+	def_bool y
+	depends on PPC_MMU_NOHASH && PPC32
+
 config PPC_BOOK3E_MMU
 	def_bool y
 	depends on FSL_BOOKE || PPC_BOOK3E
-- 
2.13.3

