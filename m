Return-Path: <linuxppc-dev+bounces-19377-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576B7E6401A
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXZn5cGfz305M;
	Sun, 05 Apr 2026 22:58:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393921;
	cv=none; b=mn/OkaxitBOdj5mpJ54qOFyaVpZ1GkCu2NvnDjPVDIxIIo8FPMTtZyKOZ0fjlFTX33DWyEWjP4cwb0aP5S0n86cUZD1NSlw22OkE9h6yx55wyHvRz/7fe+trz5RCNZ3Oo4VptPJ2FGfnBpuvpwvfDDJitF/vpVwQJLUGnvycZkuzHQ4ZLdaXbx4Cgp9yy9GkGruVCA8eWqSFFpNh6Q9OUOCEGMcQGeBSKZdL256o6Du8skCe9hrHb5lHeI1o++Hri+8ZZq4qD7GYJ0b4dztGntNQiuiGhMdgE0fZo0p0ih6YENXHIQBR7xeY2mGi4CxVZYU8J/jyV4ATkaU3fk0Cmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393921; c=relaxed/relaxed;
	bh=4TJ3Bj0XU7cO6WKSJAjWpCQXgVQz+8UMWhX8sNdkyQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJVqxySaAUyh/V8dPYHCLkAXixQ4W2+keE3sq5Zxp3Xi+lltQcf187lUXsBBYbBUqI9kMB0nRvs/RiY5IQEXlH+croEMipnAVAL94yF00xGPYFFffYGtyl1TGnRIiGZfaS93Z8oXECWm3oGSAUBnhJUSRpNPiI3CZOQ9GzRlCUpiwGSgRhKQueH0Q2BuEbYicA2BmoOeFpqm8v3C9WPtXUXlw8tcg7Y7/U3Co8AxbsFOeiZvtyTujRm/h+C6n1PiFq8OJMz7qq5XOZFzUia3rdM1F1ZtrbidpvExox33mbaAw43mw5aRAyb1HlwRv3SVa4xqw73asH+3c3WvYVIVEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JJmL5Xtn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JJmL5Xtn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXZn0TKMz2yps
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:58:41 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35c206f0481so3039887a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393919; x=1775998719; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TJ3Bj0XU7cO6WKSJAjWpCQXgVQz+8UMWhX8sNdkyQM=;
        b=JJmL5XtnIYA7n4YvLpDnPtLWDdnXaXlGgaueueB1SreZN5b4oCvfu5Wk2SIzfYVW3i
         +oC7l8oZhqvgmF9ahq6SmK2WL2ljG88n3y7ZxqENe1xwgWSYq4VkTXiVfJKkt/y7NhpG
         NPa8E6mjGzmqi6Sxaz5ZnTfbmKQPyBjPiqd2skOotZOJ6I+Kj1+i/bXpkm0ZFlaD/26n
         H7k1N8lzu3FEyop1c/wUgjY/l3e1YY4nCDQRAgK3sFGVTydSWHQfO3SnN7KmtHWJaOzH
         L+b3N0y2g7PROfuyy9KyEGVKGrXDj9+HH8JbigNzmkCetPAK42ZPDdtQ/DzRsxlRGWPa
         yvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393919; x=1775998719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4TJ3Bj0XU7cO6WKSJAjWpCQXgVQz+8UMWhX8sNdkyQM=;
        b=e/ENFcYxVt9c3zfxgQ4+8N7N4vOIRNO9qZS4Vx15sfzaUy2jR2JU/t6R5kqouedlAl
         dNa5hbzyWax7GalZ8q34UUg8Q03fvbQ6/edWXIakHnRUmft8C2m7/QfA//1X0ShqPMku
         uRKwTeXvSvPhg00Xryc7zYBWNJyMTDDwz1qxQ3BIHqSgySKf2L6weKk7vd4yjRivoW/i
         2tqj2AV3tvg/Uwhks9wnf0XLGPLgpksgJDh2lFNF6xFN69Q82wuf+VnnGaJseP0jcoHF
         azzy7BCp06Qia48f9EE1y8XzMftvZqSnIfRI8qFWRkjKwJJ03WsOWYbQ4gEZWHPTsfIN
         5hYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT2VdqBpSswMkM5Wbkc4qh+cMcepjQ+993N3QpggumEk6TilpPHur+egdUmtseyIR6Ph9Z8IaRVA3g0+w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymLzDsxlVfkcwg6LyT4DoLGR9LJSzpKrRKEa44LVoaTnfxop0g
	LzusN7sKwtJgtY1nXIM5I7+04FiTMBgGIdUKCyBdl1QY+NoK0C35zhliCH67Yxk2EWE=
