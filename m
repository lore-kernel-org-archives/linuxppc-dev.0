Return-Path: <linuxppc-dev+bounces-20901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804BFCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:21:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvHb692vz2yps;
	Wed, 13 May 2026 23:21:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678491;
	cv=none; b=MYHDiKR6+mZCPqPkncabnb8CYy5GyZ0So2Wcx0FZiM4kct6+WsH9pzPjP1pqrgienRbp7wouAYdH4p499+G/XZHvg5Dpeyt5bkfdm6+RwPtsiYh/9jl62m/ceOY6zgglutYasn9hZPKbDdKL+3ggGJe6NjZJIc1v1IYqPU73WHYytB0RaNCY/b8hPUAID//EudBHJibL4mqdDAmTm9dS8T5yY7cVaOF9A/osSobcDwmoSvVe9ATqg1n6/EHBiF6nmjNv2fIQgQbFVYM1SYBoLpsTVJDSe9+P96JnQtvCkOkAU4o4pDWN9ph9nsKIJY0z9yzO/Cu5s2u7XyIH8apffA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678491; c=relaxed/relaxed;
	bh=3PXFCj0/ECPhuZwScmmiKfqjkOg4F11/Y6QM4pfwtxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivRN70u34QO0NQ4TWf/s1xDdw9l5nO7HeBZSDoL7a8t0E2mMA3gXj0JlFGlasJaF17IPx04fGDmMbaWGP1hcQfTXtzU2yFHEQJuSoB2PEepNl1U2HE0daoFCA599oxSQRHmrdoPsenT5+hMbI2aO1sD7kA3Y9UX7YfdwL4+nMy7ERxkvCnoE2dPKQHAhtEu4w+0pXp29zvP1S/wrqTl2uOvSp9HTKn3dMssYegxNkx3W3hWU7IfoTaxYvjaTg+k7yj8Fq9DQctZwYChFZNtjtNdOrBXHdZ6zfX6lTa3d21LR/yCFppVkml/jRFG4DvHSmwxPir1MIu5cgNgj3vaDjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Nix2Yt6+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Nix2Yt6+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvHb0t4vz2yTP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:31 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-369002b26f4so351270a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678489; x=1779283289; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PXFCj0/ECPhuZwScmmiKfqjkOg4F11/Y6QM4pfwtxE=;
        b=Nix2Yt6+r244dpZbqj0jQQ0+srKOwql8+ENS9MCALGmEJhzQwsUSE94MMlThTdj4tE
         KeFWGvbeC1HtC1EeB3dOgrwmQZ/8JrvJa7dTjzWl1ZFXc268jPCbga6h+hFQOng12pr3
         K1nFQ/50rPxoXVlPS55Ir785Z0d4zmAoGl3zILvnpbd6Yw9ealEMT63QyvP4H0td6T/s
         X9U71TkNJ5dIAI0NfNWT5PDAtbP8vaSt7gVRNd1ph3ZyneP/bsN/MvHoDmjI3S8nWDdw
         /Z6u2VWJKGQHJAR5gZkJPsnfqtlIO30Q4rD3TuklXW+2AKGjCXLyt8RwnlS2pzKN/Mea
         E7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678489; x=1779283289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PXFCj0/ECPhuZwScmmiKfqjkOg4F11/Y6QM4pfwtxE=;
        b=sCH2sb0ePedzKAxkp9B9dcwJQ0KQGMtnHDbZxJWBkNC52uo5NsNytrxphn/rSPX2qW
         4ryjppDtdahTP4P3xgpS8wrg9bTM99qyQoRGpt0eknhfFcKhDyVJ7v3++96jI9VOD5fr
         qNENqOf4fSW0C8aiMfbhCuKUdyqmSVoDeaQSujt7VCgPZQtCsn9YVhzWedi8Mr+7m4Zi
         6gLhMShsNjW+/gBCoKO1OUIvaJjs87WCoew0pWP8oatvpsUJ8AVK7IX/KYYKgKU2POnq
         0a2BUN/vh/dcscCm1rsjME7aUVLv09DR2o7axWL1RKOdevYAmVxRLLXHIa1T3gMHhIIR
         H66g==
