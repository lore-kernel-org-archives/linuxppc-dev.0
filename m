Return-Path: <linuxppc-dev+bounces-20606-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A9DCD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:38:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbtw0m2yz30Vb;
	Fri, 08 May 2026 14:37:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778215032;
	cv=none; b=dMCLOVlmpIGy3t435q6kifbYATorY/h27I9GPtkjYALtV8AvyPZ/3hmyOqUW+Y6S29ocuzJp1q8uycBUUrU0KODyaBZMxsqlE5SNJYjhWy2qaoTH9GpBNvU9CpG8aPjMBeFhN/QGHgqRMV4YxRaerbBDsns7E0su3R59mYZdApXmWhekC4AQW1/sVRkfsy5DT9dSH3Rp1LzxLU8+OGHU0OUIGQds05i3YJb6jcsP3o3evuJ1bVuQB/GKgoFePbft731J0X1bKhKVremF35K8BuhCKWF28vofOERiXj05hWblY9KubT63/yItHSwPPgt8u2X35FG21wqDb4wli70HZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778215032; c=relaxed/relaxed;
	bh=Tqz3/W1Ur8IQ6oLkqp1jj/dVz1s+mpHUaVgZMEzMUSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayxbeGf0BxZpD33wikQaFTZYZHZdcraYeEfEjWIpEFjVWgoljI1BqaP/9xOMsa16cojZYWd3+4R6ISmZ0mEv+iKdEW12O3Hy1O/xYFDZcSTZAypakHQo+4gow0bJ1dyQhyHQ9prWAzo7Tth1lBTKcAKCwhDSXlgFTC1ze2ZJWAenqKXK0KiQp2CR5JsYXS9wIqpyP0UpZa8sUuMAbMmEVyTusEjIQBRlXSw3/kir3Cy0wtSssEsb4+yW0RjTD32HFqp4KdNFK0qKSUAARAg3qKsckQJc04Cl06omeHqhYbaY3EUqb0E/MasGMKFbx4EgrdxIOHui8UVnyS00rhiRLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RaqT9k45; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RaqT9k45;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbtv0H74z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:37:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0309F44049;
	Fri,  8 May 2026 04:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A86C2BCB4;
	Fri,  8 May 2026 04:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215028;
	bh=G6UD1aaMiOXRzm8kwnIOIyTXuf7I20BRIy7t3eDKGHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaqT9k45tf2HKbqNoc6L4sev712QYa636E35uPMtdW+AOElCTeTp53DZv3gyynVA+
	 LnHzueyh9HEaw2ks+9cMV4Adt1/zNfcn5uQ+qE05p04MLdrmTBqhdb30xHcBeoaWqJ
	 Jzzk6d+QnTkAv3ZSB1AkB534VkWcKyEP7xeCkW5JtKz0AAUGfMksvb5qG+rbzJ39X8
	 Rq75iVzbnWL8t5TybhoBhFH0iFCev6lefEKwMnazBMzSZgt2SselEotQB9K8R5rWwz
	 XZRW/v77zRUc+wqwFZ7p/1E7a0lpl6ASGrFBhpSn0RLItNAy0ptC7tYRwRNR/iw9Ba
	 ilwnlYdJFzBMw==
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
Subject: [PATCH v7 22/24] PCI/sysfs: Convert legacy I/O and memory attributes to static definitions
Date: Fri,  8 May 2026 04:35:41 +0000
Message-ID: <20260508043543.217179-23-kwilczynski@kernel.org>
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

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/include/asm/pci.h   |   2 -
 arch/alpha/kernel/pci-sysfs.c  |  38 ++----
 arch/powerpc/include/asm/pci.h |   2 -
 drivers/pci/pci-sysfs.c        | 221 +++++++++++++++++++--------------
 4 files changed, 135 insertions(+), 128 deletions(-)

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
index 2d46502ba09b..7dae4999c5e3 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -192,30 +192,6 @@ bool pci_legacy_has_sparse(struct pci_bus *bus, enum pci_mmap_state type)
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
@@ -292,9 +268,9 @@ static inline enum pci_mmap_state pci_bar_mmap_type(struct pci_dev *pdev,
 	return pci_resource_is_mem(pdev, bar) ? pci_mmap_mem : pci_mmap_io;
 }
 
