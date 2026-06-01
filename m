Return-Path: <linuxppc-dev+bounces-21791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140E7CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:49:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTTgn1GPhz2yv0;
	Mon, 01 Jun 2026 19:49:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780307349;
	cv=none; b=EhrlifVzTVjf2c5fPV2R/Bt99Favml75N9HrxMyusMv2D8nxkfoav/K5Klbc+WnO17wy4cELbfEcajOOyJLxbEWYxtghmo+lz2ZwCAGEpQVDesgSkiLjph3CvtcjkWpHdwqavwt+IxnqTTB42A7AeshpR6gBvJA/95OTP/oeBTyrkq5l7uvxltsuVlykZ0ZuCNbzhpUqgbtzqEakO7sYqHZR4+4tU16YGtF/ev7bMnKCMIdgZcwq8RfxOEaSN/jRYyF4FJ3yIKY8F8WTRtPETjJny59sSKIfd7RLxMkD6LA491z5GK5IoLq0GhWzRmzduc+sgbjo65KvUIwBhBr1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780307349; c=relaxed/relaxed;
	bh=mhbjseTwLH5bkq29znj9WodUduQsJ+dnwL0KiZfm0D0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmvKgnEuI78PpuhC/xU9lV96y/q5kstND9+gihMCS6G69qIX9+Az559oUbk2n24BCCSXjtdJOQKS5XkR2fY+atPLugHyYzqhdzDQRp5y7lbCglnUVmVkkDzIyvEZaEA1oLZIsuNumtas5HkKHMDzzWZR2DFL1G95Y25Y0Jhie/NKFsv3ySt2NhgJ4yI9STvQU0xX8DHBlIEgoyWoWs1cpEPGzP2jI4hQ8vPpL2t8zgiRVIRazzQLlid38ZEbEN50nx73XQTsziUSkNlzIxth5IJRP+uxDZWFgDtxECNdOULhatMqbllSUKLGb5JmzCQYSW5t12n89imUod/T04483g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bFXrEAmx; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bFXrEAmx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTTgm1W9hz2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 19:49:08 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mhbjseTwLH5bkq29znj9WodUduQsJ+dnwL0KiZfm0D0=;
	b=bFXrEAmxNUF6FjQBgDHXLvQgRz1WzTvJpan8xYXPMuWfugdqx4Wk0Iq4YlyEzum2/zn00Si80
	OoGDUvHH6r0WlRCzADhKozhdYN/ZsA3n/2DN5UKl/Z8ZltJVBpyZZVb/hA66rwLSaJ7innpLd3l
	iqivnTTAbyDpUGrGO3E1rrc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gTTVf21jPz1prLw;
	Mon,  1 Jun 2026 17:41:14 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 86E714048F;
	Mon,  1 Jun 2026 17:49:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:49:01 +0800
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
Subject: [PATCH v15 08/23] arm64: kexec_file: Fix image->elf_headers memory leak during retry loop
Date: Mon, 1 Jun 2026 17:47:50 +0800
Message-ID: <20260601094805.2928614-9-ruanjinjie@huawei.com>
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

Sashiko AI code review pointed out a potential memory leak of
image->elf_headers when load_other_segments() fails on error paths.

In the arm64 kexec_file file-load path, kexec_image.c runs a retry loop
calling kexec_add_buffer() to find a suitable location for the kernel
segment. On each iteration, load_other_segments() is invoked to allocate
and populate alternative segments such as initrd, DTB, and ELF headers.

However, if a placement or allocation failure occurs later in
load_other_segments() (e.g., when adding initrd or dtb), the execution
jumps to the out_err label. While this path restores image->nr_segments
via orig_segments, it returns an error back to the caller without freeing
the previously allocated image->elf_headers vmalloc buffer.

As a result, the retry loop in image_load() unconditionally allocates
new ELF headers on the next iteration and overwrites image->elf_headers,
permanently leaking the memory blocks allocated in previous iterations.

To fix this, decouple the ELF header allocation from the target-seeking
retry loop. Since the contents and size of ELF headers only depend on
the host memory layout and do not change with the kernel's physical
placement, move prepare_elf_headers() completely outside and prior to
the while retry loop in image_load().

And if kexec_add_buffer() for elf headers fails, not need to vfree
headers, because the err path will vfree `image->elf_headers` by calling
arch_kimage_file_post_load_cleanup().

This optimization eliminates redundant memory allocation/deallocation
overhead during kexec placement retries and eradicates the Use-After-Free
and memory leak risk.

Concurrently, remove the prepare_elf_headers() call from inside
load_other_segments() and have it directly reuse the single, pre-allocated
image->elf_headers.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Benjamin Gwin <bgwin@google.com>
Cc: stable@vger.kernel.org
Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segments fails")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v15:
- Use image->elf_headers and image->elf_headers_sz instead of adding function
  parameters for load_other_segments() to simplify the fix.
---
 arch/arm64/include/asm/kexec.h         |  1 +
 arch/arm64/kernel/kexec_image.c        | 16 ++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c | 23 +++++------------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..7ffa2ff5fcfd 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -128,6 +128,7 @@ extern int load_other_segments(struct kimage *image,
 		unsigned long kernel_load_addr, unsigned long kernel_size,
 		char *initrd, unsigned long initrd_len,
 		char *cmdline);
+extern int prepare_elf_headers(void **addr, unsigned long *sz);
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index ffcb7f9075e6..424b9527db09 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -89,6 +89,22 @@ static void *image_load(struct kimage *image,
 
 	kernel_segment_number = image->nr_segments;
 
+#ifdef CONFIG_CRASH_DUMP
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* load elf core header */
+		unsigned long headers_sz;
+		void *headers;
+
+		ret = prepare_elf_headers(&headers, &headers_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			return ERR_PTR(ret);
+		}
+		image->elf_headers = headers;
+		image->elf_headers_sz = headers_sz;
+	}
+#endif
+
 	/*
 	 * The location of the kernel segment may make it impossible to satisfy
 	 * the other segment requirements, so we try repeatedly to find a
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 13c247c28866..4cbb71e1f8ed 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -40,7 +40,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_CRASH_DUMP
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+int prepare_elf_headers(void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -105,32 +105,19 @@ int load_other_segments(struct kimage *image,
 	kbuf.buf_min = kernel_load_addr + kernel_size;
 
 #ifdef CONFIG_CRASH_DUMP
-	/* load elf core header */
-	void *headers;
-	unsigned long headers_sz;
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
-		if (ret) {
-			pr_err("Preparing elf core header failed\n");
-			goto out_err;
-		}
-
-		kbuf.buffer = headers;
-		kbuf.bufsz = headers_sz;
+		kbuf.buffer = image->elf_headers;
+		kbuf.bufsz = image->elf_headers_sz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = headers_sz;
+		kbuf.memsz = image->elf_headers_sz;
 		kbuf.buf_align = SZ_64K; /* largest supported page size */
 		kbuf.buf_max = ULONG_MAX;
 		kbuf.top_down = true;
 
 		ret = kexec_add_buffer(&kbuf);
-		if (ret) {
-			vfree(headers);
+		if (ret)
 			goto out_err;
-		}
-		image->elf_headers = headers;
 		image->elf_load_addr = kbuf.mem;
-		image->elf_headers_sz = headers_sz;
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
-- 
2.34.1


