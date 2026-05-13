Return-Path: <linuxppc-dev+bounces-20872-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98871CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:10:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv1z1f28z2yT0;
	Wed, 13 May 2026 23:09:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677783;
	cv=none; b=elNDIJFggm8ei7CclFgd/Fuz/L9bILuLfkws2gXD/zg981LpC/g1t7YPJ/kx3RjbLpWhq5efNdF35gVoJK8p5kplbm0I4l1SQYIg6XvsxDsK20G752VokqoJLliUIIhLRDceL6j3rVfyLGkPJZ2dRS5j9Xh+1Jgz+wcAvdLazDQ3bEsT2VoRPr30/D2aXYn7DEJL2CbxpyuMQnr+zpNmVW4WMCc4E8ehHpwdIkmNePzo8MIomb7EmMMXA5B3CO6t1LH/7rw54KRSBIwjs6FMwgKRib7TP2GSvpXU/7Pr0jI7Ko1gA095Eg1XXPU8WS051V4GTXamrTnctztCDSfJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677783; c=relaxed/relaxed;
	bh=thKeB2NiafjiEdbVk8XkvNjvthrX3e0E5pBtn2l+Jas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrPW7WZT0rctBE1u5r8fXemXMkqX1gY/ejVb9NCVXMH+8knx9R055y5WXTGDX8cEXfYz5RevcUH1EzHE88BZP7EBZ8uYICCGHGvaBWtA5H6MXkGrqf+yhYcrYkq6vUMvvklxT8xjhu3lEJPPX0Z5CEkLaUr4n1uF1iVEyDJTMNcr5gzIgV5GKyM3WzVjPjmXLGyp2kg0aff3NWspmkGhGINQMKXK3Wv9XJTtnFBc+UyAualfpjZ2D4oi5fXU/oimJ/KTPnHnt+LE5c6Wfn5s+AxdtBI6FnGP0/OQuvQ+48dXePIOfU3j1lAm+LVo6R1yYo/kEnZc/3cH+oYZZfe/Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hN4p/4k2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hN4p/4k2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv1y470Wz2xpp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:42 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2b45cb89f7eso43095335ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677781; x=1779282581; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thKeB2NiafjiEdbVk8XkvNjvthrX3e0E5pBtn2l+Jas=;
        b=hN4p/4k2uNEBWjbpslWSICE7uch3NjcNWiZVWw8PI9HWbJ8iUw7kRgkAUBG7jTEgBm
         1xNM6GdcJAC8tNVtP8UbBLOl5RB/MwQQLEz7FnMry7Ie/Cdjp98UkLlgeYKpBy65EhPt
         Z30pZpT1FjFVgsuYcsWY2RKLmTQ2FjgRPXHz7m1nXqXlKD6LtOhZUmvaqgALVzRTjLjs
         N2JPBjMWvfsUTAliEYGHqhwrzRuOiMs3skXcxsZmnb5KabDwRpAU+QkBxvT8VzYqO1I+
         8/7rJK45A8FwUt+HoAuxSEAWKnT8uLxhkydZEfMadTJqbJnEdCAcY4RkmgjSEP2o8NDM
         JM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677781; x=1779282581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thKeB2NiafjiEdbVk8XkvNjvthrX3e0E5pBtn2l+Jas=;
        b=a2DVVULsUMAVpE/ykaIPKF4QT/mz8eETr52eOVvf53wupQ+JrgOVWKXi3d/7zW6GWY
         15t5y9HGz+2JqP3dlDZaJzgQd1cFAXtQkbEMp6U7sJoWf/0s1txMvr3CYZ9LHB9B5Avg
         wVYCpGN6IIbsg1wS+gAMYFLyzUSW5b0DpxCydfEaKkJXL0B0UqU9IfnzlchxAPTX3tma
         VuqSS9P93E/5TwxgH+8GD6VnxVDed/4MQaB0OTU8BjyiWXU722Nip6hHtaaNKU7v+Cr5
         T3J3y3GTT7HTGk2EExS++zW0b3PUgaxV+zY6Y/MIyvbhm3/qocMRn9EWtNrqDVqVhu0O
         fmHA==
X-Forwarded-Encrypted: i=1; AFNElJ8OZdtOy42QmHUd245z9efpO/O9USq7NYpgUS/c+FFIV2rBC8stgnwhbOh8hlgM2QsNawNiFkGfj+0WUyE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFMbQU0tlYr2BE8Ntx6YuOChSfEJ/OL7f0FqewEGXJM7PldJGN
	aIMXMoLl8NUcxJLF6Rxyj9+AExI0jv+2DlrkoPKwKnDBwDnkCGaGT9gBvn5VTsC+SRQ=
X-Gm-Gg: Acq92OEhmO0ImZEy7voA8agfwOFAkUR6zn4fQs6a7lRRmmc0OSeR11QKMD980yZbhz9
	Gx7FO7Fi/KfE8hKhScVy7JYpCRB55LHvtYYxX8yUzppMhSzjlrDZBYxeR1xLM7+gUXw9Ojuz8uc
	9iYghHsEKeXTHdfEA1damEYO3fylFE2cTXbyYTqJdCidve7Hx6JrlYA6aZbWgS7uiiTjuqbRP4N
	ukTc+6UYLb/TZfvhk5x2+wQrV78aVN1/Kvv0hB0gHYMuptwLrUUndc2DykR5NkBpbqUWaPwF/Y3
	qf/9mbsxKnc9YMcZCWqNQKNyQMatSGBmkNciApTkcQfkBWP8BpRVJpxfY7YkCgoeagPWwpFSO/M
	ipzppNJhgBC09KD/ro7fesubuTYX4QkLPfIRWmVIXNrbwvEJOsjtgk3uaahGl513M/No5Aa22aW
	tgJKIy3tSMH0mDRCixSoa4uChu12JXkHeU0XvkWeBxo3j3eBcCAQAZJo87MJw=
X-Received: by 2002:a17:903:2ace:b0:2bc:7486:21cf with SMTP id d9443c01a7336-2bd276e6d61mr36673085ad.36.1778677780397;
        Wed, 13 May 2026 06:09:40 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:40 -0700 (PDT)
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
Subject: [PATCH v2 23/69] mm/sparse-vmemmap: track compound page order in struct mem_section
Date: Wed, 13 May 2026 21:04:51 +0800
Message-ID: <20260513130542.35604-24-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

HugeTLB and DAX both rely on vmemmap optimization, but sparsemem does
not record what compound page order a section is populated with.

As a result, code that needs this information has to open-code
separate handling across users of vmemmap optimization.  It also
prevents other memory management code, such as struct page
initialization, from skipping initialization of shared vmemmap pages
when needed.

Track the compound page order in struct mem_section and provide small
helpers to access it.  A compound page larger than a section naturally
carries the same order across all covered sections.

This is a preparatory change for consolidating vmemmap optimization
handling and for letting later code make initialization decisions
based on the section's compound page order.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ae0271eaec05..6f112e6f42bb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2028,6 +2028,14 @@ struct mem_section {
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
@@ -2224,6 +2232,17 @@ static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long
 	*pfn = (*pfn & PAGE_SECTION_MASK) + (bit * PAGES_PER_SUBSECTION);
 	return true;
 }
+
+static inline void section_set_order(struct mem_section *section, unsigned int order)
+{
+	VM_WARN_ON(section->order && order && section->order != order);
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
@@ -2234,6 +2253,15 @@ static inline bool pfn_section_first_valid(struct mem_section *ms, unsigned long
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
2.54.0


