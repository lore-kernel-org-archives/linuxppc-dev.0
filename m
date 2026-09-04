Return-Path: <linuxppc-dev+bounces-26552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA3C624D3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:19:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbss10kPJz2y2M;
	Fri, 04 Sep 2026 20:19:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788517173;
	cv=none; b=g3ME4ertCmq3+ZzE0Q4oNfjXb11Tu8QFtQNHUl4S/9BmJW7tm3qbC8aR/TxfEpVC0HsJ8lIKhZZYjPvdYDC6fBhvcYKUdTsRXX+NYhpm+ZKSU2VKAiLbkKRT2VEXvxVCMAi/qSniDx1eucsIY+k6DNGnstRlsrxd6X6KyApdU0B12Jqi8iDfAVh9kxYuveBBczxfNi4Wz6CWnfBRQpoVsqdvp4ey5jP/WDpBGwo9VB6LZQF2YkIsJAkGiOoinX8pmjisjqL0iZ/m4XR7o2jiBi2yFREmXvNNI6Pr835hWXzhl21XyAKl8lEtZXR1KlhQhorY7AZ1oYp5ZJt76T2kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788517173; c=relaxed/relaxed;
	bh=zHj7Jl4ER2+DUDGeXhri9eyZ/g0x3N0pfswy8RuEkQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwcN2y1jnWbyG8KiOJLkhLo3Q8bexWqNvBRbYekqAGjQYM6ajnFpbq1GGj/nWLT1Rm/ewfO3xo9BAawUSirMhYT6OO6pglAH0HJFSKPqD6kAyYIoVFsnjfZFM9R2h1bzb6d/lJgqVkgpCPZH9Wiz7Uuz1dIDOi3iSSQUJ7ngCHczdxcNQTzWx/gLoA1amduLJqpXUZksCoYMau1nQSMAkY2nTHgZ9s3idT4RAOhNU0fF2P5E0kU5TJ/oR48mlFeS0oU7VbZ0t2YJSh5suH7bzPwkevka/yID6qvWtuC+N71MRglM3Je8y6cAVbgX3Z6tuKTF7B6DXBOXzIp/Seragg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDJwGiQQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDJwGiQQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbss01X6rz2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 20:19:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 229BF6020A;
	Fri,  4 Sep 2026 10:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C2D1F00A3D;
	Fri,  4 Sep 2026 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517169;
	bh=zHj7Jl4ER2+DUDGeXhri9eyZ/g0x3N0pfswy8RuEkQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDJwGiQQcGBuD0sr5QOJBi+FgIhBc6LUaQyqvxbdxT16FlQzs1rjs6WEKus4Lnn6A
	 j60NR7rPgDsW/izsP6g8SwYmgeQcWtkQnzsA17fbOjIpNNwqwDIKSGawoO5zUcrd6P
	 ROEwa06rDkQUmdUdxMhLSZU43vk2Qwv+Y6pEHSqySVc34BQFt+oam7yM7iIuC4h62s
	 nlfQok5mVyqLOw4VBO9dCWVtya4Z27wHZi1BX3rnDSQd/dMW6ETJiOZdH5ae15CtD9
	 55bF4NAMgiET9n38B/U1Z9dQGEFPES5opWTgNAAcPm5CYWSddF/U9QOWcd+tKSmTHF
	 24urd22gLAZuA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
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
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 4/4] dma: swiotlb: Remove SWIOTLB_ANY
Date: Fri,  4 Sep 2026 15:48:10 +0530
Message-ID: <20260904101810.1193505-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
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

SWIOTLB_ANY permits the swiotlb pool to be allocated outside the
architecture's low address limit. This is already implied when
SWIOTLB_INIT_ADDRESSING_LIMIT is not set, making SWIOTLB_ANY redundant.

