Return-Path: <linuxppc-dev+bounces-19992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA33F99340
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:19:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1SC360p9z2xb3;
	Thu, 23 Apr 2026 17:19:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776928767;
	cv=none; b=KJSrwM833uH7NT7kITIYTZq9nJzUefFuaAbXKKkAY7rIpspcqE2qvoQEg52YSLrERKnxk6j1qwd1b+eNP1UigCI0uU7rK3ySW+Akpjual3zAWjGRymAJJK+kD6kQkbDDWs3xgDfc86xuEFggBZy8Af12vvIELswXNuoXPnkLKn05JgpOBPV+WXTp+TWlkjCkErRNBP3BBgKG5i63vlqU8XCNy5ODtPy9vZe1K1G5Xx6xITx9rYU3+3YZERXqMYdlUKSfREFJQV5VF0nCdpU8mEQrTtz+QC+U9ttDjhPR6eid8j+WJa3WHHjrmw4G3L4ILbYP1bglLergGKdwzE+3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776928767; c=relaxed/relaxed;
	bh=b5ucw1jsaiC+LU7Zn1moEYy2AT2i3WtwhP+YNxCDsCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADc0IYZc9MMla5lmEWbmvVBUwYo3zoCvNMcEw8BN3215YHEfVg/oEw15fIcweicwc6Y0Lne7ROZLb8hm+XBCa5280LCFDOzIEXCeF7CD+d11UFKpxvz/UHn50SDv/96rJ6j1OMl5ENql5OEKAuJcWcP3d2uC+GA/dxZpWkWRrCd4E3Ry3rZTwXRBuoYk8WqT+4AhhsLIM6rWvkOLG2sroGf6Kl1bWqIGCLjQ6MySZi8E1QK9ON5BvPKwYsHrHwGcjBPji6S20iwcGkRHP4eQ8vZA4Xc/R789fT0K2yJT+b14PT9itPJcx6joMu5wAYtaeJ7qvjlFm3G6DCleQwnbmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=l2bCuTvi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=l2bCuTvi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1SC14dvFz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 17:19:24 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so7124995a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 00:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776928761; x=1777533561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5ucw1jsaiC+LU7Zn1moEYy2AT2i3WtwhP+YNxCDsCQ=;
        b=l2bCuTviSkwS8hYpIPV/wwZnWwEq01TcxoFbmTVeZHQfxnNfBDshpWfKpepd+hGrxO
         /xNayfOtV45OhOa5KhgjOEPgItZ2KxHOpuly74gZxWovNQLMl/pY75CgtQ57nRU1BMD2
         1ItAvqq16Ug37fEEfDB1jB7flfJg1xFhdk0t3VHEMh3yqEovH/UjA9gVfryKZ2mJFQGL
         stVIJl9uyx1gxnZnWHTjWAPLdOh0sWrckrEmQzxYsafPK9q8u7RLoLIUiLUHLgReK6+y
         6zyGbqjnXg+nrUN2cJdzIBs9d6f1QUNJE/iKEW78f/oxW0aMdInPUIWREFDBcIsP1E9b
         lwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928761; x=1777533561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5ucw1jsaiC+LU7Zn1moEYy2AT2i3WtwhP+YNxCDsCQ=;
        b=KsSF9kQ0kHFnqux2rlZyEVYUKedNEZQGwpT6xXWnPrBf/Di2oIgt90Kb5Z25pR+OIW
         oQU3QdPk3/pPkdGn1nPkmHvgtBrzmIabwgOykGsSFaNw3atsxKnkuinFVvIUbB5jlHlZ
         vm6anf1g+vNT98uMnUT1ZrBaUJ21VlAX35uk27dch0FhuZ4cbMAvoL3/Gx3RrAhgUJ/q
         A5V2cHhYPXDoi3JZNyrg8zjzilrEIURjQKIaX2CZlUpfr6AtGEnz+Zx5d3b75zUoC+sU
         0ZRMmXAOysNqpav4uySYH0CT3xV/8I2dhQXGTkRrbT/otFGHKGV0mXRFM6IYLitykMCo
         /LAg==
