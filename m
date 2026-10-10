Return-Path: <linuxppc-dev+bounces-29164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D27CA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 07:58:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1x1d24vBz2xrL;
	Sat, 10 Oct 2026 18:58:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791619109;
	cv=none; b=nIKhzVzKS6wPln0ERdPB5VRAiq7NuU++coC4Hg3RD5BdYHaiJJVS4FexlYOGie3qro0TWajzIkohLIgci9dPUIwVW+wrjJcEhcPLUAw5RfTaX9UzEfNaX1nPh8QuxKt0P0yElNQUz1lQ3K+xXFwWBlOhtlKPc1xZZXqHB1Oe+NbFAYG5NoyQY6WXtiXASnLUm1QD6+zZq8Y9mlXGO17O6b1G5y0OC6XbEcUH1Lij2xWiOhV0nCAHno2SjyN6DDyCdBimDNun5i8rEtvG85zozbCwk8W45+TAxNxJcH5L+sazrmg+NwOD98PXbZX+oR6mA2Ndj5fgRj+YPC3oGbYSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791619109; c=relaxed/relaxed;
	bh=s931g07PMq4Bu75kY5DuvEAvn6osmlRZp6J1l7oOErg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLlMRH8hrj8gOPVFaiIOR5evY3nz3egRjnkq9DaCp932TXwK175RV2tP1xRZcYBwTkV+y3lO9dTOdbuDXTKpquPWT6HmlJY7FKKqJIkrY8RemPe1UbrpnpY77P+QfSTmCPf6Rwts6iHnUSiHgDIGuY4eNLJ/6ntmcfvWz5mxWDmL/HYSy2g6W63aCruoWl5xsQvWkaKLdVDa/hgGuJBYbmfUelA9cvLUImyrM/XOYguY34/7J6IlutA1lMOn4L8RLGSqjbgr8KJ3gFy3pSn2huHA6G/S0L2RN6scdYAdoTjikG/WJqLwRKQ+m8Mr2BDzzzsJVwalWaMd4tfOqqi69A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ckpW4hl0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ckpW4hl0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1x1b00ybz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 18:58:25 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cc7cc8aafe6so146028a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791619103; x=1792223903; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s931g07PMq4Bu75kY5DuvEAvn6osmlRZp6J1l7oOErg=;
        b=ckpW4hl0R2pNbeXG74Iu+pjRg+P+tfz82X85eFjXMvNkLvbOrgHtkNIypOv18TVu52
         2fPAM7kqZySIXDvf/r//5Z5C841VFp0/WcLBNWSLdGmrerxvjNJMIXz5gb0++AAAPbyA
         eFfj+ofDqlYnZwG6+iCW00Esl3in7B5L8qbdrIEvwFyzZ++nrQkiM/eoMvIACjcurXs2
         AjDDDD8aPgP+67YiRBPQo15VgdjSetiFBJAk+b+ItVWsAMNYTUw/1RT0WiNaAs24v2aj
         VJrrDUf1G1YD77FNg5qFxa1UANZ+jjF1h5uNmJxUYsn4A+zz7vQbjhXWakY7DZmAwLqh
         D2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619103; x=1792223903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s931g07PMq4Bu75kY5DuvEAvn6osmlRZp6J1l7oOErg=;
        b=AAkcKqhD8LjSSEBFa5p2CfyPuSSK+hYVOj4/mQb4nt1qxz+8Sp4lW6IZkDaULWt4fa
         Sm5IeBgIPwuwuq+mSoGx7/7QonwIZ+aBKmtuweE4XL5GzOH2t1BZCr0ZnUAS9LkmwQn1
         LJEfPWQw3M4/2iECAumX9BTbruGwHlQq8W7A10ko4SCKwUSkZmp4zqG1hP6cYkMk0rGP
         9ktbpBntnLJpJlCmhimnma4qM3FJzOT6UEuGvmnFVHa7GYEq9ACtQA2BrchqJutau+Bf
         C0+QAc0YMeCsyJn0VZHCiFKip1IaidolmiFoLkIg2kRR8LKA+tSvUols4vAOz8fOvt4l
         IgLw==
X-Forwarded-Encrypted: i=1; AKwUvByARA8Apk7f+GrwUUYZMNdO7KIKSk6uFWe0+L/nwOSEfERsMUM1sa7LT+gH2E0duOzhgX6nLTUKmckz3Lc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJTFh4q3taKoby0dgch1Zy/NGsVNR0cUWxxy/jxGqTHJxC0p1aS
	STb7DLGENjzlgqdOHrBP0OwOohEGGA0/7Sf8bEjVdCGrtvLCnHeYDewvNXpyK4UehAQ=
