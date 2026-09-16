Return-Path: <linuxppc-dev+bounces-27468-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37657C88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8Wg3msrz3blB;
	Wed, 16 Sep 2026 16:44:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.227.153
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541087;
	cv=none; b=RtMpSqdL5mkV93Gb4ORL8HO8VuEfTqeaXxoI4XrSxkxGvOrZ61SLEE/ehnar24o/23Znr6CKmtsRmf+Wl0rPwVWS/NvhH/8sE2RTzSnh837DRnD4CsvO2GxfweM9keC3TOOXAcmeT6vjOdi/NlI67uBKIr8X0rfOw4xTgLAXN/EyYtx41Kogg4GY6fcaukBufEJqM0yqVcN0Z4ufp8B8DxRVrEtEZTD1jQvCc8P9XKQSq+n3lSc8ZvJoGaEzILIsVh4bXhix1iCJNtJk4GJKmFuAt/HKtMNBD0tJ4RfpWHr02ZZw7cQ3rAzv5FjPLAJW03WI4gbrUtBf7BjCm5beLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541087; c=relaxed/relaxed;
	bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bApAm7XlWHFYUoj5Nyg5G+rmNui5vFDwIQjBk/q2Iew4c9mQBPgTHSrZ/KrhRnn4m4+wfMjLopYFF0xGop/GE7E4zufcU+4YKIsxTPQNtf6gudKLBu3plV72acfFtE8pxXYH5caDHz/s+H2Yhk/sX4H9AJ29mOmw3jbbMWpGEULGzgOKEkOHIQmvKtCAoTIo1wO61sQbl+z0R30x2l3htrEWOG9jpp6+B9xjRJVk8It5pG+ZQoOJIIXrQtyLB5FPTkRzpVf4jIlz+TCM2RHlFWgl5Zva4u+6omqT6C1npFYWELnOqYQAZ4bbJOQ7QbCTBUBhvNfWd5O2giFyb7i6Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=e4wFvVod; dkim-atps=neutral; spf=pass (client-ip=74.125.227.153; helo=mail-pj2-f25.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=e4wFvVod;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=74.125.227.153; helo=mail-pj2-f25.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com [74.125.227.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8Wf5L8jz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:46 +1000 (AEST)
Received: by mail-pj2-f25.google.com with SMTP id d9443c01a7336-2dd4b43b20bso3753935ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541084; x=1790145884; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
        b=e4wFvVodylFsC7EQVUsVP8ee1iCO3da2pX480sknVOu/N9RrHQiBAVhsbR6lb6y1rI
         3NzyvVqe/SQ16yLjCWpry90Q9Smkm0z8fI43M0/rcta4LQfEvjrv0ShNUwl0lo+KL6xt
         Yrrxen4r2egm8lOSwAJsEBOOeiJ4fvZk5eNkI9Uq/SB7pLgXj/p29aMvo5PqhzPIatoL
         GJpY5inoGDrKI05vCxXZxzkPrgcRvd/dGj30h+/6k1/gOZT+S6zecMlWo34WtEgcNsdP
         QqSKM0NEeAWQ25jI/IYxE/vUkQEgsFiGf0lnwCIRNZk1iJ6KSJyjAG4LtrZW8ljNfQ3Q
         2HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541084; x=1790145884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
        b=LvNKZdXtaJyiYtnE579F7wJ/wW8SnMFtzmMOjkLT8hK/fjlVv1viUmkXIsAyIwnceh
         mNSKRWAcjcayb/jojo9Z/h8ghlM8CGtGNsv8HL/QyJ7mcr+pXa++D/E7Ne0dVhzeDxR9
         4CSYpp9NACZ/GgCP6kAzNgCHKhSeqZkL8SDaIkddHz53h7/VXfD2h/NOvAaGdmS2I/ET
         OEwEDKDIPTBmSdWwymUl7UqqRIdYhM98HdNfMGs8J0RToOP2QVdzZ7MNQaySrEZOaPml
         BlNcuAaxoNf9JFJpINzPnXQnmTfOkTuAaSbdgvEiNlaxuQ4bIcKeQsrIS+jBC3ca8M7F
         O7gQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWd8kZfyiPMBLwtpzStgC61Nng3xS0kN9wammYd1ROz8GsuldcCU8qPcNWv/87cGPxXY/JW6iw3yN93gA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nJkRjhEUyGJilsHjd/gHVfIvOhDsAJGGd1+85BzR2H5cFgxgN+
	BVcGlHw9AVkMkwtyOYeXvhtgG9DXOKC8uCNcyUHofFHPUfawy2z/ww8zB24P0opCTqY=
X-Gm-Gg: AYBFou14ElVARXHLkrRsQyN6LNggXXgSqG3wIuNQpzODxJwaPmnyXCNnTLLusQqqFQs
	vkqI05fncFH1J7U0GRq2dUDYdpEzl4n7Uz8zGPoYOsYOzAS9gNBC/hybAyM6lLSQ526qRBwftrI
	gS46txCu7DTsiOuVoyzt3WhJW4JP46mjlHp9a99iasrpYsNXGssclszwT8HE+lquf/HiXmMi5Qg
	1vRQGqk8lkOihD6vA3eGTOAYn5ASBinYdS/5AiOuktkjT81l1mJ6DhwnVQ+PO1BuD182B1tCWus
	Vt8kBOXegEuy9miBY3RA9o87+frfQ1ADvNuBptAgmh0couHM0ZlkfAEFtsdNsccrd8lY4/I1c1u
	7hVlRAG7OuGBXYiYVHE+t1yNY/5+v8pkxt1c8i8xWfudSwroZc0/+aXqKmv1t6KD0yj3BBfcyic
	4LS+aXaXqzT4y+mi3B5W7aUHyxHt1CSUdVyhHsvDVGi1vguU6hMfXImM+eEG+H155DaZVu7vF9/
	Zbg4xBYEbSN4UIaCII=
X-Received: by 2002:a17:902:f547:b0:2d8:df44:a5c2 with SMTP id d9443c01a7336-2dd8e766fd2mr29327755ad.20.1789541084051;
        Tue, 15 Sep 2026 23:44:44 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:43 -0700 (PDT)
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
Subject: [PATCH v4 11/11] Documentation/mm: update DAX vmemmap deduplication docs
Date: Wed, 16 Sep 2026 14:43:41 +0800
Message-ID: <20260916064341.1825793-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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


