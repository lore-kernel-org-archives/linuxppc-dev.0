Return-Path: <linuxppc-dev+bounces-21460-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DB9CD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 08:52:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP8k54Zt4z2ySC;
	Mon, 25 May 2026 18:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779699069;
	cv=none; b=KwFVP1jNSa659lTxtokDC7zRPhRAtxa+JyhVS/OvTLsBbDsJB+ffOLoE6sVFjRZXGsnBRPsrh7VS6/SpA0yCGSRIO528Z43AzxqPXP663RahCuzdRMxg8jy/zD5HVcBstIyIeRZtr53x4cqF0gYeIF629itg5cgVswDpHMkg/tjVr3Ftp8mpOZcXKRQJ6GwC4NcMGNUVtYcaoXKMWHAaezFcRkh0HLfJ6+miiVorDoeUmzTNq3BccMQ86mcktILsfQda/m3I5m2qKEHGw1NlXLgqDmapMr4VYmp8GE+y8w8btQtaRiVLTds+QYGJY0+wxzS3NRTHBYVLhr0h2VAWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779699069; c=relaxed/relaxed;
	bh=j9XfifB+qCFiWXjFgjGAVxxf9YxSLc/J0SqjfD1KNYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8xz3zbuK6k8hmrT6T1/8eIYDBtXSF8mH7H0Ld3gZz+HDa4Ohq0ffuymb/3brRwL44153uNRCl1SLERKfwMNZB/NnSN/cs8/RsLlsxixTk24CMTmHBLLz9uArciLXTRylFziinNn9LbTwW2dnPoA/zjTGmGchVAOOWde9+5hDQxy1mUWyirvh2HARlI1SB8BeyqQ90MWJqb7pxFIp/jOyH8nfyvhXPwdZhhizRQs+/6ydEMU+m0B9BMLZCNdGIUfYtWS10R5dFzM7hvtOPFJ/ObcJUwd9iWZuLo+XGq/l/V6+GJSjUe5tB3xjUFJNgS2O9Miw4yGmc8kXEmA1juuVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WVWhXTBC; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WVWhXTBC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP8k42mjVz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 18:51:08 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j9XfifB+qCFiWXjFgjGAVxxf9YxSLc/J0SqjfD1KNYc=;
	b=WVWhXTBCaob4Ly9peOxmC/DpO8+2cRtSw1oRRvYPafqNoda/oCbp/Do07gbAApMt1/8OwoFkV
	8qxu9coWPqn2Rq9eNX4O8KGuI0qdbrHTa6iqp/CwZJyCyvA2XhgFMT5YSjlWCvV+Q1Tha2QmHgv
	cIFBhQ3Dyyz5c5EEIaoVvcc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gP8Xq65ptznTV7;
	Mon, 25 May 2026 16:43:07 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2440D40538;
	Mon, 25 May 2026 16:51:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 16:51:02 +0800
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
Subject: [PATCH v14 14/17] crash: Use crash_exclude_core_ranges() on powerpc
Date: Mon, 25 May 2026 16:49:29 +0800
Message-ID: <20260525084932.934910-15-ruanjinjie@huawei.com>
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

The crash memory exclude of crashk_res and crashk_cma memory on powerpc
are almost identical to the generic crash_exclude_core_ranges().

By introducing the architecture-specific arch_crash_exclude_mem_range()
function with a default implementation of crash_exclude_mem_range(),
and using crash_exclude_mem_range_guarded as powerpc's separate
implementation, the generic crash_exclude_core_ranges() helper function
can be reused.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/include/asm/kexec_ranges.h |  3 ---
 arch/powerpc/kexec/crash.c              |  2 +-
 arch/powerpc/kexec/ranges.c             | 16 ++++------------
 include/linux/crash_core.h              |  4 ++++
 kernel/crash_core.c                     | 19 +++++++++++++------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index ad95e3792d10..8489e844b447 100644
--- a/arch/powerpc/include/asm/kexec_ranges.h
+++ b/arch/powerpc/include/asm/kexec_ranges.h
@@ -7,9 +7,6 @@
 void sort_memory_ranges(struct crash_mem *mrngs, bool merge);
 struct crash_mem *realloc_mem_ranges(struct crash_mem **mem_ranges);
 int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
-int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
-				    unsigned long long mstart,
-				    unsigned long long mend);
 int get_exclude_memory_ranges(struct crash_mem **mem_ranges);
 int get_reserved_memory_ranges(struct crash_mem **mem_ranges);
 int get_crash_memory_ranges(struct crash_mem **mem_ranges);
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index d634db67becc..775895f31037 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -513,7 +513,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 		base_addr = PFN_PHYS(mn->start_pfn);
 		size = mn->nr_pages * PAGE_SIZE;
 		end = base_addr + size - 1;
-		ret = crash_exclude_mem_range_guarded(&cmem, base_addr, end);
+		ret = arch_crash_exclude_mem_range(&cmem, base_addr, end);
 		if (ret) {
 			pr_err("Failed to remove hot-unplugged memory from crash memory ranges\n");
 			goto out;
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 6c58bcc3e130..e5fea23b191b 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -553,9 +553,9 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_CRASH_DUMP
-int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
-					   unsigned long long mstart,
-					   unsigned long long mend)
+int arch_crash_exclude_mem_range(struct crash_mem **mem_ranges,
+				 unsigned long long mstart,
+				 unsigned long long mend)
 {
 	struct crash_mem *tmem = *mem_ranges;
 
@@ -604,18 +604,10 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges)
 			sort_memory_ranges(*mem_ranges, true);
 	}
 
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_res.start, crashk_res.end);
+	ret = crash_exclude_core_ranges(mem_ranges);
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
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d69c4c7c1f5e..0f4ea7ffd066 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -63,6 +63,7 @@ extern int crash_prepare_headers(int need_kernel_map, void **addr,
 				 unsigned long *sz, unsigned long *nr_mem_ranges);
 extern int crash_prepare_headers_locked(int need_kernel_map, void **addr,
 					unsigned long *sz, unsigned long *nr_mem_ranges);
+extern int crash_exclude_core_ranges(struct crash_mem **cmem);
 
 struct kimage;
 struct kexec_segment;
@@ -83,6 +84,9 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 extern unsigned int arch_get_system_nr_ranges(void);
 extern int arch_crash_populate_cmem(struct crash_mem *cmem);
 extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
+extern int arch_crash_exclude_mem_range(struct crash_mem **mem,
+					unsigned long long mstart,
+					unsigned long long mend);
 
 #else /* !CONFIG_CRASH_DUMP*/
 struct pt_regs;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index e84f3b63e79d..33e945da6776 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -286,24 +286,31 @@ unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
 int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
 int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
 
-static int crash_exclude_core_ranges(struct crash_mem *cmem)
+int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
+					unsigned long long mstart,
+					unsigned long long mend)
+{
+	return crash_exclude_mem_range(*mem, mstart, mend);
+}
+
+int crash_exclude_core_ranges(struct crash_mem **cmem)
 {
 	int ret, i;
 
 	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	ret = arch_crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		return ret;
 
 	if (crashk_low_res.end) {
-		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		ret = arch_crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
 		if (ret)
 			return ret;
 	}
 
 	for (i = 0; i < crashk_cma_cnt; ++i) {
-		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
-					      crashk_cma_ranges[i].end);
+		ret = arch_crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
+						   crashk_cma_ranges[i].end);
 		if (ret)
 			return ret;
 	}
@@ -330,7 +337,7 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 	if (ret)
 		goto out;
 
-	ret = crash_exclude_core_ranges(cmem);
+	ret = crash_exclude_core_ranges(&cmem);
 	if (ret)
 		goto out;
 
-- 
2.34.1


