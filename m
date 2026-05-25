Return-Path: <linuxppc-dev+bounces-21463-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEF9CD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 08:52:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP8kK2z2Rz2yRl;
	Mon, 25 May 2026 18:51:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779699081;
	cv=none; b=DFgrEVH9dnuObszHq0dLGKJdb5SxwdbbG45QjvPuPxcq64KHyLTUVGOqM1CrhSxsgIZuPFQp5+JF1PREEn5OWR3LozU7MWxXyDdHr7012CmDVybxNgCkCUa04psIFe8S0MdftTSO08dvJF30GaU8456ipb3udbu+s5qv0Bqhj9LoTQC2324iCy+XM10Cz7lxyWU36Pk5ErFgwfBdZjP6uXuLaNvQmdD0/swZ6N8N8GfEbB18QB6TJbPtrdYx9f2cvXssiNRCXaqfcKaoArwza2udhUesJ75xP3QW/E0zMNrOrThtgVldk9Z6OrzO8IQWYA0mXaK+lT7yQZXavCKXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779699081; c=relaxed/relaxed;
	bh=4yR5CPO0KLLo3uOC/5zlV3U1Y37VvnS9l3MG4spR538=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH4yLLb1ZLyMx0NAID8sTVaSGR4F7d327D2yXQMcjDgobstdj1E+5+n1YNPNRAPOmn5Wr2Bplnd3ABruAozrBvu6nZaznkP5QXkmCsS5w8M89N/2IjOjjtDEztYab2qyoF4O/o3RcpW30Jdxd6lITKOGHYAm1rYstRblIlXYYLBW413PNg4xbOnNVc6bH44OMF/OrCxY9aTOFLXitjD3+1GUA5PIAMqE2Cm6DdFsYvM4VtAFap5AUJpj3PI8LypuVtyBNomiGXFRqOelCXpw8gI5QJmLm9Fnj3amG3uOJYISA70b87SjVQLO/b+zUdtfKGC2rAqyvnHNL34bjoVb7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HiLPBKvL; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HiLPBKvL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP8kJ39GDz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 18:51:20 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4yR5CPO0KLLo3uOC/5zlV3U1Y37VvnS9l3MG4spR538=;
	b=HiLPBKvL7AzcvDG+y+e5GKF8frq9ouAG5ppEoxmTckOGLNLMzmqvf/OcmcGJfXr4k2bTiVE3u
	B9XH/S5lwN1WhqRdoJM8vJ/HPUF9EAUeYVirJ3Ufs6MiOEVQt5bHzDcmZwC6kaA6V/yyQeOquCT
	b4FAK9eUPsKBR6NjNwUhCRY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gP8YH1hCdzKmSw;
	Mon, 25 May 2026 16:43:31 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1417940539;
	Mon, 25 May 2026 16:51:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 16:51:14 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <ardb@kernel.org>,
	<masahiroy@kernel.org>, <mark.rutland@arm.com>, <maz@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>,
	<junhui.liu@pigmoral.tech>, <vishal.moola@gmail.com>, <kas@kernel.org>,
	<debug@rivosinc.com>, <namcao@linutronix.de>, <liaoyuanhong@vivo.com>,
	<fuqiang.wang@easystack.cn>, <seanjc@google.com>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v14 17/17] arm64/crash: Add crash hotplug support
Date: Mon, 25 May 2026 16:49:32 +0800
Message-ID: <20260525084932.934910-18-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525084932.934910-1-ruanjinjie@huawei.com>
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Due to CPU/Memory hotplug or online/offline events, the elfcorehdr
(which describes the CPUs and memory of the crashed kernel) of kdump
image becomes outdated. Consequently, attempting dump collection with
an outdated elfcorehdr can lead to inaccurate dump collection.

The current solution to address the above issue involves monitoring
the CPU/Memory add/remove events in userspace using udev rules and
whenever there are changes in CPU and memory resources, the entire
kdump image is loaded again. The kdump image includes kernel, initrd,
elfcorehdr, FDT, purgatory. Given that only elfcorehdr gets outdated
due to CPU/Memory add/remove events, reloading the entire kdump image
is inefficient. More importantly, kdump remains inactive for a
substantial amount of time until the kdump reload completes.

