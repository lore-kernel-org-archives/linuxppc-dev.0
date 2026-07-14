Return-Path: <linuxppc-dev+bounces-24239-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5718DC4450B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:08:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Nd3vkSz3bgK;
	Wed, 15 Jul 2026 00:08:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038081;
	cv=none; b=Exr3SWrmxMkQF30A4BukTk2yPSL2WEqobq7QiMdmaHA/oG3fn07EPYe91+YgPby99fVR9USbznCej26hKVjwrPBGafsq/teAsBrmbKX+kl7u9RAqroQhsCXdTQksWN1vK+FUMPRk364o/PYSRp4JuQobWil6DQAtstyPTMCLJWQ1XTwvgAspwpa15z11CyZfpwHn3XB2Rbn7ATLm6hFAgEeOd7PDTI5lkiWL4hzd/JvA4xd+a9EeXizd18fsqqPIkvH3xTtb9JTLzqAf97gyl+oC796FzgthLmJA7/3uJo89BAPYp3qjtvRls68+53Qu/bG0S1lqJooPMSgNynsoeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038081; c=relaxed/relaxed;
	bh=865cl54nJQTbOF3eykkMxymd6hEBxnf3a3hksIMsfuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSUqNl4fXR41OOc8d2lKFJHUe2M/hXJSz9vrvkSbkDqpIxj/Llm61Pbr0M3qswJY/cRCvyIDDbbAlPoi8CEPv2alH9k3GlqOfBVu0lMAgmKMZ+rFumksC6ZZp1z7nX7JZzZEFLPH22tYkoPrcX4gEXJIUXFqlhQXwdCwy4A+BdCLHnDJK3eDOr4o/z5OwO9PJEjmKRswWpKVcjjb1kFB3KYV3SRPeLfoQOYAbpKQ3VJhg6yzNVG5W3AnaxCJ7Kzj8EBchLylLpp/GHj0dp3WvTWv0RVFezCtZI3sswl3k5Ay+v9uG3LeAylPXQUT2VWVkNcS0gcXTg3w4+TCutJHXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LM6l4iVa; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LM6l4iVa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Nc4MK5z3bdq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:08:00 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0350F1C25;
	Tue, 14 Jul 2026 07:07:25 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2ACB3F7B4;
	Tue, 14 Jul 2026 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038049; bh=VE9T6pQuQsM82lM79rZVxS9mOIiIj6SKheB2t7eP+e8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LM6l4iVarrFVDA4j9SWJAplc2WkKEHlGEtdlAtv7pOYj1y3dATl0KnbkElc5xhenP
	 ErHq3OM3B9mOaLihBDgBjY6YaXcTg/I+07sfZRGvHPhPtHlUZIL/cU1EpblJJAXbkJ
	 UH/xAtOtw9tn/FqSE+wrtOg61lpQnXFpNRh+nTaw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:07 +0100
Subject: [PATCH 18/22] arm64: mm: drop explicit mm_is_efi() check in
 contpte
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-18-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2365;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=VE9T6pQuQsM82lM79rZVxS9mOIiIj6SKheB2t7eP+e8=;
 b=IJb3I/i6HXAVQpbcZffARFaIRNRmoRCmPcfDA+y7q25vE/t36H63xBNhz/u8eBXK9/0ECckK8
 YJz0OELUjVVA+CXShhe5YzEf7ewVjSRMYhD9KGxFsYnbUmRuESOa0pX
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

efi_mm is now marked as a kernel mm, like init_mm. mm_is_kernel()
therefore gives the right answer for efi_mm and mm_is_user() is now
equivalent to !mm_is_kernel().

Remove mm_is_user() and directly use mm_is_kernel() instead.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/mm/contpte.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index ad5c04cf66ff..e21e279101ca 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -4,23 +4,9 @@
  */
 
 #include <linux/mm.h>
-#include <linux/efi.h>
 #include <linux/export.h>
 #include <asm/tlbflush.h>
 
-static inline bool mm_is_user(struct mm_struct *mm)
-{
-	/*
-	 * Don't attempt to apply the contig bit to kernel mappings, because
-	 * dynamically adding/removing the contig bit can cause page faults.
-	 * These racing faults are ok for user space, since they get serialized
-	 * on the PTL. But kernel mappings can't tolerate faults.
-	 */
-	if (unlikely(mm_is_efi(mm)))
-		return false;
-	return !mm_is_kernel(mm);
-}
-
 static inline pte_t *contpte_align_down(pte_t *ptep)
 {
 	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
@@ -263,7 +249,13 @@ void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
 
 	int i;
 
-	if (!mm_is_user(mm))
+	/*
+	 * Don't attempt to apply the contig bit to kernel mappings, because
+	 * dynamically adding/removing the contig bit can cause page faults.
+	 * These racing faults are ok for user space, since they get serialized
+	 * on the PTL. But kernel mappings can't tolerate faults.
+	 */
+	if (mm_is_kernel(mm))
 		return;
 
 	page = pte_page(pte);
@@ -302,7 +294,7 @@ void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 	 * We have already checked that the ptes are contiguous in
 	 * contpte_try_unfold(), so just check that the mm is user space.
 	 */
-	if (!mm_is_user(mm))
+	if (mm_is_kernel(mm))
 		return;
 
 	pte = pte_mknoncont(pte);
@@ -465,7 +457,7 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 	 */
 	VM_WARN_ON(nr == 1);
 
-	if (!mm_is_user(mm))
+	if (mm_is_kernel(mm))
 		return __set_ptes(mm, addr, ptep, pte, nr);
 
 	end = addr + (nr << PAGE_SHIFT);

-- 
2.51.2


