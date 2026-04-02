Return-Path: <linuxppc-dev+bounces-19199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004A1CC6B0E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:26:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmYLX3Y1mz301X;
	Thu, 02 Apr 2026 18:26:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775114772;
	cv=none; b=lJgG77oX9izDrkfwAaRQJ64JBcqx3Bp4Hu8lzkZCka4iTOME4QBpA+JQx2q9/JDjnFVcq33RvsKnDdHh5SWOMAGJgJTKQnPI0+qUqoWcqIZVrRXXoK0KT6WN0fWT+CGguv1qzyf6EqdYDnX6GoMKGKhsCtaqVMxwIFFzRDhjYsdlE+FK7oeOE9p7gcatCvaEyi5xF+Ncb5stw42tSYuMRNRF2AMZSJMrel5Zza9RyikwEFaJ0dUgYSCq4c+5jiZ6A5fa+ZsWnTHsard5MtYeXdRd9yxHj6zodOp8DuoXydxOFyHqyT5tnXbiYgAkwtIoZt2bPGSXYvQflYEgpg6JgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775114772; c=relaxed/relaxed;
	bh=a5oa/1akbFaboX4rfV7+Vg9uBkAhjnDcb7jWorQ4YFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOl19UblbRloUTk5S4EDPXsyk+1o7voIIlO6G+dbClpp1aPCN8M8lI8CbUdCANHBdgP9ZET3zMjgiDEXEd0E/sYuJ4Etjvyq9jb8MW/q7PjPB2SvwpjtCvXyw1YeO2/M6C7HBCCG2Mm/lRab4AruqAWciKa9FCOLFgqSq0KE1EI4PaFscIqd4ZDnT9ZxxVqagh1C3fABUpGSxmAEe350cG6AaV8YcItb9zhI24DWBd4AhB0mzMXCvlD5UHKxcxQzL2/b8t2gfHkjMamlvqJcl2cYHmtF3rLiRGQg+hhDDuil53jIb5v4HgCf3sL5qpUJ0LV2E7ReHEo+kkSEbZwsnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fqpO3Hvp; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fqpO3Hvp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmYLW2lfVz2yhG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 18:26:11 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a5oa/1akbFaboX4rfV7+Vg9uBkAhjnDcb7jWorQ4YFU=;
	b=fqpO3HvpIjuAcuK0qAVSEZLAj73VpXyTH01PSTMPaRqRwgyGBa4gPp9dgSa5NyKMyIXjIrgPm
	AQxT8ME9ISrCOTJjv/+U1ydwIc7H0xGh87cLN+Up5FXVPDzghq6wk2BpjRl0Go8AXaMJRDhGs7V
	9ihJ7PMu9s3QAj+Hj82lfYw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fmYC32MHDz12LFg;
	Thu,  2 Apr 2026 15:19:43 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CE0D84048F;
	Thu,  2 Apr 2026 15:26:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 15:26:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v12 08/15] crash: Add crash_prepare_headers() to exclude crash kernel memory
Date: Thu, 2 Apr 2026 15:26:54 +0800
Message-ID: <20260402072701.628293-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402072701.628293-1-ruanjinjie@huawei.com>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The crash memory alloc, and the exclude of crashk_res, crashk_low_res
and crashk_cma memory are almost identical across different architectures,
handling them in the crash core would eliminate a lot of duplication, so
add crash_prepare_headers() helper to handle them in the common code.

To achieve the above goal, three architecture-specific functions are
introduced:

- arch_get_system_nr_ranges(). Pre-counts the max number of memory ranges.

- arch_crash_populate_cmem(). Collects the memory ranges and fills them
  into cmem.

- arch_crash_exclude_ranges(). Architecture's additional crash memory
  ranges exclusion, defaulting to empty.

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/crash_core.h |  5 +++
 kernel/crash_core.c        | 82 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d35726d6a415..033b20204aca 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -66,6 +66,8 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mend);
 extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 				       void **addr, unsigned long *sz);
+extern int crash_prepare_headers(int need_kernel_map, void **addr,
+				 unsigned long *sz, unsigned long *nr_mem_ranges);
 
 struct kimage;
 struct kexec_segment;
@@ -83,6 +85,9 @@ int kexec_should_crash(struct task_struct *p);
 int kexec_crash_loaded(void);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
+extern unsigned int arch_get_system_nr_ranges(void);
+extern int arch_crash_populate_cmem(struct crash_mem *cmem);
+extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
 
 #else /* !CONFIG_CRASH_DUMP*/
 struct pt_regs;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2c1a3791e410..96a96e511f5a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -170,9 +170,6 @@ static inline resource_size_t crash_resource_size(const struct resource *res)
 	return !res->end ? 0 : resource_size(res);
 }
 
-
-
-
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {
@@ -274,6 +271,85 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
+static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
+{
+	struct crash_mem *cmem;
+
+	cmem = kvzalloc_flex(*cmem, ranges, nr_ranges);
+	if (!cmem)
+		return NULL;
+
+	cmem->max_nr_ranges = nr_ranges;
+	return cmem;
+}
+
+unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
+int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
+int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
+
+static int crash_exclude_core_ranges(struct crash_mem *cmem)
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
+
+	for (i = 0; i < crashk_cma_cnt; ++i) {
+		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
+					      crashk_cma_ranges[i].end);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			  unsigned long *nr_mem_ranges)
+{
+	unsigned int max_nr_ranges;
+	struct crash_mem *cmem;
+	int ret;
+
+	max_nr_ranges = arch_get_system_nr_ranges();
+	if (!max_nr_ranges)
+		return -ENOMEM;
+
+	cmem = alloc_cmem(max_nr_ranges);
+	if (!cmem)
+		return -ENOMEM;
+
+	ret = arch_crash_populate_cmem(cmem);
+	if (ret)
+		goto out;
+
+	ret = crash_exclude_core_ranges(cmem);
+	if (ret)
+		goto out;
+
+	ret = arch_crash_exclude_ranges(cmem);
+	if (ret)
+		goto out;
+
+	/* Return the computed number of memory ranges, for hotplug usage */
+	if (nr_mem_ranges)
+		*nr_mem_ranges = cmem->nr_ranges;
+
+	ret = crash_prepare_elf64_headers(cmem, need_kernel_map, addr, sz);
+
+out:
+	kvfree(cmem);
+	return ret;
+}
+
 /**
  * crash_exclude_mem_range - exclude a mem range for existing ranges
  * @mem: mem->range contains an array of ranges sorted in ascending order
-- 
2.34.1


