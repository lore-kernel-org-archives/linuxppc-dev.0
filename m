Return-Path: <linuxppc-dev+bounces-21450-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7DACD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 08:50:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP8jK6ptfz2yFK;
	Mon, 25 May 2026 18:50:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779699029;
	cv=none; b=eFs/+wo5lixtjMtcY5B0Go2uhLPHda9IDGV+dAwExMGhUFrrQBHVVMp78S+NmCmQGt8/KQv/DtRsvhwqyjYeW2IUZWgDL91aU0sW08AsQVMmpanaD2Vl+pgpUSJsX4t1XmgaQvzPDhVYCtCM0I34oFgbrOun8quX75oKnDSDVMbPtPcsDloDmpcpALzrcBxc2p80N1mBBdeF1vUjUEt498q2I4PEXR6svQOM09o81LDkIXJWZZAKsgb8pygPzv2GLGkNukC0rrje1k/cR5hbgpr/ffvxeMwSPGxnAet1DKmMoQDnfx+Y+iUenZAUIZ1xWLXdJA8pj+mf8v7qd4ZmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779699029; c=relaxed/relaxed;
	bh=VctIRm5lAJFH3/3rqu7TJDBqStDg22GQQJGyxd6VQOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe0j+fPgiQW07JR4wnCeCEF02LitBKJtJoUPpv5V8/PK1RJzHjUUrrSr5ZoBU4PunmW8Pc3/aCWncMO0ezAQchzwFLj11qGp69BoOvAuYn7PhmJ5TafnqvWaFgnzmRCRVAw3OOrxPlqCShuQRCedYzbCVGkgw3dfzDzd42fB+SCdzTlLxTJdBEo/kkelxoUkO9EOseP8gT/ylu9xEsUeqbc/FgRNzxBxowH5bWmuov02RfdmTtIP2ZKwikdLg3j6YJwExrmY0tW9re+Pn1E+gFbXGO+zdLmDqhS2S+9qKW+qanpytUQ1bTbGdYqKCt6K0a0HOxvRpkzzt4051e5aZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JjTb9Zuy; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JjTb9Zuy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP8jK1rb1z2yST
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 18:50:29 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VctIRm5lAJFH3/3rqu7TJDBqStDg22GQQJGyxd6VQOU=;
	b=JjTb9ZuyRL81W05a2ZBznFhspS+1KKmgedq2x2Y+WumyYTG0iD+s7V3MhQMw82JC3RKO3Ago9
	t4W0o/j8lAJZ3Qs8fmF1pr65YGN3prxXmWgDGSyH/9WtS0AdZJ103vFo6uUM8v/PF7Pv5jBaOR+
	zggbZqXICCr7ifTlx9gBH10=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gP8X44M72z1T4KB;
	Mon, 25 May 2026 16:42:28 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DA7B3202E6;
	Mon, 25 May 2026 16:50:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 May
 2026 16:50:22 +0800
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
Subject: [PATCH v14 04/17] arm64: kexec: Fix image->elf_headers memory leak during retry loop
Date: Mon, 25 May 2026 16:49:19 +0800
Message-ID: <20260525084932.934910-5-ruanjinjie@huawei.com>
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

Concurrently, remove the prepare_elf_headers() call from inside
load_other_segments() and have it directly reuse the single, pre-allocated
image->elf_headers. Also, ensure that image->nr_segments is explicitly
rolled back to kernel_segment_number on retry failures to safely discard
stale segment tracking state.

This optimization eliminates redundant memory allocation/deallocation
overhead during kexec placement retries and eradicates the Use-After-Free
and memory leak risk.

Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segments fails")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/kexec.h         |  3 ++-
 arch/arm64/kernel/kexec_image.c        | 22 ++++++++++++++++++++--
 arch/arm64/kernel/machine_kexec_file.c | 16 +++-------------
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..cc2f36b1b0d4 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -127,7 +127,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
 extern int load_other_segments(struct kimage *image,
 		unsigned long kernel_load_addr, unsigned long kernel_size,
 		char *initrd, unsigned long initrd_len,
-		char *cmdline);
+		char *cmdline, void *headers, unsigned long headers_size);
+extern int prepare_elf_headers(void **addr, unsigned long *sz);
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index b70f4df15a1a..79efeaeb71e9 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -44,6 +44,11 @@ static void *image_load(struct kimage *image,
 	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
+#ifdef CONFIG_CRASH_DUMP
+	/* load elf core header */
+	unsigned long headers_sz;
+	void *headers;
+#endif
 	int ret;
 
 	/*
@@ -89,6 +94,18 @@ static void *image_load(struct kimage *image,
 
 	kernel_segment_number = image->nr_segments;
 
+#ifdef CONFIG_CRASH_DUMP
+	if (image->type == KEXEC_TYPE_CRASH) {
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
@@ -99,7 +116,8 @@ static void *image_load(struct kimage *image,
 		kernel_segment = &image->segment[kernel_segment_number];
 		ret = load_other_segments(image, kernel_segment->mem,
 					  kernel_segment->memsz, initrd,
-					  initrd_len, cmdline);
+					  initrd_len, cmdline,
+					  headers, headers_sz);
 		if (!ret)
 			break;
 
@@ -107,7 +125,7 @@ static void *image_load(struct kimage *image,
 		 * We couldn't find space for the other segments; erase the
 		 * kernel segment and try the next available hole.
 		 */
-		image->nr_segments -= 1;
+		image->nr_segments = kernel_segment_number;
 		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	}
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index e31fabed378a..daf81a873bbd 100644
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
@@ -92,7 +92,8 @@ int load_other_segments(struct kimage *image,
 			unsigned long kernel_load_addr,
 			unsigned long kernel_size,
 			char *initrd, unsigned long initrd_len,
-			char *cmdline)
+			char *cmdline, void *headers,
+			unsigned long headers_sz)
 {
 	struct kexec_buf kbuf = {};
 	void *dtb = NULL;
@@ -105,16 +106,7 @@ int load_other_segments(struct kimage *image,
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
 		kbuf.buffer = headers;
 		kbuf.bufsz = headers_sz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
@@ -128,9 +120,7 @@ int load_other_segments(struct kimage *image,
 			vfree(headers);
 			goto out_err;
 		}
-		image->elf_headers = headers;
 		image->elf_load_addr = kbuf.mem;
-		image->elf_headers_sz = headers_sz;
 
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
-- 
2.34.1