X-Forwarded-Encrypted: i=1; AFNElJ+tQYsw2pGKHOzQzKtZh+TGQKu6dNmVL1v8iUZtOrXnI5frbAeUtO3eAnFXg7x00CpId2pl1f1ZAYbbC+Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2uKxW0RFCuyD5tkYj2yQly2Ch3QIIGni+yYVNdtAE4O9ZSEL4
	r0tRlyizL4FTIJZ5HyYcrizKJnBc1J/8rYhdEKwNrnkEMVNJvdEGvwqnN7J0na9zVeU=
X-Gm-Gg: Acq92OE6qQWkry5EXlw/iHko8vCa339KjLkVJcAYC+4A7VSih+anyGhFar3DuG40yJN
	qCkXljogfBLfk5TUZBjJz6kZVwBLez7hZP7gK/GCQjWAlSsUGrArm+BiSKaHyAvtthzXH16hYGx
	R0GD+Y/GykOPPjP3bMFzorUeaEvW3qHWlFg3XwNiDQOOtMXtypNI2zVKacEZvpM4kFafJvGLODj
	i49C5ytBSF9lW9BlA13oOhk+jWNicP79u74Czjguug5gBteKOl9B6Sme6e8xOv9uUNybGmtF/5K
	pUxM9xya81X7qMU/jXCTebgYclLEerl5sPRFyCJIibleFmrpU2aTvMW3u15HF3ScMXmuMxnPOCq
	wxIwoqRXOV+ACilt/GlawKw7SBBcp2hby/SqctsNPHpCY0hLe/2zI9ky/erk+DreLNcaKacPWTa
	QfPlL+j937AaPTQoK8vLs9b4gHhobpWONk/7sQ23jXkYCQihXzFjw5D6zy2JME
X-Received: by 2002:a17:90b:1b0d:b0:35f:b5df:453 with SMTP id 98e67ed59e1d1-368f79cd1dfmr2775567a91.22.1778678489114;
        Wed, 13 May 2026 06:21:29 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.21.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:21:28 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 52/69] powerpc/mm: Drop powerpc vmemmap_can_optimize()
Date: Wed, 13 May 2026 21:20:17 +0800
Message-ID: <20260513132044.41690-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PowerPC no longer needs an architecture-specific vmemmap_can_optimize()
override for DAX vmemmap optimization.

Whether the optimized mapping can be used is now decided in the
architecture-specific vmemmap_populate() path. When PowerPC has to fall
back, such as on Hash MMU, it can simply clear the section order there
and disable the optimization for that section.

Drop the radix-specific vmemmap_can_optimize() override and rely on the
generic checks instead.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  5 -----
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 10 ----------
 arch/powerpc/mm/init_64.c                  |  1 +
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8452a2714cb1..df67209b0c5b 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -351,10 +351,5 @@ int radix__create_section_mapping(unsigned long start, unsigned long end,
 				  int nid, pgprot_t prot);
 int radix__remove_section_mapping(unsigned long start, unsigned long end);
 #endif /* CONFIG_MEMORY_HOTPLUG */
-
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-#define vmemmap_can_optimize vmemmap_can_optimize
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
-#endif
 #endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 4c3d027c823c..2f8783b3f678 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -977,16 +977,6 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
-{
-	if (radix_enabled())
-		return __vmemmap_can_optimize(altmap, pgmap);
-
-	return false;
-}
-#endif
-
 int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 				unsigned long addr, unsigned long next)
 {
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index b6f3ae03ca9e..8e18ed427fdd 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -283,6 +283,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		return radix__vmemmap_populate(start, end, node, altmap);
 #endif
 
+	section_set_order(__pfn_to_section(page_to_pfn((struct page *)start)), 0);
 	return __vmemmap_populate(start, end, node, altmap);
 }
 
-- 
2.54.0