Use SWIOTLB_INIT_ADDRESSING_LIMIT as the sole indication that the
default pool and any dynamically allocated pools must reside below
ARCH_LOW_ADDRESS_LIMIT. Otherwise, allow the pools to use any directly
mapped memory.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 Documentation/core-api/swiotlb.rst |  8 ++++----
 arch/powerpc/mm/mem.c              |  6 ++++--
 arch/s390/mm/init.c                |  2 +-
 arch/x86/kernel/pci-dma.c          |  2 +-
 include/linux/swiotlb.h            |  5 ++---
 kernel/dma/swiotlb.c               | 17 ++++++-----------
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
index 71b4e4c27eb5..06d9f88fdf7b 100644
--- a/Documentation/core-api/swiotlb.rst
+++ b/Documentation/core-api/swiotlb.rst
@@ -148,10 +148,10 @@ may also be adjusted
 due to other conditions, such as running in a CoCo VM, as described above. If
 CONFIG_SWIOTLB_DYNAMIC is enabled, additional pools may be allocated later in
 the life of the system. Each pool must be a contiguous range of physical
-memory. The default pool is allocated below the 4 GiB physical address line so
-it works for devices that can only address 32-bits of physical memory (unless
-architecture-specific code provides the SWIOTLB_ANY flag). In a CoCo VM, the
-pool memory must be decrypted before swiotlb is used.
+memory. The default pool is allocated below the architecture's low address
+limit when it is needed for devices with limited DMA addressing. Otherwise,
+it may be allocated anywhere in directly mapped memory. In a CoCo VM, the pool
+memory must be decrypted before swiotlb is used.
 
 Each pool is divided into "slots" of size IO_TLB_SIZE, which is 2 KiB with
 current definitions. IO_TLB_SEGSIZE contiguous slots (128 slots) constitute
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 006ed41097e9..1bdea6c03848 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -295,9 +295,11 @@ void __init arch_mm_preinit(void)
 		/*
 		 * Since the guest memory is inaccessible to the host,
 		 * devices always need to use the SWIOTLB buffer for DMA
-		 * even if dma_capable() says otherwise.
+		 * even if dma_capable() says otherwise. The hypervisor has
+		 * no addressing limitation, so the buffer may be allocated
+		 * anywhere.
 		 */
-		ppc_swiotlb_flags |= SWIOTLB_ANY;
+		ppc_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
 	}
 
 	/*
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 78f507e24ceb..ce10292447f1 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -166,7 +166,7 @@ static void __init pv_init(void)
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_ANY);
+	swiotlb_init(SWIOTLB_VERBOSE);
 	swiotlb_update_mem_attributes();
 }
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 3c82ebb5b6e0..e472631a5bd7 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -84,7 +84,7 @@ static void __init pci_xen_swiotlb_init(void)
 	x86_swiotlb_enable = true;
 	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
 	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
-	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
+	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP;
 	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
 	if (IS_ENABLED(CONFIG_PCI))
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index be3962a33fc6..b3da751a81dd 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,11 +15,10 @@ struct page;
 struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
-#define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
 /* Initialize a default-sized pool for devices with limited DMA addressing. */
-#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
+#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 1)
 /* Initialize a default-sized pool that requires architecture remapping. */
-#define SWIOTLB_INIT_REMAP		(1 << 3)
+#define SWIOTLB_INIT_REMAP		(1 << 2)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c4611b2c4540..2715833a21f8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -448,15 +448,10 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
 	void *tlb;
 
-	/*
-	 * By default allocate the bounce buffer memory from low memory, but
-	 * allow to pick a location everywhere for hypervisors with guest
-	 * memory encryption.
-	 */
-	if (flags & SWIOTLB_ANY)
-		tlb = memblock_alloc(bytes, PAGE_SIZE);
-	else
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	else
+		tlb = memblock_alloc(bytes, PAGE_SIZE);
 
 	if (!tlb) {
 		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
@@ -598,10 +593,10 @@ void __init swiotlb_init_remap(unsigned int flags,
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
 		io_tlb_default_mem.can_grow = true;
-	if (flags & SWIOTLB_ANY)
-		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
-	else
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
 		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
+	else
+		io_tlb_default_mem.phys_limit = virt_to_phys(high_memory - 1);
 #endif
 
 	/* if we have host or guest memory encryption */
-- 
2.43.0


