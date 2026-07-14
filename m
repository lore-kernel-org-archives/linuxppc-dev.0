Return-Path: <linuxppc-dev+bounces-24227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE0CC44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Lt2GQ6z306S;
	Wed, 15 Jul 2026 00:06:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784037990;
	cv=none; b=F6zGwTrz1KqRgTWbXPFDTnaUUm+ma9kxiqoQfcH3DzIxsD6dLx5beNyiBI1NppW+Kkfs7BSBL+DO/xm2+5fRJbBNeVJ6Fp/GAP8DhAFzRRsyNbcc9buUyY6tDgK/MpIMnDsgS7X4IpJ3NPVZ1Z6f1IvEY38MwZDtz/ShTuB5WmLsWwCeYcRICNqxhlQxMB5XwM9/XLb2/wT6j4vbm8VGrHTpEilk7odywtnoglko6UqVJU8eEsAK3kcC4Gk07sui5ia+rfxaazb1nUfmkP29h6s81oYSApZ0gu7dT7nW3xsQyx7Rg/330bBfUDSv9D/9UpzfPcN5Wx3y8hDDtpPwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784037990; c=relaxed/relaxed;
	bh=Dz69MptF58JspLJ2rtF7ybUAV2FIyyNhQ9HifHNaDpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovc1ieL2AXBIRmtcSC15mXX9pzwaQeP7ctcnqAuf62EFNI2R0DjEm9mM6RsU2HtweMzit53g3tM9t177+BuuF1HyukLsYcBvS6oVcFJprEXl+oawgkrVOFi+PozEv6tltvJuXr5GIUDgDTRb92FuvzXBQTzPZX8EzU8ERs3VhxtGZlWgGV1KlXdtrpnLnSI9wKD6X37dldfmgsQuOcSsiF7iwkgteodtkYOurPsyn6PHskIXhSTfkMuE8W87dOlXuO8Q/pohLWojbIvln3NvHwGqCiPecSrr6AO+GryIOU1sTuEkAqWiaMiQmBnUcBzhyTIvMcX1SZPwtA9nDWqFhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GBHbIxSv; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GBHbIxSv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Lr0WRwz303B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:06:27 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46E591570;
	Tue, 14 Jul 2026 07:05:52 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21DE63F7B4;
	Tue, 14 Jul 2026 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037956; bh=VE+lHAHWK4dpsc9V3W/UPtkE4aBmXym2FNHO+k6axB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GBHbIxSv6yx6lpCATNlxlwrGWzZkjE50qqNWmTtSfC55Qij6ibNwZaI+5R9T7uiWd
	 i/VIOmdvMtutA0FQwIru3Tr0+8ZG+pxZmXfmR5SvbAQB1BQh7BgutmvfbwIFq0TwaI
	 MOql+/rIhlaU8c8MGd+SNjdFNyN/NAYTkzmX9Pu0=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:55 +0100
Subject: [PATCH 06/22] loongarch: mm: use mm_is_kernel() in
 switch_mm_irqs_off()
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-6-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1057;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=VE+lHAHWK4dpsc9V3W/UPtkE4aBmXym2FNHO+k6axB4=;
 b=vNqbzx2iMvV1fGidU2iKtjDvRxNSiS8E7MvYIjkLSIIndPb41plWi7UyNf7PU14qsGJzzjbPF
 x7c/ZLWX2B8DhFd7ct6QVQiE/yCdMoFkL2mbSBPv7/C7wV2jkBlaVC2
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/loongarch/include/asm/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/mmu_context.h b/arch/loongarch/include/asm/mmu_context.h
index 304363bd3935..6d51f11427b4 100644
--- a/arch/loongarch/include/asm/mmu_context.h
+++ b/arch/loongarch/include/asm/mmu_context.h
@@ -95,7 +95,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *
 	if (!asid_valid(next, cpu))
 		get_new_mmu_context(next, cpu, &need_flush);
 
-	if (next != &init_mm)
+	if (!mm_is_kernel(next))
 		atomic_update_pgd_asid(cpu_asid(cpu, next), (unsigned long)next->pgd);
 	else
 		atomic_update_pgd_asid(cpu_asid(cpu, next), (unsigned long)invalid_pg_dir);

-- 
2.51.2


