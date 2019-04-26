Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469D4C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:05:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79902077B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="jTE1IRCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79902077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rJmG4f2PzDqNj
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:05:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="jTE1IRCS"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rJcG0bslzDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 01:58:05 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rJc91x3Qz9v0yS;
 Fri, 26 Apr 2019 17:58:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=jTE1IRCS; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 9oIV4NkfemJi; Fri, 26 Apr 2019 17:58:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rJc90vL1z9v0yM;
 Fri, 26 Apr 2019 17:58:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556294281; bh=3DWGS9kMt63W7GvktUW2iENPZqw4tVdX6j0rhiOzvIo=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=jTE1IRCShE3m7t04jgd6gFeGMsk80kMzyf524fmZ9myY1iQpcqKmaL8CFUkiZyRBN
 iiXKnBs62jSc4bHvPyo8FrDlu9IcMWRHvp+rZHYcWuq3YXzxoQpkmdueNRJG8eOctB
 ZXYmrbRSv2C5P6tN8eL/K5go88x0OPx+lxdOkJYY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BBB028B94A;
 Fri, 26 Apr 2019 17:58:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id YbZ5QGnrHNpt; Fri, 26 Apr 2019 17:58:02 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 98A7D8B82F;
 Fri, 26 Apr 2019 17:58:02 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 866C5666FE; Fri, 26 Apr 2019 15:58:02 +0000 (UTC)
Message-Id: <4f8ba02f8fbd355a140b5c33c8186e2c037a45a1.1556293738.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556293738.git.christophe.leroy@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 04/15] powerpc/mm: move pgtable_t in asm/mmu.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 15:58:02 +0000 (UTC)
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

pgtable_t is now identical for all subarches, move it to the
top level asm/mmu.h

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h | 4 ----
 arch/powerpc/include/asm/book3s/64/mmu.h      | 8 --------
 arch/powerpc/include/asm/mmu.h                | 3 +++
 arch/powerpc/include/asm/nohash/32/mmu.h      | 6 ------
 arch/powerpc/include/asm/nohash/64/mmu.h      | 6 ------
 5 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index f9eae105a9f4..2e277ca0170f 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -10,8 +10,6 @@
  * BATs
  */
 
-#include <asm/page.h>
-
 /* Block size masks */
 #define BL_128K	0x000
 #define BL_256K 0x001
@@ -49,8 +47,6 @@ struct ppc_bat {
 	u32 batu;
 	u32 batl;
 };
-
-typedef pte_t *pgtable_t;
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 230a9dec7677..d4a94c2b29f2 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -25,14 +25,6 @@ struct mmu_psize_def {
 	};
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
-
-/*
- * For BOOK3s 64 with 4k and 64K linux page size
- * we want to use pointers, because the page table
- * actually store pfn
- */
-typedef pte_t *pgtable_t;
-
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index d86c5641bd97..ba94ce8c22d7 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -129,6 +129,9 @@
 #ifndef __ASSEMBLY__
 #include <linux/bug.h>
 #include <asm/cputable.h>
+#include <asm/page.h>
+
+typedef pte_t *pgtable_t;
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
 #include <asm/percpu.h>
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
index 7d94a36d57d2..af0e8b54876a 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
 #define _ASM_POWERPC_NOHASH_32_MMU_H_
 
-#include <asm/page.h>
-
 #if defined(CONFIG_40x)
 /* 40x-style software loaded TLB */
 #include <asm/nohash/32/mmu-40x.h>
@@ -18,8 +16,4 @@
 #include <asm/nohash/32/mmu-8xx.h>
 #endif
 
-#ifndef __ASSEMBLY__
-typedef pte_t *pgtable_t;
-#endif
-
 #endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
index 26e05ce8f5aa..e490ecdac012 100644
--- a/arch/powerpc/include/asm/nohash/64/mmu.h
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -4,13 +4,7 @@
 
 #define MAX_PHYSMEM_BITS        44
 
-#include <asm/page.h>
-
 /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
 #include <asm/nohash/mmu-book3e.h>
 
-#ifndef __ASSEMBLY__
-typedef pte_t *pgtable_t;
-#endif
-
 #endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
-- 
2.13.3

