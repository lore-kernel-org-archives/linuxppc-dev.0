Return-Path: <linuxppc-dev+bounces-26239-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA64C624C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:54:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYLqc0N6mz2yCt;
	Mon, 31 Aug 2026 17:54:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788162875;
	cv=none; b=HOlyItFxkLK4oC8wX9Q11wiw1R/Nj8fCDDS/eNTiBaNZsSLwmvUjreyfkc1QATWdeXm+lmTFOOiqSMnsOPcBbyysqu7jAVoNhGnOnGX0vk1WzgVSuaxAK+08ZouocvyZZ5/nakbZrEFz121EHSvvSY2bPrsAKuSy1hFPnFe1E5g/WSyUB3nPxU/Z+eeo32viHXoBnL7tAdGcEv2vWLwosHieagdGNvGEiDd4FjMjjok+QuwLgUM/SzvFKXnpMuOSoZd1OkOyGT4DEO33yAYqlLcpxW9in8+D+WcnE3Kv3xudwDISCfRvYfbVv3eEu95Hu5XMb33FfGF6gCYY305aDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788162875; c=relaxed/relaxed;
	bh=TXPCi3Qy+Dn1DAAHVgNjvUWIuwmWO5YrhOqB0jfLte0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cvi04SarlHuKozmjygLgdJbZ5UEI3eZSGb3nbXhtmTIJlqu/gRPYmD+xSNkuK8ZTwpzj+03XHHsFVSDmU2mwlUuVmSwNBWtGULQaKuvg0mfG8McjjbA8MDldbwNf7Sz9TgI3KOq2HYxqBl9sauRhinxwEyg1PH85B7xuIIWDn8eRW9iL0qKJQylix0K8zek48vjDjcoAChmPZtn8sxCtSmVXgn4cPBd0U9WKuPeucc1Hj//LRYwU7q0JBWqI23GKdBOKXFUxP/4w6TuEMFC+sEtQM+rDTxXQd/h/4a08CoLovcBQhKt6Ria1MAQKZOPAI0NY4wBnAHjfNhVA2aAeBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=beakKhWa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=beakKhWa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYLqX0tYwz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:54:30 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-84eb992a881so2783396b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788162867; x=1788767667; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TXPCi3Qy+Dn1DAAHVgNjvUWIuwmWO5YrhOqB0jfLte0=;
        b=beakKhWaJq6PCCvVQjsyueW7L/AC3h9vBke2hdZR9xtj9ZdQDMMIoepKa56gPoBw5d
         EECwpbeIJfyawK2uX8Xe2fbBS4aNALvdqfXuLMdtEoNQnD4s0GlE7dfCGUTrVXUbi/ut
         1Lu8yG1UEVlaWp+4iMlrYSiut3URh+Yj6D1ng0ZfVKJAAVIT7gtfz+K2hXhEjT2PAk4F
         VhFAOLCtHpIOIbqAHRG3tzz3PXgQl1VCWFgid9K12nhlMq6DaJtRebBLJJc2H1+X3ZH6
         nNApJfVdSDGQeVY/1ffVPuU706tlQ3pal3JesG6TE1FtAgObKCx46FSiuZ4RBLpgnl7x
         47xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162867; x=1788767667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXPCi3Qy+Dn1DAAHVgNjvUWIuwmWO5YrhOqB0jfLte0=;
        b=oQH2oQ2glK7zu4jPX6Vv2Ca/XD0R9dByVSL5HlCozl1fXfJQfVsRrbqG8jK5LKxrAN
         QFLmlQzcWO+5Du6J3rNABgjP5Z4cUIOc3L8NdJLFkLMD4OQrGUsYb4y/ZUzu4hijup/0
         FWfgY1SL8ffTyXuAgyxFdOMoLYq2r0wfGJWHc727s//TWdi4BjFRYHCW5jEsFPk9ar61
         g4uLabDNx0iSsDvMwtLYZJQyRcYdM2oKfND4GiE4fxFcP4lrUWas30zIxn1zLyHRYd8v
         +ABbansfyJ9FESg6+Fr9ju2YJ2wSBPZ/H/rFhC0lTZXcmMVJaBa8tYG1/1ugNGiIgGNj
         xtFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpB9vzW0DqCYg4XFG3zqdYZLpQfL2x0v1s86Xid9APqgikw4lGZeEgztJENftgflQ7RD6/5K8PIx1mYcEs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kaMCKDZq7srlpukzEFIVNXxHlD6sIbK6QhmprXP/PQbvW/Mzjb
	GYGV3pCUhgR7+RxluIBE8LbVJR5z2OkDn6DwPehrHsmAEvvFcsDh0ipfaJs57d+zChk=
