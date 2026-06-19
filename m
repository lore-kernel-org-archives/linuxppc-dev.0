Return-Path: <linuxppc-dev+bounces-22781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA7CCD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 04:41:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghQ0Z5HHMz3bpm;
	Fri, 19 Jun 2026 14:41:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781844094;
	cv=none; b=cB/cSIcnC5zuwnWNM81X+kUXPv0eX5Ra+aFRiWYciTfwFN0oluMmMRb7p9ppb0riuhNZpksswsAet8qN+4KQQg8dLAXsg0COMWvHQeImPv6SlVo2+hz6jzZpXgrCqt50VIunWyWKqohD/PNh6zNr+ylbxTbuzbRaOCdvEFNMTtzXT5a4xqgprYwG35LPEMrY15F60v4voGc+IA1ksD7oI0wR7Hjw+0HxQQ9dDmvAdRi4VYbDDYvbsyNcipdQE6STVSdrl9DYQB1mEEXFrNZ9s9ERscVWA1yC9aeFP+9U3ykAskHFlcQcUx//+PkM9Cm5WAikaFBiwWWnhRtzBRVM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781844094; c=relaxed/relaxed;
	bh=ScGPgP09d6CTH8k9i/xxOIHmej0/0GzUcvmFJcghR1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBroiujqGPR7FU//sJLvjYfM0eTg+uOwr2uEoFOxZkpx+kOn3LvXc10KLLhjEkNbvbHQfrNWRlQRhfp9jGQlPtb1LnjXaGFC7roEt2+ZspCNg1X0rSRmlXAvdSDNEE/0yZ+dvaJTRetn5Y8bk7vQFjxd9EtCNCFVc6w3LCaoEv0eSddqAwHxHnX0TThXBtFEdUCN62tmzFEPVq5z+1b9N8O6ncGYmFl2G0pEgu4wFtwZKZCzLAvU6qLpaZw1cskyY5+eB5pi/sbcnthkAevLleuPMDGrwRDSaq2SKs7Xa9J/PdO4oT7qcFmDCLgi2GTuQYSX+itcw8rPtlHQaLnodg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hqLpOnZZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hqLpOnZZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghQ0Z0sY4z2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 14:41:34 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c0aa420401so10811685ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 21:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844092; x=1782448892; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScGPgP09d6CTH8k9i/xxOIHmej0/0GzUcvmFJcghR1c=;
        b=hqLpOnZZPTeuxS1h8Uw3lSuZTTWUzm8iy7vIq3IR3pNtCvWT2Uq6u8e5xs0X9nxvee
         YI7pUbNS1b8LEDCBLKQMLOiYfAitNSJVJ3HDGAV0YrLVd7e/fRMV2PNQOznYtETaWiwK
         IL3NLqCsDz/Mo46skm5NlK9+qFZujzFfqGobJ96i7reWuGysVZ92jk24619kmCUuD0fV
         L7kzhPXIGcdlHbCGouwPXQivYy8zTLwJofNDvHPykxqGfh9Vx4fm/qEM3EPHEIltaBvo
         Iutz2MI2WAS4uqnBAJdqahpVx5R0om0roIfLNSTEhnIzKVTqt833oLuV3qLR4f6fWuQZ
         tKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844092; x=1782448892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ScGPgP09d6CTH8k9i/xxOIHmej0/0GzUcvmFJcghR1c=;
        b=mGAWxyPBtndkDG7J25cPrGFNBkyag4kZMaUD+vAJv9GmysGxITdWEkibvOQZtB5TlW
         /W72vJC9YByKW8PIZgtI2t3DfgUB6RCnoffYmI9t094XtZSTaF0PGo6CTSD6Lk+hATpW
         Icghiae+9KzPXTnS3my3w04UGYxphYXhCdDPTt2I0LpxgL9GZFJ9LCW0POIdhXIzD89m
         b1zoerPouyRZaoO7sx93vZWNUvXJFX58hQvV40VICGkXUof8OP6U2quVDVqEMCyVRzUI
         +ReTwqWzIoxOLoxplf2t+Iz75o5EfojJaXffhvHfXOti5Hkggf0qZQvnEZIOtgKto5v3
         Bohw==
X-Forwarded-Encrypted: i=1; AFNElJ+K2os413GfnxpIwcpzuD2IGFpT+PdRJc4C3vzDnWhKj9WUCpMBOCk26VoeSVe37hlNhLJmuMUCY8t68uY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwAcpEpD+tVFCrNT7/gk2acZJ90E0m0gXS5d2ofdj0ZTWwwnD3u
	6W+iv8vLiAAXdDYfIY1VsoADTULQWzNXZtS6GaO+on8r1G7toPDNdIWQ
X-Gm-Gg: AfdE7ckAEXd6eJMFPw5/Q2ZLvqQOXP+EgUBuxG8oac2SrwfZ/mYL0T+4W4xewSWd0h/
	Zm2tsU1E26kwfuFP3bB+yInKAxPF+cGAubA3SgQ+mw5ZUeOobU1QT85Yga597Z0JVwmwXfXvrU6
	1Rn//0iSRBZzFdFvPaXWt51dRfw926Z6fykGzwmoxjT4PTzgVX4INctGSqRKiVWTZAX/i1h8wIg
	NwTc1n9Q5YnG4IWUjIAseOZuCenexjA8YnD7WOzw51jhOcS6PNaTgfQjSIHGZ9C/LzV0NGRcL9J
	DnkjDntQvUFP/Y73HGDcPtrLLa5Rnx69Xe492qGC08/6XPT6CTQQWL98cx7TC4DXI1808H0aEr5
	mYII2rZ1HzEA+q0d6GuTLdJncl4wcD895G7l3uch9awNxrcFEgVhO7NcOfkcO3I+vbUuGX/jW3U
	MwkdPyjYCFDg+FlAEypPNAEw==
X-Received: by 2002:a17:903:2b0b:b0:2bf:dd8b:7cd with SMTP id d9443c01a7336-2c725b713c9mr13974385ad.10.1781844092067;
        Thu, 18 Jun 2026 21:41:32 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208e5760sm8293735ad.36.2026.06.18.21.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:41:31 -0700 (PDT)
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
Subject: [PATCH v4 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
Date: Fri, 19 Jun 2026 10:10:58 +0530
Message-Id: <eda4e51ee9f1270582fbb2823ec5873e769de089.1781843449.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1781843449.git.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com>
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


