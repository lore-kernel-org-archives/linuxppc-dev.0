Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C20C6FD1D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Apr 2023 09:19:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PpWn40wqKz3fdv
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Apr 2023 20:19:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.a=rsa-sha256 header.s=fm3 header.b=BtjfwkOC;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RO5MclV+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flygoat.com (client-ip=66.111.4.25; helo=out1-smtp.messagingengine.com; envelope-from=jiaxun.yang@flygoat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.a=rsa-sha256 header.s=fm3 header.b=BtjfwkOC;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RO5MclV+;
	dkim-atps=neutral
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PpWjJ6MP0z3cdB
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Apr 2023 20:15:48 +1100 (AEDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id D4D1C5C0215;
	Sat,  1 Apr 2023 05:15:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 01 Apr 2023 05:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1680340546; x=
	1680426946; bh=hcnHw+44/BST0LlazN+bGPEtcTMQwb2S8vINX4/AFbM=; b=B
	tjfwkOCgUBddKw0AfFN9aSDCGtJ7cj6iPzmn9lNGjgaMMuN2p0D1voxnc0b+D0t1
	WSiLn6iLpMaHZL9npSONbVslZKur2IP/nHqDCz1MrLWnCa3fhjwkp3dDacdFwUdF
	O5R1AdhTwBel7MRg0GuwuXCrVBB5VEO8ICxl2wvVbQzHDhvPemaP7sQI/wEKMhN7
	pYMQt0OWrOGaVEGMOQgzPhW002om69/yLvNYTPwqlEZ1UqUEiVVPLsS9Y42s1Mbx
	fMEBdeL9qaLdH6C45x+5kDiCS2AsIB3f6ebNnq6jzfA4z3bMrffYPnk9mDTVHqt+
	GlJXIe8DxGkTlA5H+8W/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680340546; x=
	1680426946; bh=hcnHw+44/BST0LlazN+bGPEtcTMQwb2S8vINX4/AFbM=; b=R
	O5MclV+8iYZGEjTibnyUUa6zqcv/oOriD0wfapql6pJXDi33Z+FTOdEkg2RfemmH
	nf+BcjZLGWjZLyz0cQolPfXYoc86OC7UpeSMQNTd3A/qhOlbI5WMZWZNyy73PoS0
	ob5+F7+ag7xUC/b8Vqdx4GrjcSsZe1jaL9Q1jadu158xshYBoJQbAfYnaBfsn76C
	7Na7uwtKsJw6EQ6KNULJwiUfQslSJOV2wTSC1dPXbvHBEZxdfLwTeuvm98X+aK1c
	DDMY0TUlKFR89L8p4akclzvJJ4vmbj4gqGDhqrr9U68YpNsYJ2Zc0njLUJYnbnE3
	Frz+qUvEF8vQaCEnVXUTg==
X-ME-Sender: <xms:QvYnZAlpxqfkAovtGi8vJp7TdPRGJROs_Ow-GtC6wgMJGiQGpR_XZg>
    <xme:QvYnZP3qGpwF1nMYL8ZRyZMJhxoh70gWmuf-rejHsAE_dl64t6RUz2THMUtPqpbiZ
    Pl41H5m12kTZ4HZqqI>
X-ME-Received: <xmr:QvYnZOqzMaXzslXPmkFsO1qkKJW9Wfn8odWcGKeSXmmWt0nLQwuTLteS2b41OqwaiDomnnbovFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeifedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefledufeehgedvuedvvdegkefgvddttedtleeiiefhgeetudeg
    kefhvdfhjeeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:QvYnZMlCaQp3a1PCwGyfqDgmremxuc5qFh-hTSjz7myxEs_Ux5aNww>
    <xmx:QvYnZO3JYRwyCFR-LDNXEYy7ejg5p9BvVdUK3x79vIZutxwv-Dt-FA>
    <xmx:QvYnZDuEcB6TvrFL6xsB4PqMBGFOcoQi8tuVZUZ5vmZG2LCvN37yTw>
    <xmx:QvYnZIMRkcNwlrv90KaiAIkK7O43n5TNPAH1LirkYSx8ePtSjkEQXw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Apr 2023 05:15:44 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: iommu@lists.linux.dev
Subject: [PATCH v4 3/3] of: address: Always use dma_default_coherent for default coherency
Date: Sat,  1 Apr 2023 10:15:31 +0100
Message-Id: <20230401091531.47412-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
References: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, tsbogend@alpha.franken.de, Rob Herring <robh@kernel.org>, linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robin.murphy@arm.com, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de, m.szyprowski@samsung.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As for now all arches have dma_default_coherent reflecting default
DMA coherency for of devices, so there is no need to have a standalone
config option.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
v3: Squash setting ARCH_DMA_DEFAULT_COHERENT into this patch.
---
 arch/powerpc/Kconfig | 2 +-
 arch/riscv/Kconfig   | 2 +-
 drivers/of/Kconfig   | 4 ----
 drivers/of/address.c | 2 +-
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 26725cdef2be..6777f6158bdd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -113,6 +113,7 @@ config PPC
 	#
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
+	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
@@ -273,7 +274,6 @@ config PPC
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK	if PPC64
 	select NEED_SG_DMA_LENGTH
 	select OF
-	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
 	select OF_EARLY_FLATTREE
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3fb099bfa232..5a28e36b1ef1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,7 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
@@ -122,7 +123,6 @@ config RISCV
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
-	select OF_DMA_DEFAULT_COHERENT
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 644386833a7b..e40f10bf2ba4 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -102,8 +102,4 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
-config OF_DMA_DEFAULT_COHERENT
-	# arches should select this if DMA is coherent by default for OF devices
-	bool
-
 endif # OF
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 4c0b169ef9bf..23ade4919853 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1103,7 +1103,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
 bool of_dma_is_coherent(struct device_node *np)
 {
 	struct device_node *node;
-	bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
+	bool is_coherent = dma_default_coherent;
 
 	node = of_node_get(np);
 
-- 
2.39.2 (Apple Git-143)

