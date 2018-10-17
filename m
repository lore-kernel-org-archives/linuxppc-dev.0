Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD8ECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:09:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BE52151D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XC+yJkMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BE52151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZlGD2b51zF3ZB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:09:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="XC+yJkMV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+09575c8a9ff34f5a189b+5533+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="XC+yJkMV"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zl5k34kczDqrV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 19:02:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6FiYZLx2dhBUIFR4U9vdQSA35mb+o5EHEVIbdh15d8A=; b=XC+yJkMVQLfyWfkERm2qKqCOo+
 prmIxPSZ4p/7CUMaqLUHEHMo1gQWoEUSlAPS294OO8fluHAWRhQPNKz3VkDmn5aZxsinGIw2WkN1s
 g+jJyf4yrX5dyS2lheWi0arOq5xHsxK9nM+2x31g4v62M3UBuC16RKhW7ljVuZjp9U3H2D3Tgx+jW
 7rolOSp+60MRqEdD/lKB53qKoRRy60lYunkEwQGVwNnKLUJe6lP6SNGgSW+bz+q8HEmwM/pvBnVL/
 LZe2Oa6S1JRrqAmvAto82pnJ7nq2V157msKsUgE5UAeHfsZf05k1XU/dF3NmSyUuL3vlPVmwQOD5A
 ll0+Io8g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCgmc-0003LS-Az; Wed, 17 Oct 2018 08:02:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 6/8] rapidio: consolidate RAPIDIO config entry in
 drivers/rapidio
Date: Wed, 17 Oct 2018 10:01:59 +0200
Message-Id: <20181017080201.10866-7-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017080201.10866-1-hch@lst.de>
References: <20181017080201.10866-1-hch@lst.de>
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

There is no good reason to duplicate the RAPIDIO menu in various
architectures.  Instead provide a selectable HAS_RAPIDIO symbol
that indicates native availability of RAPIDIO support and the handle
the rest in drivers/pci.  This also means we now provide support
for PCI(e) to Rapidio bridges for every architecture instead of a
limited subset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig                   | 15 +--------------
 arch/powerpc/Kconfig                | 15 +--------------
 arch/powerpc/platforms/85xx/Kconfig |  8 ++++----
 arch/powerpc/platforms/86xx/Kconfig |  4 ++--
 arch/x86/Kconfig                    | 10 ----------
 drivers/Kconfig                     |  1 +
 drivers/rapidio/Kconfig             | 11 +++++++++++
 7 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 18eeb66c6d99..96198f8375e1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -894,7 +894,7 @@ config CAVIUM_OCTEON_SOC
 	bool "Cavium Networks Octeon SoC based boards"
 	select CEVT_R4K
 	select ARCH_HAS_PHYS_TO_DMA
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select PHYS_ADDR_T_64BIT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -3090,19 +3090,6 @@ config ZONE_DMA
 config ZONE_DMA32
 	bool
 
-config HAS_RAPIDIO
-	bool
-	default n
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
-
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config TRAD_SIGNALS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6430aafe712f..ee28bb22732b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -963,27 +963,14 @@ config PCI_8260
 	select PPC_INDIRECT_PCI
 	default y
 
-config HAS_RAPIDIO
-	bool
-	default n
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
-
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
-	depends on RAPIDIO = y && HAS_RAPIDIO
+	depends on RAPIDIO = y && HAVE_RAPIDIO
 	default "n"
 	---help---
 	  Include support for RapidIO controller on Freescale embedded
 	  processors (MPC8548, MPC8641, etc).
 
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config NONSTATIC_KERNEL
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 20867a23f3f2..1c6bb9180d70 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -65,7 +65,7 @@ config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
 	select PPC_I8259
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	help
 	  This option enables support for the MPC85xx CDS board
 
@@ -73,7 +73,7 @@ config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
 	select DEFAULT_UIMAGE
 	select PHYLIB if NETDEVICES
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select SWIOTLB
 	help
 	  This option enables support for the MPC85xx MDS board
@@ -218,7 +218,7 @@ config PPA8548
 	help
 	  This option enables support for the Prodrive PPA8548 board.
 	select DEFAULT_UIMAGE
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 
 config GE_IMP3A
 	bool "GE Intelligent Platforms IMP3A"
@@ -276,7 +276,7 @@ config CORENET_GENERIC
 	select SWIOTLB
 	select GPIOLIB
 	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
 	  This option enables support for the FSL CoreNet based boards.
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 87220554dd6f..badd9d6ba1ef 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -15,7 +15,7 @@ config MPC8641_HPCN
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575 if PCI
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select SWIOTLB
 	help
 	  This option enables support for the MPC8641 HPCN board.
@@ -57,7 +57,7 @@ config GEF_SBC610
 	select MMIO_NVRAM
 	select GPIOLIB
 	select GE_FPGA
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	help
 	  This option enables support for the GE SBC610.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fda01408b596..6fe3740018f6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2810,16 +2810,6 @@ config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on PCI
-	default n
-	help
-	  If enabled this option will include drivers and the core
-	  infrastructure code to support RapidIO interconnect devices.
-
-source "drivers/rapidio/Kconfig"
-
 config X86_SYSFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
 	help
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 58ee88c36cf5..065d308fcb00 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -6,6 +6,7 @@ menu "Device Drivers"
 source "drivers/amba/Kconfig"
 source "drivers/pci/Kconfig"
 source "drivers/pcmcia/Kconfig"
+source "drivers/rapidio/Kconfig"
 
 
 source "drivers/base/Kconfig"
diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index d6d2f20c4597..e3d8fe41b50c 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -1,6 +1,17 @@
 #
 # RapidIO configuration
 #
+
+config HAVE_RAPIDIO
+	bool
+
+menuconfig RAPIDIO
+	tristate "RapidIO support"
+	depends on HAVE_RAPIDIO || PCI
+	help
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
 source "drivers/rapidio/devices/Kconfig"
 
 config RAPIDIO_DISC_TIMEOUT
-- 
2.19.1

