Return-Path: <linuxppc-dev+bounces-21801-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C052DCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:51:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTThX4Lk2z3br5;
	Mon, 01 Jun 2026 19:49:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780307388;
	cv=none; b=mgGVLGCYnz6LlFT2YyYJ9xjc1c+nj4rRawqGmdK/89YReMx+SQoE3iyoMq6etThQYlfGRGWtDkMQ/60k8gMjFcKo0dIJTS892z7/6IywcXSFuZBF/AJtfAlDHxb9rm6Uk3m/bc6Ee1EC/IRdU+c8gNWeW7B1ryTFZQiqjHUDW1hqAthYBOJfXyJ0HGSfKwprTYWzgcHq8uBoqiFpZYKw3Ak9Mw6sL+ZoeIwkQJQNRj3PSm2aNCECM9dMSucGLtXXk9auE1/OR7+nyZiua0S4oer9YQJDAi8SAnRw6z9pOd8PqNmu1E7LlNfn9oA2TCP2egdv+VSmNxbSejsZzQ7zQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780307388; c=relaxed/relaxed;
	bh=frzGmIOj99V2r64L7a8e+rlKnHjd0zMn3ig4b5s7qY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsK/pO3cin7REUQH5ppTdS+qwv5rLB+NJUKwfysgr6P7kzML9dEqe0eMY+UDgnjxNKu6yp3/XUbqye6be901jFxebgXInsFXfKxbw/BjiWBDpv1yLxIYM2nEKPLQDrF1+GAJVoq9R8pjWwqnWM8hcCgR0n7zfBlpa8/NFvBfApU7Ik+5z0PwYZDndeDcAmEgEr0Qw9Wa5csj18UnaQ050oRRDOJ1pNbXNon6lpGPWJUzzs4OUIVut/6BbakMLZRxCL1LQksLQLtKrtwHYgx0fjll2ieRokMeRqJwmevOfnRK+TnjDejwJayOj2oGwdGjjOqoHUhJVWoxaq0GSQFHPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=mS7gkiH2; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=mS7gkiH2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTThW5B2Jz2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 19:49:47 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=frzGmIOj99V2r64L7a8e+rlKnHjd0zMn3ig4b5s7qY0=;
	b=mS7gkiH2dGhIoSKGtoTWyAewmvp6gOB6dLP5+6oxlYySTBRhXNvWi45ZkKaY2BkLksFCgXbwU
	RHNUZoF4VpvM19xa8VK6ZFbEK1wDxmJ/Vxzi0JZMp9AArq6KP5/a89+GIa756akZX/VCqYQZ6Ar
	fHDJ1eV9LU+DG2w64UAIZzU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gTTWL31dVznTXy;
	Mon,  1 Jun 2026 17:41:50 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F86540563;
	Mon,  1 Jun 2026 17:49:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:49:40 +0800
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
	<rdunlap@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <sourabhjain@linux.ibm.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <masahiroy@kernel.org>, <gshan@redhat.com>,
	<james.morse@arm.com>, <maz@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <suzuki.poulose@arm.com>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <djordje.todorovic@htecgroup.com>,
	<austin.kim@lge.com>, <namcao@linutronix.de>, <djbw@kernel.org>,
	<chao.gao@intel.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <makb@juniper.net>, <graf@amazon.com>,
	<piliu@redhat.com>, <rafael.j.wysocki@intel.com>,
	<mario.limonciello@amd.com>, <jbouron@amazon.com>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v15 18/23] riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
Date: Mon, 1 Jun 2026 17:48:00 +0800
Message-ID: <20260601094805.2928614-19-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601094805.2928614-1-ruanjinjie@huawei.com>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
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
 arch/riscv/kernel/machine_kexec_file.c | 49 +++++++-------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index f3576dc0513f..6e2a6747d187 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -44,6 +44,16 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 	return 0;
 }
 
+unsigned int arch_get_system_nr_ranges(void)
+{
+	/* For exclusion of crashkernel region */
+	unsigned int nr_ranges = 2 + CRASH_HOTPLUG_SAFETY_PADDING;
+
+	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+
+	return nr_ranges;
+}
+
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
 	struct crash_mem *cmem = arg;
@@ -58,42 +68,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem;
-	unsigned int nr_ranges;
-	int ret;
-
-	/* For exclusion of crashkernel region */
-	nr_ranges = 2 + CRASH_HOTPLUG_SAFETY_PADDING;
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
@@ -285,7 +262,7 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		void *headers;
 		unsigned long headers_sz;
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out;
-- 
2.34.1


