Return-Path: <linuxppc-dev+bounces-22580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D92CD98D6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 18:09:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcSGD4pwHz2ykX;
	Sat, 13 Jun 2026 04:09:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781287780;
	cv=none; b=QziHTKKgrJOsfQTveCzLlTDNR8wH6w2ORx416+SgdoarlN6hTBClOmKpew6vZrC5lZ9ML6SqgLxLrCE10OkacJCxkNfBdxUmWsOnVbeAb7opABUD6F9Hy/NNa+oOGXiiC63TRu0S54A53MAQM2gyp/r19qell1TKJmhEN3jV45SDoLPqLqku70b78mx0gVLXGZff8+vu01kCIs4HxuyDqZquJ73LAyagOMJuMQwqRQUZYnblWrEUWihzjH7/2qcMfAciOKcFmdt6lgRyGSRnFCZGVAPCW6J0Hqr7mMSVP+Xha3wWoZVWEd7JDCqcC6uhQi4wIh9kQECBZLhdEf2+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781287780; c=relaxed/relaxed;
	bh=tIviRJIKLG37v3E4DnE8ZIX3XY+lQBK31eI/eTdPTgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NAJXNNVa5n64dblRqOJUaN8XwDTBqiPwI1fxTy0dYJ8FVFP3KNkZxzLN2tyFHCawejCMEIPNWHqjdirj40/mL4HEtobfE5Z0LydC2yz57WHGeofOb/2w4fRTAAUn1q0DTb9e6dC5VI6cQaxbFEyGFfMSDDhdU9aTtq/Qk8hg6RLyYWWuxA0rr1Um6yaLTMvaQ+m52cpHEJskxfSjy6BKtdg+/CPO7bkjre0IQ7cRdnCtls4az2Y+Mdxwd3oVVvqjYHOQoRC5/rWKfAXcReBEevHqX+dQpqQbZNTxy3kuFcjo37ifju/soXGUk4Cymw1X1d0XBc95DeycQl/I8gy4OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RBqcnTFZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RBqcnTFZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcSGB6wjfz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 04:09:38 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2bf22d29dabso9090425ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781287776; x=1781892576; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tIviRJIKLG37v3E4DnE8ZIX3XY+lQBK31eI/eTdPTgg=;
        b=RBqcnTFZPOUkKafpZY8faFo8tPDloOQXT1mIuyL57Z05eN2ga/NDjWkQ0quU3e3O6O
         U5p50VtSuZV8hk0pJNsUWA60O1qCA0dX2gsKBNnsGgB1YSD1Dv/5gJiuNFiR4gM/Pi29
         3KtOrSXf332wuMp5IZ0LFb1FfQzq/A++lOp5GQSglgRBvsqxyJyEK1j/GJNgwxmiqFs9
         Jc0lJ2aQAPY/513nGfaL1VyWlEHyPLCP3EPZlOhYmAYGFpyCfDiBGIfaBRjJybK1E0bL
         DmbnQMJKmfBQI70GDrrnym/SuR939I6Xx1ZhFJrW8KNg/MkVlOk9pcEBTeGhZ5q5ez/r
         S1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287776; x=1781892576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIviRJIKLG37v3E4DnE8ZIX3XY+lQBK31eI/eTdPTgg=;
        b=d/NdDP0PFM2X9U0z/eQNUwN5b9jkc5Ty+LBKlTxhHyMHqKGd8Z772BLHj619d5MnnG
         Jxj8I1y7NjkeLwCYJmFvS8/hmG8maQdazGanemJZdelkDXuEupbgFtQbWx2EgV9HCc+1
         oVzEUwbFhhC//FhzqK5150BkqTyAlqsLgUE/g4Fd/JUYcs2trgawKcBJtoBYec5IHovv
         4q1xjMiGtSTvT/uuOgdEwQPZpTGy454x2z5gm4mjzduCagdk5vXdiMI8mltYxFEDAsdd
         JtX0g+4ThnWcgumGsMY0GD3ZGti7Uu8kxoIWinJn+qMw2AMJhTcfHAcTEXqoVgJBOi/h
         Y1sg==
