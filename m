Return-Path: <linuxppc-dev+bounces-19579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E935F4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:19:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbT15mmZz2yl2;
	Fri, 10 Apr 2026 22:19:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823557;
	cv=none; b=XuEAjrN5KqJSLvU2EwlWFx+UqubpKxa2x/ZIx60m8TRO3nvo22kanLldMf2UR+lIWfY5h8eto3HCMx13Fi5Uh7ZqqPtt3XQaaZ+q0sk5TU8v8K2RqHIr1My0qfoKPPDNQa8AHqB8FrdI4Oa1lmf26Ln30wEnKL2G9vWZEItPPyx+CNNEFZNtY5wInjBMG2kMqHRNAb2lReYudAcfap4u4FpeGX8U2QAPogbHhuG73b8uI1pz/PjdK5fTHAqeptsWvjR25LYUP+cA8SSasAASriXtj5strhJe5uAGHsTRP8R8ElDg8KfWApvM7/V+7pumF+BmOY4gx64qPdL2alKxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823557; c=relaxed/relaxed;
	bh=P2IEyAEzLrLcDKf1D+hPXmSP/5CZZgHCZVdt+e9rGY8=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Y+2gSwiRSU05+EwN0hF2woRzFd1L72pC0gSjbI78IIahmMVkSxGmTXLi0A21aNCVv8GeBcuOLbvai5T7YTKlp7Ih4bSVrGbbNHWrBG+CCDl9Hp2WSOtBoWo+bw14J0Il/TuH/aglRPNaygUHw9+GsKRy6hvlCj5knNyZ1mZuZZfMmz/pnMgMTUiOimmvbj4suwS8LfwL9mCfCF3yP+B8YsD4S4NC0Vqul0/j3k1f94cb5SjuThTlh3xqNoLXrC4JveJ8ON2irobGI2Ya6WXPVagj6A8WRpegfgU9cYG9ZjBHSbMhpAQFapJBL9VuidlDv0t/Y0IrBCFGhpPfmKpbAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pacXAmHL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pacXAmHL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbT103lYz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:19:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 65ACF44037;
	Fri, 10 Apr 2026 12:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE3EC2BC87;
	Fri, 10 Apr 2026 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823555;
	bh=qtG4jYoFMBUH8Rv5LkkLsBrvbBwuDbTX1269QfkLCzw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=pacXAmHLAMseTev4RAQUAZDfRzJFeJXjwMW3x14w8vUm7ybikBbtslQQu96s/8Sq0
	 a3pcIexn/gzfbwI2qYLuXSTx/gSXbmVwhuUFKfTY31pSFVH71nhoebkIPAnwJfmArK
	 tPmJiCD8oWRaoY6EByg0L3DGpV75oKKW/C5lmUUCoaSznEsjUHpS9yyQByZ5hUlH3x
	 P8NYw39byMTR2ebfPveTfvTFbDgwqYFvegEj7/kJQbjlvVeppRrN8YtOduabfxNT6E
	 Yw4oV6JDjGSLEpWghPJGJFmnCci2PXJh9wjpVWvhGUbODkplfUDbeuEJIVIN1zibiF
	 mC2OEaJT1jHhg==
Date: Fri, 10 Apr 2026 14:19:12 +0200
Message-ID: <20260410120318.187521447@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 09/38] iommu/vt-d: Use sched_clock() instead of get_cycles()
References: <20260410120044.031381086@kernel.org>
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
Content-Type: text/plain; charset=UTF-8

Calculating the timeout from get_cycles() is a historical leftover without
any functional requirement.

Use ktime_get() instead.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
---
 arch/x86/include/asm/iommu.h |    3 ---
 drivers/iommu/intel/dmar.c   |    4 ++--
 drivers/iommu/intel/iommu.h  |    8 ++++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -18,9 +18,6 @@ extern bool x86_swiotlb_enable;
 #define x86_swiotlb_enable false
 #endif
 
-/* 10 seconds */
-#define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
-
 static inline int __init
 arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1606,9 +1606,9 @@ void qi_flush_pasid_cache(struct intel_i
  */
 void dmar_disable_qi(struct intel_iommu *iommu)
 {
+	ktime_t start_time = ktime_get();
 	unsigned long flags;
 	u32 sts;
-	cycles_t start_time = get_cycles();
 
 	if (!ecap_qis(iommu->ecap))
 		return;
@@ -1624,7 +1624,7 @@ void dmar_disable_qi(struct intel_iommu
 	 */
 	while ((readl(iommu->reg + DMAR_IQT_REG) !=
 		readl(iommu->reg + DMAR_IQH_REG)) &&
-		(DMAR_OPERATION_TIMEOUT > (get_cycles() - start_time)))
+	       (DMAR_OPERATION_TIMEOUT > (ktime_get() - start_time)))
 		cpu_relax();
 
 	iommu->gcmd &= ~DMA_GCMD_QIE;
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -23,6 +23,7 @@
 #include <linux/xarray.h>
 #include <linux/perf_event.h>
 #include <linux/pci.h>
+#include <linux/timekeeping.h>
 #include <linux/generic_pt/iommu.h>
 
 #include <asm/iommu.h>
@@ -360,14 +361,17 @@
 /* PERFINTRSTS_REG */
 #define DMA_PERFINTRSTS_PIS	((u32)1)
 
+#define DMAR_OPERATION_TIMEOUT  (((ktime_t)10) * NSEC_PER_SEC)
+
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
-	cycles_t start_time = get_cycles();				\
+	ktime_t start_time = ktime_get();				\
+									\
 	while (1) {							\
 		sts = op(iommu->reg + offset);				\
 		if (cond)						\
 			break;						\
-		if (DMAR_OPERATION_TIMEOUT < (get_cycles() - start_time))\
+		if (DMAR_OPERATION_TIMEOUT < (ktime_get() - start_time))\
 			panic("DMAR hardware is malfunctioning\n");	\
 		cpu_relax();						\
 	}								\


