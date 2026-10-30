Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02C606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dEbLri8V
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGNHd6WjSz30Vv;
	Sat, 31 Oct 2026 01:08:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793369325;
	cv=none; b=WtUGjkCPybllKI2qxBCouhPZXdopBerc4PvJ30YgjPNGsXSldMucAxaHhm+eYKZSdgvKu5vtO6yeVqskK/EKOGtWf6TDs8JBqiLvS/+Afonjpq+ecKJaFqsq0xmHefo3CKFNBA7jHaPjSx36tCV615BnGpeCPXp+dElIOXBd31g0Zqafw5KAH95RetL+RSyrj43g0St7Xz7KSCsOVYnobZs2O5LpLvgcUOluBNUzeSnFfRyiOR+zakc2wfP8g3SC6i+g9cMqH/qqslx7NZkDxXu+90vz71IEddQBw3XP35K38BZdLpdWbshEG7he0S5fKw9XUrEJpM865ZTuYjRsew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793369325; c=relaxed/relaxed;
	bh=HwaJdDbl3ziEIlNq+4GJpu2/q8X3inKh6ZLd1kzHiJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKWS6jYlq2BY0rl76Frjan7mlg4f5Im+4CoeSkIc5ai9VkEOP0FXhPjCl+0p74ExfogdWD+Qa1DoUShU7nrCOQQ5A1wQxH2YrodbejHt7UCLbm3Wustwl0BC3zzu1UejhpQwxEFURtrwtGAc8NIoqyd8c1Nbh7AJ8u+c8zC12zvC/Tj0lAMgjtiKEaTagwiyUGH/mLDcYLbByMpO8sCxIfvftEJhC+edDbC/C5lZwcibdWoxVZ6BrY2iisN2Tv25Zv941nsb8h2bBiw53oijFcgCIsULUnFRP3wQa5sgy3TVDxDv5xcZNMTTQXuDyAH/65BpEcFEy/3+Rmkh8BSKoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dEbLri8V; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dEbLri8V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGNHc4yrWz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 01:08:44 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2eb18f4da15so2677125ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793369322; x=1793974122; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwaJdDbl3ziEIlNq+4GJpu2/q8X3inKh6ZLd1kzHiJY=;
        b=dEbLri8VlnpRZES/U7ZAmr78CwJV++s5oP0TyjNtunUkjuTcAmHLorYA3LGVH1/q69
         CY17LsdwAsfU7B87V5g3LlunckGBFUHZDKI/7wwfQRXZqrtIsmRh/d/n+BFrBLVc/9Ii
         Wx6q474twaftfJi/fO+UZnyP+oa0DnCzk2xdjLOI+FqYIrHcRWpWbbQ3tc1WV/WtH4eK
         deXnim6n3SJsP4L9iPizxWpzXFva9zngytXPXmILSfiQCDdrNdTAeANs62THBRPchWq5
         8PulYFzDAe/tXYl4PSXw5WemUa9sOlyOr7WZaSJukXlB4Np+hHiiAJzu7GtoErrudY4P
         7gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369322; x=1793974122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HwaJdDbl3ziEIlNq+4GJpu2/q8X3inKh6ZLd1kzHiJY=;
        b=c0Ne/WYUqGFaz+wIhWZMOyS4F56d665BiGgRYsw7Mh7uNJWa2SwbDOtkDeDcA3Ksxc
         AT5fZ1iHfZjoeb/0VV6/VAqXMWle+WBFS4dnMHBzn5c+ooPkjL5ly50505/yn3LE1XEq
         +mBY2HVbivxSugPJ0ZFPFTNsgnOAsSQ1PyLcps54IdA36bEBItwHbn59U3/zDrZnjSiO
         I4z3cMuSkUqQV2yAFPXf4B0puA7/jHUK+b29jBNMM1tdDS+RMQZnQQzfTDM/agGcRcVc
         l6H7FwZvvUY8ALBu1OTE9I+h8T8rkAReAQpTLvwY5M6+9NLmXfgCXIVrxNfrblv3xJw8
         GXAw==
X-Forwarded-Encrypted: i=1; AKwUvBya7f1sBoQHUagJB7Xc0RXA9vnm/AB/Sg9ap83oxFa5+nsl6814U4LsKMx8d2Eux1jfa7udKS2SL/plxh4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJmyLV4YahQDhXmoDeyRt+opxBxoEYJ2qCewEkDQurf3BJD6P/W
	tkd+LwfbVyHHlFQJDyfJClN4rg+Vj5HDtMgA2mcLJQIjlZ95AaWL+Mcz3Setq9GzfVc=
X-Gm-Gg: AYBFou3HCy8xU4MBM+RT4Jxi2k4uUpfgdGe/8I/ZkUtX3v/Gv3bWG/CgIhcPNg555zp
	3Wx+XPBzeVGSDZp2aG+I5mgn+8galJzFgxafUMjQZiWjiDhaRCE8qyRm83ubx/5hXNUVoZoNG/v
	kS0witcMhE7lkpZwAn+zROgze3aa8LZnl0sPdy5W1yAqitx/LkkaTjjwmQz/2gmWG3l1sNi9LlJ
	G4TdaByXkzOvGhIkZpAymQGKAEJKdsXqqIkWM0hi6c5T0z1YSB0INFeNx59GRw7b0Suf8AeJQNW
	6dXhvyA0f/pacKsbmwdmc2Kth1ldSbX7Q4A92CMrfEiRdt8XrvU56aPVdgeMCAbN7p22dQ26dfv
	LT4apRrOJcvZWstXGifCDe5hvwoDvc+Gr9izWY0/l9pjhUEJOsTlyVZFvuiL0WcGc/F52G7cvi5
	xqc08UCOPH1iR7w5k7JW8sMruFo63Bo4VK+ea1o/u/LC9VVaJEKjYwFofDVZdHBVsQDB2uBEU3m
	1WJUdFFG1CcpDnkRsXrNHdizNtaTDA8Bm/B8mdBuD1wPkW665HxRPY1493jHKqgNETz5hSSTnWc
	dMagwsUSqbVNvpSwCwoAE1m7z/VCHCsuuATC/+mVx73XO2H1UFov
X-Received: by 2002:a17:903:1a8b:b0:2e9:401f:f0f8 with SMTP id d9443c01a7336-2eb364e9f6amr24067465ad.53.1793369322301;
        Fri, 30 Oct 2026 07:08:42 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm7601795ad.62.2026.10.30.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:08:41 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/4] powerpc/mm: drop powerpc vmemmap_can_optimize()
Date: Fri, 30 Oct 2026 22:07:18 +0800
Message-ID: <20261030140720.1256062-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030140720.1256062-1-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC no longer needs an architecture-specific vmemmap_can_optimize()
override for DAX vmemmap optimization.

Whether the optimized mapping can be used is now decided in the
architecture-specific vmemmap_populate() path. When PowerPC has to fall
back, such as on Hash MMU, it can simply clear the section compound order
there and disable the optimization for that section.

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
index 2924604fbb38..63f369d296b4 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -978,16 +978,6 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
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
index 0e777d7dc332..509cc4190db7 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -282,6 +282,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		return radix__vmemmap_populate(start, end, node, altmap);
 #endif
 
+	section_set_compound_order(__pfn_to_section(page_to_pfn((struct page *)start)), 0);
 	return __vmemmap_populate(start, end, node, altmap);
 }
 
-- 
2.54.0


