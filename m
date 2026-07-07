Return-Path: <linuxppc-dev+bounces-23705-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1AFC43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:03:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvjcg1nG5z2xWY;
	Wed, 08 Jul 2026 00:03:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783433011;
	cv=none; b=SCgKuwS5Qp/sPJHukvDO/2kmJHWxqzSxeaTZb6kVivwGDy6Xl13N87EoBBhcvJCCo0aSODMXQEN8FWlY1cHntl65+hevDsFpy6EF1v4uaglAQ2JBTqtHFRXsaNxDs1SN6jnvAFsN/hJu5/oFJA+hI8oK/rG1P2pyFExHGMhyjqwTfltZDRe5WhF9k9c8E5oTLCr2LtKcz1Gaf1nMC36MWG3C9rf4FSE4C32qsJ9bh6+L0w9PrG3cmsVLp2oL7bxo+fapMrSZObGZHej6W3KYHysGUHzckWbRfvyC3sJL/OcSVb7KVq3ihNGDTCy7srDBpsY6I+XBcu2sluJ6ZID9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783433011; c=relaxed/relaxed;
	bh=cFiofcD+EMXffQMDr301OcMG5BuuLyYnzpBG7vHXm/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A+0wSRgu2J2TwfZ5RPnNrxRA3oVlBh3LizOivNsA05KZMEZMg1436iMkLYu1Z/qO9ARUyeTpzE8ZeVGNQajHQo88b+ARIj4nNmw/Y+1ijZUA7AWh2lp7daICoLcuUYWc5oUWP/LDtRo9k29Huawfct13xgzwjvtpnXrsx4BEkOmSiwBThJW+v7eFNM7TA+He37qJ+cSSYwk5iU1U18zH/53ui2ylJWAQfTdNFJoqUxN2gZ86kjuqzhqYFU5dVsSfqhIbkt++vEF/Mnxkt8IhSAd7Z6lfJ++Yx1PBOq3B33mK6QQvCauwAq78Qa4HLeqD0HFp/DKzvw0Vrje+IUV5PQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=b3Hv5XXb; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=b3Hv5XXb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvjcd2j0Xz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 00:03:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=cFiofcD+EMXffQMDr301OcMG5BuuLyYnzpBG7vHXm/4=; b=b3Hv5XXbIwrMeMw7O7qsT0wvDG
	P/mogf9Q/8irb8Ojv5aXYdWdVtDIpQmJZSCaqigSVn/D1yC4Xe0UH/uK6STj4pI9+KW7jU7MR1Gk1
	SSEKm6QJmO+SycyD+u8JFpJ78vgTvIUv38JRvOfjcVJ+xygvQjYMYV0EkunogqJDWjEGHRFnAmbnj
	/ckdwrt/3xabzeD8kUXWy8nHlIQgSYkWEVr+eVmvRgVaZu/gIbhAJuDorMg9aNHAldP+6INrsW9lE
	nexryKU/P5e73KDF8Tih70fpOLZ7Sa06KYft4DHjUHALsIZlQHJ0YqaMDI7RdkqNAFrIBGCwm68vN
	yGc/o3YQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh6No-002Eqp-2T;
	Tue, 07 Jul 2026 14:02:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 07 Jul 2026 07:02:34 -0700
Subject: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware error
 tracking out of vmcoreinfo
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
Message-Id: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
X-B4-Tracking: v=1; b=H4sIAPoGTWoC/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjMwM7LUzShPLSrSLUos1k01MjMzM7E0Mks2tVDSUVAqKEpNy6wAmxW
 tFOTmrBRbWwsAmo28R2AAAAA=
