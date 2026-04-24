Return-Path: <linuxppc-dev+bounces-20026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6910BF589DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 02:56:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1yJg2CQVz2xZK;
	Fri, 24 Apr 2026 12:56:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776999363;
	cv=none; b=d+OWyhSPfNSgrWXAgO5A0Q5t+K7HHSgFUhEHg8/gdyU69n/ZnLORmgJ5rTEna6wZ1exhhjklFqrHEssRg81eXL2lpKwgyx28Y4D8PHC9Oezqkr9mDwfQognAIm7PhGMswri7udjdvPjw3IhD3Fcrh6uZbTwL3TcUXo2u4YWC/6bNF/lJ8EXqkeQO3SXzvfHmO7JYNPPlNlsPt5LBXDTSLeIkFl+MrW6k+VhDKT8C0Da7a+KADdYyIio2X91hdUnUK6dwS6hrDDkJpucpMRXaP7ehG/g7w0A7Kq3UKfDDw2G9Y7wJdz+304T0jYjT8ketR4prYeC9Rwsxikj8pzgVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776999363; c=relaxed/relaxed;
	bh=VibxaiS1l+eDrVhbcfHr3+QWAZVT1Pa0QhMNfP1+esY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WsOjcKmkKQw7bW3FOZz6WeEpkYKARoIewwxEtG7syRLDBamxqM0/Ml4dgHJ1e0+ZUwjpK6KqQizUqknpr4EINeVe3jSo8OKvrOktM8Se+vu5hCD4CSPgiNaWsRT3D8aRtpoz2KTes0MhdJg9CgRVKckFkCTDvmSApudoiND/FX2cMmotLLaCr1Y+hwUoiQBnX4uPjZw8pjK5y2DcNY97/RRIeeU0Rc0TY4PmVGO6Oey2Zvh8UiUONrGEDXv6jrKBHxpPMmXz+PQ1nw6oMjkqxxdc1rySO/kl8mBmLbTNO1YThr02c/FstgM5VaqQ76tNoa6aP6sCtZw34/0s/+DQxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=euue1h2+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=euue1h2+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1yJc2QMlz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 12:55:58 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ab232cc803so35763555ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999356; x=1777604156; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VibxaiS1l+eDrVhbcfHr3+QWAZVT1Pa0QhMNfP1+esY=;
        b=euue1h2+h+ysGcx6eQpPn3dccXfbmkeMcUSLwqilq+6orTpAnqFufQclUOkqz+aNyA
         e2i4oIZwhNphhKwwX+GFfDXPutqnDW6Ln02k9hVKcqNqRcdQu4TNXEZRa7KjmmyuO6jk
         w6lkjGejTo6tekevDAkgKyLoQSmDweZ620PaRpnpK02ifZOIEphWk/22s1j3NEMPSrEV
         OyEeT81QoR/6QoGVmcRAp3G6LYBWJWEwROrpB+oR5vzUSQFfV1DAoS2d/jad8JbJRKAb
         c5tHfI9rOnT4DbY2A6tHr4d1fQbBGkyfRfsQuCDNU7KOHN4HX90Dp4NH8b2vOWK7pF1e
         L0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999356; x=1777604156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VibxaiS1l+eDrVhbcfHr3+QWAZVT1Pa0QhMNfP1+esY=;
        b=XMGiCl6iiGpSyWICIvHGaaBH+SVAeJnclkbuINRZ5IhgFZwVyvku1JAatFQXZjLPkX
         y+wyaLcOzA29afWMa+8bvmw43ByHi8MRT4iEWFlFZ20UVjNe2Oi0ax+e9/09JP9ZI2V9
         RHbaZS109CN+Rk/RAdolWZM++yfLw+K9dIg7WuezA7gNK5XXnra5Dunnh1ZjWrTcfpDM
         TEnPh73jHhtw+dH0so4tC9d4b9fGTlzuWpK2R4/V/0u9q8iiLV4qvkhN4V0lhZTO/VgG
         PDjgVQRzzl8FWlqr0EtX/TgD+ODmxVj28HbkOzD2IEqXrvbH7ClRVkFMGgkE8ODFNoEg
         Ziag==
