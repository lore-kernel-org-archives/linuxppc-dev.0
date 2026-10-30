Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF151606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WbADtghM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGNHP1fhGz2yK7;
	Sat, 31 Oct 2026 01:08:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793369313;
	cv=none; b=KFgiN3Zx4gNF2bvPz0K6oO1bu0DWTL4w9XvwqEYjVDlD3kkLRR77MZd+ZqqKDN+vNBX214TAGcEQtXmZlEXQiUFkZcjMgzUbZx+CdWH9nuMDy0c+xNgircYIg9tsCh+bJLX6xu5o3aMHsu+qXb+S2ub1Vzi1RrMn5jRez5QP5T7RbfwtA3HQ+6HvwPDspDHnlBk4ugCv/0F80AlpkXL9x5AF4gU39npLb18sxcAz5LYyXKEeCSKvHCGED7G+9qgeqYYk9UHOTQutRIbo7LtpiK80N6+p5skwrpjBwQH8mdPK9KEYdCqvFWFmcwfaEfbt/C06svUynmJqPFJ9U/pz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793369313; c=relaxed/relaxed;
	bh=OGrdsvz70oET1GgEqFqkefkFXtM+kYm4wLwbKsNMt9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQ2czMMrN6/t18z/oZj3o+DYKgsnEmlmkXHC3DHBhNzGM0Q4PtIXYIrE8ycaUdZHsaDhIi0nrSziSOSgbgy+Manoc6vp5C7LTU4yXCAm/3zTCkWr+fqPy3J0ObZKCoX/k8zDzFysY0vNmEClbjw440o2trTyxm2CKmwkbL9/PoZWkZxETnJwMdQRTvrG5qvxpTREal48UHtcbFzsOy4ZedoV+9spYoLrUNZoLVryRrXY5OVUUIYf9M6U1wPTZIxFICL7SuF2aRGdzqwd6afkuFFm3ylgkXgeaYR46rIsgSb7faToz5PNJyoX6QzhK7bl7na2vrXb2YsJIuo2r9N6sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WbADtghM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WbADtghM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGNHM3Sm3z2xln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 01:08:29 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2e60f9af6e6so7116565ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793369307; x=1793974107; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGrdsvz70oET1GgEqFqkefkFXtM+kYm4wLwbKsNMt9o=;
        b=WbADtghMpV1m0VKDKiiHOy5/ESvbS0QXCekpC42EoOpRJRxSis6Hh+M5y0sNfMJLgF
         KWxFMg2MnMJp2oQ2GwyV2mMXeudn7LfoyKR42MD2nPlWc9kRJ27CJPS5R78SS7xCof7q
         mddB40GB33sY+KXfxOej9Qw0IOwgDieBqEFosT1ix27b3Y4kwMS0TXCw3YMJ5xplU2bh
         fOH5/vjtswr2uRZdqqgONizx49tYYx8UxljQ0Ptywj/4dFk1mAFF1pxmFf7fH3CYSiiL
         DG5FYUyGDhGPPNAfIVmmOfOZ9yoJ8KpJSf07tvzMbPsXR3v8mpduwFcrRGvUFHL6Fyj2
         uE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369307; x=1793974107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OGrdsvz70oET1GgEqFqkefkFXtM+kYm4wLwbKsNMt9o=;
        b=cZJT1qeTcQjYumir3Irhfw04U66qC1/OH5/pqWy2WDZit6ZIRv0f+NdiUECjdhmsCA
         2htdfjjwOLewYv6A2HVv/hC1ywC2pKmExi+qjsJXCN5D7aQEuzIHLvxAJqQn+2gtv28q
         2VpuWesc7ji5JQmQbUKeoxvq4CQpWzhC9YByWfE/1nvqWJMS1gl41Tp3lzSzk/gm16a2
         IDS9ZM9UxcWFcgFE6Fuo6ZFktbAQ6y1p0cAyMrXcpeU39Zv4fVZPCquC3l3/I8ecFBTs
         +Byvp3buhEpttx/XShjGhsGhuMqWvcBPgK0AxnfzUeod4G0SmxhhmpEcEPCniw+y0xkM
         nKOg==
X-Forwarded-Encrypted: i=1; AKwUvBwl/JFKNA1EfW6zmH6vZ9LcM8jluQEGRTGQthwuitdAxOIYxPbwgEfXOWrVhzhDWYislvy0HIEAfZBo1Zg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI+1qJL+MfnVtBiw2MFlFbUpd8l430UbjZaDVvQMAwJKRWOaRfG
	pilsBqMLIx/RQ4MRqgwkG0+g+7nD2rKETld8OYoCGxQIkEbXduJgbCGhKx2nO3UuY60=
