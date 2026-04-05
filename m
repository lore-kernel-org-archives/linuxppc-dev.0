Return-Path: <linuxppc-dev+bounces-19352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94474F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:55:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXWT1mC8z2yrm;
	Sun, 05 Apr 2026 22:55:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393749;
	cv=none; b=S4aXtQcxDIzBA89dCFwotGNtelLccnrGQpDo5/3zDfjFgdD6vj4XxZahR87Jx/f7+EjZU83rJR6ndqX4bXQxMm89RfOVOJA35o7GCshOIKJCQSMDJ9Fz/nTl6maEiAmofJ25O6868FovKJT/ZcYfkxt8gbaBe0wxumMrkxCUKKUtZnwK/E2yf61V2k6C8ByM89b9sSBx44XCaZ3vU0idU2XTYrOTu+nUwuEya3mGNPKwEv/RnmWGiU/h8NANUhTGHz+ZBSpHDiXebxtKnI8Zk7zo/lJms1GtOg2G9T+NsWjXNpO6l8u0080KUjocUElmQ581GZ9j+g3Z3wEIRMtsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393749; c=relaxed/relaxed;
	bh=sb6cTU6E76tVxQHa/I/Ro9Ws0lLMXSEWXuSGv9owj/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmLrlL5S0IzZJFjoxWrO4IkNDL1mXY01ZN+zx/uh0AQxeq+VvnQZHrM1tZdT1de6ZFdM7EUx189CQb2jVhGhnXDyhg6onfj9G0y7UFecRCn1KTR4Q+zJs3yfqeAAamaOmRfbyuAVoCvaPRYTa2bYL/8C8bE1QWybC7/kFPTRPlsF+fVClL0MQMByrlVbnTtfAtIJ+23MSEw7Zu2BeNYVX4EnEQhJ7Zu98/k3m9pwonsFr7m0em1Fsxb0jpVXADH6tUrVz5bVxEFRjyyOwpE/N6hk5aDLV5NxPbTZ2rJBNPQ26/MNqGy3PGl6HOAsmOxl9XmsGGTxVpZAqu1Bt4welg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=G1kwqW+l; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=G1kwqW+l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXWS4Wmfz2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:55:48 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-356337f058aso1639117a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393746; x=1775998546; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb6cTU6E76tVxQHa/I/Ro9Ws0lLMXSEWXuSGv9owj/A=;
        b=G1kwqW+lvn43MrVM6h7cGLAt3088LJ45Xvu+LAbfxWRlT93P6azz6gBasVMqT5wigL
         HhhKX1m1oHwJOCxzALu/50pVJtW7foxBc+HBLciLLdyFFkVV62WB4NpSwrYMgdEQAhUi
         pTYDKRn+U8LWpjpntKUd0DH9/81/LJhI9NIcX1z/heVke9QTPJ8kl4dBjMsWZjzKajOE
         zosXW0a0DaCcJfopHTXDvQlb2Ef8CiWU+68OAyV82Go8gqti6BkLcTn5utTgB4VJ5EIW
         dwawVecgPYn/INK5ko9wNAVF7cHOtfloRyOx+jvSyKjyCRFRlo6ZDGYaUCZWyABdJeZW
         //iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393746; x=1775998546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sb6cTU6E76tVxQHa/I/Ro9Ws0lLMXSEWXuSGv9owj/A=;
        b=dlyTOiISZpbCASRoFxyGLjDJOY8UO4KgOkKd0pPSfyHJSOTvH4NGpvumVJrcreu5mj
         7crP3yD5mxUmten20Q3osAyDAKFP0RZUe987RE9idC3if3Ty3ZfC2x7xvU582/A8z1zy
         q5TXLY0DiKfRZ6YSNXLSDG0EJQrUNJe5s5Nt28d2KjxdkhAfn+4xL0KVodW1mZ/hr/5/
         oupacoj5M3g6MFmXpLLvdPpm7a8QWTGbTG5Smhfdi9sU0mtetW7J2wJrz6fWuZQY7ELM
         YXqHqXOMm1K0mnVutMl7zgSRVIuKjlTqAOxBQgFKCFZbx9SyqDToAYdx9olK7UpNKgvs
         M+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaCjf1qX3etPur9wqOeqqzTmRkJfeRv0TAMyRDy2newcCGmTzpu6tE4WpoCjPMPOCuWAKYakW5k6pwpLA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjCNxZN2uYGkZqCfIkZwRhkicJbY/amKW82EUzV7537dPC7sjX
	fGFVob1QClwl6y+V2dZmGdvvxcOTlv4PzGOBGHgTICyaFxmF6iS3uNcNyJYJcr9Syd8=
