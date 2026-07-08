Return-Path: <linuxppc-dev+bounces-23856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D14C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:26:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ4H188Pz3c52;
	Thu, 09 Jul 2026 09:26:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519248;
	cv=none; b=gzE42jNh5doclk519nJebjkOE+CVeORJ4OsfVn14AwJqENJjc3B4Zt2074Q6xkVwJ6Cccswe9x8VXz5VqQRhFkDRUhQSKFHGd+mPHw5mBLZ8mdTIzKwlACc37YUgsqUyE0KpOBEuWpnK0geHgwezKy9ErFIK7Q1Amp6iOrVda78o9k2vu4zDIYb0msF0Sl/GgQ5zzvRTlZEcefndEiFH3G/JL6tXEaRRC3Qdete5fvkhpnOM/UsU1lBTh7srxkwzpMIVxZboiasfnoYxjGQwEO/plDeKHHKxEHNGgDkY6x/DdKwH24No7qea33E0nsheFcTUT+6OE2m73ixiQ87SrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519248; c=relaxed/relaxed;
	bh=Mq58XIR0IAYhSENDSWGX9+npqsCFr/pGmluwkmwvs8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EmGjoS1THFJJ86iYyQBhGjLJQ/LzNzRQChFNVPcRzqKhH8f9+DnxOcz+ZVZYmC8GYixZnJvRjsxN7vzYMfSzglaacZPAT/o1Qmea6xHI6YfDj7HlDRWf+RD1dqkWKsZSDlcxpVRKelh17eQzj6vqVWNK6/MXVInBJ276FhDnKq8YpcBnWw0dU6K2Qm9dHy3luFfwGHv3qok70BzDO6ddXm/gDor0si7BlmFTsht73MqFuXyVTlGFU+8ppT4aw1WrywQBSBD/uW3WVnq3tSuVf0O2xWPvDZGov9ddalutl0MkKDuoFaXflnzSKxDUQWgJFRlJHuvSfriDzATmc4a+8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PoceW7Y8; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PoceW7Y8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKW31wWJz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:00:46 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 377E41E2F;
	Wed,  8 Jul 2026 07:00:11 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EF4D3F66F;
	Wed,  8 Jul 2026 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519215; bh=CJWh1/LO3GU7PcI83NdKJAP2uSNZjys41tAQXyAjl70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PoceW7Y88sADdeY3D5CT35KADJUQMW4KVBUZot4hLOwHMy4UOHalZoajBvXgAzXOG
	 LqmZwg24phuOpb7s7B8YDTcLa5F8Fr9w0jZTRILiT/jdbAr6PIj5We+zN0v55+esNi
	 SkGjHFlc7Ie07QKrEgpFZKN92EW3JyfPqqpOFKj4=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 08 Jul 2026 14:59:09 +0100
Subject: [PATCH v7 10/10] RAS: add firmware-first CPER provider
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ahmed Tiba <ahmed.tiba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=13448;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=CJWh1/LO3GU7PcI83NdKJAP2uSNZjys41tAQXyAjl70=;
 b=Q9RT7ECsqvKkGqrRhm1YnIyQ4QYUXoKoQMS7pp639ZH1rjhJixzqGeBScunR+zkd6YzbKf11z
 U6SoSwwFuRXDXpIGy3nBOuiQOnR+a8bsYRL6HbrGQ/02xJWlLLqPvDW
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Add a firmware-first CPER provider that reuses the shared
GHES helpers, wire it into the RAS Kconfig/Makefile and
document it in the admin guide.

Update MAINTAINERS now that the driver exists.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 Documentation/admin-guide/RAS/main.rst |  15 ++
 MAINTAINERS                            |   1 +
 drivers/acpi/apei/apei-internal.h      |   3 +-
 drivers/firmware/efi/cper.c            |   3 +-
 drivers/ras/Kconfig                    |  12 ++
 drivers/ras/Makefile                   |   1 +
 drivers/ras/cper-esource.c             | 332 +++++++++++++++++++++++++++++++++
 7 files changed, 364 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/RAS/main.rst b/Documentation/admin-guide/RAS/main.rst
