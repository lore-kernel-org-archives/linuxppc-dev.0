Return-Path: <linuxppc-dev+bounces-18952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3233710BA424
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2026 07:41:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjTwT4Mdnz2yr8;
	Sat, 28 Mar 2026 18:41:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774683689;
	cv=none; b=Y5oGqnRNUzVqDpw3lDfM25sTKGX8Zv5R23J5/6hdGiLwKW0zjpKfeGM6E1w9J3JN8J3kDPFGxky8JcJa2al7q70SbQA3+ITAJIHPiCXuVKKbIVVFT+195UjGO0HFEfycaylWDxdT7sSTnmxBRxsbv1oxXv9lCaA1yZsEAoSZjVrsN+qKqjQLdu1H/VncuiYbB4cK3LD6+vqL4Wwx3d/MKwPaW2GB5FtQ1iY7UKDTciuxv/T7PAQNzlj5a9FvRiZBF2x9IvKymQdgYf3I6iKCDqsvpkYhUrNsYbCgYF0VEzHMEhvKxYxJbZDSSITezEC5FEtbtzpasDMKWda253gkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774683689; c=relaxed/relaxed;
	bh=7Ej/nGP6D4OZlN2NP0wOiKbhFa+CLfU7f01IuTLoNYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlfsPUl4X09AhW07y5gi1nVyhTD5xTuNa7+tNKeY4ansRTYgjOi8OUD91HdtNIS1X5bSPi8WqlDS8k25z9YbmW6koy5u1QdfrEqrhfXVlbVFVw9skQBxdsuy7aKXu622IXPrkWDcAOhxvc9Z+ZdsQfYwkgSRJSxxX42BLWJJlRBUBsJdJ7YVz6762TYK4v2/lwmpJ2HwnupQbjQ1friiJ6MKe7+Bp1gsYGK80AVmHsdqKMF4s7vgo9GjCIE9H5FIqVgdA3t1eugvht/8bh2pSn0PoF18ghbJCBlaXJmQPowOyMV3KYu3x44Sr1jtln+Miwt9CX1RqF21VQVNjBq+iA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PCikQ7pI; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PCikQ7pI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjTwS50b1z2ypm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 18:41:28 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7Ej/nGP6D4OZlN2NP0wOiKbhFa+CLfU7f01IuTLoNYc=;
	b=PCikQ7pIzeaKrzAs1XH/O8ZmZYPB9pV0fBIUYs2VLOstWE8QiBMRuVM3CIvEXipATIGW3TQ8X
	gcrx6UYl2RFLLYRjDgwBg3lAQFmP1VJZr1v/vi26ia8fHvOPtkTiccABS/ORh8k+igGZUfzsNYX
	1sRHQpEli+zR1tX+CITCvDo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fjTnL4BJGzLlsZ;
	Sat, 28 Mar 2026 15:35:18 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B7C44056C;
	Sat, 28 Mar 2026 15:41:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Mar
 2026 15:41:22 +0800
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
	<feng.tang@linux.alibaba.com>, <pawan.kumar.gupta@linux.intel.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <cfsworks@gmail.com>,
	<osandov@fb.com>, <jbohac@suse.cz>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<kevin.brodsky@arm.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <guoren@kernel.org>, <chenjiahao16@huawei.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<james.morse@arm.com>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v11 03/11] x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
Date: Sat, 28 Mar 2026 15:40:05 +0800
Message-ID: <20260328074013.3589544-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260328074013.3589544-1-ruanjinjie@huawei.com>
References: <20260328074013.3589544-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Just add bounds checking in prepare_elf64_ram_headers_callback() to
prevent out-of-bounds (OOB) access,

Fixes: 8d5f894a3108 ("x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 335fd2ee9766..7fa6d45ebe3f 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -225,6 +225,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
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


