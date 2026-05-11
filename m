Return-Path: <linuxppc-dev+bounces-20679-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA6CD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 03:06:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDPkL6KSJz2yZc;
	Mon, 11 May 2026 13:06:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778468762;
	cv=none; b=iM6IOIsyzpl6ttVKbTkYMQLQ4sIAwsab4t3d7KoqWK3HbZ5P3Y0/GViMX319QjlH9gu/dJfqVGUjnoqrCV4NM8H6+41KCwmabjmcalgqG3AA5+pXfOOrYGJ/KtqzjClJDq29W6sN4sBTBm9rPwqE5aa17fUbMVZAlcwEXB9aQkewLOkC+PJK5rZDxpX7N+lhsLUSggRoeVvkwXXhQJdOAsgqheqyHFjGpib7XIR8kne383aDxSgHiUXnn0m0/X+2HAmxKpxu3IJI5VHhiVvQXw3b4yKmzyX5mfdneqaEJQAEIkSje4VQbMHepDrQqvwB+6gvnf3Xypu5iZinxP7ufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778468762; c=relaxed/relaxed;
	bh=FN47AsrpVzfQTrIqYctGspIy+BM7hOr1EhL3a4fj6fE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8yD/YMFQy9etg6GV3G8oLUVyXh5BI+EGkIRLgQPw2YRag44Z5UGKPaziJ8mr7a5cH/vgIhsJxbLETuFXvUMunc3jxblIZOo4yV42OtaDOl6i7c8nIuxCwgEgbpxm+KKCiOAuLYA64p8/gp/38enE5ykALRSby0PcuQ05lJQ3KTPyvCLfGkm8FIj6Oma3hvKAxUz6AoGQbUbJb6MaQaYMAWXLy6tYRsnrLc79e/z2rkLN8OONerfRYQAWZVOAfxvtmuV6oS9Z9p1BJAS+EKiWiY9ylILYANjL6fROwq125+vVuYj43ceVmAyg0sdK4iQq1ORtNJv8Ju8qscbhhy3lA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DQSa+l/d; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DQSa+l/d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDPkL0bXWz2yTP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 13:06:02 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FN47AsrpVzfQTrIqYctGspIy+BM7hOr1EhL3a4fj6fE=;
	b=DQSa+l/dDuk3pu1UynnnYhnUqa2Hqh3YefLCNgbYC/xbzSjcLGTdCUgoKDPicUOOrh4wiQUqK
	dIPYDcAQopX4RC9PvgntmzdBspJyjbpLgDpuHVBGsmFO9bXGkMoVJHzX0dO41PQLu1X6ZICTQBs
	Oz87yLApXwFII6fr0p3twqI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gDPYX2HQJzRhrf;
	Mon, 11 May 2026 10:58:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id AC7C240537;
	Mon, 11 May 2026 11:05:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 May
 2026 11:05:56 +0800
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
	<rdunlap@infradead.org>, <pmladek@suse.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <paulmck@kernel.org>,
	<ruanjinjie@huawei.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<leitao@debian.org>, <jbohac@suse.cz>, <ryan.roberts@arm.com>,
	<osandov@fb.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <adityag@linux.ibm.com>, <guoren@kernel.org>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>,
	<wangruikang@iscas.ac.cn>, <namcao@linutronix.de>, <chao.gao@intel.com>,
	<seanjc@google.com>, <fuqiang.wang@easystack.cn>, <ardb@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v13 05/15] riscv: kexec_file: Fix potential buffer overflow in prepare_elf_headers()
Date: Mon, 11 May 2026 11:04:44 +0800
Message-ID: <20260511030454.1730881-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511030454.1730881-1-ruanjinjie@huawei.com>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
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

There is a race condition between the kexec_load() system call
(crash kernel loading path) and memory hotplug operations that can lead
to buffer overflow and potential kernel crash.

During prepare_elf_headers(), the following steps occur:
1. get_nr_ram_ranges_callback() queries current System RAM memory ranges
2. Allocates buffer based on queried count
3. prepare_elf64_ram_headers_callback() populates ranges from memblock

If memory hotplug occurs between step 1 and step 3, the number of ranges
can increase, causing out-of-bounds write when populating cmem->ranges[].

This happens because kexec_load() uses kexec_trylock (atomic_t) while
memory hotplug uses device_hotplug_lock (mutex), so they don't serialize
with each other.

While this works today because RISC-V server hardware with hotplug
support is still rare and most deployments use fixed memory configurations
(e.g., QEMU virt machine), it is technically fragile. So add bounds
checking in prepare_elf64_ram_headers_callback() to prevent
out-of-bounds (OOB) access.

No functional change for current RISC-V deployments, but makes
the code robust against future hotplug-capable platforms.

Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: songshuaishuai@tinylab.org
Cc: bjorn@rivosinc.com
Cc: leitao@debian.org
Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 3f7766057cac..773a1cba8ba0 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -48,6 +48,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
 	struct crash_mem *cmem = arg;
 
+	if (cmem->nr_ranges >= cmem->max_nr_ranges)
+		return -ENOMEM;
+
 	cmem->ranges[cmem->nr_ranges].start = res->start;
 	cmem->ranges[cmem->nr_ranges].end = res->end;
 	cmem->nr_ranges++;
-- 
2.34.1


