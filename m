Return-Path: <linuxppc-dev+bounces-27100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F09DC88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:05:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2X80cTsz30dj;
	Fri, 11 Sep 2026 15:04:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103064;
	cv=none; b=eVjxfS+iJQyYdOzYnkn167SuRdHC1h+U9gSqlz7IBuVnsNfLMiuxBto0ARDGk1lctt3hDR0XefdB66Vslv2byzrMs8KWFW07oXZrxh6zc31w+cThRE0JslIy9BFHKh+XM5kTs2+4wd29+8oACYC6VKnO7uKxh7RF/fpSToaq5Czh1J2llLp8dVopU0sLYH0K4D8TCyHkgjPQllISSqsAiApcsBc4EVFvGQ5WkECFEP7UOXJbdVr11l0hFlGeHF5JscH7T+TYZ7R6ZLlAHqkZSwrMEShDUejlmmu/l/oraDms6DDHDE4rQXzFAdjSmpwnFmWba1f4Cuf1wUf7AEFxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103064; c=relaxed/relaxed;
	bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9doEFOzBXjEa/0jHE/eqcfbaq+bYyMZCsaDCdemf4sLoK8mi4apwPBVXElqu11su4rroYTgZdh2r+LH3MamHL+I1UZ4MdYffc7Yw1WhNHk0BFVTexrmWz9I4U25Xsiq3HaKMHkJ5JxgTHAjH4dpXWgTNxdhnl6EPeszcaojjDXlt2Hvi8wJVN06w6dWmqC0PiI6HVVvra2QPxCDN1w1Z+mcnKrPngFGRtJVHeUcBIBP6xANxs3TpCerW2rQIRI74i796AvczDHS6ayZxNYq1W6I/x6zu5wO4T+O/J5/a0WjjrF69bxcjcOlZiIZdeLUgeQjqwJb5FURCEoSJldT1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Xfa/JUJW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Xfa/JUJW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2X71Y8mz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:04:23 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso666974a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103061; x=1789707861; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
        b=Xfa/JUJWJkWwaJ68kxgPKJnjkBOf1gLqjtmGsLBxU/aAfMT3QUsFBRQz0Z0IqD4wqJ
         PhLn2pCV5vNfQztoD37g+K9OoQNx79bvkAhsItEJmd6QL5VYbl5a1YjdqUpJMHe47c9I
         7JWN6ppDTU8RnCZYYnw7aGj22rnmohJykYqmaZsfXIhSeE5O8UARtJHL6pWSTM4FQ259
         H0/VL35YgEXglW0jWVHZztguMc1wnlRm7IMjTdOOPoW9iGKPsFJxeKDfFtO1hZPkjnGm
         mbU1v2q8H3e0X1R0KchHa+dW8pAe/dCe6pJl+A3yx+T+8s2z40I6F7cDDkqPEY2EF6hM
         hNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103061; x=1789707861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
        b=ptvaPRs+yv4mWnQrJf0D4TV2VUYk4hwivfReSiGu+Y8qco/TTirKESoO3keUkUilOB
         c3ovTrazSAoB85zLQ1opjyaT5qdI4lsZ/HFqmcAEwUjAyGDzJUyq7q3DXrYXRA8jeoXj
         h5HXTDOE5p9oY2TmAia4SSE62hEKs7xJf9xQA2z5nFNzyU4xPnrjH0jyFG7/YkH7oRjR
         PVx598GYG5eLnUKleTu83ulDaveKZ4HQmg1uW5snkGfPsCFcGQutuabhXqcc6Dqq002T
         AZSfrNzxBzW8MTxPweyySrBo1eWlEUDgdRqA5ROCqGAhFTxCh45LrpDtt8xX3+WN0OGu
         ymaw==
X-Forwarded-Encrypted: i=1; AKwUvBzxXVHpUhr/AUOV//+o/fsdlqnviEDE4WrjhX3wDWQ6/dp88JCN0aWXDqyB3hwPIEuZ5gdIJKpHBZcQ9N8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mwxUaPcmOrHITLbDhYhN1B0uL1+KYPbNAFMKFv//gj6F+E9sxE
	ehvzxnfZ9zRymMRUXoEu9UGDzgnesFsDv8j/EjAxvyZzeijsIbefdvMk+2LHTRg4aWo=
X-Gm-Gg: AYBFou2Sf61CWo4TAjTRBChT4G65v78Yyx3apDjMiitkQJ010v/stpg2112lZ4VsPWh
	f+if13V2wfkKWu4kgtvhWHBPd9J+9cTGpE9FmfGTz8WG0ixOcIw5TsI0Lq/L+Jeh9Re5gi4I0uv
	onvtaElqE8Er9a/5xEFhADmNhp/UQTia92EZ910ujOrwumjw4Uo8xlEXdTDd3Fcwh/foY/Ht/Ls
	FWH0BANM0WO8ui1Sgoa4TlMp7d4qczqKVVMSs6Wp9doy7+cEsY3Dbmkr+aM+XIYtUs51wsGWscI
	GKeJglnOpMmieBWUE41ijZY9D+xNsCEoXVShjAC/qS0F09SZsqtK7QrKI9whEFR0BmlFHZKP43Q
	iDHHxFXSPyFJX5v0mZGSaiJ97AFiR4jXmSVGkjHVJlG5W8iIdeu/zZkjRlrov9avbCoN9dH7lLP
	1798OSOjD6P+w3GrYqhpymq8cW69yAOstwPPP5WBI3VY6xVwq7J0xVgz5FJnQu9i3UanQDls30z
	nvJgRFumA6tljJK4xxWzQ+73Vo96SehZADwUVde1yeOL3Q=
X-Received: by 2002:a17:90b:2549:b0:398:dcfe:967a with SMTP id 98e67ed59e1d1-39d9c227fc1mr3740017a91.17.1789103060720;
        Thu, 10 Sep 2026 22:04:20 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.04.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:04:20 -0700 (PDT)
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
Subject: [PATCH v3 11/11] Documentation/mm: update DAX vmemmap deduplication docs
Date: Fri, 11 Sep 2026 13:02:28 +0800
Message-ID: <20260911050228.58884-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260911050228.58884-1-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
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

Update the generic and powerpc documentation to describe the shared layout.
In the powerpc document, keep the radix and 64K-specific details, drop the
duplicated 4K PUD arithmetic, and replace the repeated device-dax diagrams
with a single parameterized PMD/PUD diagram.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng

v2:
- Clarify the commit message to state that the 4K PUD arithmetic is
  intentionally dropped reported by Sashiko.
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


