Return-Path: <linuxppc-dev+bounces-24233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1057AC44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Ml1qZfz30CZ;
	Wed, 15 Jul 2026 00:07:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038035;
	cv=none; b=nW0OinEcA+QAt0hfe/jwViplKKOpj+Wi71slWddIJmpTE9cBLkGFcmjJ8FqVAe8RspG7oZKEJ6eV3fvZ9fxZKZhl6bwCLIVq2SYx6HmL5aXjMPQDAlWqgwu41skSbSYFNZ52KUCxyUO3DlGqc/VXvHfZhltxigVPoyvTdei2mQM2o4iCJ+n/Ev/6JlGqm7NgYFvjJZY2cFaa9Zs7UrhwPdSHNwDWGXgI4atpfp9Ry6wy0ysvqQPJHCo8tT1TiXM4lRVQ3ksN60Za0R3xhB+iOzrg21k7nxgExcyIJh7fi+0ygXE/vOw+CME2hXHpP6Qj4jAbeo6GZ1D/2w4JAdXTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038035; c=relaxed/relaxed;
	bh=bBoBfUS5WMssGgUA/Wo3+dYqN4HjYGy3oqxDSlnyggk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUPyNfw+kfcxkyTUhzBsflu4JvFn3uBCNjI/WHTIFuJNl8unkn5m7p6zCcpRgN5KzQmDYt4crcCrs/VxjRy1tp1VxXgk0fVhOvRMq5gLqWZcjEAFJa+cnHJ5ZbruXUuF+hYhkKf7PXpx3EIlZBZF6pWn3UIdhl7iwSsie4ZBP53u3sW42epxdIFXPktdKU2d1pJiQWJpG7owPZldR6+ee3q5cmbmmvbA2m/y5uAp9cEEghhw4Uy3Z6hbMSTE0lTKG2rT16VfJQ9TlSKW7LV447QFbasnxfVHXtc7JtqB8zMYBUt1RyqwIPVXXU/IHZewH3piwwnoNThLL/ShZ/iRTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HIiwhwiW; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HIiwhwiW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Mk2Svjz30BJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:07:14 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5A831BF7;
	Tue, 14 Jul 2026 07:06:38 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BDF53F7B4;
	Tue, 14 Jul 2026 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038002; bh=mkvNiLNNU7+2GzQNF8eqTlv1xCMmv8/GPTLyXVohroo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HIiwhwiW5/FaoSRBjo11aX1AZpPuYcroDE7X41LVr/xwN0xxR7sqYi+EShBKHthpF
	 n4f8woYlTVlDt26juvjhHDNOK/I92UerlQVr0VVHNOso4VCLR4Gq0Tj1gOY6PCuWSc
	 FVgEvZfyeKpZuGic61DbMkRghFHRNE75lpgzlmYM=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:01 +0100
Subject: [PATCH 12/22] x86/mm: use mm_is_kernel() for kernel mm checks
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-12-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=3862;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=mkvNiLNNU7+2GzQNF8eqTlv1xCMmv8/GPTLyXVohroo=;
 b=TL/ATO2WidViUjXp4JukAFDeik9Bhx9UKyamDJVrFhja594xcdOFPLXtYE8/VvFDMq3oXLjVT
 9Ry1qd/NBLGBGmKjBP3mLajDf99Eimk93BsQgUsx2B9iCCZoXZcZow+
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/tlbflush.h | 8 ++++----
 arch/x86/mm/pgtable.c           | 2 +-
 arch/x86/mm/tlb.c               | 9 +++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 0545fe75c3fa..4af1cf711a60 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -159,10 +159,10 @@ struct tlb_state_shared {
 	 *  - Actively using an mm.  Our CPU's bit will be set in
 	 *    mm_cpumask(loaded_mm) and is_lazy == false;
 	 *
-	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
-	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
+	 *  - Not using a real mm. loaded_mm is a kernel mm. Our CPU's bit
+	 *    will not be set in mm_cpumask(loaded_mm) and is_lazy == false.
 	 *
-	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
+	 *  - Lazily using a real mm. loaded_mm is not a kernel mm, our bit
 	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
 	 *    We're heuristically guessing that the CR3 load we
 	 *    skipped more than makes up for the overhead added by
@@ -188,7 +188,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 #define enter_lazy_tlb enter_lazy_tlb
 static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
-	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
+	if (mm_is_kernel(this_cpu_read(cpu_tlbstate.loaded_mm)))
 		return;
 
 	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f32facdb3035..91d2a6f2ac5a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -168,7 +168,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 	bool failed = false;
 	gfp_t gfp = GFP_PGTABLE_USER;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp &= ~__GFP_ACCOUNT;
 	gfp &= ~__GFP_HIGHMEM;
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1023acadd8f8..5517cab8ad00 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -594,7 +594,7 @@ void leave_mm(void)
 	 * This needs to happen before any other sanity checks due to
 	 * intel_idle's shenanigans.
 	 */
-	if (loaded_mm == &init_mm)
+	if (mm_is_kernel(loaded_mm))
 		return;
 
 	/* Warn if we're not lazy. */
@@ -855,7 +855,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * cpu_tlbstate_shared.is_lazy whether or not to send an IPI.
 		 */
 		if (IS_ENABLED(CONFIG_DEBUG_VM) &&
-		    WARN_ON_ONCE(prev != &init_mm && !is_notrack_mm(prev) &&
+		    WARN_ON_ONCE(!mm_is_kernel(prev) && !is_notrack_mm(prev) &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
@@ -932,7 +932,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * This way switch_mm() must see the new tlb_gen or
 		 * flush_tlb_mm_range() must see the new loaded_mm, or both.
 		 */
-		if (next != &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(next)))
+		if (!mm_is_kernel(next) &&
+		    !cpumask_test_cpu(cpu, mm_cpumask(next)))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		else
 			smp_mb();
@@ -1134,7 +1135,7 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
-	if (unlikely(loaded_mm == &init_mm))
+	if (unlikely(mm_is_kernel(loaded_mm)))
 		return;
 
 	/* Reload the ASID if transitioning into or out of a global ASID */

-- 
2.51.2


