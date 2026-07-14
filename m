Return-Path: <linuxppc-dev+bounces-24230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17DCC4450C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01MJ1WHsz308H;
	Wed, 15 Jul 2026 00:06:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038012;
	cv=none; b=L8Br2qatPJEYd03U99Eijf5j63rnT+BvN1/CbytCmPHYghqkPUnZNlFpj2Jm2YM1aO+6fSD3aRsogpXAy8tHxCbpX5K9+avSZ3/jlQp05H9TRBUkPyU/kJQ6SDkihXJXysNymf3aB2LtCzSlf/RPBTF/pMG1umWG4jAikn3wvmmtUFlya8WfLYxKcUCEQjiN+gkYKvnRKsewsso4wCxlfEX96w86wnSDZ2SvHQsxg/PqhfqyteQSf4RkFgk+zAtRojgCb0wA4FM9qY7JGc/kAr1bFTGrjLnjmW45AQkd/byzCnTG7qXvh7B68Y1bcFP65cQ6idrLrkIgf7yLqVryVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038012; c=relaxed/relaxed;
	bh=WEPAEMG15c2gH/O6ihAUxmO/06ck6asqsv3XqqkfCYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8wZrSpiuwnb+T4VRpuulPkW9vGFnD6yHmRJEMus14omf/DyS3piqqi3wrGPEBFWEjVSSKVMhUtFxPlgiklPQF03cPyGnW5b16VqUqI1PpePJ7CY2d9U3ofWZoUiUuDZur/BSkMI8MqtDbRYgan8TmiyDspyppmnUd/hq0Du5Mceamg2a2HrFyMPoYD+dRcj3VGvIVHn0vn4KOZnZ1hOm1tNd8qyosYpc1sNSvKqqBfFwbq8tmbJfrxPP7dzb+C+7Dd9r785azSviq5PB5Kuq7QbUkv4OEiRteydfwdT7TrOmAObItJzh/xjIywRxFVmSAatv3FSkmGCW+nFig7ilA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=g68p8jn2; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=g68p8jn2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01MG6z3Rz3c2h
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:06:50 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F011BB2;
	Tue, 14 Jul 2026 07:06:15 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FE263F7B4;
	Tue, 14 Jul 2026 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037979; bh=NDusZRNCWoEozZsjG5aWosyCUDI8Y1KKdd/tV+nqCY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g68p8jn2r/BRs15OVDSJM5PC0vX+xZEjL9qs6O4bNrlLAmFr23nxaTMwPJrtgFVSe
	 PO42BSv3F1n/0/KY29fSo68pViH3svUbemsg+2g8ZALHR7Gb34DvnaAe4yB7K0yUyn
	 X1Qg4PRgk23qfvxdXOP4RJxy06FeoAcjmt/U8Rmo=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:58 +0100
Subject: [PATCH 09/22] s390: mm: use mm_is_kernel() for kernel mm checks
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-9-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2701;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=NDusZRNCWoEozZsjG5aWosyCUDI8Y1KKdd/tV+nqCY0=;
 b=EN7VJwlPWQ2mLOV0RQXIAGmFgLbZqozbS12jiAz8t5flCb4LBC8CQLf9qAbAsIdiWxuJ/h34z
 +bgdLqbZMrPAgQeOceVSuzYyrvq4LTVvYRTcF4wG9fcsRmwk6IO2SXA
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/s390/include/asm/mmu_context.h | 2 +-
 arch/s390/include/asm/pgtable.h     | 6 +++---
 arch/s390/mm/pgalloc.c              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index bd1ef5e2d2eb..675f270d0b70 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -69,7 +69,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *
 {
 	int cpu = smp_processor_id();
 
-	if (next == &init_mm)
+	if (mm_is_kernel(next))
 		get_lowcore()->user_asce = s390_invalid_asce;
 	else
 		get_lowcore()->user_asce.val = next->context.asce;
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index e882663a58e7..f7741e6b417e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1836,21 +1836,21 @@ static inline int has_transparent_hugepage(void)
 #ifdef CONFIG_PAGE_TABLE_CHECK
 static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long addr, pte_t pte)
 {
-	VM_BUG_ON(mm == &init_mm);
+	VM_BUG_ON(mm_is_kernel(mm));
 
 	return pte_present(pte);
 }
 
 static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
 {
-	VM_BUG_ON(mm == &init_mm);
+	VM_BUG_ON(mm_is_kernel(mm));
 
 	return pmd_leaf(pmd) && (pmd_val(pmd) & _SEGMENT_ENTRY_READ);
 }
 
 static inline bool pud_user_accessible_page(struct mm_struct *mm, unsigned long addr, pud_t pud)
 {
-	VM_BUG_ON(mm == &init_mm);
+	VM_BUG_ON(mm_is_kernel(mm));
 
 	return pud_leaf(pud);
 }
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 7ac44543e051..d0456b7e73d4 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -20,7 +20,7 @@ unsigned long *crst_table_alloc_noprof(struct mm_struct *mm)
 	struct ptdesc *ptdesc;
 	unsigned long *table;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp &= ~__GFP_ACCOUNT;
 	ptdesc = pagetable_alloc_noprof(gfp, CRST_ALLOC_ORDER);
 	if (!ptdesc)
@@ -120,7 +120,7 @@ unsigned long *page_table_alloc_noprof(struct mm_struct *mm)
 	struct ptdesc *ptdesc;
 	unsigned long *table;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp &= ~__GFP_ACCOUNT;
 	ptdesc = pagetable_alloc_noprof(gfp, 0);
 	if (!ptdesc)

-- 
2.51.2


