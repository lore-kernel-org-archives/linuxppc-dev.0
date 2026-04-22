Return-Path: <linuxppc-dev+bounces-19972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9D8FA1FD1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:17:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g148H3l90z2yvZ;
	Thu, 23 Apr 2026 02:15:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874543;
	cv=none; b=ZtdxJDH8t07A+2EXw9/wThcFfiJ5HyzzBMC8ImqkEK+0VXbXrxCNMIAkSmihupZgaHX9hvT6Fqs0hWenr+KqOBZxNFehTfPOWH/kWowrhNIExgerAV5OPPE2tgQBDwWbpzSGT6y8p0iYc/n5k3KDvlsA1QBWOj3mL8Scge6SbA5cN/GOK06XOnUb33l/KqBRgtG2WGLLzRl3v171bcTbVc403CY2n7SKPUuktXZ19jJfE7P1veRflZwfYlSCpDGkN1ExD5j1DBN/kiKZCa1Fh4akSi3g/sjFYpxo0qH1BbeM1NqVarfcHKJCUnwdevS9dq9PWsvRr71DoAQT7sliDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874543; c=relaxed/relaxed;
	bh=SQaBGCS8CXAgsSL+WPVn+u1IKv5zmqboGM0+4ToKWUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cq33AvpBO3RwokmhnDwkqcq6Jzp+xC9RjSbUumYnjkheAyDDovv1SaSgaXtLxj+9vqTe1h6vJ6+Fn0mIqZE7KG0tR++F8BggKeOk8QqZzI7fCmXcPWzOapOAq+ZTRQObIAUgOFqGTatX6DzTNGH5+kHUdPkizOMLhJv33bEpAE83SaXO9WYWQc6y845AqkoY4yuZuvg5mZ9isnCvKvZ6WWZo186fzBAUPHRubobbTvLgZNSO5y+s3PjgY3/0NVizDGG/3//r4DLJZPkqLUptBVi9P/ZHdBaudmeHPlB/sWNk/EA1b+aQ3p55v6/DOqmkizBXTzTs/BexbCIvYByFuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m8QdmUHE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m8QdmUHE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g148B1nG4z3d8p
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:15:38 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B560C433EE;
	Wed, 22 Apr 2026 16:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B917C19425;
	Wed, 22 Apr 2026 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874536;
	bh=dFCDzhXA2zUSnlj0+jJsCYTv9upJPkAyBg063oGGGK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8QdmUHE22S/biCkSxFIOC14JtXTSxgA4FYN2o0neiedaWK8dLMHPunLd4X2UIExa
	 fbzI4bOnwaWE+ngvwJt6ZeJzCYXsZ4kO6kjIWY0MAg3MFhCWc5CzEN0nOs9p93y47Y
	 zdwWd97wxcDcfUK95xpLmLs/yrQiEK5HAcFdj6zOR1/cUGAmz+OT8pWQEyqwEm6gYs
	 sBAMXyqoPbDKR5h4lD0HI4LpjIEnV7b1fkvWyMLYXG3zJvzNLMVek/O0P9fSknydP0
	 /TI104uBsJeLPyuRiCg9eg9mkSmplBo9QzuAoD80kRIv1cbfgTbffByeVS7VwniOQ/
	 NF2QAwy85F9Dw==
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
Subject: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap
Date: Wed, 22 Apr 2026 16:14:07 +0000
Message-ID: <20260422161407.118748-25-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
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

The resourceN_resize sysfs attributes allow users to resize
Resizable BARs (ReBAR).  After a successful resize, the resource
attribute groups are removed and recreated so that the updated
BAR sizes are reflected in the sysfs files.

Resizable BARs are a PCI Express extended capability
(PCI_EXT_CAP_ID_REBAR), which requires PCIe extended config
space.

Every PCIe-capable architecture defines either HAVE_PCI_MMAP or
ARCH_GENERIC_PCI_MMAP_RESOURCE (via the relevant arch headers
or the generic asm-generic/pci.h fallback).  On platforms that
define neither, the resource files are not created and the sysfs
group remove and create calls in __resource_resize_store() are
no-ops.

Thus, move the resize show and store helpers, the per-BAR attribute
definitions, and the attribute group behind the existing #ifdef
HAVE_PCI_MMAP || ARCH_GENERIC_PCI_MMAP_RESOURCE guard, and fold
the group reference in pci_dev_groups[] into the existing #if block.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b167e32d55ac..37c1990124d0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1690,6 +1690,7 @@ static const struct attribute_group pci_dev_reset_method_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1804,6 +1805,7 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
 	.is_visible = resource_resize_attr_is_visible,
 };
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
@@ -1878,8 +1880,8 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_resource_io_attr_group,
 	&pci_dev_resource_uc_attr_group,
 	&pci_dev_resource_wc_attr_group,
-#endif
 	&pci_dev_resource_resize_attr_group,
+#endif
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
-- 
2.54.0


