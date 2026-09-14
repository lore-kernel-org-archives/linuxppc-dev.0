Return-Path: <linuxppc-dev+bounces-27199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40193C88E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:03:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjx215vdcz30RN;
	Mon, 14 Sep 2026 17:03:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789369401;
	cv=none; b=Bwt/fhSE5t7IFEHTAgqjbJ//r5eNISg7lonRwrBCAkAS8/M1PPD1u4t/WbZKuYsAXqk/TiAAO1qku95EiigWWpUs6aSIcoap8aplZfIVtQpsEytUjl9dM3Ma0fds34sAhTA401fJ4xNsqqmWhLTDHnoI9dontExEbtMEVUNzfmz5DeLk18IoNjSPwJriMalz1zH+D4rTtV37zZ16zc+2LrnTbNiZ8ZH2yIOcLi2XNyPDqbmiC0np+88xXIcP07VCg/a6nQvgFT9HuMn7LHWJb2uiDhTbAaWwCwUIAqcHtDtG38GmV3dokID/SW8VOM6ircmNXTrOrAdK5lJY++hG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789369401; c=relaxed/relaxed;
	bh=7KNP43XtreccAemuIAJIH10BurR1mq1cqFVOYH1WwzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtD3TFLqfbHaMGjPATax7ElCbpGqkQYz4KGjzzOAGMqpXamLyEC9xvTFndMgBBLcGL3LuZo8rTeqrw2hcXZTI8Vmxa9tShEZfj9V6nro6Mrk/B2J+8OygiHH3uxclow/F5Kb1vCL96GC0/pjkqxcTYT++QgIXp47FFY7i/1ZXDKbEgEWBt/+U/4GWW7C5tKGR8lQ4KszjvrIYVV3Qo8PiSLZwIvB23IDxzXiMTAOp+jp7GERNaPfatcxuuRq+lJFSGBf6U9ejTv86vQ+r622x9PL/wAmIViPN3NbzOgLcrUkEx0fIUn2BtHoEzHECtXsp20tiNFS9B+LxCszS08gTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxHF4NFf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxHF4NFf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjx206fm2z2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:03:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B0C5960142;
	Mon, 14 Sep 2026 07:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6B61F00893;
	Mon, 14 Sep 2026 07:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789369398;
	bh=7KNP43XtreccAemuIAJIH10BurR1mq1cqFVOYH1WwzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxHF4NFfd4AGPA5yz8mau8+tK8AD9+KRrcVP4sPs6Ek5IpM9Rsyqh6nsse9weKZvB
	 l5y13It4KBVQztJqctnLK2osOkFM1t5PO+Hbb5WPlH/r3daqeQ2IwKkkgqEj+9r1rs
	 8nvaQng0eiiKaLr0YTpK86ts/4rey7oaeSvdhjkXhfL9RyPDSna5aY0FpgDyeYQ3It
	 D8HdD36+++X8fa+axfp71jZdnOtOLSbBc9kZmyQs6hFbnaPWP6KzRlDba1WF8CNKs4
	 RoPEybdTKK9YVknPt/p3XtOLneRSVAkGZfMmQlSp8GucKqkyP/KDMMfN4Vj+bT8v4W
	 Z9TCrN8riw1IA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v4 4/5] dma: swiotlb: Add an overridable architecture pool opt-out
Date: Mon, 14 Sep 2026 12:31:33 +0530
Message-ID: <20260914070135.313337-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914070135.313337-1-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
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

On x86, iommu=off historically prevented SWIOTLB initialization by not
setting SWIOTLB_INIT_ADDRESSING_LIMIT. This overloads that flag: it
controls both whether a pool is selected and where the pool is
allocated. If another requirement, swiotlb=force selects a pool
independently, omitting SWIOTLB_INIT_ADDRESSING_LIMIT may place it above
the addressable range of devices which need bounce buffering.

Add SWIOTLB_INIT_FORCE_DISABLE to let an architecture opt out of normal
pool initialization without discarding the pool placement constraints.

Unlike swiotlb_force_disable, which is set by swiotlb=noforce and
unconditionally prevents pool initialization, the new flag is an
architecture default. Explicit requirements such as memory encryption,
architecture remapping, or swiotlb=force take precedence over it.

iommu=soft retains SWIOTLB_INIT_ADDRESSING_LIMIT because it requests
software bounce buffering for devices whose DMA masks cannot address all
system memory. Such devices must be able to reach the bounce pool.

Clear both flags for Xen because Xen explicitly requires a remapped
SWIOTLB pool and may allocate it anywhere in directly mapped memory.

With no override, iommu=off disables both hardware IOMMU translation and
SWIOTLB bouncing. Direct DMA remains available; mappings outside a
device's addressable range fail instead of being bounced.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/x86/kernel/pci-dma.c | 11 ++++++++---
 include/linux/swiotlb.h   |  2 ++
 kernel/dma/swiotlb.c      | 10 ++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 3c82ebb5b6e0..cd6dd151d634 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -44,9 +44,13 @@ unsigned int x86_swiotlb_flags;
 static void __init pci_swiotlb_detect(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
-		x86_swiotlb_enable = true;
+	if (no_iommu)
+		x86_swiotlb_flags |= SWIOTLB_INIT_FORCE_DISABLE;
+
+	if (max_possible_pfn > MAX_DMA32_PFN) {
 		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+		if (!no_iommu)
+			x86_swiotlb_enable = true;
 	}
 
 	/*
@@ -83,7 +87,8 @@ static void __init pci_xen_swiotlb_init(void)
 		return;
 	x86_swiotlb_enable = true;
 	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
-	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
+	x86_swiotlb_flags &= ~(SWIOTLB_INIT_ADDRESSING_LIMIT |
+			       SWIOTLB_INIT_FORCE_DISABLE);
 	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
 	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index be3962a33fc6..ef7a776ee508 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -20,6 +20,8 @@ struct scatterlist;
 #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
 /* Initialize a default-sized pool that requires architecture remapping. */
 #define SWIOTLB_INIT_REMAP		(1 << 3)
+/* Do not initialize a pool unless SWIOTLB is explicitly required. */
+#define SWIOTLB_INIT_FORCE_DISABLE	(1 << 4)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c4611b2c4540..6695da682f96 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -563,10 +563,16 @@ swiotlb_select_pool_policy(unsigned int flags)
 	if (flags & SWIOTLB_INIT_REMAP)
 		return SWIOTLB_POOL_DEFAULT;
 
-	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
+	if (swiotlb_force_bounce)
 		return SWIOTLB_POOL_DEFAULT;
 
-	if (swiotlb_force_bounce)
+	/*
+	 * Explicit requirements above override an architecture's default opt-out.
+	 */
+	if (flags & SWIOTLB_INIT_FORCE_DISABLE)
+		return SWIOTLB_POOL_NONE;
+
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
 		return SWIOTLB_POOL_DEFAULT;
 
 	if (swiotlb_kmalloc_needs_bounce())
-- 
2.43.0


