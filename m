Return-Path: <linuxppc-dev+bounces-27185-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F60C88E5C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 08:40:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjMDQ5lHZz2xkr;
	Sun, 13 Sep 2026 18:40:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789288822;
	cv=none; b=bmG9otm7da1Rl0dEeTuyRcTk/Z0CcNwJnrZTxuUNr9wRHTEGMvK8wWj36BI+Sp2vdpOODvhY604yMdDTQPbiVjIaciYrtcjD6id9E8UWi6rbeWgTnvZxRgfZTAX77mPhHL+y0a1MPnsp9fJ5gNHcIvhbx4Zoq2AQlSGeUG2mLpX/dgFiYBv7LugetqRJbXpeNDC2AOqsNtFLA31JXE4KYmbkQ0QcGix4RFCmX+w6kcUibmd1knmvtCiIwFpoj0mMnTCA67ohtHeSCVEhppVh4RJwXUN8XWzv66D2KF5H9303w12zcEJCxMLhcmEDjlpS+y2RAp/R0urAvM3O7oBhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789288822; c=relaxed/relaxed;
	bh=XEYszFcJNVmbdBdKEoxiw48cXUFgR+bqS4N4pNtc0Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmpH5gQCssDKZw3vF97TDzL4z5OnnaWh8wwbuVDP8F8i62d9gF7guhLFlC9h1xGrdSOprC7OpetApHsyQpGkWJwHWwgbVbdwQfJlrqnoO8tgV8ncnA1fyrakjSjwc6vqjz1OUAMlMS+WFf+/RmVyeeVXtbnAtUNhPTV8ztvo06ZABRQnOG+47DUGs1l2yaO8hpjcGRPU16l3w7G6vpPcX6Tnmh8i4zYrzZ7JAUIDt00B7abyBC02L5IW0X9OfPWI2TDRoP52GHbWGHeqMdsZF6s0yrHHFohKjFuUaaiGQhyvvRCka29AcDjii61X1NUxIIu4cnFJGllWhlrU5KHc6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YDj9w3Ml; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YDj9w3Ml;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjMDN6mtRz2xft
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 18:40:19 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-869d181419bso2144395b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789288816; x=1789893616; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XEYszFcJNVmbdBdKEoxiw48cXUFgR+bqS4N4pNtc0Jk=;
        b=YDj9w3Mlyka8XZy27lO5sDzFt5K/W4UexbCp8ueo89XFjZF4Jj/t9MnYXk7gY+tseK
         inubn8LfyvcHxk/ocqvPc3WGXojWkHCcbjms5JkbQWw1Tz8oaPVqPjHrq3GRjkdLrjEB
         CaSbU5xdvqWfQC/qZzwaUVhcfEz1rv5TiiIJSTbjAMHPnLQuIKq/hLMYuvoY3VT+hFwW
         X3PpG/Ad76c4yXm3luQZHR3UUYGwtHccIZWaPAerOPKuLqUqckzzSrI6tBZ5CPETSTku
         nSXwqVhR+aDcn/pVIFwad/nzGTqzj2MfArnWcSOOXIiB9BIR0d0u0tl1KQ6qLkoZtv9R
         rM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288816; x=1789893616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEYszFcJNVmbdBdKEoxiw48cXUFgR+bqS4N4pNtc0Jk=;
        b=Grdtbruq1caMgCAl8RtcxNK6SzJ970uOXVEZk6buaINdeIldnaa5juTdeWBWgVuUyI
         y+QXgiUHIKKlcISOdevkq1obkhRZ7SZpyLloETgtPBuSWd25oTekuqRr83j4M88IT3qB
         6LScp8VX8dZ31GbsFiqsoAJ5mu7gUYS2q0PPol2Wf+c5sFAMzDbN8+HayEB0OTR9Oy/G
         AefzusWZHTB9OOiCu4vzK2iL2wGMDhht74WXSmV7O5ddmy/W1FKlBAAgTyX9htsBhLEh
         n0aV1wDCHDyEzKiVorJFZ19HXH0dJxfzonqnnA93BcByr+7T2LYxNV7Wi9lRiuA0iTrr
         oiQw==
