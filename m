Return-Path: <linuxppc-dev+bounces-23847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0E7C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:25:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ2k6K4sz309r;
	Thu, 09 Jul 2026 09:25:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519200;
	cv=none; b=WITHhGoKwcSS+VuLsZm3X8RzQb4kMquynXfwBwcEF5kK8pq1ncp2c99cMuvPiFycUJkKainp+LkdCjVa67LEUrMQUHI868ZX4rJzJTnJcseferDSyrSzGRk51eZLAuU2zHqt1lri16tJ/xBLQKK7h2yFLQokyvgXyLeZUB6TWaCWZSTmpZ1uiltkwoEpbwFTDFMfgaCShjcOFXCqYGCXL7M/oFSIC/CdvjkhLMSHYueED3/D/ovdFgZDWZe3mn2h61Uu2xhgsftm4r557oy2LQ3hTM6Kwr66WoNzot91ib+zRiRSYgUUsLvCf9whhfd6nSQiITpjFFRC9SKG56dMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519200; c=relaxed/relaxed;
	bh=SeWVr29tMb6Zni5dqSMeOV+bGz3Z+Cg3xtabArwRl+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eToyCcwwD10HpNPfidBcfpq/L+8URglWAIMs+mO9eNVHEC8qTzLx5pUkqBJPS9Bg+j15f1EVeYDB0tGTfHbw+YTd3zOiJ7HBQwUswDn0AvoY6z4KBGhVHwUwgAVAIfdqfJCQAqIVncAza5Sh29Ga8SUPHpZ8/AshBUyRnL9Ph2gv+i1mPnwKKZbiWzvPRPIc64P9Ch54vUP6J8fHFfg936bN4I2J44ypV9AXAvug2ZS4MNksMrCWmRqVph4Lp3OzJ5SZoqL56yI1S4GS5gZZY4ntU86H2VY3TUtAxEqmeNmW0LVrkqm/4ZSYhPw3zjVpbPWRVWdr+NCxkEdiIM0SFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qa+A/j8n; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qa+A/j8n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKV74ntHz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 23:59:59 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C2E81D14;
	Wed,  8 Jul 2026 06:59:24 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F0B3F66F;
	Wed,  8 Jul 2026 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519168; bh=/yxjkgVJ8COe69BpZmMcew2K/FPoTQigEm8dy9Gg2zI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qa+A/j8nKEOiWra4XWUiblG5Pj3JyTXgwdIRtpMbEOeQ3/RUYTrW06IzNbzjTeGvI
	 r8gkJagpGuqGnHq+xXtdnvjW8BVpIp0dhjFLy1aTXHIPRRwkKX3BPETbCq8p2o5lL1
	 6FaUD1LLfzGgYXEFvj37Gj3CzjTMfoLT2+J4IEOc=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 08 Jul 2026 14:59:00 +0100
Subject: [PATCH v7 01/10] ACPI: APEI: GHES: share macros via a private
 header
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
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-1-8b3a85216cef@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=11357;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=/yxjkgVJ8COe69BpZmMcew2K/FPoTQigEm8dy9Gg2zI=;
 b=F+Ba+FoQnCQQIgAIDGmSYxCRQDUI2pjbjVP89eZzqRer7HheF2jTlhC8+oUiVPmI9xotUFm/Q
 AJ/CASEq1lVBpVMLiW9EMXMufpSDxtGzJTEawnH/HKNNVnhKvI7/Zqs
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Carve the CPER helper macros out of ghes.c and place them in a private
header so they can be shared with upcoming helper files.

Move the vendor record entry declaration and the prototypes for the CPER
read and clear helpers along with ghes_new() and ghes_fini() into the
same header. This requires dropping their local static visibility in
ghes.c.

Also synchronize ghes_proc_irq_work during ghes_remove()
to avoid a use-after-free.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c |  95 +++++++++----------------------------------
 include/acpi/ghes_cper.h | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 76 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..c73a316644e8 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -49,6 +49,7 @@
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
+#include <acpi/ghes_cper.h>
 #include <acpi/apei.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
@@ -57,40 +58,6 @@
 
 #include "apei-internal.h"
 
