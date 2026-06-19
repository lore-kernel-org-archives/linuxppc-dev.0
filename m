Return-Path: <linuxppc-dev+bounces-22799-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E305CD98F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:53:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWZJ16ttz3br5;
	Fri, 19 Jun 2026 18:52:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859160;
	cv=none; b=iQ0xndJqOwaVLC4MmgTQmJUMDfnrvG3+kdAT5eTn2FdU4Tg8iUhw9OL7f0mjEFEldQoGz5R9ps0rVHwZZ2AP83+0w7FNbAqQn5JrYdxCN9OmptH1cfbXnBdPrOz8XCdvXfsuyiuLCnRLMuNXdOkyc6b2Iw6HnV8UDhm+P9FXZQTXBo8HHdlq+fV9uI8CRlB62aFP95hKH9jOjb3nta1cpeetjkG8tPjSAAdHdTmCJX1yVNNR/zUV/DMSUJt2qo0Wb2NHUxO244Garw1wMaQyS6Hc+FWHWi+KfYb0wHax3QEWxoheZhvIT/y2H75x7x4Dh50AjvcV2W7JNmmPl5PYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859160; c=relaxed/relaxed;
	bh=ZKeckWCfh4gjuHUPhpR/CO046mcmnckXFaZkM90an1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O06ZT/C4jOOi9X2+NYkf+U158oOMAxJw038uwxgP1qpBPuvqfZQutQtf7gXifxIX6C2e2lT/g6kMQDXe99FMTxLah4+knyc+L1mhd+KOy5/2ChjUtjH9huTUU+PmL50Zb0ho1cj3SAMbSD0/dr3+b+qpvFm5P8kQB4l5BF10mYf+yLG6QledLRYg5wkMi8lrEId/59MV5r5FAl16eXvnd/zUx7tzopaMv3zW+sdaI8NfE/+tru4yT7WLyhZL5BgQU6tITJCeuVytRNgktotWee9MWDpfCO6PADljjgXZlIw+NaSWjHp9MoCk1lHXrVQyRjY8bzYw90crat8pZ/f4VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0r/I99D; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0r/I99D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWZH33Zsz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:52:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E479340A11;
	Fri, 19 Jun 2026 08:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CB71F000E9;
	Fri, 19 Jun 2026 08:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859157;
	bh=ZKeckWCfh4gjuHUPhpR/CO046mcmnckXFaZkM90an1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D0r/I99DR/KUnTuclOi6C9Q77McqqjVUqkJZBOnxAsWTdtCi3dRU5b29NubsW9fil
	 Y09grlR2vZsuMN5nw/fejgYZSuHpHP+T2aL4DvYVL9reBQH24dvJo3ETM+mtV/ELSR
	 iQAS/xJduLi60WrqmqvSWkc4nAf8VLsW0VfCJsal6JmGeQaZeGlm1QXaj+QFzFpY2Z
	 WfRl3CEt5S4eiPx6Xn20r8ywwgNTmygBDViz5EFEx+Qxe8qUSF24h2/D6qZwScAFq4
	 pwQbF5+xUgJ/KM+DyleG9ELBA7Gt8z7clnakOzkOqVlRvrTD+03tkAbuJomUnblAEh
	 PiPiuF/uLx+hA==
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
Subject: [PATCH v8 09/25] PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
Date: Fri, 19 Jun 2026 08:51:44 +0000
Message-ID: <20260619085200.3729431-10-kwilczynski@kernel.org>
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

On platforms with HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE,
resource files are now handled by static attribute groups registered
via pci_dev_groups[].

Thus, the pci_create_sysfs_dev_files() and pci_remove_sysfs_dev_files()
can now be stubbed out, as the dynamic resource file creation is no
longer needed.

Also, simplify pci_sysfs_init() on these platforms to only iterate
buses for legacy attributes creation, skipping the per-device loop.

Move the __weak stubs for pci_create_resource_files() and
pci_remove_resource_files() into the #else branch since only platforms
without HAVE_PCI_MMAP (such as Alpha architecture) still need them.
Guard the res_attr[] and res_attr_wc[] fields in struct pci_dev the
same way.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 15 ++++++++++++---
 include/linux/pci.h     |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b8b7fb809c69..208ec7057b50 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1370,10 +1370,9 @@ static const struct attribute_group *pci_dev_resource_attr_groups[] = {
 };
 #else
 #define pci_dev_resource_attr_groups NULL
-#endif
-
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { }
+#endif
 
 /**
  * pci_write_rom - used to enable access to the PCI ROM display
@@ -1742,6 +1741,10 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.is_visible = resource_resize_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
+#else
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
@@ -1763,9 +1766,15 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
 	pci_remove_resource_files(pdev);
 }
+#endif
 
 static int __init pci_sysfs_init(void)
 {
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+	struct pci_bus *pbus = NULL;
+
+	sysfs_initialized = 1;
+#else
 	struct pci_dev *pdev = NULL;
 	struct pci_bus *pbus = NULL;
 	int retval;
@@ -1778,7 +1787,7 @@ static int __init pci_sysfs_init(void)
 			return retval;
 		}
 	}
-
+#endif
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 974605c9fce2..b998a56f6010 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -515,8 +515,10 @@ struct pci_dev {
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
+#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+#endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
@@ -2531,8 +2533,10 @@ int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
 
+#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 extern int pci_create_resource_files(struct pci_dev *dev);
 extern void pci_remove_resource_files(struct pci_dev *dev);
+#endif
 
 #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
-- 
2.54.0


