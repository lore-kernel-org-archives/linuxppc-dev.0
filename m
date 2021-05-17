Return-Path: <SRS0=r+Zg=KM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1894C43460
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 06:18:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BBD61260
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 06:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BBD61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fk88T0YQ7z3c2C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 16:18:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=VGuccLrd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631;
 helo=mail-pl1-x631.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VGuccLrd; dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fk87066Pbz2xZS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2021 16:17:16 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id a11so2542604plh.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 May 2021 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tb6Q+4ZkP0HF5cA9E4010lvohyhoMm0NkErv1ILAPJ0=;
 b=VGuccLrdUG5VrwE+CG5lliHeOR7utv+bl3TzkdcMjNtSnUGL8tCVlBJDa22eE47VCW
 8s+0HeHtmI405C/LUvsylRSVEzxrygj/7QZhmr/SyR4tG95v37oDMPoWSbTHs2PCmcGA
 L6ITRM5IGnlaM5IQ9/PZ1k/6ggwOrXIvz8tMUFQpFFVlTc1pYjhTTx0EwSa0tqm3DdYp
 nUKfKiG4B2MYvQd8VTheJvPXE9UiygXJMkWzfzddCehmMSSLPLd8qPox6X5uPXjjqG0g
 NnF5HnpsG6T7cfCvNgfIf/OVPgE3LiQSduc8G3zu5l8+uDk4C2vOKsQCWsq+K33X1giI
 Vz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tb6Q+4ZkP0HF5cA9E4010lvohyhoMm0NkErv1ILAPJ0=;
 b=ADgNr/WbFKnlYr9ZYaSatmZPjaaVeI36xqtcm7mH+61fQeX3h/MBm0eppCIhrNk5T9
 qyTtnpWKJkKR5Vp5D/oEYIt1bZBmSJ0f297g9hsIsmzGdK6Rnmzy4+ZOJJD1o5/bbx7M
 USy5oRz63Tk0SJfelT4/SqbkA1hyRaBrojfo60EkUaJffFCIoqum6JKoUdYtn5REEAvB
 +aG0SF2yo/GpCQ11uRyGKPdpiWITnC5sY4LEM7Ld0q1gA1pSkOh1wG+QjT7Noemd+pjP
 VvFYZsgbmeoZ46B5w0vnqeND7aT04im0LzL885oG8ylMAmj/4NTklEHCZWspDDfA3If5
 kCfw==
X-Gm-Message-State: AOAM532tRa2Dql+CN9Pj4sF4EZdeCIvXTU72/Ooq/AMO7rlwNKsLCYCN
 9XoalJ/wtxZVgVcBpkROSy7pGlWgmVk=
X-Google-Smtp-Source: ABdhPJxQQ7xht6Rt3BWtB+rdDofRcRKdyUimvtoDXFq0nFlWMC09ioeIBx8oEDLrCmMQDBJuA0yUWw==
X-Received: by 2002:a17:90a:df8d:: with SMTP id
 p13mr8208192pjv.67.1621232234835; 
 Sun, 16 May 2021 23:17:14 -0700 (PDT)
Received: from tee480.ibm.com (159-196-117-139.9fc475.syd.nbn.aussiebb.net.
 [159.196.117.139])
 by smtp.gmail.com with ESMTPSA id gg2sm1505327pjb.45.2021.05.16.23.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 May 2021 23:17:14 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/64s: Remove unneeded #ifdef
 CONFIG_DEBUG_PAGEALLOC in hash_utils
Date: Mon, 17 May 2021 16:16:56 +1000
Message-Id: <20210517061658.194708-3-jniethe5@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517061658.194708-1-jniethe5@gmail.com>
References: <20210517061658.194708-1-jniethe5@gmail.com>
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
Cc: Jordan Niethe <jniethe5@gmail.com>, npiggin@gmail.com,
 aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@csgroup.eu>

debug_pagealloc_enabled() is always defined and constant folds to
'false' when CONFIG_DEBUG_PAGEALLOC is not enabled.

Remove the #ifdefs, the code and associated static variables will
be optimised out by the compiler when CONFIG_DEBUG_PAGEALLOC is
not defined.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 5b9709075fbd..d74482cce064 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -126,11 +126,8 @@ EXPORT_SYMBOL_GPL(mmu_slb_size);
 #ifdef CONFIG_PPC_64K_PAGES
 int mmu_ci_restrictions;
 #endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
 static u8 *linear_map_hash_slots;
 static unsigned long linear_map_hash_count;
-static DEFINE_SPINLOCK(linear_map_hash_lock);
-#endif /* CONFIG_DEBUG_PAGEALLOC */
 struct mmu_hash_ops mmu_hash_ops;
 EXPORT_SYMBOL(mmu_hash_ops);
 
@@ -326,11 +323,9 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			break;
 
 		cond_resched();
-#ifdef CONFIG_DEBUG_PAGEALLOC
 		if (debug_pagealloc_enabled() &&
 			(paddr >> PAGE_SHIFT) < linear_map_hash_count)
 			linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;
-#endif /* CONFIG_DEBUG_PAGEALLOC */
 	}
 	return ret < 0 ? ret : 0;
 }
@@ -965,7 +960,6 @@ static void __init htab_initialize(void)
 
 	prot = pgprot_val(PAGE_KERNEL);
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
 	if (debug_pagealloc_enabled()) {
 		linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
 		linear_map_hash_slots = memblock_alloc_try_nid(
@@ -975,7 +969,6 @@ static void __init htab_initialize(void)
 			panic("%s: Failed to allocate %lu bytes max_addr=%pa\n",
 			      __func__, linear_map_hash_count, &ppc64_rma_size);
 	}
-#endif /* CONFIG_DEBUG_PAGEALLOC */
 
 	/* create bolted the linear mapping in the hash table */
 	for_each_mem_range(i, &base, &end) {
@@ -1944,6 +1937,8 @@ long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
+static DEFINE_SPINLOCK(linear_map_hash_lock);
+
 static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 {
 	unsigned long hash;
-- 
2.25.1

