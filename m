Return-Path: <linuxppc-dev+bounces-22809-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A3FCD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:54:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWb12v27z2xF8;
	Fri, 19 Jun 2026 18:53:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859197;
	cv=none; b=RDkgdIaq/LMhCnXSmI+gDsZdASMPJB7m2YM0zLgVGRvWWqj5SPvVLRyO7FACkgyclJTzoBFMQn0o9Yu4znDR+t3Anl4HOMTLevjFSKa6c+fM6o59RV+zRLjLeLoTToC1ZSgLXi9oOGnlcRDbEcFWfJMiumIHkdy0GmnCEOAATM1CCFD/q3ENkgEDGXcSoQHhfOhIlJTdm3nIjmRU+vJVdwJY8+vBLi1lNKzyu1zI6T5XapVpT9W62XgBeW/yZEUUHdtCNVDAmcaOiE6CVVtPvPwDy+CYMo7IXZiD+M/iTq+i8N3HmJAQEK6Lb23nNYh8mVy31KJZHlunU4/WWkwxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859197; c=relaxed/relaxed;
	bh=sskwaIOGPPfHiPAa1LaAJ6GSlFNS8/PzCMP/8IQx/ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoI8c6PsRmLJGmW7SYUVkCgSdyRlMt2d8Im1sg3fgYYAe8w6tgGWLdkI8YlD+QuE4yrWceoQs/Vupu6vQjeJkyHCoDNfj4bom23wgd0Cb9hgv389ckVNjpdTbL0Nt4myaQazY6bldOi8ikWD0WWCWk4kS8sV6WzhasS5LBAXWuOwx+qPyMk1ylUBaWbaIdW0OS76L99JZGseCrujxKgXwuVCQzLh4q9ybM8b92IbjXscoozE8Y0Kvh6sSNZfXLMUYMzaPkzK64pr1ZtU/XYwjtXPWXUFsGz28PLPvYrBtHniuoFficZ4+25zhDXxzQk9gglrS33yTdcnJpirB4DdpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR9gEhQz; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR9gEhQz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWb01mm6z3cQx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:53:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30C5943FBF;
	Fri, 19 Jun 2026 08:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2551F000E9;
	Fri, 19 Jun 2026 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859194;
	bh=sskwaIOGPPfHiPAa1LaAJ6GSlFNS8/PzCMP/8IQx/ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nR9gEhQzp2n4Yl8O4T7jOS4nEYX9Ls/GLG1h/NNfPGQ3Wb/nIoPOmFEhE7BO+u4GQ
	 VHTAVC+AISgQC5lf7CrjHy12rLtHLBBKl3xkkHPwWiAkhjNwNgt9MkJ1i4GhpDJkSg
	 fr9cRJ3IdR5WNJXJ2oHfNXlbeDggRMCvlDgidbJKNg657WDFHOLk2VnllTRRiRuyqM
	 Q7Tcd5Sz1kkwRLZAdgcSS4MGvhmDwPQy8XHeswRSK7SOeqeFBHUDeIhq+zzFDI0WKD
	 GCrlkoY/KEasAL3Qpt6zTN0Df+PLFBrPLvZzPbC9/9vrRQ1myMKVyYNmy0srSmHV1n
	 TULMO9rJNXnkA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 19/25] PCI: Add macros for legacy I/O and memory address space sizes
Date: Fri, 19 Jun 2026 08:51:54 +0000
Message-ID: <20260619085200.3729431-20-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
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
Content-Transfer-Encoding: 8bit

Add defines for the standard PCI legacy address space sizes,
replacing the raw literals used by the legacy sysfs attributes.

Then, replace open-coded values with the newly added macros.

No functional changes intended.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 include/linux/pci.h     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9d1378700c3a..b8986a735a46 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1019,7 +1019,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 
 	sysfs_bin_attr_init(b->legacy_io);
 	b->legacy_io->attr.name = "legacy_io";
-	b->legacy_io->size = 0xffff;
+	b->legacy_io->size = PCI_LEGACY_IO_SIZE;
 	b->legacy_io->attr.mode = 0600;
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
@@ -1036,7 +1036,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem = b->legacy_io + 1;
 	sysfs_bin_attr_init(b->legacy_mem);
 	b->legacy_mem->attr.name = "legacy_mem";
-	b->legacy_mem->size = 1024*1024;
+	b->legacy_mem->size = PCI_LEGACY_MEM_SIZE;
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
 	/* See pci_create_attr() for motivation */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c56f2cf0d2ab..e37677a8dd3c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -27,6 +27,7 @@
 #include <linux/mod_devicetable.h>
 
 #include <linux/types.h>
+#include <linux/sizes.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
@@ -1169,6 +1170,10 @@ enum {
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
+/* PCI legacy I/O port and memory address space sizes. */
+#define PCI_LEGACY_IO_SIZE	(SZ_64K - 1)
+#define PCI_LEGACY_MEM_SIZE	SZ_1M
+
 extern unsigned int pci_flags;
 
 static inline void pci_set_flags(int flags) { pci_flags = flags; }
-- 
2.54.0


