Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C79BC43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:38:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C97820693
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fS4TAjwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C97820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rKW54fqzzDqCR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:38:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="fS4TAjwz"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rK9f634LzDqPT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 02:23:34 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rK9Z1Ks0z9v17w;
 Fri, 26 Apr 2019 18:23:30 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=fS4TAjwz; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id gwA0PTIrOIMs; Fri, 26 Apr 2019 18:23:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rK9Z02rbz9v17t;
 Fri, 26 Apr 2019 18:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556295810; bh=T5roomQKloe+Cr1IT+Xg0/TzN2EQ/rbW1mXIN5nYL+c=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=fS4TAjwzTicw/PUlQxOzcTBcJWoAgSLee/JkoM02O9SX9kqJf+NtFvrjUoySYCaBw
 9ZIKcPUED7JwQC0VKuTlyclCGMOASmCWAMHF0j+Nra2R6/xoeKWfu7y98NcSybCLjn
 N6vG6KypL9alARPP0Kg3feEZLF3+Od69rVeXv1NI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A667C8B950;
 Fri, 26 Apr 2019 18:23:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Hp1PCONqW6O8; Fri, 26 Apr 2019 18:23:31 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 78E758B82F;
 Fri, 26 Apr 2019 18:23:31 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 68403666FE; Fri, 26 Apr 2019 16:23:31 +0000 (UTC)
Message-Id: <1e92f048b27d26473b822ef6663d4a0eb004f5c3.1556295460.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556295459.git.christophe.leroy@c-s.fr>
References: <cover.1556295459.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v11 07/13] powerpc/32: make KVIRT_TOP dependent on FIXMAP_START
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Fri, 26 Apr 2019 16:23:31 +0000 (UTC)
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

When we add KASAN shadow area, KVIRT_TOP can't be anymore fixed
at 0xfe000000.

This patch uses FIXADDR_START to define KVIRT_TOP.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 13 ++++++++++---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 13 ++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index aa8406b8f7ba..838de59f6754 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -134,15 +134,24 @@ static inline bool pte_user(pte_t pte)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+
+#ifndef __ASSEMBLY__
+
+int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
+
+#endif /* !__ASSEMBLY__ */
+
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
  * value (for now) on others, from where we can start layout kernel
  * virtual space that goes below PKMAP and FIXMAP
  */
+#include <asm/fixmap.h>
+
 #ifdef CONFIG_HIGHMEM
 #define KVIRT_TOP	PKMAP_BASE
 #else
-#define KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
+#define KVIRT_TOP	FIXADDR_START
 #endif
 
 /*
@@ -373,8 +382,6 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
-int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
-
 /* Generic accessors to PTE bits */
 static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
 static inline int pte_read(pte_t pte)		{ return 1; }
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index bed433358260..0284f8f5305f 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -64,15 +64,24 @@ extern int icache_44x_need_flush;
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
+#ifndef __ASSEMBLY__
+
+int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
+
+#endif /* !__ASSEMBLY__ */
+
+
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
  * value (for now) on others, from where we can start layout kernel
  * virtual space that goes below PKMAP and FIXMAP
  */
+#include <asm/fixmap.h>
+
 #ifdef CONFIG_HIGHMEM
 #define KVIRT_TOP	PKMAP_BASE
 #else
-#define KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
+#define KVIRT_TOP	FIXADDR_START
 #endif
 
 /*
@@ -379,8 +388,6 @@ static inline int pte_young(pte_t pte)
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
-int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_POWERPC_NOHASH_32_PGTABLE_H */
-- 
2.13.3

