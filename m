Return-Path: <linuxppc-dev+bounces-25713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F28C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 04:22:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJz3h1fXpz30N8;
	Tue, 11 Aug 2026 14:22:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786422128;
	cv=none; b=Avm2N11yWMC/BAJhHqNk4m+e8SEk3/n13hrAHHv43mT+9zmAHvtVuP8WUuRqmrI0wI1q6ESMmcn4H4o+cocU/pyKqwjwrL4ELZMkw6iRqZpXR69IowBFal1sel19HTIRvroBfIoQHmhZmtomukht0JmvWPm1hbbVOOl9g/aqqXZnAEvSK/v4jROioDH7ohyS1W7PVmEqe9LcDt/f58+nOEM7pQlf5lXEVj84QXPpTsazL1tUCncFi7rSxdEl9scGVLaWp3E9W0XN97t3rx79cFMCygOATr6P3ilaXHZ9t9X4hltyfO7lh0GqJ5/BZIb2/vzv/vsB0jovCqXARt+GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786422128; c=relaxed/relaxed;
	bh=EI5j2f3e0rorVshjGDKXnzZx89bDqNn4XV41gU2IJnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+/S6yt2oF/ErlxRV5GGHFBG6grqAqioS2OvF4AyqEpPDHeZ7N9RVPT244/UpZUIU5omggJ0pFO8Ywmx8EeftYtYrkYIo0x0K+XFAYAsHuzC6xUbHfZtsrR9WPILOInRjmgqMJu3zOBYxqQoE18A4JiirlkepIA9s0HoPQYM4LyDrnoAd5aMmonGE7jS7kP3W3jyI91SoO/O1J4k+uf3VTai0zEexcAExCJy+vjiYoM5r2Ln3VZXRlco8rNCx1PrPouKTwF2JToGWqWi7pYV8sKbFhF+ipIPPxYyzAlYaT7knrRAImeELENfzpyPb1SoOSC5KiLG7E3IXyDVZqfTbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eWCiC7xg; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eWCiC7xg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJz3g2SXZz304r
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 14:22:07 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D0F1688;
	Mon, 10 Aug 2026 21:21:32 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BCE93F673;
	Mon, 10 Aug 2026 21:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786422095; bh=pfMAQ/GDECbmwo/qWefWNRsbphdRQF7xgYQeIgh1v4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWCiC7xg6Urch6e/NkyTz2nx1jVxQ2+lXNNVl32VkpGHIvNOZKoKK7OwvEvBfhSEE
	 wJbBJKEACAKzuY3XWRWmEiavQBuGK0AQKUazXEqU1d31lkT1Spev7terS8Toxwdnjv
	 EicAFdP1tvM9H1F3vee9RdSt/Ezcn1ReEpkjAW58=
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
Subject: [RFC V2 3/6] sh/mm: Stop using pte_ERROR()
Date: Tue, 11 Aug 2026 09:51:16 +0530
Message-ID: <20260811042119.3652929-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811042119.3652929-1-anshuman.khandual@arm.com>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
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

Directly use pr_err() in set_pte_phys() and drop pte_ERROR() which helps in
eventually dropping pte_ERROR() macro across the tree. In this new printing
__FILE__ and __LINE__ has been dropped because they are always the same and
don't really add any value.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/include/asm/pgtable_32.h |  5 -----
 arch/sh/mm/init.c                | 11 ++++++++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 5f51af18997b..c8eb9a7a4c4c 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -401,14 +401,9 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pmd_page(pmd)		(virt_to_page(pmd_val(pmd)))
 
 #ifdef CONFIG_X2TLB
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, \
-	       &(e), (e).pte_high, (e).pte_low)
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
 #else
-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 #endif
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 110308bdef01..b3c7fd84ceb4 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -78,13 +78,22 @@ static pte_t *__get_pte_phys(unsigned long addr)
 	return pte_offset_kernel(pmd, addr);
 }
 
+static void print_bad_pte(pte_t pte)
+{
+#ifdef CONFIG_X2TLB
+	printk("bad pte %p(%08lx%08lx).\n", &pte, pte.pte_high, pte.pte_low);
+#else
+	printk("bad pte %08lx.\n", pte_val(pte));
+#endif
+}
+
 static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
 {
 	pte_t *pte;
 
 	pte = __get_pte_phys(addr);
 	if (!pte_none(*pte)) {
-		pte_ERROR(*pte);
+		print_bad_pte(*pte);
 		return;
 	}
 
-- 
2.43.0