X-Change-ID: 20260629-hwerr-ras-e26664926c58
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Breno Leitao <leitao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-pci@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=9453; i=leitao@debian.org;
 h=from:subject:message-id; bh=+HFvUXO/TKduc/+1aKAay7FhER/2toYf8ISyOgmTxzw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTQb+unZrlzHUltM9YWtB1pfwsG5kzA7FdZ4sm
 aXTm5HuduiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak0G/gAKCRA1o5Of/Hh3
 beOFD/9h12Jsz4beYkelAgHWozexcm7gkQvDaFrr2h30Fr6kxsuMBRP5MQF3A9aLKrJTES/o8kC
 kFbnFXmY/q8avmFdOQ+ItYPZVCULHwduqb06qpt3becyaG0H4C7m45UzR2KPRb3IN8WIo4O5IhI
 wHGdtQ8QLYlD1OumzfoLZqmT76XYFjXxvSikdFO/Hcev7zmUbJK+uk3ZjRit9VNiQNYZ98OkJcA
 S5z/LfAWvpfWYLmWwcwRSr5pI7RpNeBAgmAewZHVbC0LvYZmuuBA49QVc8XQzvtdf1w0dR9zL3e
 27gxJ7CjSq10PvAoniZvrvaQc+qYD9YkqVsT2HA2SrCtSsPwOmk9CDTMUtmlN+OcqeaHiop8Jbn
 qkxhtiVKTOOzczhp69cOcKaXGpWc7vY9wVHa2SaQw2lJbTTpv4Ao2haxrqQFg+iy0bv0dDPqsSP
 xty3PiisZB1/2vENe33YEh+8es78EHzv/+Xcil/tDwIWqmkuiW1mF9W8zTisCXH8HB7+LeGzs49
 1ByUa1RDW3CdgXGFgLEWJKa0YGponuqlaY6A0c7JbWXbv5iGbMAIWbMOhsdDpARLYbk0RGKzXXy
 Qe3OKzailwDVlZsAdHavbE4ah3LkV3hZ/nC5he4JwFHo5Dd5uoy3aQokKm+uzr+J6/TqHpZT8dY
 vIFi6HqUN2gNTfw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The recoverable hardware error tracking (hwerr_log_error_type() and the
hwerr_data[] counters) was added under vmcoreinfo, but it uses none of the
vmcoreinfo note machinery: hwerr_data[] is a plain global array that crash
tools read from the vmcore by symbol, like any other global.  Functionally
it is RAS code, fed only by the hardware error paths (x86 MCE, APEI GHES
and PCIe AER).

I wanted to expand it, and Baoquan suggested moving it away from vmcore
info, which makes sense. [1]

Move the implementation to drivers/ras/hwerr_tracking.c and the
declaration (with its no-op stub) to <linux/ras.h>.  Give it a dedicated
CONFIG_RAS_HWERR (bool, under RAS, default y) rather than riding
CONFIG_VMCORE_INFO, so it is a first-class RAS feature that can be turned
off on its own.  The producers now reach hwerr_log_error_type() through
<linux/ras.h>: x86 MCE and APEI GHES already include it, so drop their
<linux/vmcore_info.h> include; PCIe AER switches its include from
<linux/vmcore_info.h> to <linux/ras.h>.

enum hwerr_error_type stays in <uapi/linux/vmcore.h> as it has been part
of the UAPI since the feature shipped; <linux/ras.h> includes it from
there.

hwerr_data[] keeps its name and layout, so existing crash/drgn recipes
keep working.  The config gate moves from CONFIG_VMCORE_INFO to
CONFIG_RAS_HWERR (default y).

Link: https://lore.kernel.org/all/aYvi4Y_HNqk_u1-v@fedora/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Once we move it outside of vmcore info, I am planning to add new
features that are in the limbo now, given they don't belong to vmcore
info, such as:

Track fatal hardware errors
	https://lore.kernel.org/all/20260617-hwerr-v1-0-ff131cd6203c@debian.org/

Expose hardware error recovery statistics via sysfs
	https://lore.kernel.org/all/20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org/
---
 MAINTAINERS                    |  7 +++++++
 arch/x86/kernel/cpu/mce/core.c |  1 -
 drivers/acpi/apei/ghes.c       |  1 -
 drivers/pci/pcie/aer.c         |  2 +-
 drivers/ras/Kconfig            | 12 ++++++++++++
 drivers/ras/Makefile           |  1 +
 drivers/ras/hwerr_tracking.c   | 35 +++++++++++++++++++++++++++++++++++
 include/linux/ras.h            |  7 +++++++
 include/linux/vmcore_info.h    |  7 -------
 kernel/vmcore_info.c           | 21 ---------------------
 10 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1705eb823dd00..356a51032e4b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22539,6 +22539,13 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/ras/amd/fmpm.c
 
+RAS RECOVERABLE HARDWARE ERROR TRACKING
+M:	Breno Leitao <leitao@kernel.org>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	Documentation/driver-api/hw-recoverable-errors.rst
+F:	drivers/ras/hwerr_tracking.c
+
 RASPBERRY PI PISP BACK END
 M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
 R:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9bba1e2f03af7..58f1d7a601883 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -45,7 +45,6 @@
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
 #include <linux/kexec.h>
