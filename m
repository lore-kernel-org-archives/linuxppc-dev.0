Return-Path: <linuxppc-dev+bounces-27705-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C7C982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:05:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmSsG66qSz3bkd;
	Fri, 18 Sep 2026 20:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789725874;
	cv=none; b=JiOk33CSw3S25rkd5JY7/qFHJQRw5p8b3wB9i2opzMz4jRbgpJIgBz0iTnYp/2GP9JTdh3y7JdsiMJ5BITCWLmNgI80w4Kaa8WX7UJigSq8CsH2SW8SS5Erd3mE/77twjf0DtDFte7ZMbrJMmgrzxTljgJRu+MJPKUSejOSrVzVwwH8hD11FrvmyJtc0PLzL8dewtc5T6amt6P+ejL6F/XLJ8ytL0x8gZlwwosB+PtPCIc45XkImVqZZxz3mGBpLDBLCnh4VB3P6Xchwi+mtk9XOYa9y9QEXDSwrAmFxkPBb+pYgzhfCuiNHmV4865kiR8qYSwi412Ma5NmjrFtT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789725874; c=relaxed/relaxed;
	bh=fcjawUwcF+Ipqrmkc8OrDyT490KlVJ99NxRKRbRdpXA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxX6dRY/5mYP8X6Aadb8jek9aaOLOKs5en3qlEk38kQz/xiufTeEVu1aLLXn6udlOaxL+LSAj6eBi32OQ7zdxTLEGdSEBHIYyOAJmzqk75ZQD0weODrJtl4L3mhm5qb6KB+WK9R/EtxwqTzodpwdFRsO1OhBvaTz8+lYk42f1QBczsHurEhz1aOGNNqIK0wvS1W0vNapHWaZYa+lrv2mzhzqEgpuIPgCW58all3tRDp83rD2IjPJTBsLGuhNYHJo2nVsJSvblVIoj4JfjrPItd87FdmP/VzIKTyo7vWhD2VGOUKNCQj6gudMVM5gWLJHtbkuS4FscdgwQ+exOJKvAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ecL8AZSB; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ecL8AZSB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmSsF0LrCz3bd0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:04:32 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fcjawUwcF+Ipqrmkc8OrDyT490KlVJ99NxRKRbRdpXA=;
	b=ecL8AZSBtNZyNEDhb7BkDVSF7YYpJKkdn+Gr4NAiy2DW2kneIO5+g5PmiFfrGKL5IsFrau7oz
	vJR7SAcg2qXV6KQen8h3kFQFaWecc7ZPX+Uxz1BuGMnZIWUhkXy3p4JcCeGOa99CANsaYD4jLJE
	M1oAwIx3bIJ0dBf+uImYDDI=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hmScQ3fDWzmVX8;
	Fri, 18 Sep 2026 17:53:26 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 948334057C;
	Fri, 18 Sep 2026 18:04:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:24 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 12/17] crash: Fix TOCTOU race in crash memory range collection
Date: Fri, 18 Sep 2026 18:04:37 +0800
Message-ID: <20260918100442.3841135-13-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
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
Fixes: 8d5f894a3108 ("x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer")
Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c    |  9 ++++++++-
 include/linux/crash_core.h |  2 +-
 kernel/crash_core.c        | 28 +++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 3 deletions(-)

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
index 47a4579eb97e..760ca9822a13 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/buildid.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
@@ -317,7 +318,21 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
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
@@ -351,6 +366,17 @@ int crash_get_memory_ranges(struct crash_mem **mem_ranges)
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


