Return-Path: <linuxppc-dev+bounces-24228-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B69C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01M05gYgz3080;
	Wed, 15 Jul 2026 00:06:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784037996;
	cv=none; b=Vz+mDa1zzCioLNdnWIKrxqNG3j5vKJ8u6/0LRTxdiPkqsKxmMOvFIOcTNFu+tqzuV6ZWzw07fjs/ype22VTfZ/wrWeM+wFhtPrFHgRyZY8eZJzr6kJ077oBjD46wNAJpvRlgaGGyox+EiyUu3Af5vhyU/Tziqy9tjZC6qBEczU3o33XhZWt4oBLTJNcxsnPvFwSBxElY7OUp/tKmUUjZkJWFaphyhFU3YweS9vvSMGtuhdqvjzpC6D+RXnvr51hY7M4A7C5d18jbZ5WkAPXva/ZqSe8QjW6lI+fcxHu2D19GubzktKCIqxHth0BHnHymbaqu6ZV1//2Hda+WRTfDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784037996; c=relaxed/relaxed;
	bh=oa1CtGB6O+ipLkqxSVLPYawR7pVmeA+m5qsDYuMHpVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eem2bmKEEXo7eprhdo2p3odSR1RhHrNuRDxUbDoSwizpVQGmizqDRymRx9qEDMJPkOz8LkOs7U5HwPihmd/qIB1YCkQCP8L/RU4oUnLqQDn8naVFX+QWTCSlSBqlfVQOwROAac6ZAR+AXw1tlJpsp8/cR4DaG/9M8vO90O44bdEzdu8UtpEZiXPK/PKVyqlzVUQSLQTjUuFZVDyWygxRgujbCpeX+ClvxWPxR78K56pjLsk3K+ERDBrjw1O9txinvfE5IcQb5Bv2HAqfMI4+5JBFHno6WhqKwDJg1230FqIEHk9mf0MIGOfUKgpit9i7u2Fi/xoei+n9gdaxUZncBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gLbEbpAv; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gLbEbpAv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Lz3SCwz307v
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:06:35 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0839A1595;
	Tue, 14 Jul 2026 07:06:00 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4CBA3F7B4;
	Tue, 14 Jul 2026 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037964; bh=n3wqVkoRE0XrCf49SeUd/3zMbBniK8cKIbHpgqpyHxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gLbEbpAvFzCqe/uk00cuBVEyk86ImDFUKg9+DAxOfE+6fXLZiWwmczq+TYqacIij9
	 dzObBv+9qrGLnOJGKWs94LTFpTVFSye5m9UY9LBRCiPUb+bTNDGQ4mEUs5d8asduh+
	 urPZbHaQ9KgT1hC0YSHV6N5wgcZRQb27Ns4Uao8I=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:56 +0100
Subject: [PATCH 07/22] parisc: mm: use mm_is_kernel() for kernel mm checks
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-7-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2128;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=n3wqVkoRE0XrCf49SeUd/3zMbBniK8cKIbHpgqpyHxU=;
 b=NiOLSLM4Bju3NE/MJk1JSg+adlOz6kSqOBN5Q1Ojo91j2+7DutkOZ20lco5JkeakYm3HADh4V
 WLZkvqMg2QAA0cYBkRVmiWNUb4u1J8+jQygFQcLGfYdNrt+hwaqOb94
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/parisc/include/asm/mmu_context.h | 2 +-
 arch/parisc/include/asm/pgalloc.h     | 2 +-
 arch/parisc/include/asm/tlbflush.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include/asm/mmu_context.h
index c9187fe836a3..e265da67559e 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -87,7 +87,7 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 	 * already, so we should be OK.
 	 */
 
-	BUG_ON(next == &init_mm); /* Should never happen */
+	BUG_ON(mm_is_kernel(next)); /* Should never happen */
 
 	if (next->context.space_id == 0)
 		next->context.space_id = alloc_sid();
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 3b84ee93edaa..9f09cc4fa5dd 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -34,7 +34,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	struct ptdesc *ptdesc;
 	gfp_t gfp = GFP_PGTABLE_USER;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp = GFP_PGTABLE_KERNEL;
 	ptdesc = pagetable_alloc(gfp, PMD_TABLE_ORDER);
 	if (!ptdesc)
diff --git a/arch/parisc/include/asm/tlbflush.h b/arch/parisc/include/asm/tlbflush.h
index 5ffd7c17f593..a5a6cfff295c 100644
--- a/arch/parisc/include/asm/tlbflush.h
+++ b/arch/parisc/include/asm/tlbflush.h
@@ -35,7 +35,7 @@ int __flush_tlb_range(unsigned long sid,
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
-	BUG_ON(mm == &init_mm); /* Should never happen */
+	BUG_ON(mm_is_kernel(mm)); /* Should never happen */
 
 #if 1 || defined(CONFIG_SMP)
 	/* Except for very small threads, flushing the whole TLB is

-- 
2.51.2


