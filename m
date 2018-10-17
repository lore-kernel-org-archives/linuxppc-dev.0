Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5277BECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:12:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24FA2151D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VARKN0M3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24FA2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZlK000DJzDqmf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:12:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="VARKN0M3";
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
 header.b="VARKN0M3"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zl5h6X6LzF3Xm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 19:02:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=39zMTQSbdGWCkYgM3TcO8gzxnidTjjeKxyyL/cCZp3o=; b=VARKN0M3MglF5W7gl3dQL77t9h
 TasVq4gbZIw1lJ6GKxCxv92H7kJaJZ5AZRv87v2+Y9ZgUXkPUTeX+mAV6Vm7CSin1DUWH/epVWRr4
 P/HkF2XfUA6gxoOxNpVhWV4NJ0WIW8YYKk9AXOegbM6hJWH3h3S1xVmFcwEMJTx/cP+i5uHrdpYE6
 e27e0DoqV2S/HBQN/YHHvwuov7KqxQ8Ti+rkagZhFntaFQb/dTXeyWvKa0h4Y7wswbV8AkgYA3ZIR
 hsxF6ziLZCLOwsJPgu9xbxXPPewKlRN/JFeIfD+A/8KPyXbccb7isAh9om98V7Xki/nanp0RVmm8h
 wRpzlL3w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCgmZ-0003KP-I0; Wed, 17 Oct 2018 08:02:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 5/8] pcmcia: allow PCMCIA support independent of the
 architecture
Date: Wed, 17 Oct 2018 10:01:58 +0200
Message-Id: <20181017080201.10866-6-hch@lst.de>
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

There is nothing architecture specific in the PCMCIA core, so allow
building it everywhere.  The actual host controllers will depend on ISA,
PCI or a specific SOC.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/alpha/Kconfig     | 2 --
 arch/arm/Kconfig       | 2 --
 arch/ia64/Kconfig      | 2 --
 arch/m68k/Kconfig.bus  | 2 --
 arch/mips/Kconfig      | 2 --
 arch/powerpc/Kconfig   | 2 --
 arch/sh/Kconfig        | 2 --
 arch/sparc/Kconfig     | 2 --
 arch/unicore32/Kconfig | 6 ------
 arch/x86/Kconfig       | 2 --
 arch/xtensa/Kconfig    | 2 --
 drivers/Kconfig        | 1 +
 drivers/parisc/Kconfig | 2 --
 drivers/pcmcia/Kconfig | 1 +
 14 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index bb89924c0361..96f02268ea16 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -675,8 +675,6 @@ config HZ
 
 source "drivers/eisa/Kconfig"
 
-source "drivers/pcmcia/Kconfig"
-
 config SRM_ENV
 	tristate "SRM environment through procfs"
 	depends on PROC_FS
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 516105df6c71..60e37b9a715d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1256,8 +1256,6 @@ config PCI_HOST_ITE8152
 	default y
 	select DMABOUNCE
 
-source "drivers/pcmcia/Kconfig"
-
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 89da763d7c17..704ff5922ce0 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -553,8 +553,6 @@ config PCI_DOMAINS
 config PCI_SYSCALL
 	def_bool PCI
 
-source "drivers/pcmcia/Kconfig"
-
 endmenu
 
 endif
diff --git a/arch/m68k/Kconfig.bus b/arch/m68k/Kconfig.bus
index 8cb0604b195b..9d0a3a23d50e 100644
--- a/arch/m68k/Kconfig.bus
+++ b/arch/m68k/Kconfig.bus
@@ -68,6 +68,4 @@ if !MMU
 config ISA_DMA_API
         def_bool !M5272
 
-source "drivers/pcmcia/Kconfig"
-
 endif
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 09b93d5a55cb..18eeb66c6d99 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3090,8 +3090,6 @@ config ZONE_DMA
 config ZONE_DMA32
 	bool
 
-source "drivers/pcmcia/Kconfig"
-
 config HAS_RAPIDIO
 	bool
 	default n
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8f5a49d11385..6430aafe712f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -963,8 +963,6 @@ config PCI_8260
 	select PPC_INDIRECT_PCI
 	default y
 
-source "drivers/pcmcia/Kconfig"
-
 config HAS_RAPIDIO
 	bool
 	default n
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2ff6855811a5..ce9487139155 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -861,8 +861,6 @@ config MAPLE
 config PCI_DOMAINS
 	bool
 
-source "drivers/pcmcia/Kconfig"
-
 endmenu
 
 menu "Power management options (EXPERIMENTAL)"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index fc311b8dc46b..0198f96528fc 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -509,8 +509,6 @@ config SPARC_GRPCI2
 	help
 	  Say Y here to include the GRPCI2 Host Bridge Driver.
 
-source "drivers/pcmcia/Kconfig"
-
 config SUN_OPENPROMFS
 	tristate "Openprom tree appears in /proc/openprom"
 	help
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 601dcad2560e..d7750e7c7ccb 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -118,12 +118,6 @@ config UNICORE_FPU_F64
 
 endmenu
 
-menu "Bus support"
-
-source "drivers/pcmcia/Kconfig"
-
-endmenu
-
 menu "Kernel Features"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5816e20a3ff9..fda01408b596 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2810,8 +2810,6 @@ config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
-source "drivers/pcmcia/Kconfig"
-
 config RAPIDIO
 	tristate "RapidIO support"
 	depends on PCI
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f057c16a48a5..c18ceaab7860 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -517,8 +517,6 @@ config FORCE_MAX_ZONEORDER
 	  This config option is actually maximum order plus one. For example,
 	  a value of 11 means that the largest free memory block is 2^10 pages.
 
-source "drivers/pcmcia/Kconfig"
-
 config PLATFORM_WANT_DEFAULT_MEM
 	def_bool n
 
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 059573823387..58ee88c36cf5 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -5,6 +5,7 @@ menu "Device Drivers"
 
 source "drivers/amba/Kconfig"
 source "drivers/pci/Kconfig"
+source "drivers/pcmcia/Kconfig"
 
 
 source "drivers/base/Kconfig"
diff --git a/drivers/parisc/Kconfig b/drivers/parisc/Kconfig
index 5bbfea1a019c..1a55763d1245 100644
--- a/drivers/parisc/Kconfig
+++ b/drivers/parisc/Kconfig
@@ -92,8 +92,6 @@ config IOMMU_SBA
 	depends on PCI_LBA
 	default PCI_LBA
 
-source "drivers/pcmcia/Kconfig"
-
 endmenu
 
 menu "PA-RISC specific drivers"
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index cbbe4a285b48..c9bdbb463a7e 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig PCCARD
 	tristate "PCCard (PCMCIA/CardBus) support"
+	depends on !UML
 	---help---
 	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
 	  computer.  These are credit-card size devices such as network cards,
-- 
2.19.1

