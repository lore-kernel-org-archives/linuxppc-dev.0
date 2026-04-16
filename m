Return-Path: <linuxppc-dev+bounces-19797-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCB0F8D761
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:02:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQnD4TCZz2yvc;
	Fri, 17 Apr 2026 04:01:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362496;
	cv=none; b=dzmD0Hrw4XNiZR/VysAhiMwOFv/NnHYu7PMwmlqveBiHI864Kte7IDiArgH1IQrRSiRAJJTUGJXGLGNdLVtf7aIjn4+WSzHXExleVHH1JjxzDKXzpU1sP6A2AsHArPLLcUcbsU71Do0VmNIbKRJ/WiWEWoABbf5QCSkkh7/KeXenCdZ9kTgE0fK7pQ00YaDJBbp3uyEUzguF1IzhZ/WO68wdVjxY1tEKB94r7NbQ77kcXAHHv142kMT4/o94CbJx9QasG68kIl6VJLhqs35QGmQ/TZOQDoZYOkQ8OU8lTsNZNsScYXDt3ot2cTWS12NIqhN+25R4164BITaV6WlK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362496; c=relaxed/relaxed;
	bh=DsND2OegQlKeJ6ma9zHjpPjgbzOUuLnfEPE32ZjS1+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuZkY5QHPe3ZB83zOnPpE7MT2+NgOt9dxORTDKft2xEdxa792/0zd6i7rOeaiI67Mv92FQpU0vkpIlQe9ICHkWK93NcDcdg7WQYWIYA443LQqVx+gklHumhUsPrLhWmHDkzV64o651iksEgRuPjvIjh6fi66GdBBBT4goZF9442F4r8pUWfdzS/NAzMm06b3YYd53xf2tLX7RvgFUfdOv97NOOkAaBOWpVaUVm34mQCiAVmRw2oG8VUlC4dQtVZKC3bAICu3ItK460aiIIA6WSZy5/52XgCanL12iho6wbbcXNNa7sY2zpue8v5P9CqpLc5CIVTxljUYOJGRPmPgCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XT2hpkIq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XT2hpkIq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQnC4l6yz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:01:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B3F960130;
	Thu, 16 Apr 2026 18:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B3DC2BCB0;
	Thu, 16 Apr 2026 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362493;
	bh=LAO3kiSYc9DUEJ5+NT4mnNGV1/nvxvflH6EBLBheCNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XT2hpkIqS7+I0iSX2m1IEx7D99X3EghsArq5x8w6+r0rBJQZXZMS3ZPBpQo0e+2uh
	 M8/SgQq8+W/H/S5wBhFSZd2Axy23LpMEl9BEN8rZvnrMpId/fFPlcoXxiMQ3SZVYEN
	 q8LepWzUWgyUpfYGJNxcAM9RHQGDMLlI1WVYJKkBuQwLd2uXUiLDCvrSKOPfREOV2o
	 UEbFvuzZIP1NYdfZ+s79NqGZOWaUiYHCEpa5gsXXlVD+cBrntqokywI3hqH2bNVfBs
	 w1UxK6riKY6gx/2rOEs/ayUGBlWUceJtofBb4mICBa7KOftIfW4nf+hCagQp+BeRmu
	 6G8RE4C+ct11g==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v5 06/23] PCI/sysfs: Add static PCI resource attribute macros
Date: Thu, 16 Apr 2026 18:00:50 +0000
Message-ID: <20260416180107.777065-7-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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

Add three macros for declaring static binary attributes for PCI
resource files:

  - pci_dev_resource_io_attr(), for I/O BAR resources (read/write)
  - pci_dev_resource_uc_attr(), for memory BAR resources (mmap uncached)
  - pci_dev_resource_wc_attr(), for write-combine resources (mmap WC)

Each macro only sets the callbacks its resource type needs.  The I/O
macro conditionally includes mmap support via __PCI_RESOURCE_IO_MMAP_ATTRS
on architectures where arch_can_pci_mmap_io() is true at compile time
(such as PowerPC, SPARC, and Xtensa).

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 4f95b336cc34..e7ca83aec3e8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1220,6 +1220,47 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
 	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
 }
 
+/*
+ * generic_file_llseek() consults f_mapping->host to determine
+ * the file size. As iomem_inode knows nothing about the
+ * attribute, it's not going to work, so override it as well.
+ */
+#if arch_can_pci_mmap_io()
+# define __PCI_RESOURCE_IO_MMAP_ATTRS		\
+	.f_mapping = iomem_get_mapping,		\
+	.llseek = pci_llseek_resource,		\
+	.mmap = pci_mmap_resource_uc,
+#else
+# define __PCI_RESOURCE_IO_MMAP_ATTRS
+#endif
+
+#define pci_dev_resource_io_attr(_bar)					\
+static const struct bin_attribute dev_resource##_bar##_io_attr = {	\
+	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),			\
+	.read = pci_read_resource_io,					\
+	.write = pci_write_resource_io,					\
+	__PCI_RESOURCE_IO_MMAP_ATTRS					\
+}
+
+#define pci_dev_resource_uc_attr(_bar)					\
+static const struct bin_attribute dev_resource##_bar##_uc_attr = {	\
+	.attr = { .name = "resource" __stringify(_bar), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),			\
+	.f_mapping = iomem_get_mapping,					\
+	.llseek = pci_llseek_resource,					\
+	.mmap = pci_mmap_resource_uc,					\
+}
+
+#define pci_dev_resource_wc_attr(_bar)						\
+static const struct bin_attribute dev_resource##_bar##_wc_attr = {		\
+	.attr = { .name = "resource" __stringify(_bar) "_wc", .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),				\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource,						\
+	.mmap = pci_mmap_resource_wc,						\
+}
+
 /**
  * pci_remove_resource_files - cleanup resource files
  * @pdev: dev to cleanup
-- 
2.53.0


