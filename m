Return-Path: <linuxppc-dev+bounces-21452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D11ECD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 08:51:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP8jS6nNHz2yQL;
	Mon, 25 May 2026 18:50:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779699036;
	cv=none; b=U0gFPVWjckAGl1oicYwqSVZyn0GXB6Pl1SO2mkMRCYU+FelL5edcL0V6+5596pgHbZn9+mVmGLUND1LULvJCTbjeTGyvyo9Qd9ejRiD+MtT/rbVgdE1RupLTAcenhYB08+zWJz9Aopdc4DjTvC3NUw9HitwBMzXd2OnRoI+i8HEEAbd2YPoYHCAJVL4SgJ4w1dRyyXclKmEAhubMQ+XvtR8LrQs9lsg5irVBVrmTHYannDLpWz9I3O3v3ZZAcnQNlHwOggE5I805pYOyFXsxIYlb6mA/+ikqcX3MNhjVJTcSmJMw3WHTskd4D/a9ruBDkBQvOfK3vkfpgehcI5bH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779699036; c=relaxed/relaxed;
	bh=KREnohZudRYElg3e3hdfHAZRWPOppD/SLYkuWRfyNA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouxy+kwe4bJFsmZkCNImqSOmllmdy5/UzyEbscTXb4ec9d3B+vD9VvsmZ5Vl4rp8PztTEPF35qeGJ+4OxO783NNms6su1jbNNpGWcaSfsTjSHq2dfzwaLVsl2PqBQN1z/oEd1lFamQDymbWGPI5q/Ly+GW0gXCaqy9RDWO5MKgJkj0bDefvAwrL62zPUq1kiczD8wZlrx0vIkCyrNH9gRn0i7cqMrQx0dJ9ot9FtHhY36UgSIFINBj2fyyB/StEJuHn9OhglAWhV4dZ09i76+fTQ0uf90yaYxB3/JCz40RfELgXLM/Tz9YEmdEzAsNfsLt10KcZBAltRdd1TXE6D4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=kXF8nwYG; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=kXF8nwYG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP8jS23Hdz2yN8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 18:50:36 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KREnohZudRYElg3e3hdfHAZRWPOppD/SLYkuWRfyNA8=;
	b=kXF8nwYG70ZpsZEcN1FmPVrWQYkcHel7tA8/Nnt//qhS/QCGBo/YqBDsJn+kO/9vyKg/MOHAl
	zn5OUHHaxXyNjaRYYVJ2u6N2oHr/FOVVBMQjtLICKSSORNAIQfk0oVJxAB9vpqecK/I15mMVB0L
	RH2WQbPC20KrhqtsexvWXro=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gP8XD2JdHz1T4KL;
	Mon, 25 May 2026 16:42:36 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 994374048F;
	Mon, 25 May 2026 16:50:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 16:50:30 +0800
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
Subject: [PATCH v14 06/17] arm64: kexec_file: Fix potential buffer overflow in prepare_elf_headers()
Date: Mon, 25 May 2026 16:49:21 +0800
Message-ID: <20260525084932.934910-7-ruanjinjie@huawei.com>
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

Sashiko AI code review pointed out there is a TOCTOU (Time-of-Check to
Time-of-Use) race condition in prepare_elf_headers() between the initial
pass that counts System RAM ranges and the second pass that populates them.
If a memory hotplug event occurs between these two steps, the number of
memory regions may increase, causing an out-of-bounds write to
the cmem->ranges[] array.

Directly introducing get_online_mems() inside prepare_elf_headers() would
trigger an immediate recursive read-after-write deadlock when invoked by
the runtime hotplug notification path (which already holds the hotplug
write lock).

To eliminate the TOCTOU window safely without deadlock risks, move the
get_online_mems() read lock to the top-level architecture image loaders.
Since these top-level loaders are strictly executed on the initial system
call path and are never re-entered by the runtime hotplug notifier, this
approach physically isolates the locking contexts. The system memory ranges
are forced to be statically frozen during the entire layout generation,
eradicating the buffer overflow vulnerability.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/kexec_image.c        | 4 ++++
 arch/arm64/kernel/machine_kexec_file.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 79efeaeb71e9..884e446f08e3 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/memory_hotplug.h>
 #include <linux/pe.h>
 #include <linux/string.h>
 #include <asm/byteorder.h>
@@ -96,11 +97,14 @@ static void *image_load(struct kimage *image,
 
 #ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH) {
+		get_online_mems();
 		ret = prepare_elf_headers(&headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
+			put_online_mems();
 			return ERR_PTR(ret);
 		}
+		put_online_mems();
 		image->elf_headers = headers;
 		image->elf_headers_sz = headers_sz;
 	}
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index daf81a873bbd..c0ace89ded92 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -59,6 +59,11 @@ int prepare_elf_headers(void **addr, unsigned long *sz)
 	cmem->max_nr_ranges = nr_ranges;
 	cmem->nr_ranges = 0;
 	for_each_mem_range(i, &start, &end) {
+		if (WARN_ON_ONCE(cmem->nr_ranges >= cmem->max_nr_ranges)) {
+			ret = -EAGAIN;
+			goto out;
+		}
+
 		cmem->ranges[cmem->nr_ranges].start = start;
 		cmem->ranges[cmem->nr_ranges].end = end - 1;
 		cmem->nr_ranges++;
-- 
2.34.1


