Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8F5C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 15:23:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DEC20877
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 15:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dl682IBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DEC20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XT4B018DzDrNT
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 02:23:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="Dl682IBc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+5d6e0690757439347628+5529+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Dl682IBc"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XSnf02NXzF3Dj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 02:10:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QPBMP2AY+9bgnbpVmkgJo646v0aeLX7ryil5y2diJ6g=; b=Dl682IBcN/vV0+FP4QMeJjJaLD
 NlRTkfBUhRbH/mPVGxQbIPNZZZ42jtUSzLpfzqRNMTVJKARyoUaRSBAwDdHf/8wVaVjYcl2mbhjXJ
 BES5G0WBlExBeutOIi+y8DRKIYy6CtxLSTDIvhWrg7apIC7XXmgJZq1E9KyGD+JnNIFvMHJBHv4M6
 OzHvV5cbP7yPFixa+l4bXSEg0fu1/DrxrtKBCAiEfAQfThfQi9+Ue7dV4IHrKI/AycO3ghn6PpPGX
 nhKqeSy8a7+ytVaWPVH12sFGtWCUhoVkYonGC6kAWd8r72SNyMN6sOIU8I6bql4RmSW2lmalK6dL5
 1nADuoZg==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gBLYs-0002xw-3M; Sat, 13 Oct 2018 15:10:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in drivers/eisa
Date: Sat, 13 Oct 2018 17:10:15 +0200
Message-Id: <20181013151016.31674-8-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181013151016.31674-1-hch@lst.de>
References: <20181013151016.31674-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Alexandre Bounine <alex.bou9@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Let architectures opt into EISA support by selecting HAS_EISA and
handle everything else in drivers/eisa.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig     |  8 +++-----
 arch/arm/Kconfig       | 16 +---------------
 arch/mips/Kconfig      | 31 +++++--------------------------
 arch/powerpc/Kconfig   |  3 ---
 arch/x86/Kconfig       | 19 +------------------
 drivers/eisa/Kconfig   | 21 ++++++++++++++++++++-
 drivers/parisc/Kconfig | 11 +----------
 7 files changed, 31 insertions(+), 78 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 73a7558c71bd..6a9be9cb74e6 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -6,6 +6,9 @@ config ALPHA
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_NO_PREEMPT
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select HAS_EISA if ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || \
+				ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || \
+				ALPHA_NORITAKE || ALPHA_RAWHIDE
 	select HAS_PCI if !ALPHA_JENSEN
 	select PCI if !ALPHA_JENSEN
 	select HAVE_AOUT
@@ -518,11 +521,6 @@ config ALPHA_SRM
 
 	  If unsure, say N.
 
-config EISA
-	bool
-	depends on ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_RAWHIDE
-	default y
-
 config ARCH_MAY_HAVE_PC_FDC
 	def_bool y
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0339c074147f..1903f73d42e7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -49,6 +49,7 @@ config ARM
 	select GENERIC_STRNLEN_USER
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
+	select HAS_EISA
 	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
@@ -162,21 +163,6 @@ config HAVE_PROC_CPU
 config NO_IOPORT_MAP
 	bool
 
-config EISA
-	bool
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
 config SBUS
 	bool
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 70a9e09329bb..b3e6b2adf510 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -23,6 +23,7 @@ config MIPS
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_ISA_DMA if EISA
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_CMPDI2
@@ -72,6 +73,7 @@ config MIPS
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
+	select ISA if EISA
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select MODULES_USE_ELF_REL if MODULES
 	select PCI_DOMAINS if PCI
@@ -634,7 +636,7 @@ config SGI_IP22
 	select CSRC_R4K
 	select DEFAULT_SGI_PARTITION
 	select DMA_NONCOHERENT
-	select HW_HAS_EISA
+	select HAS_EISA
 	select I8253
 	select I8259
 	select IP22_CPU_SCACHE
@@ -699,7 +701,7 @@ config SGI_IP28
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select IRQ_MIPS_CPU
-	select HW_HAS_EISA
+	select HAS_EISA
 	select I8253
 	select I8259
 	select SGI_HAS_I8042
