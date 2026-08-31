Return-Path: <linuxppc-dev+bounces-26250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9836CC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:56:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLrV2Gjyz2ygK;
	Mon, 31 Aug 2026 17:55:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162922;
	cv=none; b=Kob+3U6WT+1BWUkEB0f1T+4Awh20qrnWE6iSrgIgX0wPFejIKMhcdMx7gg+ni3aEj46oNIDq9SJ68FvFC8mEnsmguEnGFmhXy+hspWv4Okd6h2fSdanR7NCxG5WfJfct0H/LulZ6moSIfZzpsija70wiWwkOxPcTfBvL+ZhBxNKSQlyqgG1TwdUD4FYzxtfeKDwKrKB8hgzhYoKDNBDkdLAY7OlIisNUzwJRN1LOouF1NA9e8X8r58m6sK31YPJh351bQd3KU9QxMsy7BeN2CH75Ndk9lPALlr1L3zJ4rD+roQsNTGsPVCCCEumXR2hCD4EDL8lp6G4qn9NZ210DWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162922; c=relaxed/relaxed;
	bh=UUo/y6IjpqbcIL2TFvU1ITTKCpXfhtvRzwNLV1+yihc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iI5LxzHyH2veXHdeNETY8qO9U3fsaFDsrPSVEBCbS+lAKKfDYU3P2sglYhbZhNZVORvFAHBQV/ut+WiL7IotH3R2baGLoNveOXcNUwZp07nWRZv0GoA/+M30jybrTqBUEcltZETxa6ZBsSlpNCoz1S7NOXF4pO4OiGNVIsoNC1hDyEZ2ihe8OmgRbax7IjDSIppgey1WebRheJHuF2sA5OT9zmySVO/fzxdQhRTHfioRRuV73rVEyKEnoURkCS4rOzNXJ8VQdEU7/+bgNHh1vZANAJmQIhSiM8sTvuOOnNCYYT1SpwtbgNoun1MCrI57yv8T1ZU20diiAPxka6Vemg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=K9HbLrWe; dkim-atps=neutral; spf=pass (client-ip=209.85.210.171; helo=mail-pf1-f171.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=K9HbLrWe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=209.85.210.171; helo=mail-pf1-f171.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLrT3m0kz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:55:21 +1000 (AEST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-85377c8bc96so2855622b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162919; x=1788767719; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UUo/y6IjpqbcIL2TFvU1ITTKCpXfhtvRzwNLV1+yihc=;
        b=K9HbLrWe4NXp4H8sLzpunEuM3VRkmGfENCxqdAusfI/Hdwhx+xb4EsUoVXj3bTGE3g
         +kqfwBj8O5ibQFvK5p6b9ZnjmpRDpe4hzKLNC5SD8fp4KO5FPCTG7RWm1NAhayDrGScf
         tR8PMVxjrWDDPiMy8X9scWtbojDeXlKN0+iXwwau0z/LPeO+49MNXPFVeu3s8vHfwQ0P
         IcDU6C3CXUk51jQbmjdJPi/RZcggMCOTtpwJSwulEbjyoQBtcEM2FjzwNhd6WZarUnHR
         L1mrluv0fqKfll6KAjbwHtMvTeTqwztQLjHeHUM9I9l8368LJMq8r+BPN1l440X0DHJ7
         /Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162919; x=1788767719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UUo/y6IjpqbcIL2TFvU1ITTKCpXfhtvRzwNLV1+yihc=;
        b=swwwOR5zvCJbwzVWrTrhnMjL/heaFqydk/JnpwXX56euh/ggJRbz6U4NAeqoMAJVAW
         v4zO1abClvltva+qYEckN9lpcyew25VTBTDzi7ncAnZ9yzCQDnHpCjUg7X5NLizdCRxI
         +0B1f+5McGAW7uSOVkWCN3V+ESXBuq8JD3vvhrgBTN+C3jgVlyTvC2Dg8oh1seNp5YbI
         t69zHiRs9cncdXczVIBf2FA2S/FQfCFIVFqxR5shjk3BdRccBJWp6hXeGzaFw9gco539
         tIixBJnNIzu+pKnag+iN5vZWbGu5FhoKe5+jZ8b39TD0kLsOmu3dn7aIPWGsCu3OmF6q
         C2ng==
X-Forwarded-Encrypted: i=1; AHgh+RpCj8v0ttlXCByaVRsCi0Wyq/Xptxsu2b7cjwdi204SXsYsdn8Eb3UGh6ZHyENzntNMQWwL/45SYPUliA4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mIIaqFtha5MyPpaHiWsfCI4XFKmalV9kixJ5EEZ4GPMgksafgC
	wtIbkl8HrrHILxMT3+GZGSO8IT15wj7xaqTIFE7K1hXNetfcN2LwUIPq+osbG3H+O6M=
X-Gm-Gg: AR+sD13z/40Khh3A0+xtDDZhWfaD2Na/GBahSMlHQqWwamlpVhpjg1dU3+YiEweqgyH
	/M9eeb0U7eZ0u2pkk1gZUYf9ldLKvPlCCAhjGZHlIuEHG9ZEWClPCYc9Wf3LURpgnoeagM+ab29
	PeD5FUrtuNJOLLF50+Qvv97V8XeosPAJg30P9OoVo9vvQnkrC9a0FWITskiiAQFHZYgMVsYZT5x
	TCLgt8NOVC1nL1qYODXtBfsBnklcayRyCFgEK351O0ZvPDbV/YH3O0n1riMQOBb9ubx2DqKqPtJ
	adMh9PJFcUobq3Fng6Uimq04J8yOIWvKjz9S0QcAbWXGMjUxFmS2B/vKtAKAGR45Ff0B/eKeyPv
	lJbcpMyYA3hBND9cuzwrzh/QvE/QQDCINeDJWOsmRO4B4+cennFCbNIH+rLHg4cB127lF0X2T6F
	neJ7fhg5ozVDqHlY+tb5hbDVNkVHa2Rk5JL3MdvoYRAp8czJEC+Kd3WGK+sgcjOdAM/NgtLjr3X
	pxK+bH76NBFL+0j3WFR92jM
X-Received: by 2002:a05:6a00:f0a:b0:848:4859:a45 with SMTP id d2e1a72fcca58-85628988a7cmr40655921b3a.2.1788162918893;
        Mon, 31 Aug 2026 00:55:18 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.55.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:55:18 -0700 (PDT)
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
Subject: [PATCH 11/11] Documentation/mm: update DAX vmemmap deduplication docs
Date: Mon, 31 Aug 2026 15:53:42 +0800
Message-ID: <20260831075342.57563-12-songmuchun@bytedance.com>
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

Device DAX now uses the common per-zone shared tail page for vmemmap
deduplication. The old documentation still described a DAX-specific
layout with a separately populated tail vmemmap page and half the HugeTLB
savings.

Update the generic and powerpc documentation to describe the shared layout
and keep the powerpc-specific size calculations while avoiding duplicate
diagrams.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/arch/powerpc/vmemmap_dedup.rst | 90 ++++----------------
 Documentation/mm/vmemmap_dedup.rst           | 32 +------
 2 files changed, 21 insertions(+), 101 deletions(-)

diff --git a/Documentation/arch/powerpc/vmemmap_dedup.rst b/Documentation/arch/powerpc/vmemmap_dedup.rst
index dc4db59fdf87..8286acbca9bc 100644
--- a/Documentation/arch/powerpc/vmemmap_dedup.rst
+++ b/Documentation/arch/powerpc/vmemmap_dedup.rst
@@ -19,82 +19,28 @@ With 1G PUD level mapping, we require 16384 struct pages and a single 64K
 vmemmap page can contain 1024 struct pages (64K/sizeof(struct page)). Hence we
 require 16 64K pages in vmemmap to map the struct page for 1G PUD level mapping.
 
-Here's how things look like on device-dax after the sections are populated::
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PUD    |                     +-----------+                       | | |
- |   level   |                     |     .     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     .     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |     15    | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
-
-
 With 4K page size, 2M PMD level mapping requires 512 struct pages and a single
 4K vmemmap page contains 64 struct pages(4K/sizeof(struct page)). Hence we
 require 8 4K pages in vmemmap to map the struct page for 2M pmd level mapping.
 
-Here's how things look like on device-dax after the sections are populated::
-
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PMD    |                     +-----------+                       | | |
- |   level   |                     |     5     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     6     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |     7     | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
-
-With 1G PUD level mapping, we require 262144 struct pages and a single 4K
-vmemmap page can contain 64 struct pages (4K/sizeof(struct page)). Hence we
-require 4096 4K pages in vmemmap to map the struct pages for 1G PUD level
-mapping.
-
-Here's how things look like on device-dax after the sections are populated::
-
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PUD    |                     +-----------+                       | | |
- |   level   |                     |     .     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     .     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |   4095    | --------------------------+
- |           |                     +-----------+
+Here's how things look on device-dax after vmemmap-optimized sections are
+populated. ``N`` is the number of vmemmap pages required by the DAX mapping
+above::
+
+  Device DAX                  vmemmap pages (N pages)         backing page frames
+ +-----------+ ---virt_to_page---> +-----------+   mapping to   +-------------+
+ |           |                     |     0     | -------------> |      0      |
+ |           |                     +-----------+                +-------------+
+ |           |                     |     1     | ------+
+ |           |                     +-----------+       |
+ |           |                     |     2     | ------+
+ |           |                     +-----------+       |
+ |           |                     |     .     | ------+        +-------------+
+ |  PMD/PUD  |                     +-----------+       |        | A single,   |
+ |   level   |                     |     .     | ------+------> | per-zone    |
+ |  mapping  |                     +-----------+       |        | shared tail |
+ |           |                     |   N - 1   | ------+        | page        |
+ |           |                     +-----------+                +-------------+
  |           |
  |           |
  |           |
diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 9fa8642ded48..8c287ae3f86c 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -1,4 +1,3 @@
-
 .. SPDX-License-Identifier: GPL-2.0
 
 =========================================
@@ -192,32 +191,7 @@ to 4 on HugeTLB pages.
 
 There's no remapping of vmemmap given that device-dax memory is not part of
 System RAM ranges initialized at boot. Thus the tail page deduplication
-happens at a later stage when we populate the sections. HugeTLB reuses the
-the head vmemmap page representing, whereas device-dax reuses the tail
-vmemmap page. This results in only half of the savings compared to HugeTLB.
-
-Deduplicated tail pages are not mapped read-only.
+happens at a later stage when we populate the sections.
 
-Here's how things look like on device-dax after the sections are populated::
-
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PMD    |                     +-----------+                       | | |
- |   level   |                     |     5     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     6     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |     7     | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
+Deduplicated tail pages are not mapped read-only. The mapping layout is the same
+as HugeTLB.
-- 
2.54.0


