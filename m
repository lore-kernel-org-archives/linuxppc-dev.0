Return-Path: <linuxppc-dev+bounces-27832-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCD5C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:06:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHNr6Nt7z30Nl;
	Mon, 21 Sep 2026 19:04:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981484;
	cv=none; b=BxheV2BRE4QgWPatzj4eevR9lydc19G6MOGG5OKJgIrbfW+3vPN1WwOw1OfkUfzzYrLEkeGCt1BVmXrm8yUm8HVOPWAseYDcetl7AsyriPThaPyjuiDyMLKddje6RtFut/Zubj68Xsayovw+CrGSpMNnO1I6yMU1B8Vre7HQhmzSamMpAokgQilcwMn0ndg0ScisnJAo9gStEghTDzbd+TBRZEaDC2RfxN+SN3TEYpGfqrlTbdaQKj+o95a4ujVMKNXOV3fMApoZ/Ldy4l7zBYqs9+7cmUf82by5B5Z6eVM5swqM2eeijdsCCUv5p6uAlrEf74LYeD/C0DFfPMvoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981484; c=relaxed/relaxed;
	bh=tZDkeXV6a369nstMRHLxqf/4pglLnuU252K/oM3e//U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZikZp1qc/a05UJikX3MjKCiYrf7PTqCHqXn37GcTXR4XQA/nz6dI/pePR26itXmauSYshCv6LXhQ2G7IOh/Fgk6qTEMv0qhSBuIbTcEi2NA6zM0PU4fvxHLp9g1/T0K1DDd0sms9y16XfBKICN7ekSzySr41nowKGncN1cRK2hhp1Tn9FhrBPeIelGwaock+PMKY4H5GXWWHG+61R41CVkRVnmt5bhANpNuVRUpVILT5VSWR4h1ylUEWSiJDEdkN5HZrhz4m7hT7/CIT2rC6bepQySe4qRi0Hr9ftDM5Z/peH2qyfNGNfmg+P6fcWGS5XrTTv/zDsOReY9KeYK/0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FSQCRI07; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FSQCRI07;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHNq65n1z303F
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:04:43 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tZDkeXV6a369nstMRHLxqf/4pglLnuU252K/oM3e//U=;
	b=FSQCRI07g5QzFIcDMwCwg/ym4bv+MAK0v8zfemlvrSwKiabVebvUXPWom1TVv4gzGf8buXlLy
	RMYyu38fBRkQyRbfO+5BpR3c6LEShSJE+2OjrybC1bDiGSgDcbIKCxFkfXpl37nLLre31VHPXRY
	sgFKRo0j3+ZlmM8+lt2rpds=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hpH7w5X96z1K9Ck;
	Mon, 21 Sep 2026 16:53:32 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A928D40592;
	Mon, 21 Sep 2026 17:04:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:04:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 14/14] crash: Fix TOCTOU race in crash memory range collection
Date: Mon, 21 Sep 2026 17:04:50 +0800
Message-ID: <20260921090450.807575-15-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)

The crash kernel ELF core header construction counts system memory
ranges via `arch_get_system_nr_ranges()`, allocates the crash_mem
buffer, and then populates it via `arch_crash_populate_cmem()`.
This sequence has a time-of-check-to-time-of-use (TOCTOU) race with
memory hotplug: a concurrent hotplug event between the count
and populate steps can increase the number of ranges beyond the allocated
capacity, causing an out-of-bounds write. If the event triggers
memblock_double_array(), the memblock array can be freed and reallocated
during iteration, leading to a use-after-free.

Protect the entire range collection with device_hotplug_lock. Since
the hotplug notification path already holds that lock, add a lockless
helper, crash_get_memory_ranges_nolock(), for use there. The regular
crash_get_memory_ranges() acquires the lock and calls the helper.

Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Youling Tang <tangyouling@kylinos.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Fixes: 8d5f894a3108 ("x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer")
Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c    |  9 ++++++++-
 include/linux/crash_core.h |  2 +-
 kernel/crash_core.c        | 35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f34fa8dba028..7fa139725514 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -447,6 +447,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
  */
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
+	struct crash_mem *cmem = NULL;
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 	void *elfbuf = NULL;
@@ -461,11 +462,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	    image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		return;
 
+	if (crash_get_memory_ranges_nolock(&cmem)) {
+		pr_err("Failed to get crash mem range\n");
+		goto out;
+	}
+
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
+	if (crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
@@ -501,6 +507,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	pr_debug("updated elfcorehdr\n");
 
 out:
+	kvfree(cmem);
 	vfree(elfbuf);
 }
 #endif
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index a740757dff35..1296a9b29974 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -63,7 +63,7 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
 extern int crash_prepare_headers(int need_kernel_map, void **addr,
 				 unsigned long *sz, unsigned long *nr_mem_ranges);
 extern int crash_exclude_core_ranges(struct crash_mem **cmem);
-int crash_get_memory_ranges(struct crash_mem **mem_ranges);
+int crash_get_memory_ranges_nolock(struct crash_mem **mem_ranges);
 
 struct kimage;
 struct kexec_segment;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b638ad0e5ba2..43b21de1d64a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/buildid.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
@@ -317,12 +318,33 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
 	return 0;
 }
 
-int crash_get_memory_ranges(struct crash_mem **mem_ranges)
+/**
+ * crash_get_memory_ranges_nolock - Collect crash kernel memory ranges
+ * @mem_ranges: Output parameter for the allocated crash_mem structure
+ *
+ * Gathers the system memory ranges to be included in the crash kernel's
+ * ELF core header, excluding the crashkernel reserved region and other
+ * architecture-specific areas.
+ *
+ * Context: Caller must hold device_hotplug_lock.
+ *
+ * Return: 0 on success, in which case *@mem_ranges points to a newly
+ * allocated struct crash_mem that the caller must free with kvfree().
+ * Returns a negative error code on failure.
+ */
+int crash_get_memory_ranges_nolock(struct crash_mem **mem_ranges)
 {
 	unsigned int max_nr_ranges;
 	struct crash_mem *cmem;
 	int ret;
 
+	/*
+	 * Callers must serialize against memory hotplug by holding
+	 * device_hotplug_lock, otherwise the memblock iteration below can
+	 * race with memblock_double_array() and read freed memory.
+	 */
+	device_hotplug_lock_assert_held();
+
 	max_nr_ranges = arch_get_system_nr_ranges();
 	if (!max_nr_ranges)
 		return -ENOMEM;
@@ -351,6 +373,17 @@ int crash_get_memory_ranges(struct crash_mem **mem_ranges)
 	return ret;
 }
 
+static int crash_get_memory_ranges(struct crash_mem **mem_ranges)
+{
+	int ret;
+
+	lock_device_hotplug();
+	ret = crash_get_memory_ranges_nolock(mem_ranges);
+	unlock_device_hotplug();
+
+	return ret;
+}
+
 int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 			  unsigned long *nr_mem_ranges)
 {
-- 
2.34.1


