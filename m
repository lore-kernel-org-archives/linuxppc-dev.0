Return-Path: <linuxppc-dev+bounces-19936-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F84F94CDF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:14:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0sTR3HRTz2yqs;
	Wed, 22 Apr 2026 18:14:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776845691;
	cv=none; b=DVnc5OBJb7xwRbJZ5dlEvTa7jB5b/Ata1k2QOd5Kj0gr5qnrMvFLIsx12wo+u3KwdUWJgR0FPuYccKgM8qlh3+1pQobrYZFRVGs6LU91KEtCjCihQY7gUqSN5rNGPjk+x/3IkN2da4S3vx7c/x7DMJgSVFJCQEhNTt3NYor4MaPixLCDfmAkev4bRJ9p5EczaO5JvrwySxO48fETDr4sVP7uaL3UPX04YxmkdNxaJJwj6CYNJygusxhTHnOERQMFScA43GWdnYcFDepB7fJlekW2eHwCKNIidBIl8Gwn8A2gOX+AcnBwHQ1Qm487PQgS7zRo2nWDhZfmD2kInbhDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776845691; c=relaxed/relaxed;
	bh=Bl8Z+WQHqHX+qQjnRU0ICkmrP9C1SwKb8blByh5RwmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZN6A2ii8iym8aW+g2MoV+Y4oqO9iSp2q8XIzpSYUDC+w5EjJf/ZY10huMuENCpqH+gDoqQNWd7g3GwQ93exzuBPxTLbKfl10M+mCdd7/cK+5jmzS1mWioMxCgR8i/+DXrnQvID/FrDlRQ6Dba9FjtpKaYByrcbl0hp0/MhANnGuo3lfjTcfK+eNG67J9162C9A5PiybJjCiD7SGDhqeXyalGzfc0an39zYKJykQjJuc8+p0xcOpkBVRub72pNwoH0liEUbi4Xy2PQby1jqWCZZ53pHMQlA5+fZs/MFnn2Qkl0xnl5uR4qTeDV6rDWiQ2eknxifgXKR6Lv0ErbZ67Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KHjuJtM5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KHjuJtM5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0sTP3L1Zz2yql
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:14:46 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82fb2d0c5d1so2046051b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776845684; x=1777450484; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl8Z+WQHqHX+qQjnRU0ICkmrP9C1SwKb8blByh5RwmA=;
        b=KHjuJtM51qb86N3uHjMfPHjS/FfYlIyHdbGTojJLRk9fSsu+GVaFn7oYYdHtXHQFaO
         8uSEOnvVWp/p8cNqXPpi08Kj/PmvhJw7gFHVuEx0y5ZS3+cFUhGtYBEg/Z5c80ZXMT5E
         tubmVZLCnWIUBS3Li23GTIWI0hCyRlyb+QGGhsUaF2xaA5Hk2JUVsHtKd4AC9uOBV6zR
         D8TKFAe4qPrDh1cv7CbBzE6jMhHznlOznIewRfD3E0KAwg+q6MayQIXQFbMKvUfqQzc6
         fdQZgS5ATOHYRQco3xe00eMx/mo7UGrpnBz6GLgEsy757z7wH7l0qxJ6PBi3WcfbVsXR
         1ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845685; x=1777450485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl8Z+WQHqHX+qQjnRU0ICkmrP9C1SwKb8blByh5RwmA=;
        b=ostkc1AGMDFXGJ6RdwLDRGjw72Z7RPUZkPrTAZobjdp27G89uaLlO3gQTUfttPP3U6
         nXACr+suLIysRsd5mU2sM/ZsAeo2WnrrRpiAkgWVmsfqNNeXZbmQ+LQ/ULcl3D4G5Csu
         XS+UTU25p3lXxNqVSKuE3RyoH9p4r73D6U8qjxbEUg/BpSDc36CEdvV0VpuN7ZgiIgLz
         2s9fG+lgXbtsO6lfjypug09eWq6vaQcapP4PC+AW2yJEYzNEW3bl7c+83U60IOJT6/T0
         DnKyQvpsc7scxfontG67Idz43stPs0bTdHD53MoX3OcEjT7vNVzQbMg9gDBxcu1NFlFZ
         +8cw==
