Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52997C10F05
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:49:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02FA2184E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ayFt+6Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02FA2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PRVx1kYKzDqDS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:49:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ayFt+6Uy"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZJ6wQXzDqJS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:07:04 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQZD4Ldlz9vC00;
 Wed, 20 Mar 2019 11:07:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ayFt+6Uy; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id P1HEMYxrAL9q; Wed, 20 Mar 2019 11:07:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZD303zz9vByx;
 Wed, 20 Mar 2019 11:07:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076420; bh=p1320MT2AD9wARLRu0EAvOL85pBiGOIq1EL25ZZos+M=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=ayFt+6UyoxOAduX1bKC6O73mvPx5zmDGzi/A/+cTjwyP4t+t68f5uuF8an+4k/xVq
 a3WISzlIy11T1AkAQ8+qNXE1x+KX1sFT5Vq7qRh6LvPGqhzNF3AuKsc7/PqqQYzK8b
 e5fQExZI7oPLBZDkzRMuLUKdjKldQu5V02aJ+vec=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 48C248B918;
 Wed, 20 Mar 2019 11:07:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id RYiFnsfE_Rw0; Wed, 20 Mar 2019 11:07:01 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 00F048B911;
 Wed, 20 Mar 2019 11:07:00 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C2AB163AEF; Wed, 20 Mar 2019 10:07:00 +0000 (UTC)
Message-Id: <728efa7f67c335835b91fc45cc1eed724541febd.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 24/27] powerpc: define subarch SLB_ADDR_LIMIT_DEFAULT
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:07:00 +0000 (UTC)
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

This patch defines a subarch specific SLB_ADDR_LIMIT_DEFAULT
to remove the #ifdefs around the setup of mm->context.slb_addr_limit

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/slice.h | 2 ++
 arch/powerpc/include/asm/nohash/32/slice.h | 2 ++
 arch/powerpc/kernel/setup-common.c         | 8 +-------
 arch/powerpc/mm/slice.c                    | 6 +-----
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index af498b0da21a..8da15958dcd1 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -13,6 +13,8 @@
 #define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
+#define SLB_ADDR_LIMIT_DEFAULT	DEFAULT_MAP_WINDOW_USER64
+
 #else /* CONFIG_PPC_MM_SLICES */
 
 #define get_slice_psize(mm, addr)	((mm)->context.user_psize)
diff --git a/arch/powerpc/include/asm/nohash/32/slice.h b/arch/powerpc/include/asm/nohash/32/slice.h
index 777d62e40ac0..39eb0154ae2d 100644
--- a/arch/powerpc/include/asm/nohash/32/slice.h
+++ b/arch/powerpc/include/asm/nohash/32/slice.h
@@ -13,6 +13,8 @@
 #define SLICE_NUM_HIGH		0ul
 #define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
 
+#define SLB_ADDR_LIMIT_DEFAULT	DEFAULT_MAP_WINDOW
+
 #endif /* CONFIG_PPC_MM_SLICES */
 
 #endif /* _ASM_POWERPC_NOHASH_32_SLICE_H */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2e5dfb6e0823..af2682d052a2 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -948,14 +948,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = klimit;
 
 #ifdef CONFIG_PPC_MM_SLICES
-#ifdef CONFIG_PPC64
 	if (!radix_enabled())
-		init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
-#elif defined(CONFIG_PPC_8xx)
-	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
-#else
-#error	"context.addr_limit not initialized."
-#endif
+		init_mm.context.slb_addr_limit = SLB_ADDR_LIMIT_DEFAULT;
 #endif
 
 #ifdef CONFIG_SPAPR_TCE_IOMMU
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 50b1a5528384..64513cf47e5b 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -652,11 +652,7 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	 * case of fork it is just inherited from the mm being
 	 * duplicated.
 	 */
-#ifdef CONFIG_PPC64
-	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
-#else
-	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
-#endif
+	mm->context.slb_addr_limit = SLB_ADDR_LIMIT_DEFAULT;
 
 	mm->context.user_psize = psize;
 
-- 
2.13.3

