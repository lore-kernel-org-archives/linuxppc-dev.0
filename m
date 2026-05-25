Return-Path: <linuxppc-dev+bounces-21457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B532CD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 08:51:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP8js5LpFz2yvD;
	Mon, 25 May 2026 18:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779699057;
	cv=none; b=ks4Y5Djt2JL+kifPhmtuf8l5CZPqba/CIabCPoDfupSQmnFl7QwhPgtiaWdpGpzABg+OX/KkNjJMGpjC5TamXiRu+9ClAj3NLygQbzU8wkwwiLOob9+J0ZWOSoiyHyhirLttXMXQsVBxtcAxwRL/aBk/jU4ZTEkxDrIHLZayADP1PtnFWw6MEmbsvQId7wDmkNImcTbdYMZBHo85O8ZnH8yisNw2AKlBIh5j9tQA/zgg/N4Uux2GnaZ+P/pg68O9BG3Vizi24n/5I9/1p/AuAN/5SMC8DC83Gp+g3pAuvwTQGmicw9ERGCo+fXjyQxs7KbBhfqsyXc6I1F9t1N1hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779699057; c=relaxed/relaxed;
	bh=s+swiDeCPjZNQiMPbwC355gr6g04gFdIOC7QXnxqniw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKj4P8B2PIAldTuphEVECyNbp43TXdnAg/27axqvZU/luTvwTw/DAc0yi7dA5JmcpCtM9x1XLdzrp744lduhgh8mT7Kf87FtfShYnctYuuRh28NiBA9T5/suiGUY/XdF2BGuylwQWhyvqhKhd+wm2VyFEwkTO9676MxAlaAf+IHw1n3C7zrU2c1Vmc9kGKQs2gy7P9plEn7gWN0qqooQW8Q2OEZyc8yz1YZWCj1mq/bptU2RpSFEfc69Gb1+SGhoqPll9D+0439b9Md0cc0W1DDnsaCL09BU4RBYp2wqRR3yRpjZ48W9WmnCZKCeLvG4XjFudMd8RrraIVYGb9zApA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=MGrsXNZ1; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=MGrsXNZ1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP8jr55HGz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 18:50:56 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s+swiDeCPjZNQiMPbwC355gr6g04gFdIOC7QXnxqniw=;
	b=MGrsXNZ1ejydULg609vJ3WJUkrR6RzUrrn5IpU25a7hbGVd3Ekm1r3UqomPphPOWYJ4qIS6Oo
	0eJZNCVXY54lb7F+EJSpmr9ODZ1+LA+iOVJx89WU/s1GqJC95TnmA0d8vNBXbH2MpdHpW9FFkT2
	Im40bToB2M9Hzwy6OFaTpCY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gP8YJ0Qb8zpStH;
	Mon, 25 May 2026 16:43:32 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D3AE40537;
	Mon, 25 May 2026 16:50:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 16:50:50 +0800
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
Subject: [PATCH v14 11/17] x86/kexec: Use crash_prepare_headers() helper to simplify code
Date: Mon, 25 May 2026 16:49:26 +0800
Message-ID: <20260525084932.934910-12-ruanjinjie@huawei.com>
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
 arch/x86/kernel/crash.c | 96 ++++++-----------------------------------
 1 file changed, 12 insertions(+), 84 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f319308b06ee..26f140dff348 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
-#include <linux/memory_hotplug.h>
 
 #include <asm/bootparam.h>
 #include <asm/processor.h>
@@ -154,16 +153,8 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
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
@@ -178,49 +169,16 @@ static struct crash_mem *fill_up_crash_elf_data(void)
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
@@ -237,35 +195,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
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
 
@@ -423,14 +355,11 @@ int crash_load_segments(struct kimage *image)
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	get_online_mems();
-	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
-	if (ret) {
-		put_online_mems();
+	ret = crash_prepare_headers_locked(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
+					   &kbuf.bufsz, &pnum);
+	if (ret)
 		return ret;
-	}
 
-	put_online_mems();
 	image->elf_headers	= kbuf.buffer;
 	image->elf_headers_sz	= kbuf.bufsz;
 	kbuf.memsz		= kbuf.bufsz;
@@ -520,7 +449,6 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
 	void *elfbuf = NULL, *old_elfcorehdr;
-	unsigned long nr_mem_ranges;
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
@@ -538,7 +466,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
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


