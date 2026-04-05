Return-Path: <linuxppc-dev+bounces-19340-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2C1F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXTy1MVLz2yqF;
	Sun, 05 Apr 2026 22:54:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393670;
	cv=none; b=W3K/ZYxJNoL3HXX1a3BwNa328VeASUbJ4OXXno/a7o1Au0yK+d17XfhbEcqHuBj+Gl4s69dBLmyKk7My4yPHsij944azkFR6sf987uSjfu0QlBMjn0MUhSpPCyi3yA9NYC301bvqnzsZPvs7X9dQOoWFgl8TpD37/Q9qn2ptV9334K7W+x9UUuJT/Eo5hXUi0X2GmkHm/R0+66cHtc4ftICwNVOGuDzudkcNMNck0r31lExKS7mxRIXCEdpbvICmYojEvUioAIlEaOGOb1PrUU+8BuHQml/N/YxZSl7z8Piq0COvNQykxyrqaAvSQc/i9saRcnghSg/BdZHmC9sP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393670; c=relaxed/relaxed;
	bh=uQZVpg6xJPTStuz2eFGC89hf7AN4wP07MvFFryn7lXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RFVAsCPleIo5C3pMbcWLQlBT8mYalDZxgwIt6hq7pPjpV1t5rqu6vu6fClvl0j9NjRfqfLQoOtrZf/lREfXFeM+PO2UwY6f94ZPtmP7drDSlE67+QqKPUrTWFwquzwLF+CgBFcSr67nx4rP7uFrfIpn/lKN3tA0rlmb05zMicV8o4LyVOEE9dGpkPdbZSC6GNKNalbxOtdxq9dejtl+BJIWNscNIoeMi47qG9ekJ1zeFfPqgpXNksyd+0mWvvBOmHPvF8zcWQmqlE49kNQ8yhZc/W+unZ6muqUbzDXtTVoJUxUpXxOXWkH4T7R1p0uicU3L56meZtICdRF8gnDzRSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=b91g43zH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=b91g43zH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXTx3cMXz2ypw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:29 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1787299a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393667; x=1775998467; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQZVpg6xJPTStuz2eFGC89hf7AN4wP07MvFFryn7lXk=;
        b=b91g43zH3kc850iYqEJe6RIi85tr6LJghseLi7yBsqUy28joVDbLiDu4sEOHUEEtQx
         kGwgWgvRKKRzApyEhHK1KVM4KUtvjR/c7Lh21PySFT14URAUz3gacoDnosFege4yCAco
         02ktJctM7iALrdJtqeC7joKtycQPu1n20axKxpeW3FyY5dcLLBhyQx+LN1d6PwttvbSH
         SLgsPdYN47xIArqAwrLDQLOJUzpo7sgsjv2Iz0/vW9b3V2w3IiSCPTLtssQ9XzW+9Pcr
         Nt/Lp4OtkzEVgkM/R/SrkRpuvdNGWExW9vJFk+LFchBrCCBF3CRfhb+yIk7+U00DuYNT
         sr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393667; x=1775998467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQZVpg6xJPTStuz2eFGC89hf7AN4wP07MvFFryn7lXk=;
        b=iw0Vt3g8pZLRtWFwEXZlTLE/hO5DmM0jxfkUF/SlN+0qiqRjWmtVrb059QRTtIt6bq
         Y5loYgsO0cnSuTuTfXLBIqrfKucijBUq+0dyzboL7kBhh8rTGhN21UyPmijxv+jB6V8b
         KFEqzzdWYTW1BvDa8891dy1IjbA+QNLNoyM72wbMBuPxOb3AqYrh/RHgi0vBh6M5W1n7
         7NRF2+24cxC2uQ+MQCwl7KYUXqWTabRqKovRjbd/6fED1ASp3vkHzVWFFiK2eYkr37Ho
         pVzcP5HFOVsVrqy6PXpAuMpwdNqDz3yE6KO+ZUtEmlbX3/oIHN5rg4GTVinrWCdsPqoi
         lPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi5zNFccZx5eBATqhMMqRTyRSqpdS/Fw8eS9NJQApWHYwDs7JdGJwKvdKW3STAZuLxiuSvKGIhvdWTb/E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxrJxhlhvKa/MZVN3q0NN/pLzo2M1c322opj1mixsZzXIQFyf16
	dmdjCTKl15ggutTm0wS8IEF5/2ypIJii9btfTs+6FQzHLowkjhfRYdikLkDr5yNH+jM=
X-Gm-Gg: AeBDieuBfV1/4i8BKwM7p3/WF9wDteH8cKmxOf0jyCXgGUQ5AS2Mrl4omWRi2mu/eU5
	wZWBDP9MvtT1DkOFVZc36rGk1P5M/EIin71+Tz5jcU7aGuZglnpLg8IHq4vvyWg4m87skNuIKbt
	NrvNEbDLu0PsxYZkYcNBRJMlTVvuh9KdPsAHwrwlNRcGgw9+L2Hb1lQX99pZV9JhKsnIs6wIq6S
	xA/MUtE995oJ5iBlWlC4Ng3tL2mIv0RaTkZdjjXskLxaUXDqSnHMDpbVllXXozoMZ5gAoyQWdPm
	a9x4LD6fToOUmC7oSZm50xF/g1fpMWDBIjWzTmMRsRQfN3zPUIL0CoSfgOq9dyHGYe/3TQFPLXr
	XFz3M6gqnvyzSRPDejls30bF4J372KiY4Ip+Jidesu3n+3eMu39PC9xfcMDaD45MhHWtQJkqNTB
	4j586cbGpWKNb3IXqPc/8+rE+e5GLLl9VAaJ1mjISY5C8=
X-Received: by 2002:a17:90b:2b50:b0:35d:a6eb:197f with SMTP id 98e67ed59e1d1-35de660a696mr8364134a91.0.1775393667087;
        Sun, 05 Apr 2026 05:54:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:26 -0700 (PDT)
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
Subject: [PATCH 10/49] mm: move subsection_map_init() into sparse_init()
Date: Sun,  5 Apr 2026 20:52:01 +0800
Message-Id: <20260405125240.2558577-11-songmuchun@bytedance.com>
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

Move the initialization of the subsection map from free_area_init()
into sparse_init(). This encapsulates the logic within the sparse
memory initialization code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h       |  5 ++---
 mm/mm_init.c        | 10 ++--------
 mm/sparse-vmemmap.c | 11 ++++++++++-
 mm/sparse.c         |  1 +
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index edb1c04d0617..d70075d0e788 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1004,10 +1004,9 @@ static inline void sparse_init(void) {}
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
index a92c5053f63d..5ca4503e7622 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1857,18 +1857,12 @@ static void __init free_area_init(void)
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
index 0ee03db0b22f..b7201c235419 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -603,7 +603,7 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 	bitmap_set(map, idx, end - idx + 1);
 }
 
-void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages)
+static void __init sparse_init_subsection_map_range(unsigned long pfn, unsigned long nr_pages)
 {
 	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
 	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
@@ -626,6 +626,15 @@ void __init sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages
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
index 5c12b979a618..c7f91dc2e5b5 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -424,5 +424,6 @@ void __init sparse_init(void)
 	}
 	/* cover the last node */
 	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
+	sparse_init_subsection_map();
 	vmemmap_populate_print_last();
 }
-- 
2.20.1