-#include <linux/vmcore_info.h>
 
 #include <asm/fred.h>
 #include <asm/cpu_device_id.h>
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6b..4b6666bc19c77 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -45,7 +45,6 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
-#include <linux/vmcore_info.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a548..00cdca26a5114 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -30,7 +30,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
-#include <linux/vmcore_info.h>
+#include <linux/ras.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c6..241642679c1f1 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -34,6 +34,18 @@ if RAS
 source "arch/x86/ras/Kconfig"
 source "drivers/ras/amd/atl/Kconfig"
 
+config RAS_HWERR
+	bool "Track hardware errors for crash analysis"
+	default y
+	help
+	  Record the count and timestamp of the most recent recoverable
+	  hardware error for each source (CPU, memory, PCI, CXL, ...).  The
+	  data is written at runtime and read post-mortem from a vmcore by
+	  tools such as crash or drgn, to correlate recoverable errors with a
+	  later panic.
+
+	  If unsure, say Y.
+
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
 	default m
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 11f95d59d3972..4217bee75d910 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_RAS)	+= ras.o
+obj-$(CONFIG_RAS_HWERR)	+= hwerr_tracking.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
 
diff --git a/drivers/ras/hwerr_tracking.c b/drivers/ras/hwerr_tracking.c
new file mode 100644
index 0000000000000..847c01fb24d55
--- /dev/null
+++ b/drivers/ras/hwerr_tracking.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Track recoverable hardware errors (visible to the OS but not fatal) so that
+ * crash tools like crash/drgn can read the count and timestamp of the last
+ * occurrence from a vmcore and correlate them with a subsequent panic.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates
+ * Copyright (c) 2026 Breno Leitao <leitao@kernel.org>
+ */
+
+#include <linux/atomic.h>
+#include <linux/export.h>
+#include <linux/ras.h>
+#include <linux/timekeeping.h>
+
+struct hwerr_info {
+	atomic_t count;
+	time64_t timestamp;
+};
+
+/*
+ * Keep hwerr_data[] at global scope so it stays accessible from the vmcore
+ * (via crash/drgn) even when Link Time Optimization (LTO) is enabled.
+ */
+struct hwerr_info hwerr_data[HWERR_RECOV_MAX];
+
+void hwerr_log_error_type(enum hwerr_error_type src)
+{
+	if (src < 0 || src >= HWERR_RECOV_MAX)
+		return;
+
+	atomic_inc(&hwerr_data[src].count);
+	WRITE_ONCE(hwerr_data[src].timestamp, ktime_get_real_seconds());
+}
+EXPORT_SYMBOL_GPL(hwerr_log_error_type);
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 468941bfe855f..1019183c00342 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -5,6 +5,7 @@
 #include <asm/errno.h>
 #include <linux/uuid.h>
 #include <linux/cper.h>
+#include <uapi/linux/vmcore.h>
 
 #ifdef CONFIG_DEBUG_FS
 int ras_userspace_consumers(void);
@@ -35,6 +36,12 @@ static inline void
 log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 
+#ifdef CONFIG_RAS_HWERR
+void hwerr_log_error_type(enum hwerr_error_type src);
+#else
+static inline void hwerr_log_error_type(enum hwerr_error_type src) { }
+#endif
+
 struct atl_err {
 	u64 addr;
 	u64 ipid;
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index e71518caacdfc..fb6f29b7202e3 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -5,7 +5,6 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
-#include <uapi/linux/vmcore.h>
 
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
@@ -79,10 +78,4 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
 
-#ifdef CONFIG_VMCORE_INFO
-void hwerr_log_error_type(enum hwerr_error_type src);
-#else
-static inline void hwerr_log_error_type(enum hwerr_error_type src) {};
-#endif
-
 #endif /* LINUX_VMCORE_INFO_H */
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 8614430ca212a..5c288796bdbf5 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -29,17 +29,6 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
-struct hwerr_info {
-	atomic_t count;
-	time64_t timestamp;
-};
-
-/*
- * The hwerr_data[] array is declared with global scope so that it remains
- * accessible to vmcoreinfo even when Link Time Optimization (LTO) is enabled.
- */
-struct hwerr_info hwerr_data[HWERR_RECOV_MAX];
-
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
@@ -127,16 +116,6 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 }
 EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
-void hwerr_log_error_type(enum hwerr_error_type src)
-{
-	if (src < 0 || src >= HWERR_RECOV_MAX)
-		return;
-
-	atomic_inc(&hwerr_data[src].count);
-	WRITE_ONCE(hwerr_data[src].timestamp, ktime_get_real_seconds());
-}
-EXPORT_SYMBOL_GPL(hwerr_log_error_type);
-
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	int order;

---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260629-hwerr-ras-e26664926c58

Best regards,
--  
Breno Leitao <leitao@debian.org>


