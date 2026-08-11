Return-Path: <linuxppc-dev+bounces-25742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5799AC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 13:41:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKCSy6pmfz2yyJ;
	Tue, 11 Aug 2026 23:41:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786455682;
	cv=none; b=J+eTfPAEpqZvkWq9fx2iB5+yZofJDdORE8fuD0wpvKfWTYHQd6vsZ9EDvA6Leiep6fdw7FbFX323nDbOJ6/PsY2vp4v6gccvySyTC/2lUGQ2ZEEQnCe8UcvlYR21MLxI/ZnVic7UUH0kzviSsgJT1SrHQrOP4Lub+WGYfpLYEB2hLLEb0uuQyVl2/QaO1PiIAsbVgVuM+sBw1fYOFMV7PjpLBiHuufbrLlqiiqAxuszCch9JC8129acgc2UgETAHP9eQaOiwQaBcjF5Oa2P/R7/7mqE49XtGQrvzeFLiT+cjQ8hgpuBZL/mfnyrM4Pi6UXPJxIIZo5hFdA07g85VDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786455682; c=relaxed/relaxed;
	bh=Rtob55i4e0G3U1P7cI6YyoQ5Gk8sDLsGafMrnwcMx2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfoJdE6tP0w8Y/XbNPNpB4h9inGn5MT0pOOsWiUxCTlDyFjxIfIcGDSv9jH6s9cmkL2E5Cv5XO1XojOt2O3xZNupjqY6lfYUKq2llDZ/3nsaI+mkJKwMwg0aExB7Ea88Ner9CFJA9Tem+H6ygm8KKxjN01oAXwh2TCYQgakKHruYyrGsyq9/IvasI2TaAkHAMpYqchuMUFlj5MZMa+f08UNUdLc/zJQbHRC1xllHti+JNi0w0A8MR+DV4bOHxikh24O4IGHRPWctiss6W4D260rZQWUhxCCGYcDNBToGnlUqPw9WHotbYlaCmBxfy6Kk4cpTZsKEYkLDuUO6slpVrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjOpUM8Z; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjOpUM8Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKCSx4r7Hz2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 23:41:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 59405600AD;
	Tue, 11 Aug 2026 13:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B11F000E9;
	Tue, 11 Aug 2026 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786455678;
	bh=Rtob55i4e0G3U1P7cI6YyoQ5Gk8sDLsGafMrnwcMx2Y=;
	h=From:To:Cc:Subject:Date;
	b=WjOpUM8Zua34pWZkC/xHj7rZadf2NR92L+j7peuB2sGQVps47SQ7I9RtU8SF18l6I
	 IOh/wc7zD4UA0dbEhTmcxDzLStcT1cvy1mrgeLWWWyuGOUZKL6L8S5R71MlHSOjVOf
	 Gh9h6CvCQXmsBmtCBx5c6iccERDFj62Dr+KKoVWJNsEppeq5zZyyzYCjMT2RGvAFbo
	 +wpOunRFbWefmd0o691QiJ86WOkjX/8ExdZWV7k9L/oX/qR8GTQ+94d9ZuViEPto9z
	 zp/AxyWsyP/wCjKCAeD8aWGIabx2hjjHuhMNglixaSBZdqHawXPD8B/SrTh5qLREzt
	 J012u7kyh0ffg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
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
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH] dma: swiotlb: Size shared default pools for memory encryption
Date: Tue, 11 Aug 2026 19:10:56 +0530
Message-ID: <20260811134056.756015-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Systems with memory encryption use swiotlb to provide shared or
unencrypted buffers for device DMA. Confidential guests may route all
DMA through these buffers, while SME hosts use them for devices that
cannot address encrypted memory. The default swiotlb pool can therefore
be exhausted under I/O-intensive workloads.

Let architectures mark the default swiotlb pool as shared before
swiotlb_init(). Move the existing x86 sizing policy into generic swiotlb
code and add early pool marking for arm64 Realm guests, powerpc secure
guests, s390 protected-virtualization guests, and x86 memory-encryption
platforms. Use CC_ATTR_MEM_ENCRYPT on x86 to include host SME, whose
swiotlb pool must also be decrypted for devices that cannot address
encrypted memory.

