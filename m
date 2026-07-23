Return-Path: <linuxppc-dev+bounces-24740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04135C531CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Wkx2HmWz2yx7;
	Thu, 23 Jul 2026 23:12:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784812377;
	cv=none; b=CIBNYJGGHhuJCSaalSyc67qU55IbKykk0LgkoUtG6ojfFI0l1isfAvUuIEdcjoTEzIXBAUQujBsa/17zjZhmYZzxTmgE02+D+HI9jY6O1BLa+kBavWRNIev/V5knUZjL25kA74WhbXPK85L3mjPtbOXwv4p/fSgu25mViCjiSHrffZiv97IgjCvrJV/wKhagG3rZ06ZJ+nxE4WSX5gGJUf3ZzGd+UatNEVTTFcuihJrMdga2SIu27mrq8D1aSbUO8gKMeJoheX7+QCYfi3slTznh8NK+/UGzMLYlnXWpW/UK0BLkB4sToIzCbJNcNaSLDUhWn2eDcwDU5Q2/UT45IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784812377; c=relaxed/relaxed;
	bh=DwpJfr2TfW5ZcV9VJdTNQmd8jMNOS9Pa5pxsaoQnPQY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXPVO9xSE/zKYwU2bx6WQQyObfccOh0xwKyg7wPUAE9HP473m9xn91jq827fCPUIOV/KF3e9K5wJ2MKQ53PurC3DQwxfiANY53pwBGGQ+N8HHahWwe+aTQkLWxV+stdn9ZHV3v4FNPkDtsioTcQvj96AegNCwpdAFNGzbsLs1YG3j1lx+87f9TCbmaxSO+rK5GTtByu7J3mXdWwWMB9K33BYjge+LJ7IIQEOdf2V7VW5yza5tUVdaYSPuMgUgP9zcqg4INO6LbwTL+SK182bNUWDl1Z+RVaJ0UBgjJR1l0lllfpSVK1Ze9KZVWQ/wD3ana4yrzcTHuiWLb8XlTlxJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=eq4xquh3; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=eq4xquh3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Wkt106Hz2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 23:12:54 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DwpJfr2TfW5ZcV9VJdTNQmd8jMNOS9Pa5pxsaoQnPQY=;
	b=eq4xquh3Zh3MM68UJba8oFngr+x+Dbbj1dGjcEMDpdCCY6tpKlerVUPDvZO5Vy97FNH/Q/vGg
	VF6VPggav+R++AFm115WuRxAUSOeqCnXPHDCGExXcix3GdtKzTes/WDt5TQTNE6OehXAqWUBm03
	camWohp9UZDc70R3rGPm7E0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWn3mfcz12LDF;
	Thu, 23 Jul 2026 21:03:17 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id AF7CE2025F;
	Thu, 23 Jul 2026 21:12:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <vladimir.murzin@arm.com>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <james.morse@arm.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <kees@kernel.org>,
	<coxu@redhat.com>, <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <liaoyuanhong@vivo.com>,
	<jbouron@amazon.com>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>
Subject: [PATCH 8/8] arm64: crash: Add crash hotplug support
Date: Thu, 23 Jul 2026 21:12:42 +0800
Message-ID: <20260723131242.1537633-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

When CPU or memory hotplug events occur, the elfcorehdr in the kdump image
becomes stale, potentially leading to incomplete crash dumps.

Currently, userspace udev rules reload the entire kdump image upon such
events, which is inefficient and leaves kdump inactive for a long time.

Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
support") introduced a kernel mechanism to update only the elfcorehdr.
This patch enables that support for arm64.

On arm64, only memory hotplug events require elfcorehdr updates:
- Physical CPU hotplug is not supported.

- For ACPI based vCPU hotplug [1], the elfcorehdr is built using
  for_each_possible_cpu(), so no update is needed.

The patch:
- Adds CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG (default y).

- Implements following arch functions to handle memory hotplug:
  1. arch_crash_hotplug_support()
  2. arch_crash_get_elfcorehdr_size()
  3. arch_crash_handle_hotplug_event()

- Moves arch_get_system_nr_ranges() and arch_crash_populate_cmem()
  from machine_kexec_file.c to crash.c for crash hotplug reuse.

Follows the approach of x86 commit ea53ad9cf73b ("x86/crash: add x86 crash
hotplug support") and powerpc commit b741092d5976 ("powerpc/crash: add
crash CPU hotplug support").

Tested with QEMU [2] virtual machine using:
	-M virt,acpi=on,highmem=on
	-smp cpus=1,maxcpus=3
	-bios /usr/share/edk2/aarch64/QEMU_EFI.fd
	-m 2G,slots=64,maxmem=16G

Only kexec_file_load path has been tested; kexec_load is expected to
work via KEXEC_CRASH_HOTPLUG_SUPPORT flag but not yet verified.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Kees Cook <kees@kernel.org>
[1]: https://lore.kernel.org/all/20240529133446.28446-1-Jonathan.Cameron@huawei.com/
[2]: https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                     |   3 +
 arch/arm64/include/asm/kexec.h         |  13 +++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/crash.c              | 148 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  53 ++++-----
 5 files changed, 187 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3afe0688919..bebebded5b96 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1666,6 +1666,9 @@ config ARCH_DEFAULT_CRASH_DUMP
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	def_bool y
+
 config TRANS_TABLE
 	def_bool y
 	depends on HIBERNATION || KEXEC_CORE
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..4f3d4fc2807e 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -130,6 +130,19 @@ extern int load_other_segments(struct kimage *image,
 		char *cmdline);
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+#define pnum_hdr_sz(pnum) ((pnum) * sizeof(Elf64_Phdr) + sizeof(Elf64_Ehdr))
+
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags);
+#define arch_crash_hotplug_support arch_crash_hotplug_support
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
+#endif
+
 #endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index d2690c3ec528..9bbac452994c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -64,7 +64,7 @@ obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
+obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o crash.o
 obj-$(CONFIG_VMCORE_INFO)		+= vmcore_info.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
diff --git a/arch/arm64/kernel/crash.c b/arch/arm64/kernel/crash.c
new file mode 100644
index 000000000000..4a8d074c49b8
--- /dev/null
+++ b/arch/arm64/kernel/crash.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Architecture specific functions for kexec based crash dumps.
+ */
+
+#define pr_fmt(fmt)	"crash hp: " fmt
+
+#include <linux/kexec.h>
+#include <linux/elf.h>
+#include <linux/memblock.h>
+#include <linux/vmalloc.h>
+#include <linux/cacheflush.h>
+#include <linux/crash_core.h>
+
+#include <asm/kexec.h>
+
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)
+unsigned int arch_get_system_nr_ranges(void)
+{
+	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
+
+	return nr_ranges;
+}
+
+int arch_crash_populate_cmem(struct crash_mem *cmem)
+{
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_CRASH_HOTPLUG
+int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
+{
+#ifdef CONFIG_KEXEC_FILE
+	if (image->file_mode)
+		return 1;
+#endif
+	/*
+	 * For kexec_load syscall, crash hotplug support requires
+	 * KEXEC_CRASH_HOTPLUG_SUPPORT flag to be passed by userspace.
+	 */
+	return kexec_flags & KEXEC_CRASH_HOTPLUG_SUPPORT;
+}
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int phdr_cnt;
+
+	/* A program header for possible CPUs, vmcoreinfo and kernel_map */
+	phdr_cnt = 2 + num_possible_cpus();
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
+
+	return pnum_hdr_sz(phdr_cnt);
+}
+
+/**
+ * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it with old
+ *			       elfcorehdr in the kexec segment array.
+ * @image: the active struct kimage
+ */
+static void update_crash_elfcorehdr(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
+		pr_err("unable to create new elfcorehdr");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = (void *)__va(mem);
+	if (!old_elfcorehdr) {
+		pr_err("mapping elfcorehdr segment failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy((void *)old_elfcorehdr, elfbuf, elfsz);
+	dcache_clean_inval_poc((unsigned long)old_elfcorehdr,
+			       (unsigned long)old_elfcorehdr + elfsz);
+	xchg(&kexec_crash_image, image);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: a pointer to kexec_crash_image
+ * @arg: struct memory_notify handler for memory hotplug case and
+ *       NULL for CPU hotplug case.
+ *
+ * Update the kdump image based on the type of hotplug event:
+ * - CPU add and remove: No action is needed.
+ * - Memory add/remove: Update the elfcorehdr to reflect the current memory layout.
+ *
+ * Prepare the new elfcorehdr and replace the existing elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
+{
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
+	update_crash_elfcorehdr(image);
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 3d907f8ee594..35124f10b509 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
-#include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
@@ -39,34 +38,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_CRASH_DUMP
-unsigned int arch_get_system_nr_ranges(void)
-{
-	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end)
-		nr_ranges++;
-
-	return nr_ranges;
-}
-
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
-		cmem->nr_ranges++;
-	}
-
-	return 0;
-}
-#endif
-
 /*
  * Tries to add the initrd and DTB to the image. If it is not possible to find
  * valid locations, this function will undo changes to the image and return non
@@ -89,8 +60,9 @@ int load_other_segments(struct kimage *image,
 	kbuf.buf_min = kernel_load_addr + kernel_size;
 
 #ifdef CONFIG_CRASH_DUMP
+	unsigned long pnum = 0;
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = crash_prepare_headers(true, &kbuf.buffer, &kbuf.bufsz, NULL);
+		ret = crash_prepare_headers(true, &kbuf.buffer, &kbuf.bufsz, &pnum);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
@@ -101,9 +73,28 @@ int load_other_segments(struct kimage *image,
 
 		image->elf_headers = kbuf.buffer;
 		image->elf_headers_sz = kbuf.bufsz;
+		kbuf.memsz = kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+		/*
+		 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map
+		 * maximum CPUs and maximum memory ranges.
+		 */
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
+		else
+			pnum += 2 + num_possible_cpus();
+
+		if (pnum < (unsigned long)PN_XNUM) {
+			kbuf.memsz = pnum_hdr_sz(pnum);
+			image->elf_headers_sz = max(kbuf.memsz, kbuf.bufsz);
+			image->elfcorehdr_index = image->nr_segments;
+		} else {
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+		}
+#endif
 
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = kbuf.bufsz;
 		kbuf.buf_align = SZ_64K; /* largest supported page size */
 		kbuf.buf_max = ULONG_MAX;
 		kbuf.top_down = true;
-- 
2.34.1