-static inline umode_t __pci_dev_resource_is_visible(struct kobject *kobj,
-						    const struct bin_attribute *a,
-						    int bar)
+static inline umode_t __pci_resource_attr_is_visible(struct kobject *kobj,
+						     const struct bin_attribute *a,
+						     int bar)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
@@ -314,7 +290,7 @@ static umode_t pci_dev_resource_is_visible(struct kobject *kobj,
 	if (has_sparse(hose, pci_bar_mmap_type(pdev, bar)))
 		return 0;
 
-	return __pci_dev_resource_is_visible(kobj, a, bar);
+	return __pci_resource_attr_is_visible(kobj, a, bar);
 }
 
 static umode_t pci_dev_resource_sparse_is_visible(struct kobject *kobj,
@@ -331,7 +307,7 @@ static umode_t pci_dev_resource_sparse_is_visible(struct kobject *kobj,
 	if (type == pci_mmap_mem && !sparse_mem_mmap_fits(pdev, bar))
 		return 0;
 
-	return __pci_dev_resource_is_visible(kobj, a, bar);
+	return __pci_resource_attr_is_visible(kobj, a, bar);
 }
 
 static umode_t pci_dev_resource_dense_is_visible(struct kobject *kobj,
@@ -347,14 +323,14 @@ static umode_t pci_dev_resource_dense_is_visible(struct kobject *kobj,
 		return 0;
 
 	if (type == pci_mmap_mem && !sparse_mem_mmap_fits(pdev, bar))
-		return __pci_dev_resource_is_visible(kobj, a, bar);
+		return __pci_resource_attr_is_visible(kobj, a, bar);
 
 	dense_base = (type == pci_mmap_mem) ? hose->dense_mem_base :
 					      hose->dense_io_base;
 	if (!dense_base)
 		return 0;
 
-	return __pci_dev_resource_is_visible(kobj, a, bar);
+	return __pci_resource_attr_is_visible(kobj, a, bar);
 }
 
 static inline size_t __pci_dev_resource_bin_size(struct kobject *kobj,
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
index 1e6786463e4e..868b42420358 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -676,11 +676,6 @@ static const struct attribute_group pcibus_group = {
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
@@ -879,19 +874,6 @@ static const struct attribute_group pci_dev_config_attr_group = {
 	.bin_size = pci_dev_config_attr_bin_size,
 };
 
-/*
- * llseek operation for mmappable PCI resources.
- * May be left unused if the arch doesn't provide them.
- */
-static __maybe_unused loff_t
-pci_llseek_resource_legacy(struct file *filep,
-			   struct kobject *kobj __always_unused,
-			   const struct bin_attribute *attr,
-			   loff_t offset, int whence)
-{
-	return fixed_size_llseek(filep, offset, whence, attr->size);
-}
-
 #ifdef HAVE_PCI_LEGACY
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
@@ -989,91 +971,144 @@ bool __weak pci_legacy_has_sparse(struct pci_bus *bus,
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
-	b->legacy_io->llseek = pci_llseek_resource_legacy;
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
-	b->legacy_mem->llseek = pci_llseek_resource_legacy;
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
+static loff_t pci_llseek_resource_legacy(struct file *filep,
+					 struct kobject *kobj __always_unused,
+					 const struct bin_attribute *attr,
+					 loff_t offset, int whence)
+{
+	return fixed_size_llseek(filep, offset, whence, attr->size);
+}
+
+static const struct bin_attribute pci_legacy_io_attr = {
+	.attr = { .name = "legacy_io", .mode = 0600 },
+	.size = PCI_LEGACY_IO_SIZE,
+	.read = pci_read_legacy_io,
+	.write = pci_write_legacy_io,
+	.mmap = pci_mmap_legacy_io,
+	.llseek = pci_llseek_resource_legacy,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_io_sparse_attr = {
+	.attr = { .name = "legacy_io_sparse", .mode = 0600 },
+	.size = PCI_LEGACY_IO_SIZE << 5,
+	.read = pci_read_legacy_io,
+	.write = pci_write_legacy_io,
+	.mmap = pci_mmap_legacy_io,
+	.llseek = pci_llseek_resource_legacy,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_mem_attr = {
+	.attr = { .name = "legacy_mem", .mode = 0600 },
+	.size = PCI_LEGACY_MEM_SIZE,
+	.mmap = pci_mmap_legacy_mem,
+	.llseek = pci_llseek_resource_legacy,
+	.f_mapping = iomem_get_mapping,
+};
+
+static const struct bin_attribute pci_legacy_mem_sparse_attr = {
+	.attr = { .name = "legacy_mem_sparse", .mode = 0600 },
+	.size = PCI_LEGACY_MEM_SIZE << 5,
+	.mmap = pci_mmap_legacy_mem,
+	.llseek = pci_llseek_resource_legacy,
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


