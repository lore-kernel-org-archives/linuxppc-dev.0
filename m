Return-Path: <linuxppc-dev+bounces-16575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2294E95368
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 09:36:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Zxg258zz2xqD;
	Wed, 04 Feb 2026 20:36:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770197815;
	cv=none; b=cEHCvEJF3CPQ4ZG9CebRRkAX9HTKjMcBp97CrlJn6czzaq6gyVOWOM4ETrogPbome6GV1oAroa6muN50ElvFeP4EPymAgRY0goFXvT5UwIqlT+MbCcKUI7mlK8nPtAX4Iet/Xl+RS58Ezln8mAuyF4KWq+Lv7umkp/Kum8BQes5P2C7kwvafAP3phphj7NiKmEu5riT+h2UB7Kxy6/Hc86tHNSDoeNBYN4WR6aJomzgG1bttrb4MXoG54lCYpt5YFHzatriJvedZGbhRWWAearObHJm3V60zdJJB+XU9PCnWT3+/XnwPjGcmkLvVWbqK8RSX3rMvF520e1PdRDysyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770197815; c=relaxed/relaxed;
	bh=QVg6OyxDVrqaKGU+pvZ6DlNaiN3X5DKslNqzBQhZthc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP8jzU1UhqvVZFEL+j+AVklGHmzFRFrEvc60p2XkPbjyp5P8fQfNh+HMdDyjqp8645TQYRoegHN5whcNt0u5pxfLPuHuDm3iImik/ZVhtGxWw6P0H3Y9CeLSouMU6hny0B2kXgDwgedstBE5wYs31CWO5LKFDE+4mg0iYfzqXwHlySfHuqc9MNoe3EPeTgCoL0+9wlkbZ+ruDbwnLquNXMID48fSvi3tR08j0TgTIHXQEBYommObDoZvKXOX2YgAk9ltUjaLeNK73oXO0+nWRVqGIWEPupaVGpRuOxbmWv7lq1eUIJ1GNvHENLSGg1dMZ1pJG4+xLiXAowqD7CmEgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3aga8HNk; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3aga8HNk; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3aga8HNk;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3aga8HNk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Zxc35mNz2xHt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 20:36:52 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QVg6OyxDVrqaKGU+pvZ6DlNaiN3X5DKslNqzBQhZthc=;
	b=3aga8HNkyvVPYyyaP7DsKfPU92VXxDmY9f7epER4l6Hw3sgYrNxgvZ1lbM4t0CmbNGfEzjYlh
	7Z7dN5STGxEM45T2fuFfRB4UQbR2WGh1ZZTJVXpBzcrjn0gYSucWjZ25dZGu2oS4y1xBQwKjZY/
	UA2dKT27fnDTZ0axxkIuFbo=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4f5Zwg6CvMz1BGCw
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2026 17:36:03 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QVg6OyxDVrqaKGU+pvZ6DlNaiN3X5DKslNqzBQhZthc=;
	b=3aga8HNkyvVPYyyaP7DsKfPU92VXxDmY9f7epER4l6Hw3sgYrNxgvZ1lbM4t0CmbNGfEzjYlh
	7Z7dN5STGxEM45T2fuFfRB4UQbR2WGh1ZZTJVXpBzcrjn0gYSucWjZ25dZGu2oS4y1xBQwKjZY/
	UA2dKT27fnDTZ0axxkIuFbo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f5Zr64G09zLlSs;
	Wed,  4 Feb 2026 17:32:06 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D1C84055B;
	Wed,  4 Feb 2026 17:36:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 17:36:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<kees@kernel.org>, <elver@google.com>, <arnd@arndb.de>,
	<lirongqing@baidu.com>, <fvdl@google.com>, <leitao@debian.org>,
	<rppt@kernel.org>, <cfsworks@gmail.com>, <osandov@fb.com>,
	<sourabhjain@linux.ibm.com>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <samuel.holland@sifive.com>,
	<kevin.brodsky@arm.com>, <junhui.liu@pigmoral.tech>,
	<vishal.moola@gmail.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<liaoyuanhong@vivo.com>, <brgerst@gmail.com>, <fuqiang.wang@easystack.cn>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 1/3] crash: Exclude crash kernel memory in crash core
Date: Wed, 4 Feb 2026 17:37:26 +0800
Message-ID: <20260204093728.1447527-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204093728.1447527-1-ruanjinjie@huawei.com>
References: <20260204093728.1447527-1-ruanjinjie@huawei.com>
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

