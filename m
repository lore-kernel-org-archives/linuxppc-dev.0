Return-Path: <linuxppc-dev+bounces-21882-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F637CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV6763JRwz3bxR;
	Tue, 02 Jun 2026 20:11:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395090;
	cv=none; b=eRT+ghInIkTrmlyWqX8hCHZDgDPF11EakKBsisnHPSuumxFfjG7t/o8nZrbgpiLxW3+CT40mocvASU9jExAll+D7TCZCQoLyPProRLuQ14S53+OVrYsh3cx3LPZzc4Uuqn5xX8yiyfpuDkuewwCXUwRoei9F5hrDRDkFp0nRu4kj+N1oNBLjbQxUS0P7qK2jSYftF8uh02237WVF3Gh8Yvm3jUI1tln8C9rfGs5slRWPwQ6C2Xcw0sskR0L6RQslylJxKVb7PnIpS15r69wYyZ4bSarBvM9x4V0pJgddviKpaBXvROQyQ/WGpvPQEOZ6m2m2+ul4XLKvBD+WKPn+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395090; c=relaxed/relaxed;
	bh=DnGxO1Udfe58Wuis4xgFsB98Q+Og1N+BThJGTGl24kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsYAfNxwdW8+lMmi/kKG+StgJbYz7w8TrzWJo+NsYM9MaG9uLljyS4SyKgIv9r8/AsGh5novoi3xd1qt5TiyQwM1zbFw6Kfg37GCscEUK+Cq3hvl0RdjcZ5qzN5610KGKKKwV4g2ET1i549bbM9XOiMLi+ZE6BMX9N3eVBe4PMRYK0AI7UKj1sIY5WWJ1QioVJPw5J+5PQBLGu6n5HbNqPlFr1rUIw/uVGrsZY6jlSrLEwVGbkXbO4mVYZf9dbxeGHYQVN9ObAh50t4aE2wsGR47UmxFuSD3SJlZTstvOQneYJSzYWn3X5CwmPkX1huzDqfR7cI8AFoWUQhELXZIWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=iirxH8LM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=iirxH8LM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV6755sJMz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:29 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-8422871b42dso1600639b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395088; x=1780999888; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnGxO1Udfe58Wuis4xgFsB98Q+Og1N+BThJGTGl24kM=;
        b=iirxH8LMXntbcNPtZnDn0d/xaBpoMosYGNGUe6A0xao92Rn5PtuT6BY/EEvGvJqTEI
         Xgj/u00VMK+wavWBsyOcDom2Y420nHA0litpGldj85CLpxqqnMolVo3GStLv/GY25k9P
         yMqa7lIMW+E7R9q72aNTsQh13KIv5r9lUo0d85eIzsloLVdJaRaROBmDxS/mgioW+XX8
         eL2sY9No2ZJmso4Qk2ZpQ71idHNdSWw0ayHTIlShLuE3yKChkfkxStZjrvA/aAODquDf
         HF8qpt3wtbM5tsuBYXeK9JaEJ0CJGtZr2scBJOgcneiQkbtMApwrZRqOcm4qHRzrdpPx
         AjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395088; x=1780999888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnGxO1Udfe58Wuis4xgFsB98Q+Og1N+BThJGTGl24kM=;
        b=JI7YjR7KO0ppNkVuWLXIW1o32dAV1rPXvluAgr0zLaxrz8H31EVJxM03imEQ+/09TS
         XXvpmlSgzyQSldy1mgTXKxzX4UwguAprU0tDH+fX/VTqz+bpMVegsBBGS12BjJelycAB
         OT/XQB0h2TXjXC4CpYSNr23F2VmH2Kienw0VSBo/9V1XGdVaGWZfOqXppvjB3SxAUYSO
         iEm5KColWyh3JY1WRLCotwzAEuDH+KVeorHEtM9hXbYfHHK8dEP7tN6ZrYeGzZ/UdFKn
         LzDcmITFjvetGYIm8TT4umQP6XYAke33oBE4yDe3pNCrZveUxxOTCFuB+UDJtaOpzPw3
         EHlw==
X-Forwarded-Encrypted: i=1; AFNElJ+6WH2gUVnsv1EkylqnnIfTofPvHIykOUCpO7R9rz6ZJcsaRacXGXjfUT2wpyy+E+uit7waLRqEA/2IwkY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWjdGV3RIKDKwm7WzGkR4WhOQUIb17FCNzYOKk7rJv+IdXjXq8
	IncGphbnmUE+3Zp06NDTkA+oCSvWzc5gvbHY8535b/UcnmfOC6iv2/kGoEZ0qTN6TzY=