X-Forwarded-Encrypted: i=1; AFNElJ/FBkCk/Gld4FIOcf3ogIUkXqOfHX76WtW3vyKEb3ARIkhLfruEVwMSu244DT+oj+TpBaldwwE80sHlfkY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwIIsIDZlfdyjbwtylBuP9MgBBzygCfUMA1OJHo2UcEguNhsasv
	ub68Qgc5jo2eK2zrr6diB1xKwlknfARu9dIIilG1Z8bWub81DuAsvYmbrZMySVaI4F0=
X-Gm-Gg: AeBDieueUXKiLpveUVTRSCWt+AkkK9XsnUN398/xWLNt8v5t5yR3tQ8l7vF0UERDhkh
	ZAwiFUQlyc6Lcys2NwoLWDgEjvWdFzYkW+PpVn4/9+O6w0aCBsy6jcycg89mRXmTikWHS3oCWsa
	tYXRN/tPRM0zRc0mZIcFW3RfoAUj0bgp2mCalIGGgQ0/+o1Vs38GMdNRsIOqvWj58EnAbnxR4/Q
	l/YDqv3HZ1czcmLAAyawZDEHTn7I67H6c8zul6T25q9+C/UIWCUrSAo7CX7yPFgsnUAy2d2efYp
	Csfpo7FfRMFJTiOCyijpEozkbf492e6FmMcjVUIUhszkxqQUxSkw4IXNtWbsAbOC4gLqfa1lLVp
	G5b+ErcsXATHZkEJGOCtnPzsCqt6J8ENOWvFJaZyJTHxdQ2q6a+S6ZY6t380achJrgD8oD4PPnI
	Am7QzVp76mHAfJez/J4UneBlEI70iKABaLGwrodWCkXro7EZk+ktC8VA==
X-Received: by 2002:a17:90b:5543:b0:35f:b227:db86 with SMTP id 98e67ed59e1d1-361403af6a5mr26477355a91.2.1776928761356;
        Thu, 23 Apr 2026 00:19:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbd970fsm7092372a91.14.2026.04.23.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:19:20 -0700 (PDT)
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
Subject: [PATCH v5 0/6] mm: fix vmemmap optimization accounting and initialization
Date: Thu, 23 Apr 2026 15:19:05 +0800
Message-Id: <20260423071911.1962859-1-songmuchun@bytedance.com>
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

The first four patches fix vmemmap accounting issues. The first patch
fixes an accounting underflow in the section activation failure path.
The second patch fixes incorrect altmap passing in the error path.
The third patch passes pgmap through memory deactivation paths so the
teardown side can determine whether vmemmap optimization was in effect.
The fourth patch uses that information to account the optimized DAX
vmemmap size correctly.

The last two patches fix initialization issues in mm/mm_init. One makes
sure all pageblocks in ZONE_DEVICE compound pages get their migratetype
initialized. The other fixes a case where DAX memory hotplug reuses an
unoptimized early-section memmap while compound_nr_pages() still assumes
vmemmap optimization, leaving tail struct pages uninitialized.

Changelog:
v4 -> v5:
- mm/memory_hotplug: Fix incorrect altmap passing in error path (new bugfix
  suggested by Sashiko).
- mm/sparse-vmemmap: Rename section_vmemmap_pages() to
  section_nr_vmemmap_pages() and use two-tab indent (suggested by David).
- mm/sparse-vmemmap: Use 1UL for pages_per_compound and use const for
  order and pages_per_compound (suggested by David).
- mm/sparse-vmemmap: Simplify VM_WARN_ON_ONCE checks for better readability
  (suggested by David).
- mm/mm_init: Use two-tab indent and const for @end in
  pageblock_migratetype_init_range() (suggested by David).
- Collect Acked-by tags from David.

Muchun Song (6):
  mm/sparse-vmemmap: Fix vmemmap accounting underflow
  mm/memory_hotplug: Fix incorrect altmap passing in error path
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
 include/linux/memory_hotplug.h |  6 +--
 mm/memory_hotplug.c            | 15 ++++----
 mm/memremap.c                  |  4 +-
 mm/mm_init.c                   | 34 +++++++++-------
 mm/sparse-vmemmap.c            | 37 ++++++++++++++----
 11 files changed, 81 insertions(+), 45 deletions(-)

-- 
2.20.1

