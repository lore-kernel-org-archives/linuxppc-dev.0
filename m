Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B354DC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:05:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB54222B5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EyLuCDHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB54222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ynch0xZCzDqW3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:05:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+9b1dcb6e3a5668f89bb7+5650+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="EyLuCDHD"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ymyw1jzbzDqST
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 00:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kS81US42l2eBH55sNfQ2cxqJLL8J5zIp6tiw36gy2lk=; b=EyLuCDHDWfjzDGunyxTVNtkg+H
 ipxJCXmkBSFVn/Fu+J/jiy+YkGgfNuyRX7jJYG9D3n5Vp6ohMN4cdeuCGoCwAzGBuSacj3iqouGte
 v2LfEpqXVqggN1nCbIOrNPwUXxzSMYXbjfPCH0RCFRz9vl9ueIv29G3a5UxkbKD91lVfyx7orUsP7
 FKS7NnREErcImnr0xoHGOhXdb+vFWAvLKpyTstAHjfb3HXWvh6gaenK+JhzTjsjodL6xKNnH116O4
 OfpJmrW2ET+ND8yAhI0mzyVC/5cplIkipVQZqv38BOn7i5Sw9A7mCekh4ICVPk7jp/iTJ2WO2sQKb
 0Hu9FRTQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBkw-0000D4-Ff; Mon, 11 Feb 2019 13:36:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 07/12] dma-mapping: move CONFIG_DMA_CMA to kernel/dma/Kconfig
Date: Mon, 11 Feb 2019 14:35:49 +0100
Message-Id: <20190211133554.30055-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is where all the related code already lives.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/Kconfig | 77 --------------------------------------------
 kernel/dma/Kconfig   | 77 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 3e63a900b330..059700ea3521 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -191,83 +191,6 @@ config DMA_FENCE_TRACE
 	  lockup related problems for dma-buffers shared across multiple
 	  devices.
 
-config DMA_CMA
-	bool "DMA Contiguous Memory Allocator"
-	depends on HAVE_DMA_CONTIGUOUS && CMA
-	help
-	  This enables the Contiguous Memory Allocator which allows drivers
-	  to allocate big physically-contiguous blocks of memory for use with
-	  hardware components that do not support I/O map nor scatter-gather.
-
-	  You can disable CMA by specifying "cma=0" on the kernel's command
-	  line.
-
-	  For more information see <include/linux/dma-contiguous.h>.
-	  If unsure, say "n".
-
-if  DMA_CMA
-comment "Default contiguous memory area size:"
-
-config CMA_SIZE_MBYTES
-	int "Size in Mega Bytes"
-	depends on !CMA_SIZE_SEL_PERCENTAGE
-	default 0 if X86
-	default 16
-	help
-	  Defines the size (in MiB) of the default memory area for Contiguous
-	  Memory Allocator.  If the size of 0 is selected, CMA is disabled by
-	  default, but it can be enabled by passing cma=size[MG] to the kernel.
-
-
-config CMA_SIZE_PERCENTAGE
-	int "Percentage of total memory"
-	depends on !CMA_SIZE_SEL_MBYTES
-	default 0 if X86
-	default 10
-	help
-	  Defines the size of the default memory area for Contiguous Memory
-	  Allocator as a percentage of the total memory in the system.
-	  If 0 percent is selected, CMA is disabled by default, but it can be
-	  enabled by passing cma=size[MG] to the kernel.
-
-choice
-	prompt "Selected region size"
-	default CMA_SIZE_SEL_MBYTES
-
-config CMA_SIZE_SEL_MBYTES
-	bool "Use mega bytes value only"
-
-config CMA_SIZE_SEL_PERCENTAGE
-	bool "Use percentage value only"
-
-config CMA_SIZE_SEL_MIN
-	bool "Use lower value (minimum)"
-
-config CMA_SIZE_SEL_MAX
-	bool "Use higher value (maximum)"
-
-endchoice
-
-config CMA_ALIGNMENT
-	int "Maximum PAGE_SIZE order of alignment for contiguous buffers"
-	range 4 12
-	default 8
-	help
-	  DMA mapping framework by default aligns all buffers to the smallest
-	  PAGE_SIZE order which is greater than or equal to the requested buffer
-	  size. This works well for buffers up to a few hundreds kilobytes, but
-	  for larger buffers it just a memory waste. With this parameter you can
-	  specify the maximum PAGE_SIZE order for contiguous buffers. Larger
-	  buffers will be aligned only to this specified order. The order is
-	  expressed as a power of two multiplied by the PAGE_SIZE.
-
-	  For example, if your system defaults to 4KiB pages, the order value
-	  of 8 means that the buffers will be aligned up to 1MiB only.
-
-	  If unsure, leave the default value "8".
-
-endif
-
 config GENERIC_ARCH_TOPOLOGY
 	bool
 	help
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index b122ab100d66..d785286ad868 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -53,3 +53,80 @@ config DMA_REMAP
 config DMA_DIRECT_REMAP
 	bool
 	select DMA_REMAP
