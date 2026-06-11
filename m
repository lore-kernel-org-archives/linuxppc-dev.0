Return-Path: <linuxppc-dev+bounces-22475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46D9CD98D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:48:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbdBC2kl6z3bqh;
	Thu, 11 Jun 2026 19:48:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781171299;
	cv=none; b=bbSWyske5Zi0j042bsaJswvr//08ahEXodxeXVJInobfK2NKkoDALLz3M+ajT4CAmlbz5xa6SrIkY4lSTPPa6qB///ZuxUwi1CFyJ1Y+jo+wK0bPO8TeyE7HuiOAAiCWhwpp4VqT3HQH9G69rsw9csB1841bEcdqNhGALXEQdO+PdW/74RhkMAnEUaSscirXGpk4SDwf2ApZEOLlg+qJvgjbpUIkxJUTyU9XGg6Q19/iH6hIyFfDczoim6mO1Qy1trF5vpZ+vFn8zgKx2yl6g/rIt7mBX2DSDbIKLYOHT4XZntEs0u/OzlLCLi1ybYozmgILbv027lxebxzJlxt3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781171299; c=relaxed/relaxed;
	bh=0kbz74MU7QErdxN5+g1e14+NsDJyyX6Cj5o0sAgDfuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJeGMCBKma8/88Xe2hHE5nL07TEeaPF1Lh+u5l7I5IQ7a7GdUJdbFgF9QVFwGKQCaGlHdtTLQXRU5wv0Hxoo/7P+4ChwZ56bw6yvsOuwa60euYM533PkhfZkOZZ3dEJv0VAYl6UNlQ6GmZvKxLFRjz3Wj23EVvmrRfdPlXM7SvmaS6cKIv3iRYgLNn1SLeedS2jfcuxiqOjIazfM4tf09i/IoRqcC961EBvYYyYgFWgfvNkl3bBNef4iTfICLrHRuqa20s1AoOJfqoccYwREdya322DYFU87QO1nfoQi7PtRPLI0e2KgILN4m8wDLV8b82N0c6Kyl9XQlKUzL6bMxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d+RDhw5/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d+RDhw5/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbdBB54MDz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 19:48:18 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2c0c3546924so51994925ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781171297; x=1781776097; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kbz74MU7QErdxN5+g1e14+NsDJyyX6Cj5o0sAgDfuo=;
        b=d+RDhw5/05rdz0BcxdxFe2N/J8FQ0S2X1h5O6KqrNVARHYX7r/BoRpm/xCQb1czm/0
         dsvr9ldAvo3JXpGJkg2AsrUtDKeCA2lXKI2c9dDJZ8DeC3FRK+OFKa6ziCWrIkvCFZEk
         LCpgZDJ06UFj1yepp5svXiG1bofL/BWLXYcVasFQz39nT/ytO2CsKt2jiyVUbGhGSWNP
         XzF2mAMAPAq+55jGLMiz/E/IGPM1vuIvMtjaCT3KRBnoTjAIfBwvFsfXYro3j9xJsjYV
         xCwjWtlCEClXE6kh7fFX78TRCfHM0NchrlceAAgWH9FGD7+neaFYA0VHFT3KI+ZBlkPJ
         3loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171297; x=1781776097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kbz74MU7QErdxN5+g1e14+NsDJyyX6Cj5o0sAgDfuo=;
        b=MYF/xOcAvYDtW4Ri4PlgRhlKINsZ3+/l6OAOOKm1Of5UfbEn4zCCvFrsgLlO+xC3ng
         9vuK3shPogBDuNd+tDOtJ/o06YCZudzlTF8Yq4Zmi0gFhGjE8ENrmxXNwaWPOhRuSs3+
         sXBl4zPm4dq9gBl6pNDG6GZjpnFW1v/rpYYdNjOwZ7FzO70VTmP1NUfHLBSY7a2R5YeP
         txy/ixXl9/yMyBnPN9aj3YOHVR5lhf1XVZ/iWtQ+ndVnwJ2qfGCvc8UBKfc69wHTSl/c
         hrCypFWl7huXa1kDymV5CqRVlBPxGDBti6im/R4miJZSjd5SAWx0Mwi6SjEkIqMjo9pn
         tmDw==
X-Forwarded-Encrypted: i=1; AFNElJ+8bOGuKUTYYSoy4Op2xUDas973f95xTcJqtXQXORKUSE/ByFSGBQO5tAPTg5DSYj6nDzQ8D4+BkV3zPlE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDiTOb9iZH9DLX32LELgaZDpNRtAoLe5JuLn8+oxHQr3J6xrm8
	v/2TCtp24n/jpa+IMEBJQFbv1qZjE7VyRoy5aii+w2dNVnf09McSPgtV
X-Gm-Gg: Acq92OHzu0KhVNr6DA8TEH/gYmYyb2oP726dctkgcBa4jO1/5EXdcZPj+y6ihVySABx
	waN4WgTJVu/scUwFjXQ+4W82tDleJGalmIdhqUAv48f1oI7IuHM4kJg3OLJ/deRpf70ki8i/jF6
	v2KM2bgtEyI/frJ/awmJYMBCdqMuu1izP+wRzY3+ITJVC/BTUNNbyWQMirXFUiUy1IG6QE25nd/
	HoD2mtX8u0ROe1ogoikgLewNjJX3ZkTBxi1lZ7br4DhYq4B9jcbdNzdkKmMytXCs79dRbgfgURm
	Rs9RRJIsVWUb4AZa6DaewaDi/OJ2i3+mYugyL/SmAYjvkAIQBBkfR6VYnA4zl3p/pB+ZoTSf1s2
	F9L4Sw+0eolNERqmwuJ3xpPVgtKSUQm2lio8ssROMiSj7i429VyCPob8T1M/1FFHYkpwK+lKmAr
	LSCyB+8vGYzhfXX6lKInewdlNFhhWYKdh5e9EGfQEnESQ=
X-Received: by 2002:a17:903:247:b0:2c2:bd05:dacc with SMTP id d9443c01a7336-2c2f0f11c2bmr23663225ad.16.1781171296415;
        Thu, 11 Jun 2026 02:48:16 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm283324905ad.60.2026.06.11.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:48:15 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
Date: Thu, 11 Jun 2026 15:17:52 +0530
Message-Id: <4821927908f81632fb2a3724d4ff99fe2a946506.1781170904.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781170904.git.ritesh.list@gmail.com>
References: <cover.1781170904.git.ritesh.list@gmail.com>
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
index 46c25523d7b8..4e1701b4a565 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -223,11 +223,21 @@ enum {
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


