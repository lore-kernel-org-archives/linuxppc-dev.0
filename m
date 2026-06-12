Return-Path: <linuxppc-dev+bounces-22582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A905CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 18:09:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcSGQ4PXlz2ykX;
	Sat, 13 Jun 2026 04:09:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781287790;
	cv=none; b=OsZ0uTbhPJ3PuL8wgiUyVxYdBNT4Hyv0mSLjgXwQGm7A5a81f4zOTS89orY73c4vtkwxPzzbpW22q3VZm4Cw570pYTDP4hcNRlGL9HHlWNbhdT1rucUL2WT2oU6KcD78faEsV8fbrq7sFjA5vzAtIKr06yA+vjlPoh2XhCoJKmgGbKf8erpB2excTIJRjd8/3dR94mapPse4cB2PyzbclfAhMVCA6HZRzkO6UA0qITQJ2hCU1O1Cz2gDmycNVvoRwD23/LYGyeOHPMWteNMs5GdY5szDKl08UzryK1Aldoi01xd2mUgp3DgQEP8b4kwvlUbS25b3fAot0hui38cBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781287790; c=relaxed/relaxed;
	bh=ScGPgP09d6CTH8k9i/xxOIHmej0/0GzUcvmFJcghR1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpXsF3zS0bNkl8ZyoiE/3A1aJ/1FTDJkDG89t7dQl6g8IhmfpcWLL74a1TCG+vK2MfngdgPvx++PIGuN8nHDOqJLYZJT7i+SmRv+6NR7FMAQUhtggfYcca8733MBdSLDeKVxJajpi+lcFTSeJHiyOm4VSZenfN6eHJNWcCVnhgJO4lDvBrw53sLSjSI6mlK/Ky0qbcsjmPkoqcKK5jyhwSLCxFNbjKU1znZkc2sfWOb1yihb8AcGnJ8QYDM6dAXweHU9JcuEWBn8WnSwmLzNQf5ACXoxjLo1bYJH5XSSBXnWmZNAbpkJi6P5ymVHbxj2+pIKzNBeLx1yz23OYSBnsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YN/JD/Bp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YN/JD/Bp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcSGP6L9Tz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 04:09:49 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so9559115ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781287788; x=1781892588; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScGPgP09d6CTH8k9i/xxOIHmej0/0GzUcvmFJcghR1c=;
        b=YN/JD/BpLLbjFONUVldH1agqCoutCn3XT8FPpvoVS+N/dvxnrBg7/GFF4hwwvSq0MW
         dPaOgknNKnjotq0cKta/CSdRDUTYw0HgHQUGABFRDLFSl4OiRXIASQmfFg7uG3vIOaHE
         5Xb8JSh5Hg+aQ8bl0eBreVS7DzK3QP9I1pIICs6y5zWlNOf+Ea7StgImm+ESlmG9yOxa
         J9tgWK8xjKcoaPC00EYkBipY1wu5NolE3ErtyKybl2Z417U1aTTajEa4QTPRncOJoVwd
         upr/Tih0P3StWUwg78M4U5tz+LIJo4nwWa8PxSZGMzkevoAqCjpkma/EY9UJADV3f5jI
         HgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287788; x=1781892588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ScGPgP09d6CTH8k9i/xxOIHmej0/0GzUcvmFJcghR1c=;
        b=DNRUbfALkBd38ZBIKr5WABMvM4NE0hKw9i/6F9eDyw4rmQ5QeZoUgy5Qa1RV5eR4WE
         0rREQEMVLSJbQ/OxWUSL2Md/4+vx7Pk/u+xwWnY3GX4MeRb8Uad/iPc9dvO0wSdAqwc0
         b4xGbvRGeCrC9r5wTh3ucNWLQqWI637gSNsjLCLFdIEw0olD/waTnoAgtxyRA2s6gvXP
         uiW7R8amK3PRUjBk4XIa5KDHjjsgJRAEYRikzGjlStar7c8GEsapFPLlIp/RghgTJ88N
         ISuknJ1huI491yiSdeYlI8IOaqlJAPtcdIXsaR1xQvF22JkCneRbM/jAhZvBEnBFyPdE
         ek4w==
X-Forwarded-Encrypted: i=1; AFNElJ8k9xengYFDS8tGVGindBhOLogoiDrGNhdjAChASX2awiXAE4I0Xw8IkhJMH84Kaz4rLnk0Vk83tTaFlQE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyd35eyejHRiYxHYSFXIvxAR80nsX02r2z1x/Jnojnk/K+2qtwg
	XWYMT7RLmtkS85m+hAOzTJI9QMfp9EQ+Z6cSzoG86YYAiAdCsGkI11eMOEAutTU5