X-Gm-Gg: Acq92OFuVnudUGuOlY0g2DzUubrlrv7PKvpW1mMinbYAFA7PoXQJpJvNJpaUe0jOCjQ
	t9gs4hTNZQJRTdOMJi9YBWc09CQLAId5RckT+bmm9BIBqea69iFZOr3bqQJMo+3dd+RJOsyQFMY
	2gFShMIQzBVbUTxEnFphgKjybWvaXC5K90Q642PDbqy8yLqRWchZinX1JNLBbwMuTQFArvUbz8F
	Ik192Xl2Gjj0NL1WhfE08Y+fH2w/G0HOWG+8kGXXiEsy6NX3ZtvmbNMhdytd8/ClPFuSs8k2/Ir
	58PJYmV0q2sJqDz+x3SRgS5kcPlDfNn8JvCFPTQ9I9ISvqpU7EH4Nr2Aa1ujhCg4h/o+P4toDE7
	S9/UW96JHPyoNVt0aeEJtAtAsbYgbLUcaJwJ6XB65++qySePwJGkiIajZ+1uNVQtuxACBj9DF0h
	I+A1Qr3H8rOyNHVBU9qDRwC3W+ll5EnsIGvZZqYtZIbyjm/JanYMJfryFScOruJLd3cQ==
X-Received: by 2002:a05:6a00:348c:b0:842:5c60:513 with SMTP id d2e1a72fcca58-8425c600b94mr6788288b3a.30.1780395087753;
        Tue, 02 Jun 2026 03:11:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:27 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 07/19] mm/sparse: Move subsection_map_init() into sparse_init()
Date: Tue,  2 Jun 2026 18:10:27 +0800
Message-ID: <20260602101039.1867613-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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

subsection_map_init() is part of sparse memory initialization, but it is
currently called from free_area_init().

Move it into sparse_init() so the sparse-specific setup stays together
instead of being split across the generic free_area_init() path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v2->v3:
- collect Acked-by from Oscar Salvador
---
 mm/internal.h       |  5 ++---
 mm/mm_init.c        | 10 ++--------
 mm/sparse-vmemmap.c | 11 ++++++++++-
 mm/sparse.c         |  1 +
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5602393054f3..e71ba519f7f2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -994,10 +994,9 @@ static inline void sparse_init(void) {}
  * mm/sparse-vmemmap.c
  */
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-void sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages);
+void sparse_init_subsection_map(void);
 #else
-static inline void sparse_init_subsection_map(unsigned long pfn,
-		unsigned long nr_pages)
+static inline void sparse_init_subsection_map(void)
 {
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index be652b6990a2..3a57bf5a9b46 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1879,18 +1879,12 @@ static void __init free_area_init(void)
 			       (u64)zone_movable_pfn[i] << PAGE_SHIFT);
 	}
 
-	/*
-	 * Print out the early node map, and initialize the
-	 * subsection-map relative to active online memory ranges to
-	 * enable future "sub-section" extensions of the memory map.
-	 */
+	/* Print out the early node map. */
 	pr_info("Early memory node ranges\n");
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)
 		pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
 			(u64)start_pfn << PAGE_SHIFT,
 			((u64)end_pfn << PAGE_SHIFT) - 1);
-		sparse_init_subsection_map(start_pfn, end_pfn - start_pfn);
-	}
 
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index db9cfe57e827..3b036251a2f4 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -596,7 +596,7 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 	bitmap_set(map, idx, end - idx + 1);
 }
 
-void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages)
+static void __init sparse_init_subsection_map_range(unsigned long pfn, unsigned long nr_pages)
 {
 	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
 	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
@@ -619,6 +619,15 @@ void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages
 	}
 }
 
+void __init sparse_init_subsection_map(void)
+{
+	int i, nid;
+	unsigned long start, end;
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
+		sparse_init_subsection_map_range(start, end - start);
+}
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 
 /* Mark all memory sections within the pfn range as online */
diff --git a/mm/sparse.c b/mm/sparse.c
index c92bbc3f3aa3..85557ef387c7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -361,5 +361,6 @@ void __init sparse_init(void)
 	}
 	/* cover the last node */
 	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
+	sparse_init_subsection_map();
 	vmemmap_populate_print_last();
 }
-- 
2.54.0


