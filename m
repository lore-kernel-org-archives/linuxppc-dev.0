Return-Path: <linuxppc-dev+bounces-21885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EDACD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:12:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV67R2j9Mz3bpM;
	Tue, 02 Jun 2026 20:11:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395107;
	cv=none; b=n6vRe7FONrJjdZ+CN9n4SvFa6JFgkvh8Z8yvJdugLC3MF18e+ZnHHJXskEzMG9FuhoNrzKB/f9JYyfMIPIbfpU+D1zMwTynlHAoe1KvOx8hEoTEpRXZ11UH2dTVhL0Jb1T3+/DfrJKjA/IxrgxDWRIExJNyt5X3tXtdkoOSRTbToT1NMIF6tPbqdoIUshDkdcUcmgIpm1e/Ootn/YAYnbU1xbyx1O8C1Pg3C9S3T5Imtq3A7tLt1sCXfYHZuL4DhW+ZX/vXvOn5eJSzFQ14nz6SKXI4bKz2F6K7jrYaFAqSEvHcguB+aGrq64I0lvDQTb6/fJq5gI84lwXc7Is6WfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395107; c=relaxed/relaxed;
	bh=lRWl52YiNF8NqlpcvOldJSrMkxHitZpwQxluu3UebDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ2xnPRSrACGDV+WiOQZjzDiG5bgvCfV53HHnGhX0vrJUOIDVugO0yI0tpCidQQnVtWeGIYsY2zwiXAQrey7iE1XGABG0ikPVFl67YAw8zOykiqz6A3RZlgeVU2jwGWzjUxEC0VOTNIoMt+eTWiSXxpmcMU8LnCdcK+cODM9D1tN0Zf5KKfiKy6CGrbOBQ4tGa2uUmYFHxIQRFYQpbmHfoTNvUFCR6ZoS2qAsMYHyOfrAvWsc6VnbJEpDK5qUKrNc5Wq+1QCc5wAtNcDHKoHZ7E9Z9fdTCr/2DKXbbMJSiyODh9QeA8BKTeiQGyiX59XYygH811JoMghdtcORjYLzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NqeCYSC1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=NqeCYSC1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV67Q5S03z2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:46 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8423f236418so1016658b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395105; x=1780999905; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRWl52YiNF8NqlpcvOldJSrMkxHitZpwQxluu3UebDE=;
        b=NqeCYSC16lZeYw1E98Kg+TLRFoBYwH0tCyjYqw/jt+h8f2WH5NP3wAFkruuFu9+yjP
         uOV8suRKBExFzQPzPgmDF2ZNdQndOL0+ZEkai5VNX7nwrLt7UHjNM7BiYhh797untbBm
         bp3CEY2ipCR9ce3sbCSCpb1GFIg+keW6wNsp/LMZakLyusbJ74tg/A2Q/J9EnH43UyDs
         TsVRMn3zRedYjBk8/q80/QBS+KdVoyUJ3z/x2LCUDnqKQ0b8wGNwQeNLaqcNCKdz2mNS
         xleNco4LK7kd/eI1XsMHQvbS+z0VE8WkdhhWqkdg7IAnDFvCw8EYjzJChYa2+pyZtqke
         GOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395105; x=1780999905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lRWl52YiNF8NqlpcvOldJSrMkxHitZpwQxluu3UebDE=;
        b=fbk9XwnnyyX3ibKlUXowDiHPdbbzaRlp9Vz48dVnlTw2XGscDoWOtbYtORSo/AEWJS
         M2yHVVLscTWCxs8YFj8YdC0LvaAMh3dZAA7UvCbwIK7P7jZImtn9wrP3LRJmDKMtp1dg
         FzwVc+j+Ziz2Tb9f7vkqFqYGZ75v33uB05cwC5v9MdEZW7KNcW7mVmJkQanOrw/NzNEJ
         f4Ze0Y0GHfJnnWFazQBivhfAz3J+itu7s5IYq5xa+k8qGeEGeR4savDuuE6Teq4KdvzH
         AuHc0SnGsX3ApsAhJuLwiSmUUvdSfS+Hj1WIpgdHX9dsymRY8qJH/MW/kYCmIZy2Ov2U
         encA==
