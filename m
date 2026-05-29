Return-Path: <linuxppc-dev+bounces-21731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52806CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:02:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmh17K6z3bsY;
	Sat, 30 May 2026 01:02:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066948;
	cv=none; b=fpp5Orm6fspH+kx6eKwkhb64YCixQzpEygwBT+hwNyVGk+wQFITBT4ZShfBFHurdqqhjFsai22Y6srgECBFrydrkzHN2FVVHDGW880SAPz13e62SsklpuXyd99jVPcpCwPikNtYVDHqELCKxdINNOtGfj0XZTZUlSHd1tqlHz7DQMp081gC1GoSFFP7ONCiWHkPEzpRtChmLPJeNw6v6SzwhtjEH+RYXkuUXdIFA6XSoh8EVDxbw3yNXjrUCjnK0rstV2Q8KZfrAr9qAxTUW/EXbDmfcV6w8wmXfXhLyZs/oBFswGk3iXbSG7hHz2eNnQDvcm1kwio1GfwRSH18yEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066948; c=relaxed/relaxed;
	bh=KwwWx+36ZO5AyFG8PbXK1ZtkzsCWR7UH7LxbrRw2oLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oOcKGLL6cVr7v2x55GZ/YCKBEGdp4tESO2MB45QRsjIDW3pcFpWSHmoUyzsN2x5QmX0k7XEcYP0FgPllXg6Do2fu9cbQUqrA/f/d6se2iKvnjqLH7ew1TtpCY5XX7/Ewv+BucMJX5zFliCT6gCgKOe8Srf+t7YpD4rNDT3xFCUQW3oqoT3yqGuamR2kuTCAhubLj5RyEtDp5aIBx5J0/ugScNMcHM+LEOpBdH6oaeZ7caQGq700iloPg6uwx5Yxe44nCXqBPUIerHVd4w1anJ4JTLWn6mqkhPRiuWpYqSkIDhAxstiW3VCJZi2AePLGDnA+FJ6uVyYN4p1S+2TmRHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Kj1vAa1c; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3f6ozaggkdjiwdzx+24f2aa270.ya8749gjbby-z0h74efe.al7wxe.ad2@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Kj1vAa1c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3f6ozaggkdjiwdzx+24f2aa270.ya8749gjbby-z0h74efe.al7wxe.ad2@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmf3VxKz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:26 +1000 (AEST)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-4909e55c480so9133105e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066943; x=1780671743; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwwWx+36ZO5AyFG8PbXK1ZtkzsCWR7UH7LxbrRw2oLU=;
        b=Kj1vAa1cNcgd8ND0pNYcJ8HD2Iw7g3329ZJq71phGIcf2TTgYjlaF//uDk0zvpcXv7
         O/02VRLCGd8bLplygEE/DetF9GW0FblYpYdsnSLvximV/mo7eHfjialslGBu8HGWP90T
         ckdHm7N59MpkTqijyFI3cRbRhn3LoUQrATHCzigYFlDcmfg46NCTDXs1/Ihk+VHuktAn
         RjIsNNnrFym2zPRzqjpGsa9rYX8iw/othx4SXUFo/C8gjZwSNCBg/eX03JB5Obl3lBaM
         OAbOqDzsJxd6eDfWioCol6fGUoSQCs6di6ry+8CH5Y12ElEfd0N09oTGUNrciAj4TbpQ
         oRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066943; x=1780671743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwwWx+36ZO5AyFG8PbXK1ZtkzsCWR7UH7LxbrRw2oLU=;
        b=Pxz9GbASKk3VPACNApD+c0Bjix1ufI8eUDT7V9/aLJoK7XN7f6D3sl5WfkbT4DE7TU
         KV9qV3tqYfJ8GY0GVcG+QcSRPH3i0YNAxKVs+2hKUjunNzuoQoTh9mfBmcBhzhGEoAHR
         Er5+7NY1CHsQ2nqRYAdgLl1AOnRDMlgtDkNtShDPtv+26Rrj/gb7uUXc4z52+8nV9hSn
         ALNaGXnH/VOj2llAiF7+9h5QaD1KlDIyiXXIHc+MOpcd+JebZV0Cw6Wrlf8xPrrLBXvX
         ujR3gMvCluAZX/mPw3KGdSWKrQXP708DCeApsF8/uDvLQEQlQedQsT6esuKXVftPKo73
         pBMA==
X-Forwarded-Encrypted: i=1; AFNElJ+8q0S4jqUTTecw2qSpW7W/58SMAF1/XmGPk7ZpBpOF6B8BsL86RcL1QZLKuNcmtdS+9utLszydmRKDMCM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwVexOTmjLVn+rMuBcJth3UCKZJKijqWE+GUyfW6rrJMvcL1qnN
	GLbH4xxie9ETbNvNwWqs9qAPDIypOXClNXBZ3PWiusguqBnOyhU7zqdH2LYLQNN5VQNmU/ROyg=
	=
X-Received: from wmbiv7.prod.google.com ([2002:a05:600c:5487:b0:48f:de29:3f52])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:2313:b0:490:6237:5213
 with SMTP id 5b1f17b1804b1-4909c0af69cmr42420765e9.23.1780066943345; Fri, 29
 May 2026 08:02:23 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:56 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
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
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700; i=ardb@kernel.org;
 h=from:subject; bh=JEV2e9VnURwytUBvbY/jPf+EEXewGZ41iq/e9jE9rQo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVap1rG3Fm6CS7u4UZS4lT7Z9HxxXNudcEuL6naq74
 afp7KCOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGPCgx/uKQ8e8xyJPt5JLP2
 bi5SltRnOvLycG3KFEeBXT7tu08rMTKsXffM79eljW7bhWbvntV0WFru9cWYiprdF6/MlLIvbk5 kAAA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-22-ardb+git@google.com>
Subject: [PATCH v7 05/15] arm64: mm: Preserve non-contiguous descriptors when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
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
2.54.0.823.g6e5bcc1fc9-goog