@@ -843,7 +845,7 @@ config SNI_RM
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
-	select HW_HAS_EISA
+	select HAS_EISA
 	select HAS_PCI
 	select IRQ_MIPS_CPU
 	select I8253
@@ -2991,9 +2993,6 @@ config MIPS_AUTO_PFN_OFFSET
 
 menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"
 
-config HW_HAS_EISA
-	bool
-
 config HT_PCI
 	bool "Support for HT-linked PCI"
 	default y
@@ -3027,26 +3026,6 @@ config PCI_DRIVERS_LEGACY
 config ISA
 	bool
 
-config EISA
-	bool "EISA support"
-	depends on HW_HAS_EISA
-	select ISA
-	select GENERIC_ISA_DMA
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
-source "drivers/eisa/Kconfig"
-
 config TC
 	bool "TURBOchannel support"
 	depends on MACH_DECSTATION
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b1c3a47f1f30..f0ea460653cd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -900,9 +900,6 @@ config PPC_INDIRECT_PCI
 	default y if 40x || 44x
 	default n
 
-config EISA
-	bool
-
 config SBUS
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f731ad1a043a..6a4fb550a206 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -113,6 +113,7 @@ config X86
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
+	select HAS_EISA
 	select HAS_PCI
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
@@ -2680,24 +2681,6 @@ config ISA
 	  (MCA) or VESA.  ISA is an older system, now being displaced by PCI;
 	  newer boards don't support it.  If you have ISA, say Y, otherwise N.
 
-config EISA
-	bool "EISA support"
-	depends on ISA
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
-source "drivers/eisa/Kconfig"
-
 config SCx200
 	tristate "NatSemi SCx200 support"
 	---help---
diff --git a/drivers/eisa/Kconfig b/drivers/eisa/Kconfig
index 2705284f6223..bd35daffee3b 100644
--- a/drivers/eisa/Kconfig
+++ b/drivers/eisa/Kconfig
@@ -1,6 +1,26 @@
 #
 # EISA configuration
 #
+
+config HAS_EISA
+	bool
+
+menuconfig EISA
+	bool "EISA support"
+	depends on HAS_EISA
+	---help---
+	  The Extended Industry Standard Architecture (EISA) bus was
+	  developed as an open alternative to the IBM MicroChannel bus.
+
+	  The EISA bus provided some of the features of the IBM MicroChannel
+	  bus while maintaining backward compatibility with cards made for
+	  the older ISA bus.  The EISA bus saw limited use between 1988 and
+	  1995 when it was made obsolete by the PCI bus.
+
+	  Say Y here if you are building a kernel for an EISA-based machine.
+
+	  Otherwise, say N.
+
 config EISA_VLB_PRIMING
 	bool "Vesa Local Bus priming"
 	depends on X86 && EISA
@@ -53,4 +73,3 @@ config EISA_NAMES
 	  names.
 
 	  When in doubt, say Y.
-
diff --git a/drivers/parisc/Kconfig b/drivers/parisc/Kconfig
index 1a55763d1245..09c5e59f5374 100644
--- a/drivers/parisc/Kconfig
+++ b/drivers/parisc/Kconfig
@@ -2,6 +2,7 @@ menu "Bus options (PCI, PCMCIA, EISA, GSC, ISA)"
 
 config GSC
 	bool "VSC/GSC/HSC bus support"
+	select HAS_EISA
 	default y
 	help
 	  The VSC, GSC and HSC busses were used from the earliest 700-series
@@ -46,16 +47,6 @@ config GSC_WAX
 	  used), a HIL interface chip and is also known to be used as the
 	  GSC bridge for an X.25 GSC card.
 
-config EISA
-	bool "EISA support"
-	depends on GSC
-	help
-	  Say Y here if you have an EISA bus in your machine.  This code
-	  supports both the Mongoose & Wax EISA adapters.  It is sadly
-	  incomplete and lacks support for card-to-host DMA.
-
-source "drivers/eisa/Kconfig"
-
 config ISA
 	bool "ISA support"
 	depends on EISA
-- 
2.19.1