X-Forwarded-Encrypted: i=1; AFNElJ+GGYSPciPshleMTnw4M3YyUKnvJfWhIqsS+6RtcO8gSJQJlr2hQwH9EioiBAYwtN5rqeT1NTifFzL4iIw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6QwJ6fc4Da+EFFDwq45FH++1EKkzMy/KbGz/3gNM3zgWZmH5b
	ogQMaD/sjFaWTmTuU6ipM5jO3syS3E+hhxKqkulsEh8IIQDawFwIRYMNZxWmh9ldM9w=
X-Gm-Gg: Acq92OGiU2/W89UjiqnZSGFDpY6QdDjBrG/eFzFkTSFtzidJpEmAruBy/LErHEb9aq+
	s8D+0t7BIqTS42Ri4CjzNeZIK41E+MfGyogxN+swH2Rtb0De97/SA16LdZ4OnO74XOYKXRbz6En
	YrCxvI/e0D0bPVpvW5D+xr/b+HKPW50K08LJEQBScU4jrO5S7ceGxkCLjL2pLQZlGgsC/f09Tig
	AAHkcj+nYr75cH+Xit4/8nvnswp3q1T/ReX0GScVzvDyPFX6pkQWK2PeDASWiPJVVi99PPb76+C
	RpmLMPxn9RHo2A6YwmSZH15cGjcdgPAZToii00AIWlOGUuZ/oaAOgNT0q9QEDAhBQ29jS7MtJzM
	swUwAwawmrElC/g0lIBQUB6ORDMPfp7HHzJfz6gVI/j1Grx1rIeA08cZjs6meghx2QE/mqYmZTz
	nCtV+wwAImMO1+WesK2Zq4qfJjTWyQMZW986phgdZaWRSseihR8QPBGEkhx1hKjmUyrw==
X-Received: by 2002:a05:6a00:22ca:b0:842:4469:9202 with SMTP id d2e1a72fcca58-84244699f1bmr9235454b3a.12.1780395104666;
        Tue, 02 Jun 2026 03:11:44 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:44 -0700 (PDT)
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
Subject: [PATCH v3 10/19] mm/mm_init: Remove set_pageblock_order() call from sparse_init()
Date: Tue,  2 Jun 2026 18:10:30 +0800
Message-ID: <20260602101039.1867613-11-songmuchun@bytedance.com>
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

free_area_init() already sets pageblock_order before sparse_init() runs
for CONFIG_HUGETLB_PAGE_SIZE_VARIABLE, so sparse_init() does not need to
call set_pageblock_order() again.

With that call removed, set_pageblock_order() is only used in mm/mm_init.c.
Make it static.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@suse.de>
---
v2->v3:
- collect Reviewed-by from Oscar Salvador
---
 mm/internal.h | 1 -
 mm/mm_init.c  | 4 ++--
 mm/sparse.c   | 3 ---
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e71ba519f7f2..004a3f1d5006 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1435,7 +1435,6 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
 
-extern void set_pageblock_order(void);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4601e5d659eb..44512f3b3544 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1511,7 +1511,7 @@ static inline void setup_usemap(struct zone *zone) {}
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
-void __init set_pageblock_order(void)
+static void __init set_pageblock_order(void)
 {
 	unsigned int order = PAGE_BLOCK_MAX_ORDER;
 
@@ -1537,7 +1537,7 @@ void __init set_pageblock_order(void)
  * include/linux/pageblock-flags.h for the values of pageblock_order based on
  * the kernel config
  */
-void __init set_pageblock_order(void)
+static inline void __init set_pageblock_order(void)
 {
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 85557ef387c7..324213d8bdcb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -343,9 +343,6 @@ void __init sparse_init(void)
 	pnum_begin = first_present_section_nr();
 	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
 
-	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
-	set_pageblock_order();
-
 	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
 		int nid = sparse_early_nid(__nr_to_section(pnum_end));
 
-- 
2.54.0


