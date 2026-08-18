Return-Path: <linuxppc-dev+bounces-25937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB570C5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:01:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGGd1zQhz2yYq;
	Tue, 18 Aug 2026 14:01:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787025689;
	cv=none; b=YhGnzr+CWnknbAnJLDshI4thJRZktJ6NUfskzfsIzeQ+FEitmaBL3o3Q6pZWriMWm0zpiUREHnyu1NgsAwg98W2XeBGFhr22r9fOMLeTQAtMfpGN5B79Iyl528B0b4DqolqdVz23VgZDRE22q3LPyMT/ECGehBgWi3pnIpySo26d/lipQ5VIrQ8yVYGURlkFF+A2xrZ+UVA+0h0xhCCn8wdD8BZZG7Ak58B5AY6WrbBRPeKrsKcuXkk7cZL4smgaUT45xgOffY8UWniDpoLzIouTrd5oHkpRmmeaGG6IHy9xLlu+yoFtcd/S4KifTe2VGftk3/ONbC3sUj16vhM9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787025689; c=relaxed/relaxed;
	bh=/1goycZjc9fa7vdpkGr1s93sKilynT51Ho35yadE4IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meSB8bYR5Nhcf87lI4hlpWS3WNDQgoiKpqrC2vljumfDl77SsGjWc5qI+wZlweeYcsOkDVXQWedLKPHzXd7XEfT27uHcDhYXU143QEPTDK26iThfwXoauty00P9FfdtrIlmb9SuyrrB8K7hshE4bScBwBN9Pxq35kBomgle63EslYs0FoCIIMNGRSYvNZalJ98IxihljFW9XZIchp8CcEzKTUektRqV0ldvtTHe0OYmT1VqfQZJineJWyqMhVGRzRwXd15p6qXpMXD35JmabqaCJaMWahpfVT4TUQhKvwtgaOqSARCAg78+raOPZGKJjw0wFJF091SZd1ltEaAMhnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y9O89JQy; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y9O89JQy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGGc278Jz2xxr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:01:28 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F21B19F0;
	Mon, 17 Aug 2026 21:00:52 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CE443F66F;
	Mon, 17 Aug 2026 21:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025656; bh=gvoumZ1mqXkMoeZql0lSWe/WgOn7RJynulYHo9T6RIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9O89JQyRqQ99Ip6I5SMUpHO4W28lwAqA2qQ+OKQSGxWJr89SaoR/wtggTE6HGy2w
	 HqMNRSDsvGkmDDhGrL3ogwDzNoudsgFh4VO3YmzItUimTXFbhBkwBOd2VWMP9W94UP
	 6KX+q/3TgiOZkxYB/5NzoHl/Y9RFVVAOm6h/P+14=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC V3 3/8] loongarch/mm: Stop using pte_ERROR()
Date: Tue, 18 Aug 2026 09:30:36 +0530
Message-ID: <20260818040041.1891769-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
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

Directly use pr_err() in __set_fixmap() and drop pte_ERROR() which helps in
eventually dropping pte_ERROR() macro across the tree. In this new printing
__FILE__ and __LINE__ has been dropped because they are always the same and
don't really add any value. The new ptval_to_str() helper is being used for
converting pgtable entry value into a string. The error message itself has
been cleaned up as well.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in RFC V3

- Cleaned up the error message and used ptrval_to_str()

 arch/loongarch/include/asm/pgtable.h | 2 --
 arch/loongarch/mm/init.c             | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 223528c04d73..a32a8fff70c1 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -128,8 +128,6 @@ struct vm_area_struct;
 #define ptep_get(ptep) READ_ONCE(*(ptep))
 #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
 
-#define pte_ERROR(e) \
-	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #ifndef __PAGETABLE_PMD_FOLDED
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 3407030f3e7a..b8d6c3cb4565 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -197,13 +197,15 @@ void __init __set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags)
 {
 	unsigned long addr = __fix_to_virt(idx);
+	char str[PTVAL_STR_MAX];
 	pte_t *ptep;
 
 	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
 
 	ptep = populate_kernel_pte(addr);
 	if (!pte_none(ptep_get(ptep))) {
-		pte_ERROR(*ptep);
+		ptval_to_str(str, pte_val(*ptep));
+		pr_err("unexpected set PTE at %lx in %s: %s\n", addr, __func__, str);
 		return;
 	}
 
-- 
2.43.0


