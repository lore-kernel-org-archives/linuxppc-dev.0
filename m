Return-Path: <linuxppc-dev+bounces-21892-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126A2CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:12:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV68F3QYDz3brN;
	Tue, 02 Jun 2026 20:12:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395149;
	cv=none; b=Np1ZsAtek9ksECtkLNvxpOJYm2Pg09/Fmv9+pzNAjfXsJIVv6HwtQpchwqfGCt+6meKsyJpoLjeeMqvUT3DdLploT6Nh/D5+ns5lOuv6yLa+RsxAz1bwLvatwQQsLm+iKwE8jrMOaN/xnWPaW/WFzcLJz8Y0jkQ5KIbGq0XdQAG1O62YaoR3zLJ98PWCzuitZZzkGdGv3FgGVOqpGdT9Ee0VeHZxTmwZb28f+1JmWDq+tevXnFzzvc4jdgHTtnbuT+S33RK8zucH1g3kNpBloykHn9DUOLCx8Zkp5i/VnGu/3LalTjPiMKFy3btcgPuwWyqyujvh2s5PP3VOpcUXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395149; c=relaxed/relaxed;
	bh=26MXCqLFrwb2c3VcF20KKUb5g0TkMABKfAG/bHmkXiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG83jDxpHF84VCU4347eOMAjNbRbaJglXJCX/7pMipYSaBFUyD7CMyi4tus7VMHtigF6QjXEENllzf5U0h7+Tq6mSKItDdIs3SCFzILavj4oTq+Bxo0n/nA8gWEETPFjOpR7qU3X742KwYUHJ3IQUfcZJw07ocjJVwe+kimljxZipC9pzN4IcIG+TUQxJ3ZckotD9Lnk29lViyeDPuA+s4zrSUNRLtKtFLMEB3ueBIE+blU9q4Mw46eVjQwfhJKpeeG/jzIl7uTC4SVTPvoy/lOBYhWZomQxFX0KWRe9iQiioH3oU3P4vc5p8T5qxo5wKV81bNwKqwrfWQ+m5D238A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O/Tj/JEc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=O/Tj/JEc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV68D5Jzvz3brH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:12:28 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8422f148dfcso1273924b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395147; x=1780999947; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26MXCqLFrwb2c3VcF20KKUb5g0TkMABKfAG/bHmkXiE=;
        b=O/Tj/JEc4rxEfGwpYR/n1ux456XGHw2m4or13YMI3ArMGlEnpL6/UlyWlVQXfntc39
         s8lPwLmWmXuE6Ewks43gs80u8G6yXf9SiP86D1MUorXbxLP4YeFO6oT4xbvVtIC7jcrb
         E6eBHBN24tudQRZ+u5X4eHhDodvgbNorzIqg/vshtO0oFrCIncUEKbL1YMyRMPVKVbQF
         nEBaFu4WYQ6MGjLZ61BycFw/qrUQxO2ze+HujfxEsxDETpb7zxhzazim56t99lk36XbT
         Q/OY2q9GrT9Gd9bcCyegDuO7Zj/TGga4BmRxMU/7tSU/69dS9c5FNKe35pn5SBoR7sWF
         AJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395147; x=1780999947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26MXCqLFrwb2c3VcF20KKUb5g0TkMABKfAG/bHmkXiE=;
        b=sGxTbvfNkW1mTaBz70GcrOD/MuKkERNedumcyq//pNhLNyao13szXzWFZucPtRcGeS
         f2H3n78/3O+s6IIOdWdreWy5nXo8CpMYhMB1O2YsoP9rlYPDkM/YyTsZpcaHnKu7rGSg
         Kwr0ByLto8FhI6ChtZH4KGtR6LxMtyOlt5crHvfQytR7U51yUU7d/fz5d4vlXl8mXvtx
         +QkUvgtOzSZqb7MRemrAvkh48WN2QNpdGvImiYhFnX9zQlqfzMHQoUxkAJPQ8h86MItO
         B998iiw4TrDvhp03686kYH0ErbDoHLwZiaI1uPTq+LNO/8gQ2rcvwOO86dP9Va1QS/Fy
         S5pA==
X-Forwarded-Encrypted: i=1; AFNElJ8VvDJu+GsE7++oOOSsZsb7r9h8Rv9dLv57I6tnyOYsitke85iy/qoixksPwMSClLKaXKbXA1eEio/ACLQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyyXVbA3dJ0vihoaLxBDWi5gN0mE8OfzarG0/kW+cDH3jqIejt
	Zf1fPqGCVQ3SCYLfYHBeiNPMCMU/amSJShGuO3YnA3SL6IhHVkrB1CNXArkCqNssV/M=