X-Gm-Gg: Acq92OHQjrjvG/1r5CV89+uHez1Xhjgmxg20VAqI9i0u+nZzcqe969JYuWxtQIaer3G
	KZeUZ11ePLIb81B3swr8MZB+AQAIqDPBq4rzPZ+8c5Yr70KVWfLyfI7cYKQtnZGtH2s1ljv0WKM
	8zB18XyHFGXF6INasXN2E6G0koxrkpg5UvVNlGdPl9hJhFidXz8SaO4b9ezzfdsQo1mZt4k0l+M
	LCaLd3U664ZFfSpsfk4LgQMHCTrBOddRoHRGeqb28Igcxsl0jR5QgE7vnCdBqnBt5k/uPv3KuIv
	p50tu2p/2bU0lk30KmFwlDpzU9wvOTpqSZRw5C8rtcINEVa0ybKwVk7B5n913oe7J49LdaT/Ddp
	nEy5N7pLrFQ5kDaVTLyt7jkt8ihkqRJm1SsH5lUkkZLX3IqQv5MnQmqzNVomrTj2OCm3shuHBcC
	Je9p24Qg6/iFTRIi7EyUklR2qiOJyDhAkb
X-Received: by 2002:a17:902:d48f:b0:2c2:1982:5270 with SMTP id d9443c01a7336-2c6641e28f9mr8104325ad.21.1781287788002;
        Fri, 12 Jun 2026 11:09:48 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c70easm38956975ad.25.2026.06.12.11.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:09:47 -0700 (PDT)
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
Subject: [PATCH v3 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
Date: Fri, 12 Jun 2026 23:39:16 +0530
Message-Id: <a1ca4510e1bd3090fa639709ffcf10430eb4c136.1781287297.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781287297.git.ritesh.list@gmail.com>
References: <cover.1781287297.git.ritesh.list@gmail.com>
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

SWAP_NR_ORDERS sizes a few small bounded arrays inside THP swap
allocator code (nofull/frag cluster lists, percpu_swap_cluster's
si/offset arrays, next array for rotational device). This currently
expands to PMD_ORDER+1, which only works when PMD_ORDER is a compile
time constant.

However on architecture like PowerPC Book3S64, PMD_ORDER is a runtime
variable which depends upon which MMU is selected (Radix / Hash), so in
that case, PMD_ORDER cannot be used to size the static arrays.

This patch provides an optional ARCH_MAX_PMD_ORDER (upper-bound)
override for such architectures. The memory overhead on enabling this
override is negligible. Even if we make SWAP_NR_ORDERS runtime alloc,
default slab padding could cause some memory waste. Also we lose the
per-cpu cacheline benefits (for percpu_swap_cluster) because it might
cost an extra cacheline indirection overhead in swap_alloc_fast() for
fetching si[order]/offset[order]. Note that a fully runtime
SWAP_NR_ORDERS was considered in previous version but was dropped for
this reason [1]

[1]: https://lore.kernel.org/linuxppc-dev/pl1zdksc.ritesh.list@gmail.com/

Suggested-by: YoungJun Park <youngjun.park@lge.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++++
 include/linux/swap.h                         | 12 +++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e67e64ac6e8c..7f22d5d5fbdf 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -204,6 +204,13 @@ extern unsigned long __pmd_frag_size_shift;
 #define MAX_PTRS_PER_PGD	(1 << (H_PGD_INDEX_SIZE > RADIX_PGD_INDEX_SIZE ? \
 				       H_PGD_INDEX_SIZE : RADIX_PGD_INDEX_SIZE))
 
+/*
+ * Compile-time upper bound on PMD_ORDER across hash and radix MMUs.
+ * Used by THP SWAP code. Check include/linux/swap.h
+ */
+#define ARCH_MAX_PMD_ORDER ((H_PTE_INDEX_SIZE > RADIX_PTE_INDEX_SIZE) ? \
+				H_PTE_INDEX_SIZE : RADIX_PTE_INDEX_SIZE)
+
 /* PMD_SHIFT determines what a second-level page table entry can map */
 #define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
 #define PMD_SIZE	(1UL << PMD_SHIFT)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8f0f68e245ba..317168aa2db5 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -229,11 +229,21 @@ enum {
  */
 #define SWAP_ENTRY_INVALID	0
 
+/*
+ * ARCH_MAX_PMD_ORDER is an optional arch hook: a compile-time upper bound for
+ * PMD_ORDER across all possible MMU configurations of that arch. It is used to
+ * size SWAP_NR_ORDERS on architectures (e.g. powerpc book3s64) where PMD_ORDER
+ * is selected at boot rather than at compile time.
+ */
 #ifdef CONFIG_THP_SWAP
+#ifdef ARCH_MAX_PMD_ORDER
+#define SWAP_NR_ORDERS		(ARCH_MAX_PMD_ORDER + 1)
+#else
 #define SWAP_NR_ORDERS		(PMD_ORDER + 1)
+#endif /* ARCH_MAX_PMD_ORDER */
 #else
 #define SWAP_NR_ORDERS		1
-#endif
+#endif /* CONFIG_THP_SWAP */
 
 /*
  * We keep using same cluster for rotational device so IO will be sequential.
-- 
2.39.5