-#define GHES_PFX	"GHES: "
-
-#define GHES_ESTATUS_MAX_SIZE		65536
-#define GHES_ESOURCE_PREALLOC_MAX_SIZE	65536
-
-#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
-
-/* This is just an estimation for memory pool allocation */
-#define GHES_ESTATUS_CACHE_AVG_SIZE	512
-
-#define GHES_ESTATUS_CACHES_SIZE	4
-
-#define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
-/* Prevent too many caches are allocated because of RCU */
-#define GHES_ESTATUS_CACHE_ALLOCED_MAX	(GHES_ESTATUS_CACHES_SIZE * 3 / 2)
-
-#define GHES_ESTATUS_CACHE_LEN(estatus_len)			\
-	(sizeof(struct ghes_estatus_cache) + (estatus_len))
-#define GHES_ESTATUS_FROM_CACHE(estatus_cache)			\
-	((struct acpi_hest_generic_status *)				\
-	 ((struct ghes_estatus_cache *)(estatus_cache) + 1))
-
-#define GHES_ESTATUS_NODE_LEN(estatus_len)			\
-	(sizeof(struct ghes_estatus_node) + (estatus_len))
-#define GHES_ESTATUS_FROM_NODE(estatus_node)			\
-	((struct acpi_hest_generic_status *)				\
-	 ((struct ghes_estatus_node *)(estatus_node) + 1))
-
-#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
-	(sizeof(struct ghes_vendor_record_entry) + (gdata_len))
-#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
-	((struct acpi_hest_generic_data *)                              \
-	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
-
 /*
  *  NMI-like notifications vary by architecture, before the compiler can prune
  *  unused static functions it needs a value for these enums.
@@ -102,25 +69,6 @@
 
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
-static inline bool is_hest_type_generic_v2(struct ghes *ghes)
-{
-	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
-}
-
-/*
- * A platform may describe one error source for the handling of synchronous
- * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
- * or External Interrupt). On x86, the HEST notifications are always
- * asynchronous, so only SEA on ARM is delivered as a synchronous
- * notification.
- */
-static inline bool is_hest_sync_notify(struct ghes *ghes)
-{
-	u8 notify_type = ghes->generic->notify.type;
-
-	return notify_type == ACPI_HEST_NOTIFY_SEA;
-}
-
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -165,12 +113,6 @@ static DEFINE_MUTEX(ghes_devs_mutex);
  */
 static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
-struct ghes_vendor_record_entry {
-	struct work_struct work;
-	int error_severity;
-	char vendor_record[];
-};
-
 static struct gen_pool *ghes_estatus_pool;
 
 static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
@@ -266,7 +208,7 @@ static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 	apei_write(val, &gv2->read_ack_register);
 }
 
-static struct ghes *ghes_new(struct acpi_hest_generic *generic)
+struct ghes *ghes_new(struct acpi_hest_generic *generic)
 {
 	struct ghes *ghes;
 	unsigned int error_block_length;
@@ -313,7 +255,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 	return ERR_PTR(rc);
 }
 
-static void ghes_fini(struct ghes *ghes)
+void ghes_fini(struct ghes *ghes)
 {
 	kfree(ghes->estatus);
 	apei_unmap_generic_address(&ghes->generic->error_status_address);
@@ -363,8 +305,8 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 }
 
 /* Check the top-level record header has an appropriate size. */
