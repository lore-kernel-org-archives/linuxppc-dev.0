Return-Path: <linuxppc-dev+bounces-24229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0115C4450B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01M8391yz308Q;
	Wed, 15 Jul 2026 00:06:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038004;
	cv=none; b=Fnvg6BE9ZHnxqIsZwCGDiDUSb/Uu3cXr5sX5/shs3E1CDnjXQkCaEO25lAuOh1+Oxa1HFjzR/erkhewIaILYZmfaFGTSJXDSkWTUS9qvzfkrLw5cY9FPRLWG7Vs6MxIGjK3OTWV/uRXOO83nbPkqZ1ncaT0CjM79HRaxKPIkPutVKFZwFHDWacr3HlZPZE5Y5216kIq9vuFMBxCTe2AiwHDTHu9XjKQRchtW66SbiS5zg9KBMeKaKRgrFQSPQEJmzDbbql47/lErUhC3v+HaI3kmXUx/iEZnpZ7OvGzgdLhhwfsrCwl6k86AmGVyvwWtK0QSUShwu/oBvPpzbJ5tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038004; c=relaxed/relaxed;
	bh=xrTKSUYe+o4yYeiHIfdmZfk/VD/VvZ4yWrfSjmZcls0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATGgIK3BrR2mDygrrmg/PAwC2JlszPh8uaD4OmcaOwbLR4tCSO575dWQwKkAWMj0lgRSg/LyoJVB5aEewo4V6pqwW907fxVmJeC0qTbvwkq/MdQs2PbncxDOjAAHYoVGOGHZl01XqQUDxtgdSyTzonRJxLnObpL+pjWg08RICGJSl+7GIf9Yd8vPh+nixxG/KvWqzOxMnUD15d6haKtS59K3dUEqkjGUsBs4zV6YEr9eoWe6zEUjJG4PGWux+XVKCTrV1EWTeuVPmsb9HA8U5Z9MWUw0V5WQ4f/0fdYBZtIM8iJhxvSyMRMSjZrWjZzWZM+7JwOFwCAOkULsf49gzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UsBpoovP; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UsBpoovP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01M72yy4z308H
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:06:43 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95291691;
	Tue, 14 Jul 2026 07:06:07 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923CB3F7B4;
	Tue, 14 Jul 2026 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037972; bh=wjWPKE4gokVm0n43Fz8OrYiTdEX4ZJIt+9rA3rzslZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UsBpoovPpZ85RSIZfXEnSBfVHOZtFnPkX47Kj5gg3LsgzJNhCVgTUWCtTOeVOPaNp
	 HKjlV2fnQGGYMeGqcjyozlJa7a3QA1IlDMrT8hf3JRzN2w2i+9FSRlqOzr8/QB6/Qf
	 Q0z0BAmzTk1fTpNEZ3NiarWVCe9KoxmszHFZ5aSw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:57 +0100
Subject: [PATCH 08/22] powerpc: mm: use mm_is_kernel() for kernel mm checks
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-8-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, 
 x86@kernel.org, tboot-devel@lists.sourceforge.net, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2458;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=wjWPKE4gokVm0n43Fz8OrYiTdEX4ZJIt+9rA3rzslZA=;
 b=mGXIMwx7mP+wc+PdjO+ERefisoZsiZf5NJNBVQYllixOIGkiZykJ/6wIrBXI36cbJ4lbGAtZA
 wL42KEsLctGAHh95szgDEyWgp6+51aO6Iy65UQOmRkiEbYbzhv701ws
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/powerpc/include/asm/pgalloc.h | 2 +-
 arch/powerpc/mm/book3s64/pgtable.c | 2 +-
 arch/powerpc/mm/mmu_context.c      | 2 +-
 arch/powerpc/mm/pgtable.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 3a971e2a8c73..88acccc5b06e 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -7,7 +7,7 @@
 #ifndef MODULE
 static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
 {
-	if (unlikely(mm == &init_mm))
+	if (unlikely(mm_is_kernel(mm)))
 		return gfp;
 	return gfp | __GFP_ACCOUNT;
 }
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85ab6723c8f2..eb365f7c8907 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -395,7 +395,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 	struct ptdesc *ptdesc;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp &= ~__GFP_ACCOUNT;
 	ptdesc = pagetable_alloc(gfp, 0);
 	if (!ptdesc)
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index 3e3af29b4523..b51934c511f3 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -48,7 +48,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 	/* Mark this context has been used on the new CPU */
 	if (!cpumask_test_cpu(cpu, mm_cpumask(next))) {
-		VM_WARN_ON_ONCE(next == &init_mm);
+		VM_WARN_ON_ONCE(mm_is_kernel(next));
 		cpumask_set_cpu(cpu, mm_cpumask(next));
 		inc_mm_active_cpus(next);
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index a9be337be3e4..d04f4fecfc7c 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -393,7 +393,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		return;
 	pgd = mm->pgd + pgd_index(addr);
 	BUG_ON(pgd_none(*pgd));

-- 
2.51.2


