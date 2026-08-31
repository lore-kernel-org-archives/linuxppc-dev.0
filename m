Return-Path: <linuxppc-dev+bounces-26217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBF2C61DE8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 05:44:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYHxn5Wbrz2yDc;
	Mon, 31 Aug 2026 15:44:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788155085;
	cv=none; b=jTWYWpbOouG1slSxHCLlZI+9WKHXTQXuzE7q0J+ecTqEuRoV/WZilBrGGz9JHixHk9FYueJer1vtzRzKn1kiqpqkEI8XU+Jc4ZQnUzXjIFbFErhebningWCgQyypVDmLDRKabwCwffPzKB5CywtNNKKfxuDmGSQlO/4DlpgHMGalwIrqKFz9gd9keqn0z/EtArK8GZbZlgZQR56L6h/aC7+PZQBv9QHV3AMQYlFtG2IijjEmgGIaaeN0D8pgniqsM/c6TWbz1B85dlkyDwBXpsIE8HDg13U8nrioJs624KtNHKTcUDVpOR7HFy1Zx09panbYgFjjNtI2Z2y3nHBhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788155085; c=relaxed/relaxed;
	bh=KntaQece5KLPwg54O9DJOAVj9nRdl5PrfkBK4M6L750=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o00YQaRS4Dzn6pMMCk0i/RX6UavE7tjPtiKlmf8iwoEzYYsQoYt4zNilrqBwOShEhuhU373H99zJmdri8+n7TjblRc9sX0URXs94Cn1jH8FebE4tG8lBzaqaN86xQAUz9xMLVECvC/Uij1ttVxTeWP6i+vblRmbp3sFluWyqiqG/1Ms2WSJMh61mfZemKAR653u7EOecsQgpLkppP4FkzdAYBk8qwLy96vuvtWWjZ0TQ7aAo4nl2bAa3/1DfSGqiHfLxv89EzUaS3p4yIxGwInYXGK6cHG27qu/MbVObRwKlLj4yqQTIyp9K8yLcakNC2MNcVd+gvMWIiYPI9aRzLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jTd9KjtS; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jTd9KjtS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYHxm4zBzz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 15:44:44 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 394E31A00;
	Sun, 30 Aug 2026 22:43:49 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4094F3F85F;
	Sun, 30 Aug 2026 22:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788155033; bh=bACj7yeD3kQHNtaEo3qPM/7pYVMQxld/GWsQ0raGU14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTd9KjtSO47ZSa6Eegu9Jg3Egpfu6bTxJIeCEbbBs9lqVrJh/QwBdWqQGOEmVP0OA
	 hcTTxkZT6fAeEx8haq4FYbspEuUlfOA+P6q6eaBD4749BBYDUsR3ASLkC8OBZT5DoQ
	 0XYYCcDmZkZUnHFkXTJfrC1qadu+n2mdWf7vuxCU=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: samuel.holland@sifive.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: [PATCH 5/8] sh/mm: Stop using pte_ERROR()
Date: Mon, 31 Aug 2026 11:13:27 +0530
Message-ID: <20260831054331.625505-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
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