+
+config DMA_CMA
+	bool "DMA Contiguous Memory Allocator"
+	depends on HAVE_DMA_CONTIGUOUS && CMA
+	help
+	  This enables the Contiguous Memory Allocator which allows drivers
+	  to allocate big physically-contiguous blocks of memory for use with
+	  hardware components that do not support I/O map nor scatter-gather.
+
+	  You can disable CMA by specifying "cma=0" on the kernel's command
+	  line.
+
+	  For more information see <include/linux/dma-contiguous.h>.
+	  If unsure, say "n".
+
+if  DMA_CMA
+comment "Default contiguous memory area size:"
+
+config CMA_SIZE_MBYTES
+	int "Size in Mega Bytes"
+	depends on !CMA_SIZE_SEL_PERCENTAGE
+	default 0 if X86
+	default 16
+	help
+	  Defines the size (in MiB) of the default memory area for Contiguous
+	  Memory Allocator.  If the size of 0 is selected, CMA is disabled by
+	  default, but it can be enabled by passing cma=size[MG] to the kernel.
+
+
+config CMA_SIZE_PERCENTAGE
+	int "Percentage of total memory"
+	depends on !CMA_SIZE_SEL_MBYTES
+	default 0 if X86
+	default 10
+	help
+	  Defines the size of the default memory area for Contiguous Memory
+	  Allocator as a percentage of the total memory in the system.
+	  If 0 percent is selected, CMA is disabled by default, but it can be
+	  enabled by passing cma=size[MG] to the kernel.
+
+choice
+	prompt "Selected region size"
+	default CMA_SIZE_SEL_MBYTES
+
+config CMA_SIZE_SEL_MBYTES
+	bool "Use mega bytes value only"
+
+config CMA_SIZE_SEL_PERCENTAGE
+	bool "Use percentage value only"
+
+config CMA_SIZE_SEL_MIN
+	bool "Use lower value (minimum)"
+
+config CMA_SIZE_SEL_MAX
+	bool "Use higher value (maximum)"
+
+endchoice
+
+config CMA_ALIGNMENT
+	int "Maximum PAGE_SIZE order of alignment for contiguous buffers"
+	range 4 12
+	default 8
+	help
+	  DMA mapping framework by default aligns all buffers to the smallest
+	  PAGE_SIZE order which is greater than or equal to the requested buffer
+	  size. This works well for buffers up to a few hundreds kilobytes, but
+	  for larger buffers it just a memory waste. With this parameter you can
+	  specify the maximum PAGE_SIZE order for contiguous buffers. Larger
+	  buffers will be aligned only to this specified order. The order is
+	  expressed as a power of two multiplied by the PAGE_SIZE.
+
+	  For example, if your system defaults to 4KiB pages, the order value
+	  of 8 means that the buffers will be aligned up to 1MiB only.
+
+	  If unsure, leave the default value "8".
+
+endif
-- 
2.20.1