index 5a45db32c49b..d4e3c8c1b92f 100644
--- a/Documentation/admin-guide/RAS/main.rst
+++ b/Documentation/admin-guide/RAS/main.rst
@@ -205,6 +205,21 @@ Architecture (MCA)\ [#f3]_.
 .. [#f3] For more details about the Machine Check Architecture (MCA),
   please read Documentation/arch/x86/x86_64/machinecheck.rst at the Kernel tree.
 
+Firmware-first CPER providers
+-----------------------------
+
+Some systems expose Common Platform Error Record (CPER) data through
+platform firmware, with the error source described in DeviceTree.
+Enable ``CONFIG_RAS_CPER_ESOURCE`` to support those providers. The
+current in-tree binding is
+``Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml``.
+
+The DeviceTree node describes the firmware-owned status buffer and ack
+buffer used to exchange CPER data with the OS. The driver reuses the
+shared GHES CPER handling helpers, so parsing, logging, notifier
+delivery, and memory failure handling follow the same paths as ACPI
+GHES whether the error source is described by ACPI or DeviceTree.
+
 EDAC - Error Detection And Correction
 *************************************
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 951342f11e6e..3fa901cb884a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22525,6 +22525,7 @@ RAS ERROR STATUS
 M:	Ahmed Tiba <ahmed.tiba@arm.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
+F:	drivers/ras/cper-esource.c
 
 RAS INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 77c10a7a7a9f..15d11f10d067 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -123,8 +123,7 @@ struct dentry *apei_get_debugfs_dir(void);
 static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 {
 	if (estatus->raw_data_length)
-		return estatus->raw_data_offset + \
-			estatus->raw_data_length;
+		return estatus->raw_data_offset + estatus->raw_data_length;
 	else
 		return sizeof(*estatus) + estatus->data_length;
 }
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..a78e7d17a1b9 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -742,7 +742,8 @@ int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus)
 	    estatus->data_length < sizeof(struct acpi_hest_generic_data))
 		return -EINVAL;
 	if (estatus->raw_data_length &&
-	    estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
+	    (estatus->raw_data_offset < sizeof(*estatus) ||
+	     estatus->raw_data_offset - sizeof(*estatus) < estatus->data_length))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..0592a98792f9 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -34,6 +34,18 @@ if RAS
 source "arch/x86/ras/Kconfig"
 source "drivers/ras/amd/atl/Kconfig"
 
+config RAS_CPER_ESOURCE
+	bool "Firmware-first CPER error source block provider"
+	select GHES_CPER_HELPERS
+	depends on OF_RESERVED_MEM
+	help
+	  Enable support for firmware-first Common Platform Error Record
+	  (CPER) error source block providers. The current in-tree user is
+	  described by the arm,ras-cper DeviceTree binding. The driver
+	  reuses the existing GHES CPER helpers so the error processing
+	  matches the ACPI code paths, but it can be built even when ACPI is
+	  disabled.
+
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
 	default m
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 11f95d59d397..0de069557f31 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
+obj-$(CONFIG_RAS_CPER_ESOURCE)	+= cper-esource.o
 
 obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
