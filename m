Return-Path: <linuxppc-dev+bounces-26712-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C571DC79F9F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:05:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf81b74Brz2yqd;
	Tue, 08 Sep 2026 13:04:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836691;
	cv=none; b=Wx1DTApHOVC/CwbwowKPoMd9ISq/nkOEOG8eg3tL3mNGma0ixVt83WuanozP4VLElUsMqOBByj68/5/KrayPzgZECBHK2gbWJwMF0F1oR5OLTcTq5C7f9vq9JFqqhza6Bid+E8eUIFK9uePxNG6ckdLvPIPPitbONl22sV3yQq922puwTWMkh4TzkEql99zSNpys3GLfIdWB+AEmKF/YWueqb6OOsomCveK1e0RTP4Fidb6suotIzfVF9BKYWfa64zbQW6xY7YaW7wtItiNbxT4vFseJ+WqZGr9oeWc1CoxtF3wIxAbS8gs2DqKAQ8jUR0OARlZebAHN4gxm/E6coQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836691; c=relaxed/relaxed;
	bh=IQIwuT52UGUULzXnvd9jyK7/apm1xntD2qx3gMLc028=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxDk9aQT7GKbkjsaEVc8/CCPWWToT5EE54GJW9Nbqpb3OeRuYHdSGc4nA0bOJ3rwNOcLfcUHxnUV/gZyICu+nshupY44lfmq/bQ0mU+MCQr8UTLRddSuqaTRMBbmgFzkmxVJQ5e3Vbb4ukuBmJTw6aiZHJQSmoCpm/ErqSjY61QM3xhPG6u2h7VFNGBRHtxhZvxJT16k+oRWyRYpS4y7aDhruTClXmoJUsCh/k67ipVRN5+V2E5S/KX6clMicePGeBmfrrxQbvG06l6lU4D0ulfRhqeVzmlMKxEFNBEG1kwBBO2A4CNC44eoTLGk+AhlIdMtzwHpWctc76UpVRJ8NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=h5sK3ahq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=h5sK3ahq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf81b1qyrz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:51 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso3021441b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836689; x=1789441489; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQIwuT52UGUULzXnvd9jyK7/apm1xntD2qx3gMLc028=;
        b=h5sK3ahqnrAChppWnzvSDF4jZV+DsCo6cWpj8s38J6H615SPmtxYv4PtNvJVrmDbal
         BddoDxOB4aHAHP6L7X1fU22sq0xD+aRmJelqOx+oAMge/y3B7jerCd76yc4qijKpMSBF
         /4rstMhkd6HJmaj7oOORnelZwsQd5SAbPW5s7dC6jjVrBEC9DSnPkV2Y2RxgJd67Py89
         opVFIbCpGIT5mWJTOOWNDsR4VujYseIlcTFiyMMAnO2uIMbKdLLcEYOuIwkzHGtLwJhT
         eDVUZM3YgKf+wM9a5Yisn9OfqLanp2XX4i2MRrlN6aNRKzkblfTS1qk3YuEmG1du+kGs
         2KYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836689; x=1789441489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQIwuT52UGUULzXnvd9jyK7/apm1xntD2qx3gMLc028=;
        b=NQ9XWKXH2EN6TIv7EbkhMNlARgwqT7pM4BN7SRZVAIg6th/hY9c7h1nySpEBwchZ8f
         vyAcevPBO5P1NCT5zXdzdCgd616gal75skQ4SI8c9F9VEgtPgJ9G+Hoqpv23gfuQZyhD
         kRJTDO0LZGO+0lTSuLRJ5crVQkp4Lhek7f89Z3dzgv/+XDCgyhogJ5kN8rnYP6gdOnAe
         2YMftXgjNBq/wy4FfgZKuze+2sZ6sddycr/ZO5m4TLgCsFHAOX4KEmO6S0ZTiSlrfwK1
         6Sxurado4mgqTTNeVjxI9qN5S/eOPzifpcWPc8eJEBlRx86Dvd42STBXXGRa6/IG6w+4
         PeSA==
X-Forwarded-Encrypted: i=1; AKwUvBzf03R1mfIAjG+nJqafH2z2alU2NVnwBlgkZ/9yDXcdE/J9WQO7H3Di5PCxXaWg4cAlNrpL0P3XLMdpYqQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mxfjXvbdzbfyjvle8suKi2xRmdCFQp4XeiltdYatSZOMIad06x
	GwDQJxJFLclNNK9Rwukovf/ujaj8hwn/xuHVzhbi+qfAJiItpUG2+TBMdRwATS4Sy8k=
X-Gm-Gg: AYBFou08jmGv20Iffb+C2RAtA8ReQ9qsz4Db50qpndZh1YGLEewjaMuAVmxz2ea8N4l
	E3ev9gvF+tP82TUr1XSCuiZbonZOawIKwVh+PhaD8CX1P15Hbl28rFaLfXzlPeVK7e0q/x9HV5w
	ItIWjAppqLaz8N1hcAg1rDxsh2D7DkzzInSwzMnkSpqAtCzyobHDNknY5q5F2wQ2mpvYXORpcQ2
	MCzMOkA6xgW8bLrEQGkAskvvR5n9OdBzad2jMOpCZGELN0xhGi49q7e0z7xQ2GKk0M3Ilw7j7WP
	ft78msN8LUx9hp2gpg1WUVACx5CiAwYCss6YPkaia9kjLWFd/1OobEYnzKZk8QpCgZ387YLlvN3
	4hralHw7hXGBOgOMkZc6muveVxSZDStzKxgTjp39mdV6Ho5PmJzgjfYMzD6j0VW7HiFXpY3zBNs
	XKgeIm1pgobn5oxdYtQeM+gCGdmSsVTczCufxE9kjrUEq7Eb6ACnfPgNZMHBWMbFo+0tmL+OtPA
	GgyXW4ec37T+SNyDe6HFbfhEArmWYjh1Jc=
X-Received: by 2002:a05:6a00:400e:b0:84e:e741:174f with SMTP id d2e1a72fcca58-861669c6df9mr39676733b3a.7.1788836688830;
        Mon, 07 Sep 2026 20:04:48 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.04.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:04:48 -0700 (PDT)
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
Subject: [PATCH v2 11/11] Documentation/mm: update DAX vmemmap deduplication docs
Date: Tue,  8 Sep 2026 11:03:35 +0800
Message-ID: <20260908030335.96549-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908030335.96549-1-songmuchun@bytedance.com>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
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
---
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


