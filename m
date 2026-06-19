Return-Path: <linuxppc-dev+bounces-22814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715B9CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:54:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghWbL3ZPRz3bsX;
	Fri, 19 Jun 2026 18:53:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781859214;
	cv=none; b=SXjIPbTFwFEFbjSyNOntVH29gEWcl4DAS4Ev2t5G6UgKGQGCGvXbU4CFTSPax/SqtitFUTys2L0RiBcrPrlY6e+Us7pYNlj7a7DmtZTCHO62fzY0vXtEmb+yRk0PsGF9f8X18ngJkrkH/6csS0igRmoJowbtI3qdDdmOlOEaewo2t8sfnOabhnyZIDVn+C4VKtWOVCt3vsF1E+2mAJ7WMn/ZUFnAyIyeGlBXnTCwBJiZNcUK0+gSgXWFzqAb+4Ockx0ATehvXNO4tTm1Fq0aGZOV3NwDxK2DSl14Tbbu4i4ZYWO5Ir6zzt5/BQg0Z2eYX5TiA8QpVbsXp1RPB7NtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781859214; c=relaxed/relaxed;
	bh=g1uGVCygZtkGHVLBMmgjo9/ctPukOUe/hrG8rw2aLgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4QRYKmYCW0ssxq2r0IT/Dy7/Ee2VnCHO1ewcP22ck04hEY8SI5YZzTmuxTGplRyAIBJkgsU/0Ufn3BXIRmJHL1in1qKgQsHW4dYVi/yOdbHeTma0lYf8FPcBjrOIHC2nbo8u/TXhjNJ5EdSljPBBfCTDvbsGF4JE1R2aQPQYXiWGwqGcgCI0vcANU7Uv6oEFQJFs3aX2vbzplcA7iCp9L+5CNRg66Tj3jW4+nGORS1icrX0gZ3Tf5V8GWyNlGmB9KRxvRVPv8j1fxyh+vWI88h+l+iY+j30s9EsnblzYU1QxVkNAOpGVrPrx6/Jy+F+A/6KuGVk3Ie52UQJDsqNTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYlgOxuC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYlgOxuC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghWbK5VNRz3bsS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 18:53:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C6D5437A3;
	Fri, 19 Jun 2026 08:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64A11F000E9;
	Fri, 19 Jun 2026 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859212;
	bh=g1uGVCygZtkGHVLBMmgjo9/ctPukOUe/hrG8rw2aLgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DYlgOxuCpHbJAeNDfKOJFQ1kyMKnuSXkKMdA0JbQyQOtVE86gxbsFGZ8B5WnM/6zZ
	 NSCsTaStKzmEOUG7lz8Qd10mFrNHR859p1z60yGyxXf2MLDzA8webgJAGKWn7H59I5
	 abK4lvAmyOmjycQBotMUIzAPotKS3YLqnR05ad0L6cD5LIiaPmPqeSmNhusNULy2e9
	 lnqtzhh/ZIIKnArEDqPip8pu8w8xVayo78mwlPDe5s8rjfH8lpem0e3ki2qYPP0hDT
	 TqkMatM2/D7BWZDKR94ejyRxZkGJCi1e9eJ7kkVYgMfm3rcslTbieqhh+Hrm+gNSZ8
	 Eq8cibqaEhcdw==
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
Subject: [PATCH v8 24/25] PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()
Date: Fri, 19 Jun 2026 08:51:59 +0000
Message-ID: <20260619085200.3729431-25-kwilczynski@kernel.org>
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

Currently, pci_create_legacy_files() and pci_remove_legacy_files() are
no-op stubs.  With legacy attributes now handled by static groups
registered via pcibus_groups[], no call site needs them.

Remove both functions, their declarations, and the call sites in
pci_register_host_bridge(), pci_alloc_child_bus(), and pci_remove_bus().

Remove the pci_sysfs_init() late_initcall and sysfs_initialized.  The
late_initcall originally existed to create all the dynamic PCI sysfs
files, but with both resource and legacy attributes now handled by
static groups, it is no longer needed.

Remove the legacy_io and legacy_mem fields from struct pci_bus which
were used to track the dynamically allocated legacy attributes.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 21 ---------------------
 drivers/pci/pci.h       |  8 --------
 drivers/pci/probe.c     |  6 ------
 drivers/pci/remove.c    |  2 --
 include/linux/pci.h     |  2 --
 5 files changed, 39 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dfb4e06677fc..dd87b83ba3a9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -37,10 +37,6 @@
 #define ARCH_PCI_DEV_GROUPS
 #endif
 
-#ifdef HAVE_PCI_LEGACY
-static int sysfs_initialized;	/* = 0 */
-#endif
-
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -1085,8 +1081,6 @@ static const struct attribute_group pci_legacy_mem_sparse_group = {
 	.is_bin_visible = pci_legacy_mem_sparse_is_visible,
 };
 
-void pci_create_legacy_files(struct pci_bus *b) { }
-void pci_remove_legacy_files(struct pci_bus *b) { }
 #endif /* HAVE_PCI_LEGACY */
 
 const struct attribute_group *pcibus_groups[] = {
@@ -1773,21 +1767,6 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.is_visible = resource_resize_attr_is_visible,
 };
 
-#ifdef HAVE_PCI_LEGACY
-static int __init pci_sysfs_init(void)
-{
-	struct pci_bus *pbus = NULL;
-
-	sysfs_initialized = 1;
-
-	while ((pbus = pci_find_next_bus(pbus)))
-		pci_create_legacy_files(pbus);
-
-	return 0;
-}
-late_initcall(pci_sysfs_init);
-#endif
-
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
 	&dev_attr_serial_number.attr,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c64c7f5f0bcf..4d17dab4662c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -358,14 +358,6 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 int pci_hp_add_bridge(struct pci_dev *dev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
 
-#if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
-void pci_create_legacy_files(struct pci_bus *bus);
-void pci_remove_legacy_files(struct pci_bus *bus);
-#else
-static inline void pci_create_legacy_files(struct pci_bus *bus) { }
-static inline void pci_remove_legacy_files(struct pci_bus *bus) { }
-#endif
-
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
 extern struct mutex pci_slot_mutex;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..748c7a198262 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1073,9 +1073,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 			dev_err(&bus->dev, "failed to add bus: %d\n", err);
 	}
 
-	/* Create legacy_io and legacy_mem files for this bus */
-	pci_create_legacy_files(bus);
-
 	if (parent)
 		dev_info(parent, "PCI host bridge to bus %s\n", name);
 	else
@@ -1281,9 +1278,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 			dev_err(&child->dev, "failed to add bus: %d\n", ret);
 	}
 
-	/* Create legacy_io and legacy_mem files for this bus */
-	pci_create_legacy_files(child);
-
 	return child;
 }
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 6e796dbc5b29..d8bffa21498a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -65,8 +65,6 @@ void pci_remove_bus(struct pci_bus *bus)
 	list_del(&bus->node);
 	pci_bus_release_busn_res(bus);
 	up_write(&pci_bus_sem);
-	pci_remove_legacy_files(bus);
-
 	if (bus->ops->remove_bus)
 		bus->ops->remove_bus(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e37677a8dd3c..74b767012766 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -726,8 +726,6 @@ struct pci_bus {
 	pci_bus_flags_t bus_flags;	/* Inherited by child buses */
 	struct device		*bridge;
 	struct device		dev;
-	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
-	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
 	unsigned int		flit_mode:1;	/* Link in Flit mode */
-- 
2.54.0


