Return-Path: <linuxppc-dev+bounces-21458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86514CD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 08:51:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP8jw6Q3Lz2ySV;
	Mon, 25 May 2026 18:51:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779699060;
	cv=none; b=LvkhbVSYvV8Wnj6pp+XunlaS2Vyg3gy8n1rNO9J0c8di3tM3uTxA19kssmBoOyHCAwQNwu78E+x9+MR3xoLcq55NDriMK1YG5JgKMChKEZcKoKhI16LQX+iX717iVxImldb5xare7wu+eAbChp0XjD1OP6i2k+Wd0WPVPkzkzJ3fd2tqS4EYPUPu9rO7vicn7q64dkk6nAxJaHlAXiLmYzeRa+4FhIwlPcN0+uYWsh7D+CF+ydPh1BffXNFxxQldHJqC5flABIQ4r7eBGo1HUT8+8KvuY5Ta0oZG6mf5+inD+UEtiu+LaRBFT1nx10X993iAfpR/wCKnVgXcnAAlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779699060; c=relaxed/relaxed;
	bh=yvr4bCXcJCPd8D4DBs3QOoT49bvc06o4/wVbNRJdXbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYC/MUvW9Ogykb91smJlZbbhP76EHbb2wUqCtEW2S+gWbpcV1EL3zNPwdfOCh1Q1pjsIJZuAXd531XajF7soit8GIsWFYZokt7asNcRtlU+EsR60FsjhDrV/xnzyihCEspfPmDgxldngLkuSc8OOGEpp7treYjHJ+6tEZf/X9N0H9lWoAZ2dPB9267fovE2JK6kQHxJlE/s/J/Vn5LbDKfxDJjSFUAM0hH26o9U4GrpWR3yw8F3afQNx2hBewtsM00qaDvgafpb6TqVyqkgzYs6W3CnYOxJUnpv1aEXxB5pNdlBKtEwe0Pd4FuEYTICuVaA9cY5LvhteWTL5M5bSEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TybJFSW9; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TybJFSW9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP8jw15KPz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 18:51:00 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yvr4bCXcJCPd8D4DBs3QOoT49bvc06o4/wVbNRJdXbc=;
	b=TybJFSW9GLvV4xNVHO8fZwd15CFZdkg2Akh3GDeCP92Rr/Nfyqsvqwuf/awGm3KfQCWekw0Su
	/0DyIIys0NN6XGyIa8RQi49kaHqJJu0TeEn6Y7EIvRR58+B9PW5pl6g2nk32UA3wlmQFP543Yw7
	c+brN5L1/2Cltqmd5m0FTs8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gP8Xv3dLmz1prmB;
	Mon, 25 May 2026 16:43:11 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 681CA40537;
	Mon, 25 May 2026 16:50:58 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 16:50:54 +0800
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
Subject: [PATCH v14 12/17] riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
Date: Mon, 25 May 2026 16:49:27 +0800
Message-ID: <20260525084932.934910-13-ruanjinjie@huawei.com>
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

Only the following two architecture functions need to be implemented:
- arch_get_system_nr_ranges(). Call get_nr_ram_ranges_callback()
  to pre-counts the max number of memory ranges.

- arch_crash_populate_cmem(). Use prepare_elf64_ram_headers_callback()
  to collects the memory ranges and fills them into cmem.

Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Guo Ren <guoren@kernel.org>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 51 ++++++--------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index a88362dfbd89..d2bb61a8b6b6 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -8,7 +8,6 @@
  */
 #include <linux/kexec.h>
 #include <linux/elf.h>
-#include <linux/memory_hotplug.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/libfdt.h>
@@ -45,6 +44,15 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 	return 0;
 }
 
+unsigned int arch_get_system_nr_ranges(void)
+{
+	unsigned int nr_ranges = 2; /* For exclusion of crashkernel region */
+
+	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+
+	return nr_ranges;
+}
+
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
 	struct crash_mem *cmem = arg;
@@ -59,41 +67,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem;
-	unsigned int nr_ranges;
-	int ret;
-
-	nr_ranges = 2; /* For exclusion of crashkernel region */
-	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
-
-	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
-	if (!cmem)
-		return -ENOMEM;
-
-	cmem->max_nr_ranges = nr_ranges;
-	cmem->nr_ranges = 0;
-	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
-	if (ret)
-		goto out;
-
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
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
-
-out:
-	kfree(cmem);
-	return ret;
+	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
 }
 
 static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
@@ -285,15 +261,12 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		void *headers;
 		unsigned long headers_sz;
-		get_online_mems();
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = crash_prepare_headers_locked(true, &headers, &headers_sz, NULL);
 		if (ret) {
-			put_online_mems();
 			pr_err("Preparing elf core header failed\n");
 			goto out;
 		}
 
-		put_online_mems();
 		kbuf.buffer = headers;
 		kbuf.bufsz = headers_sz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-- 
2.34.1