X-Forwarded-Encrypted: i=1; AFNElJ9IEGgangipUp0eVr75Wxy+M6SdAB9ATFxSVeVG0TjqyBGx/B4kavxCNxGWIwxiswCIyMO93nzDqdfnf78=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4o4pmrDc0eDARgiJNQ99FMz3rQ2Q98QIRAG007t0AYKeZWl55
	qAYeKuvUKE5B4ewwZHmE8JwBvQMzsBcUBl1asxvd+MkTRyfdIEvDtFgpgUW62pXTA+8=
X-Gm-Gg: AeBDietm+b9aTHFNi0Eto+z2+XqTzBfshW08m3fJTjCN16e1AMv1rF/Yw++YYx3iDUK
	uMC5AObfwwbwxo2+B1SHg8L7jntLn2CM9LwsPcLHEPmoh62FTuyyZsdDDQWKY+SlQ0Ncp8CrKXQ
	NqG44dG8xdFjmj02gLGD2+TwnzOD67qWMjnHAskjK3/3JdQgfDVquFr2fSoN4dsU3u3/m/8HTPR
	DFsKFeUrb3qkzcs/IvHI+EFsDJ9nzTgyk7NU7ICxdkkLHZkkQFfVzFBHsPTGzp0Nn4mBD3u2caJ
	lrAnFkZzRvUDWxkuyK3QCoK9r3FFejs0D0FH8xP6/KXWlGg30MjQo73fu0AvbeDV3p96vl4iFrM
	CQIhSkX9O2lvFrzp7x1Q3NlGRCJbcry6LOSzFDiMgt8/yaHjlBHnG0I4i6QJyUgRmFeLNiYmZQI
	s4/5brwzgnY3oynG4Ibwn//FBx5NjY+JbmfarRwMWsVYkzNWLsR1NYyvE=
X-Received: by 2002:a17:903:17cf:b0:2b2:4d78:eec2 with SMTP id d9443c01a7336-2b5f9f1ab12mr304233705ad.18.1776999356343;
        Thu, 23 Apr 2026 19:55:56 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:55:55 -0700 (PDT)
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
Subject: [PATCH v6 0/7] mm: fix vmemmap optimization accounting and initialization
Date: Fri, 24 Apr 2026 10:55:40 +0800
Message-Id: <20260424025547.3806072-1-songmuchun@bytedance.com>
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

The last three patches handle follow-up initialization and cleanup
issues. Patches 5 and 6 fix initialization issues in mm/mm_init. One
makes sure all pageblocks in ZONE_DEVICE compound pages get their
migratetype initialized. The other fixes a case where DAX memory
hotplug reuses an unoptimized early-section memmap while
compound_nr_pages() still assumes vmemmap optimization, leaving tail
struct pages uninitialized. The last patch factors out the altmap free
and verification logic into a helper.

Changelog:
v5 -> v6:
- Add Cc: stable@vger.kernel.org to bugfix patches.
- mm/sparse-vmemmap: Relax the alignment warning in
  section_nr_vmemmap_pages() for sub-section callers.
- mm/memory_hotplug: Factor out altmap free/check handling into a final
  standalone patch suggested-by from David Hildenbrand.
- Collect Acked-by tags from David.

Muchun Song (7):
  mm/sparse-vmemmap: Fix vmemmap accounting underflow
  mm/memory_hotplug: Fix incorrect altmap passing in error path
  mm/sparse-vmemmap: Pass @pgmap argument to memory deactivation paths
  mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
  mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
  mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
  mm/memory_hotplug: Factor out altmap freeing checks

 arch/arm64/mm/mmu.c            |  5 ++--
 arch/loongarch/mm/init.c       |  5 ++--
 arch/powerpc/mm/mem.c          |  5 ++--
 arch/riscv/mm/init.c           |  5 ++--
 arch/s390/mm/init.c            |  5 ++--
 arch/x86/mm/init_64.c          |  5 ++--
 include/linux/memory_hotplug.h |  8 +++--
 mm/memory_hotplug.c            | 29 ++++++++++--------
 mm/memremap.c                  |  4 +--
 mm/mm_init.c                   | 47 ++++++++++++++++++-----------
 mm/sparse-vmemmap.c            | 55 +++++++++++++++++++++++++---------
 11 files changed, 111 insertions(+), 62 deletions(-)

-- 
2.20.1