X-Gm-Gg: AYBFou2Y/jtdK8CMf9GJr164ZC1/0qC7WmBtzIgpYYfI94C3v/I3fnpzpGqd/LcXN0/
	YfxLSz0zsdjmtYg2UW8zMfLNS3x5H8aQltUV2c37FG8Ux/pJfGWWa2CYth6nyYLdgNL+VZC98qk
	xblPfqo++YY0pj/MsakePSUFSHz4kWqaz3Ejr/FrgNgQaxXKDKS2Hb9VYkbW7L1RhlRNwFhhTjh
	4Xp9QoPscr5pKlSNASQ3MmQROLgsEbWIx/BQENZsXfaAwssax5FXYetfsWw/msqzI2WCWVBhLME
	l3E6rEu2b3JT8OIOkPKXDTqZMhNnbpGZqzVm5mL4SMjz3lzszgUiMKIZ3q5ODvsEc6XLMpBW/DW
	L595DAGmPyKVUfHD/I1LmV7SM3CCGFl2kVgNBnf9Ht3YUL7/1UWpzq/BZIpUpQ+//L//gyJr4if
	W/bYzy3ZNSfYCL2J+YAfCjRdfitDu8NBr0/WcrEGpiG0tcjOq5PELTm3RGSm0KbqtaunMp1HLdy
	L0AVdH4n7Tc+CZ/87bFcaJ+O1OGSGkii/dvHw==
X-Received: by 2002:a17:90b:4b:b0:3aa:f2c4:12ea with SMTP id 98e67ed59e1d1-3ab3ab5e193mr3041362a91.20.1791619102741;
        Sat, 10 Oct 2026 00:58:22 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab57c05724sm3473569a91.4.2026.10.10.00.58.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:58:21 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v4 0/6] mm: Unify device DAX and HugeTLB vmemmap population paths
Date: Sat, 10 Oct 2026 15:57:49 +0800
Message-ID: <20261010075755.83339-1-songmuchun@bytedance.com>
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

This v4 is based on mm-new commit d5207c6d152c, which contains v6 of
"mm: Switch device DAX to section-based vmemmap optimization" [1].

This series is split out from the earlier, larger series "mm: Generalize
HVO for HugeTLB and device DAX" [2]. While the parent series generalizes
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

[1] https://lore.kernel.org/20260930140627.57431-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/20260513130542.35604-1-songmuchun@bytedance.com/

v4:
- Rebase onto mm-new commit d5207c6d152c, which contains v6 of the Device
  DAX section-based vmemmap series.
- Factor the zone mismatch check into a local helper as suggested by Mike
  Rapoport.
- Collect Reviewed-by tags from Lance Yang.

v3: https://lore.kernel.org/20260929053231.66085-1-songmuchun@bytedance.com/
- Rebase onto mm-new commit 2ddb90ee544a, which contains v5 of the Device
  DAX section-based vmemmap series.
- Document the exact dependency order as suggested by David Hildenbrand
  and Ritesh Harjani.
- Use the public order-based optimization predicate in the powerpc path.
- Collect Acked-by tags from Qi Zheng.

v2: https://lore.kernel.org/20260924075259.2013039-1-songmuchun@bytedance.com/
- Expand the comments around the slab initialization boundary as suggested
  by Qi Zheng.
- Collect Acked-by tags from Qi Zheng.
- Defer the patch making vmemmap_populate_compound_pages() static to a
  follow-up series that cleans up the powerpc vmemmap population code.
- Add a new patch to warn about mismatched zone IDs between a page and its
  shared tail vmemmap page.

v1: https://lore.kernel.org/20260913083734.86802-1-songmuchun@bytedance.com/

Muchun Song (6):
  mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
  mm/sparse-vmemmap: support device DAX in common vmemmap path
  mm/sparse-vmemmap: drop Device DAX-specific population path
  mm/sparse-vmemmap: remove the unused ptpfn argument
  mm/sparse-vmemmap: open-code vmemmap_populate_address()
  mm/mm_init: add zone mismatch warning during page init

 arch/powerpc/mm/book3s64/radix_pgtable.c |   3 +
 mm/mm_init.c                             |  12 +-
 mm/sparse-vmemmap.c                      | 208 ++++++-----------------
 3 files changed, 70 insertions(+), 153 deletions(-)


base-commit: d5207c6d152c88761f604ca461e67d6b0fe7402e
-- 
2.54.0


