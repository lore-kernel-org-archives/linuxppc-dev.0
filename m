Return-Path: <linuxppc-dev+bounces-20608-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF26CD342F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:38:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbv32YrBz30Vn;
	Fri, 08 May 2026 14:37:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778215039;
	cv=none; b=eTZWIjqVJO6t61foTynxRy4plWcIP7483u9L+ljpSHVq5cHW/hA0xw+ZV4yrUHzACe+81L9FNEkIWS0VWmFuap1OUEaeQtJLJRBDx4Xfx8ZyVHK8GJpCxlgsRH2gSjNw/ej8SI2fT+oWmyzGViPSx4138C2JlfJs+I5ISF3+gwVi6BbTOZr3fkNMMpewYTG4p9UoXKlg/D3Nd7ceKcVDbHWHzWV6r3a1C4cFm7UxE4fgIZpTbI1dYb/d/IVDgGhQfn67bkwdUDjG3BpKOej+yff0BB3cZY/nOsqTBodP9SVhZ1cvOk/zbnKqsaS/AoDUELe4pbV6ducBAJrGZMNx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778215039; c=relaxed/relaxed;
	bh=5rM02NLXVdR9uWLAGneUkIpOyQErRLVkxCVpCs0cPIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNt+vtWCHiKwfWOJUiZVPIj6XyE1Np9lZqykKKklx1NKB55r+D0T9ilDVDZeFZk+Lg9K1oV3w74ZYvv22zpJK7Wbkp6JcyFA1Lup9V4Qyn3aEpif85SN9iPskdTxaUpglAYJM1B6qEg9qtNWHTTno+/bBbDtI2nsV02tR+5TPDbnuFGL/XdoqfQzsrWgEtrPvJqFlKDArgAW9uzE0dNKdDnA6j3ivI6kuM2SCX2sXzuG/9tI9+dmNfdf4cfsYO41r8Kl26b1uI1lEe3aMCCnESlaMwG4RykbtjlURh2kfMC+Z/T7bB7OqxVq0GCoZSsnQS8iacZvOizk+oBpIsoLxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pDIZz6JT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pDIZz6JT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbv23Wthz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:37:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 71F7B6024D;
	Fri,  8 May 2026 04:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B32C2BCB0;
	Fri,  8 May 2026 04:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215036;
	bh=g1Q0Y9xFxmkBFDILfcdAU3XRw5NhqOHXxvlpf+w+W4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pDIZz6JT+F50/NoXuF7lFmNqg8Xpq6ar8JHkiL1odWO86N+rOe8JidqrT7wtsIW3t
	 93FSlxaBsR1QokyyJQgywFCxNoHnJN1NdlhT9+bOWnTetGZ0UGfNr2EJYfRxtSa9+7
	 QafCJBekO6SkU2yTq/Ljkct+pzdCfy1y6YRu75s/pcMlmDhnqoynyxXB9EWN3hAlq+
	 ShPRwGhnWD94gNzGH+PKAm0G7/pWojPkWZV7fdHaAbDN0ZvvmcR/LehdvcM5/RxpQY
	 fy+35MGYw1z1BM427XCnE9GzPrIrGwKKUJDZMlUpUYQFHur1LncvYHjphNqfo8qNUB
	 zzg9mYwpDD3dw==
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
Subject: [PATCH v7 24/24] PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap
Date: Fri,  8 May 2026 04:35:43 +0000
Message-ID: <20260508043543.217179-25-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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

Currently, __resource_resize_store() uses sysfs_remove_groups()
and sysfs_create_groups() on pci_dev_resource_attr_groups to
tear down and recreate the resourceN files after a BAR resize,
so the updated BAR sizes are visible in sysfs.

The resourceN files only exist on platforms that define
HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE.  On platforms
that define neither, pci_dev_resource_attr_groups is NULL and
the sysfs_remove_groups() and sysfs_create_groups() calls in
__resource_resize_store() become no-ops.

Resizable BAR (ReBAR) is a PCI Express extended capability
(PCI_EXT_CAP_ID_REBAR) that requires PCIe extended config
space.  Every PCIe-capable architecture defines HAVE_PCI_MMAP
or ARCH_GENERIC_PCI_MMAP_RESOURCE (via arch headers or the
asm-generic/pci.h fallback).  Architectures without either
only support conventional PCI and cannot have any ReBAR-capable
devices.

Thus, move the resize show and store helpers, the per-BAR attribute
definitions, and the attribute group behind the existing #ifdef
HAVE_PCI_MMAP || ARCH_GENERIC_PCI_MMAP_RESOURCE guard, and fold the
group reference in pci_dev_groups[] into the existing #if block.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f5427bcfb0cc..6099371f67e7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1661,6 +1661,7 @@ static const struct attribute_group pci_dev_reset_method_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1775,6 +1776,7 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.attrs = resource_resize_attrs,
 	.is_visible = resource_resize_attr_is_visible,
 };
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
@@ -1849,8 +1851,8 @@ const struct attribute_group *pci_dev_groups[] = {
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


