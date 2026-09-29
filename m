Return-Path: <linuxppc-dev+bounces-28439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AC9C9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:33:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv6K369cKz2xfP;
	Tue, 29 Sep 2026 15:33:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790659991;
	cv=none; b=ThgZzoFkdaiIqamJESIKHrqn9exvYpaUr1VwgByGwoHvDw1t0W2buN6ehX+5jJLEs1tgamjR860HnaDdDwxke70lgevPHd1oJ67BEBAhG7cl/ySNJd4ZUX3H6FIHGND+SF5n4HoOwcapiwY66WkCTi/sET+jCMfCwSkfv9V4oF8R3QkADPzPpGC813eFEvtSCyH3N6InfyhFKTpYuFGPSCnZlPSidW4XFm/N6TxmA38UFIsylAyffSm4idnIdNhCC5wZBcArbwvRqNFwjfxHAsxJh+y9xLRziMEaL0bnO0BzdMev/erS6zpbludSPWaZLZ+t6h24B9YsrncJBxe0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790659991; c=relaxed/relaxed;
	bh=utwCr7dhiJhH+7zfFzlq+sGzsmDUrkDOgCiJgBfnXiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cP87JXi2mo9uXjOr7lkBHUytJLJFrcjNiVU+NfBxtR5+VwjYNAZ5TOWeOZiqdBpYo1iCRJ4IL0yG2yKOkq+dCD70VFiQv5MVzWgY4/aFmndAqFhvFQTQdXbI9bhz//4Y3jJwi+d2I2iXxpfojY4fcgYtW/mYuf/powDP1198MI+1trnfefqmiRJstAA8gM6oM+DE3J1jlYi9GfU+6HOKRY2QkA19nYhfTNZghdtTg+aAiItXlEBUL2+xgAizy/De/eWqcRm3d/vE9E2Feqr9hZAYzPA+dFBk5j9cykAFlzAVkIaahKog2ohNl2NO1p2MJ1FspHxgxd7rdoISElFqwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JL936YdN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JL936YdN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv6K22THcz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 15:33:09 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747eb79f7so16985335ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790659987; x=1791264787; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=utwCr7dhiJhH+7zfFzlq+sGzsmDUrkDOgCiJgBfnXiw=;
        b=JL936YdNq7XKrmFCGsXdVd29JqlazwuzsAJJ1Aaz5+DT0UzL1sgov11jyuQHRGs/mQ
         ueqo/0UH6mcGSv2g7V7mvBXMB4Tx245DRjWdbtqXbWFs266s2YlNukRAR8e1+Ty72zv/
         Nb94igMCWTCX7vvbvmM4f84eu0TXJ/7QbBBTo2FDY+6SkacZbOduag60ogUr8L8Ot8pE
         ss6WwrxEfvEeh8KMf+9KhPkTfXZG9mlkE4fa9F3XYYxJeR6rc+Cxop51DIAaLJ55W6BN
         RwTHJOUMrdAK68tt91cfpujKJxHTVtJEOzZwxHKRgAXgk7ZiPNlE5dxjcdsMF36uV1pD
         dgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790659987; x=1791264787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=utwCr7dhiJhH+7zfFzlq+sGzsmDUrkDOgCiJgBfnXiw=;
        b=fThvCZ6HEZu46IYvz07AU4qHtAioKbm5/LRMo4+y/kVUgJhe9/ww74VC2XcZM0HB5W
         7WW6FLYzvWDmz0ksCnN2sEUf0n1HC8w1lBcK3fsRjOW6MYUF9oEacvXB6kBHd6ochf0u
         m0xyADd2XcIYZwgmGFqaWy4zAbcbK9Eu/vVMcWvBnFgFw97MroU3iiq11StbJXsVQyH0
         00MWZE36mfLyaWCVNKoAQIa9kEjxjTvaRWI3bW5k2OUTC4kDgl6xKGaTOGTZ7v0N0F0x
         4YiLovCGJ4z8+uXxuvGNymVem5lgxyXMZ7o9B7hP4/uQAxQN0bmdShsgc/JaOs0F4vj3
         WSqQ==
X-Forwarded-Encrypted: i=1; AKwUvByyeIsstvSwUeiKhDAIsPwF+tA3dTcl9QZZiOvE0Ek7Ap+WnP7wY4F3VR3rbu+4r0GEkEIZjeykt4IJTvw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK2aKc5KFUzHN0w/PH1AewJ4JGhuuRdvOXm3Sp1pTXGYBM8Is2p
	PtZ3H+dvrcLyPtBZMC36K/bg5FTiQD+Xkg27LkpVJKaHuL3lK8XOcLO/xLZBZJGHvPE=
X-Gm-Gg: AYBFou0nxMNrstSt/XaOYe86YLnGuNJ6ecLsgpiiyl5TTxlzVlqkn0ry2+k+YxEjBh9
	G5GqNGIfthu6El+dlYt7RmtIGc9usXvAj8c9fqpAmgpaSIdgkxCi/QMQQlTgySYL69u3GOtVZDj
	w6VPn/k5ANd+KUqQ/0/+B3qCUinR7BYZYFNjEAsPUDlYYJ5+uaADAlCex46OKxLf2ERUdu4vkgq
	lZT8UyLFNk95b6/fNMMbI3No3sg43KdPmQ/ZudO4s6abd/hyI2qEinRizXcpJbq4UDRB/ueWzMz
	8Son0wiiEyPouoqM1Wlqra+uMrNJKh6vcJPLYzFw5Mtj6gynutApyMH+yKUI0Ff+BI1TecaQC2g
	PZ5Egu282p2K1/+eEMc0uUuHV1/2qLD0O/FLCG0HrBB8wO8GAudCjgweyUoV03WvlLKqzOAG2aY
	MVFRC5zh6iRVi4Y+7PJHElKgIJRxkOVc3eG4LBrTSLErkvzv7UrGM8nwKsWTPohLspRG/yoALsA
	6THrd5o0BAwaZtFPbc=
X-Received: by 2002:a17:903:1447:b0:2dd:c0ff:e737 with SMTP id d9443c01a7336-2df7e11e8d9mr118705625ad.73.1790659986929;
        Mon, 28 Sep 2026 22:33:06 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm49251765ad.51.2026.09.28.22.32.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 22:33:06 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v3 0/6] mm: Unify device DAX and HugeTLB vmemmap population paths
Date: Tue, 29 Sep 2026 13:32:25 +0800
Message-ID: <20260929053231.66085-1-songmuchun@bytedance.com>
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

This v3 is based on mm-new commit 2ddb90ee544a, which contains v5 of
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

[1] https://lore.kernel.org/20260927025441.741633-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/20260513130542.35604-1-songmuchun@bytedance.com/

v3:
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
 mm/mm_init.c                             |   5 +-
 mm/sparse-vmemmap.c                      | 208 ++++++-----------------
 3 files changed, 63 insertions(+), 153 deletions(-)


base-commit: 2ddb90ee544ae97215afc4698dc223293997cc43
-- 
2.54.0


