Return-Path: <linuxppc-dev+bounces-21884-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C6BCD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:11:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV67L31gKz30FP;
	Tue, 02 Jun 2026 20:11:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780395102;
	cv=none; b=Lm130sjACszbr+MT6lXwj3pn365xRrCegTcAmyCTL4Q2Bgg4CjOFnCpOX4pK+ksz6fj7Gl/RoK/FbzN02042cbzeHmxo6RAImDFoDoOc/AuHUfYW2L71KVw4+nH0OGRNdnWsm+1kC1K1i0y3i2f5v2C/xS+a3WI56Y/d4BcM42xncPifl1Xktx7j7kwrrPnBJlnlGxsv4dIg02fDHSSz4u96fuSTYzwCGJPp5wha0rtey//biZ8Dl72AI0z1z2UVjtOW9eYr8Sp3fa055cMlc0G+31gLUJTYYe8nfUAyc4fWqy3Mpk7i77nNivDSmjJFq0DImVEfGZ85O8pY7Km76g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780395102; c=relaxed/relaxed;
	bh=sxbi5h4Z+JKwQ2t0bJ1zO9+zcXybTFpZA7Fr3QeLXFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TztgzG3vKrVWMaNtrGroVzfmDnovXQGPeBnW68RC0SzYSO+8tPfQDy4CEgq4cHcjCjaJuyRYGdIMgl8sysXUub75DhAApA2vg7egcL3eRs8JBYQ6W389k5AiP6hSayon62P42fxixfsCy9UCoExBQsaE6vBSvOVjFYdxQB2UhkSi8NwWC9zcv+I6QcxyPsZfx8IMBWe43uY3V4m0o0Y4GOJoZGax5Bu7nz85+Fg/WtmbvOjMrppxIBPMsBfFzVAQRkJhlyhC3uFCw2DglQIiSbJDr/YB3CwXvWrPT8F/iOqrrZhZIHKEtCJNQ2b5+UJ3Hfoilnv6QpdFQXhO3GGFCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ty8fcdxx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ty8fcdxx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV67K4Wkhz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:11:41 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-8422f148dfcso1273582b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780395100; x=1780999900; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxbi5h4Z+JKwQ2t0bJ1zO9+zcXybTFpZA7Fr3QeLXFU=;
        b=Ty8fcdxxu7Tk3xxujj0S1MSJof0jV8gWHDrBVusGTng2i2t2HcepJTDTwlU3tJu2ic
         Bf6XYGYKnG4HIkFL5lWdLJOEvBcCbfbDbqn3ndnYMiQdUDYNg3bAz5EVJva6k8YnQaaw
         7Q1S867pM1w1RHzFfsMoax/uLuLslQaLUaI3lyhiXGCJuxGoEO5U3fmWa0RDtIvX+3jN
         3uFSElrXBZCkb6D60t5nyX/9nYOmNj0oz6VXehfqozDNq/TvaP3cryHlNvobyQbK7lH9
         YZepS66TcyMYFlf61WqBRLI4kAOPMMgbDJU5a8lmVcXWU7OjqhFoRpZceWPTfBGCilDD
         LhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395100; x=1780999900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sxbi5h4Z+JKwQ2t0bJ1zO9+zcXybTFpZA7Fr3QeLXFU=;
        b=J5cWyNhODCHjQhqPSKxL9jR55RjXCb9W5oDettMrR1wdVdQI8s3JVBzb44CQ5i9Z+r
         kzXicSWobRmB/h0epO28NVUuoS9EQ5g/0/VTe+i9QDL/yXrY23SmNhNBiJSjyJ51y3pK
         kjy/bpKpvtRbwKPJHdDb4PP30xb6Ag94UqKxj1ulnygyLOHYilKztyzQVM8IPxjGAAay
         NeomiyQ2WDc+zbKlFRvpBdbGU215KCrmww8UKsIXeh7ZzUpAYcswcslRHS0dfVCb9YuL
         O5hCQPBeaNu7/k9Ggcza79cdhGdTkwuU6OOlZwLwf+Do3ihRMiIErIl2Ddlqj4XItjlo
         aDUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Nx28AA+eyH3/DRJ1wUrD/jREmZQQUvNxrIp4d/vMn01L8QonusKeUNz60Bx9plranv91Ab5c50+P4LJg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxhdCI7raHp1/Rg95Pcp/+e7b+U8oGCt7rVA9PyFh83DmQO4Iny
	N8HFpzgpW0zZfqNuqRsaQauxZDHcEYoumeGC/jma3dTeEETfM2BBUAtSOrj182dUx+4=
X-Gm-Gg: Acq92OFFsFjI9XykBAKFn468gff5WJGRyPzTdBMwwH+ypQMCvL0pW+M35FK9Xpg0igm
	rfXmjk83sliCWVt0fpzGDObgZAPBx/jhp+0KL31tkE87MSM9n1vyl3NoY5DAoV9yERwrWwfRTIX
	QCmVbVm83zO9Teo7GK9kc8O3brXX29xpvBGM7IZGwWwxVdaos2MfEFC0LaqF3A/27YI1fMeTABW
	Nais8UIFq0MbpPfUuaHqYVLB1FgixjlGcsn7rQ+J6l9tQXNB5lLuMeUAqU6RvFL9tngPKnD454N
	+JthqjUC5HsPpuoDBo247hfnxxcNZa8ylsT0awbHc8bneHKAp54cQ8dUBhX5zLa4T6pXr/w1abd
	nBW0qerVeKC0PtDSqkSNdMsQiphEIsvc9unbpI1dz4cvYIwJSZigJh1x61sH9FCLXyVax6h145p
	wdlqUxDFEMAjoNMjiVBWlndSKbEUiTRgKS9PqIl3p7rDxv6sTUbAJGTXs=
X-Received: by 2002:a05:6a00:1741:b0:842:6004:3fb9 with SMTP id d2e1a72fcca58-84260044470mr5719945b3a.25.1780395099558;
        Tue, 02 Jun 2026 03:11:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12015507b3a.60.2026.06.02.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:11:39 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>
Subject: [PATCH v3 09/19] mm/mm_init: Defer hugetlb reservation until after zone initialization
Date: Tue,  2 Jun 2026 18:10:29 +0800
Message-ID: <20260602101039.1867613-10-songmuchun@bytedance.com>
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

hugetlb_cma_reserve() and hugetlb_bootmem_alloc() currently run before
free_area_init(), so HugeTLB reservation happens before zone state is
initialized.

Move the reservation step after free_area_init() so the relevant zone
information is available before HugeTLB reserves memory. This is needed
for later hugetlb changes that validate boot-time HugeTLB reservations
against zone boundaries.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
---
v2->v3:
- collect Reviewed-by from Mike Rapoport
- collect Reviewed-by from Oscar Salvador
---
 mm/mm_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f349a6f34139..4601e5d659eb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2691,11 +2691,11 @@ void __init mm_core_init_early(void)
 {
 	int nid;
 
+	free_area_init();
+
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
-	free_area_init();
-
 	sparse_init();
 	for_each_node_state(nid, N_MEMORY)
 		sparse_vmemmap_init_nid_late(nid);
-- 
2.54.0


