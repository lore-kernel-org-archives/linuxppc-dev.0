Return-Path: <linuxppc-dev+bounces-28097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C7DC98315
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:58:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr5md02Xbz2y7Y;
	Thu, 24 Sep 2026 17:58:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790236688;
	cv=none; b=l+xxyelPMzzlBe0K352Rh8Fbjv0mvj+nI943cZwMFSZR9uKiPCVJwfr9YtfVos63qkb1r9FBEdVKArGYzSaZ+HMM9nCi/AdBBHr+siyNOPvJUD5wVLv5FZcsWDfD63v2FIO8B3Skg0a/qZjEhv07PEl51iXld5cRDECtEmqceRuKd+jMfAlJJ6/oWEYUs8S7NVg/R57OBOAokJq9gRClwuNK8UNBPmpQGGRlxBT6O0YmEy3te8ZchAuVFngvEXarqOgBSTAK2CugZnUNCFnJuqkhci72E1l4ZP0nryq4tT6BCF+VUU2zrUGEQ1wL9sGCQ2qEsfqk/aIqA0r1oBDCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790236688; c=relaxed/relaxed;
	bh=cH8utLFYEujpE6X6Qzd7ExQckIBLy/Lta27TjnKc3ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GS2Qsmv9dfje1vESotOAPmZLxeaprCTZOlTDHeLJZ3mGLVfPebRg68fmNkCX3Gy9vFyMNXTlyknUS3kRe6fvQL2CvZ84SZl/CaqmtMBKs5hCTICOdfMn/WcJ49fBerCHNONTSk15rCPhta0hckuSK/iG4z6LyIhF9NVsWJDQRiOMTz8Ud8Fl1SQb4+3L0tPlhfQwtXIJqSejiyC+s9IVY5qwDkKCxUYLEHeQ5UDtiHBNl+njvQ9P8tmHwRWctXbQp5c2I10c5gsbf5DlHC2GdUC8brfL2cVEbtP473c/0BBtCBwQo7bghLpOs1J/ekHaSguhtSW5zlTPiwvm9n4u8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AbthnPFD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AbthnPFD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr5mY4BcYz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:58:03 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1237861a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790236682; x=1790841482; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cH8utLFYEujpE6X6Qzd7ExQckIBLy/Lta27TjnKc3ts=;
        b=AbthnPFDHO6id2A85Q9OQH+LhEtnOyKK3z4PHGknGE8rmZfXCoaApc/1di8UxZbRb4
         49Lz730nCQSei5jOKhWXmNkK91Evr0nggwgQdSmYy+aVZ2gAmukpOR8/7ndzf6w8kGIK
         x+4CbxXShxndunPsiomOPkVR9aF5C48npXlAUvqiRyxSPQnPIhJquL+YLHja12ijurdX
         9ItE6dwmmRahlY5VzUjjODjXUmleeUtn7krHzq6giaussCR2adYxjyAQjGQCB04v4ZD3
         iibDD5b+82u3zJ6eAfOI3O+7TTSN1IW6zBtgmobItYlawPdUYfRdwcIRxK70RJD33Uir
         vI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236682; x=1790841482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cH8utLFYEujpE6X6Qzd7ExQckIBLy/Lta27TjnKc3ts=;
        b=1lLZMv5BWJ0Tokj/EI0qCtIDKobfzwHbgjnU/kGBiFeRcCQ4NI/JbEnK3GFvZgKgas
         nQ6buppnlVnET7bxSJQKrNCuahh/861X7nlakLJEMVwaKu7BU32vDrwyjKSwn5d3mlST
         zygtqeg1SAfG4qLPGBXuROhnNeEGUD1K+7c2+/M0ZlLDY12wdIpNeeO3Y/+N5JxGNRDq
         gp/gXwiYUKEmwwJK4erxmPJt8raPQkAFFvGVzqrWnFV07aDD3t1SGUSST8XztHoYxfVA
         0uI31jne8Y6s74aK8pUGjaJ+q2MuhChEiSP+xPr2pUeuRGnMNh1DccerO37qrbl9gOxU
         qQsw==
X-Forwarded-Encrypted: i=1; AKwUvBwqK/y7iLrPNZESz/vOw4HNb3rj3qPG9zokf5bu79Yv58+BY+tn/KaodyD8j8dU9KkkSjxfHY5yvVwjzCQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m4bT9NWiRhMRWNhBtb6/AYQFJ2D/gBVvB8euKkegfFqaQNbbVN
	SDwL9bJM7RpewYIcDtJo7HrnWEd8gxfpwwcCpiRWEzoVRRbpl8P2nOcYx4KKfofJFeU=
