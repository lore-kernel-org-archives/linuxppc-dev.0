Return-Path: <linuxppc-dev+bounces-23217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C790C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:04:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqRJG6MDyz2yfS;
	Wed, 01 Jul 2026 01:04:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831870;
	cv=none; b=JN8Js8Rwp+tX6jhFvr6+wLDsxwHmYGpk3bpu7J7zBwEjcAqenVOHW1G+vGs1jKKvLrhbmgivCFenhIfveD8rSJhjyE4kifMXxZ/bBf2lH/aJyZi54mWw35fJRGWgnqvv++JnNhkZIJoOJzbhK3yRcvyfx5asnYtGxS9QGLKq2Ag2kUN71ichpcLQNkSn2Gv59cjfptqMLSQqBAE2agnXLr5w9/tlUnrgGf8v5aQdr303f/m35TuKl4a7YAGXFx0cq1lr5rUdXVSxVNMw9GS9K6l7uzGUwzXRq5OJsE93V6o0l00u6BfaiqiOmkuowckCvJGM1mZ3YifKnWBZymva7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831870; c=relaxed/relaxed;
	bh=hkhDPMkIn7o4S+p4EJjWg1/vRnrXI2zfxcLsfb3CwqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPQSXov1DZb1UkAeAKU7zQ9rE4ywFVo6qicnl6nPM/o0gbN6vPBzSPH8KAdcFDp1WiS+OhBgPWN8pJ7KyR2vfTE5gEGy/Y3lzlr0zPGE1YruZ+LhY318c5doVVwIBKQMQDETwjf9PyM7mg29GWyKrAZqz/PT2tqXua/EMVffgajrpGHqslxe9NKdOuWbbIPODX546Wza+cNoANgHf/MwscebvfuMWBENQKscuFe6CMePbjnox7wk5xmqHFAMNW4b4PCXJ1XVVrfbttlvZ0lCvvjIevfemYUPOTTynuXHNKgXOGsq84qdtBi4GC7tC5s0EuxkEroKsNsN9lM0LF1UJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FW96KiJr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FW96KiJr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqRJF4XzBz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 01:04:29 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so25224195ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782831866; x=1783436666; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkhDPMkIn7o4S+p4EJjWg1/vRnrXI2zfxcLsfb3CwqA=;
        b=FW96KiJrGUQCXaO6y6OWsdZ8yblpW5zIj2DP5FuZBk6buUvz2MOL2llFMVr2NpysPB
         ytoBtHYCsauClAdkaJfFz+VgSFLNQR5rF/DokjeotIzKPT+iWxRHHMvXQ3gtl77e11ad
         CH6doisHlKTrmveADvLwYIIhVWrx0W2hza06qBRYMdSBKTj+8mhTPRE8RXb4gRWsSBlM
         p7zTh0uFeY4pb3xXTWaUfXji/vjAygJed32tCVUA/CAQxNJwzzrqsNxyt3Z1RsefPPpf
         RVgBDUVeGDlRDVNkbYkPm/UCOTtI15AhUGJwf5/pSiNGdtf/dHQh2nMIj2JNYdQJaPos
         nTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831866; x=1783436666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkhDPMkIn7o4S+p4EJjWg1/vRnrXI2zfxcLsfb3CwqA=;
        b=gZglo/hkveRk+xqn8c7GBAKcQVr5RTZcBsJUjTAzId0x9DAB0Ns3H+rV49aAmGPt2S
         f57pPVx8cpkXo02/xxZHFSE+eNtSsc/wFMQXNtomTv374icHlQBXwI/yrxYpta2HxFNV
         1OEUwS7MHKtdOtA4zE5xXOgXbDXyahPylUXzO5KF1wiUEZQIzS4n4lSca+FMq6eC8P2z
         TGVVQDFrwJgVuhTiJ8eMfAo2+sHJ7prUSIbfAEhaNRj1l7fDqL5UgrQfuDn5BuMtYJS7
         vOta0fPqY5y+RsR0dBU0V6sF7tpTittZe66SJmQwCyAMS+lWgAquasF65uO908U6Ru2a
         X7VA==
X-Forwarded-Encrypted: i=1; AHgh+RokqfuruJmuXQIhNJrLnyY9o5hFrhcsdiCwd2uZMVQlIlTI0UShlB86MohGowaWk3mEavkk3k4yBIWVMSs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVgmb3qOsVISIRA33NqrC6okXbd0GYqL3pcShU3u66RyyWoGdj
	19d8YXYwCoD6OBzrdE2U3uxPf8ASaqPxEGGMRJuGi9dw0oefJMm3vqkb
