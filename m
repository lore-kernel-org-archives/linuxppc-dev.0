Return-Path: <linuxppc-dev+bounces-22172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF0BCD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 07:37:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYkPs64vHz3bpm;
	Mon, 08 Jun 2026 17:36:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780904209;
	cv=none; b=oyimRLVoMWsxkeMLWtj50zpuv9OAbz6vefNFZrRiBUO3drO4IWA9Cyq0JOhSv5RvZzaXP/smtfMVRaf8PrA5O/CfjHZUlHgtkkXBVC8jFj7HSRpwcqkJZv3BYY+fRK3TuaJoR5nsTBxKTEdgBxBzd2Wb7MUx4nDNaDD+6rf3TNLxSovd4kFPk8tK/NBXZkYT7muOoBEn7crZReW11Q0SUH26uKK2Tkz8yOs1Ci9JKRBn8m9cppS+7JUeqGf+KTfclfFLSR+vnK7eJBPQmqi3sj62+uc+DfCfSXtP0GfX7r8vDaBzN74VilCNgcHEc2RwlDu0v7m+i2iVnUSaj+Kn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780904209; c=relaxed/relaxed;
	bh=OhQ1+25EUpbXCPTD4GC5P+SdsvIWWE9q8awCUHeFRBs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I19P7HvC1bS16uZhh3wUDwe0C2WeYd/5XKSI0ytk8r2ePjBD5x4BKF9ihJhRdipbFx1F4A3IT8Hq8DYKhSRx15c2uAOLOe3DyZvLeKtKXVibmAjikKPuz0j5z320pHIcoAlq8MooBY85Z21xUxEsYw+HRJmWDczDGlTPwlw4doHHxjcFPQjeJKMwn2tk7kc9/mCyIBvXROehk8CJJ1sz/uLaTDjokm/DU1FxzHOvBsHGpV/YELMGb8ZU5m/lfBcktKDHoVEKiyPKnePbmSWeoV9OJhH47+ljYkkbtCheWMIlJo0cBKPZTdOKL35BaWUH8i0EPAauNxjfGUTSWC3cWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=R0n8hhby; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=R0n8hhby;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYkPr73lKz3bpM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 17:36:48 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OhQ1+25EUpbXCPTD4GC5P+SdsvIWWE9q8awCUHeFRBs=;
	b=R0n8hhbyS+KPo2UGjzZaAsBTUQAYuYq0T4WoeogjMYbACMQ0EbBoz3wE/7AQfiiBs5rdSdiJR
	gr3SUuUmvYQm1Dj2nKmXVOyrT1Ug2A/qBzmBT7B1hp0LHawwnp553K4/S8gORt8PDId5bTscpAU
	uH5QiS/9jvWGeYLzmk/RKEE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gYkDj040ZzRhwn;
	Mon,  8 Jun 2026 15:28:52 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 88F2140572;
	Mon,  8 Jun 2026 15:36:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Jun
 2026 15:36:42 +0800
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
Subject: [PATCH v16 09/10] arm64: kexec_file: Add support for crashkernel CMA reservation
Date: Mon, 8 Jun 2026 15:34:58 +0800
Message-ID: <20260608073459.3119290-10-ruanjinjie@huawei.com>
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

Tested-by: Breno Leitao <leitao@debian.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Baoquan He <bhe@redhat.com>
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
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/arm64/kernel/machine_kexec_file.c          | 2 +-
 arch/arm64/mm/init.c                            | 5 +++--
 drivers/of/fdt.c                                | 9 +++++----
 drivers/of/kexec.c                              | 9 +++++++++
 include/linux/crash_reserve.h                   | 4 +++-
 6 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..52742fab49a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1119,7 +1119,7 @@ Kernel parameters
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 	crashkernel=size[KMG],cma
-			[KNL, X86, ppc] Reserve additional crash kernel memory from
+			[KNL, X86, ARM64, PPC] Reserve additional crash kernel memory from
 			CMA. This reservation is usable by the first system's
 			userspace memory and kernel movable allocations (memory
 			balloon, zswap). Pages allocated from this memory range
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index b019b31df48c..854d872dfd0f 100644
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
index 97987f850a33..227f58522dad 100644
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
index 82f7327c59ea..0470acbd1fcf 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -880,11 +880,12 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 /*
  * The main usage of linux,usable-memory-range is for crash dump kernel.
  * Originally, the number of usable-memory regions is one. Now there may
- * be two regions, low region and high region.
- * To make compatibility with existing user-space and older kdump, the low
- * region is always the last range of linux,usable-memory-range if exist.
+ * be 2 + CRASHK_CMA_RANGES_MAX regions, low region, high region and cma
+ * regions. To make compatibility with existing user-space and older kdump,
+ * the high and low region are always the first two ranges of
+ * linux,usable-memory-range if exist.
  */
-#define MAX_USABLE_RANGES		2
+#define MAX_USABLE_RANGES		(2 + CRASHK_CMA_RANGES_MAX)
 
 /**
  * early_init_dt_check_for_usable_mem_range - Decode usable memory range
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index b6837e299e7f..029903b986cb 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -458,6 +458,15 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 			if (ret)
 				goto out;
 		}
+
+		for (int i = 0; i < crashk_cma_cnt; i++) {
+			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+					"linux,usable-memory-range",
+					crashk_cma_ranges[i].start,
+					crashk_cma_ranges[i].end - crashk_cma_ranges[i].start + 1);
+			if (ret)
+				goto out;
+		}
 #endif
 	}
 
diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
index f0dc03d94ca2..30864d90d7f5 100644
--- a/include/linux/crash_reserve.h
+++ b/include/linux/crash_reserve.h
@@ -14,9 +14,11 @@
 extern struct resource crashk_res;
 extern struct resource crashk_low_res;
 extern struct range crashk_cma_ranges[];
+
+#define CRASHK_CMA_RANGES_MAX 4
 #if defined(CONFIG_CMA) && defined(CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION)
 #define CRASHKERNEL_CMA
-#define CRASHKERNEL_CMA_RANGES_MAX 4
+#define CRASHKERNEL_CMA_RANGES_MAX (CRASHK_CMA_RANGES_MAX)
 extern int crashk_cma_cnt;
 #else
 #define crashk_cma_cnt 0
-- 
2.34.1


