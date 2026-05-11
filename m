Return-Path: <linuxppc-dev+bounces-20676-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0392CD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 03:06:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDPkG0Kcjz2yLP;
	Mon, 11 May 2026 13:05:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778468757;
	cv=none; b=AC/nWREAu/R91wFVHztMeycFRYLzgNobff6tUsdAN2H3zRMmMZUQ/xG9aLiZUtFnCvw/S6FJrgheMXTDSzAaGUfWlahDZOPA9gl0yDxgWFhcYF1DWcolnh/rtf8ULpaPUugXGug0SA95T9KXyqRa/Q8bwbv2ykw73Oi0Zkt7hpMcRRrlOxRDk0ItpFCyS15Mpu/zJjwnziyXUZ62fgR9DWTgPCDlIVE1MSZBvUmBT/dz7cHc/8rheKyJVtSdJU6S33/LCC59nC3HkHe8IYYaxfshF4LnK0Y+vHQ1OwMwXVrs+/SYY/WbLWmwG+NM0naGJI7+RfHRWX4x8CfP2JXFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778468757; c=relaxed/relaxed;
	bh=gP8HfVClTHWeVnZhgkiJHpftRA/L/IH7204wUamvGpI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tgkx/CIz5928jxUaVkqsy9FKGfP5xY+O9hSJ7xSS/9aS/JVgWKuWLjrsdPbSHRLNpHmjw1l+7lZfvb7Ps/Ms5fzH35ddV/Zq82amkODw6hO0bdnQaQntVE9b2AB95+z81ha4d4FHM99sWeGf/OymqUpBHrJmvpCSmh5oQGCuzBHMTw8GSc+o8utJRLtJBeeYLTKoakzpuUBqxEodD7unIW5zcPpNFBv2exDIpj7L3c9aJisN3JKuB87YQXlNWdo4vH7Vnc+DoCdsYtZTOMqYPP/u/Y8yq5KK+N7GoSfyA+zHPrjeNuTvEkAz290FTwAPKwIzoEH0untZaDtFuL1aCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aC5ld2VG; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aC5ld2VG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDPkF0VDzz2yD6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 13:05:56 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gP8HfVClTHWeVnZhgkiJHpftRA/L/IH7204wUamvGpI=;
	b=aC5ld2VGwocK5wNF4kNLWzXRwqGy7VVPy2Y7aT6z1Plew96KuD/b6JVVo5tIpaUsuozqhNEBl
	Uq5G5iRkNwhE7Lb+guOM8yaJgFcRNxm/1aqoZHpEZ52JHGoLfBZO5hurcijEe7IxeJY4lGg8hJ6
	MUBIPE/iCbbNEzS2v3yjOWw=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gDPYR2FCnz1K9ZG;
	Mon, 11 May 2026 10:58:19 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CB14402AB;
	Mon, 11 May 2026 11:05:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 May
 2026 11:05:50 +0800
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
Subject: [PATCH v13 03/15] x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
Date: Mon, 11 May 2026 11:04:42 +0800
Message-ID: <20260511030454.1730881-4-ruanjinjie@huawei.com>
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

Since x86 supports crash hotplug, any data inconsistency caused by
a race during the initial load will be corrected by the subsequent
hotplug update. However, we must prevent a buffer overflow if the
number of memory regions increases between the two passes.

Add a boundary checking in prepare_elf64_ram_headers_callback() to ensure
that the number of populated ranges does not exceed
the allocated maximum.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 8d5f894a3108 ("x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cd796818d94d..fa6a1feb1bf1 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -226,6 +226,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
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