X-Gm-Gg: AR+sD115Le00cwIStCOFq/drpAIs2Z+yw6dSPQT/rOCKjwmb2o6SD0X2t54lJ3QzgUW
	kymRcWN4QNphH6Z8OAQKexFNi5eJ4ySVCecNZUjpLnKW2r/yjr+fBqHrBZINpxwzl8WQORdTFYw
	+P/Q08gRZlLWUc32Zjo795yqQDbtAsWqM5do1MQWfTIlFqEXdENGJL1OuqnmY6PUDgLPHnH1kRN
	Xm4iXJz0SOeNnAA0Wb2qgGOL2BYW7MH0uTOFzgdsdoLU0LkwpF0eDyn9g4MPpNlfuWU78xvVkR3
	VivDmrjYFcM46dAIAt+5vngo6S83e6U6ObAYkopHmUW5n8MWvYn94F0yBTQA3m9loptszn8y375
	FU26IhAGGEmLFDKAnY5kyDcyx//nWnzd8hste6sG2ejwDMZ2cGJ/Rl1HpUsqL8qHbd9U9FT4oMe
	tFTuu3vfVjg/hCFcFspcGn/8E0r/G6/WUyjVZ+ypBgVM3JMiGCwYy3wtFyPp8eJOEoTnpqEYfJ4
	d7BfI0e/3eEculnAqfNTyMPWd57Xl1T0tY=
X-Received: by 2002:a05:6a21:e081:b0:3d3:b00b:26e8 with SMTP id adf61e73a8af0-3d3b00b6d9dmr18107787637.28.1788162867110;
        Mon, 31 Aug 2026 00:54:27 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f88csm3590256a12.10.2026.08.31.00.54.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 00:54:26 -0700 (PDT)
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
Subject: [PATCH 00/11] mm: Switch device DAX to section-based vmemmap optimization
Date: Mon, 31 Aug 2026 15:53:31 +0800
Message-ID: <20260831075342.57563-1-songmuchun@bytedance.com>
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
a single, self-contained step: switching device DAX to the section-based
sparse-vmemmap optimization infrastructure introduced for HugeTLB.

After the HugeTLB conversion, optimized vmemmap state is described by
the memory section and the sparse-vmemmap population path can allocate or
reuse shared tail vmemmap pages based on that metadata. Device DAX still
uses the older DAX-specific population model, including a separate tail
vmemmap page reservation and architecture-specific logic to locate or
populate reusable tail pages.

This series makes device DAX use the same section-based model. Device DAX
sets the section order from pgmap->vmemmap_shift before vmemmap
population, uses the common per-zone shared tail vmemmap page, and drops
the extra reserved tail page. The powerpc radix path is updated to use
the same shared tail-page helper, so the generic and powerpc DAX paths
follow the same reservation model.

The first patches prepare the shared infrastructure by introducing a
generic CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION symbol, factoring out
shared tail-page allocation, and keeping the special shared-tail struct
page initialization local to sparse-vmemmap.

The middle patches move device DAX onto that infrastructure by recording
the device DAX compound page order in the memory section, using that
section metadata to back generic device DAX mappings with the common
per-zone shared tail page, exposing the shared helpers so the powerpc
radix path can use the same model, and then dropping the extra DAX-only
tail page reservation, and the now-unused section accounting arguments
can be removed.

The final patch updates the documentation for the new DAX layout.

This is intended to be the third smaller step toward the broader HVO
generalization. The wider HVO consolidation between HugeTLB and device
DAX is left for follow-up series.

[1] https://lore.kernel.org/linux-mm/20260513130542.35604-1-songmuchun@bytedance.com/

Muchun Song (11):
  mm/sparse-vmemmap: introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
  mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
  mm/sparse-vmemmap: open-code init_compound_tail()
  mm/sparse-vmemmap: prepare DAX vmemmap population for section orders
  mm/sparse-vmemmap: set section order for device DAX
  mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
  mm/sparse-vmemmap: move HVO helpers to a public header
  powerpc/mm: switch device DAX to shared tail vmemmap pages
  mm/sparse-vmemmap: drop the extra tail page from device DAX
    reservation
  mm/sparse-vmemmap: drop unused section_nr_vmemmap_pages() arguments
  Documentation/mm: update DAX vmemmap deduplication docs

 Documentation/arch/powerpc/vmemmap_dedup.rst  |  90 ++-------
 Documentation/mm/vmemmap_dedup.rst            |  32 +--
 MAINTAINERS                                   |   1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c      | 124 +-----------
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |   2 +-
 drivers/dax/Kconfig                           |   1 +
 fs/Kconfig                                    |   1 +
 include/linux/mm.h                            |   6 +-
 include/linux/mmzone.h                        |  23 ++-
 include/linux/page-flags.h                    |   5 +-
 include/linux/vmemmap-optimization.h          |  88 +++++++++
 mm/Kconfig                                    |   3 +
 mm/hugetlb.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                          |  30 +--
 mm/internal.h                                 |   9 -
 mm/memory_hotplug.c                           |   6 +-
 mm/mm_init.c                                  |  15 +-
 mm/sparse-vmemmap.c                           | 184 ++++++++----------
 mm/sparse.c                                   |   3 +-
 mm/sparse.h                                   |  78 +-------
 20 files changed, 244 insertions(+), 459 deletions(-)
 create mode 100644 include/linux/vmemmap-optimization.h


base-commit: da6c37ed8beb273e3308e42d4bca3ce11b4432fa
-- 
2.54.0


