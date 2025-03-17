Return-Path: <linuxppc-dev+bounces-7144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78F7C282EC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Mar 2025 14:23:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGccz4x5hz2yrP;
	Tue, 18 Mar 2025 01:22:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742221363;
	cv=none; b=ILV5vEbkhIQlORWavsrz0dkLcBS7PI0vub6+lKlW70XoSviECye+7YB7yhhudjdubqIATTZpYnqvIuahlH8Uu3eq3WVW5hPwFIHuIPcHSeBWrmU9Pyq8OpwDwJvg85cIFEVzAEe192UBneK4JZa7A4cVJRkFQQiEtzQir26nAxEIWsSTBKBY9XP86Mv7VWokyWKvFd5Gn0sXHBSWpRDOjQX/naIae9zcVvqsW0BZgNV/X2hy0kH7sVTbiA3QcrIAP2SCoiVes5yOsB+UVRxp94yZMQTQ657ALO4eSKUxBNvszFyKHDRTdafO9OdRzzcMZak6loAF6doJjkJVhDAD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742221363; c=relaxed/relaxed;
	bh=IFWyEFvD7taIrIds3ww1RZCtlo3XiqYGCEZ44ZgHvMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klNQr0Oqz2nK88zDT9IG0wbNlO4gB0TH7JbZ4W02f3UEnT90QRlb56yr6PyJDCgfl1xtcO8KWyguzyBrkjWZX42OVv+ZT0PVenT1g5Wgg297MqL6OerrWHUFlIo4BYz0t56D4xJm7fm84HE8IW/Q98+7ZfnkCKdPlGwn7CZffQvG3PrRTxX7hYPKawYuxQcvCGEEn3uHFqr7ku4OqH1Ma+rMtI63GGS9+XiFZyB5Lg48QrjXWlG1crR7pC0dQ/wE8derwLTESG+crhSIGKqzJdR4xJmFe3HPS+dJTfiiGZfPOxfbZQRBBNXojrGHSiRwSDbT6M2jYhNbOHmuRI0ecA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGccy74sWz2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Mar 2025 01:22:42 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D64111688;
	Mon, 17 Mar 2025 07:22:20 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEC523F63F;
	Mon, 17 Mar 2025 07:22:07 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 09/11] riscv: mm: Clarify ctor mm argument in alloc_{pte,pmd}_late
Date: Mon, 17 Mar 2025 14:16:58 +0000
Message-ID: <20250317141700.3701581-10-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250317141700.3701581-1-kevin.brodsky@arm.com>
References: <20250317141700.3701581-1-kevin.brodsky@arm.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pagetable_{pte,pmd}_ctor(mm, ptdesc) skip the ptlock initialisation
if mm is &init_mm. To avoid unnecessary overhead, it is therefore
preferable to pass the actual mm associated to the PTE/PMD.

Unfortunately, this proves challenging for alloc_{pte,pmd}_late() as
the associated mm is not available at the point where they are
called - in fact not even top-level functions like
create_pgd_mapping() are passed the mm. As a result they both call
the ctor with NULL as mm; this is safe but potentially wasteful.

This is not a new situation, but let's add a couple of comments to
clarify it.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/riscv/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 703c3648cfa9..fb18940113f2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -409,6 +409,11 @@ static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
+	/*
+	 * We do not know which mm the PTE page is associated to at this point.
+	 * Passing NULL to the ctor is the safe option, though it may result
+	 * in unnecessary work (e.g. initialising the ptlock for init_mm).
+	 */
 	BUG_ON(!ptdesc || !pagetable_pte_ctor(NULL, ptdesc));
 	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
@@ -489,6 +494,7 @@ static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
+	/* See comment in alloc_pte_late() regarding NULL passed the ctor */
 	BUG_ON(!ptdesc || !pagetable_pmd_ctor(NULL, ptdesc));
 	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
-- 
2.47.0


