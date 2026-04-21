Return-Path: <linuxppc-dev+bounces-19857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1702F5A8A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 02:21:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g05gs36nNz2xc8;
	Tue, 21 Apr 2026 12:21:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776738073;
	cv=none; b=fo+rRmAZoly+Ly2qnYVygigcuZ6DjDZOUfFbLrb/5Qak+Cb+bVRd1s0X61D48zoSUiB8prW6bmegOI5BGrKaV8k+EOx3btdH9P8tMt7AyAVBAgzzY9sDVMKKVe8EwaZs9FdCKAg7+33H5e64okjFsoWPyw7SRJSC1UlXVy1lXplDy8ySui4mz4Obvzm2TjY3rbGUnCKb+ZdZrGXJOf1OZxUb16nsKSIBqyaKGr/rauF6wYYxjYMjwLRL1WTNhCxHCDQnyS1vHZuwOblrGbSgOAY6UPXSo1IuvRwO/yjs0JxQ5JDebCcjWgPSUpmuy/E+vGs3coHrypAg11N4HTMTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776738073; c=relaxed/relaxed;
	bh=qcnAylFtx6soM7u98F+sq6AMHsS/6wPy1LO+T0Gz9iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LNFBUTNYaVz7La2RyFoTyJpcJQX3P8a0wGD8ttaYHmDvF8iCGjfLggJu6nz6WbNSaON/rUCNJjHRA4j/mEPlZ0kNKJsc8LCiglnteQbGemJAkJmyzv5LUW7OD/i+XnfaL3Ylej3PcroxfNqabu+4hHyDhzFHFSECrXMJ8k67f6blWILVckuEOUP5kaC8tGcdxxyYYnjq6k/JwgjmabDtE9l61DmYDuPbJbNI1ISIX7SThx9STwvyT+kJUhN4aV+WG4eIAwr8orjZzRlhMlZKrgz5y83VpPWYIXHeUMJT+nHFzU1biLPff1YlXAsrjqhcu8CeMfuj/NQc1F3h58tnNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AZvTr4q6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AZvTr4q6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g05gq2sR7z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 12:21:10 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c795f441ff7so2611593a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 19:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776738069; x=1777342869; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcnAylFtx6soM7u98F+sq6AMHsS/6wPy1LO+T0Gz9iU=;
        b=AZvTr4q6OJ5amo6AG+aN/6zYXLYX9kI5ygR0wQr7XH9JsHQ3Qg1lfyRPJRJ9DxFB6+
         Q9+CcTWrv47luqrq8oJyYVlhxV9CezkEGWHryEGJ2loqDqDC/D1rMf4HsROfHcpZ0sMl
         AQwgpt2LnOV9Ouo1N7wmYTyEPVOUsSzSFRv8mZSc8b2vS2HhHcVhknsp8w+63jPXaho5
         ++yq4z4gOZW8HGQZzXX/CtK+QFnUVEhvYTe0qOSJb2ft+HMtvGp19cFOdWK4KY3c1+6/
         NIY3/8wzzL8Jktf+6FtXVjKienkY/vE5s3AfXPLhHB7QxjNOixOZX4nu/PwqBClcvO2s
         nP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738069; x=1777342869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcnAylFtx6soM7u98F+sq6AMHsS/6wPy1LO+T0Gz9iU=;
        b=IJ4u3nAWxN3zUZAW37WCLBAT2HhXzVpKCtWsyLH6CnxwcDbGeWhRQogvH1Q/ghdux6
         kVY6E0kARgoK40kMLdcVk7MXirwfgdubbLg/w1SyseeRAUS3t42MVxQOpXyaXenNur9d
         S3yYicsg708cEDgoaOKhMfOS1+kOmjXo6GQ/B/T+OG4i4mQg2A+DUicLVF2wHt6+dxxG
         k1qKh4VBUWMfb/HXw4XvJ219wsRFqySmgwNc29RoznuPvfHXDYwryH1OoiBukxs6W7Ot
         gm9BRBe6tkrOVx5fLNDZNr2jEGoFwAWK5YIyobJ/l7e2vX265ABTwmeGKuLT2WZZu8T7
         15+A==