Move the powerpc secure-guest swiotlb enablement before initialization
so that the shared pool is allocated with the required flags. pKVM
guests continue to use a restricted DMA pool instead of the default
swiotlb pool.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c                 |  6 ++-
 arch/powerpc/mm/mem.c                |  7 +++
 arch/powerpc/platforms/pseries/svm.c | 10 ----
 arch/s390/mm/init.c                  |  2 +
 arch/x86/mm/mem_encrypt.c            | 27 ++--------
 include/linux/swiotlb.h              |  7 ++-
 kernel/dma/swiotlb.c                 | 73 ++++++++++++++++++++++------
 7 files changed, 82 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e308a7cabd12..4c022e8aed43 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -338,8 +338,12 @@ void __init arch_setup_zero_pages(void)
 void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
+	/* pKVM uses restricted-dma-pool */
+	bool cc_guest = is_realm_world();
 
-	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
+	if (cc_guest) {
+		swiotlb_mark_default_cc_shared();
+	} else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
 		/*
 		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
 		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 4c1afab91996..39246ac66ad4 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -287,6 +287,13 @@ void __init arch_mm_preinit(void)
 	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
 
 #ifdef CONFIG_SWIOTLB
+	if (is_secure_guest()) {
+		/* The host can access DMA buffers only through the SWIOTLB. */
+		swiotlb_mark_default_cc_shared();
+		ppc_swiotlb_enable = 1;
+		ppc_swiotlb_flags |= SWIOTLB_ANY;
+	}
+
 	/*
 	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
 	 * 4G. We force memblock to bottom-up mode to ensure that the
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 7a403dbd35ee..4a0be631dc6d 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -21,16 +21,6 @@ static int __init init_svm(void)
 	if (!is_secure_guest())
 		return 0;
 
-	/* Don't release the SWIOTLB buffer. */
-	ppc_swiotlb_enable = 1;
-
-	/*
-	 * Since the guest memory is inaccessible to the host, devices always
-	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
-	 * otherwise.
-	 */
-	ppc_swiotlb_flags |= SWIOTLB_ANY;
-
 	/* Share the SWIOTLB buffer with the host. */
 	swiotlb_update_mem_attributes();
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 8d1de5a2e554..d88578fa550c 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -163,6 +163,8 @@ static void __init pv_init(void)
 	if (!is_prot_virt_guest())
 		return;
 
+	swiotlb_mark_default_cc_shared();
+
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 95bae74fdab2..9fa4c97b34e0 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -101,9 +101,6 @@ void __init mem_encrypt_init(void)
 
 void __init mem_encrypt_setup_arch(void)
 {
-	phys_addr_t total_mem = memblock_phys_mem_size();
-	unsigned long size;
-
 	/*
 	 * Do RMP table fixups after the e820 tables have been setup by
 	 * e820__memory_setup().
@@ -111,30 +108,12 @@ void __init mem_encrypt_setup_arch(void)
 	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		snp_fixup_e820_tables();
 
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		swiotlb_mark_default_cc_shared();
+
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
-	/*
-	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
-	 * Kernel uses SWIOTLB to make this happen without changing device
-	 * drivers. However, depending on the workload being run, the
-	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
-	 * run out of buffers for DMA, resulting in I/O errors and/or
-	 * performance degradation especially with high I/O workloads.
-	 *
-	 * Adjust the default size of SWIOTLB using a percentage of guest
-	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
-	 * memory is allocated from low memory, ensure that the adjusted size
-	 * is within the limits of low available memory.
-	 *
-	 * The percentage of guest memory used here for SWIOTLB buffers
-	 * is more of an approximation of the static adjustment which
-	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
-	 */
-	size = total_mem * 6 / 100;
-	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
-	swiotlb_adjust_size(size);
-
 	/* Set restricted memory access for virtio. */
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 }
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 277b9aa2edaa..324859ecb5cd 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -189,7 +189,8 @@ void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_allocated(void);
 bool is_swiotlb_active(struct device *dev);
