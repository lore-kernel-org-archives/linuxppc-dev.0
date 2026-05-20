Return-Path: <linuxppc-dev+bounces-21219-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D465FCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 08:54:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL52N2ZKSz2xqv;
	Wed, 20 May 2026 18:54:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779267276;
	cv=none; b=Z7hG2xSMkVZgsZn4fOc3W0wS17u8kEY4TLdIUHTxhYYTUbSSykvyclagPthlqTWKIwKMNouN2QQiUwEkN+E3BnrDOa0mvjjqbkprqs1vzG1pDyEmAkvFqh6ZpHnEq23yCtDpFuRcQ+zg65nyls1+vmQuqueGar3cXmqjCYrIhRWxE3hXriFlTvCE2le6+rY6BOiKbEOXfTi+xT8beiravhGF+DUeIn+1vZF4bjpz4sTQF0/kwPeGe3m0pGuyHNCeQFc1T1KBwBLV5ukjBqR7+wMkPDinRBMlE9NNPMgna+Rlq2Zu7JPuUn1HnKMxfXj25483XZGbg25uyvwQfnvXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779267276; c=relaxed/relaxed;
	bh=SJbvQCeYYGK31no0UiRJJfovB9239W4R99+29etyJMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6OrLxDijAvNMUrwVhWWeFmb8CU5EfHJ2kynTvvznbaZ7RRLAbHQoa8J0IP+Naba2IYzKI4U6k2yfW0DMpdSKCSNZEUJpPL86OVWgkbWVufIR8nWgybdImbt45H9RR/AJ19niSJ/LU1OHa32ZRsi51xGbIl9UnBRGxcZtzbKX/iRegcamyjPZKectCVG59TUHyWdfooxfkYE7wPDv0MR4KNZgAIfwjAq8zUYZW0ZYTpXiVgue0erd0qCo+k6YeS4GNqlKVzAJj92COVxmdYTHRdo/p4Ytz5o4e8ru3/dYztj7GkOVxaWNPDkg7flYS0SwlBgSpzVvwiyEGz6WpNXYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsYunww/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsYunww/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL52M3jwbz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 18:54:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D00F600CB;
	Wed, 20 May 2026 08:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95071F000E9;
	Wed, 20 May 2026 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779267273;
	bh=SJbvQCeYYGK31no0UiRJJfovB9239W4R99+29etyJMU=;
	h=From:To:Cc:Subject:Date;
	b=nsYunww/wNRisO2TgDK+NnVSxFs1l7ZnC4Cr1l+Mv8AdN0N49rj5GjBZEza3sAx7e
	 6BzLM08hEytZZaqwT/hG2gaouG9wwGCLXzjJ1VtTRp1PbPlGIgWmkWT8OC8+wuOvol
	 Umsz3HVbfb1s7phBZGumKda2+n97tSR0EnnNbsRHmaNfEcl6Sul27o6Eh42efiCnO5
	 +MzvGAo67z/1QpbmS00ePYqARLlz43ZZuQB65TqVdo2aq714OtfnAsawZerHDkPthE
	 0WJBYxD1w5mdAmEDNlhOz5joxLnEqejRILGOZ0EIGti2J6GpJ+Ih4Rw8+DPxxZKs/s
	 aX/x1RqwCYINA==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH resend] powerpc/code-patching: Avoid r/w mapping of the zero page
Date: Wed, 20 May 2026 10:54:23 +0200
Message-ID: <20260520085423.485402-1-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=ardb@kernel.org; h=from:subject; bh=oY6gtKVWNTBx6UhZYZ8J5F7bWJKDdqkgNGPUoOyRHTg=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYs3RWD7P9O9sip+nxa8t3i22u1c9+ypXxduWjaj6mv8v Ad5y6codpSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJhBox/M94/XbBEb45a0sm T0iw2eXcuyKvVOt/YIzwzZp7x18VHdrC8E/zmjyPpZ+xlEKMw/TfJ/4sXjvrUTTvgvztfF9NHeL uS7ECAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The only remaining use of map_patch_area() is mapping the zero page, and
immediately unmapping it again so that the intermediate page table
levels are all guaranteed to be populated.

The use of the zero page here is completely arbitrary, and not harmful
per se, but currently, it creates a writable mapping, and does so in a
manner that requires that the empty_zero_page[] symbol is not
const-qualified.

Given that this is about to change, and that map_patch_area() now never
maps anything other than the zero page, let's simplify the code and
- take the PA of empty_zero_page directly
- create a read-only temporary mapping.

This allows empty_zero_page[] to be repainted as const u8[] in a
subsequent patch, without making substantial changes to this code
patching logic.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Build tested only (Clang)

Resending from my non-Google email. Apologies if you are receiving this
twice.

 arch/powerpc/lib/code-patching.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index f84e0337cc02..13a8acf851f1 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -60,7 +60,7 @@ struct patch_context {
 
 static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
 
-static int map_patch_area(void *addr, unsigned long text_poke_addr);
+static int map_patch_area(unsigned long text_poke_addr);
 static void unmap_patch_area(unsigned long addr);
 
 static bool mm_patch_enabled(void)
@@ -117,7 +117,7 @@ static int text_area_cpu_up(unsigned int cpu)
 
 	// Map/unmap the area to ensure all page tables are pre-allocated
 	addr = (unsigned long)area->addr;
-	err = map_patch_area(empty_zero_page, addr);
+	err = map_patch_area(addr);
 	if (err)
 		return err;
 
@@ -236,11 +236,10 @@ static unsigned long get_patch_pfn(void *addr)
 /*
  * This can be called for kernel text or a module.
  */
-static int map_patch_area(void *addr, unsigned long text_poke_addr)
+static int map_patch_area(unsigned long text_poke_addr)
 {
-	unsigned long pfn = get_patch_pfn(addr);
-
-	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
+	return map_kernel_page(text_poke_addr, __pa_symbol(empty_zero_page),
+			       PAGE_KERNEL_RO);
 }
 
 static void unmap_patch_area(unsigned long addr)
-- 
2.54.0.631.ge1b05301d1-goog


