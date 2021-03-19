Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FDCC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 14:42:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197AD64F18
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 14:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197AD64F18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F267X4ggxz3cmF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 01:42:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=RB9K609x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::636;
 helo=mail-pl1-x636.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=RB9K609x; dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F265p6kwdz3c1h
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Mar 2021 01:41:18 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id q11so3054064pld.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qKLiRC30kOdPHC3UyyAEWstGuLi3bp5QolFCwAhhC7s=;
 b=RB9K609xBBKHLmVu6q0zBTHCurmpEPtTCvtNqpEq5RNh8dgYMtilKPNGL41//RV7E8
 Ua5icRvqI9/RhIxy6y9EtY9nDrLEDq6rlnBiR74X/IkmxlgfJFDHmwfydWhuEZOm65rj
 a9ceUlQqbrxKJjxyKrQQKLa18u7T8FtnPoA0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qKLiRC30kOdPHC3UyyAEWstGuLi3bp5QolFCwAhhC7s=;
 b=rcqNrvyJcb5bvLOswgxHoz0Uxxo9tPGP2EZQYglXuY9McDaMGuuNHZwBIJZzMKvZla
 HNb1uHR7gXvK6exBDOAXVJg9Oo+m2FmuVh2Vh0Pz2sT3yifpvC9bFE+Rys8hPX9k76t4
 j2/GL0Tw4fg1neLodVZwb2oenkOEW0kGYr0AjTBnSd9AWJ60vlZGhLIHihzLeDirRdmK
 x4SQ8q3DW1Fo+odaXFg3KJVocNVfuc4WVJLWVJyqe8vrMHWx+fM7+ER1L6LQW/9SFuv5
 JeB+WtoFSjTyYIgGJHjSemp4flXDTT4/JP4+IhWK6Ju2YlT2XGQEYZ073xmba25hwRCB
 PinQ==
X-Gm-Message-State: AOAM533xWitkkyCVfGuDnQ1VIAtsM/veQXWHddRFZfg+Uv+124/RG4no
 o7UIjDAhk/+i+rJ0Oru4miGY6g==
X-Google-Smtp-Source: ABdhPJxCL9BFVDeji3FA3iRoKvJ0vZhuKYAjDyiGePrtI2Wq8ptbQq6QVHVkHkYWt6+FsCizWW7jZw==
X-Received: by 2002:a17:90a:7786:: with SMTP id
 v6mr10062692pjk.16.1616164876553; 
 Fri, 19 Mar 2021 07:41:16 -0700 (PDT)
Received: from localhost
 (2001-44b8-111e-5c00-674e-5c6f-efc9-136d.static.ipv6.internode.on.net.
 [2001:44b8:111e:5c00:674e:5c6f:efc9:136d])
 by smtp.gmail.com with ESMTPSA id w8sm5204443pgk.46.2021.03.19.07.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 07:41:16 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
Subject: [PATCH v11 3/6] kasan: define and use MAX_PTRS_PER_* for early shadow
 tables
Date: Sat, 20 Mar 2021 01:40:55 +1100
Message-Id: <20210319144058.772525-4-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319144058.772525-1-dja@axtens.net>
References: <20210319144058.772525-1-dja@axtens.net>
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

powerpc has a variable number of PTRS_PER_*, set at runtime based
on the MMU that the kernel is booted under.

This means the PTRS_PER_* are no longer constants, and therefore
breaks the build.

Define default MAX_PTRS_PER_*s in the same style as MAX_PTRS_PER_P4D.
As KASAN is the only user at the moment, just define them in the kasan
header, and have them default to PTRS_PER_* unless overridden in arch
code.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/kasan.h | 18 +++++++++++++++---
 mm/kasan/init.c       |  6 +++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6bd8343f0033..68cd6e55c872 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -44,10 +44,22 @@ static inline bool kasan_arch_is_ready(void)	{ return true; }
 #define PTE_HWTABLE_PTRS 0
 #endif
 
+#ifndef MAX_PTRS_PER_PTE
+#define MAX_PTRS_PER_PTE PTRS_PER_PTE
+#endif
+
+#ifndef MAX_PTRS_PER_PMD
+#define MAX_PTRS_PER_PMD PTRS_PER_PMD
+#endif
+
+#ifndef MAX_PTRS_PER_PUD
+#define MAX_PTRS_PER_PUD PTRS_PER_PUD
+#endif
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
-extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS];
-extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
-extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
+extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS];
+extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
+extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 
 int kasan_populate_early_shadow(const void *shadow_start,
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index c4605ac9837b..b4d822dff1fb 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -41,7 +41,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
-pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
+pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
 static inline bool kasan_pud_table(p4d_t p4d)
 {
 	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
@@ -53,7 +53,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
+pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
 static inline bool kasan_pmd_table(pud_t pud)
 {
 	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
@@ -64,7 +64,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 	return false;
 }
 #endif
-pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS]
+pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS]
 	__page_aligned_bss;
 
 static inline bool kasan_pte_table(pmd_t pmd)
-- 
2.27.0

