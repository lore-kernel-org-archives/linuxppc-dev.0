Return-Path: <linuxppc-dev+bounces-28572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E857CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:09:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxjl2VNnz30DH;
	Thu, 01 Oct 2026 00:08:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777339;
	cv=none; b=UnHTvXA9Z0vZIcJJqXH0J5Q6aReaWxBanYpGHx2awLocJP890Ic0W60wa18aIFwIKKeb/slCAxnvBJy23sbq+C71lxYlOK84Pz3+rshMsmTBVuiFEL0Fg6OgYbr2ETqyTqMbsqehxgIbHzsrqJAs3UB89cH5Mrn+4dAOnQ5wqEL3lKRvv/AE6+GsEW7hJWNxseXyjMqdY5I+HiKkoyWMQfNcfJIaqMA4YbEmIlINiGKTgX4QsipYEO9z47XZvTWfg/hKpmnTBVp0DF4bSxwbX9HWm8MsEj+T0U6MgPStR7EkfiI7VJYd2Cgv5NpZcEQvLabB+zChPE2lcYx8QQ9dcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777339; c=relaxed/relaxed;
	bh=wFs7N1zg+/ZEZHxojTsBYZG7Bu1MLCx/OGkj1iEK8Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al4//pIrk4lF/bezTDYgaijPitsCEI+SxUAsBV1Q3C4CGUGo10EDTazmMucVUPAhvhoT7EenvT1SoWZ1e1xcjFOjDe/GMSEdnqe2vMvg8XVVw2Hbx2elVBkoQrOovd25Hib16bEdRmhd7JwEGdz79zH/o5ALwOGremsjVRODVmjxvBebYaxGmegAY6TaaDyYTFnhsXI+rx58qJhQwgdDgCfrdhazupfIcmC2cCgRgVxrYmpZsW1dmD9nvV86O5D8eUd7/QKZQHVRtjiGU07QTwL9j6HqWNyR4p1FQRHxe/e5VqVc889e4VpFh0E9Zr9q8gIPDFzNDl/Ad2B5Jucs5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=RUrWckaD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=RUrWckaD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com [IPv6:2607:f8b0:4864:39::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxjk4MMdz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:08:58 +1000 (AEST)
Received: by mail-pj2-x0c.google.com with SMTP id 98e67ed59e1d1-3a0f64df6a6so2112254a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777337; x=1791382137; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFs7N1zg+/ZEZHxojTsBYZG7Bu1MLCx/OGkj1iEK8Us=;
        b=RUrWckaDF2t+hGCPa/ASA7jIOeah9hljYTIbxEhQSXp/lVYsnCJD7Sst3IUU5fJCfb
         INcCGP5YDkYlMWoILmzKxX8ugFCfV+7MNb0wJ+RThpnZ/8ISCIal67I3MdgW4HqDxubw
         SVajUtihjAgRsK8MSw/tAZFGjyqd5hdp4lR8ze03mfRGBu9zj+oTBVrjKgjVoaltJLA1
         fvmEDZSb5YK6V8uvWe2lgOrOOLK9dAeQJAZbqBJiwq/KfyGzz/W7F0GeU62ZzL2j9NDn
         igSFWkZnkaxNoz3uk7vDSXJKm7LUOHWdbT+sDy8NWZKSPZESW5OrbyltpUoP+ba2IlUB
         2PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777337; x=1791382137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFs7N1zg+/ZEZHxojTsBYZG7Bu1MLCx/OGkj1iEK8Us=;
        b=VA7hTsMzVxmkZucKA3TEFgihbJaATxEoyrNF31U3zN1UExucjDv/BMP3YsV10Vf0/g
         2B6ZRYoRFfNaStS1FvpUtpAv2tNtcoI8p1h9ZMs6HUDJnHC5DXQTk6Qt2+oItPWtxdBU
         /6Gt70wm/HhgiSBXfxnftHGdCfZiA2ye0C9FMLere1N+PNRbqXdl73XPbpDFxyJdJzVG
         HI6LOQFSEfGwu6C1WYGxtLnfy69d5V2t1kIXzBirz/Izfbaf1wmqdbwR2Pm5GuoKMrI8
         o3KPjNY1SJfzUpAMxaWv/jusqNpf/v5UJ3aqV3FKYPxa6eNMZ2GTDgdH3OzRBvlQU9L7
         8LyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM6P4/TSDyLWlkGyriqQhSW8uJbvG/2nnUElbkqF34CIcWQylC77I/gTXmAu4AJkKZyg8wQnsQVCcDzEE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKGOi2DBuyUTKUL0e30ilI1w0Q2q116EoH/n7rIs3vtKPNXjqlW
	M3rEtd0opliz5H1ICDVyD/GPRaQbAHM885LnTmTi8iHPsIXe4UihlDJZAsr8RDiVX4I=
X-Gm-Gg: AYBFou1HrRzFybrHgN9+QxsPJ5NsXWOnqS+9lA/H2v+77PmVL3NNN4MsoerBROc3PBN
	1EPDL9SDhvC9A3oUpo2kfu+qPG0Q3jJubZo3jSDe1d2O5j3Rg31lGciGrtwFS8M0cqg4vvT/9pY
	qns+KxQoQUWGZthdpJsReCHqnvpRnuu9lfReV0QX2CylIIBNeKrR2yA9Cr2qrMkZxAIh1ZjM/uN
	Zyx8Jnmwn3Y5bzyxhLrQNbwdj45ejZyKmYJtbW61b7Yia+gWI3LegpJoHZDMjXANWRGbiUP1gkZ
	emjg7VTH8Y0HANln60XsZGRSEv57yV8s0ziS1UbtKgizlGY2WAuyp8q40Kg39DuGpIzho6GELgE
	quGHHMaNWRyrdMQFnkqkBuVxzkXhfrLNw0ZDdg5IdFdLx1iOkDO6mRGgvIliF4odCqQ3vVW9BSu
	3QFN25etgePEZhPCPBC/uUQSVQuTxrJHWbRBha8mIRJHUJ1FkNBE/UTq6xlcc8e8G1dQ61e+8kn
	wycGXk3BdiE6V8hkFAA06H8
X-Received: by 2002:a17:90b:3ccb:b0:39e:6a80:b796 with SMTP id 98e67ed59e1d1-3a4d18c4d32mr1414859a91.38.1790777336778;
        Wed, 30 Sep 2026 07:08:56 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.08.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:08:55 -0700 (PDT)
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
Subject: [PATCH v6 12/12] Documentation/mm: update DAX vmemmap deduplication docs
Date: Wed, 30 Sep 2026 22:06:27 +0800
Message-ID: <20260930140627.57431-13-songmuchun@bytedance.com>
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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v6:
- Collect Acked-by from David Hildenbrand

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


