Return-Path: <linuxppc-dev+bounces-24224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC7FC44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01LP4fswz2yXj;
	Wed, 15 Jul 2026 00:06:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784037965;
	cv=none; b=BXewe6imR8LdEfK3wLaBSrY6KzftKwOJwi63QkzCsPIgrSP2lzOLDI6xwWe1Zi8Mhi7Y7ZP14VDJF3I7vkTY21AJwvnNlFlxX4Uqqlwd2dWwYmbRO9paxCB/M/3/70WiSkQnePdGo9HGwa+E8o63OAJ8LIxU1xITQevpPGJ6K3hx/uVjavdAFQixwcYIqfXil18uDSD/6vEuHnHakOqSMP7dd5Xdno+wNshc02AZM/D0/p0i1yr9VZJ+1fLewwvE5GTpen1GtrQHRgLF6DFc9hMESLWpMtsy6f1ny4bN1G5GBuwJtr745m5IWVZ8VCbf5GQSyr9ZWKYc/AVhxN8IEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784037965; c=relaxed/relaxed;
	bh=Sn+zU8yNJHIyNq+aM/0w0FGWDdrVU1gUm/tv5PTPfjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmNJu4Fgl5VjPRmb6/U/VRscnxv7VbvZOQE97PijZFkPsc+8jmTW9kqvy0WaMItgvNMw6RASkJgrCOKXxw/BJbm4upzlZzPW6V5eFviGtIz3ohMMGOLDXWpZTeVoX2SlI9F7lVfnIiLzxprM46++VshOFKhYHpHNkGynsCQfr8fitQ3ax76rUhqR6LeXhIXvGrBasCPrqDSv6vNvKdrwhbgE5sKYRLbeZXMxblqU0D9GdGgz4nukpa+Ec/N4ZXCPLx3VxvdmijqKf4YWb0plEZHIUDA6pY+h//PLBVKmooP2ZaBDk4T+EVYxxjaLonIjUHk1mDPVDe4D7x1Kz099ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Bm1/z7nw; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Bm1/z7nw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01LN4MJsz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:06:04 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 224CC152B;
	Tue, 14 Jul 2026 07:05:29 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECA813F7B4;
	Tue, 14 Jul 2026 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037933; bh=FInc2gTxhVQc4LYtwtKoJPw43dSvFTnMs+LPVQ5s9u0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bm1/z7nw3ZrVQHSoXKrtxTQs91wc4RUrXfic6nvC1VPB3At2KepfWXr7Aw3HYFpkn
	 ioHo5OCLJkJiU6MHz48diP4nr6YFWtjQg3UL72aeFoQQSfWxPSBxVE10gNTyxwI//k
	 BrtCJZVqyK4Ji57oD58xPcYajyNM3z8AN78Fhrlw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:52 +0100
Subject: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for init_mm
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2504;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=FInc2gTxhVQc4LYtwtKoJPw43dSvFTnMs+LPVQ5s9u0=;
 b=LLyApQy3cCX+sEK7+yEv+wdSQwFfqhZ/PtGYmJI+JJbZMoulhtvHZSYrG2onhzlRcBnCeJhTe
 oQ14mia3FhGBEfCDsSpVX5EPWBdyUPXpBCd8WmZOxEP54NLEVWz9CaD
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

mm code often needs to know whether some mm represents a kernel or
user address space. This is currently done by comparing the mm
pointer with &init_mm; besides not being particularly elegant, this
ignores the fact that other mm's (e.g. efi_mm) may also represent
parts of the kernel address space.

Introduce a new mm flag MMF_KERNEL and set it for init_mm.
Subsequent patches will use this flag to replace comparisons with
&init_mm. No functional change is introduced for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm_types.h | 10 ++++++++++
 mm/init-mm.c             |  1 +
 2 files changed, 11 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a2e0dc5892ff..7838ea3aac00 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1414,6 +1414,8 @@ struct mm_struct {
 	char flexible_array[] __aligned(__alignof__(unsigned long));
 };
 
+#define MM_FLAGS_INIT(flags)	{ .__mm_flags = { BITMAP_FROM_U64(flags) } }
+
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
 	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
@@ -2001,6 +2003,9 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
 
+#define MMF_KERNEL		32	/* mm belongs to the kernel */
+#define MMF_KERNEL_MASK		BIT_ULL(MMF_KERNEL)
+
 #define MMF_INIT_LEGACY_MASK	(MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
@@ -2008,6 +2013,11 @@ enum {
 /* Legacy flags must fit within 32 bits. */
 static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
 
+static inline bool mm_is_kernel(const struct mm_struct *mm)
+{
+	return mm && mm_flags_test(MMF_KERNEL, mm);
+}
+
 /*
  * Initialise legacy flags according to masks, propagating selected flags on
  * fork. Further flag manipulation can be performed by the caller.
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3e792aad7626..93773269bf87 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -34,6 +34,7 @@ struct mm_struct init_mm = {
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
+	.flags		= MM_FLAGS_INIT(MMF_KERNEL_MASK),
 	.write_protect_seq = SEQCNT_ZERO(init_mm.write_protect_seq),
 	MMAP_LOCK_INITIALIZER(init_mm)
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),

-- 
2.51.2


