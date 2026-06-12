Return-Path: <linuxppc-dev+bounces-22539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4603BCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:00:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Q23p7cz3bsy;
	Fri, 12 Jun 2026 14:00:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236810;
	cv=none; b=XDGeN1Ihm6DSnlrCYbp9cky5w6CNgNZKbrgtXuR2EpvMbPseqfVR7spQRNYFRplfbkiopCQ8bFW7fF9ujW9QshDV9bOOjSf7sKb2SpbSrD3lIxtj4o4xACTdwUvPNmJOqGArlRCa4zqlbJ1OMADxB1PGWhrrDhFxz+UyGvrQ/48aXGcoV7SPh7xXwzdUVIe8chqaRZi/bTuUD8qiFfgRszZEABS30G7XLLWsFWKHhRRQXURS0dKxtH9fsEaRzZTXm0TgOCjZYKVcPzNXD3f7E5aVIUERSX1Ew8ZYYfUDzaC3FNJzBMdLaoOQFZ9W/EbFLkor1UBDT9m8pJ7RpWiQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236810; c=relaxed/relaxed;
	bh=AtY9w5OLgbMDm1Vvzf6EQHSekByITXuJYckwU3WoHU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFrltu9XpSXxY1Prx0FEfpS54wgsdypo4QY9IeqjR2U5D3+E8EkuXj3RcnqnhFaKWmKe2THkvHSQOogVHw8jumH+49uosShF68IWW2P2l5gYnXN0Vz6K5+FsxU5okdPq0r4FauEIOrfzF+6dw3xITtdvviILjM1TZ40FibFmQHQKyvOXzMvc9eEmpJtvgFfjSNXFIjq44ADB0AfHlIqq0uSS/bV8tc6n7QfIMTAvMFT9NmR0S3X/A1+CGIAyuxxnPiYRS17T2sNPlBOKS8pxOPXdg+Ij9qLj82ixsawa5U8WyCTQDRvRyNfFHuL7CBZUllNI9GlZJ0sBxQcAiKURsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aQtNu9zE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aQtNu9zE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5Q128WXz3bsQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 14:00:09 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8423f869421so468471b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 21:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236807; x=1781841607; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtY9w5OLgbMDm1Vvzf6EQHSekByITXuJYckwU3WoHU0=;
        b=aQtNu9zEBDOM3QJBCAFdbisczqjBwLBdu0jhPQgXPaF0we8s49ZXfXAfqE4337Ra6v
         1Eq/NRiP9hvlakyIyAqRu7P00aXKY8Wi2IhshymGMm8zhNsFmEnenmF0pEO8gD6BURtE
         6oF1IE8ga9gUOpLZWt32THn3QRaD8Kt86EP8ynTIj3weCRnWcyRc0SbEilq329dp7Vcc
         G1MECEuc2uXMhn5UUwXo+LDwAJYVQBKSXkTTHqBevqRlgul3gQgZeYi0behaYwGiGdkH
         OVTcwX9bs3TFVD99nXhwof6Gmqpu7NCd78dL/Eacu2Oz9i2MjW1ebskYW+3ARapwqDyl
         wRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236807; x=1781841607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtY9w5OLgbMDm1Vvzf6EQHSekByITXuJYckwU3WoHU0=;
        b=JAC1Vyp4z1emyzjQ6NANNZJLSDTarL0RM9fb5fJptmrVIfinvB2NU4o/j1tyxRUKsJ
         6Czqal31Pr/at7OJMT1sR5P+V5uUNup+r3aLtr/8j2MZo0YVW8Dn4tFJYwUT56PYKWQB
         0PTDF1W8rUy8hVROPJ9VMQyH0I0zdlSG159s5r3+uo1IE0rUdaBIc9wgs4lgC6vUTwsa
         TYb2n4xXvq4yjBDwkXGQUd26ouZCXcUruw834fozu5NnPyqHHVPJG9N+CWE0KPfiviFI
         f/ThnW4K5M0fj+MAzGvFE7Mty/ztli2+xuRT2YoVjw8KFWcj5b+myLA8Vk1BECSSH1PX
         RnVw==
X-Forwarded-Encrypted: i=1; AFNElJ+1O/O4yHjN/XiQXe0U+7887beLsvJ37x2A9vCegDuUvMMNWcfuJ9gittakEduzrd1Yf/ile9SKmO+pr+c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLWG+72Oul0pJrK1SnWFsTOma8+7YO3x2CM9+gjgGDe/bNpwZ9
	wlbsefHwZFLtHs8whq5RoFcsDo+0Ury04chfcVmO8EegTvXxuWMJ4nAhb+bTKIJPmOc=
X-Gm-Gg: Acq92OGAmZep5qb1BQ3sf/ODMxUSQ4rn9Rn4sk28r6/EvIKVLMJTbWxvciaLpuLCCL+
	PFEAbVnJoUKNehZbz/ZHbwIZ/5xBgKdaQ0ciAPAxR1923Jfn7PJT2OAhPyV5qTA0h27T2Ks13S3
	7gY/ZNH/v1U1dKZu5yUJSf63oI0YmrDKxaaFA1/X9Qbqx3f23O8FLzC+FrBzDBSoH+j9k9hw+gz
	ppYUYddyvFzBLinvfo/8Yx1OfgR9U6KbCkl7imYVDii+P6lLC0eL9fwsVYS+WQaBiF/ieQQehu2
	MiASRnUcjjquQn3BjjGLQkjjW8cVuzoRNTEgcVmyoaWe/NkoEnibSO1YSq1lh5LPUXOPpqsMLGk
	Pf+NqyR2u1zPWbGwD8wEGW0wM923xIx0D2Kw122gSHZIGqiXKPLlBjhxfFF9gWc7acTNCfjgnpi
	NAUwgY1QZUIgsSH/fCN1GgyBrX+GVG+mDefqdyQFCIKJI=
X-Received: by 2002:a05:6a00:2992:b0:842:5d9b:d590 with SMTP id d2e1a72fcca58-8434ce1c8c4mr1121632b3a.30.1781236807010;
        Thu, 11 Jun 2026 21:00:07 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.21.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:00:06 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>
Subject: [PATCH v4 11/19] mm/sparse: Move sparse_vmemmap_init_nid_late() into sparse_init_nid()
Date: Fri, 12 Jun 2026 11:58:55 +0800
Message-ID: <20260612035903.2468601-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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

sparse_vmemmap_init_nid_late() is still called separately from
mm_core_init_early(), away from the rest of the sparse initialization
path.

Now that sparse_init() runs after zone initialization, call
sparse_vmemmap_init_nid_late() from sparse_init_nid() instead. This
keeps both sparse_vmemmap_init_nid_early() and
sparse_vmemmap_init_nid_late() in the sparse setup path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
---
 mm/mm_init.c | 4 ----
 mm/sparse.c  | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a0eb61f9f55a..c76498b7abd1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2674,16 +2674,12 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
-	int nid;
-
 	free_area_init();
 
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
 	sparse_init();
-	for_each_node_state(nid, N_MEMORY)
-		sparse_vmemmap_init_nid_late(nid);
 	memmap_init();
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 324213d8bdcb..3917a47153d8 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -320,6 +320,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 		}
 	}
 	sparse_usage_fini();
+	sparse_vmemmap_init_nid_late(nid);
 }
 
 /*
-- 
2.54.0


