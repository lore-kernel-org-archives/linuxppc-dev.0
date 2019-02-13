Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C7DC282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 17:49:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9112086C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 17:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dybDH4+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9112086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4406VQ1PdyzDqSl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 04:49:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="dybDH4+q"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4406Hc70q6zDqQC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 04:40:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XMTme1/aRHBU3E1NpydVyNxz2LU2eqHpXSq4PFlUCf8=; b=dybDH4+q+XTWQP0qDHT6N+gCjB
 Kz/WwxMNo5zsLwsDehzYqWMI7NTCRNaP3alTgdZSuDitAMhZ11DPpVZ3RRJofKnk06LcV/Fcxyi5l
 n6TzH5Ccq6XEyyigy2g4z27z6eLqONgLNAMNTcEKnRu1UjGj99ZlUsUoIWwRrLu3RtKaG8nwvCqJ5
 OUMqgeqxqGkeqBykgx3MInSDP3HC3caM6+1COwU9tGsHg071Ipae3sp4qP82hbeNih5s0izX7pQGy
 oh+I63aNZ/qNC6Ayglo4/sIeNmLF/ypVqShOJMnWnMROYKH5E4h4Pal25u8QcAEaAhsragUKhy3O6
 jjBIQLVQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyWH-0008Ed-Bj; Wed, 13 Feb 2019 17:40:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 04/11] tracing: consolidate the STACKTRACE_SUPPORT symbol
Date: Wed, 13 Feb 2019 18:39:58 +0100
Message-Id: <20190213174005.28785-5-hch@lst.de>
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

Add one definition to kernel/trace/Kconfig and let the architectures
select if it supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig        | 6 ++----
 arch/arm/Kconfig        | 5 +----
 arch/arm64/Kconfig      | 4 +---
 arch/hexagon/Kconfig    | 5 +----
 arch/ia64/Kconfig       | 4 +---
 arch/microblaze/Kconfig | 4 +---
 arch/mips/Kconfig       | 5 +----
 arch/nds32/Kconfig      | 4 +---
 arch/openrisc/Kconfig   | 4 +---
 arch/parisc/Kconfig     | 4 +---
 arch/powerpc/Kconfig    | 5 +----
 arch/riscv/Kconfig      | 4 +---
 arch/s390/Kconfig       | 4 +---
 arch/sh/Kconfig         | 4 +---
 arch/sparc/Kconfig      | 5 +----
 arch/um/Kconfig         | 7 ++-----
 arch/unicore32/Kconfig  | 4 +---
 arch/x86/Kconfig        | 4 +---
 arch/xtensa/Kconfig     | 4 +---
 kernel/trace/Kconfig    | 3 +++
 20 files changed, 24 insertions(+), 65 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index c0dd229af534..e8e3776fc5fa 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -47,6 +47,8 @@ config ARC
 	select OF_RESERVED_MEM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
+	select STACKTRACE_SUPPORT
+	select STACKTRACE
 
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
@@ -81,10 +83,6 @@ config GENERIC_CALIBRATE_DELAY
 config GENERIC_HWEIGHT
 	def_bool y
 
-config STACKTRACE_SUPPORT
-	def_bool y
-	select STACKTRACE
-
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
 	depends on ARC_MMU_V4
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ed4c0560b50..68a891f3ffa0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -109,6 +109,7 @@ config ARM
 	select REFCOUNT_FULL
 	select RTC_LIB
 	select RWSEM_XCHGADD_ALGORITHM
+	select STACKTRACE_SUPPORT
 	select SYS_SUPPORTS_APM_EMULATION
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
@@ -165,10 +166,6 @@ config NO_IOPORT_MAP
 config SBUS
 	bool
 
-config STACKTRACE_SUPPORT
-	bool
-	default y
-
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2f8da4e18a1e..a6a0bb868369 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -172,6 +172,7 @@ config ARM64
 	select REFCOUNT_FULL
 	select RWSEM_XCHGADD_ALGORITHM
 	select SPARSE_IRQ
+	select STACKTRACE_SUPPORT
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
@@ -226,9 +227,6 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
 config NO_IOPORT_MAP
 	def_bool y if !PCI
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config ILLEGAL_POINTER_VALUE
 	hex
 	default 0xdead000000000000
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 49f364ea18d4..615693b62ea0 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -26,6 +26,7 @@ config HEXAGON
 	select NO_IOPORT_MAP
 	select GENERIC_IOMAP
 	select GENERIC_SMP_IDLE_THREAD
+	select STACKTRACE
 	select STACKTRACE_SUPPORT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
@@ -68,10 +69,6 @@ config GENERIC_IRQ_PROBE
 config GENERIC_HWEIGHT
 	def_bool y
 
-config STACKTRACE_SUPPORT
-	def_bool y
-	select STACKTRACE
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 99a629f05de4..8c14b669d194 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -54,6 +54,7 @@ config IA64
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select RWSEM_XCHGADD_ALGORITHM
+	select STACKTRACE_SUPPORT
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
@@ -78,9 +79,6 @@ config MMU
 	bool
 	default y
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config GENERIC_LOCKBREAK
 	def_bool n
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d459c70d9a66..ecccf8651caa 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -37,6 +37,7 @@ config MICROBLAZE
 	select OF_EARLY_FLATTREE
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_SYSCALL if PCI
+	select STACKTRACE_SUPPORT
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
@@ -75,9 +76,6 @@ config GENERIC_CALIBRATE_DELAY
 config GENERIC_CSUM
 	def_bool y
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6ad1882a8db9..0645e7b96493 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -80,6 +80,7 @@ config MIPS
 	select MODULES_USE_ELF_REL if MODULES
 	select PERF_USE_VMALLOC
 	select RTC_LIB
