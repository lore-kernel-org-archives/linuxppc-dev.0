Return-Path: <linuxppc-dev+bounces-16576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EC0E95360
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 09:36:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Zxg29XFz2xs4;
	Wed, 04 Feb 2026 20:36:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770197815;
	cv=none; b=cbWgoeqJO9ObZbv47JVXLgsSEofWcIfMfOzG592uMfQK7HWRIvlw8ggh3n9Jd8DuUG2x82Jd8H3xLW+xwJH5KDLXr/5h+aZBWkV5mfPrG3YfJrSY9PYdAX2lJshY59NCNNfo6cg3afCIACWy1Lykmxfs3ZS5/hwaXvBtCT44c+2hHLCm3oyGPf7VlPKxpLitjEb+STNLvEB2ZhCU7QTty9A/KJq4yY7C4J0DJJ2NCtBctvXGbnqYSxjJLNk/L1mKk5/fSGcZN/LKBrpTtLpb6+9zrlzo+PKEbLy8X9wYlIVRdJLmEQEnpZonNifsURWf2qqZ3I6JNqUvkGLVDwmKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770197815; c=relaxed/relaxed;
	bh=9dh41FuXoskin5kEyP/EzKDXWLppsq5+vDzuAG9frAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dwy8C1Hr32iNph88ip0cwbckL6zPgcuf3lCSR5iJTAaFVL5FLAT24lxNOrQPh/BayugB16MFgJ5GQTehgNfvaAutMjPUUFFXCmpPfaJgvqfKD5K4YyqJxtzLTn3YnkROwqVhFxvrE4TDVBqPV/1utp2e86KfsFZxzrua5PF5WLblsLTBzvJtf03+T1vqqiUQJyRw6fTSWO+LwUSX/Om8zUDDf/1Ba19thtyunMcwy9mEW1ScRFHz4rS0MJRlOQ28GVBwLTteNZhgh9sIZq/LIL1FSg08Oe2gzda3MSC74GsA0XHMwZDrowd9qreMubYk+4b8jK/aARm4vUO5tfNrfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=O05tgehu; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=O05tgehu; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=O05tgehu;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=O05tgehu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Zxd45HXz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 20:36:53 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9dh41FuXoskin5kEyP/EzKDXWLppsq5+vDzuAG9frAc=;
	b=O05tgehusLXxCPdoMc3HuZGiKmyI7zPSArAukVtx29XJeeSPz6a9SN/2YFTXxU1lSlAJ79XK1
	K0hTPthQMZ92VIfFMbzLuF5PiVF+fIshLc7csCP+lx0p4fKMolwvRJCvTP4q8HxXlOf5doEOqux
	NH1bTdersZfl51BebkcMNZM=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4f5Zwk4JSmz1BGCs
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2026 17:36:06 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9dh41FuXoskin5kEyP/EzKDXWLppsq5+vDzuAG9frAc=;
	b=O05tgehusLXxCPdoMc3HuZGiKmyI7zPSArAukVtx29XJeeSPz6a9SN/2YFTXxU1lSlAJ79XK1
	K0hTPthQMZ92VIfFMbzLuF5PiVF+fIshLc7csCP+lx0p4fKMolwvRJCvTP4q8HxXlOf5doEOqux
	NH1bTdersZfl51BebkcMNZM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f5ZrP1l8Wz1T4fn;
	Wed,  4 Feb 2026 17:32:21 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E0B5404AD;
	Wed,  4 Feb 2026 17:36:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 17:36:40 +0800
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
Subject: [PATCH v3 2/3] arm64: kexec: Add support for crashkernel CMA reservation
Date: Wed, 4 Feb 2026 17:37:27 +0800
Message-ID: <20260204093728.1447527-3-ruanjinjie@huawei.com>
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

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Add Acked-by.
v2:
- Free cmem in prepare_elf_headers()
- Add the mtivation.
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/arm64/kernel/machine_kexec_file.c          | 8 +++++++-
 arch/arm64/mm/init.c                            | 5 +++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8..36bb642a7edd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1119,7 +1119,7 @@ Kernel parameters
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 	crashkernel=size[KMG],cma
-			[KNL, X86, ppc] Reserve additional crash kernel memory from
+			[KNL, X86, ARM64, ppc] Reserve additional crash kernel memory from
 			CMA. This reservation is usable by the first system's
 			userspace memory and kernel movable allocations (memory
 			balloon, zswap). Pages allocated from this memory range
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index ed2c45007158..cab4aaf8cb22 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -48,7 +48,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	u64 i;
 	phys_addr_t start, end;
 
-	nr_ranges = 2; /* for exclusion of crashkernel region */
+	nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
 
@@ -64,6 +64,12 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 		cmem->nr_ranges++;
 	}
 
+	for (i = 0; i < crashk_cma_cnt; i++) {
+		cmem->ranges[cmem->nr_ranges].start = crashk_cma_ranges[i].start;
+		cmem->ranges[cmem->nr_ranges].end = crashk_cma_ranges[i].end;
+		cmem->nr_ranges++;
+	}
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 	kfree(cmem);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 524d34a0e921..28165d94af08 100644
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
-- 
2.34.1