To address the aforementioned issue, commit 247262756121 ("crash: add
generic infrastructure for crash hotplug support") added a generic
infrastructure that allows architectures to selectively update the
kdump image component during CPU or memory add/remove events within
the kernel itself.

In the event of a CPU or memory add/remove events, the generic crash
hotplug event handler, crash_handle_hotplug_event(), is triggered. It
then acquires the necessary locks to update the kdump image and invokes
the architecture-specific crash hotplug handler,
arch_crash_handle_hotplug_event(), to update the required kdump image
components.

[1] has supported virtual CPU hotplug in virtual machines for ARM64,
allowing vCPUs to be added or removed at runtime to meet Kubernetes
demands.

On ARM64, only memory add/remove events are handled. Here's why:

1. Physical CPU hotplug: Not supported on ARM64 hardware.

2. ACPI vCPU hotplug (KVM virtual machine):
   - vCPU hotplug is implemented as a static firmware policy where all
     possible vCPUs are pre-described in the MADT table at boot.
   - The vCPU status will be automatically updated after vCPU hotplug.
   - No FDT or elfcorehdr update needed.

3. Device tree booted Virtual Machine vCPU hotplug:
  - The elfcorehdr is built using for_each_possible_cpu(), so it
    already includes all possible CPUs and doesn't need updates.

For memory add/remove events, the elfcorehdr is updated to reflect
the current memory layout.

This patch adds the ARCH_SUPPORTS_CRASH_HOTPLUG config option and
implements:
- arch_crash_hotplug_support(): Check if hotplug update is supported
- arch_crash_get_elfcorehdr_size(): Return elfcorehdr buffer size
- arch_crash_handle_hotplug_event(): Handle memory hotplug events

This follows the same approach as x86 commit
ea53ad9cf73b ("x86/crash: add x86 crash hotplug support") and powerpc
commit b741092d5976 ("powerpc/crash: add crash CPU hotplug support")
and commit 849599b702ef ("powerpc/crash: add crash memory hotplug
support").

The test is based on the following QEMU version:
	https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2

Replace your '-smp' argument with something like:
 | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1

then feed the following to the Qemu montior to hotplug vCPU;
 | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
 | (qemu) device_del cpu1

feed the following to the Qemu montior to hotplug memory;
 | (qemu) object_add memory-backend-ram,id=mem1,size=256M
 | (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
 | (qemu) device_del dimm1

The qemu startup configuration is as follows:
qemu-system-aarch64 \
		-M virt,gic-version=3,acpi=on,highmem=on \
		-enable-kvm \
		-cpu host \
		-kernel Image \
		-smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1 \
		-bios /usr/share/edk2/aarch64/QEMU_EFI.fd \
		-m 2G,slots=64,maxmem=16G \
		-nographic \
		-no-reboot \
		-device virtio-rng-pci \
		-append "root=/dev/vda rw console=ttyAMA0 kgdboc=ttyAMA0,115200 \
			earlycon acpi=on crashkernel=512M" \
		-drive if=none,file=images/rootfs.ext4,format=raw,id=hd0 \
		-device virtio-blk-device,drive=hd0 \

There are two system calls, `kexec_file_load` and `kexec_load`, used to
load the kdump image. Only kexec_file_load syscall way is tested now.

This patch is based on following rework:
	https://lore.kernel.org/all/20260328074013.3589544-1-ruanjinjie@huawei.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Kees Cook <kees@kernel.org>
[1]: https://lore.kernel.org/all/20240529133446.28446-1-Jonathan.Cameron@huawei.com/
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                     |   3 +
 arch/arm64/include/asm/kexec.h         |  11 +++
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/crash.c              | 125 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  23 ++++-
 5 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..9091c67e1cc2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1609,6 +1609,9 @@ config ARCH_DEFAULT_CRASH_DUMP
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	def_bool y
+
 config TRANS_TABLE
 	def_bool y
 	depends on HIBERNATION || KEXEC_CORE
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index cc2f36b1b0d4..f338d162dec1 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -131,6 +131,17 @@ extern int load_other_segments(struct kimage *image,
 extern int prepare_elf_headers(void **addr, unsigned long *sz);
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
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
index 74b76bb70452..629e962813ab 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
+obj-$(CONFIG_CRASH_HOTPLUG)		+= crash.o
 obj-$(CONFIG_VMCORE_INFO)		+= vmcore_info.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
diff --git a/arch/arm64/kernel/crash.c b/arch/arm64/kernel/crash.c
new file mode 100644
index 000000000000..2114375820da
--- /dev/null
+++ b/arch/arm64/kernel/crash.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Architecture specific functions for kexec based crash dumps.
+ */
+
+#define pr_fmt(fmt)	"crash hp: " fmt
+
+#include <linux/kexec.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/crash_core.h>
+
+#include <asm/kexec.h>
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
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
+	return sizeof(Elf64_Ehdr) + phdr_cnt * sizeof(Elf64_Phdr);
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
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
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
+	switch (image->hp_action) {
+	case KEXEC_CRASH_HP_ADD_CPU:
+		fallthrough;
+	case KEXEC_CRASH_HP_REMOVE_CPU:
+		if (image->file_mode || image->elfcorehdr_updated)
+			return;
+		fallthrough;
+	case KEXEC_CRASH_HP_ADD_MEMORY:
+	case KEXEC_CRASH_HP_REMOVE_MEMORY:
+		update_crash_elfcorehdr(image);
+		return;
+	default:
+		pr_warn_once("Unknown hotplug action\n");
+	}
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index d2985ce62306..781febd0f6db 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -82,10 +82,11 @@ int load_other_segments(struct kimage *image,
 			char *cmdline, void *headers,
 			unsigned long headers_sz)
 {
-	struct kexec_buf kbuf = {};
-	void *dtb = NULL;
 	unsigned long initrd_load_addr = 0, dtb_len,
 		      orig_segments = image->nr_segments;
+	struct kexec_buf kbuf = {};
+	unsigned long pnum = 0;
+	void *dtb = NULL;
 	int ret = 0;
 
 	kbuf.image = image;
@@ -98,6 +99,23 @@ int load_other_segments(struct kimage *image,
 		kbuf.bufsz = headers_sz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 		kbuf.memsz = headers_sz;
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
+		if (pnum < (unsigned long)PN_XNUM)
+			kbuf.memsz = pnum * sizeof(Elf64_Phdr) + sizeof(Elf64_Ehdr);
+		else
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+#endif
+
 		kbuf.buf_align = SZ_64K; /* largest supported page size */
 		kbuf.buf_max = ULONG_MAX;
 		kbuf.top_down = true;
@@ -108,6 +126,7 @@ int load_other_segments(struct kimage *image,
 			goto out_err;
 		}
 		image->elf_load_addr = kbuf.mem;
+		image->elf_headers_sz = kbuf.memsz;
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
-- 
2.34.1


