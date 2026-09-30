Return-Path: <linuxppc-dev+bounces-28564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DCBCA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:07:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxhT57TWz30FB;
	Thu, 01 Oct 2026 00:07:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777273;
	cv=none; b=ZWM8lmda5Nw+7sB3b72ODVDOlw4Nlzbebjm5OC1mDryV4wmJ/DVS+k573DVhglj8Ib+bgnbd/3K9PnrYFWIBuQ3VzGO7TcjGC34AG5+y3ydR2WDgfosl6e6GOvLVbOuPrsPE38ceERMkQI1OvNO+MGsvyZBK99SGTCRCX5VckwTw6mIzsVqK40przfCQYBG/vi30DjhKMhUTjyp+C1HdRHMmGU4fpA0R8p44gs9cssE/IUf+0iQs1T1yg9JBZ0A4zHXWg7BCYOmy6jNWPM4aFIjQ/ZiTsyKagBQe0/2Sa9zVi/Q4NV1Mob/MIQqfDp4BRh8w7rgEAs77SBREoK/FBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777273; c=relaxed/relaxed;
	bh=4lYqlLPEL4NmsKfc4jswjFAJ2nsB8z9Iog/hwprMxOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4ETI/QKlje/NG6z+3VH8k+Tq/3Wyg7PQWRke+z+DDt33keFp6KJBU+kZ9oXJdegMqSJVonJZNzKstWYpHgFL5Q5lm+4B4/dZM3JpLlBekdL3zejW+s9NMtHoOIpHJUimlL9KNzZL3YNdwYtMNsgWhr02XHOUhAVBh0B/sPNohnv7pdzYxjB3ksOeMDiw3De7XGaiphwnRE2FWKr6tvKctNLWsEF+Z+gzB8E8RftQHQ3HCBeePylpz40DsQDtuQYrddogc4h/NzyMI/L3CfiVDeg0rNb6rtMJu1itbMNMbiZRKrYOLhLv+WG8zrVkeP1jAio9/i4Q6aA64mlscFLGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cKD8eWp9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=cKD8eWp9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxhS5Gk8z30DZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:07:52 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso2753947a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777271; x=1791382071; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lYqlLPEL4NmsKfc4jswjFAJ2nsB8z9Iog/hwprMxOQ=;
        b=cKD8eWp9YzNOySG0xXXLkbGXmCR/js8fcI5RWaNBd6HivFTQ1+Ni3aDvnr4fk8C0jJ
         HLuDm2lAjkEQxPISLi9GVSLFGatFYayzzPCdqyI5lNqJST6mt5crysKy94riwAQ2ZFek
         n/21gfe8T3VmmeOXnWfK4nxL+AcLHoTWwDuZCsCgbPRYD6HtbGBwhiesagHbEeTRiez5
         qSO7pqFSX2lF/9YZ6kbXfXh3WYfJ5TCI+Pf++IIo5P0JPkqBZG2FJ04pC8ZkDTVvUjq0
         X3ERtn2WpGAoHK58QbwajPoCi3k2leGDEyEYOwCT3i/hRUOku4YbqVQPzBZv3HkM/dO6
         RNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777271; x=1791382071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4lYqlLPEL4NmsKfc4jswjFAJ2nsB8z9Iog/hwprMxOQ=;
        b=URtVs8wH8yHNK4vrw0y8LnSNyHiKYmhYvoN5b4qLy8S5FSbluMg2l/sxWqeEAn5ZcT
         fOloXDKlBM/RZmRTMMqt2bZgjjAvrT3APAr8rgilCqz5r2o7lQGUn3kLxrGn41R9cdcs
         N9GIzc0YVQAzLkN7vzERZhgcFZgOpMolUYLyIKjLyy9PzfldAf6pgq1GsC7thwuDF60c
         gXiwpc+ROK18yA+gGN6gTFK6UxgU+Jbfe4IauYmkIhEl9PArFdG9kfxUoib4WzG+2bdD
         96GSNkCYpk7bnb9ZEhhIvqBj0yaXXE7sWhLQ4kfvPb0r6NKtSVY2Gz4YEixN/d/ajq6o
         YZPw==