-void __init swiotlb_adjust_size(unsigned long size);
+void __init swiotlb_mark_default_cc_shared(void);
+void swiotlb_adjust_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
 #else
@@ -228,6 +229,10 @@ static inline bool is_swiotlb_active(struct device *dev)
 	return false;
 }
 
+static inline void swiotlb_mark_default_cc_shared(void)
+{
+}
+
 static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 897aba538c5b..bc67d427f995 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -208,7 +208,7 @@ unsigned long swiotlb_size_or_default(void)
 	return default_nslabs << IO_TLB_SHIFT;
 }
 
-void __init swiotlb_adjust_size(unsigned long size)
+void swiotlb_adjust_size(unsigned long size)
 {
 	/*
 	 * If swiotlb parameter has not been specified, give a chance to
@@ -274,24 +274,15 @@ static void swiotlb_mark_pool_used(struct io_tlb_pool *pool)
 void __init swiotlb_update_mem_attributes(void)
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
-	unsigned long bytes;
-
-	/*
-	 * if platform support memory encryption, swiotlb buffers are
-	 * shared by default.
-	 */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		io_tlb_default_mem.cc_shared = true;
-	else
-		io_tlb_default_mem.cc_shared = false;
 
 	if (!mem->nslabs || mem->late_alloc)
 		return;
-	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 
 	if (io_tlb_default_mem.cc_shared) {
 		int ret;
+		unsigned long bytes;
 
+		bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 		ret = set_memory_decrypted((unsigned long)mem->vaddr,
 					   bytes >> PAGE_SHIFT);
 		if (ret) {
@@ -382,6 +373,42 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	return tlb;
 }
 
+void __init swiotlb_mark_default_cc_shared(void)
+{
+	io_tlb_default_mem.cc_shared = true;
+}
+
+static void swiotlb_adjust_cc_attributes(void)
+{
+	unsigned long size;
+	phys_addr_t total_mem = memblock_phys_mem_size();
+
+	/*
+	 * For SEV and TDX and CCA, all DMA has to occur via
+	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
+	 * happen without changing device drivers. However, depending on
+	 * the workload being run, the default 64MB of SWIOTLB may not be
+	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
+	 * I/O errors and/or performance degradation especially with high
+	 * I/O workloads.
+	 *
+	 * Adjust the default size of SWIOTLB using a percentage of guest
+	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
+	 * memory is allocated from low memory, ensure that the adjusted
+	 * size is within the limits of low available memory.
+	 *
+	 * The percentage of guest memory used here for SWIOTLB buffers is
+	 * more of an approximation of the static adjustment which 64MB for
+	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 */
+	size = total_mem * 6 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	swiotlb_adjust_size(size);
+
+	if (!IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC))
+		pr_info("Consider enabling CONFIG_SWIOTLB_DYNAMIC for memory-encrypted systems\n");
+}
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
@@ -395,8 +422,14 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	size_t alloc_size;
 	void *tlb;
 
-	if (!addressing_limit && !swiotlb_force_bounce)
+	/*
+	 * A shared pool is required for DMA on memory-encrypted systems even
+	 * when all devices are otherwise able to address memory directly.
+	 */
+	if (!addressing_limit && !swiotlb_force_bounce &&
+	    !io_tlb_default_mem.cc_shared)
 		return;
+
 	if (swiotlb_force_disable)
 		return;
 
@@ -411,6 +444,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
 #endif
 
+	if (io_tlb_default_mem.cc_shared)
+		swiotlb_adjust_cc_attributes();
+
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -465,7 +501,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
-	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	unsigned long nslabs;
 	unsigned int order, area_order, slot_order;
 	bool leak_pages = false;
 	unsigned int nareas;
@@ -479,6 +515,15 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (swiotlb_force_disable)
 		return 0;
 
+	/* Apply the shared-pool default sizing before deriving nslabs. */
+	if (io_tlb_default_mem.cc_shared &&
+	    size == swiotlb_size_or_default()) {
+		swiotlb_adjust_cc_attributes();
+		size = swiotlb_size_or_default();
+	}
+
+	nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
-- 
2.43.0


