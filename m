Return-Path: <linuxppc-dev+bounces-21537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353E2CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:43:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ77z6b0Yz2xq0;
	Wed, 27 May 2026 08:43:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818370;
	cv=none; b=cWd9swu1ne7SBEXaXk9S5cdIRK8xnaSSaXes7Dt2ESaGlBOVS0rXdzfgU4p9hzhfGhvnOTL0uuJqa4G37uoy3K9KRjoWge0aNxKgJhVpWOqWhzU3uG2W3CAGgStE0RgU0VXHnwFqBHbiwfxw06V0aCa71gDq7CT0azoZeUt5LJ35yVJMSFUdLZTsmG1lmWCrIUWDEt25kbZpBMXzZOUeGSFycS/Doap2v/BO2roVgpHdUesmIIF0t3hGKfBOQgkuUoJOVpaMJYdyne32KRNstWsTpL7xYj2+BOSBaIFUppq6Tt/5b+mnKHJZWfhTXGKg6UrwRMX7EsAouMTwL0zi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818370; c=relaxed/relaxed;
	bh=cVtRZrGktzRjCdUnH3kN7Vy8R0F1sW5LmttIAYz/k8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kHrcjCc3yexuX8hTSQxlYA+JySCGk7UwOH8bLfNhf/3tF1xOCqEFwhi00mBw+u6gXr0s5MpxI/VAQOXBlC7eDuCgsJrTA8bsAGYD9VgYEL8AEsOUsJwHAhz7p/drSRJflIFe2DnR03SCq8FlbfHSM+Qg21Cu/QjYeS+6OBdCuGFgAlFjiMDtsCRhU8OUx43LpTwd8Qiz9uvZbfMvpabbHYCGDku4GL/g027yjdsSmkzzXDp7XatJm8UhUASlRYZkKmbOUmGh+nxAzIOrnUmDDJ+DZ8OPTA39/fNDNAQCWt2OPPi58xtA3cN+GXvVPVQnPmej3wEQeClsNPjS9Mwu2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=usQyEmUy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::549; helo=mail-ed1-x549.google.com; envelope-from=3ft8vaggkdosneqo+tvgtbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=usQyEmUy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::549; helo=mail-ed1-x549.google.com; envelope-from=3ft8vaggkdosneqo+tvgtbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rL0GXYz2yD6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:29 +1000 (AEST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-671495fcedcso7143371a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818367; x=1780423167; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVtRZrGktzRjCdUnH3kN7Vy8R0F1sW5LmttIAYz/k8A=;
        b=usQyEmUyguxt04No5OJoFxhU7QGnbcBtPQCeLJtZcpHII3DmcaX0YE0q+8yaCoMJBQ
         9+nbGZbOAo2eFBdpbD5kfkE9wIBLvy0kVwtECA7kEoEbJDNFsIgs5mkqEZlWeMylIpXL
         0sGnSq7newll1fCVhot6fFszECCb8P/9MoV606K1yRPPnUUSUd29x81iNcdeU16qpTSn
         yqx9/R1h74x8E1w/Rok4BFecqU66AcdE1zSpghth6G1L0XSLfoC58waO0khYuExWtPzw
         hyTnhTG1U5L85QAkvoJqksX8LXtUO46uQcYHpNIs58Bhf+Y7t7qsrlKamgocrI10bR0g
         rgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818367; x=1780423167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVtRZrGktzRjCdUnH3kN7Vy8R0F1sW5LmttIAYz/k8A=;
        b=W9Yd4Ae3wiJEJlPLX3OBlSjNd5XSxN3ou/H50WBOnYm6g4ynEFXclFkqhukhOyzowy
         LSXFMN7DusbXFtcjkJAaU1dgmSzCvwSNsA/35L7pma7oJA2Qb2Ekzy/hPzeYslNDmfC6
         p0Exm/tn1k0HWD08COBfwDrZ2cEwJSL9Xb23g6+xjp/b8uqUN+bh8Sq+bOt1XE9xQwQF
         pglws+iTgKUwnEmMOHnM3chk0dQkKwhEiINQle6PQ0YfUfQkleZUxyKrsqmNFhKOgTpy
         niHx6SmiFia3Dj3KGsjGRoSPfzC9IynpXDZfkIRwyvs8MGIJCPA8xl28YLdhoU9005aL
         VF8A==
X-Forwarded-Encrypted: i=1; AFNElJ8DP5Br7vlvoDRzr53BAo3rW7iH2QB2aKOJjPudMsyDr6XXxboYeHHpPipBN9F3eg9uL9xQuMBTQhRG0nU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvGcGYFwrUvwVZRavU+DFbHc/1WaKd6XTG58Gl9Msfaosf5YdI
	ElxGxil2S5U0nv0+rnxYJGXBGj9q0moSQIyAvb0jCcx7TPEGohpeYbLwjYpefyaSLe7GRlJvPg=
	=
X-Received: from edgg7.prod.google.com ([2002:a05:6402:1ec7:b0:687:a46:a91a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3891:b0:683:1cc8:84b0
 with SMTP id 4fb4d7f45d1cf-6889c41ece7mr9857461a12.1.1779818366685; Tue, 26
 May 2026 10:59:26 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:52 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700; i=ardb@kernel.org;
 h=from:subject; bh=z6XqclO2VktRYngIWmFbVHfouJpd6sLXvnE8xwKtYlk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0flxH4ekTmyZ0HhJ9JL0wwCSxxnH9nteLX//dwO4dq
 58gueBoRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI3R2G36zF1sq/DnmIFKhu
 n6+5tapE4TVTQeM123nvlwhbO97ZVc/wV4jD64xshEfNl9JbBTcNtzWsVTgTNfuZcwu3tFeOvPJ UZgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-22-ardb+git@google.com>
Subject: [PATCH v6 05/15] arm64: mm: Preserve non-contiguous descriptors when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of blindly overwriting existing live entries regardless of the
value of their contiguous bit when mapping DRAM regions at
contiguous-hint granularity, check whether the contiguous region in
question contains any valid descriptors that have the contiguous bit
cleared, and in that case, leave the contiguous bit unset on the entire
region. This permits the logic of mapping the kernel's linear alias to
be simplified in a subsequent patch.

Note that this can only result in a misprogrammed contiguous bit (as per
ARM ARM RNGLXZ) if the region in question already contains a mix of
valid contiguous and valid non-contiguous descriptors, in which case it
was already misprogrammed to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h |  4 ++++
 arch/arm64/mm/mmu.c              | 22 ++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4dfa42b7d053..a1c5894332d9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -181,6 +181,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
  * Returns true if the pte is valid and has the contiguous bit set.
  */
 #define pte_valid_cont(pte)	(pte_valid(pte) && pte_cont(pte))
+/*
+ * Returns true if the pte is valid and has the contiguous bit cleared.
+ */
+#define pte_valid_noncont(pte)	(pte_valid(pte) && !pte_cont(pte))
 /*
  * Could the pte be present in the TLB? We must check mm_tlb_flush_pending
  * so that we don't erroneously return false for pages that have been
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5c827fa3cd38..6b42d724bd1b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -187,6 +187,14 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
 }
 
+static bool pte_range_has_valid_noncont(pte_t *ptep)
+{
+	for (int i = 0; i < CONT_PTES; i++)
+		if (pte_valid_noncont(__ptep_get(&ptep[i])))
+			return true;
+	return false;
+}
+
 static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 			       unsigned long end, phys_addr_t phys,
 			       pgprot_t prot,
@@ -224,7 +232,8 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pte_range_has_valid_noncont(ptep))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pte(ptep, addr, next, phys, __prot);
@@ -283,6 +292,14 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	return 0;
 }
 
+static bool pmd_range_has_valid_noncont(pmd_t *pmdp)
+{
+	for (int i = 0; i < CONT_PMDS; i++)
+		if (pte_valid_noncont(pmd_pte(READ_ONCE(pmdp[i]))))
+			return true;
+	return false;
+}
+
 static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 			       unsigned long end, phys_addr_t phys,
 			       pgprot_t prot,
@@ -324,7 +341,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_CONT_MAPPINGS) == 0 &&
+		    !pmd_range_has_valid_noncont(pmdp))
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
-- 
2.54.0.794.g4f17f83d09-goog