X-Forwarded-Encrypted: i=1; AKwUvBzt0+3MQQ8b/bKnVAKho6dzomytlju5/ya/cKtywd4KZz1U0QMqPo7gSBdzirF7G7kJouYA3hS5BYeriCk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYItku0BHZHlyMcZkrEGI7i0FQcDgAMp+WPkymaHykoc0JgSnv5u
	JaIDlrNv+Vus2iTubUjRp6r/JfBzkauPehMN1FwNDub5uZ3oZekQo4y5lkSFNLCSdLA=
X-Gm-Gg: AYBFou3ub4UA0/7bbs6pNYk3WAVLL7nNQnSpTdnRDOVIL86Y8Tgy/TSzjJw7hg0oS7l
	LlwZ6lsMgdwowOxsVAur1gTEpv1szYFcFrimtg3J8+oPRpg6adhTaxhs1cL7twKU8s/oFrtSyZu
	pYMUdkAf7AxJ60XnugQT/2VZFXXTwnvCGpXNMtAVKnZvLoVrq/V0r7iMNrJZPDC5RDs8+wKCvoC
	uUlYXuNYdkGGLCLTX8me2nohV6k+2PayLPTxTr+1RT4EoSXjE3g0DaJHqSu3f0Y13RhtQTDdf2t
	4kOB8J+jecTyxFoxuXt9raTS8aMphlzsYDpI+CC9OdIbN6oz1xLBTvwQZDtSM8h/t5VEHOzRjSh
	lyq0yCranTuQ+lmdSU+YizJSl14FOGvAZ69qNVG1TO9HXHbQPiQg/6l2BrHBzQW5PbagJs/g0fE
	WD0Tk++gkwaJ5DPpoLy0b17Cyi/4rnYyIWPSq5ERU7jkyzVvd9UjhEPXYC+u9b7QkSqYRXbblnv
	KvqCdIX2Zx8MvTTqFlySob5dw==
X-Received: by 2002:a17:90b:1d46:b0:3a4:cfc2:3517 with SMTP id 98e67ed59e1d1-3a4d1b5dee4mr1371166a91.49.1790777270839;
        Wed, 30 Sep 2026 07:07:50 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.07.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:07:50 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v6 04/12] mm/sparse-vmemmap: open-code init_compound_tail()
Date: Wed, 30 Sep 2026 22:06:19 +0800
Message-ID: <20260930140627.57431-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-1-songmuchun@bytedance.com>
References: <20260930140627.57431-1-songmuchun@bytedance.com>
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

init_compound_tail() is only used by vmemmap_shared_tail_page(), where
the shared tail page setup intentionally passes NULL as the compound head.

Keeping this helper in mm/internal.h exposes that special case to the rest
of the MM code and can make the NULL head argument look generally valid.
Open-code the initialization at the only call site so the special-case use
stays local to sparse vmemmap optimization.

No functional change intended.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v4:
- Collect Acked-by from Mike Rapoport

v3:
- Collect Acked-by from David Hildenbrand

v2:
- Collect Acked-by from Qi Zheng
---
 mm/internal.h       | 9 ---------
 mm/sparse-vmemmap.c | 5 ++++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index da14c56fb24e..0dca33db068f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -786,15 +786,6 @@ static inline void prep_compound_tail(struct page *tail,
 	VM_WARN_ON_ONCE(tail->private);
 }
 
-static inline void init_compound_tail(struct page *tail,
-		const struct page *head, unsigned int order, struct zone *zone)
-{
-	atomic_set(&tail->_mapcount, -1);
-	set_page_node(tail, zone_to_nid(zone));
-	set_page_zone(tail, zone_idx(zone));
-	prep_compound_tail(tail, head, order);
-}
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6916a3690778..f77e6e1e5a8b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -221,7 +221,10 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++) {
 		page = (struct page *)addr + i;
 		mm_zero_struct_page(page);
-		init_compound_tail(page, NULL, order, zone);
+		atomic_set(&page->_mapcount, -1);
+		set_page_node(page, zone_to_nid(zone));
+		set_page_zone(page, zone_idx(zone));
+		prep_compound_tail(page, NULL, order);
 	}
 
 	page = virt_to_page(addr);
-- 
2.54.0