X-Forwarded-Encrypted: i=1; AFNElJ/K1Pn3NXhaQCwN04CtgeHydvO0FP3x4IbMtSYElN0uSR1+OUW/sG1CGDa8SN8bWZ3bwZfbVfB+Mx6P28Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjG9xuFzpWp4rId6UaDv16jq/o0goB1o5BTpR5IkvMK+4tvcba
	Fho4BDN3w0Rx+A20dEqY7pTBNtSePPcWM6WYfs/r6WEWQYlrkObbbvvq
X-Gm-Gg: Acq92OGe2VGSC81qkHxts3LzLxUs9+kbIRoNgJvnoQlGtgbKMfKV1ZRDooxMKeBHcPn
	sNspmiV+UTpyzkY7puT138zvOmMo+nbr/RL4y5RPwEu9Xm6tMOB8T/Ov4QDGJl/KVHRX1NxHG9w
	c7b8F/aGiBuENUEgBpUeRmVNQu6NzVh+ZNU/C3cphU+U86AvsB9SmkZQhqQnPOYBbBX/fHoN5DZ
	AsGDl1vg4MhUyPDTMD2WaKWSB5nyUhRG2XUW0W3KiPAQs8fKPg26Bj6W4bZR7X0sYI4IIKEAFqk
	LeAUK5l1PGK4zfERpfkasCojVZpuifDnGKEagRQKwCkpR7DwTqtqEwWPzR5b/wQhJfpwqP0wupe
	CgDxPZ9tPR9wURehY9s79ZefRiE5sd0ubu/oGQoKk/k9E/q36T5aAY4G38Fs2MVc+9/v53FxE1Y
	MKVlzuMBVnuhWzTqmephSGnSwoWI8K5dMs
X-Received: by 2002:a17:902:cecd:b0:2c2:27be:39a5 with SMTP id d9443c01a7336-2c412749c19mr43103815ad.33.1781287775593;
        Fri, 12 Jun 2026 11:09:35 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c70easm38956975ad.25.2026.06.12.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:09:34 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sayali Patil <sayalip@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 0/3] mm, swap: Enable THP SWAP for PowerPC Book3S64
Date: Fri, 12 Jun 2026 23:39:14 +0530
Message-Id: <cover.1781287297.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

On PowerPC Book3S64, MMU is selected at runtime, so macros like PMD_SHIFT
are effectively runtime variables in the Book3S64 code. THP swap code uses
these macros for e.g. to size some of its array data structures based on
PMD_ORDER. This patch series makes that usage dependent on the runtime
variable and provides an upper-bound architecture override for cases (e.g.
SWAP_NR_ORDERS), where the runtime conversion is not considered beneficial.

This series increases bandwidth throughput with zram backend for swapout by
around 40-50% with Radix and 100-130% with Hash (Tested by Sayali)

Note that this patch series is based out of linux-next (next-20260608).

v2 -> v3:
=========
1. Fixed sparse warning for swap_table_use_page reported by lkp in patch-1

RFC -> v2:
==========
1. Send the unused leftovers change in swap.h separately [1]
2. Changed RFC Patch-3 design from runtime SWAP_NR_ORDERS to arch override
   (ARCH_MAX_PMD_ORDER) - suggested by Youngjun
3. Dropped RFC tag

[1]: https://lore.kernel.org/linux-mm/68591daf0d679e5a0072d63751f187d14613e2b0.1781146877.git.ritesh.list@gmail.com/
[RFC]: https://lore.kernel.org/linux-mm/cover.1781000840.git.ritesh.list@gmail.com/
[v2]: https://lore.kernel.org/linuxppc-dev/cover.1781170904.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (3):
  mm, swap: make SWAPFILE_CLUSTER runtime
  mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
  powerpc: Kconfig: Enable THP_SWAP on Book3S64

 arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 include/linux/swap.h                         | 12 ++++++++-
 mm/swap.h                                    |  5 ++--
 mm/swap_table.h                              |  6 ++---
 mm/swapfile.c                                | 27 ++++++++++++++++----
 6 files changed, 46 insertions(+), 12 deletions(-)

--
2.39.5


