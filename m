Return-Path: <linuxppc-dev+bounces-19201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2331DCC6B0E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:27:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmYLg237Pz30D3;
	Thu, 02 Apr 2026 18:26:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775114779;
	cv=none; b=mnJSs1PTZb80gNP9odPKgh6Pwm62HuyocBl6cFkZZ1TuH6tokU5Yw9irLzZA1uNHXnn0Tt97+agvHHfOu1aA0CInxH8cqwGU9uFJxF+QkPQ6S8vPQXZXIIPHxGyOs9O7aY6Q3a823DXZgrSaSilSspFmPvz2Eku56NlDycf4sMMEWcUKQZrYR3uAFZmxsbzQW+mK9JRkMH2D4nuo2PuELx4hpK5c9wjURW4UR/MQ4SO9kYmIqfZvnRCR4qSZ+GgoPACOp2Ccc3vi+wMEptWNTu4Wrv2RhhPQ5zbm7yBF4gNJq3uHtPgJ+BVWUSN6sbR2rtQPwHSiUiB7VqxpbizcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775114779; c=relaxed/relaxed;
	bh=GPCukH3EUrSMBYCRHaxwWi6/BWowSCWPu0qInnaCPMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXpIIzQkeRsTcv92gktuFlTsU1DwdipQAU5YtKc28Zif1CZhH5tXPn7YQMBerHrc+FuCTpqBjgZIR8DF2/3FCzFdgBy2nkp8tv0W60kOzgEayz37R4XGk4OgHqQ0lgcvAdDAd1dxYG3mG57/OoK1bExNJwuMBS7YkHoWSe45wI4e+27icplDuyf2HlcaxT5vDzqbzdB/3z+Gy/l3gb+L02/J5HYctnDEz1Tpo6OnINo8qbo+jLnn6GmzkTcH7YcARfU0/1fz5krXiD1GpMys4rn60ibpNSZtSbsYo7WJBqpNrwaoZaXnGUXez6Bb/jJNGO/R2du2pb+9LmtUGE7RlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aqeG4E+L; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aqeG4E+L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmYLf3LCsz2yhG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 18:26:18 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GPCukH3EUrSMBYCRHaxwWi6/BWowSCWPu0qInnaCPMw=;
	b=aqeG4E+LpS7IctWlo82J8VkIJRmmQsg+LEWrb1zS9/Aner5/I9/Gcd/F7ajWqjBZX1+Z68FD1
	xqpH7y3lcqLgF0nkso8Z24O1H+QraYXD6KVQStR1FL1/MNPZ6ws4xVj+QHcAhQ37WlJfidb9zgu
	F1hw9EfeC9JbCIAB3WZBbW8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fmYCW1kzxz1K981;
	Thu,  2 Apr 2026 15:20:07 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 51DEB4056D;
	Thu,  2 Apr 2026 15:26:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 15:26:12 +0800
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
Subject: [PATCH v12 10/15] x86/kexec: Use crash_prepare_headers() helper to simplify code
Date: Thu, 2 Apr 2026 15:26:56 +0800
Message-ID: <20260402072701.628293-11-ruanjinjie@huawei.com>
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

Use the newly introduced crash_prepare_headers() function to replace
the existing prepare_elf_headers(), allocate cmem and exclude crash kernel
memory in the crash core, which reduce code duplication.

Only the following three architecture functions need to be implemented:
- arch_get_system_nr_ranges(). Call get_nr_ram_ranges_callback()
  to pre-count the max number of memory ranges.

- arch_crash_populate_cmem(). Use prepare_elf64_ram_headers_callback()
  to collect the memory ranges and fills them into cmem.

- arch_crash_exclude_ranges(). Exclude the low 1M for x86.

By the way, remove the unused "nr_mem_ranges" in
arch_crash_handle_hotplug_event().

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c | 89 +++++------------------------------------
 1 file changed, 11 insertions(+), 78 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 7fa6d45ebe3f..10ef24611f2a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -152,16 +152,8 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-/* Gather all the required information to prepare elf headers for ram regions */
-static struct crash_mem *fill_up_crash_elf_data(void)
+unsigned int arch_get_system_nr_ranges(void)
 {
-	unsigned int nr_ranges = 0;
-	struct crash_mem *cmem;
-
-	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
-	if (!nr_ranges)
-		return NULL;
-
 	/*
 	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
 	 * may cause range splits. So add extra slots here.
@@ -176,49 +168,16 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	 * But in order to lest the low 1M could be changed in the future,
 	 * (e.g. [start, 1M]), add a extra slot.
 	 */
-	nr_ranges += 3 + crashk_cma_cnt;
-	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
-	if (!cmem)
-		return NULL;
-
-	cmem->max_nr_ranges = nr_ranges;
+	unsigned int nr_ranges = 3 + crashk_cma_cnt;
 
-	return cmem;
+	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	return nr_ranges;
 }
 
-/*
- * Look for any unwanted ranges between mstart, mend and remove them. This
- * might lead to split and split ranges are put in cmem->ranges[] array
- */
-static int elf_header_exclude_ranges(struct crash_mem *cmem)
+int arch_crash_exclude_ranges(struct crash_mem *cmem)
 {
-	int ret = 0;
-	int i;
-
 	/* Exclude the low 1M because it is always reserved */
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
+	return crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
 }
 
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
@@ -235,35 +194,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-/* Prepare elf headers. Return addr and size */
-static int prepare_elf_headers(void **addr, unsigned long *sz,
-			       unsigned long *nr_mem_ranges)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem;
-	int ret;
-
-	cmem = fill_up_crash_elf_data();
-	if (!cmem)
-		return -ENOMEM;
-
-	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
-	if (ret)
-		goto out;
-
-	/* Exclude unwanted mem ranges */
-	ret = elf_header_exclude_ranges(cmem);
-	if (ret)
-		goto out;
-
-	/* Return the computed number of memory ranges, for hotplug usage */
-	*nr_mem_ranges = cmem->nr_ranges;
-
-	/* By default prepare 64bit headers */
-	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
-
-out:
-	vfree(cmem);
-	return ret;
+	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
 }
 #endif
 
@@ -421,7 +354,8 @@ int crash_load_segments(struct kimage *image)
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
+	ret = crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
+				    &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
@@ -514,7 +448,6 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
 	void *elfbuf = NULL, *old_elfcorehdr;
-	unsigned long nr_mem_ranges;
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
@@ -532,7 +465,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
+	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
-- 
2.34.1


