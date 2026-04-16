Return-Path: <linuxppc-dev+bounces-19800-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09775F8D761
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:02:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQnQ3jZ3z2yw7;
	Fri, 17 Apr 2026 04:01:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362506;
	cv=none; b=DkYAMiyOCS9hcYwKgOB5NU/jNu10TInNmPx6rVyXUNG377hisN5JGtV8s0mWACZ+3fDmTVRAksWLrR9kIR4TzdJiVgMNPUdjTDKVQH23sR1RTdyB3+DNqNPyIJsOmCmhLvRbzyGvXv6IZR8ketNPSS0S20Iu34kgIlpybmCct9kQMfhsyF7u14k5yq8rx/yA/xgOKdZjFnq2cqukM4S5Dq/hROMAPrMTOhMnIMeKCXRnh6+xQutrIo2gIlPpTxx2zyh/GQDADLztcSeC8UjWzFt6FkEGBE42vVJSi5z9s6z3nDZGzwg2zZcYb/EzsIdUwbA9IB4YQnZoX2vMLrwDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362506; c=relaxed/relaxed;
	bh=lzWRqyJIbRjEAzysxaC48fx9aNpMRJ4BGNuWLuDK3Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rcg+gTQccX8oBc+TAtqS7SOd9SFTv81dczhDQDthA5MDy6d4aG8hfyjgU81H/yky6Fab7/+Nm9/wYPpKEKeZ7UNK9YTfnfmQArJTT6GTDIpLpjUCmfgA3TWh0f84Lop89dmIIHhZ+yGX8nDHvhgrTIY56CP7FhRUq7xnRWasFnN1Krc9Ze7kJxtLyN62pv1QIn5f8zG4dfDRIkp/ZDW+6KSwDKZnPKy2G1+NIoLg/gfoboGUNvG6ui9FFzReYl4DDdOIVD42h6xo/dY20sONwAHjMCox+PLXqeO/k5XSv2DPIZMaJgzvtiqC3gVB0mMQkSHMKo047plSPB9GIrHcVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H+wZ7Ghj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H+wZ7Ghj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQnP53Sbz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:01:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E26F340AF7;
	Thu, 16 Apr 2026 18:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95391C2BCAF;
	Thu, 16 Apr 2026 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362503;
	bh=9a670pxaN5vTIVp/eoWyGpfgnbFQKJPHCQ1Ff885QlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+wZ7GhjAYwIWcQXdYb/i/udmewYM7nKQOYyJvHo66UNO91HI0blFJyyiuhCvFKDL
	 depSkOpomcT4cgaEezk2QrabpAlmHmVL6zqvbUpWvKVugdtzFUXwF2d6Gw5gc37OQ5
	 P7sSQrgvL1jPy7dGVq9vUpjmUdqdbF4KeYnZPnkOLZpfZek+tfeYlh+6g1at6VOeOw
	 B3S6T9NzbE7WcwDwvv7/9LLhZIurWUWZN0sUgOzOX1A+FP4jUojsdmX8p89MRVzKrG
	 1olj+02hAuA/5b2AdMBsqykIe2fTrcSIcfNkCa99ppHKtuU2AAdlieUpcr7Q3rHrjn
	 uj/JnGIt57ncw==
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
Subject: [PATCH v5 09/23] PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
Date: Thu, 16 Apr 2026 18:00:53 +0000
Message-ID: <20260416180107.777065-10-kwilczynski@kernel.org>
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

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 15 ++++++++++++---
 include/linux/pci.h     |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c0925bdc9ecd..517efb6d71cc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1394,10 +1394,9 @@ static const struct attribute_group *pci_dev_resource_attr_groups[] = {
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
@@ -1766,6 +1765,10 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.is_visible = resource_resize_attr_is_visible,
 };
 
+#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
+#else
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
@@ -1787,9 +1790,15 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
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
@@ -1802,7 +1811,7 @@ static int __init pci_sysfs_init(void)
 			return retval;
 		}
 	}
-
+#endif
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9c0782899ef9..30aeb8e02b7b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -507,8 +507,10 @@ struct pci_dev {
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
+#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
+#endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
@@ -2526,8 +2528,10 @@ int pcibios_alloc_irq(struct pci_dev *dev);
 void pcibios_free_irq(struct pci_dev *dev);
 resource_size_t pcibios_default_alignment(void);
 
+#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 extern int pci_create_resource_files(struct pci_dev *dev);
 extern void pci_remove_resource_files(struct pci_dev *dev);
+#endif
 
 #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
-- 
2.53.0


