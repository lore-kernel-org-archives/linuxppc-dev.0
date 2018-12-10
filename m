Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD1C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 12:26:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FBC2086D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 12:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FBC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D2Nw2dGFzDr9y
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 23:26:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D2KT1bzqzDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 23:23:09 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43D2KP3cZGz9v6Jl;
 Mon, 10 Dec 2018 13:23:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IiZp27ydnH8M; Mon, 10 Dec 2018 13:23:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43D2KP2ryCz9v6Jj;
 Mon, 10 Dec 2018 13:23:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E72998B7B0;
 Mon, 10 Dec 2018 13:23:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id P3U917INE2Et; Mon, 10 Dec 2018 13:23:05 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C86F28B7A9;
 Mon, 10 Dec 2018 13:23:05 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B0171716F0; Mon, 10 Dec 2018 12:23:05 +0000 (UTC)
Message-Id: <77dc61d57af91aa944f2416fefaa5cc27016d796.1544444552.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: define an empty slice_init_new_context_exec()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 10 Dec 2018 12:23:05 +0000 (UTC)
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

Define slice_init_new_context_exec() at all time to avoid

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/slice.h     | 14 +++++++++-----
 arch/powerpc/mm/mmu_context_nohash.c |  2 --
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index a595461c9cb0..44816cbc4198 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -10,6 +10,10 @@
 #include <asm/nohash/32/slice.h>
 #endif
 
+#ifndef __ASSEMBLY__
+
+struct mm_struct;
+
 #ifdef CONFIG_PPC_MM_SLICES
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -18,10 +22,6 @@
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
-#ifndef __ASSEMBLY__
-
-struct mm_struct;
-
 unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 				      unsigned long flags, unsigned int psize,
 				      int topdown);
@@ -34,8 +34,12 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 void slice_init_new_context_exec(struct mm_struct *mm);
 void slice_setup_new_exec(void);
 
-#endif /* __ASSEMBLY__ */
+#else /* CONFIG_PPC_MM_SLICES */
+
+static inline void slice_init_new_context_exec(struct mm_struct *mm) {}
 
 #endif /* CONFIG_PPC_MM_SLICES */
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_POWERPC_SLICE_H */
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 431ecf37f17c..22d71a58167f 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -372,7 +372,6 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 {
 	pr_hard("initing context for mm @%p\n", mm);
 
-#ifdef	CONFIG_PPC_MM_SLICES
 	/*
 	 * We have MMU_NO_CONTEXT set to be ~0. Hence check
 	 * explicitly against context.id == 0. This ensures that we properly
@@ -382,7 +381,6 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 	 */
 	if (mm->context.id == 0)
 		slice_init_new_context_exec(mm);
-#endif
 	mm->context.id = MMU_NO_CONTEXT;
 	mm->context.active = 0;
 	pte_frag_set(&mm->context, NULL);
-- 
2.13.3

