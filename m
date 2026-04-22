Return-Path: <linuxppc-dev+bounces-19970-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F11FA1FD1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:17:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g14876n2Dz2yvb;
	Thu, 23 Apr 2026 02:15:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776874535;
	cv=none; b=g+ulzz4MqB7++zmELaa4Axe2BKYscMCc1EDh7uMtmdHOYVbcLUMr6I5oFtDXkojho0v53U4Jrxj8ktkGyKK0AiakAlnFiWYWQVl7u975VlHYEA/lBlu618z+HA7Zr5d8CLL+8Oqp08MaTCKEocE7gj9YSyyxX0MIHwCLI0oT2T/5satVz2lIUspQUV4E2Xx+2uq3cW4r2bGN5HtBHMlN7r7BED/cE+vYWlyaChhqz1gWYZGlFCQ5kwZ9TlfaaWzYaJ2QVnqofmao8DRjJYBtHXBARtDzA5eSKYrLroO7ZtPs3nvWFKXi5nEyHNW2HfJyAvHhmiQtKGVzzxyIuVV97A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776874535; c=relaxed/relaxed;
	bh=H8PVxb5rGSolxis7f3aP7Mlc2b8/PML9sNLGJ2/OV3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0SgGla9w4qIRRfuiYOMRjqedD5hiqGH4cXSbMnxEWl+DymdmnN4avGL5edABW/E+kJRz7U86r61TPwMTcde1RPngv760ZT22twqN9BkPuh0kujw3wLjISclI1mYEeRZ3LdjNbYlLRsjqQiBvOwFfWlh8WtG3AF0AXxA/IsxnOt5UPlkepXiXv2ad1JsG4u/FROBhVdd2MojKDbFjGEx1s05+U31fpZhOrHM1KhHnIkDgd+/t0lvFh2KFvqu862dT6OlbS+Fnp17Eoi95+bN19T6a2RqWrgA4VTpGS0dUb2eU5sy5ViEKX01MJa19O3Er+yRi96jakPHYSoD89mT4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=urfpD0G1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=urfpD0G1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g14831g9zz2ysZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 02:15:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A48EE418E4;
	Wed, 22 Apr 2026 16:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44D6C2BCB4;
	Wed, 22 Apr 2026 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874529;
	bh=QW43kt1wGXNpFnpdrIy8ZJkJhZHybDlvjR+csVavZCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urfpD0G11ZxJIwnAzabKK+9muQYP0F0CkvHMc34psC/HSSm+goVU6cjXqFhos1l5u
	 IdpgLmtO41/LwAUNmuMqWikA0dvfRkF47EwAYu5NshvC++ZOPnpeLs3eu/ZJZUkIRL
	 rY/c4Tv3YMO0UyRKS1LOuLXqmbS+og4vaZbXhK9aRsRyh4ZMbpSUOIKDboeM9mJujD
	 0gFIO9O4/OHc4JD2iGp0bn62fFnkwR/AoL+fKouQNWpQMFs6fOoKZFTfF+TXZTwqZH
	 YYgkLQYpBxf/MnCyYPjYUuleko5g3kKBbazJ90GuU9DU/c8ezOZSV4OEQZNDB7PMaB
	 2zdCC4eJaAWPQ==
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
Subject: [PATCH v6 22/24] PCI/sysfs: Convert legacy I/O and memory attributes to static definitions
Date: Wed, 22 Apr 2026 16:14:05 +0000
Message-ID: <20260422161407.118748-23-kwilczynski@kernel.org>
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

Currently, legacy_io and legacy_mem are dynamically allocated and
created by pci_create_legacy_files(), with pci_adjust_legacy_attr()
updating the attributes at runtime on Alpha to rename them and shift
the size for sparse addressing.

Convert to four static const attributes (legacy_io, legacy_io_sparse,
legacy_mem, legacy_mem_sparse) with is_bin_visible() callbacks that
use pci_legacy_has_sparse() to select the appropriate variant per bus.
The sizes are compile-time constants and .size is set directly on
each attribute.

Register the groups in pcibus_groups[] under a HAVE_PCI_LEGACY guard
so the driver model handles creation and removal automatically.

Stub out pci_create_legacy_files() and pci_remove_legacy_files() as
the dynamic creation is no longer needed.  Remove the __weak
pci_adjust_legacy_attr(), Alpha's override, and its declaration from
both Alpha and PowerPC asm/pci.h headers.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/include/asm/pci.h   |   2 -
 arch/alpha/kernel/pci-sysfs.c  |  24 ----
 arch/powerpc/include/asm/pci.h |   2 -
 drivers/pci/pci-sysfs.c        | 200 ++++++++++++++++++++-------------
 4 files changed, 120 insertions(+), 108 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index 95de7ffd59e8..ad5d1391e1fa 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -84,8 +84,6 @@ extern int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val,
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      struct vm_area_struct *vma,
 				      enum pci_mmap_state mmap_state);