X-Forwarded-Encrypted: i=1; AKwUvByOFvzQgzfh9dDf0zriJZjRc0U7u8cgwKXdHha/Q2cdwnj5tEiIPLakywmoAmqqo382OR1IKAyKUMp29jw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kY0Wq8o/SmMQR9de9Tmnn3L0g7M4k+OzjgNmLc22Ajg7eIPB3g
	pA+WxB8mfXP3UWxE+2j1d4hUC8qBQFt/DP4I7xX0X8K0xtTsX1KvQ7ibZA5HG97ln2s=
X-Gm-Gg: AYBFou3I9XDCu/TjjGMhcOgqRlmM25n8q1KK41LKalqIn3R/gsUdVQzSiRPfI1Xu6yM
	5XMVj0Okv1O7iFHhKLsslXF7t3N5Ng10D5f1coAnNrhv2/djN6wFrXH/aEqzp4sIOslIrRTT061
	9FpRsXXlJP7eSig/bvXOaMLkX5sRuxCQysnNcZn1vvYH5TgqpDiXvgIHtFYqdwVibp3qPB4NSpK
	l1IIALpLcVMxKaOf8aUAoRhg98YkMrCvNWmBfplI6Xk+CwX3foB0cJkocJWM3ILvCxNSDwUOUSw
	YCH1wl6JbQDW0J1XtTX/IpafKS6dEYfMxCtXeHRGGKL3/xpHGnJgHFv0GB0XhKBzp8mysmmTc5b
	WnQ/fdAXYo5C9KeWFCxOSjSCLv13f/GrTupnDRf+LZYbqMVOYv5MwWmmpL2OR12ZG1uZhHTBEgx
	6Z0epdK3GBiaO68eo/KL1Rbst7ej42fgNjdaEfr1cZZB99iYOPUyY+re9AoP6PmBeRt5i4RCRfN
	TdfuYT1K8rmr7pM9JmRBUR7QmboK+v63Z5l7g==
X-Received: by 2002:a05:6a00:6c97:b0:868:7a65:d92d with SMTP id d2e1a72fcca58-86b32fef08emr19801366b3a.26.1789288816421;
        Sun, 13 Sep 2026 01:40:16 -0700 (PDT)
Received: from G6L4RL2QG9 ([2409:8a00:1832:cf0:5137:990:100e:cc7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb0d3sm3070531b3a.42.2026.09.13.01.40.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 01:40:15 -0700 (PDT)
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
Subject: [PATCH 0/6] mm: Unify Device DAX and HugeTLB vmemmap population paths
Date: Sun, 13 Sep 2026 16:37:28 +0800
Message-ID: <20260913083734.86802-1-songmuchun@bytedance.com>
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
through vmemmap_populate(). The powerpc radix implementation retains its
architecture-specific compound-page population and selects it directly
for optimizable sections.

The remaining patches remove the unused ptpfn argument, make the
powerpc compound-page helper local to radix_pgtable.c, and open-code
vmemmap_populate_address() now that no caller needs its returned PTE.

This is the fourth smaller step toward the broader HVO generalization.
After this series, HugeTLB and Device DAX use the same population model
instead of parallel generic paths, while powerpc keeps its
architecture-specific implementation.

[1] https://lore.kernel.org/all/20260513130542.35604-1-songmuchun@bytedance.com/

Muchun Song (6):
  mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
  mm/sparse-vmemmap: support device DAX in common vmemmap path
  mm/sparse-vmemmap: drop Device DAX-specific population path
  mm/sparse-vmemmap: remove the unused ptpfn argument
  powerpc/mm: make vmemmap_populate_compound_pages() static
  mm/sparse-vmemmap: open-code vmemmap_populate_address()

 arch/powerpc/include/asm/book3s/64/radix.h |   6 -
 arch/powerpc/mm/book3s64/radix_pgtable.c   |  14 +-
 mm/mm_init.c                               |   2 +-
 mm/sparse-vmemmap.c                        | 188 +++++----------------
 4 files changed, 50 insertions(+), 160 deletions(-)


base-commit: 383fc05d4650b021f3c17e36a145106dcc61a294
-- 
2.54.0


