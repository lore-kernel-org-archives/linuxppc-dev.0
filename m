Return-Path: <linuxppc-dev+bounces-26242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD026C624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:55:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLqm2lnrz2yrH;
	Mon, 31 Aug 2026 17:54:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162884;
	cv=none; b=H71l6L7CuQ/1AJSXC2PXODH41uJ5BQzm5i26kKXj8N6Uxd53Erz7920uTNd+vVfhlczCSVro7EgOcgxT0xHY7tlXsDhS5CJTf4lL66i+cZwmEub04ZIxO9rZjRRmk5XyIa2VGEcercrNrjtGZCbTkyEcUzsdyjlzIYT0+SaZAc/X30TibDgLRu2zcww6IUMMg2p2BGHEf0luNN5M2KzV5G02++hKOi88uzyxIGHAJY9fzNTa9ZZDFCFIUcRcNGwTrxlv9axm/g/lhZviIFdJbEAWN11PAWxNkhVKJ9lN4iIQYMcCBrcSlI06RW+NQWCK97oYDbkvDLKLsgGSFAXIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162884; c=relaxed/relaxed;
	bh=Ydg9K+ixOLWYvkyYLVa0DgkFjsmj2k1/+Q4MRUoiR6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/WG1zWmJwkIpQdwI5Az4y9SDMhHKZTMU0k/0a5kCYNEXaVPNRcoaJxJ+8whWhfA+kU8T7qHfqkVhwV3s2BSK0FJefQteiteocxItx3TZ6FJAhtH6PXemaOZy/eQ2gV8kmkfGXxXyUDiGh5oiEVKtnVXOJ3VvXnqufrhU5A3ZsujYZx2wPuK+JWmM/7w0yn37pacJv13Udck+d+rMcgm5anrACuS3rofcFJDEXSrSiR7Q5pd5ulplX5hsZHvrfiomRNqhQKF19qTx2W8V5YR/Qhl970nZkVwSeOF5y8Cj9RTJGka0brsmLfgyoLA+q7Si62LK5ELsKQGoMSoX/fXqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=F1fea4Ne; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=F1fea4Ne;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLql546Dz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:54:43 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso2870591b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162881; x=1788767681; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ydg9K+ixOLWYvkyYLVa0DgkFjsmj2k1/+Q4MRUoiR6A=;
        b=F1fea4NeF3t+aLgFnQZpyEK+I8ijooc/uV/giOrLZEYLLHy59TeczCcGe/txQ+QApl
         NXyTcld0MFxevvMykHfE35qNIcaGLYyZERhB1m4Gc3awurpzUz3T/NZubASjJMLUp1LO
         97PGpHk400RpYIc+88DnAz0NaWvnvfAJ29adf4tNTZvp+NsLL5x8s3kQ7xyPk+1dqJG7
         tJhe1opIv5NVZl+HbMAxH56/cTLZKmfuLsMw1W9uhNaPUPruusG8em7pNercG8U8CSxK
         BdfonvtUg5/qT9MwqOLyURNa+nUWP4zwRePQMdd6YBGS7QQGfCuHHO/CJmQf02EJk93B
         5lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162881; x=1788767681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ydg9K+ixOLWYvkyYLVa0DgkFjsmj2k1/+Q4MRUoiR6A=;
        b=MX8z+FFXsrOIjrtb0e9pCPqpGYG93sXkcp5isnr2qjOwSLWFaGaM1tfnkavfOSMAvy
         VpZlPrMZrlNRKggBlES5YywLAN/O93owKsBjkfGq1l6U/cgLnjtWvo9bBq1Lif8q+hUW
         Kf3dX1qWfyQTHHMrRk/cg1No5w7ySZFPkcwZZC4yJnbc/gMXicFIWS8MmbjmNYms9Mvd
         MS8ZDsruszdKu8RJkzQP7YV9A1p0GWsofpoKcmHkcX1VWbGTRWWfsiTn0TVLrQq5IIEt
         EvXXw4AK5kk0Z+y6oLMvcBSa8mbECYavXaduRJpEdq+I0qxeGRpC92uX8YWhr/XVG30q
         jMJg==
X-Forwarded-Encrypted: i=1; AHgh+RqdcCDOcFZEAaZvLMqyWI82t4U2O8WO7pILmvV8AzTqKHQWgf0b9n4HnS3UHshSusbbmCjK0RceT7jRsNg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nMMByeKKMCxPI91mtS3g/xujzKBXfnEnHUsvWAHBMWymEhXj9j
	/mbPdTR2eJ9KpYxXYFo/+Go5/Sg0pJ9NCf/WsWpL4QpRVgcBfwvI6uJ5KSq7zwh7PQw=
X-Gm-Gg: AR+sD13M/jyfUP0VSV8LDjoBEM2rfbs8EAwJ+sCHkKEx4wHAEbhIJF3jMlUuI4V+toL
	UZPgoXjRXXk/Px6G24H1AuUW2KxG1oQKZ4NC5K2YQI8BIdUVXUqICSmR5ZKWt6nHfp4NtU7qS6q
	6FNGVKxMaihYhFTq4zB/xMUvBgTZHuu4JtwjmXbAV8To6ikinNlPhOsNS9vjNF/afhDv3pKy098
	id/XytNuuVcBj65ytb4WgwqeSsn6uczygp+HuwRZB2cbhmYkM/Oox2PM3v0deoTsVR6rU0JQvII
	M/23p7q6rOSY/+aWfSWD7vIMeTLp5lBEKTzcdmWhU8zGyhLEmH2gfhru+4pA9lZE7gHJYhfCmHj
	7i3s0AHZ0lxJq7MmdoPEgwQH//O/raXo8faJSo2cCBz+JGMnHiPM+PDnBFzT+3YG02CQeLZNDev
	TAny6n5JyJW0F7HujjHUWgBcEtv9XdIxZrdRgJAbhn73S6jHsXnvG9LbHhjFA146ZJIqPXJr/1u
	n40LagzbQnpB8fWm0/0qRKJ
X-Received: by 2002:a05:6a00:3487:b0:842:3c77:5996 with SMTP id d2e1a72fcca58-85994491148mr5360786b3a.1.1788162881545;
        Mon, 31 Aug 2026 00:54:41 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.54.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:54:41 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 03/11] mm/sparse-vmemmap: open-code init_compound_tail()
Date: Mon, 31 Aug 2026 15:53:34 +0800
Message-ID: <20260831075342.57563-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831075342.57563-1-songmuchun@bytedance.com>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
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
---
 mm/internal.h       | 9 ---------
 mm/sparse-vmemmap.c | 5 ++++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e16f1250b25c..5ddb49680b06 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -783,15 +783,6 @@ static inline void prep_compound_tail(struct page *tail,
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
index 70143dd8b579..e453ce4675a0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -189,7 +189,10 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
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