X-Gm-Gg: AeBDietqmOmeEQW/Ajm9Nov8wwpoJyo6dKO/P5O4jq+mPK1Uu9H3jItrt8QNARtIYiH
	/PrMkc+Ld0Zzw4EUgAXp5pQZaYLwfP/7F1dOaYtRZp66R/KwX4O9mVOTp/PiBJNbeQV5CqSDVoE
	WXp0h5BHqtFQJRDAQC4/cZU8oVgkiR0sYa8j0Q2S1rnrkB1uhCBrpj9/wOl1NI+y0jzz/DOF4mJ
	9bS0vrqNSsGeTsGlUQfIv/nFHzq3BGmtugpM58B/xTUtrfeXs4zb5fPmpWjt0YT8CwWn/7AGn+p
	JYO+dGImrTwK08ypG8W+9A0A3anSM/r67zqt1SHk8HxnK6lbHyT8q1F57J1FXK93G4XzD5kFLkp
	jVyqxuyCvr2Ym3TVKhag4x/inVaU9UQgcXnAPnY+TWTpOgsjAgRZsV6mfcV/7lY1k+NyWU5G2/0
	odh3RBLqvX0WtW+LwmeLCfQBcz9e4fFMryia7S3sUdzLs=
X-Received: by 2002:a17:90b:2ccc:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-35de67dc7d4mr8298573a91.7.1775393746346;
        Sun, 05 Apr 2026 05:55:46 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:55:46 -0700 (PDT)
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
Subject: [PATCH 22/49] mm/sparse: introduce compound page order to mem_section
Date: Sun,  5 Apr 2026 20:52:13 +0800
Message-Id: <20260405125240.2558577-23-songmuchun@bytedance.com>
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

During early system boot and DAX device initialization, the establishment
of vmemmap page mappings via __populate_section_memmap() is done on a
per-section basis, followed by the initialization of the struct page area.

Currently, there are two scenarios utilizing HugeTLB Vmemmap Optimization
(HVO): HugeTLB and DAX.

For HugeTLB, the SPARSEMEM_VMEMMAP_PREINIT mechanism is used to apply HVO
(with Read-Write mappings), and later, vmemmap_wrprotect_hvo() is used to
enforce Read-Only mappings. HugeTLB has to manage its own related statistics
and metadata updates; the work done by hugetlb_vmemmap_init_early() is
somewhat similar to what sparse_init_nid() does. Furthermore, the shared
vmemmap tail pages allocated by vmemmap_get_tail() are left uninitialized
because they would be overwritten by the subsequent memmap_init(). We are
forced to compensate for this in hugetlb_vmemmap_init(). This limitation
also forces us to maintain two separate implementations of vmemmap_get_tail()
(one in hugetlb_vmemmap.c and another in sparse-vmemmap.c).

For DAX, HVO is already applied via __populate_section_memmap(), but it
does not employ Read-Only mappings, which introduces potential security
risks. Moreover, the fact that HugeTLB and DAX implement different logics
for what is essentially the same purpose increases code complexity and
maintenance burden.

The root cause of these issues is that a memory section is completely unaware
of the concept of compound pages. It cannot properly handle HVO or struct
page initialization for them.

To solve this, introduce the concept of compound page order to the memory
section (`struct mem_section`). Typically, a section holds compound pages
of a specific order, and a larger compound page will span multiple sections.
In the future, this order information can be utilized to unify and streamline
the aforementioned scenarios.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3e3755666846..620503aa29ba 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2014,6 +2014,14 @@ struct mem_section {
 	 */
 	struct page_ext *page_ext;
 #endif
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	/*
+	 * The order of compound pages in this section. Typically, the section
+	 * holds compound pages of this order; a larger compound page will span
+	 * multiple sections.
+	 */
+	unsigned int order;
+#endif
 };
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
@@ -2210,6 +2218,17 @@ static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long
 	*pfn = (*pfn & PAGE_SECTION_MASK) + (bit * PAGES_PER_SUBSECTION);
 	return true;
 }
+
+static inline void section_set_order(struct mem_section *section, unsigned int order)
+{
+	VM_BUG_ON(section->order && order && section->order != order);
+	section->order = order;
+}
+
+static inline unsigned int section_order(const struct mem_section *section)
+{
+	return section->order;
+}
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
@@ -2220,6 +2239,15 @@ static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long
 {
 	return true;
 }
+
+static inline void section_set_order(struct mem_section *section, unsigned int order)
+{
+}
+
+static inline unsigned int section_order(const struct mem_section *section)
+{
+	return 0;
+}
 #endif
 
 void sparse_init_early_section(int nid, struct page *map, unsigned long pnum,
-- 
2.20.1