diff --git a/drivers/ras/cper-esource.c b/drivers/ras/cper-esource.c
new file mode 100644
index 000000000000..3f60c9849d9a
--- /dev/null
+++ b/drivers/ras/cper-esource.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Firmware-first CPER error source provider.
+ *
+ * This driver shares the GHES CPER helpers so we keep the reporting and
+ * notifier behaviour identical to ACPI GHES.
+ *
+ * Copyright (C) 2026 ARM Ltd.
+ * Author: Ahmed Tiba <ahmed.tiba@arm.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/cper.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/panic.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <acpi/ghes.h>
+#include <acpi/ghes_cper.h>
+
+static DEFINE_IDA(cper_esource_source_ids);
+static DEFINE_MUTEX(cper_esource_pool_lock);
+static bool cper_esource_pool_ready;
+
+struct cper_esource_ack {
+	void *addr;
+	u64 preserve;
+	u64 set;
+	u8 width;
+	bool present;
+};
+
+struct cper_esource {
+	struct device *dev;
+	void *status;
+	size_t status_len;
+
+	struct cper_esource_ack ack;
+
+	struct acpi_hest_generic generic;
+	struct acpi_hest_generic_status *estatus;
+
+	int irq;
+};
+
+static void *cper_esource_map_region(struct device *dev, unsigned int index,
+				     size_t *size)
+{
+	struct resource res;
+	void *addr;
+
+	if (of_reserved_mem_region_to_resource(dev->of_node, index, &res))
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "unable to resolve memory-region %u\n",
+					     index));
+
+	*size = resource_size(&res);
+	if (!*size)
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "memory-region %u has zero length\n",
+					     index));
+
+	addr = devm_memremap(dev, res.start, *size, MEMREMAP_WB);
+	if (!addr)
+		return ERR_PTR(dev_err_probe(dev, -ENOMEM,
+					     "failed to map memory-region %u\n",
+					     index));
+
+	return addr;
+}
+
+static void cper_esource_release_source_id(void *data)
+{
+	struct cper_esource *ctx = data;
+
+	ida_free(&cper_esource_source_ids, ctx->generic.header.source_id);
+}
+
+static int cper_esource_init_pool(void)
+{
+	int rc = 0;
+
+	mutex_lock(&cper_esource_pool_lock);
+	if (!cper_esource_pool_ready) {
+		rc = ghes_estatus_pool_init(1);
+		if (!rc)
+			cper_esource_pool_ready = true;
+	}
+	mutex_unlock(&cper_esource_pool_lock);
+
+	return rc;
+}
+
+static size_t cper_esource_estatus_len(struct acpi_hest_generic_status *estatus)
+{
+	if (estatus->raw_data_length)
+		return (size_t)estatus->raw_data_offset +
+		       (size_t)estatus->raw_data_length;
+	else
+		return sizeof(*estatus) + (size_t)estatus->data_length;
+}
+
+static int cper_esource_validate_status(struct cper_esource *ctx)
+{
+	size_t estatus_len;
+
+	if (!ctx->estatus->block_status)
+		return -ENOENT;
+
+	if (ctx->estatus->data_length >
+	    ctx->status_len - sizeof(*ctx->estatus))
+		return -EINVAL;
+
+	if (cper_estatus_check_header(ctx->estatus))
+		return -EINVAL;
+
+	if (ctx->estatus->raw_data_length &&
+	    (ctx->estatus->raw_data_offset > ctx->status_len ||
+	     ctx->estatus->raw_data_length >
+	     ctx->status_len - ctx->estatus->raw_data_offset))
+		return -EINVAL;
+
+	estatus_len = cper_esource_estatus_len(ctx->estatus);
+	if (estatus_len < sizeof(*ctx->estatus) || estatus_len > ctx->status_len)
+		return -EINVAL;
+
+	if (cper_estatus_check(ctx->estatus))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void cper_esource_ack(struct cper_esource *ctx)
+{
+	if (!ctx->ack.present)
+		return;
+
+	if (ctx->ack.width == 64) {
+		u64 *addr = ctx->ack.addr;
+		u64 val = READ_ONCE(*addr);
+
+		/* Publish status-buffer updates before raising the ack bit. */
+		wmb();
+		val &= ctx->ack.preserve;
+		val |= ctx->ack.set;
+		WRITE_ONCE(*addr, val);
+	} else {
+		u32 *addr = ctx->ack.addr;
+		u32 val = READ_ONCE(*addr);
+
+		/* Publish status-buffer updates before raising the ack bit. */
+		wmb();
+		val &= (u32)ctx->ack.preserve;
+		val |= (u32)ctx->ack.set;
+		WRITE_ONCE(*addr, val);
+	}
+}
+
+static void cper_esource_clear_status(struct cper_esource *ctx)
+{
+	ctx->estatus->block_status = 0;
+	WRITE_ONCE(((struct acpi_hest_generic_status *)ctx->status)->block_status, 0);
+}
+
+static void cper_esource_fatal(struct cper_esource *ctx)
+{
+	__ghes_print_estatus(KERN_EMERG, &ctx->generic, ctx->estatus);
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+	panic("GHES: fatal firmware-first CPER record from %s\n",
+	      dev_name(ctx->dev));
+}
+
+static irqreturn_t cper_esource_process(struct cper_esource *ctx)
+{
+	int rc;
+	int sev;
+
+	memcpy(ctx->estatus, ctx->status, ctx->status_len);
+
+	rc = cper_esource_validate_status(ctx);
+	if (rc == -ENOENT)
+		return IRQ_NONE;
+	if (rc) {
+		dev_warn_ratelimited(ctx->dev, FW_WARN GHES_PFX
+				     "Invalid error status block\n");
+		cper_esource_clear_status(ctx);
+		cper_esource_ack(ctx);
+		return IRQ_HANDLED;
+	}
+
+	sev = ghes_severity(ctx->estatus->error_severity);
+	if (sev >= GHES_SEV_PANIC)
+		cper_esource_fatal(ctx);
+
+	ghes_print_estatus(NULL, &ctx->generic, ctx->estatus);
+
+	ghes_cper_handle_status(ctx->dev, &ctx->generic, ctx->estatus, false);
+	cper_esource_clear_status(ctx);
+	cper_esource_ack(ctx);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cper_esource_irq(int irq, void *data)
+{
+	struct cper_esource *ctx = data;
+
+	return cper_esource_process(ctx);
+}
+
+static int cper_esource_init_ack(struct cper_esource *ctx)
+{
+	struct device *dev = ctx->dev;
+	size_t size;
+
+	ctx->ack.addr = cper_esource_map_region(dev, 1, &size);
+	if (IS_ERR(ctx->ack.addr))
+		return PTR_ERR(ctx->ack.addr);
+
+	switch (size) {
+	case 4:
+		ctx->ack.width = 32;
+		ctx->ack.preserve = ~0U;
+		break;
+	case 8:
+		ctx->ack.width = 64;
+		ctx->ack.preserve = ~0ULL;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported ack resource size %zu\n", size);
+	}
+
+	ctx->ack.set = BIT_ULL(0);
+	ctx->ack.present = true;
+	return 0;
+}
+
+static int cper_esource_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cper_esource *ctx;
+	size_t size;
+	int source_id;
+	int rc;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->dev = dev;
+
+	ctx->status = cper_esource_map_region(dev, 0, &size);
+	if (IS_ERR(ctx->status))
+		return PTR_ERR(ctx->status);
+
+	ctx->status_len = size;
+	if (ctx->status_len < sizeof(*ctx->estatus))
+		return dev_err_probe(dev, -EINVAL,
+				     "status region is smaller than a CPER header\n");
+
+	rc = cper_esource_init_ack(ctx);
+	if (rc)
+		return rc;
+
+	rc = cper_esource_init_pool();
+	if (rc)
+		return rc;
+
+	ctx->estatus = devm_kzalloc(dev, ctx->status_len, GFP_KERNEL);
+	if (!ctx->estatus)
+		return -ENOMEM;
+
+	/* Keep source_id 0 unused so a zeroed header is never treated as valid. */
+	source_id = ida_alloc_min(&cper_esource_source_ids, 1, GFP_KERNEL);
+	if (source_id < 0)
+		return source_id;
+	if (source_id > U16_MAX) {
+		ida_free(&cper_esource_source_ids, source_id);
+		return -ENOSPC;
+	}
+
+	ctx->generic.header.type = ACPI_HEST_TYPE_GENERIC_ERROR;
+	ctx->generic.header.source_id = source_id;
+
+	rc = devm_add_action_or_reset(dev, cper_esource_release_source_id,
+				      ctx);
+	if (rc)
+		return rc;
+
+	ctx->generic.notify.type = ACPI_HEST_NOTIFY_EXTERNAL;
+	ctx->generic.error_block_length = ctx->status_len;
+
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq < 0)
+		return ctx->irq;
+
+	rc = devm_request_threaded_irq(dev, ctx->irq, NULL, cper_esource_irq,
+				       IRQF_ONESHOT,
+				       dev_name(dev), ctx);
+	if (rc)
+		return dev_err_probe(dev, rc, "failed to request interrupt\n");
+
+	return 0;
+}
+
+static const struct of_device_id cper_esource_of_match[] = {
+	{ .compatible = "arm,ras-cper" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cper_esource_of_match);
+
+static struct platform_driver cper_esource_driver = {
+	.driver = {
+		.name = "cper-esource",
+		.of_match_table = cper_esource_of_match,
+	},
+	.probe = cper_esource_probe,
+};
+
+module_platform_driver(cper_esource_driver);
+
+MODULE_AUTHOR("Ahmed Tiba <ahmed.tiba@arm.com>");
+MODULE_DESCRIPTION("Firmware-first CPER provider");
+MODULE_LICENSE("GPL");

-- 
2.43.0