X-Gm-Gg: AYBFou118KJXuSO/LlloY5ioImnRCO2cA44GnYFJ7ZJdZ7STYqneniKGkauoJ1dfkFc
	IJUwTlmuCKou18SE3dUisAcaTaGhsIPXs6I+ocQ/nGMaSIkCS8kyDgr7zU4vMmjPtl5pyFYQSpb
	8OosmT8ORQdXTKGJe4+dlE09R8nN3aeSO00Ou3Pt8C1MBdbPONTkNrpITGM4yMdWYXhOMZK0iU6
	bTTS5Q/gJoPxpUldL7LxA5Je1EERFv2h9vQsafPXCm4+NS/DjVvIpdEODLy1OlgvoF9TvLG5beo
	wZv0l9HDPR/Pj2HSN5H6R56oKJCojGwIBE39DF44Y9lDaSYk4wt1zd0Uxkz5cyRImBpDdee8Exv
	drYAgPOeGIE5rbgGHdKgWHDAi8jQnNto5oaOmLjA54Jw9gbz5ezBMad6Rno8B4M5In5awGi+6X8
	jTV+XhSWgNGrP2V7Q2VTZu3ceQF8ygibMZEu37uPa3hi1gjhxg6WubaEPCXafM4/fI3Fh2LGmVv
	JvkAWJSPlUvq8lY46MpHVjDTNzacRpEIWBltdCp0q5Vgt+pL+pZf/1C1x7BiHRTUEHclZONapeT
	AktcED0TzSvJGpVqgXtJGsS/vDimOqiMWua3ZBtdxWCAW1vT/6o=
X-Received: by 2002:a17:903:24b:b0:2e3:1bb4:610d with SMTP id d9443c01a7336-2eb364f6800mr27744295ad.50.1793369307550;
        Fri, 30 Oct 2026 07:08:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm7601795ad.62.2026.10.30.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:08:26 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/4] mm: Simplify device DAX vmemmap optimization plumbing
Date: Fri, 30 Oct 2026 22:07:16 +0800
Message-ID: <20261030140720.1256062-1-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series is split out from the earlier, larger series "mm: Generalize
HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
vmemmap optimization across HugeTLB and device DAX, this subset addresses
a single, self-contained step: simplifying the device DAX vmemmap
optimization plumbing.

After device DAX was converted to section-based vmemmap optimization,
whether a mapping can be optimized is carried in mem_section, and the
architecture-specific population path can handle any remaining fallback.
The code still retains the DAX-specific vmemmap_can_optimize() helper, a
PowerPC override, and @pgmap arguments threaded through lower-level
vmemmap population and memory-removal interfaces. These duplicate the
section-order policy and keep otherwise generic paths coupled to
dev_pagemap.

This series removes that obsolete plumbing by consolidating the
optimization policy around memory-section metadata and simplifying the
generic and architecture-specific population paths. This also eliminates
dependencies that are no longer needed once the optimization state is
carried by the memory section.

This leaves the section compound order as the single source of truth for
vmemmap optimization and decouples the generic sparse-vmemmap and
memory-hotplug paths from device DAX.

This is another smaller step toward the broader HVO generalization.

[1] https://lore.kernel.org/20260513130542.35604-1-songmuchun@bytedance.com/

Muchun Song (4):
  powerpc/mm: make vmemmap_populate_compound_pages() static
  powerpc/mm: drop powerpc vmemmap_can_optimize()
  mm/sparse-vmemmap: drop vmemmap_can_optimize()
  mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs

 arch/arm64/mm/mmu.c                        |  5 ++-
 arch/loongarch/mm/init.c                   |  5 ++-
 arch/powerpc/include/asm/book3s/64/radix.h | 12 -------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 23 ++++---------
 arch/powerpc/mm/init_64.c                  |  1 +
 arch/powerpc/mm/mem.c                      |  5 ++-
 arch/riscv/mm/init.c                       |  5 ++-
 arch/s390/mm/init.c                        |  5 ++-
 arch/x86/mm/init_64.c                      |  5 ++-
 include/linux/memory_hotplug.h             |  8 ++---
 include/linux/mm.h                         | 40 +---------------------
 mm/memory_hotplug.c                        | 16 ++++-----
 mm/memremap.c                              |  4 +--
 mm/sparse-vmemmap.c                        | 34 ++++++++++--------
 mm/sparse.c                                |  6 ++--
 15 files changed, 54 insertions(+), 120 deletions(-)


base-commit: 5e6c45aaaf93343c7f8a1cde9797080238af5c1b
-- 
2.54.0


