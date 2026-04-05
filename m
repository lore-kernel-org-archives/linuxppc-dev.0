Return-Path: <linuxppc-dev+bounces-19351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6D7F3D5E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXWL1krbz2yrt;
	Sun, 05 Apr 2026 22:55:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393742;
	cv=none; b=YM1rTY6XsmU07HsxHZ5FRAT1hd/bmo0YItWwtjbSOzCEhZdwN7PSME5VE4zyH7vrwQfuWZN14z/MRQOLGWRnh5LJCC+X5tDodvlfyoCEIXx1k6WGwe/FSwSXPGgQuKoj8tXnH0OwjMRKGJ9919gP1q7Nf6yDpoL4SDDCAzjJHUACXCV/EkqrPiDfV+iPRlNFVsuu5pykxvWkk1W6k/8VULuNhlFP1gqbVVT0sS2Rc4J83f4KrXx6IWJ3jdGY39vVOMSRt5pwBaDUcuR2TmSAc+rvc6FcAkjg4J6RplrgTfgDlkQvjKIxIdNn/Lvxq65/xEiLLIh4amWT/LdgpkZhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393742; c=relaxed/relaxed;
	bh=RosLEkDdV2Cdz9XETYo2dsVY+zgApycOz9SAkpm7hvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGLp9KjAhmRxkpaxDG3u4NZC6U7ZBEBoZUqpO6atzQ+RycsCcbXd+yKAVJHUcWvKWDBQlZkSFeZsve4F/Jpb66B4Cm6aMd2EC2G82BaZI2D0J7v9zpdzQ6xv7/aeZkmM8s6Bw4cjucy8LOh28y3EplcZPz7SsAbaMQuJlEfM5EnbD+iok8XTbuOT7JW3CvwYpMmgUuhU5TChhnyUhueXylZluF2ZMes4TrjdIei3UnlWuCNiSBIDseufTkIoe+bXWUrDfP0Rxz/6fbkQAI+3+ooLHeWnaXvJ3eUWqg1BBDNw0pfmY4oWi0ZOaPQhD7gjmGD21/N3zmkT++Li9nW4Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lw74I0n3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lw74I0n3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXWK39H7z2yrm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:41 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so2875527a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393740; x=1775998540; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RosLEkDdV2Cdz9XETYo2dsVY+zgApycOz9SAkpm7hvM=;
        b=lw74I0n3sCba4dEhyonu9CpxlsEXfICCNlth/gRZakCpTpgMPRASgU7QQWFFqSUQ2p
         42obKFu80a/cBJ+iG0HS5GmKLJEfk1E80ImrZhICQePtVKTlAZOQP8P9n8z0XBXoFReQ
         Sl1SLVnRMF7IvQBLfhzsS6rAq4uiBIGmH6xpXlSjqSYQp7qy+oyzEhMIf11fQ3E/1Z6I
         2m048deYzq5zzv+SAYHvdBjQm5m9F8AuWBjeZfpQKq3XD14nakqBv5TcEHYK0TGyXDw8
         QUV9l2NglvUseX6azVxasd4SCu9gqpRKQESKTIHzDhIuzbI7NpFFiU5kV6GtR6KTFucs
         3wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393740; x=1775998540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RosLEkDdV2Cdz9XETYo2dsVY+zgApycOz9SAkpm7hvM=;
        b=aWlerXRo9ghV0BIu8CiPS03xMJhnNdHqrj/FpbuDvl0a6QGSQE6dlbVAbAn3IYP+hG
         MpmRHwe8tumRLIcQOOxAhHAvKKTRqNn4LTMERalK3/EWZj55Z0rtgPM2067TsLb+dwes
         Q9kpwZr76lFroq3ZVkqwPXc1naVjssHoccPbnA6SwkV4HR4eAtdQCdAtuk8EEeVtnsjf
         lquWYjenc0HRoaQb79tpBBdsUa1k/vGRA+D6vbkmEWDCdDiiQva/vfrqSqEcgC5MIML3
         PxLUYAKI9/jrccaoBXNX5zcAagKMwYoOAbV9sKeTxWNSvrfAJvgvIKJr96rMYIlgr1T3
         KKBg==
X-Forwarded-Encrypted: i=1; AJvYcCWPuF9m+3BXUs2TqHFq3MpBE5V3fpp3nOwfTD1dCZUhcexGMMKA98wYMwlnYzfxYT9uyADBFuCAPedPrSk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxF8qBEBUx2JlfkcXUbBNqCjF4w8hSHkBmIXio0SQbuk7nS2j6C
	t9/PccFb4KJLxUi+aVt3HK2G7S6n2+cpoPA4qZB2XA0RXP/P4QPLiLzZFcCQ0eAtOAM=
X-Gm-Gg: AeBDievbH6NA0cGlTHzKerj18KdGlxTy18wYfPKr+FcismeCaugGYhW9qaGDdO+E7Fw
	wEdhEHXhZqcNvtdJCj5gjFSprJI9wUzcL3wqVa52ppB8tBAp3D9ThdI0DMma5sdSgkBoWYzbi69
	61m+7C0J/u55gs2Io+8iotxp6nUQk/HT9XhMygB0g4xD7zwHik9rrnWQDeypBOO0nUGKvMOjjWq
	9JeehaLkLFVpEQJF6KpE7xth8fYuZUC1env9atxBOGkuXq1kmAOVCBC+u1wRrS1DJXWAZNEdaLr
	VnNs3ntu8N/fvB806LQOHh+z9jshexwb8qJ9nb5zupUHxUicqfbgrG5oyachdvEsgfobnw1Z4fo
	PBdofoECP1hSHiUpBc1ONM9wMjKgi/lgZVG+RveBeFWx1u5SpRYgANj9c/CrFKPVfauFYpYCLAL
	v+aN7SspacPI7nNUNbJqRTaOPfaRybOKLDVTlGwh0HxYo=
