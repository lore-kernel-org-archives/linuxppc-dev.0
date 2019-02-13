Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BBC282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 17:58:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAF0222B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LUwdnvLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAF0222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4406hD3j42zDqRj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 04:58:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="LUwdnvLz"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4406Hr06DrzDqQF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 04:40:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UXU6oxKDgZ9+oYo0ruUqoHR1FSnD+dI44Pi+CxtKUf0=; b=LUwdnvLzmXjG1aC3yMZL2aaqKY
 76h91QvJreBv5FTwpADuHvybBvGGORkHqMhQ565wVSXyEH/48TwpcMsPFIaKbljpd+CdH86aY5cBB
 504qKhW960h1tF16JzJ3v01nEW7cGr7yc/p9sdAnDButnhHn8msSV/sQLGzRq3XDAtgVnabDSQTCx
 5afKAT1JYUTR1b+k1FlwOFO3gYG5YxgSN7wTl6hvUAwRklSIU6Qx1ouP2OXZ+iFUVbl+9F3VPAFPl
 1wgBhnVQ3cV2O7YVi5E0uBWv9aUQN/g/DyuoO9IvEAfYw05KbqWuG17X6Mn+LaN2Z9UsRCwCTEqau
 FrsYfJAA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyWS-0008PD-3N; Wed, 13 Feb 2019 17:40:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 08/11] lib: consolidate the GENERIC_BUG symbol
Date: Wed, 13 Feb 2019 18:40:02 +0100
Message-Id: <20190213174005.28785-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174005.28785-1-hch@lst.de>
References: <20190213174005.28785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

And just let the architectures that want it select the symbol.
Same for GENERIC_BUG_RELATIVE_POINTERS.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig     |  5 +----
 arch/arm64/Kconfig   | 10 ++--------
 arch/c6x/Kconfig     |  5 +----
 arch/hexagon/Kconfig |  5 +----
 arch/parisc/Kconfig  |  6 +-----
 arch/powerpc/Kconfig |  6 +-----
 arch/riscv/Kconfig   | 10 ++--------
 arch/s390/Kconfig    |  8 ++------
 arch/sh/Kconfig      |  5 +----
 arch/x86/Kconfig     | 10 ++--------
 lib/Kconfig          |  6 ++++++
 11 files changed, 20 insertions(+), 56 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96780ab64a2e..c230fb1e09ba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -36,6 +36,7 @@ config ARM
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
+	select GENERIC_BUG if BUG
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
@@ -256,10 +257,6 @@ config PHYS_OFFSET
 	  Please provide the physical address corresponding to the
 	  location of main memory in your system.
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-
 config PGTABLE_LEVELS
 	int
 	default 3 if ARM_LPAE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c39dac831f08..913b2ca7ec22 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -85,6 +85,8 @@ config ARM64
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY
+	select GENERIC_BUG if BUG
+	select GENERIC_BUG_RELATIVE_POINTERS
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
@@ -234,14 +236,6 @@ config ILLEGAL_POINTER_VALUE
 	hex
 	default 0xdead000000000000
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-
-config GENERIC_BUG_RELATIVE_POINTERS
-	def_bool y
-	depends on GENERIC_BUG
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index d5f382830f49..19b145ef7d92 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -10,6 +10,7 @@ config C6X
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select CLKDEV_LOOKUP
 	select GENERIC_ATOMIC64
+	select GENERIC_BUG if BUG
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_TRACEHOOK
@@ -30,10 +31,6 @@ config FPU
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-
 config C6X_BIG_KERNEL
 	bool "Build a big kernel"
 	help
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 425217c98a77..5eb4f48506b6 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -14,6 +14,7 @@ config HEXAGON
 	# select GPIOLIB
 	# select HAVE_CLK
 	# select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_BUG if BUG
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
@@ -65,10 +66,6 @@ config GENERIC_IRQ_PROBE
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-
 menu "Machine selection"
 
 choice
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fcbc67b6b830..42282b8e086d 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -27,6 +27,7 @@ config PARISC
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_BUG if BUG
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
@@ -85,11 +86,6 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default n
 
-config GENERIC_BUG
-	bool
-	default y
-	depends on BUG
-
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8b9f3639555f..1684017fa496 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -142,6 +142,7 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_ATOMIC64			if PPC32
+	select GENERIC_BUG			if BUG
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
@@ -283,11 +284,6 @@ config AUDIT_ARCH
 	bool
 	default y
 
-config GENERIC_BUG
-	bool
-	default y
-	depends on BUG
-
 config SYS_SUPPORTS_APM_EMULATION
 	default y if PMAC_APM_EMU
 	bool
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 732614eb3683..c410ed896567 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,6 +19,8 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select GENERIC_BUG if BUG
+	select GENERIC_BUG_RELATIVE_POINTERS if 64BIT
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
@@ -66,14 +68,6 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-	select GENERIC_BUG_RELATIVE_POINTERS if 64BIT
-
-config GENERIC_BUG_RELATIVE_POINTERS
-	bool
-
 config GENERIC_CSUM
 	def_bool y
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 15ccdd04814e..2a5c12be633e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -17,12 +17,6 @@ config ARCH_HAS_ILOG2_U64
 config GENERIC_HWEIGHT
 	def_bool y
 
-config GENERIC_BUG
-	def_bool y if BUG
-
-config GENERIC_BUG_RELATIVE_POINTERS
-	def_bool y
-
 config GENERIC_LOCKBREAK
 	def_bool y if SMP && PREEMPT
 
@@ -103,6 +97,8 @@ config S390
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS2
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
+	select GENERIC_BUG if BUG
+	select GENERIC_BUG_RELATIVE_POINTERS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES if !SMP
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 01d09a4637d9..92d16cab61f3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -35,6 +35,7 @@ config SUPERH
 	select LOCKDEP_SUPPORT
 	select RTC_LIB
 	select GENERIC_ATOMIC64
+	select GENERIC_BUG if BUG && SUPERH32
 	select GENERIC_IRQ_SHOW
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
@@ -92,10 +93,6 @@ config ARCH_DEFCONFIG
 	default "arch/sh/configs/shx3_defconfig" if SUPERH32
 	default "arch/sh/configs/cayman_defconfig" if SUPERH64
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG && SUPERH32
-
 config GENERIC_CSUM
 	def_bool y
 	depends on SUPERH64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1bd4f19b6b28..f4cb31174e1b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -91,6 +91,8 @@ config X86
 	select DCACHE_WORD_ACCESS
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
+	select GENERIC_BUG			if BUG
+	select GENERIC_BUG_RELATIVE_POINTERS	if X86_64
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
@@ -253,14 +255,6 @@ config GENERIC_ISA_DMA
 	def_bool y
 	depends on ISA_DMA_API
 
-config GENERIC_BUG
-	def_bool y
-	depends on BUG
-	select GENERIC_BUG_RELATIVE_POINTERS if X86_64
-
-config GENERIC_BUG_RELATIVE_POINTERS
-	bool
-
 config GENERIC_HWEIGHT
 	def_bool y
 
diff --git a/lib/Kconfig b/lib/Kconfig
index a9e56539bd11..a827d214d866 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -615,6 +615,12 @@ config STRING_SELFTEST
 
 endmenu
 
+config GENERIC_BUG
+	bool
+
+config GENERIC_BUG_RELATIVE_POINTERS
+	bool
+
 config GENERIC_LIB_ASHLDI3
 	bool
 
-- 
2.20.1

