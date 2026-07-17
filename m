Return-Path: <linuxppc-dev+bounces-24364-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213C0C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 18:06:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1yX63TPjz3c4Y;
	Sat, 18 Jul 2026 04:06:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784311574;
	cv=none; b=P5EWCoAbzAI2wFMsVHCXks+pg5tfnJ0Z7Y2qMA6C0NO7WLsaUaBEpcOaULDFGZYGn7Nl1H2kEb6mEgkrAIWnbcRMpXWewydqcEujejbNgHD2zdGMJRbRjsPX8RT66O3a23RaD6xJPnF7Ojb0Kd+xxPOHkqx9S2GmDcTXHn5Acm/7UetYNdylW2Io2RPfJNtR40xlS7lxlipc3LlD8GTogm8iXFxSblrj4Iol+rkzPLKYNDuldP9VtKm+K4TBxLPKXfdYIazteYLTkfXYP+92+sS8sGaufdoWlXtYJdq9AIy2MkSa0FJCZ6VDQohEST0zrk1RGSseukjJAbzK0bHozA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784311574; c=relaxed/relaxed;
	bh=Rrxw0zEy8zZMWEqkMIDa1FzZShUbfKRclWdKlq0ShMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kp9a+fsVFqYXnkEO8ebKv/aELCBjMO28nyvdahqQEJfCEf0WptCOhtIOXdV/WFjEcyDV6SrPcfuWjG8m8GImGVUThtaqjtfP0INPvcgcBjgKk0U9c+vkjIwcXU7CtZRl3JDc5MlgNL2EvSZ3uX6rHOwTtRLbcBqogW6gcDiBuYHRLnHtTu5eMhcWFrhirVceNoXweo0Z6dGXF4MEL4YSqUUaDkFGHONSqSiBd5r2AwH1b07vf1HmX4F1TOFb/hMMlhQBuvwO//nsLZ1q0dp+qQUJbdouw7Kk9TU9FugFRe68cL9tCxAw7jb+0q4Rxc3GagOIVx/e7RTXLXYyYqeCQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EERFj5zc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EERFj5zc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1yX55Dclz3c3x
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 04:06:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0977643922;
	Fri, 17 Jul 2026 18:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEE21F000E9;
	Fri, 17 Jul 2026 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311571;
	bh=Rrxw0zEy8zZMWEqkMIDa1FzZShUbfKRclWdKlq0ShMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EERFj5zc2d1jA+hIVXVcVJggI1VJBh6HdI8oHQug+TwsCjCPDhkj8fgqKZNT5UKmQ
	 skT7ficUTZLNY6S5Q3WuT+J3gDPyb5GnOK0eE4+99RLNKTOi0lmWjkSlC/FxYVNHnn
	 q+TDBxiQ5oDyN2mWpC+pdJKRIjdGTidnIJ2DRnbkb/Wwweh43EfdUgHvUnqdvibl/B
	 e/zfr+LG1u2pOOInDppAvmMm2gA8NijvsUlHIklzuhUedsUdhgRC1xjDdCSCqYxnZL
	 whMwkwGTaERO5lLJjICrZdh5y2RbN8VXWq6eAWyMjpTj/NNgKByqrALdpvYGXDfxBD
	 AzsJQx65teoug==
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
Subject: [PATCH v8 06/23] s390: Expose protected virtualization through cc_platform_has()
Date: Fri, 17 Jul 2026 23:34:24 +0530
Message-ID: <20260717180442.110954-7-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
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

Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Jaehoon  Kim <jhkim@linux.ibm.com>
Tested-by: Jaehoon Kim <jhkim@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/s390/Kconfig   |  1 +
 arch/s390/mm/init.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..ab1bf55d197a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -84,6 +84,7 @@ config S390
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CC_CAN_LINK
+	select ARCH_HAS_CC_PLATFORM
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f07168a0d3dd..c29326c44af0 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -50,6 +50,7 @@
 #include <linux/virtio_anchor.h>
 #include <linux/virtio_config.h>
 #include <linux/execmem.h>
+#include <linux/cc_platform.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
 pgd_t invalid_pg_dir[PTRS_PER_PGD] __section(".bss..invalid_pg_dir");
@@ -142,6 +143,19 @@ bool force_dma_unencrypted(struct device *dev)
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


