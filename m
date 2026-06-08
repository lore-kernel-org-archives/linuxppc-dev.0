Return-Path: <linuxppc-dev+bounces-22170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763C4CD8C8E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 07:37:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYkPk65YMz30FP;
	Mon, 08 Jun 2026 17:36:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780904202;
	cv=none; b=FvAzsUiJIf9clPOgRJlz4kgDAVg0R7ydgXYCRJnH0APuRwtqaY7SelbfARrA3Ub+upGkp2CVjXfU7VjzJ6cYF/QH0YZs5ZTQfJvTmPEr6n/1Z6XZo1zfFzGuD6VI7TZFDj24UdrMle6JvbSC7rWBEnU3v9QgXZDVXQfxHMC1qLkf+P7Ln+Itc6z/xIr9TAQWNIvk1yypL9QP7kgIofHvDShGRhdjQMSZHwYHcXXpKTeBJ9atUsescfH2g256u1J9tCTJHvGD6JGEAeULPfE9XrcH6M6dXHfmzG83xBtaB1YsuzmJTILKAuDEb9Lgzz6nGzdR1GFxqiEFWktDsiDZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780904202; c=relaxed/relaxed;
	bh=/KNrfwy/46ciNtz3WlJ+PmQJtYTserIzNJqhu5VMOdE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aG68td61iyRjxD1CAMpF+jphui9YOH71qwqls4ygeht1kUOV6Y92/3/o1FdkL4r5UXHc0AC7Vtm5AFeJBvvp2yagGBuuxFnrj58IdAY0os1X27lFS/svByNoQfp8YLOh3b1Pbf5Gqeb4YvMQqIbvV45tMs3Jd5JDznAfUDSH+cG+exveXyzkwlyL6aY0OLLKcwF6oUJRWC/lq5rnromEKFoHCnfZwqI6tSyO2jUhoK/5hkj9LHDzO3Z6WVaDmPHWY0b2PP2zGs9ia7x/kwqKYO158lPctkAl1A1zxjcR+NZcGn3PEUfi+wRE87XvEg2j5DviHAuWNhVWPGG1Do5PtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xX5pb4oZ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xX5pb4oZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYkPj5Mxqz3brC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 17:36:41 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/KNrfwy/46ciNtz3WlJ+PmQJtYTserIzNJqhu5VMOdE=;
	b=xX5pb4oZQl8S3LFkQ+XNSPCyGxnv6wDluapLBmoBeBcPAdVuFRzOhVKXPxBT3jR8oq75lFl/4
	uah02exL968DlGDw0uBXUyrlRTGs2JQXhO/4gLuWhheWz5GbDTgIFCGIUw8VK4RJryeaqYSWG6r
	NvJcY4n4wSs66L1VJbxxM6M=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gYkDZ1VWgzRhQX;
	Mon,  8 Jun 2026 15:28:46 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CAB0C40537;
	Mon,  8 Jun 2026 15:36:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Jun
 2026 15:36:35 +0800
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
	<rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<lirongqing@baidu.com>, <ebiggers@kernel.org>, <paulmck@kernel.org>,
	<ruanjinjie@huawei.com>, <leitao@debian.org>, <coxu@redhat.com>,
	<Liam.Howlett@oracle.com>, <ryan.roberts@arm.com>, <osandov@fb.com>,
	<jbohac@suse.cz>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <ardb@kernel.org>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v16 07/10] LoongArch: kexec_file: Use crash_prepare_headers() helper to simplify code
Date: Mon, 8 Jun 2026 15:34:56 +0800
Message-ID: <20260608073459.3119290-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608073459.3119290-1-ruanjinjie@huawei.com>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
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

Use the newly introduced crash_prepare_headers() function to replace
the existing prepare_elf_headers(), allocate cmem and exclude crash kernel
memory in the crash core, which reduce code duplication.

Only the following two architecture functions need to be implemented:
- arch_get_system_nr_ranges(). Use for_each_mem_range to traverse
  and pre-count the max number of memory ranges.

- arch_crash_populate_cmem(). Use for_each_mem_range to traverse
  and collect the memory ranges and fills them into cmem.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Youling Tang <tangyouling@kylinos.cn>
Cc: Baoquan He <bhe@redhat.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/kernel/machine_kexec_file.c | 40 +++++++---------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5584b798ba46..5412aa9f3568 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -56,46 +56,30 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
 }
 
 #ifdef CONFIG_CRASH_DUMP
-
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+unsigned int arch_get_system_nr_ranges(void)
 {
-	int ret, nr_ranges;
-	uint64_t i;
+	int nr_ranges = 2; /* for exclusion of crashkernel region */
 	phys_addr_t start, end;
-	struct crash_mem *cmem;
+	uint64_t i;
 
-	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
 
-	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
-	if (!cmem)
-		return -ENOMEM;
+	return nr_ranges;
+}
+
+int arch_crash_populate_cmem(struct crash_mem *cmem)
+{
+	phys_addr_t start, end;
+	uint64_t i;
 
-	cmem->max_nr_ranges = nr_ranges;
-	cmem->nr_ranges = 0;
 	for_each_mem_range(i, &start, &end) {
 		cmem->ranges[cmem->nr_ranges].start = start;
 		cmem->ranges[cmem->nr_ranges].end = end - 1;
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
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
-
-out:
-	kfree(cmem);
-	return ret;
+	return 0;
 }
 
 /*
@@ -163,7 +147,7 @@ int load_other_segments(struct kimage *image,
 		void *headers;
 		unsigned long headers_sz;
 
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
 		if (ret < 0) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
-- 
2.34.1