-static int __ghes_check_estatus(struct ghes *ghes,
-				struct acpi_hest_generic_status *estatus)
+int __ghes_check_estatus(struct ghes *ghes,
+			 struct acpi_hest_generic_status *estatus)
 {
 	u32 len = cper_estatus_len(estatus);
 	u32 max_len = min(ghes->generic->error_block_length,
@@ -389,9 +331,9 @@ static int __ghes_check_estatus(struct ghes *ghes,
 }
 
 /* Read the CPER block, returning its address, and header in estatus. */
-static int __ghes_peek_estatus(struct ghes *ghes,
-			       struct acpi_hest_generic_status *estatus,
-			       u64 *buf_paddr, enum fixed_addresses fixmap_idx)
+int __ghes_peek_estatus(struct ghes *ghes,
+			struct acpi_hest_generic_status *estatus,
+			u64 *buf_paddr, enum fixed_addresses fixmap_idx)
 {
 	struct acpi_hest_generic *g = ghes->generic;
 	int rc;
@@ -400,7 +342,7 @@ static int __ghes_peek_estatus(struct ghes *ghes,
 	if (rc) {
 		*buf_paddr = 0;
 		pr_warn_ratelimited(FW_WARN GHES_PFX
-"Failed to read error status block address for hardware error source: %d.\n",
+				    "Failed to read error status block address for hardware error source: %d.\n",
 				   g->header.source_id);
 		return -EIO;
 	}
@@ -417,9 +359,9 @@ static int __ghes_peek_estatus(struct ghes *ghes,
 	return 0;
 }
 
-static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
-			       u64 buf_paddr, enum fixed_addresses fixmap_idx,
-			       size_t buf_len)
+int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
+			u64 buf_paddr, enum fixed_addresses fixmap_idx,
+			size_t buf_len)
 {
 	ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
 	if (cper_estatus_check(estatus)) {
@@ -431,9 +373,9 @@ static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
 	return 0;
 }
 
-static int ghes_read_estatus(struct ghes *ghes,
-			     struct acpi_hest_generic_status *estatus,
-			     u64 *buf_paddr, enum fixed_addresses fixmap_idx)
+int ghes_read_estatus(struct ghes *ghes,
+		      struct acpi_hest_generic_status *estatus,
+		      u64 *buf_paddr, enum fixed_addresses fixmap_idx)
 {
 	int rc;
 
@@ -449,9 +391,9 @@ static int ghes_read_estatus(struct ghes *ghes,
 				   cper_estatus_len(estatus));
 }
 
-static void ghes_clear_estatus(struct ghes *ghes,
-			       struct acpi_hest_generic_status *estatus,
-			       u64 buf_paddr, enum fixed_addresses fixmap_idx)
+void ghes_clear_estatus(struct ghes *ghes,
+			struct acpi_hest_generic_status *estatus,
+			u64 buf_paddr, enum fixed_addresses fixmap_idx)
 {
 	estatus->block_status = 0;
 
@@ -1852,6 +1794,7 @@ static void ghes_remove(struct platform_device *ghes_dev)
 		break;
 	}
 
+	irq_work_sync(&ghes_proc_irq_work);
 	ghes_fini(ghes);
 
 	mutex_lock(&ghes_devs_mutex);
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
new file mode 100644
index 000000000000..4649e3140888
--- /dev/null
+++ b/include/acpi/ghes_cper.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * GHES declarations used by both the ACPI APEI GHES driver
+ * and the firmware-first CPER provider.
+ *
+ * These declarations lets GHES and other firmware-first error sources use
+ * the same helper so the non-ACPI path follows the same
+ * behavior as GHES instead of carrying a separate copy.
+ *
+ * Derived from the ACPI APEI GHES driver.
+ *
+ * Copyright 2010,2011 Intel Corp.
+ *   Author: Huang Ying <ying.huang@intel.com>
+ */
+
+#ifndef ACPI_APEI_GHES_CPER_H
+#define ACPI_APEI_GHES_CPER_H
+
+#include <linux/workqueue.h>
+
+#include <acpi/ghes.h>
+#include <asm/fixmap.h>
+
+#define GHES_PFX	"GHES: "
+
+#define GHES_ESTATUS_MAX_SIZE		65536
+#define GHES_ESOURCE_PREALLOC_MAX_SIZE	65536
+
+#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
+
+/* This is just an estimation for memory pool allocation */
+#define GHES_ESTATUS_CACHE_AVG_SIZE	512
+
+#define GHES_ESTATUS_CACHES_SIZE	4
+
+#define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
+/* Prevent too many caches are allocated because of RCU */
+#define GHES_ESTATUS_CACHE_ALLOCED_MAX	(GHES_ESTATUS_CACHES_SIZE * 3 / 2)
+
+#define GHES_ESTATUS_CACHE_LEN(estatus_len)			\
+	(sizeof(struct ghes_estatus_cache) + (estatus_len))
+#define GHES_ESTATUS_FROM_CACHE(estatus_cache)			\
+	((struct acpi_hest_generic_status *)				\
+	 ((struct ghes_estatus_cache *)(estatus_cache) + 1))
+
+#define GHES_ESTATUS_NODE_LEN(estatus_len)			\
+	(sizeof(struct ghes_estatus_node) + (estatus_len))
+#define GHES_ESTATUS_FROM_NODE(estatus_node)			\
+	((struct acpi_hest_generic_status *)				\
+	 ((struct ghes_estatus_node *)(estatus_node) + 1))
+
+#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
+	(sizeof(struct ghes_vendor_record_entry) + (gdata_len))
+#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
+	((struct acpi_hest_generic_data *)                              \
+	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
+
+static inline bool is_hest_type_generic_v2(struct ghes *ghes)
+{
+	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
+}
+
+/*
+ * A platform may describe one error source for the handling of synchronous
+ * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
+ * or External Interrupt). On x86, the HEST notifications are always
+ * asynchronous, so only SEA on ARM is delivered as a synchronous
+ * notification.
+ */
+static inline bool is_hest_sync_notify(struct ghes *ghes)
+{
+	u8 notify_type = ghes->generic->notify.type;
+
+	return notify_type == ACPI_HEST_NOTIFY_SEA;
+}
+
+struct ghes_vendor_record_entry {
+	struct work_struct work;
+	int error_severity;
+	char vendor_record[];
+};
+
+#ifdef CONFIG_ACPI_APEI
+struct ghes *ghes_new(struct acpi_hest_generic *generic);
+void ghes_fini(struct ghes *ghes);
+
+int ghes_read_estatus(struct ghes *ghes,
+		      struct acpi_hest_generic_status *estatus,
+		      u64 *buf_paddr, enum fixed_addresses fixmap_idx);
+void ghes_clear_estatus(struct ghes *ghes,
+			struct acpi_hest_generic_status *estatus,
+			u64 buf_paddr, enum fixed_addresses fixmap_idx);
+int __ghes_peek_estatus(struct ghes *ghes,
+			struct acpi_hest_generic_status *estatus,
+			u64 *buf_paddr, enum fixed_addresses fixmap_idx);
+int __ghes_check_estatus(struct ghes *ghes,
+			 struct acpi_hest_generic_status *estatus);
+int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
+			u64 buf_paddr, enum fixed_addresses fixmap_idx,
+			size_t buf_len);
+#endif
+
+#endif /* ACPI_APEI_GHES_CPER_H */

-- 
2.43.0