X-Gm-Gg: AYBFou2suMeHSMoS79ImS81HC4FWmFtaNTnP/2MX0yPN8QM9Qw7RR5bCZB0u0yLUi09
	RGjVPVdzRJuHQG7GPuNd9e6+fxC4WGyYqAv/maFhI3+GJ9yAuMDyaF/KUl2rHJoxyJz2WZl6nWW
	ue9IGtkJaOuYJEXUH+kskWH3xtgXWE/1/ODTV0QRjDPumdOy5Puezt1leZnBOI0NrBsM2wYI8pl
	0O2+ZkeCb+HOsKpLx0tpvZsqq8ZByDnZ/pdBJcyq9ld/JpeDkHss9GnnqtDTkacpdX+qNEp+Yly
	AsVavW/0cxIWeB1lTKkAZaLEZafrY65/ungpwMwa0/8dAdXelst0hwULkc3AJ/Ep9Bzw96ftz2n
	1CxSK1IfPat2nmvKClVo7tJTnwud5BSenJcfVwOGOoPQ2UPyT8/IIG4suIu/x1RA19sV0Pbn13a
	0Pr4byK69JxuiQOj7Us+sjb5Ca9uIkNk4rKJL5doQi/J1Gz37ThNIgIhpIy7Uh4Z4wC04ShHY/X
	5590UJ6BMux8HYUnXY=
X-Received: by 2002:a17:90b:390b:b0:39d:f66e:1720 with SMTP id 98e67ed59e1d1-3a09860771cmr1679255a91.13.1790236681626;
        Thu, 24 Sep 2026 00:58:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3575622a91.7.2026.09.24.00.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:58:01 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v2 0/6] mm: Unify device DAX and HugeTLB vmemmap population paths
Date: Thu, 24 Sep 2026 15:52:53 +0800
Message-ID: <20260924075259.2013039-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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

This series is split out from the earlier, larger series "mm: Generalize
HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
vmemmap optimization across HugeTLB and device DAX, this subset addresses
a single, self-contained step: unifying their vmemmap population paths.

After the preceding Device DAX conversion, both HugeTLB and Device DAX
describe optimized vmemmap mappings through memory-section metadata and
use per-zone shared tail vmemmap pages. The generic code, however, still
carries a Device DAX-specific population flag and compound-page population
path, along with arguments and helpers needed only by that path.

This series first removes VMEMMAP_POPULATE_DAX and moves selection and
reference handling for the shared tail page into the common vmemmap
population path. It then removes the generic Device DAX-specific
compound-page population path and routes section vmemmap population
through vmemmap_populate(). The powerpc radix path continues to use its
architecture-specific compound-page population implementation for
optimizable sections.

The remaining patches remove the unused ptpfn argument, open-code
vmemmap_populate_address() now that no caller needs its returned PTE, and
add a warning for inconsistent zone initialization of shared tail vmemmap
pages.

This is the fourth smaller step toward the broader HVO generalization.
After this series, HugeTLB and Device DAX use the same population model
instead of parallel generic paths, while powerpc keeps its
architecture-specific implementation.

[1] https://lore.kernel.org/all/20260513130542.35604-1-songmuchun@bytedance.com/

v2:
- Expand the comments around the slab initialization boundary as suggested
  by Qi Zheng.
- Collect Acked-by tags from Qi Zheng.
- Defer the patch making vmemmap_populate_compound_pages() static to a
  follow-up series that cleans up the powerpc vmemmap population code.
- Add a new patch to warn about mismatched zone IDs between a page and its
  shared tail vmemmap page.

v1: https://lore.kernel.org/all/20260913083734.86802-1-songmuchun@bytedance.com/

Muchun Song (6):
  mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
  mm/sparse-vmemmap: support device DAX in common vmemmap path
  mm/sparse-vmemmap: drop Device DAX-specific population path
  mm/sparse-vmemmap: remove the unused ptpfn argument
  mm/sparse-vmemmap: open-code vmemmap_populate_address()
  mm/mm_init: add zone mismatch warning during page init

 arch/powerpc/mm/book3s64/radix_pgtable.c |   3 +
 mm/mm_init.c                             |   5 +-
 mm/sparse-vmemmap.c                      | 200 ++++++-----------------
 3 files changed, 59 insertions(+), 149 deletions(-)


base-commit: f19407ca08644f728cfe9762bf1d1f6985826c47
-- 
2.54.0