X-Gm-Gg: AfdE7ckIu3CNKWjyR1TVRFPMmBplupoCzFfqEot0FAjZk13MY8Mzmlc3g5vm2QcUiZh
	b88IowUqsPfQAj1uRWkbU+cdvEq4qeXhI8b8I6RasycXISkdVhsAsMdq5fhEGcS6VWRTQoLejEe
	z7PGweH6jzx7ogxOQVWwiKnG4Q8zH1lOUw5GfTETE/L0DFefbxqSSD3h97aWsWJubxIebQmB7VS
	xnWrpELnhFm8piEE+pFARBa2IvaPGJV99Cg5+d0ztgc0rN80D8qpgyR/mJpbAncqRWScKtLCDtZ
	/GG62PCRgyrATvVie3VUUSO18Nzh6WzP6VoWlfHgPPmsdO3+oje+0GCSDoBJpyMIudMtm4/YjG0
	Ap8WBBlbAPQqjLNP8+OxOtvPMKMGmBlwM1duL7AYp8SJKlYTvuu6hXE7T0M8vQEui+P2tS+7VCb
	Om0u0yjp4=
X-Received: by 2002:a17:902:e541:b0:2c9:97a7:71ac with SMTP id d9443c01a7336-2ca2ea23674mr32988355ad.39.1782831866110;
        Tue, 30 Jun 2026 08:04:26 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a70bc0sm16250465ad.10.2026.06.30.08.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:04:25 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	Nicholas Piggin <npiggin@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH v3 0/8] treewide: remove unnecessary invalid range checks in memblock iteration loops
Date: Wed,  1 Jul 2026 00:04:05 +0900
Message-ID: <20260630150413.1718632-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The memblock API guarantees that for_each_mem_range() and
for_each_mem_pfn_range() never return an invalid range, meaning start is
always less than end.

Several memblock callers still have unnecessary invalid range checks in
their loop bodies, so remove them.

Patches 1-6 cover for_each_mem_range() callers. memblock never stores a
zero-size region, so the range it returns always has start < end. Some
callers apply __va() or __phys_to_virt() before comparing, but these keep
start < end too, so the check is unreachable.

Patches 7-8 cover for_each_mem_pfn_range() callers. __next_mem_pfn_range()
skips any region that contains no whole page, so it only ever returns
start_pfn < end_pfn and the check is unnecessary.

For reference, commit 36ca7f4be809 ("arm64: mm: Remove bogus stop
condition from map_mem() loop") did a similar cleanup in arm64 map_mem().

All these checks are in different trees, so I split the change into one
patch per arch/subsystem. The patches are independent and can be applied
separately.

---
Changes from v1 [1]
- Add review-by, tested-by tags from v1
- Add missing simliar patches(5,6) to patch series
- Change base to rppt/for-next

Changes from v2 [2]
- Remove unused local variable and braces

[1] https://lore.kernel.org/all/20260621145919.1453-1-ekffu200098@gmail.com/
[2] https://lore.kernel.org/all/20260629163736.1606688-1-ekffu200098@gmail.com/
---

Sang-Heon Jeon (8):
  arm64: mm: remove unreachable invalid range check in
    kasan_init_shadow()
  LoongArch: remove unreachable invalid range check in kasan_init()
  riscv: remove unreachable invalid range check in
    create_linear_mapping_page_table()
  riscv: remove unreachable invalid range check in kasan_init()
  ARM: remove unreachable invalid range check in kasan_init()
  powerpc64/kasan: Remove unreachable invalid range check in
    kasan_init_phys_region()
  mm: remove unnecessary empty range check in
    early_calculate_totalpages()
  mm/hugetlb: remove unnecessary empty range check in
    hugetlb_bootmem_set_nodes()

 arch/arm/mm/kasan_init.c               | 6 ------
 arch/arm64/mm/kasan_init.c             | 3 ---
 arch/loongarch/mm/kasan_init.c         | 3 ---
 arch/powerpc/mm/kasan/init_book3e_64.c | 3 ---
 arch/powerpc/mm/kasan/init_book3s_64.c | 3 ---
 arch/riscv/mm/init.c                   | 2 --
 arch/riscv/mm/kasan_init.c             | 3 ---
 mm/hugetlb.c                           | 7 ++-----
 mm/mm_init.c                           | 3 +--
 9 files changed, 3 insertions(+), 30 deletions(-)

-- 
2.43.0


