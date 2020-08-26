Return-Path: <SRS0=u8mG=CE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC1C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 15:02:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB8C2074A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 15:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tV4+5Nx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB8C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bc8GH2NmQzDqP1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 01:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tV4+5Nx+; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bc85821nYzDqRD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2020 00:54:01 +1000 (AEST)
Received: by mail-pj1-x1043.google.com with SMTP id nv17so1000448pjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2020 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lZpeavpM6FR0EH3kfJJE/Au2m2iIw9NIl2DBgHhhejM=;
 b=tV4+5Nx+mWlMy1oPzbYssmbGFGn5MHDir+9Ml+ngC5YXRaOzyAwOFaifKm1R8UaWLX
 WQkXZvfbvY3oB5ULl79mFnabYoRV5BVHIVLrPO7hSistjiLvksufno1oOheZpuNe7odh
 cPO43oxRGgxo+TNxe1CNAUffQQJbpZlOvD1bN7nsgaLANe3l/5uKXIeq538FdXpyrHPR
 OgSaag90wBeVfRqyZUYj6CDGbu1+vItm3CEXZ02Jo8biOWyVnUPQhdZ1V6goCeTzxSSL
 TdSWKrdJAB4gR9cj8GvLOhpfeXcZelfyOXPY1BKqy3ngWA/gWgmLXh5kB6C1C5rA8jzc
 qavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lZpeavpM6FR0EH3kfJJE/Au2m2iIw9NIl2DBgHhhejM=;
 b=A3Td8BWTmK5XrcjHzf9dY7UabHfBIwOIOoLNfyyOz637OiuEO/fEdDwQ8XmAnXTVTl
 GoYFbcph4jNzZumOrfwgEzJZxEg0rHAiyDzO1W0Iyvayk9ONwuHEFGAbCoEFL18Q1OU/
 5rKSEhsCv3qx/gmSkqkkGiOvCIT+AxKQzEyJ9zOPq8Q4Ibvu5lf7QsJA0R6H6nZsw1oU
 3Z3CZIdzqxf6y4Tnw71LP+MsiN6aMpCVcFGAItWr0V4IEtapa+28OYmzpXxjudPKnZHM
 WAGagXCRaW92lxYdTI7uWinlAcDhf+EG34AuEsJ0itfzLq7GgL0QXn9e5Q/PsTo23TS7
 RBFQ==
X-Gm-Message-State: AOAM5327njvqrJ7q69zYPSp00utp9/QMoIbLZGwRPAHNQl3Qc1I6gJ++
 PkmvjBvWcN8u6aUWMriWbgU=
X-Google-Smtp-Source: ABdhPJx2B9QoNopM3vjtHv2uBEnKqWYo0WOtGbIQ2+KMIlZyPXpfHeAM0oiNKIprYdNp4bvVxSnUYw==
X-Received: by 2002:a17:902:704b:: with SMTP id
 h11mr12417938plt.307.1598453637947; 
 Wed, 26 Aug 2020 07:53:57 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
 by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 07:53:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-arch@vger.kernel.org
Subject: [PATCH v2 16/23] powerpc: use asm-generic/mmu_context.h for no-op
 implementations
Date: Thu, 27 Aug 2020 00:52:42 +1000
Message-Id: <20200826145249.745432-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mmu_context.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 7f3658a97384..bc22e247ab55 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -14,7 +14,9 @@
 /*
  * Most if the context management is out of line
  */
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 struct mm_iommu_table_group_mem_t;
@@ -235,27 +237,15 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-	switch_mm(prev, next, current);
-}
-
-/* We don't currently use enter_lazy_tlb() for anything */
+#ifdef CONFIG_PPC_BOOK3E_64
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
 	/* 64-bit Book3E keeps track of current PGD in the PACA */
-#ifdef CONFIG_PPC_BOOK3E_64
 	get_paca()->pgd = NULL;
-#endif
 }
+#endif
 
 extern void arch_exit_mmap(struct mm_struct *mm);
 
@@ -298,5 +288,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 	return 0;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
-- 
2.23.0