+	select STACKTRACE_SUPPORT
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
 
@@ -3053,10 +3054,6 @@ config LOCKDEP_SUPPORT
 	bool
 	default y
 
-config STACKTRACE_SUPPORT
-	bool
-	default y
-
 config HAVE_LATENCYTOP_SUPPORT
 	bool
 	default y
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 6a3c53d05dcd..65a506fe25a9 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -38,6 +38,7 @@ config NDS32
 	select OF_EARLY_FLATTREE
 	select NO_IOPORT_MAP
 	select RTC_LIB
+	select STACKTRACE_SUPPORT
 	select THREAD_INFO_IN_TASK
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
@@ -62,9 +63,6 @@ config GENERIC_LOCKBREAK
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
-config STACKTRACE_SUPPORT
-        def_bool y
-
 config FIX_EARLYCON_MEM
 	def_bool y
 
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9f51da5e4f57..addbe1d0dee6 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -35,6 +35,7 @@ config OPENRISC
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IRQ_MULTI_HANDLER
+	select STACKTRACE_SUPPORT
 
 config CPU_BIG_ENDIAN
 	def_bool y
@@ -56,9 +57,6 @@ config TRACE_IRQFLAGS_SUPPORT
 config GENERIC_CSUM
         def_bool y
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config LOCKDEP_SUPPORT
 	def_bool  y
 
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 8efbeeafb68e..9288ff6af559 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -53,6 +53,7 @@ config PARISC
 	select CPU_NO_EFFICIENT_FFS
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
+	select STACKTRACE_SUPPORT
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
@@ -104,9 +105,6 @@ config TIME_LOW_RES
 config PM
 	bool
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config ISA_DMA_API
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2c3ccffbb2ec..45d0d69237b1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -91,10 +91,6 @@ config PPC_WATCHDOG
 	  seleted via the generic lockup detector menu which is why we
 	  have no standalone config option for it here.
 
-config STACKTRACE_SUPPORT
-	bool
-	default y
-
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
@@ -234,6 +230,7 @@ config PPC
 	select RTC_LIB
 	select RWSEM_XCHGADD_ALGORITHM
 	select SPARSE_IRQ
+	select STACKTRACE_SUPPORT
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS			if !PPC64
 	#
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa251310c48c..f0e87594fc9b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -47,6 +47,7 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_TIMER
+	select STACKTRACE_SUPPORT
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
 
@@ -63,9 +64,6 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7f547d4d835f..fde5d60aab7e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -11,9 +11,6 @@ config CPU_BIG_ENDIAN
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config ARCH_HAS_ILOG2_U32
 	def_bool n
 
@@ -177,6 +174,7 @@ config S390
 	select PCI_MSI			if PCI
 	select RWSEM_XCHGADD_ALGORITHM
 	select SPARSE_IRQ
+	select STACKTRACE_SUPPORT
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TTY
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 4f8c7472079b..e77d3befa52a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -49,6 +49,7 @@ config SUPERH
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
 	select PCI_DOMAINS if PCI
+	select STACKTRACE_SUPPORT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
@@ -126,9 +127,6 @@ config SYS_SUPPORTS_SMP
 config SYS_SUPPORTS_NUMA
 	bool
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 60c90e59eb3c..85c4447fce00 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -91,6 +91,7 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select RWSEM_XCHGADD_ALGORITHM
+	select STACKTRACE_SUPPORT
 
 config ARCH_DEFCONFIG
 	string
@@ -107,10 +108,6 @@ config ARCH_ATU
 	bool
 	default y if SPARC64
 
-config STACKTRACE_SUPPORT
-	bool
-	default y if SPARC64
-
 config LOCKDEP_SUPPORT
 	bool
 	default y if SPARC64
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ec9711d068b7..a88ad4c0c3b4 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -17,6 +17,8 @@ config UML
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
+	select STACKTRACE
+	select STACKTRACE_SUPPORT
 	select TTY # Needed for line.c
 
 config MMU
@@ -40,11 +42,6 @@ config LOCKDEP_SUPPORT
 	bool
 	default y
 
-config STACKTRACE_SUPPORT
-	bool
-	default y
-	select STACKTRACE
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index e080087f0762..d7dccc247301 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -20,6 +20,7 @@ config UNICORE32
 	select GENERIC_IOMAP
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
+	select STACKTRACE_SUPPORT
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
@@ -32,9 +33,6 @@ config GENERIC_CSUM
 config NO_IOPORT_MAP
 	bool
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3c98f3f78631..c5f92cfd5d85 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -206,6 +206,7 @@ config X86
 	select SPARSE_IRQ
 	select SRCU
 	select SYSCTL_EXCEPTION_TRACE
+	select STACKTRACE_SUPPORT
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
@@ -228,9 +229,6 @@ config ARCH_DEFCONFIG
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config MMU
 	def_bool y
 
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index ddd3b02191a6..51cdd270a44d 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -35,6 +35,7 @@ config XTENSA
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
 	select RWSEM_XCHGADD_ALGORITHM
+	select STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
@@ -63,9 +64,6 @@ config HZ
 config LOCKDEP_SUPPORT
 	def_bool y
 
-config STACKTRACE_SUPPORT
-	def_bool y
-
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fa8b1fe824f3..80291d016e21 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -3,6 +3,9 @@
 #  select HAVE_FUNCTION_TRACER:
 #
 
+config STACKTRACE_SUPPORT
+	bool
+
 config USER_STACKTRACE_SUPPORT
 	bool
 
-- 
2.20.1

