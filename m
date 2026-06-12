Return-Path: <linuxppc-dev+bounces-22537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6A3CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 04:00:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5Pq58C5z3bsZ;
	Fri, 12 Jun 2026 13:59:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781236799;
	cv=none; b=ezeYL+Sw9aKy9Z5+aMXtTuOyPhg9uC44VfvtykUG4eML0V+R8SnZ6LFUtpYdYbFREREX1ZzKMKoVH1iQ8LAHkds1NYVE7eox0RAX4gzgndwC/4Vc5I3nfUpVoaGTN97kqoVyVNmnYiRUbBoUkJkiHtx+5f4d8G5mlhxyiCWZtbtGSTnL2hzMDb0WM+cRYsDtKZ2I81nS6625OgZrQ8ePEGqblo8ndOXrzBJUNtNxShQhBV2fla/aoJUVMXFDlE40I+V+SalS5lawsQ1pC24ppg4Jtj8zDEWQCamrFF07RM12cmtZjlkoINCue0DD6M80e3MgUS0jhtmvQ4NNgxFftg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781236799; c=relaxed/relaxed;
	bh=BR0a3ryVRFpnQOFzhfXrKrFPrgwx6VYHHIteJPCS1zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mp7EOeWjsXPooTEmMT6xRYSsii51Kll705y8CVpBXvSkllOjWT2ScX5SMR39/KQ4JoUs1qt//JbaLT4qLn04TrV2cPuIL6NZpXjBCjbAPo++J3JlDCT7oDQaP3/VkgiWcMXPSYBLmQ4qvVWNmiuzHLc5ePrAeaRGDg9W04R4BjILh7eOv6XpoGYmuMV6vqzJzvM7wc3bX+wG6OSxtZy+quU2P1sqUg7lDW9hxPZjRzUEgJ+EUFM1e2xH/6uY/armdzPLpmz3eFUt8MU+JLmrn5zUMSnPNPqkHPjNda3EmIF8Dw87Dml/OThJLa91zYtgCHiShjJC46oVJrgZ7bbYjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VNEZqGBA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VNEZqGBA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc5Pq0Vfbz3bsj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 13:59:58 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8422f395a4aso418418b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781236797; x=1781841597; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR0a3ryVRFpnQOFzhfXrKrFPrgwx6VYHHIteJPCS1zU=;
        b=VNEZqGBA045nm/keCKue88qibLFFl6Z7brP1eITQ1GWfbe2ESTMOoL3+gMxXNYRbkB
         gqI2dNFSbPR3eF30WZAJwIVwOGuSpP2acmS+G7nqQHUL5LLUtZGfpwG3x4+czE79bYQb
         MO1rDtdSRxRTcX0dhwhZ6cmnZT/bw3R4f19uHq9aGDOVX+xlqBIbMFx8Gs2jnL49C1ok
         X670jGVId83aFigxEA1LBiFd3g69mFODgyQg2O468eLtNGaZ3nfY1D9TJNTXX+EFqwUq
         ki+2PNKfmWqkcmEZ8CR7Rs87lxFGA66Fm7bWc1sNlryh6gIv0bUWJHdQLE1T9sOQFUaW
         CFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781236797; x=1781841597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BR0a3ryVRFpnQOFzhfXrKrFPrgwx6VYHHIteJPCS1zU=;
        b=pYPHRG3iSDIAgigHKYhJ/SZtRaP9uVqoZUfrJ4uDd4qqQ7hFFl8LHt29ZQOfRldmgh
         NuunzshQwFOCQBhR7qYioynd4/Dv33j3R9EPuHSzlwnHOCgOkhDTmyDRdQKqimAXzoEw
         fAGrpmQLJ8r2lpaZ0nGSJYimdjmaSHHtGL1sx4CPxZdq5fXRFw0YUSsF7mugiwPNwkFH
         Hxe+DiZfXA1VXlXW8ys/VIQZ+QjFvjbwv6+chel7vJ7B4HGdfpGQFdcGxmab8+jAZTR5
         yWHSNSxGqwyON7NCTKoSNe8eoWkQQ9uGJOe9THWkriEhsQiNceyY/HzYQG0qreFKql/1
         xazw==
X-Forwarded-Encrypted: i=1; AFNElJ9T8FdvdAxC5qUBhOOy0SUu7FVGPCturFIilMjK11/JUIDKyOAuPSnlnhBFzT3DKCdjO03gZbf3mD1pZ+o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4JnueyWt8a70Jom7uCOuhMqR8dDIKW/M2dj2qCCeHsstta/En
	yh4YJYfuwyJjPR7Y2HxuSF2OLowPkNkYDQEPGZtoK3e5cyCpMevarzQ0lFnDt3veYks=
X-Gm-Gg: Acq92OFDCa+aYJe70xSiqiPg13Ar+El74OCKZd3v1KyhXD21uvNCfZ9qOU9kzRkf1hv
	qOBFNUUskzRwySxze/DFUyBD4vZ93690rW5PPJdRCAsnCGN3gzgsfMGPn5t+s/SY+A7hHNXmP8b
	AyjbCEWt+ozw2QV7xqcEttqXqmUlmAnxa59lNOH9aMEzSR/LYukmthzQkD6CGjTzr2iWL3Om6AR
	smU5bgD66hxbyRakWbdo941QYBTD6ZjlqoZl9w2W1zFwgzlEFDlDvjcRKk1VQxfmdU/NQoLd2ET
	FEZMI4Mfb+e6XEcoYwszP0FqPbsb4/QfLGXob1+O8oWq602I5wlXXXPaUpNiNjza6VrdQCGRspG
	bicImCeArs2Iqylc1+VBST42hf7o2+XmT9QNxH+edn2lP3S7TYKE1i3ZUaUHJhrPq4ze3R3WxIJ
	HF5eVfS4ZxZK9PF7OeYE8xxfjDP7OqlHejPFqldhH8JkQ=
X-Received: by 2002:a05:6a00:3e20:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-8434ceb5bfbmr869958b3a.10.1781236796968;
        Thu, 11 Jun 2026 20:59:56 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad03fdcsm643352b3a.24.2026.06.11.20.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:59:56 -0700 (PDT)
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
Subject: [PATCH v4 09/19] mm/mm_init: Defer hugetlb reservation until after zone initialization
Date: Fri, 12 Jun 2026 11:58:53 +0800
Message-ID: <20260612035903.2468601-10-songmuchun@bytedance.com>
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
 mm/mm_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index bdeaceadb531..ccf494fa7586 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2676,11 +2676,11 @@ void __init mm_core_init_early(void)
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