X-Forwarded-Encrypted: i=1; AFNElJ/Aj6VQHs1onWc9BVoVNQiMdrk3GbFrvrEPioYkHzlSgJdrF3h0C+KAgbUiFS3Tjc7aJyWpH7YJSObJOns=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYojwsVM028IvjezPM6wBDGOsWwVrfFAp7esNhYhpGz4C2Vy3q
	JJkxhwuHvLNu0yS1WAQV/4MqXa7tKwHPsusQkCcbxNz5LUk9uZK8u2cqN6OcX1ATgfY=
X-Gm-Gg: AeBDiesVeTg1mvmaoo3R8u10cabWJHuJXaGMuzBxRNwNqVSJ4Z+xQ9ZXnOhyggTtB73
	Pv9qXr8PTlpFRQvHOtV0nRJgG4VA9wlrrf9/CFyhQaO33MKzgDUVPUpurxzE4cM+UElp2IjP+8Q
	tZ+H2ahQ3F5zyuVttBPVShRzyN0jic8IkGehG/VuRTAOhYAbi4f0Km6ztzD0XIGeAriXy35cHR2
	rGfhOMkflY8BTeFu518ScZ4GtMUZrZySwllEc/DHoM8Qsr/tyoTSlPebtXW/w0nzrhKEdmSK+vY
	UZBU3kOI5B6hU9Me4AfoUOp8Aql5komaOLTFRZQXUx/Vbd46w0xSHOPQ2XiFV/2wFG2qsOAk7yC
	H6+brGjxQVMJoV8cpNPwWu1hJuoHMOUwn38TiaHKSIfTNLmekZlc1L+zRyXm8Qq2RAIcXk/XZqx
	IrAqgCV/yegp669kF1fWszzcZ7hPka
X-Received: by 2002:a05:6a20:9191:b0:39f:5671:921 with SMTP id adf61e73a8af0-3a08d6eb3f9mr19080715637.3.1776738068373;
        Mon, 20 Apr 2026 19:21:08 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::340])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f932dabd4sm11538780b3a.51.2026.04.20.19.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:21:07 -0700 (PDT)
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
Subject: [PATCH v3 0/4] mm: Fix vmemmap optimization accounting and initialization
Date: Tue, 21 Apr 2026 10:20:40 +0800
Message-Id: <20260421022044.1217503-1-songmuchun@bytedance.com>
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

The series fixes several bugs in vmemmap optimization, mainly about incorrect
page accounting when vmemmap optimization is enabled for DAX and memory
hotplug paths. Also fixes the pageblock migratetype initialization for
ZONE_DEVICE compound pages.

v2 -> v3:
- Drop patch 4 and patch 5 from v2 since the page table sync issue has
  already been fixed by Harry's series.
- [Patch 1]: Remove an unintentionally left line.
- [Patch 4 (previously Patch 6)]: Call cond_resched() every
  PAGES_PER_SECTION instead of every compound page, as suggested by
  Mike Rapoport.
- Collect Acked-by and Reviewed-by tags from Mike Rapoport.

Muchun Song (4):
  mm/sparse-vmemmap: Fix vmemmap accounting underflow
  mm/sparse-vmemmap: Pass @pgmap argument to memory deactivation paths
  mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
  mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages

 arch/arm64/mm/mmu.c            |  5 +--
 arch/loongarch/mm/init.c       |  5 +--
 arch/powerpc/mm/mem.c          |  5 +--
 arch/riscv/mm/init.c           |  5 +--
 arch/s390/mm/init.c            |  5 +--
 arch/x86/mm/init_64.c          |  5 +--
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 12 +++----
 mm/memremap.c                  |  4 +--
 mm/mm_init.c                   | 43 +++++++++++++++---------
 mm/sparse-vmemmap.c            | 61 +++++++++++++++++++++++++---------
 11 files changed, 104 insertions(+), 54 deletions(-)

-- 
2.20.1

