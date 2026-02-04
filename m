Return-Path: <linuxppc-dev+bounces-16578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB28E95360
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 09:37:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Zxh2nVnz3bf4;
	Wed, 04 Feb 2026 20:36:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770197816;
	cv=none; b=P49FsD7NxldPGm8AdIdyRgtefmse+me1hsOH8a12kcsURn9xDgbT8YbJEemmCPFVCguuyps4oLeYDCZYtQfeTmSiHm3w86I+wJ2zB3JlbDa3qJiJ8lS7vMTF8PVfZwm8vo7K6qjlOU4baOwMl6Jm2bOoweuZL/FGFRa6sqSYuMUGISNzyUswfJJwK1ZTDx9hZEktUAujLSeEJ7MfKA63SfkIuDZUcW/XNLMaDF3n8T51ja/lXhE427ejRTTUITku8F/Vkdzf4E8vH71PQ11EpC9g82xG/PLbW/271W2Le+14sy+sCGXVBPVAwoeDfGPdS9sojuuCQVkroSh31Ri2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770197816; c=relaxed/relaxed;
	bh=JCg+l/0tXKCFf/mTir6vjlLYgbGXrZ03085YKEzTp9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5khc/Xh9UFwfADes+Y5eIAQ76XRGMJn0zdgczcDUGxe5sOekSK0a0UuL4rJgtjE3mljOSlw4p4XjsfoKgYwM24cYg+U3p8WTXWXllHuJ1biYqzYcgsUjJHRVxi7kEssSK/7vmwpX+8c7tgpxqjJafwpU7N/W5KejdXd35OjNi5tg18WbeNXMmNVI699IG7dBfxT7VbjlvoDbzaHJbiKWaOKaw17b0vwkNBOyunK7txveSKN6QUr3kNf+vrZbTE/nLif8pv+vw61nXv6NN2UHIlu4fq7nLciT4tJ9g7M6RKaY9+oc7thJLaskSZkbFh5G3gMQsoBYEyONWtfklhNQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Piy+D2Ae; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Piy+D2Ae; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Piy+D2Ae;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Piy+D2Ae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Zxf46YNz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 20:36:54 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JCg+l/0tXKCFf/mTir6vjlLYgbGXrZ03085YKEzTp9o=;
	b=Piy+D2Ae8+BF6TNKkVTiXKJnuFRuLSxDv9GIoqvekPwAbC38MSuPzE4rdAmNy3fDxpahTOecm
	sKzwPjEQ0ep8SD+2yLXGpYWSH2DZhEAqorz6ufVLlnMdITs3Fz1ny860+YBmJ0BWnHjZrHjvE/C
	Qjz9qZbGW0FgfxFyHLhAxEY=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4f5Zwl47qcz1BGD5
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2026 17:36:07 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JCg+l/0tXKCFf/mTir6vjlLYgbGXrZ03085YKEzTp9o=;
	b=Piy+D2Ae8+BF6TNKkVTiXKJnuFRuLSxDv9GIoqvekPwAbC38MSuPzE4rdAmNy3fDxpahTOecm
	sKzwPjEQ0ep8SD+2yLXGpYWSH2DZhEAqorz6ufVLlnMdITs3Fz1ny860+YBmJ0BWnHjZrHjvE/C
	Qjz9qZbGW0FgfxFyHLhAxEY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4f5ZrF0Lt0zRhRB;
	Wed,  4 Feb 2026 17:32:13 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A83CA40561;
	Wed,  4 Feb 2026 17:36:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 17:36:43 +0800
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
Subject: [PATCH v3 3/3] riscv: kexec: Add support for crashkernel CMA reservation
Date: Wed, 4 Feb 2026 17:37:28 +0800
Message-ID: <20260204093728.1447527-4-ruanjinjie@huawei.com>
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

Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
crashkernel= command line option") and commit ab475510e042 ("kdump:
implement reserve_crashkernel_cma") added CMA support for kdump
crashkernel reservation. This allows the kernel to dynamically allocate
contiguous memory for crash dumping when needed, rather than permanently
reserving a fixed region at boot time.

So extend crashkernel CMA reservation support to riscv. The following
changes are made to enable CMA reservation:

- Parse and obtain the CMA reservation size along with other crashkernel
  parameters.
- Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
- Include the CMA-reserved ranges for kdump kernel to use.
- Exclude the CMA-reserved ranges from the crash kernel memory to
  prevent them from being exported through /proc/vmcore, which is already
  done in the crash core.

Update kernel-parameters.txt to document CMA support for crashkernel on
riscv architecture.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++--------
 arch/riscv/kernel/machine_kexec_file.c          | 10 ++++++++--
 arch/riscv/mm/init.c                            |  5 +++--
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 36bb642a7edd..3b92324d3a03 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1119,14 +1119,14 @@ Kernel parameters
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 	crashkernel=size[KMG],cma
-			[KNL, X86, ARM64, ppc] Reserve additional crash kernel memory from
-			CMA. This reservation is usable by the first system's
-			userspace memory and kernel movable allocations (memory
-			balloon, zswap). Pages allocated from this memory range
-			will not be included in the vmcore so this should not
-			be used if dumping of userspace memory is intended and
-			it has to be expected that some movable kernel pages
-			may be missing from the dump.
+			[KNL, X86, ARM64, RISCV, ppc] Reserve additional crash
+			kernel memory from CMA. This reservation is usable by
+			the first system's userspace memory and kernel movable
+			allocations (memory balloon, zswap). Pages allocated
+			from this memory range will not be included in the vmcore
+			so this should not be used if dumping of userspace memory
+			is intended and it has to be expected that some movable
+			kernel pages may be missing from the dump.
 
 			A standard crashkernel reservation, as described above,
 			is still needed to hold the crash kernel and initrd.
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index fec3622a13c9..0e4ac70d5a9a 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -59,9 +59,9 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
-	int ret;
+	int ret, i;
 
-	nr_ranges = 1; /* For exclusion of crashkernel region */
+	nr_ranges = 1 + crashk_cma_cnt; /* For exclusion of crashkernel region */
 	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
 
 	cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
@@ -74,6 +74,12 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	if (ret)
 		goto out;
 
+	for (i = 0; i < crashk_cma_cnt; i++) {
+		cmem->ranges[cmem->nr_ranges].start = crashk_cma_ranges[i].start;
+		cmem->ranges[cmem->nr_ranges].end = crashk_cma_ranges[i].end;
+		cmem->nr_ranges++;
+	}
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index addb8a9305be..074d2d5f79ee 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1404,7 +1404,7 @@ static inline void setup_vm_final(void)
  */
 static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long low_size = 0;
+	unsigned long long low_size = 0, cma_size = 0;
 	unsigned long long crash_base, crash_size;
 	bool high = false;
 	int ret;
@@ -1414,11 +1414,12 @@ static void __init arch_reserve_crashkernel(void)
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base,
-				&low_size, NULL, &high);
+				&low_size, &cma_size, &high);
 	if (ret)
 		return;
 
 	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
+	reserve_crashkernel_cma(cma_size);
 }
 
 void __init paging_init(void)
-- 
2.34.1