-extern void pci_adjust_legacy_attr(struct pci_bus *bus,
-				   enum pci_mmap_state mmap_type);
 extern bool pci_legacy_has_sparse(struct pci_bus *bus,
 				  enum pci_mmap_state type);
 #define HAVE_PCI_LEGACY	1
diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 98f81bc73660..53fda641cb05 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -198,30 +198,6 @@ bool pci_legacy_has_sparse(struct pci_bus *bus, enum pci_mmap_state type)
 	return has_sparse(hose, type);
 }
 
-/**
- * pci_adjust_legacy_attr - adjustment of legacy file attributes
- * @bus: bus to create files under
- * @mmap_type: I/O port or memory
- *
- * Adjust file name and size for sparse mappings.
- */
-void pci_adjust_legacy_attr(struct pci_bus *bus, enum pci_mmap_state mmap_type)
-{
-	struct pci_controller *hose = bus->sysdata;
-
-	if (!has_sparse(hose, mmap_type))
-		return;
-
-	if (mmap_type == pci_mmap_mem) {
-		bus->legacy_mem->attr.name = "legacy_mem_sparse";
-		bus->legacy_mem->size <<= 5;
-	} else {
-		bus->legacy_io->attr.name = "legacy_io_sparse";
-		bus->legacy_io->size <<= 5;
-	}
-	return;
-}
-
 /* Legacy I/O bus read/write functions */
 int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t size)
 {
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 46a9c4491ed0..72f286e74786 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -82,8 +82,6 @@ extern int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val,
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      struct vm_area_struct *vma,
 				      enum pci_mmap_state mmap_state);
-extern void pci_adjust_legacy_attr(struct pci_bus *bus,
-				   enum pci_mmap_state mmap_type);
 #define HAVE_PCI_LEGACY	1
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 8d4ec862c326..c81d3964cfa4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -702,11 +702,6 @@ static const struct attribute_group pcibus_group = {
 	.attrs = pcibus_attrs,
 };
 
-const struct attribute_group *pcibus_groups[] = {
-	&pcibus_group,
-	NULL,
-};
-
 static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -1025,91 +1020,136 @@ bool __weak pci_legacy_has_sparse(struct pci_bus *bus,
 	return false;
 }
 
-/**
- * pci_adjust_legacy_attr - adjustment of legacy file attributes
- * @b: bus to create files under
- * @mmap_type: I/O port or memory
- *
- * Stub implementation. Can be overridden by arch if necessary.
- */
-void __weak pci_adjust_legacy_attr(struct pci_bus *b,
-				   enum pci_mmap_state mmap_type)
+static inline umode_t __pci_legacy_is_visible(struct kobject *kobj,
+					      const struct bin_attribute *a,
+					      enum pci_mmap_state type,
+					      bool sparse)
 {
+	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+
+	if (pci_legacy_has_sparse(bus, type) != sparse)
+		return 0;
+
+	return a->attr.mode;
 }
 
-/**
- * pci_create_legacy_files - create legacy I/O port and memory files
- * @b: bus to create files under
- *
- * Some platforms allow access to legacy I/O port and ISA memory space on
- * a per-bus basis.  This routine creates the files and ties them into
- * their associated read, write and mmap files from pci-sysfs.c
- *
- * On error unwind, but don't propagate the error to the caller
- * as it is ok to set up the PCI bus without these files.
- */
-void pci_create_legacy_files(struct pci_bus *b)
+static umode_t pci_legacy_io_is_visible(struct kobject *kobj,
+					const struct bin_attribute *a, int n)
 {
-	int error;
-
-	if (!sysfs_initialized)
-		return;
-
-	b->legacy_io = kzalloc_objs(struct bin_attribute, 2, GFP_ATOMIC);
-	if (!b->legacy_io)
-		goto kzalloc_err;
-
-	sysfs_bin_attr_init(b->legacy_io);
-	b->legacy_io->attr.name = "legacy_io";
-	b->legacy_io->size = PCI_LEGACY_IO_SIZE;
-	b->legacy_io->attr.mode = 0600;
-	b->legacy_io->read = pci_read_legacy_io;
-	b->legacy_io->write = pci_write_legacy_io;
-	/* See pci_create_attr() for motivation */
-	b->legacy_io->llseek = pci_llseek_resource;
-	b->legacy_io->mmap = pci_mmap_legacy_io;
-	b->legacy_io->f_mapping = iomem_get_mapping;
-	pci_adjust_legacy_attr(b, pci_mmap_io);
-	error = device_create_bin_file(&b->dev, b->legacy_io);
-	if (error)
-		goto legacy_io_err;
-
-	/* Allocated above after the legacy_io struct */
-	b->legacy_mem = b->legacy_io + 1;
-	sysfs_bin_attr_init(b->legacy_mem);
-	b->legacy_mem->attr.name = "legacy_mem";
-	b->legacy_mem->size = PCI_LEGACY_MEM_SIZE;
-	b->legacy_mem->attr.mode = 0600;
-	b->legacy_mem->mmap = pci_mmap_legacy_mem;
-	/* See pci_create_attr() for motivation */
-	b->legacy_mem->llseek = pci_llseek_resource;
-	b->legacy_mem->f_mapping = iomem_get_mapping;
-	pci_adjust_legacy_attr(b, pci_mmap_mem);
-	error = device_create_bin_file(&b->dev, b->legacy_mem);
-	if (error)
-		goto legacy_mem_err;
-
-	return;
-
-legacy_mem_err:
-	device_remove_bin_file(&b->dev, b->legacy_io);
-legacy_io_err:
-	kfree(b->legacy_io);
-	b->legacy_io = NULL;
-kzalloc_err:
-	dev_warn(&b->dev, "could not create legacy I/O port and ISA memory resources in sysfs\n");
+	return __pci_legacy_is_visible(kobj, a, pci_mmap_io, false);
 }
 
