Return-Path: <linuxppc-dev+bounces-23853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01374C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:26:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ3s5DcJz30DZ;
	Thu, 09 Jul 2026 09:26:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519233;
	cv=none; b=XVDsq7jqqHcwTpvqNzvnsDYg1qjUC+4FrPWKMbmrMLRwR0sZE6v2biMf/BWTgBr7gldUd6VpnRoo3pHmsKkNOcBWj/w37JAprIvp3gyKeIUGonHNaBP7ZQXFkpMa0zhdlzl40QwobSmdbnS4p59cShWIONVtg795wqtuOjSNEZvsWGnZI5BhWNir2gyLTpvISqLV+iUmb+vyiq4DBpbrRMAOTB1DfOA9gmum2yIvbVO9uMJtRtTpTpAo/O8TTTpoGCzNm1bZGIaoVJticzu+KrrBjSA42LnZrZGbe6recBXmP9kFKrXs+WT1FZ0wIJUFr3KKnJw3Aw9wp9Vw0ujvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519233; c=relaxed/relaxed;
	bh=zJTtFNIcZ/JYT11Z5w+daYliKUsc9BYYLZ4eYRyTQ+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4oammXrU/cSeFD6uC7ymGpVSew2gg5O0NuQOvwKngfpaNOEaz5VWJ4JPrgUhPpGw0h0IoVAWrd+TiSDckYc71M7Q4+3+XSueeEM4DRsd+FH9WGQ62TAH4p92HFwm+Du+wugOUlDJbrCsrhTkOomBEXQ/HFuLEZ2UBfilXFnOGie3FPHCglKM1SnNNkZxXJSKCl82rhDW+Dp2HyFNHoDOrOevpBVMvH1+7RkITjiCeRaEsknvwdoOfDYE1zAq49dLoW5OGQdCpr9JYSA9UIqQ+CMa0l6gkBXmfHfHt1RgzcuSu8h1tUucGPXAjJpm37b7DCQGKPCmBw303+te3vM6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aYBKu5q1; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aYBKu5q1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKVm1Ws4z3054
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:00:32 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BB0127B5;
	Wed,  8 Jul 2026 06:59:55 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F26B63F66F;
	Wed,  8 Jul 2026 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519199; bh=249EtbQ7QOZ8d9nrBtZms9AGdeTNWz6CuHB9NoFCBL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aYBKu5q1ZGzBbLbUD6eFTsT+kIys+fFE8lNVtvxqPcxceefeUXpp0XfhCUAiDBiy2
	 OW4l1XyGVzo8AxP+5v5nZbZH/wO//Fqe+MozqNq1gqtMwa98bWOX/L/RJ2y9+du5eg
	 jmTd7pOvIzkgwKi3bI14l4ykBRam3FzOYEm7eztg=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 08 Jul 2026 14:59:06 +0100
Subject: [PATCH v7 07/10] ACPI: APEI: introduce GHES helper
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
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-7-8b3a85216cef@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=4358;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=249EtbQ7QOZ8d9nrBtZms9AGdeTNWz6CuHB9NoFCBL8=;
 b=Hh7Cwgsu/GxcgF7FSBqagmnecpwTKJSvE+I+dn9hLAV+0f/R9bPSpvxcUsWj7r2T7mPhRTGUK
 lnfF/0IEYPUBWaduGNOHponvxh/0t91V3OTU0QQPEWa0QtgCQvYp1Bp
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Add a dedicated GHES_CPER_HELPERS Kconfig entry so the shared helper code
can be built even when ACPI_APEI_GHES is disabled. Update the build glue
and headers to depend on the new symbol.

Include asm/acpi.h in cper-x86.c to provide arch_apei_report_x86_error()
declaration in ACPI-disabled builds.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/Makefile                |  1 +
 drivers/acpi/Kconfig            |  4 ++++
 drivers/acpi/apei/Kconfig       |  1 +
 drivers/acpi/apei/Makefile      |  2 +-
 drivers/firmware/efi/cper-x86.c |  1 +
 include/acpi/ghes.h             | 10 ++++++----
 include/cxl/event.h             |  2 +-
 7 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 0841ea851847..27a664cb45ea 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -31,6 +31,7 @@ obj-y				+= idle/
 obj-y				+= char/ipmi/
 
 obj-$(CONFIG_ACPI)		+= acpi/
+obj-$(CONFIG_GHES_CPER_HELPERS)	+= acpi/apei/ghes_cper.o
 
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..13ef0e99f840 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,6 +6,10 @@
 config ARCH_SUPPORTS_ACPI
 	bool
 
+config GHES_CPER_HELPERS
+	bool
+	select UEFI_CPER
+
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on ARCH_SUPPORTS_ACPI
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 428458c623f0..ddb62638eb02 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -21,6 +21,7 @@ config ACPI_APEI_GHES
 	bool "APEI Generic Hardware Error Source"
 	depends on ACPI_APEI
 	select ACPI_HED
+	select GHES_CPER_HELPERS
 	select IRQ_WORK
 	select GENERIC_ALLOCATOR
 	select ARM_SDE_INTERFACE if ARM64
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index f57f3b009d8e..66588d6be56f 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
-obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o ghes_cper.o
+obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
 # clang versions prior to 18 may blow out the stack with KASAN
 ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
 KASAN_SANITIZE_ghes.o := n
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 3949d7b5e808..aa9388284e65 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -3,6 +3,7 @@
 
 #include <linux/cper.h>
 #include <linux/acpi.h>
+#include <asm/acpi.h>
 
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8d7e5caef3f1..2ffab36b6154 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -83,15 +83,17 @@ int devm_ghes_register_vendor_record_notifier(struct device *dev,
 					      struct notifier_block *nb);
 
 struct list_head *ghes_get_devices(void);
-
-void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
-
-static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) { return; }
 #endif
 
+#ifdef CONFIG_GHES_CPER_HELPERS
 int ghes_estatus_pool_init(unsigned int num_ghes);
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
+#else
+static inline int ghes_estatus_pool_init(unsigned int num_ghes) { return -ENODEV; }
+static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) { }
+#endif
 
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
 {
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ff97fea718d2..2ebd65b0d9d6 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -285,7 +285,7 @@ struct cxl_cper_prot_err_work_data {
 	int severity;
 };
 
-#ifdef CONFIG_ACPI_APEI_GHES
+#ifdef CONFIG_GHES_CPER_HELPERS
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);

-- 
2.43.0


