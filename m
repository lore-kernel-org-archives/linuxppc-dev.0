Return-Path: <linuxppc-dev+bounces-23848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B90C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:25:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ2v32wvz3046;
	Thu, 09 Jul 2026 09:25:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519205;
	cv=none; b=C1kx6LsM+Q/LheZ356F2Y4NIuF+aqcbwFrGRZ/xm02dDUi0bv61CfBONEhknbd4TwPihebF/0ux7xhvi53VYmt2CgbVu3V8gWZYk2QuQFvv8h3I5xxMZm3tNzyIswiCDgzfEMHIzF7T2uQO27CUZ4J1GgqdwvVHCbkUAkDurrKPWVfcJAE8RGp0RjDWCZHmgHj9zpsWirpOMaisMfNrcDAzxR08hiKqgoNnsUMHHw1MwZnouyY8opyj8GDaPVp0WGqtsTJxCC6x/u2wa25GZfZAAUEG/jyPAmxRBNNX3z9G28+uQE8dQWtgAD4udioShXvndfTGLwePNK67cTmelqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519205; c=relaxed/relaxed;
	bh=lH5tXY/lsrWCOaYe6IWwF5TcQnNIR5E9mMGcaXzYvls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGK9IS+h9ZdatkqA4kU9cPobvV3+4Qe92aj2BmyNePEWZWNhoJfQ568DKICXzW3EWDjb+1VuEZ34ZfetGKEuElC4qEp8CyTmnITK2iSN6Y/VYQhi4yO+YQa+XtOvBqF46tOu6gFaFlZxd37wogIvlbp6+8qbHdYbuqN6kKFRwAjk+0T1QxcfgUnnVXUfwTzjf3MlyZipkm9JKL+IzkiUwi/8j3EjNVviSfuIHMeAqX+NtzYhGyWXAVIxVyxts+LXW2lyM83wnglPBXpuvHLRWQNo7rCf1whacfiXglvMYLM6EBbJQLZay35Gba+eURFawwPBpOFD1muxh0I2oPDmrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Nh1LgSSo; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Nh1LgSSo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKVD6FHxz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:00:04 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3815D1E2F;
	Wed,  8 Jul 2026 06:59:29 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A90623F66F;
	Wed,  8 Jul 2026 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519173; bh=ZCjtntdw7IwCo8ZKJV9f9QDaaQ3JL7ULHfeyEQr0Ykw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nh1LgSSo7Kxer50UXcAQnZmv8Ut4F2lkXkWyhErvpv6nu6n81TLonduW4DcBNwxlT
	 Q3vbfDEFdHwD804W1ImL5TzOql4uSNdwFDTbzVFe3j24EvmUGZmFBK2CEgHx5d0W6X
	 YvM+HHgSnLW9/NAKeQEo8JsZ/aSoKf7gHns7PUKI=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 08 Jul 2026 14:59:01 +0100
Subject: [PATCH v7 02/10] ACPI: APEI: GHES: move CPER read helpers
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
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-2-8b3a85216cef@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=12095;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=ZCjtntdw7IwCo8ZKJV9f9QDaaQ3JL7ULHfeyEQr0Ykw=;
 b=b3tpQhpemXve2i6+uYcvkdAhs1pZYYsrFoeS+WiuzP6TYvXAZ6Fnk6LCoc8pzE9K2V7YvY9+Q
 w8nPIf0P7ldBCM9YyT/LMvvQA+Xym1ShRkMFeefoOjt1yywqeMMwflU
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Relocate the CPER buffer mapping, peek, and clear helpers from ghes.c into
ghes_cper.c so they can be shared with other firmware-first providers.
This commit only shuffles code; behavior stays the same.

While here, fix ghes_ack_error() mask handling and add second-copy length
validation in __ghes_read_estatus().

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/Makefile    |   2 +-
 drivers/acpi/apei/ghes.c      | 166 ---------------------------------
 drivers/acpi/apei/ghes_cper.c | 210 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+), 167 deletions(-)

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 66588d6be56f..f57f3b009d8e 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
-obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
+obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o ghes_cper.o
 # clang versions prior to 18 may blow out the stack with KASAN
 ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
 KASAN_SANITIZE_ghes.o := n
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index c73a316644e8..f74fd5de34cc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -118,26 +118,6 @@ static struct gen_pool *ghes_estatus_pool;
 static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
-{
-	phys_addr_t paddr;
-	pgprot_t prot;
-
-	paddr = PFN_PHYS(pfn);
-	prot = arch_apei_get_mem_attribute(paddr);
-	__set_fixmap(fixmap_idx, paddr, prot);
-
-	return (void __iomem *) __fix_to_virt(fixmap_idx);
-}
-
-static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
-{
-	int _idx = virt_to_fix((unsigned long)vaddr);
-
-	WARN_ON_ONCE(fixmap_idx != _idx);
-	clear_fixmap(fixmap_idx);
-}
-
 int ghes_estatus_pool_init(unsigned int num_ghes)
 {
 	unsigned long addr, len;
@@ -193,21 +173,6 @@ static void unmap_gen_v2(struct ghes *ghes)
 	apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
 }
 