-void pci_remove_legacy_files(struct pci_bus *b)
+static umode_t pci_legacy_io_sparse_is_visible(struct kobject *kobj,
+					       const struct bin_attribute *a,
+					       int n)
 {
-	if (b->legacy_io) {
-		device_remove_bin_file(&b->dev, b->legacy_io);
-		device_remove_bin_file(&b->dev, b->legacy_mem);
-		kfree(b->legacy_io); /* both are allocated here */
-	}
+	return __pci_legacy_is_visible(kobj, a, pci_mmap_io, true);
 }
+
+static umode_t pci_legacy_mem_is_visible(struct kobject *kobj,
+					 const struct bin_attribute *a, int n)
+{
+	return __pci_legacy_is_visible(kobj, a, pci_mmap_mem, false);
+}
+
+static umode_t pci_legacy_mem_sparse_is_visible(struct kobject *kobj,
+						const struct bin_attribute *a,
+						int n)
+{
+	return __pci_legacy_is_visible(kobj, a, pci_mmap_mem, true);
+}
+
+static const struct bin_attribute pci_legacy_io_attr = {
+	.attr = { .name = "legacy_io", .mode = 0600 },
+	.size = PCI_LEGACY_IO_SIZE,
+	.read = pci_read_legacy_io,
+	.write = pci_write_legacy_io,
+	.mmap = pci_mmap_legacy_io,
+	.llseek = pci_llseek_resource,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_io_sparse_attr = {
+	.attr = { .name = "legacy_io_sparse", .mode = 0600 },
+	.size = PCI_LEGACY_IO_SIZE << 5,
+	.read = pci_read_legacy_io,
+	.write = pci_write_legacy_io,
+	.mmap = pci_mmap_legacy_io,
+	.llseek = pci_llseek_resource,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_mem_attr = {
+	.attr = { .name = "legacy_mem", .mode = 0600 },
+	.size = PCI_LEGACY_MEM_SIZE,
+	.mmap = pci_mmap_legacy_mem,
+	.llseek = pci_llseek_resource,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_mem_sparse_attr = {
+	.attr = { .name = "legacy_mem_sparse", .mode = 0600 },
+	.size = PCI_LEGACY_MEM_SIZE << 5,
+	.mmap = pci_mmap_legacy_mem,
+	.llseek = pci_llseek_resource,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute *const pci_legacy_io_attrs[] = {
+	&pci_legacy_io_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_legacy_io_sparse_attrs[] = {
+	&pci_legacy_io_sparse_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_legacy_mem_attrs[] = {
+	&pci_legacy_mem_attr,
+	NULL,
+};
+
+static const struct bin_attribute *const pci_legacy_mem_sparse_attrs[] = {
+	&pci_legacy_mem_sparse_attr,
+	NULL,
+};
+
+static const struct attribute_group pci_legacy_io_group = {
+	.bin_attrs = pci_legacy_io_attrs,
+	.is_bin_visible = pci_legacy_io_is_visible,
+};
+
+static const struct attribute_group pci_legacy_io_sparse_group = {
+	.bin_attrs = pci_legacy_io_sparse_attrs,
+	.is_bin_visible = pci_legacy_io_sparse_is_visible,
+};
+
+static const struct attribute_group pci_legacy_mem_group = {
+	.bin_attrs = pci_legacy_mem_attrs,
+	.is_bin_visible = pci_legacy_mem_is_visible,
+};
+
+static const struct attribute_group pci_legacy_mem_sparse_group = {
+	.bin_attrs = pci_legacy_mem_sparse_attrs,
+	.is_bin_visible = pci_legacy_mem_sparse_is_visible,
+};
+
+void pci_create_legacy_files(struct pci_bus *b) { }
+void pci_remove_legacy_files(struct pci_bus *b) { }
 #endif /* HAVE_PCI_LEGACY */
 
+const struct attribute_group *pcibus_groups[] = {
+	&pcibus_group,
+#ifdef HAVE_PCI_LEGACY
+	&pci_legacy_io_group,
+	&pci_legacy_io_sparse_group,
+	&pci_legacy_mem_group,
+	&pci_legacy_mem_sparse_group,
+#endif
+	NULL,
+};
+
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
 /**
  * pci_mmap_resource - map a PCI resource into user memory space
-- 
2.54.0


