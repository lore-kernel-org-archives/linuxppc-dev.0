Return-Path: <linuxppc-dev+bounces-21350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D569CD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 04:29:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMC3465C3z2xSN;
	Fri, 22 May 2026 14:29:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779424144;
	cv=none; b=d0kP/JEgiyqM/20mdlKVdnezttYEaXExCIGUiCNoM2FVz4bYSLZEDRp3/uEg4FjPSrtPEheC6gtrZACOflZ8NMSP5Rc/+7DtVcr/RjZqrkaw9rAWmCRTN8fopjKeLNKL5ysrsWnwGsaIitxI5N0rHbcJkxmt1SK46/CWt3Hpc9TL7XGN7+VUCdRfpIwfsdOl9GZGHKPxTLFBZ6mpo8KlAzWxvD7kS8WeD5myaqHX03uzeLmGWKYi1F8ogZvEQEP7heNagc7y6XPFRPHi82lj4XD7bhG2MV051ujrhddVZhVhWTajd/jH556xIEYexImiCcK0kl52b005/iWD1u0E3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779424144; c=relaxed/relaxed;
	bh=4aF9+d8jwgDAX56PY9Oecf4wOZ9YOQdZwhZO6X/dmDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9C1NKi0pMprA0GjKb4c2ewJYiIjp+Yl/HmFv5IjOgjmqQhjN157Mc4/rQOopjEJUxND09jfZg8drvZkPRgRgFgCuMP31SmOvX4GqkgXNNQ6POunL65Nr7W9sqr3SYmo4qngy4CKdlP1pd5MLtKW0jhh/Re289/WJMmN39Q5cvUvNeqOGL8S+kaMPOeMCIcRCJ9VUUV415z8QKZQaLjLO0+WDjz7QFceTto6i174V2binnbzS99VGI2QadmMBximhESQaVUL/wkNuBQyD7SUp8rz6rqTc69BIjHgrZ3nDbOyUxgltJCbpndHoeIkhsg7H/rDfQHJ/wqTX66c9mLtdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQoyawK8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQoyawK8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMC340KfZz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 14:29:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C3AA60172;
	Fri, 22 May 2026 04:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D13A1F000E9;
	Fri, 22 May 2026 04:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424141;
	bh=4aF9+d8jwgDAX56PY9Oecf4wOZ9YOQdZwhZO6X/dmDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQoyawK8y+HW7VDzUabZEzIrZMxRHXdpf/BDYPznoAE+Q6F0scH3UnMFqICzd6qWv
	 4LbbljSgBLQjqtntkeO/+IVq4sO6eqL3fn3WTONJfIDhngF9Ngl7YYO9x4U4fdJwcr
	 7hThxT/Jz/LlAG05H970ULFr26ngAdhF3QzgfIFW5MKIZA1M4jQ1W5XJyM7zc8EVoG
	 KB1BH9PWN7nrgb79LWOpW0nTN03ONx6qqd0lRzmgZnfJ874m5C3f6fGj2Kqqa7TcBy
	 DLNynTYhdlh9Cey8CGdd/mrmFS+4vFir/UlmRMRvjCphkLeHJFBObp2YnnyhkwIu+j
	 LsbLqIQqmxb0Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
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
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
	x86@kernel.org,
	Halil Pasic <pasic@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v5 02/20] [DO NOT MERGE] s390: Expose protected virtualization through cc_platform_has()
Date: Fri, 22 May 2026 09:57:57 +0530
Message-ID: <20260522042815.370873-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
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

Protected virtualization guests use memory encryption, so advertise that to
the rest of the kernel through cc_platform_has(CC_ATTR_MEM_ENCRYPT).

s390 already forces DMA mappings to be unencrypted for protected
virtualization guests through force_dma_unencrypted(). Add
ARCH_HAS_CC_PLATFORM and provide the matching cc_platform_has()
implementation

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Jaehoon  Kim <jhkim@linux.ibm.com>
---
 arch/s390/Kconfig   |  1 +
 arch/s390/mm/init.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..9b5e6029e043 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -87,6 +87,7 @@ config S390
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CC_CAN_LINK
+	select ARCH_HAS_CC_PLATFORM
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 1f72efc2a579..ad3c6d92b801 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -50,6 +50,7 @@
 #include <linux/virtio_anchor.h>
 #include <linux/virtio_config.h>
 #include <linux/execmem.h>
+#include <linux/cc_platform.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
 pgd_t invalid_pg_dir[PTRS_PER_PGD] __section(".bss..invalid_pg_dir");
@@ -140,6 +141,19 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_prot_virt_guest();
 }
 
+
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_prot_virt_guest();
+
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
+
 /* protected virtualization */
 static void __init pv_init(void)
 {
-- 
2.43.0