-static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
-{
-	int rc;
-	u64 val = 0;
-
-	rc = apei_read(&val, &gv2->read_ack_register);
-	if (rc)
-		return;
-
-	val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
-	val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
-
-	apei_write(val, &gv2->read_ack_register);
-}
-
 struct ghes *ghes_new(struct acpi_hest_generic *generic)
 {
 	struct ghes *ghes;
@@ -280,137 +245,6 @@ static inline int ghes_severity(int severity)
 	}
 }
 
-static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
-				  int from_phys,
-				  enum fixed_addresses fixmap_idx)
-{
-	void __iomem *vaddr;
-	u64 offset;
-	u32 trunk;
-
-	while (len > 0) {
-		offset = paddr - (paddr & PAGE_MASK);
-		vaddr = ghes_map(PHYS_PFN(paddr), fixmap_idx);
-		trunk = PAGE_SIZE - offset;
-		trunk = min(trunk, len);
-		if (from_phys)
-			memcpy_fromio(buffer, vaddr + offset, trunk);
-		else
-			memcpy_toio(vaddr + offset, buffer, trunk);
-		len -= trunk;
-		paddr += trunk;
-		buffer += trunk;
-		ghes_unmap(vaddr, fixmap_idx);
-	}
-}
-
-/* Check the top-level record header has an appropriate size. */
-int __ghes_check_estatus(struct ghes *ghes,
-			 struct acpi_hest_generic_status *estatus)
-{
-	u32 len = cper_estatus_len(estatus);
-	u32 max_len = min(ghes->generic->error_block_length,
-			  ghes->estatus_length);
-
-	if (len < sizeof(*estatus)) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
-		return -EIO;
-	}
-
-	if (!len || len > max_len) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
-		return -EIO;
-	}
-
-	if (cper_estatus_check_header(estatus)) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/* Read the CPER block, returning its address, and header in estatus. */
-int __ghes_peek_estatus(struct ghes *ghes,
-			struct acpi_hest_generic_status *estatus,
-			u64 *buf_paddr, enum fixed_addresses fixmap_idx)
-{
-	struct acpi_hest_generic *g = ghes->generic;
-	int rc;
-
-	rc = apei_read(buf_paddr, &g->error_status_address);
-	if (rc) {
-		*buf_paddr = 0;
-		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Failed to read error status block address for hardware error source: %d.\n",
-				   g->header.source_id);
-		return -EIO;
-	}
-	if (!*buf_paddr)
-		return -ENOENT;
-
-	ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
-			      fixmap_idx);
-	if (!estatus->block_status) {
-		*buf_paddr = 0;
-		return -ENOENT;
-	}
-
-	return 0;
-}
-
-int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
-			u64 buf_paddr, enum fixed_addresses fixmap_idx,
-			size_t buf_len)
-{
-	ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
-	if (cper_estatus_check(estatus)) {
-		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Failed to read error status block!\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-int ghes_read_estatus(struct ghes *ghes,
-		      struct acpi_hest_generic_status *estatus,
-		      u64 *buf_paddr, enum fixed_addresses fixmap_idx)
-{
-	int rc;
-
-	rc = __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
-	if (rc)
-		return rc;
-
-	rc = __ghes_check_estatus(ghes, estatus);
-	if (rc)
-		return rc;
-
-	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
-				   cper_estatus_len(estatus));
-}
-
-void ghes_clear_estatus(struct ghes *ghes,
-			struct acpi_hest_generic_status *estatus,
-			u64 buf_paddr, enum fixed_addresses fixmap_idx)
-{
-	estatus->block_status = 0;
-
-	if (!buf_paddr)
-		return;
-
-	ghes_copy_tofrom_phys(estatus, buf_paddr,
-			      sizeof(estatus->block_status), 0,
-			      fixmap_idx);
-
-	/*
-	 * GHESv2 type HEST entries introduce support for error acknowledgment,
-	 * so only acknowledge the error if this support is present.
-	 */
-	if (is_hest_type_generic_v2(ghes))
-		ghes_ack_error(ghes->generic_v2);
-}
 
 /**
  * struct ghes_task_work - for synchronous RAS event
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
new file mode 100644
index 000000000000..0c3f52b2d7f1
--- /dev/null
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Shared GHES helpers for firmware-first CPER error handling.
+ *
+ * This file holds the GHES helper code that is shared by the in-tree GHES
+ * driver and by other firmware-first error sources that reuse the same CPER
+ * handling flow.
+ *
+ * Derived from the ACPI APEI GHES driver.
+ *
+ * Copyright 2010,2011 Intel Corp.
+ *   Author: Huang Ying <ying.huang@intel.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/ratelimit.h>
+#include <linux/slab.h>
+
+#include <acpi/apei.h>
+#include <acpi/acpi_io.h>
+#include <acpi/ghes_cper.h>
+
+#include <asm/fixmap.h>
+#include <asm/tlbflush.h>
+
+#include "apei-internal.h"
+
+static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
+{
+	phys_addr_t paddr;
+	pgprot_t prot;
+
+	paddr = PFN_PHYS(pfn);
+	prot = arch_apei_get_mem_attribute(paddr);
+	__set_fixmap(fixmap_idx, paddr, prot);
+
+	return (void __iomem *) __fix_to_virt(fixmap_idx);
+}
+
+static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
+{
+	int _idx = virt_to_fix((unsigned long)vaddr);
+
+	WARN_ON_ONCE(fixmap_idx != _idx);
+	clear_fixmap(fixmap_idx);
+}
+
+static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
+{
+	int rc;
+	u64 val = 0;
+
+	rc = apei_read(&val, &gv2->read_ack_register);
+	if (rc)
+		return;
+
+	val &= gv2->read_ack_preserve;
+	val |= gv2->read_ack_write;
+
+	apei_write(val, &gv2->read_ack_register);
+}
+
+static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
+				  int from_phys,
+				  enum fixed_addresses fixmap_idx)
+{
+	void __iomem *vaddr;
+	u64 offset;
+	u32 trunk;
+
+	while (len > 0) {
+		offset = paddr - (paddr & PAGE_MASK);
+		vaddr = ghes_map(PHYS_PFN(paddr), fixmap_idx);
+		trunk = PAGE_SIZE - offset;
+		trunk = min(trunk, len);
+		if (from_phys)
+			memcpy_fromio(buffer, vaddr + offset, trunk);
+		else
+			memcpy_toio(vaddr + offset, buffer, trunk);
+		len -= trunk;
+		paddr += trunk;
+		buffer += trunk;
+		ghes_unmap(vaddr, fixmap_idx);
+	}
+}
+
+/* Check the top-level record header has an appropriate size. */
+int __ghes_check_estatus(struct ghes *ghes,
+			 struct acpi_hest_generic_status *estatus)
+{
+	u32 len = cper_estatus_len(estatus);
+	u32 max_len = min(ghes->generic->error_block_length,
+			  ghes->estatus_length);
+
+	if (len < sizeof(*estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
+		return -EIO;
+	}
+
+	if (len > max_len) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
+		return -EIO;
+	}
+
+	if (cper_estatus_check_header(estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Read the CPER block, returning its address, and header in estatus. */
+int __ghes_peek_estatus(struct ghes *ghes,
+			struct acpi_hest_generic_status *estatus,
+			u64 *buf_paddr, enum fixed_addresses fixmap_idx)
+{
+	struct acpi_hest_generic *g = ghes->generic;
+	int rc;
+
+	rc = apei_read(buf_paddr, &g->error_status_address);
+	if (rc) {
+		*buf_paddr = 0;
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+				    "Failed to read error status block address for hardware error source: %d.\n",
+				    g->header.source_id);
+		return -EIO;
+	}
+	if (!*buf_paddr)
+		return -ENOENT;
+
+	ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
+			      fixmap_idx);
+	if (!estatus->block_status) {
+		*buf_paddr = 0;
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
+			u64 buf_paddr, enum fixed_addresses fixmap_idx,
+			size_t buf_len)
+{
+	u32 len;
+
+	ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
+
+	len = cper_estatus_len(estatus);
+	if (len < sizeof(*estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
+		return -EIO;
+	}
+
+	if (len > buf_len) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
+		return -EIO;
+	}
+
+	if (cper_estatus_check(estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+				    "Failed to read error status block!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int ghes_read_estatus(struct ghes *ghes,
+		      struct acpi_hest_generic_status *estatus,
+		      u64 *buf_paddr, enum fixed_addresses fixmap_idx)
+{
+	int rc;
+
+	rc = __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
+	if (rc)
+		return rc;
+
+	rc = __ghes_check_estatus(ghes, estatus);
+	if (rc)
+		return rc;
+
+	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
+				   cper_estatus_len(estatus));
+}
+
+void ghes_clear_estatus(struct ghes *ghes,
+			struct acpi_hest_generic_status *estatus,
+			u64 buf_paddr, enum fixed_addresses fixmap_idx)
+{
+	estatus->block_status = 0;
+
+	if (!buf_paddr)
+		return;
+
+	ghes_copy_tofrom_phys(estatus, buf_paddr,
+			      sizeof(estatus->block_status), 0,
+			      fixmap_idx);
+
+	/*
+	 * GHESv2 type HEST entries introduce support for error acknowledgment,
+	 * so only acknowledge the error if this support is present.
+	 */
+	if (is_hest_type_generic_v2(ghes))
+		ghes_ack_error(ghes->generic_v2);
+}

-- 
2.43.0


