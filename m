Return-Path: <linuxppc-dev+bounces-20221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8917CFF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 08:19:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4YHg72lYz2yhv;
	Tue, 28 Apr 2026 18:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777364351;
	cv=none; b=S4R1xSzMIqBYeQU03a7A3rzEHD0qxBGAmLNh8Myr9F3xWdS2hGqgTQPUJFLPgTfmM+JR6gzSnBPA8PlOR+IoAUtUuJ5rth0tMatlNnacBc4MHl5TdUvgH4ikTY5ZTyEjksm3+XYAtfFz/8ihEFL6xY5qLH82bZEQ+36SWZlCrsqME7HOlNeBBOC7tmfchopxfliurQ0BI+1Gc1ZC7Uf+rGVTTVBLW4pPa4NHftpztbFj7O1aR2cFPJM1kHAaF0Velf0nwusQiPRh2XFnCRGDwGXxTOcZa/eVmbePtpfBkgqcjzYVTLkgIoECWbhzcoM4W71TLtL9HG3keGgY2G/12w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777364351; c=relaxed/relaxed;
	bh=hoqV22eVCAsRVRHya4lFbLghj59bHdoGO9txDqRFMfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RE1EFELD6sd0ESb+AJEfQJKNx9ud/FSvXF84EnZkODOE+Eor8hXBDGVvhgMQztRZg4wynlAYZlpuckjSoo/CXbpa7mp8pbsraDNybsOtfBwYxUPsXMvNNgquzjlEkR75DH8xclLEZ6+dCKYpggQm/vNYHqEAGGWShywHTnSs2OQXA4KUb8sCEfd+fRVRFjjuz0EhMtvXoFKR6rKphs7ndHvBXe+Yf0otM+DrkvGzctG99p7civje3tvXMNYKxXQKzkC79FVtCQPuRvxBxt0nFED3YV1jnrLbr7xdwss1NYNi43mKZkAALQXKuknR3TLfSMgzv+gsIH/8JO3fdiyAnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KNvKkEjN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KNvKkEjN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4YHc64lKz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 18:19:06 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so9000968a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364344; x=1777969144; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoqV22eVCAsRVRHya4lFbLghj59bHdoGO9txDqRFMfw=;
        b=KNvKkEjN26/Eb4ATwkoaqedHFFvzWKNDdhLuTg40hLTPi87pdf8EqAaxxSYedQt44Y
         TUGhmhCUOsjAYnhavppJ1Cgu6vlgxwYsApK1VF5xg9I+wPbuvKpKDGdGOlW8RkBiAp64
         S0d12bEpTJTYzmzopyLwPPCCSVJML3QQltKXmVy834pvEhX6pKhNm6BcbCBHaFxbGZuO
         alJYCdJAicfIQwLJqC7VTRxZ755BpXhZGlkeZ+JxlRrO/SCspJ6gvKzYSbvsDWXd7co6
         d/5m1A9JCRZ2ujl26TuqykJevHHJWrD3ERUcb3i+zeL+alOfv6slIhx5WnXnlhpXOppk
         /g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364344; x=1777969144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoqV22eVCAsRVRHya4lFbLghj59bHdoGO9txDqRFMfw=;
        b=Mho7/bvbcRwJrH3LbTcYw66AKYKZiFBVAX2vOXQUv6yZxNtY3wCwnP/UBl4SsVejR7
         Rny2BtkL+As+2+8DlwO9smynQx74DSD7kAhj0HZUfwNPr1+aSLt3JjrPbvqG+v4JKeQh
         3QgwZJ4pJTLxugexH2jRm6eKA8pb7avry3CkXEboVUGUIKqSIzS6+PlYl7D2P4aaOp6S
         +/JEIch4qDPALWUa7JcHKsOjBYFY8xrICu+RHJDIDA0RXC0PSI0RZSfPIw26G91YBZ1o
         /hfX9M4a6CMVgEHwFB1tyoT4iFyaG2wiinG8OsIC2BBszk8AMKRxpycFBUyqAJXrVRjA
         11HA==
X-Forwarded-Encrypted: i=1; AFNElJ9uyq1uO7veyzfqZJNIDUtMaoJSMveXkwwCk65LjvYHTQqiqamle28tfMp2/dhQ8GwO4uDH0qJcmRwcGI0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtggDPkK5nCxsnsliuvC8yz7+zzbhqkMbGo+sBYXc+GkmIu/I2
	BtUDZKiVU8QByfoe466hxNaicRZJMhsY3LiTMu/4gyW1CoUJqxWC8lrKpiUEXU6kJUo=
X-Gm-Gg: AeBDievYO8WCKP2UYXwmcZlWAXoBrPFgutOGQ+yixAeQabf/PRWAUtEnaQQxujuwYV6
	90kJLgBVc9fd4ANs2H+S35qvSon5IX66r/9dgvfaTL3H3JcCYEz3EXiwMjM2zP1ToLgZ59NLx6i
	zkzyNQ9th2hMdnMidDE3hEmXwH92IcDW3amzYrFL0SwiTQkRVSVrUlB2kNtYZ78hAVgUjjcAeIg
	wp1JV62QkpdsXFqbWVmMntfySJcE6sOlHD3SrC0hgk3do1P3MT/qTUeJA5uNmsK37OOIz6hWobg
	hxcpkALYy66QqOKgo3ZhAFxgMKa/MFHoUp7i7bKAe9nWtKcYZA33iGZyIohOzf3IKoT/DgtvWgv
	4xUqiiJVySJrVC6dpZHnUtQ/6NSTyNzZrz8Dswn6XbxW2AlTwLDTBVXjXIdbEHTcwYoRHBjFIK2
	Oy2KUQ/pWsaTAS7/HygmmfgpSpbSAVOYtJOeZJ+G/+EsPW4FtSw0jdgLo=
X-Received: by 2002:a17:90a:d88f:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-36491fad396mr2247144a91.1.1777364343972;
        Tue, 28 Apr 2026 01:19:03 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:03 -0700 (PDT)
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
Subject: [PATCH v8 0/6] mm: Fix vmemmap optimization accounting and initialization
Date: Tue, 28 Apr 2026 16:18:49 +0800
Message-Id: <20260428081855.1249045-1-songmuchun@bytedance.com>
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

Patches 1-4 fix vmemmap accounting issues. Patch 1 fixes an accounting
underflow in the section activation failure path by moving vmemmap page
accounting into the lower-level allocation and freeing helpers. Patch 2
fixes incorrect altmap passing in the memory hotplug error path. Patch 3
passes pgmap through memory deactivation paths so the teardown side can
determine whether vmemmap optimization was in effect. Patch 4 uses that
information to account the optimized DAX vmemmap size correctly.

Patches 5-6 fix initialization issues in mm/mm_init. One makes sure all
pageblocks in ZONE_DEVICE compound pages get their migratetype
initialized. The other fixes a case where DAX memory hotplug reuses an
unoptimized early-section memmap while compound_nr_pages() still assumes
vmemmap optimization, leaving tail struct pages uninitialized.

Changes in v8:
- In patch 4, move VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION) to the
  top of section_nr_vmemmap_pages().
- In patch 4, add Acked-by from David Hildenbrand.

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
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 13 ++++----
 mm/memremap.c                  |  4 +--
 mm/mm_init.c                   | 47 ++++++++++++++++-----------
 mm/sparse-vmemmap.c            | 58 ++++++++++++++++++++++++++--------
 11 files changed, 105 insertions(+), 55 deletions(-)


base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
-- 
2.20.1


