Return-Path: <linuxppc-dev+bounces-21349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFCACD5BB3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 04:28:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMC2s26bTz2xpn;
	Fri, 22 May 2026 14:28:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779424133;
	cv=none; b=LtJe5Sq9wwkna/XXkVurF4QptNTmf9yWKSpPn35OI0bEtWuDRnsyXwR/2+aQEdYDS/UxAX9/2KjUNbUDlg3/ZzZ3xxJ/fMVljB01WiaR4lc0YnlIKuWqOjO+AymNwZ4BU/CJwuJOttlFRi8umti717lXsDo9nYMz0d8OhInvYhTglxHT9WNZ0iblUjtMsJ9w56Lr/wZztjqUBVWFVLdC0/yI0O5BbLWhFCeZk5JIrZUZnczezweXKzDEcl+Yg2Z9wDT43TUhHVk2dZ5Q5xG9h1Rn4cXofS4jL4zyUA+sLv2yW995j3Q9TxI2nidP43+d/BFt2SIdUWS1H1EHRCQDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779424133; c=relaxed/relaxed;
	bh=EN0IQUuPXitnl1iltsyZkrJ7mdFplVIW+Qac7dXtXac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOjJ5TRxC4chWJkjBbeo4Q23hUoOQZ+trqbJSKxKYLyG2TExhPIX0QMalAsz3ix8cS4HcAgQwpo3ZnvUkbcr8q45XwimTsHmA4gMuhGFap2lFCJczUOP0HSY2HFeprdhV1o/jtNr9N/cE9CyjpHZ4yn3g6miIg87YZKNCNUIGmnMsaqKqoi7PjN3APxZcUaGZbMgQqbU+YPEXXZzsyDuxqvx7FhWRSnY48EzIqt63XqElWAD4XaYRnAgICAZT1DxkG93aa5ZSP56oagycWnq9LvFu+pNAvy9gXxFSL6ZDcglcdFCo04foUAcfLIX3PHTdWfpT4ulLgBK7GrkddWknA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oofhJ+Bn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oofhJ+Bn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMC2r3tbDz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 14:28:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4502E60172;
	Fri, 22 May 2026 04:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D9E1F00A3D;
	Fri, 22 May 2026 04:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424130;
	bh=EN0IQUuPXitnl1iltsyZkrJ7mdFplVIW+Qac7dXtXac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oofhJ+BnD8hM/LCVdJ/7G55+n1MfvMzsj1mvKIs9w+pDJYq+ccbHNjqkIxMBcMsOI
	 IYRjlhqi87N4ou0jrg8o6TYwheH8tqcQW+W6RvZNEy5/RiBBWG59HTEH7imcMyRY78
	 5/FXpn57pnIkN9R+y0xvddQGPGhc1Fihzc94yaxS4G9cm94A92wehVQmntTf0ceGoP
	 EqaRcHfsrsIFCyQeY7lGyxVXnADKgk4z1iHqzSRL+6PrxS/DIveIY6JZWQDQmDwNUf
	 ne3/dijtNZY+hUzTFcJggFSsezzF436KsKMclkD8FbeXxxhRKLI+pnP1/+1D51tgO7
	 0D9yvrU1JTw9w==
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
	x86@kernel.org
Subject: [PATCH v5 01/20] [DO NOT MERGE] arm64/coco: Add pKVM as a CC platform
Date: Fri, 22 May 2026 09:57:56 +0530
Message-ID: <20260522042815.370873-2-aneesh.kumar@kernel.org>
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

pKVM does support memory encryption, expose that to the rest of
the kernel through cc_platform_has()

At the moment, all devices inside the guest are emulated which
requires its memory to be shared back to the host (decrypted), so
set force_dma_unencrypted() to always return true.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/hypervisor.h           |  6 ++++++
 arch/arm64/include/asm/mem_encrypt.h          |  3 ++-
 arch/arm64/kernel/rsi.c                       | 12 ------------
 arch/arm64/mm/init.c                          | 13 +++++++++++++
 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c |  5 +++++
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/hypervisor.h b/arch/arm64/include/asm/hypervisor.h
index a12fd897c877..1b0e15f290be 100644
--- a/arch/arm64/include/asm/hypervisor.h
+++ b/arch/arm64/include/asm/hypervisor.h
@@ -10,8 +10,14 @@ void kvm_arm_target_impl_cpu_init(void);
 
 #ifdef CONFIG_ARM_PKVM_GUEST
 void pkvm_init_hyp_services(void);
+bool is_protected_kvm_guest(void);
 #else
 static inline void pkvm_init_hyp_services(void) { };
+
+static inline bool is_protected_kvm_guest(void)
+{
+	return false;
+}
 #endif
 
 static inline void kvm_arch_init_hyp_services(void)
diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index 314b2b52025f..636f45b4d8af 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_MEM_ENCRYPT_H
 #define __ASM_MEM_ENCRYPT_H
 
+#include <asm/hypervisor.h>
 #include <asm/rsi.h>
 
 struct device;
@@ -20,7 +21,7 @@ int realm_register_memory_enc_ops(void);
 
 static inline bool force_dma_unencrypted(struct device *dev)
 {
-	return is_realm_world();
+	return is_realm_world() || is_protected_kvm_guest();
 }
 
 /*
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 92160f2e57ff..25ca75ce1a4d 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -7,7 +7,6 @@
 #include <linux/memblock.h>
 #include <linux/psci.h>
 #include <linux/swiotlb.h>
-#include <linux/cc_platform.h>
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
@@ -23,17 +22,6 @@ EXPORT_SYMBOL(prot_ns_shared);
 DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
 EXPORT_SYMBOL(rsi_present);
 
-bool cc_platform_has(enum cc_attr attr)
-{
-	switch (attr) {
-	case CC_ATTR_MEM_ENCRYPT:
-		return is_realm_world();
-	default:
-		return false;
-	}
-}
-EXPORT_SYMBOL_GPL(cc_platform_has);
-
 static bool rsi_version_matches(void)
 {
 	unsigned long ver_lower, ver_higher;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 97987f850a33..c1b223e7cc8e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -12,6 +12,7 @@
 #include <linux/swap.h>
 #include <linux/init.h>
 #include <linux/cache.h>
+#include <linux/cc_platform.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/initrd.h>
@@ -36,6 +37,7 @@
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
+#include <asm/hypervisor.h>
 #include <asm/kasan.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/kvm_host.h>
@@ -416,6 +418,17 @@ void dump_mem_limit(void)
 	}
 }
 
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_realm_world() || is_protected_kvm_guest();
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
+
 #ifdef CONFIG_EXECMEM
 static u64 module_direct_base __ro_after_init = 0;
 static u64 module_plt_base __ro_after_init = 0;
diff --git a/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c b/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
index 4230b817a80b..297e6d6019b8 100644
--- a/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
+++ b/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
@@ -95,6 +95,11 @@ static int mmio_guard_ioremap_hook(phys_addr_t phys, size_t size,
 	return 0;
 }
 
+bool is_protected_kvm_guest(void)
+{
+	return !!pkvm_granule;
+}
+
 void pkvm_init_hyp_services(void)
 {
 	int i;
-- 
2.43.0


