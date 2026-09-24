Return-Path: <linuxppc-dev+bounces-28084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62A2C98312
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 06:08:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr3LH16Hwz30Sx;
	Thu, 24 Sep 2026 16:08:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790230119;
	cv=none; b=PPrpRzE53nWXIDm/auUo+GsVGLtOgW88YIFQQ6Q8VMbGVAdU7FB1YLonr3Vh3EpbuG+bDqvnXd1CIXWRnDN2Uqkc8rbcS6JSLrlEcxXddBQmp2JJkzXykA7RIhd/jx7UIE8GnGLZBP8dDq1rlQ3tFHHRv79hpLtHdEzEFX8Z4sj2CSVBDKCtaGzbxXdKdoqLMQbXyJcLDkcMNnGXVXwqLChcEBaTexknCqMkTd8wiqjuBKgis++ZYme8Uy9AH6+c4D2F6TjzI9F43a+FCK/+IDK/EXi0zCNM0DLGEy6+Ktm+ypRYy4u7YRRCAFQiK5KvxNCYe5a5USPOhGBLOOmk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790230119; c=relaxed/relaxed;
	bh=90/UBHgIVZHnWcX2iXkQQVtFO2UpIQ73195GKlJNVa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To6t84MyyY4PdXCZaemjJ8yUFlU2TSYmZFwFDmgiemeSaW7+Z9xN8Ygs44p7eDTliJvAEbc0JNhrVBMYafF69i0ogOb8cSmgk/VR+ae7Y+5cv7QXtKoW3y81wzJwwdDsHZ0izpxiNOrXPZs9WS7DkPflICGcCni8ER876mA+Bs9o+S19MnqXFrHjnrjFaGj9jk8Z54mqWt08sV79x6obLV+CmPv9WqG2TirrQDUX4/HAH73gT8U94utHqKb5j2R44Vf3ghZVLvY5CZ/Q4fTDa4wjXCCBlNINKdsrkNH4LPUCQLt6K7UK2Iz7OctY18k1mX1p/AaunElqKyBKM4ZPAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn1JBlRs; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn1JBlRs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr3LG26zhz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 16:08:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8000A40712;
	Thu, 24 Sep 2026 06:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2F01F00893;
	Thu, 24 Sep 2026 06:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230115;
	bh=90/UBHgIVZHnWcX2iXkQQVtFO2UpIQ73195GKlJNVa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dn1JBlRsc1tzw1/Hp0ITWR1GzpUUhunYQCS0MQv1129xb7p54LHARo1KWvgJbKpYA
	 WxRRH3LRfneK8Jz+4Zv9Nb+SqgCe1KZxIRAUYJeRoXALzqqfIJjYWLZY+Blfsk7etY
	 7cbkpIUhQT3NqW9yf+YPzFUS7wMLzRbUEOyRPMgBwXSEKJWbGdGk2DigF3ABrcabAJ
	 IedCTNlJjkIg/pOURGkjX18mbmywzCKsTIosd2GinD2FpeTrKk+yD06Xa48WBpagr3
	 JXK0moBAIFefd37ROD/cGCVIBgOoINaxjXS2y3lSw4P+i6b2O/+LY7qU11vY+s3+Bz
	 DRDSkaKIG1Blw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v6 1/8] dma: swiotlb: Rename swiotlb_size_or_default()
Date: Thu, 24 Sep 2026 11:37:49 +0530
Message-ID: <20260924060756.1325156-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
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

Rename swiotlb_size_or_default() to swiotlb_default_pool_size() to make
clear that it returns the current size of the default SWIOTLB pool.
This includes changes made by command-line options or sizing heuristics,
not just the compiled-in default.

No functional change.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm/xen/mm.c                    | 2 +-
 arch/arm64/mm/init.c                 | 2 +-
 arch/riscv/mm/init.c                 | 2 +-
 arch/x86/include/asm/crash_reserve.h | 4 ++--
 include/linux/swiotlb.h              | 2 +-
 kernel/dma/swiotlb.c                 | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 882cd70c7a2f..a6cf55c6fd55 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -125,7 +125,7 @@ static int __init xen_mm_init(void)
 		return 0;
 
 	/* we can work with the default swiotlb */
-	rc = swiotlb_init_late(swiotlb_size_or_default(),
+	rc = swiotlb_init_late(swiotlb_default_pool_size(),
 			       xen_swiotlb_gfp(), NULL);
 	if (rc < 0)
 		return rc;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index fbf215ecc7d0..0842098a279b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -348,7 +348,7 @@ void __init arch_mm_preinit(void)
 		unsigned long size =
 			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
 
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
+		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
 	}
 
 	swiotlb_init(true, flags);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb37b0b67efe..5fa392021717 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -185,7 +185,7 @@ void __init arch_mm_preinit(void)
 		 */
 		unsigned long size =
 			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
+		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
 		swiotlb = true;
 		swiotlb_flags |= SWIOTLB_ANY;
 	}
diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 7835b2cdff04..047f638a766d 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -18,7 +18,7 @@
  * no good way to detect the paging mode of the target kernel which will be
  * loaded for dumping.
  */
-extern unsigned long swiotlb_size_or_default(void);
+extern unsigned long swiotlb_default_pool_size(void);
 
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX     SZ_512M
@@ -33,7 +33,7 @@ extern unsigned long swiotlb_size_or_default(void);
 static inline unsigned long crash_low_size_default(void)
 {
 #ifdef CONFIG_X86_64
-	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+	return max(swiotlb_default_pool_size() + (8UL << 20), 256UL << 20);
 #else
 	return 0;
 #endif
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 2a421241b980..5f24edf47b68 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -38,7 +38,7 @@ struct scatterlist;
 #define IO_TLB_DEFAULT_SIZE (64UL << 20)
 #endif
 
-unsigned long swiotlb_size_or_default(void);
+unsigned long swiotlb_default_pool_size(void);
 void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	int (*remap)(void *tlb, unsigned long nslabs));
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ded7016a46a7..42c51fb57e12 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -285,7 +285,7 @@ setup_io_tlb_npages(char *str)
 }
 early_param("swiotlb", setup_io_tlb_npages);
 
-unsigned long swiotlb_size_or_default(void)
+unsigned long swiotlb_default_pool_size(void)
 {
 	return default_nslabs << IO_TLB_SHIFT;
 }
-- 
2.43.0


