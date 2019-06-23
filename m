Return-Path: <SRS0=EJr+=UW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1C2C43613
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Jun 2019 09:51:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946B520679
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Jun 2019 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC3Fgqht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946B520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Wnjr3n7yzDqY2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Jun 2019 19:50:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MC3Fgqht"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Wnbr5bj0zDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2019 19:45:44 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id cl9so5176039plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2019 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8jypfSRuf2tzCnQqgBbeT0KAA5/GWGPe8r0gYwybhoA=;
 b=MC3FgqhtZqqZOa3fca2etHFPOlAX/zHSptGaJf3qBl/azqwKXvi2ibRnsxz9AQxojg
 EICGDT1H4meg+DusobPeLFIRimkWAHJJDK/dlKDhDPS57IyazF6sl+ol2f+XRdncSjTx
 ujEpJ6IHP0e4ia/heO06G73O29JIvv3eBxJ8vsug9U/B1QpbHlPO/jQtEgUyBX1hHmH5
 zhJon/QZMy/0r5wuDPk+yXcnBxYz2434lS1tOAZo8EudlMygn0yOCpQ4Q+dnsj6bSIhB
 TiQ0NJrPR2ggTlL8e/n3bTP2N95KcpYLeCsOcEREJ/hqIDZLZqTrbj00s66H18rrjXqL
 +jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8jypfSRuf2tzCnQqgBbeT0KAA5/GWGPe8r0gYwybhoA=;
 b=bHBshrZSlzkX24FR2c3BVHaTDG0a4tn+6V5Mx/Q8Ztby35pHCBj79331exULK5uOVN
 /U/9sTThnsQKE07t1ca+zOyVvPBT79rY7KE8p1Ummi83i0OBLvDKRxC5sBK9h43esikL
 I2xk+8eqs7Vs8j+cK36HC4yqLGEA30zTSM3UbgrOooSN7tK63nIyJtDQ7yDXvG6JF9Qf
 B3YJkzb3bd93+tKxx+WBiHhegGWxUYBcVJyz6+EpaedL5/aD7rkl+lsli5m7gdhgUXRC
 +JRaUN+tmPx4+Sx9gnH8DgnC95HovDroR2IA8g+crXR8wpv97VyxejZqC0Pm8Usn3V5m
 BM1w==
X-Gm-Message-State: APjAAAUgI/M5Dpogbzuu1cP7jpvCqWETYN+2KvA+tpcACPapvaSe251o
 FxLVa7Ko2ZcqCRdYKcAAmK8=
X-Google-Smtp-Source: APXvYqxG5TUNwj0LFGeB24LqT2Ou4ZDW4mig65P9OQLsMEMD34gg1qObLUiUXmLaNRqELQkQNbwqkg==
X-Received: by 2002:a17:902:a517:: with SMTP id
 s23mr13564230plq.306.1561283142460; 
 Sun, 23 Jun 2019 02:45:42 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([1.129.156.141])
 by smtp.gmail.com with ESMTPSA id d26sm6181062pfn.29.2019.06.23.02.45.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 23 Jun 2019 02:45:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org
Subject: [PATCH 2/3] powerpc/64s: Add p?d_large definitions
Date: Sun, 23 Jun 2019 19:44:45 +1000
Message-Id: <20190623094446.28722-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190623094446.28722-1-npiggin@gmail.com>
References: <20190623094446.28722-1-npiggin@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The subsequent patch to fix vmalloc_to_page with huge vmap requires
HUGE_VMAP archs to provide p?d_large definitions for the non-pgd page
table levels they support.

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Upstream powerpc code does not enable HUGE_VMAP, but the powerpc next
tree has patches, so this patch is required to fix dependency between
this series and powerpc tree in linux-next.

 arch/powerpc/include/asm/book3s/64/pgtable.h | 24 ++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index ccf00a8b98c6..c19c8396a1bd 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -915,6 +915,11 @@ static inline int pud_present(pud_t pud)
 	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
 }
 
+static inline int pud_large(pud_t pud)
+{
+	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
+}
+
 extern struct page *pud_page(pud_t pud);
 extern struct page *pmd_page(pmd_t pmd);
 static inline pte_t pud_pte(pud_t pud)
@@ -958,6 +963,11 @@ static inline int pgd_present(pgd_t pgd)
 	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
 }
 
+static inline int pgd_large(pgd_t pgd)
+{
+	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
+}
+
 static inline pte_t pgd_pte(pgd_t pgd)
 {
 	return __pte_raw(pgd_raw(pgd));
@@ -1083,6 +1093,11 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mk_savedwrite(pmd)	pte_pmd(pte_mk_savedwrite(pmd_pte(pmd)))
 #define pmd_clear_savedwrite(pmd)	pte_pmd(pte_clear_savedwrite(pmd_pte(pmd)))
 
+static inline int pmd_large(pmd_t pmd)
+{
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
+}
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
 #define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
@@ -1151,15 +1166,6 @@ pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
 	return hash__pmd_hugepage_update(mm, addr, pmdp, clr, set);
 }
 
-/*
- * returns true for pmd migration entries, THP, devmap, hugetlb
- * But compile time dependent on THP config
- */
-static inline int pmd_large(pmd_t pmd)
-{
-	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-}
-
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
 	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
-- 
2.20.1