X-Gm-Gg: Acq92OEPGvwFT7tc4lnXNukHpZY6jF1EmIrprU4Tp2w3uhIsUyroiqaQ8kltGK0CI/U
	ePShIKizaf+j6QMpZ08lN6XGliX7SB9tetcRZADqyGize8BLZ2duxTD2hQAEj3dV09K4n7J1gJi
	bEo/BvtvP8GU0UV4xsN9X7p6Yo3XVBrKXzgvYzAVVxfzxSpF41dMRCEOfdnfBtkzghwBVmDqqo9
	j0ZTBB/B9xGks9h3BwINsJqsYF/rZH3PWaQZNjJ96GlmNolm2rcziwle6pkCdlXuJQmB0cG85u+
	3EdN4vH4hQ84PTUsAa/KIn3yIWnUcgF+Ji+hdXF+Irtxao1NWsXhxEDd6dJfH6Yvkif1/Gyf53p
	/y1jgRcN3OPN8Og2vdSGhR9Ox6+LTHP++ZgSGv04QVV0R/j/FceyGaqkIrQuyKZ210AjQAo0+Wg
	9eJjvGSC0O7wqu7xPlRlzEcBGn8FIPUBTvyK/TlNSzVeCrSRuCeiuAFKk=
X-Received: by 2002:a05:6a00:4c8b:b0:842:43d1:4b41 with SMTP id d2e1a72fcca58-84243d15007mr9808067b3a.47.1780395146453;
        Tue, 02 Jun 2026 03:12:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:12:25 -0700 (PDT)
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
Subject: [PATCH v3 17/19] mm/sparse-vmemmap: Remove sparse_vmemmap_init_nid_late()
Date: Tue,  2 Jun 2026 18:10:37 +0800
Message-ID: <20260602101039.1867613-18-songmuchun@bytedance.com>
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

hugetlb_vmemmap_init_late() no longer has any users, so the remaining
late-init path in sparse_vmemmap_init_nid_late() is dead code.

Remove sparse_vmemmap_init_nid_late() and its declarations.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h |  7 -------
 mm/hugetlb_vmemmap.c   |  4 ----
 mm/hugetlb_vmemmap.h   |  5 -----
 mm/sparse-vmemmap.c    | 11 -----------
 mm/sparse.c            |  1 -
 5 files changed, 28 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1331a7b93f33..72883df17c72 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2170,8 +2170,6 @@ static inline int preinited_vmemmap_section(const struct mem_section *section)
 }
 
 void sparse_vmemmap_init_nid_early(int nid);
-void sparse_vmemmap_init_nid_late(int nid);
-
 #else
 static inline int preinited_vmemmap_section(const struct mem_section *section)
 {
@@ -2180,10 +2178,6 @@ static inline int preinited_vmemmap_section(const struct mem_section *section)
 static inline void sparse_vmemmap_init_nid_early(int nid)
 {
 }
-
-static inline void sparse_vmemmap_init_nid_late(int nid)
-{
-}
 #endif
 
 static inline int online_section_nr(unsigned long nr)
@@ -2388,7 +2382,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 
 #else
 #define sparse_vmemmap_init_nid_early(_nid) do {} while (0)
-#define sparse_vmemmap_init_nid_late(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
 #endif /* CONFIG_SPARSEMEM */
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 464578ee246e..cde6f3aba87b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -810,10 +810,6 @@ static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
 
 	return NULL;
 }
-
-void __init hugetlb_vmemmap_init_late(int nid)
-{
-}
 #endif
 
 static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 18b490825215..7ac49c52457d 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -29,7 +29,6 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 void hugetlb_vmemmap_optimize_bootmem_folios(struct hstate *h, struct list_head *folio_list);
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
 void hugetlb_vmemmap_init_early(int nid);
-void hugetlb_vmemmap_init_late(int nid);
 #endif
 
 
@@ -81,10 +80,6 @@ static inline void hugetlb_vmemmap_init_early(int nid)
 {
 }
 
-static inline void hugetlb_vmemmap_init_late(int nid)
-{
-}
-
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3b036251a2f4..077686af394b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -574,17 +574,6 @@ void __init sparse_vmemmap_init_nid_early(int nid)
 {
 	hugetlb_vmemmap_init_early(nid);
 }
-
-/*
- * This is called just before the initialization of page structures
- * through memmap_init. Zones are now initialized, so any work that
- * needs to be done that needs zone information can be done from
- * here.
- */
-void __init sparse_vmemmap_init_nid_late(int nid)
-{
-	hugetlb_vmemmap_init_late(nid);
-}
 #endif
 
 static void subsection_mask_set(unsigned long *map, unsigned long pfn,
diff --git a/mm/sparse.c b/mm/sparse.c
index 3917a47153d8..324213d8bdcb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -320,7 +320,6 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 		}
 	}
 	sparse_usage_fini();
-	sparse_vmemmap_init_nid_late(nid);
 }
 
 /*
-- 
2.54.0


