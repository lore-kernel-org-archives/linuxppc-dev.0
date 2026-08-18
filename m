Return-Path: <linuxppc-dev+bounces-25941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CAEC5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:02:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGH950JGz2ynH;
	Tue, 18 Aug 2026 14:01:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787025717;
	cv=none; b=FTXPAD9Vodk8tlH4ws8bT+Z+ivx38+3k4RYnkgxT6UeGYUGsf9a5LwPS3gx71CR5mi8zveAVvaNpn00xcvwbrQ1b89ieReCtd1FFC1f2OYd5AKqgrUonZpJ1UwcQJsW1SRDzxfcVyJHNjIOzjaK2IDcll9H5MSGxdx9EMe1m1rEE2BOjliOR71JlGAf7E/plld6erqNSahi1VSX3uFO5aOpgvSRNNFgM5TMPO/21gaTz3ECJ4geLYArOmVQW2nF1V6x65z+kZ9L99nplqJNbcHVctF9ivpIReXODkocykpBHxoyEGuVuAAtdoy9jpAtsN8I8dhLShQ+C8RrnN7NV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787025717; c=relaxed/relaxed;
	bh=Fznq/o2YShbuayKM0ksE2LhKkcoysixYwDK2OVdlfbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHVbNAIM3cNe3aaYEPtgU1UqT5xWuANdjjg5104WhRHslwR5pVIt5udA5QYvkwHPHK8+1/AFgbN9ufT4aZYpMzYsSMfjG09gogZr8RVg5FMYkW/PRKwu2uQYWf6+09RhSz8q+qbcvq6WcSDL3LIMH41SFZW8hhbK0Ad/b90GZ8QEvl798l5TL0k1Hug4Yw0B+yU1MQ+brGe3bD3l9PDfmUxE/2Fi35VVZL530AE3tAbCrPEoagFzc8mZWTu/5fGcRbU1xjnNB5LPRN3t46b1REZ7eey7UeDXN1yrIx04TBjtKhTdEJC4sq90DR2akLLOODtdMOvRxavOsNkYGLB7eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RwYiQyZ1; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RwYiQyZ1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGH84V5Xz2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:01:56 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B6A619F6;
	Mon, 17 Aug 2026 21:01:00 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18FEC3F66F;
	Mon, 17 Aug 2026 21:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025664; bh=+IOKlajyDGmq0sYEfpdSj8LTjC//Z3kh760ik0Or7T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwYiQyZ1+Gm65Beru//SBDmjn+yw3OE19u+NNLDDYSJEmLRaTwxULRvx1BeUbv2jK
	 RMrPw8oBILsTv6WNVwRvec7ZHbG3DUf5WAPvJbhSBJcW8jGsVmR0JNTmxttvAgrdYU
	 j6l5G+LrXUhY083h6l2N3RQI/Kw9J2+W+viSZqTY=
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
Subject: [RFC V3 5/8] sh/mm: Stop using pte_ERROR()
Date: Tue, 18 Aug 2026 09:30:38 +0530
Message-ID: <20260818040041.1891769-6-anshuman.khandual@arm.com>
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

Directly use pr_err() in set_pte_phys() and drop pte_ERROR() which helps in
eventually dropping pte_ERROR() macro across the tree. In this new printing
__FILE__ and __LINE__ has been dropped because they are always the same and
don't really add any value. Besides ptrval_to_str() has been able to handle
different PTE representation with and without CONFIG_X2TLB, which helped in
unifying error message printing.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in RFC V3

- Cleaned up the error the message and used ptrval_to_str()

 arch/sh/include/asm/pgtable_32.h | 5 -----
 arch/sh/mm/init.c                | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

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
index 110308bdef01..9466ae6f9f16 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -84,7 +84,11 @@ static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
 
 	pte = __get_pte_phys(addr);
 	if (!pte_none(*pte)) {
-		pte_ERROR(*pte);
+		char str[PTVAL_STR_MAX];
+
+		ptval_to_str(str, pte_val(*pte));
+		pr_err("unexpected set PTE at %lx in %s: bad pte %p(%s).\n",
+			addr, __func__, pte, str);
 		return;
 	}
 
-- 
2.43.0


