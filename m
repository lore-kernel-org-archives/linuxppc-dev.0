Return-Path: <linuxppc-dev+bounces-21740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7445CD6E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:04:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmv0b8Lz3c57;
	Sat, 30 May 2026 01:02:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066959;
	cv=none; b=TNE7t7TajI5jTWqUtJIvFS/K06lrHQ5mWXnVGqFjts+bRVeYk4tHHGa/X4zAEgbtcYqs8r8PQmICW2jIRzuWPeOdcX0+dNQQKmJ3OAqEAn/wI2b7NZH5HQ/7sfZAbBqtNBcqYgZVLvnPnrJFt8BOp3XY/YY28D9t9Fgp07BmJHFdBrB0m2xttXRnv67cCdHlwKvoRixKpUhtBKpnm0Qm/8yQThcGfrxcMEq7iFXm97moRTrVXPCkTNLuXFCZIsHMHNYUxV+SI+Ilzy7TBS7cgcOO8z1XDXw1cP9HOWLOZi88rt3fwnaFLFy0WMicO8tfYr1X2/kJlW1PszFW6VHL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066959; c=relaxed/relaxed;
	bh=RUlY0Cb5F8XLpE5JfjwZ+7xlX215FRQLeW3ZifZ4LCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ftYnw/CaS4BCR3l66tgOM8rRU/2BoWdUFhiV6IipngHdmDIhPQQxhN7midZCvEPDvtL6PXkHWaCb1Y+p+DO6r97wuGRbKf3N50iixWJodndEg281E5OjxXEtNOJGmqUHspUYvRkXsiFAj7B3HhuS+DiHSehafN0zNK194gIgTPlnkgL+PVIxp0gts17PpEdiwLs52s8UvqPo0HCfUJ3PeCXw/dEVzkvLTvICKGwtte8xYMULChmOXEcbjPfLbaVhem2uDFVatBmkHMF+bKeyHUjO/0DPIv2rJwvx/Sr4tkiUZaRt/Kp2z4M9XskQkfE/0qkBdEPtaAcHvyJ8v9Zmqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xulg689b; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3i6ozaggkdj48pb9+egremmejc.amkjglsvnna-bctjgqrq.mxj89q.mpe@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Xulg689b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3i6ozaggkdj48pb9+egremmejc.amkjglsvnna-bctjgqrq.mxj89q.mpe@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmt1rdBz3c7H
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:38 +1000 (AEST)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4909e29e78fso5072135e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066955; x=1780671755; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUlY0Cb5F8XLpE5JfjwZ+7xlX215FRQLeW3ZifZ4LCc=;
        b=Xulg689b0OP7MFHWGnWGFPbH2UoCIURsdbj30hHYSQkKUWOxCrxA7ty6mMF3OhcyZL
         gZ7a2NS98nYHxMKy7kR66ryuESfwB9DvvKnh5MnLIuNVpnreefbLyxG9sFduBKjI9mHx
         Wrqk15vAG2gN17EgTDJ3JI85yko1r9sxk+drlDTETR+cqTjMVoTVJSJUiyUV6d3O3S3z
         jIznjBnf+zLNNNGmDvPavuA7gQumJZlBo8Xe14la9Nrtdk87JlTTrri53ix+6/0iwCyz
         CR5NducbPaLy48ITv67EzJ77XFtVGJBTKqt4eqUKIarrAzdUzvpohCyOsrkuXlAmItn1
         kGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066955; x=1780671755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUlY0Cb5F8XLpE5JfjwZ+7xlX215FRQLeW3ZifZ4LCc=;
        b=NKVSvIOG8YTm3wk5xkBR6KOtq05SnxMLsM8sGE4wO7wVzYQDy4/SLHadkorvCXW7Ur
         5MsVcS9/xzGffdU3h6xAIF3vtU1lriRcAQzkPzmai7f5K1Ij+MGfh0C+TUGdfu0L5xi3
         4VDOO0E6jUryACbI/IU4QsVSjykDfCw74KPFOZ9V/dT66TZWizjS+G1y+XXGps2zDDvG
         e6pbbc9hGsZvUf5FsfpWADXSdMCXcgFxiLBrJo0sPg4Z2z02ZSMFGWG05+AywFfavrAb
         jsOwRS80qOJ3kOsPl6eFkTOL6j7GIkkv4+DV81NqOLTAITIS34oE9Al29LVD+KduYneq
         s94A==
X-Forwarded-Encrypted: i=1; AFNElJ8PWAnFC2CyUPJKrHCPvvU6Gp+yQg7+TGbvLkbAPeBhzDC8h3me95LpioGipGVaBJ1y/7FTXGTsS5e62So=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+1LcRSOMTWI+DR6KPKxyPJLdwbgPQT0Ks4aywfA+dDpwJrESY
	loV0ftn3q+i7bocB9uB9tnYyWksOAMIDTqVdm6gad549J/i9dk6nq4ZK+BczDRJBsY93jMitqQ=
	=
X-Received: from wmte9.prod.google.com ([2002:a05:600c:8b29:b0:48f:de4f:a90])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b13:b0:490:44eb:c1d7
 with SMTP id 5b1f17b1804b1-4909c0f30c7mr58093455e9.30.1780066955148; Fri, 29
 May 2026 08:02:35 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:05 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
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
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=ardb@kernel.org;
 h=from:subject; bh=hrcFvMrty6wWPLsRojP9eqDUmoO4ZLfdaegUjBt5TKE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVT7LQrk5StrVnhW9eSm1/NNic7seSLefqruzq2ZDx
 bLLO9w6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQWTmP4Z9y4/eO0WW8mJKrq
 1MW9sj4c8WmpWkn/Y9030oYr+jdxWTH8DxJlLpd0i0/zDFP5wK+8gt14wjNV0eevVH96qbb/sHn BAwA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-31-ardb+git@google.com>
Subject: [PATCH v7 14/15] arm64: mm: Map the kernel data/bss read-only in the
 linear map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

On systems where the bootloader adheres to the original arm64 boot
protocol, the placement of the kernel in the physical address space is
highly predictable, and this makes the placement of its linear alias in
the kernel virtual address space equally predictable, given the lack of
randomization of the linear map.

The linear aliases of the kernel text and rodata regions are already
mapped read-only, but the kernel data and bss are mapped read-write in
this region. This is not needed, so map them read-only as well.

Note that the statically allocated kernel page tables do need to be
modifiable via the linear map, so leave these mapped read-write.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dcfca5667e5c..7b18dc2f1721 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1138,7 +1138,9 @@ static void __init map_mem(void)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
 	phys_addr_t kernel_start = __pa_symbol(_text);
-	phys_addr_t kernel_end = __pa_symbol(__init_begin);
+	phys_addr_t init_begin = __pa_symbol(__init_begin);
+	phys_addr_t init_end = __pa_symbol(__init_end);
+	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
 	phys_addr_t start, end;
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
@@ -1173,7 +1175,11 @@ static void __init map_mem(void)
 	 * contents of the region accessible to subsystems such as hibernate,
 	 * but protects it from inadvertent modification or execution.
 	 */
-	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
+	__map_memblock(kernel_start, init_begin, pgprot_tagged(PAGE_KERNEL),
+		       flags);
+
+	/* Map the kernel data/bss so it can be remapped later */
+	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
 		       flags);
 
 	/* map all the memory banks */
@@ -1186,6 +1192,11 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
+
+	/* Map the kernel data/bss read-only in the linear map */
+	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
+	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
+			       (unsigned long)lm_alias(__bss_stop));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog


