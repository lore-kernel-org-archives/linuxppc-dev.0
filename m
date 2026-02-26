Return-Path: <linuxppc-dev+bounces-17275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B77FCE068
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:06:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMBXQ4RfPz2yFm;
	Fri, 27 Feb 2026 00:05:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772111142;
	cv=none; b=MryOxwTzEQHUc4AFwBRAdqsPUyHcNX5CgKaz50zxt7oc/kIoPSDCiF92oO653A2VnQRVfADIbYytBeCH3Q+pYV9fh1/A7NjTeAWXkUZRtgwY102aE3Q9BG53N7pGuaH6UElHsaR3L0NqcK/6cuLSYRzaPuDo3VKlS/HgAU5MiSMLRYfussISmL4bFiy3ZWEsHotFCrg/qOX/SGAZe9irzmOoWmCbANGadPVSf46xFxCY4ui3EVpfwgkeDc8PTHIKOcpd74+y2wxeLzyVbTZnsOnHHTQu2uzLdroBHJ5w92w5cuWgJuzL4wTcZubk/3CqFHCGqWXJwAu0fB716b6CYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772111142; c=relaxed/relaxed;
	bh=TcB25wV+GVcxRRaN4hJemV88twLbPCQRBA4cy/gefbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c19RRvYXZsyuONFi6qD+6foXb73aHKKdmhlOi/Pe/THVVmkba7RXCFKTrrJja1k1cpTGcLKJNqhAYYKReZNU4wVoAnBf+xabvc4yoLczLWBUduzUAO3Q14b8mEpPmiJHmtF43/GwDVz6mD8RIvgOEx6LWoyBfL1pDlEOQmObkaMX7cPxU17k/jxFyRHw+TqDm2LPlTmj7xAbPywnAE1qN9/nglp1vD1nUli2hqQc7yM0JAh8b9ojZ3bdNKsCfIJaEC8zVypyFNJW0mETW+9KKx9BVr+WfKrwlxagATR/t1WOdZs7QyM7b0CQ2nR80wrr83nd6L5OB1RXzMi6OreNcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TJnn4ee+; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TJnn4ee+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMBXN6Rsgz3bfZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 00:05:40 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TcB25wV+GVcxRRaN4hJemV88twLbPCQRBA4cy/gefbc=;
	b=TJnn4ee+pIS+c6GqtPGGFNWkHjbejCaBZvNjPENY4oPOoboVjjxO0n8JPqCCJq0ipM31zGo69
	3/+AruweN1FpwEU0Tw4Ccf59OAc5kpsDMH0Po5FqPvZSPU4wPIs4ylDsrE2VEgjmbtLsM6kcyRy
	LWdIs/zyP+rd0p5nVMvZWfM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fMBQk4ppTzRhS7;
	Thu, 26 Feb 2026 21:00:46 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 86E3040561;
	Thu, 26 Feb 2026 21:05:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Feb
 2026 21:05:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <paulmck@kernel.org>,
	<lirongqing@baidu.com>, <arnd@arndb.de>, <rppt@kernel.org>,
	<ardb@kernel.org>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
	<jbohac@suse.cz>, <cfsworks@gmail.com>, <ryan.roberts@arm.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <hbathini@linux.ibm.com>,
	<eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<samuel.holland@sifive.com>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<liaoyuanhong@vivo.com>, <brgerst@gmail.com>, <fuqiang.wang@easystack.cn>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v7 4/5] arm64: kexec: Add support for crashkernel CMA reservation
Date: Thu, 26 Feb 2026 21:04:36 +0800
Message-ID: <20260226130437.1867658-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226130437.1867658-1-ruanjinjie@huawei.com>
References: <20260226130437.1867658-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
crashkernel= command line option") and commit ab475510e042 ("kdump:
implement reserve_crashkernel_cma") added CMA support for kdump
crashkernel reservation.

Crash kernel memory reservation wastes production resources if too
large, risks kdump failure if too small, and faces allocation difficulties
on fragmented systems due to contiguous block constraints. The new
CMA-based crashkernel reservation scheme splits the "large fixed
reservation" into a "small fixed region + large CMA dynamic region": the
CMA memory is available to userspace during normal operation to avoid
waste, and is reclaimed for kdump upon crash—saving memory while
improving reliability.

So extend crashkernel CMA reservation support to arm64. The following
changes are made to enable CMA reservation:

- Parse and obtain the CMA reservation size along with other crashkernel
  parameters.
- Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
- Include the CMA-reserved ranges for kdump kernel to use.
- Exclude the CMA-reserved ranges from the crash kernel memory to
  prevent them from being exported through /proc/vmcore, which is already
  done in the crash core.

Update kernel-parameters.txt to document CMA support for crashkernel on
arm64 architecture.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v7:
- Correct the inclusion of CMA-reserved ranges for kdump
  kernel in of/kexec.
v3:
- Add Acked-by.
v2:
- Free cmem in prepare_elf_headers()
- Add the mtivation.
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/arm64/kernel/machine_kexec_file.c          |  2 +-
 arch/arm64/mm/init.c                            |  5 +++--
 drivers/of/fdt.c                                |  9 +++++----
 drivers/of/kexec.c                              | 13 +++++++++++--
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb850e5290c2..afb3112510f7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1121,7 +1121,7 @@ Kernel parameters
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 	crashkernel=size[KMG],cma
-			[KNL, X86, ppc] Reserve additional crash kernel memory from
+			[KNL, X86, ARM64, PPC] Reserve additional crash kernel memory from
 			CMA. This reservation is usable by the first system's
 			userspace memory and kernel movable allocations (memory
 			balloon, zswap). Pages allocated from this memory range
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index c338506a580b..cc577d77df00 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -42,7 +42,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 #ifdef CONFIG_CRASH_DUMP
 unsigned int arch_get_system_nr_ranges(void)
 {
-	unsigned int nr_ranges = 2; /* for exclusion of crashkernel region */
+	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
 	phys_addr_t start, end;
 	u64 i;
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 96711b8578fd..144e30fe9a75 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -96,8 +96,8 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 
 static void __init arch_reserve_crashkernel(void)
 {
+	unsigned long long crash_base, crash_size, cma_size = 0;
 	unsigned long long low_size = 0;
-	unsigned long long crash_base, crash_size;
 	bool high = false;
 	int ret;
 
@@ -106,11 +106,12 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, NULL, &high);
+				&low_size, &cma_size, &high);
 	if (ret)
 		return;
 
 	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
+	reserve_crashkernel_cma(cma_size);
 }
 
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 331646d667b9..531be5fcdeb6 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -871,11 +871,12 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 /*
  * The main usage of linux,usable-memory-range is for crash dump kernel.
  * Originally, the number of usable-memory regions is one. Now there may
- * be two regions, low region and high region.
- * To make compatibility with existing user-space and older kdump, the low
- * region is always the last range of linux,usable-memory-range if exist.
+ * be 2 + CRASHKERNEL_CMA_RANGES_MAX regions, low region, high region and
+ * cma regions. To make compatibility with existing user-space and older
+ * kdump, the low region is always the last range of linux,usable-memory-range
+ * if exist.
  */
-#define MAX_USABLE_RANGES		2
+#define MAX_USABLE_RANGES		(2 + CRASHKERNEL_CMA_RANGES_MAX)
 
 /**
  * early_init_dt_check_for_usable_mem_range - Decode usable memory range
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index c4cf3552c018..02a8cfc47180 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -309,10 +309,10 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   unsigned long initrd_len,
 				   const char *cmdline, size_t extra_fdt_size)
 {
-	void *fdt;
-	int ret, chosen_node, len;
+	int ret, chosen_node, len, i;
 	const void *prop;
 	size_t fdt_size;
+	void *fdt;
 
 	fdt_size = fdt_totalsize(initial_boot_params) +
 		   (cmdline ? strlen(cmdline) : 0) +
@@ -431,6 +431,15 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		if (ret)
 			goto out;
 
+		for (i = 0; i < crashk_cma_cnt; i++) {
+			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+					"linux,usable-memory-range",
+					crashk_cma_ranges[i].start,
+					crashk_cma_ranges[i].end - crashk_cma_ranges[i].start + 1);
+			if (ret)
+				goto out;
+		}
+
 		if (crashk_low_res.end) {
 			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
 					"linux,usable-memory-range",
-- 
2.34.1