The exclude of crashk_res, crashk_low_res and crashk_cma memory
are almost identical across different architectures, so handling them
in the crash core would eliminate a lot of duplication, so do
them in the common code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/machine_kexec_file.c     | 12 -------
 arch/loongarch/kernel/machine_kexec_file.c | 12 -------
 arch/powerpc/kexec/ranges.c                | 16 ++-------
 arch/riscv/kernel/machine_kexec_file.c     |  5 +--
 arch/x86/kernel/crash.c                    | 39 ++--------------------
 kernel/crash_core.c                        | 28 ++++++++++++++++
 6 files changed, 34 insertions(+), 78 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 410060ebd86d..ed2c45007158 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -64,20 +64,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 		cmem->nr_ranges++;
 	}
 
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (ret)
-		goto out;
-
-	if (crashk_low_res.end) {
-		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
-		if (ret)
-			goto out;
-	}
-
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
-out:
 	kfree(cmem);
 	return ret;
 }
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index fb57026f5f25..26f867e53955 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -80,20 +80,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 		cmem->nr_ranges++;
 	}
 
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (ret < 0)
-		goto out;
-
-	if (crashk_low_res.end) {
-		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
-		if (ret < 0)
-			goto out;
-	}
-
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
-out:
 	kfree(cmem);
 	return ret;
 }
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 867135560e5c..3f76dd266b1f 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -553,9 +553,7 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_CRASH_DUMP
-static int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
-					   unsigned long long mstart,
-					   unsigned long long mend)
+static int crash_realloc_mem_range_guarded(struct crash_mem **mem_ranges)
 {
 	struct crash_mem *tmem = *mem_ranges;
 
@@ -566,7 +564,7 @@ static int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
 			return -ENOMEM;
 	}
 
-	return crash_exclude_mem_range(tmem, mstart, mend);
+	return 0;
 }
 
 /**
@@ -604,18 +602,10 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges)
 			sort_memory_ranges(*mem_ranges, true);
 	}
 
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_res.start, crashk_res.end);
+	ret = crash_realloc_mem_range_guarded(mem_ranges);
 	if (ret)
 		goto out;
 
-	for (i = 0; i < crashk_cma_cnt; ++i) {
-		ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_cma_ranges[i].start,
-					      crashk_cma_ranges[i].end);
-		if (ret)
-			goto out;
-	}
-
 	/*
 	 * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
 	 *        regions are exported to save their context at the time of
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index dd9d92a96517..fec3622a13c9 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -74,10 +74,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	if (ret)
 		goto out;
 
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 335fd2ee9766..d8341a48f6b3 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -186,41 +186,6 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	return cmem;
 }
 
-/*
- * Look for any unwanted ranges between mstart, mend and remove them. This
- * might lead to split and split ranges are put in cmem->ranges[] array
- */
-static int elf_header_exclude_ranges(struct crash_mem *cmem)
-{
-	int ret = 0;
-	int i;
-
-	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
-	if (ret)
-		return ret;
-
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (ret)
-		return ret;
-
-	if (crashk_low_res.end)
-		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
-					      crashk_low_res.end);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < crashk_cma_cnt; ++i) {
-		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
-					      crashk_cma_ranges[i].end);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
 	struct crash_mem *cmem = arg;
@@ -247,8 +212,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz,
 	if (ret)
 		goto out;
 
-	/* Exclude unwanted mem ranges */
-	ret = elf_header_exclude_ranges(cmem);
+	/* Exclude the low 1M because it is always reserved */
+	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
 	if (ret)
 		goto out;
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 99dac1aa972a..5c0de111ddc3 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/crash_core.h>
+#include <linux/crash_reserve.h>
 #include <linux/reboot.h>
 #include <linux/btf.h>
 #include <linux/objtool.h>
@@ -161,8 +162,30 @@ static inline resource_size_t crash_resource_size(const struct resource *res)
 	return !res->end ? 0 : resource_size(res);
 }
 
+static int crash_exclude_mem_ranges(struct crash_mem *cmem)
+{
+	int ret, i;
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		return ret;
+
+	if (crashk_low_res.end) {
+		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		if (ret)
+			return ret;
+	}
 
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
+					      crashk_cma_ranges[i].end);
+		if (ret)
+			return ret;
+	}
 
+	return ret;
+}
 
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
@@ -174,6 +197,11 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	unsigned int cpu, i;
 	unsigned long long notes_addr;
 	unsigned long mstart, mend;
+	int ret;
+
+	ret = crash_exclude_mem_ranges(mem);
+	if (ret)
+		return ret;
 
 	/* extra phdr for vmcoreinfo ELF note */
 	nr_phdr = nr_cpus + 1;
-- 
2.34.1