X-Received: by 2002:a17:90b:554e:b0:35d:aeb2:25b2 with SMTP id 98e67ed59e1d1-35de69780b4mr8868406a91.27.1775393739584;
        Sun, 05 Apr 2026 05:55:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:39 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 21/49] mm/sparse: drop power-of-2 size requirement for struct mem_section
Date: Sun,  5 Apr 2026 20:52:12 +0800
Message-Id: <20260405125240.2558577-22-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

Since sparsemem-extreme was introduced, struct mem_section has been
forced to a power-of-2 size so that the section-to-root lookup could
use a cheap bit-mask instead of an expensive divide:

    section = &mem_section[root][nr & SECTION_ROOT_MASK];

This is enforced at compile time with

    BUILD_BUG_ON(!is_power_of_2(sizeof(struct mem_section)));

and forces us to add padding that grows and shrinks with every config
combination, wasting memory just to keep the structure aligned to the
next power of two.  With CONFIG_PAGE_EXTENSION enabled the padding
alone can reach 42 struct mem_section instances per section-root page.

Drop the requirement and switch to a plain modulo:

    section = &mem_section[root][nr % SECTIONS_PER_ROOT];

Modern compilers turn the divide into a multiply-by-reciprocal approach,
so the runtime impact is negligible.  In return we get:

1. Immediate memory savings when CONFIG_PAGE_EXTENSION is enabled.
2. Freedom to extend struct mem_section in the future without having
   to fiddle with artificial padding or the power-of-2 rule.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h  | 8 +-------
 mm/sparse.c             | 2 --
 scripts/gdb/linux/mm.py | 6 ++----
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 378feaf4e4ed..3e3755666846 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2013,12 +2013,7 @@ struct mem_section {
 	 * section. (see page_ext.h about this.)
 	 */
 	struct page_ext *page_ext;
-	unsigned long pad;
 #endif
-	/*
-	 * WARNING: mem_section must be a power-of-2 in size for the
-	 * calculation and use of SECTION_ROOT_MASK to make sense.
-	 */
 };
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
@@ -2029,7 +2024,6 @@ struct mem_section {
 
 #define SECTION_NR_TO_ROOT(sec)	((sec) / SECTIONS_PER_ROOT)
 #define NR_SECTION_ROOTS	DIV_ROUND_UP(NR_MEM_SECTIONS, SECTIONS_PER_ROOT)
-#define SECTION_ROOT_MASK	(SECTIONS_PER_ROOT - 1)
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
 extern struct mem_section **mem_section;
@@ -2053,7 +2047,7 @@ static inline struct mem_section *__nr_to_section(unsigned long nr)
 	if (!mem_section || !mem_section[root])
 		return NULL;
 #endif
-	return &mem_section[root][nr & SECTION_ROOT_MASK];
+	return &mem_section[root][nr % SECTIONS_PER_ROOT];
 }
 extern size_t mem_section_usage_size(void);
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 5fe0a7e66775..cfe4ffd89baf 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -394,8 +394,6 @@ void __init sparse_init(void)
 	unsigned long pnum_end, pnum_begin, map_count = 1;
 	int nid_begin;
 
-	/* see include/linux/mmzone.h 'struct mem_section' definition */
-	BUILD_BUG_ON(!is_power_of_2(sizeof(struct mem_section)));
 	memblocks_present();
 
 	if (compound_info_has_mask()) {
diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index d78908f6664d..0c9eeed92064 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -70,7 +70,6 @@ class x86_page_ops():
             self.SECTIONS_PER_ROOT = 1
 
         self.NR_SECTION_ROOTS = DIV_ROUND_UP(self.NR_MEM_SECTIONS, self.SECTIONS_PER_ROOT)
-        self.SECTION_ROOT_MASK = self.SECTIONS_PER_ROOT - 1
 
         try:
             self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
@@ -100,7 +99,7 @@ class x86_page_ops():
     def __nr_to_section(self, nr):
         root = self.SECTION_NR_TO_ROOT(nr)
         mem_section = gdb.parse_and_eval("mem_section")
-        return mem_section[root][nr & self.SECTION_ROOT_MASK]
+        return mem_section[root][nr % self.SECTIONS_PER_ROOT]
 
     def pfn_to_section_nr(self, pfn):
         return pfn >> self.PFN_SECTION_SHIFT
@@ -249,7 +248,6 @@ class aarch64_page_ops():
             self.SECTIONS_PER_ROOT = 1
 
         self.NR_SECTION_ROOTS = DIV_ROUND_UP(self.NR_MEM_SECTIONS, self.SECTIONS_PER_ROOT)
-        self.SECTION_ROOT_MASK = self.SECTIONS_PER_ROOT - 1
         self.SUBSECTION_SHIFT = 21
         self.SEBSECTION_SIZE = 1 << self.SUBSECTION_SHIFT
         self.PFN_SUBSECTION_SHIFT = self.SUBSECTION_SHIFT - self.PAGE_SHIFT
@@ -304,7 +302,7 @@ class aarch64_page_ops():
     def __nr_to_section(self, nr):
         root = self.SECTION_NR_TO_ROOT(nr)
         mem_section = gdb.parse_and_eval("mem_section")
-        return mem_section[root][nr & self.SECTION_ROOT_MASK]
+        return mem_section[root][nr % self.SECTIONS_PER_ROOT]
 
     def pfn_to_section_nr(self, pfn):
         return pfn >> self.PFN_SECTION_SHIFT
-- 
2.20.1