X-Gm-Gg: AeBDiesG4s+ZIXqwUIs2qoQteCtrdWjwCYETzAK3aZflJCIUgsDmp99aWj69aajsUyG
	BjwqJ5Vv6WRahBiHog5vghK/tZ8oja4UqZWsrhXMQubPwREkqTokpuvXEHktQaJ6MBiQaeGbW9Z
	+56Brd8FxK89xgKc4wLC1gbaj59q+GYm1RWkmt15/0xbo1nhKQ1KaNvC1zbvxCVCcbZVyMcnpLM
	stOcv8D43VJpu6U5N/fn9Az2mXmHdq2fMWmPIO5PlAyhPp4vjB0aCx43qMCWm7RFbmEEOV1MzKm
	Z5I1Cu55P2yKnGU62/ft2PaIbRILW7WOmTTGSxsPvJxbc4EkQgkMHQpgYl4gbp9dBAltkTkAXfj
	o78JWndKKIKqJYnYq4FQhTBncsMZViMzPNEX1yr5HreTr4wjaB+OTM66o5iZOJmwgEQCvPoSyhu
	FipI/xhA1ndvQtVhS/a8OmYI6AFB3BGs5nfnF2SIkBpzE=
X-Received: by 2002:a17:90b:52c3:b0:35d:a861:36de with SMTP id 98e67ed59e1d1-35de691b394mr9081749a91.24.1775393919158;
        Sun, 05 Apr 2026 05:58:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:58:38 -0700 (PDT)
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
Subject: [PATCH 47/49] mm: redefine HVO as Hugepage Vmemmap Optimization
Date: Sun,  5 Apr 2026 20:52:38 +0800
Message-Id: <20260405125240.2558577-48-songmuchun@bytedance.com>
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

The vmemmap optimization is a generic method used to save struct page
overhead. Currently, HVO stands for "HugeTLB Vmemmap Optimization",
which strictly ties the concept to the HugeTLB subsystem.

To reflect the general applicability of this technique, redefine HVO
as "Hugepage Vmemmap Optimization" in generalized contexts, and
"Hugepage Vmemmap Optimization for HugeTLB" in contexts strictly
related to the HugeTLB subsystem.

Update all generic references and comments in the codebase to use the
new terminology "Hugepage Vmemmap Optimization", and modify the
HugeTLB-specific ones to "Hugepage Vmemmap Optimization (HVO) for
HugeTLB".

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/admin-guide/sysctl/vm.rst         | 2 +-
 Documentation/mm/vmemmap_dedup.rst              | 2 +-
 fs/Kconfig                                      | 4 ++--
 include/linux/mmzone.h                          | 2 +-
 mm/Kconfig                                      | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1c8a16309270..ae711cd7887d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2125,7 +2125,7 @@ Kernel parameters
 	hugetlb_free_vmemmap=
 			[KNL] Requires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 			enabled.
-			Control if HugeTLB Vmemmap Optimization (HVO) is enabled.
+			Control if Hugepage Vmemmap Optimization (HVO) for HugeTLB is enabled.
 			Allows heavy hugetlb users to free up some more
 			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
 			Format: { on | off (default) }
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 97e12359775c..886f5e78686f 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -665,7 +665,7 @@ This knob is not available when the size of 'struct page' (a structure defined
 in include/linux/mm_types.h) is not power of two (an unusual system config could
 result in this).
 
-Enable (set to 1) or disable (set to 0) HugeTLB Vmemmap Optimization (HVO).
+Enable (set to 1) or disable (set to 0) Hugepage Vmemmap Optimization (HVO) for HugeTLB.
 
 Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
 buddy allocator will be optimized (7 pages per 2MB HugeTLB page and 4095 pages
diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 9fa8642ded48..44e80bd2e398 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -8,7 +8,7 @@ A vmemmap diet for HugeTLB and Device DAX
 HugeTLB
 =======
 
-This section is to explain how HugeTLB Vmemmap Optimization (HVO) works.
+This section is to explain how Hugepage Vmemmap Optimization (HVO) for HugeTLB works.
 
 The ``struct page`` structures are used to describe a physical page frame. By
 default, there is a one-to-one mapping from a page frame to its corresponding
diff --git a/fs/Kconfig b/fs/Kconfig
index 9b56a90e13db..0bcd5b5721a8 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -261,11 +261,11 @@ menuconfig HUGETLBFS
 
 if HUGETLBFS
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
-	bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
+	bool "Hugepage Vmemmap Optimization (HVO) for HugeTLB defaults to on"
 	default n
 	depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	help
-	  The HugeTLB Vmemmap Optimization (HVO) defaults to off. Say Y here to
+	  The Hugepage Vmemmap Optimization (HVO) for HugeTLB defaults to off. Say Y here to
 	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
 	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
 endif # HUGETLBFS
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 846a7ee1334f..a6900f585f9b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -97,7 +97,7 @@
 #define MAX_FOLIO_NR_PAGES	(1UL << MAX_FOLIO_ORDER)
 
 /*
- * HugeTLB Vmemmap Optimization (HVO) requires struct pages of the head page to
+ * Hugepage Vmemmap Optimization (HVO) requires struct pages of the head page to
  * be naturally aligned with regard to the folio size.
  *
  * HVO which is only active if the size of struct page is a power of 2.
diff --git a/mm/Kconfig b/mm/Kconfig
index 166552d5d69a..33a36e20db3a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -411,7 +411,7 @@ config SPARSEMEM_VMEMMAP
 	  efficient option when sufficient kernel resources are available.
 
 config SPARSEMEM_VMEMMAP_OPTIMIZATION
-	bool "Enable Vmemmap Optimization Infrastructure"
+	bool "Enable Hugepage Vmemmap Optimization (HVO) Infrastructure"
 	default y
 	depends on SPARSEMEM_VMEMMAP
 	help
-- 
2.20.1


