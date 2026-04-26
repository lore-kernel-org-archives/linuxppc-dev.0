Return-Path: <linuxppc-dev+bounces-20113-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B3FFF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 09:27:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Lv25sNQz2yFl;
	Sun, 26 Apr 2026 19:27:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777195630;
	cv=none; b=naHuLsbTOrLsGIDdQatRoSSqcP1UySej3V1ilcDkUEvXYR3GwDqDF5dJguGAOH4lVh+4Q6ugUVQ9MInb6sdk3vR/GXF6P5uXKS6HG0UeWGIENQeKO4CSwZDI1SGq0+5NuRxDp+pvWj7X9eNu3eRcM87xV7cxyk/LYGM85T8Wn7EDzd0IWIyEI0Dzm42VC34xJmOlLTncqj2R+vOvENv22RjVZQ/VnQcObloQxMlP6SBs8DKzc/azjCoYUS19UZdDAQFYctjfVzvY3cu+qo3fnHXp8hkdDzuNF6lSx8ALQQAP/dBW+gYMsu4c6Xi4MIJch4SOMJOTzZIui320XYCTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777195630; c=relaxed/relaxed;
	bh=iZUxF2n4jgKeeubqC5qvDAhtO/51+Y+R8j9b6gRv+Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mfgdPC4a0gjs07Hd/vBfcK//n01MMmliIkZWY00MtMFW/ltWrOmwj/VPkkxyoDRrP52Umf2ly3LfwlgANt2JHOVj0j2P12jYhZqEZHryL+sXZIT9XnD5DeLfRd2bLPO52VS3cDBmiWph3IDhE04eK7F++LEpHUfx/ZMAL8NWhVUnjNhprrfsh2yV2VkzICyUPNh2u6KAqOUQywEEqQNbHQ+TRdo0mraZNV+NbK2TUZ9+OCjV8u9Icnm64s1QGZQWXFwsfORZw+pWWVmu6UHrtOkbKyxRkwRA2i7awNYbFXCj9MgvUwuq3jqvN8Pdeo8+OVarrbmAcxv5jZuSXpajZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Wyx1izeW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Wyx1izeW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Lv01hnlz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 19:27:06 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b458ca2296so57286675ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195624; x=1777800424; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZUxF2n4jgKeeubqC5qvDAhtO/51+Y+R8j9b6gRv+Wc=;
        b=Wyx1izeWAh4qJTQpiN3um+aEKUm0qEveejMkklrkFAt+RNUTFgZZBdusR7wmqpS2+m
         2BymP2l+Y8XajIJY2OmSY42B2AMN9/DutdhmlyEFu8z6jSYgMz5VVIRgCtYhABsj5qdU
         8E6cioEbqH9v3P/PDWZ8hbX3ZufbOZU8UyJ1J12Ot6WMuWt9/Hz86Enbclqw/V+hoROj
         A5PQPmhF6/TTgV8ivRw4e37dk4rrYsFdR63iysVrrPl8dlWf4GL2a+yVvwkdwsVtUmsP
         RUqw91TBo4yMpr70aVqRl0ndl2QEEK3IpKoluUHzIBJcvrQHzS7FzqczZs2LB0Mk5dND
         aLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195624; x=1777800424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZUxF2n4jgKeeubqC5qvDAhtO/51+Y+R8j9b6gRv+Wc=;
        b=tM7DiVrGwldHTqwOYPiY+8r66kDYsyAARbz8iaoxXp80EA9w9dgc6Pd1KEfhKBv6Ih
         GHwXDPJMWbuGVTFiRn/31gZTRSsULgIK/BwAk7GEW8Xu25Dzv3gSHNdqlGSm4WNGYqWH
         TSimr9E1bEUsrbrqy8d+23EExQVkZ0FcfXAs3WhfxIEHxHELTkIhgAAliZRUHD3akdOm
         w/FXEAd5RzGh5mSqQOVg+vmUewyFl4GJdZGoF8qYOXTV1GAaNBRh9NjgA1qV6EVliuYN
         YuTJ+xAg3iJ/wP08ENUS36dNM90RxlbN+A7j6f1NwhVrbNBXpVcyeZ+dWgbHhagH/jya
         nHcA==
X-Forwarded-Encrypted: i=1; AFNElJ/DyWCDd/OkhbYftTyIsNzGzT0jEWpSzCkFcG1A385vej10qDgXsV7q3PFBFUVelFo0eIDhw8EhBxd65Ks=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxgdhy+nSEUPTcwsiUb3ssIt0XqcHfzGjUXc1ljGlea6ZjomTMa
	wFt/OTIOHozTiTRB6qWkEYzwyuuX7/Q7hIJGZdbsL1on+GLbxKjc/SCc3sZ9Ay/Y9YE=
X-Gm-Gg: AeBDiespSGwefo7slUB5F9CeLDLoSir5Sx0eOFuqAcEn6vHKPuxFl+vYtr4RE+sO51M
	2oHMz5OXIKUOS14nWbuKEUKUbK1tAtqP6bQK8aDDqGzJBWVPpWbdf5Nsyy+6cmlF1FpfrLqr83O
	kAdgOwbaRjvl/Kt3V71dMqpk5o5kkQZ3jsIqCuvdouFU7AyG85nUKgc5q1UiP3MHbd++kE6DATP
	yqPpfAFimyKmFxIQX1KyZJxyckTGmYjB9OX4rvAXtcSdObkvSe2ZCgwOi0hwKajL2qZzjhW353M
	ad+jFb0LsAkNZ9uYLBixRvvmiboahxMUs0cJCNnLxWf8+j0n35exnvmQ5kd/GHBGXQum2a/sTHG
	VsDml2yn0NY2kqQzfSceFkmmVOp0S6qlhZXKeci1NbXLEej8QrdROCD6a8Mjx88MZQqebp06B06
	fixVdEVexqHCBTTgZaeC8Qi3Qmfk5X
X-Received: by 2002:a17:902:f710:b0:2b9:4941:7f6e with SMTP id d9443c01a7336-2b949418316mr52947595ad.2.1777195624237;
        Sun, 26 Apr 2026 02:27:04 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:03 -0700 (PDT)
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
Subject: [PATCH v7 0/6] mm: Fix vmemmap optimization accounting and initialization
Date: Sun, 26 Apr 2026 17:26:34 +0800
Message-Id: <20260426092640.375967-1-songmuchun@bytedance.com>
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

Changes in v7:
- Split the previous series into a fixes-only series and a follow-up cleanup
  patch per review feedback.
- Drop the altmap-freeing cleanup patch from this bugfix series.
- Make the alignment assertions in section_nr_vmemmap_pages() explicit for
  subsection, compound, and section granularity as suggested by David
  Hildenbrand.
- Collect Acked-by from Mike Rapoport on the ZONE_DEVICE initialization fix.

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


base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
-- 
2.20.1