X-Forwarded-Encrypted: i=1; AFNElJ8UgvurvHXxSZJE5F7UM7th4c61hd3tOzpC3LU+Wj28cA7Piv4I76bLc3QEjHA9yfe5W/u/+KSYrrw1ojY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTmmim9esoPnuwiEWR4eR57QwWntew0DvNktO8dE8w9tzoCP1Y
	+KPgO7at4PhgzMvDPVpmVBLpSToeNvijE9JA1M5SVjXcY95bx0uF3PRVmpC9d0Qtgoo=
X-Gm-Gg: AeBDievlyjNRRv83Gc6OwoWq7VHWd6e/HsDZApURbW1bO6bxW2MUw1N3ygZuwO9Wo0A
	Yahw5gWL2rJUpZZMEx538FcDFX4ydZxtKNZuIRPTa6a0XZtvQdh+CuoeG0Se6PDKe2OxcN8XdGy
	5DwVejU5NJ51Y5zsVp8UeKBzCM0HOZKuvQgDdz4HkrM8Tm5pYc7XA99uogiGRJI0LtJVsLL3FIU
	F4hGjMttyA1oAvP4LbOt6R3kndJsFBNWktkxIDvLU7yPhUwFFlmGF2WJbWZk6XpcKP6RxKzETsN
	gpR2KFj71sKLqMl8vZlqBBsjh8uxZ/JUmVC8mfssjeyHCKoc7yD6O4v1Yc4yBKcuO3EltwbzcVd
	X4hxU90Tnejb/NZxNDKNWN8wS8PlICV9RD89vC/wbfHTtGyOjulxqpMareQoGqM4DDv0GYt30p9
	iOnmcBQrjl2D3BIj2YV47ZyTJ2fa+c
X-Received: by 2002:a05:6a00:a254:b0:82f:6d4a:df3e with SMTP id d2e1a72fcca58-82f8b32d44emr16671789b3a.5.1776845684472;
        Wed, 22 Apr 2026 01:14:44 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec0307esm16522874b3a.53.2026.04.22.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:14:43 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] mm: Fix vmemmap optimization accounting and initialization
Date: Wed, 22 Apr 2026 16:14:15 +0800
Message-Id: <20260422081420.4009847-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
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

The series fixes several bugs in vmemmap optimization, mainly around
incorrect page accounting and memmap initialization in DAX and memory
hotplug paths. It also fixes pageblock migratetype initialization and
struct page initialization for ZONE_DEVICE compound pages.

The first three patches fix vmemmap accounting issues. The first patch
fixes an accounting underflow in the section activation failure path.
The second patch passes pgmap through memory deactivation paths so the
teardown side can determine whether vmemmap optimization was in effect.
The third patch uses that information to account the optimized DAX
vmemmap size correctly.

The last two patches fix initialization issues in mm/mm_init. One makes
sure all pageblocks in ZONE_DEVICE compound pages get their migratetype
initialized. The other fixes a case where DAX memory hotplug reuses an
unoptimized early-section memmap while compound_nr_pages() still assumes
vmemmap optimization, leaving tail struct pages uninitialized.

v3 -> v4:
- Collect Acked-by and Reviewed-by tags from Oscar Salvador.
- Fix the build issue reported by Sashiko.
- Add a fix for uninitialized struct pages for ZONE_DEVICE, based on
  analysis from Sashiko and verified locally.

Muchun Song (5):
  mm/sparse-vmemmap: Fix vmemmap accounting underflow
  mm/sparse-vmemmap: Pass @pgmap argument to memory deactivation paths
  mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
  mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
  mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE

 arch/arm64/mm/mmu.c            |  5 +--
 arch/loongarch/mm/init.c       |  5 +--
 arch/powerpc/mm/mem.c          |  5 +--
 arch/riscv/mm/init.c           |  5 +--
 arch/s390/mm/init.c            |  5 +--
 arch/x86/mm/init_64.c          |  5 +--
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 13 ++++----
 mm/memremap.c                  |  4 +--
 mm/mm_init.c                   | 58 +++++++++++++++++++++++-----------
 mm/sparse-vmemmap.c            | 56 ++++++++++++++++++++++++--------
 11 files changed, 114 insertions(+), 55 deletions(-)

-- 
2.20.1


