Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C0606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Qniwr2Mp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCm8M53csz3bSK;
	Mon, 26 Oct 2026 18:53:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001203;
	cv=none; b=FUKEd8Ol4HT3l7KaJwhASL25jJBbsxMIUkABkE2/AUNfgNNv8sPjfcANXMB5QV6ZtI/RzdIjXXTMhwmqqcqzLkRrE5LiwGmp3S5+P8hqXdsokjcHP/se6USFsFK6+n1oCkdY4GX7wMZEAKe9yEK2uI3osZmj+WxzC801LfEem/UdztZhUmyJ+6B2VVpR/NwoRMnkmAqkqqiMlwA/eP16tGdIIOlLDXNtQ9inRuqYQrV7jfI4KX3NC5fpioMJ0FXvwVVAeU5OcbTd1ynqv3NjpfxM9gvqnGPrLpdBaP0dE5yrrFnVPTey0RCjFUs9NTAvF/2YcM65lD9lhJ1HcX5lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001203; c=relaxed/relaxed;
	bh=mfJDf2saZhRyM8lhlYVnrxJjuWkMOyjzX5Pm7gBK9aM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdimHOEpUkVd0V9oSHf8O6Hcs51HkQpkaft1In+hXprpMjICo1QrfKUJbdnqUAG/7YXW+J3oZZKF1BKgCkm0csnYB7qbH9aD/Arq4C6pOeaJUnGjvRTtPQsVnKl1anOj9/2ls3WS5VXWLrAJc4ZQ4vuzuTV3l/zrXaL7caT0BQYHIX1fZjc0QzfyJqrpAMmNtFhIcyCs5WoFONQKAX4M+52vqXY8a3ZEUPAvV2iS3fgoIsrcm/juijJCCsow19WUh67t7wkp8IWpI6W9jLtCjGlFPELLa4/hGvoyUhoVPmsgLp1cGxM9av1mknNkpcXKCh+3QCQjVuMtMwO0IbXQBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Qniwr2Mp; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Qniwr2Mp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCm8L4q9Cz2yR1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 18:53:22 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mfJDf2saZhRyM8lhlYVnrxJjuWkMOyjzX5Pm7gBK9aM=;
	b=Qniwr2MpK7TJoN1Qu7La4LzKRnHeo01r6FPCPpP3sshmuH6ql6KbjD55Cw/f61CYiRNabI0l/
	6PbkoAJqeToWnCcDZmm3Q5eTDMXEUJFkLUvBtmATOqy0YZvvTK81+hldzY2t/Q06ig7MJ0r+keq
	mgGy9JFFZIHNZY3aNER5I3M=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jCm852YzwzcbTF;
	Mon, 26 Oct 2026 15:53:09 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 598BC40579;
	Mon, 26 Oct 2026 15:53:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 15:53:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <ruanjinjie@huawei.com>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <robh@kernel.org>,
	<sourabhjain@linux.ibm.com>, <kees@kernel.org>, <coiby.xu@gmail.com>,
	<Yeking@Red54.com>, <tangyouling@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <hui.wang@canonical.com>, <sohammetha01@gmail.com>,
	<guoren@kernel.org>, <gaohan@iscas.ac.cn>, <kai.huang@intel.com>,
	<kas@kernel.org>, <vishal.l.verma@intel.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
Subject: [PATCH v7 13/15] arm64: kexec_file: Use kexec_load_other_segments() to simplify code
Date: Mon, 26 Oct 2026 15:51:59 +0800
Message-ID: <20261026075201.699550-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026075201.699550-1-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the local copy with the common helper.

The retry loop stays. And the DTB and the dm-crypt keys move to the setup
hook and the keys are loaded after the initrd now.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/kexec.h         |  5 --
 arch/arm64/kernel/kexec_image.c        | 12 +++-
 arch/arm64/kernel/machine_kexec_file.c | 95 ++++----------------------
 3 files changed, 23 insertions(+), 89 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..8fc04e0e7dad 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -123,11 +123,6 @@ extern const struct kexec_file_ops kexec_image_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
-
-extern int load_other_segments(struct kimage *image,
-		unsigned long kernel_load_addr, unsigned long kernel_size,
-		char *initrd, unsigned long initrd_len,
-		char *cmdline);
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 6ed1991e3142..f5a7f1f92afc 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -44,6 +44,12 @@ static void *image_load(struct kimage *image,
 	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
+	struct kexec_load_params params = {
+		.initrd = initrd,
+		.initrd_len = initrd_len,
+		.cmdline = cmdline,
+		.cmdline_len = cmdline_len,
+	};
 	int ret;
 
 	/*
@@ -101,9 +107,9 @@ static void *image_load(struct kimage *image,
 	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
 		/* Try to load additional data */
 		kernel_segment = &image->segment[kernel_segment_number];
-		ret = load_other_segments(image, kernel_segment->mem,
-					  kernel_segment->memsz, initrd,
-					  initrd_len, cmdline);
+		params.kernel_load_addr = kernel_segment->mem;
+		params.kernel_size = kernel_segment->memsz;
+		ret = kexec_load_other_segments(image, &params, false);
 		if (!ret)
 			break;
 
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index e7f280915e8d..44754b380bf1 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -63,91 +63,30 @@ int arch_crash_populate_cmem(struct crash_mem *cmem)
 }
 #endif
 
-/*
- * Tries to add the initrd and DTB to the image. If it is not possible to find
- * valid locations, this function will undo changes to the image and return non
- * zero.
- */
-int load_other_segments(struct kimage *image,
-			unsigned long kernel_load_addr,
-			unsigned long kernel_size,
-			char *initrd, unsigned long initrd_len,
-			char *cmdline)
+int arch_kexec_setup_other_segments(struct kimage *image,
+				    struct kexec_load_params *params,
+				    unsigned long initrd_load_addr)
 {
 	struct kexec_buf kbuf = {
 		.image = image,
-		/* not allocate anything below the kernel */
-		.buf_min = kernel_load_addr + kernel_size,
-		.buf_max = ULONG_MAX,
+		.buf_min = params->kernel_load_addr + params->kernel_size,
 	};
-	void *dtb = NULL;
-	unsigned long initrd_load_addr = 0, dtb_len,
-		      orig_segments = image->nr_segments;
-	int ret = 0;
+	unsigned long dtb_len;
+	void *dtb;
+	int ret;
 
-#ifdef CONFIG_CRASH_DUMP
-	/* load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = crash_prepare_headers(true, &kbuf.buffer, &kbuf.bufsz, NULL);
-		if (ret) {
-			pr_err("Preparing elf core header failed\n");
-			goto out_err;
-		}
-
-		if (unlikely(image->elf_headers))
-			vfree(image->elf_headers);
-
-		image->elf_headers = kbuf.buffer;
-		image->elf_headers_sz = kbuf.bufsz;
-
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = kbuf.bufsz;
-		kbuf.buf_align = SZ_64K; /* largest supported page size */
-		kbuf.top_down = true;
-
-		ret = kexec_add_buffer(&kbuf);
-		if (ret)
-			goto out_err;
-
-		image->elf_load_addr = kbuf.mem;
-
-		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
-
 		ret = crash_load_dm_crypt_keys(image);
 		if (ret)
-			goto out_err;
-	}
-#endif
-
-	/* load initrd */
-	if (initrd) {
-		kbuf.buffer = initrd;
-		kbuf.bufsz = initrd_len;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = initrd_len;
-		kbuf.buf_align = 0;
-		/* within 1GB-aligned window of up to 32GB in size */
-		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
-						+ (unsigned long)SZ_1G * 32;
-		kbuf.top_down = false;
-
-		ret = kexec_add_buffer(&kbuf);
-		if (ret)
-			goto out_err;
-		initrd_load_addr = kbuf.mem;
-
-		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
+			return ret;
 	}
 
 	/* load dtb */
 	dtb = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
-					   initrd_len, cmdline, 0);
+					   params->initrd_len, params->cmdline, 0);
 	if (!dtb) {
 		pr_err("Preparing for new dtb failed\n");
-		ret = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 
 	/* trim it */
@@ -163,8 +102,10 @@ int load_other_segments(struct kimage *image,
 	kbuf.top_down = true;
 
 	ret = kexec_add_buffer(&kbuf);
-	if (ret)
-		goto out_err;
+	if (ret) {
+		kvfree(dtb);
+		return ret;
+	}
 	image->arch.dtb = dtb;
 	image->arch.dtb_mem = kbuf.mem;
 
@@ -172,12 +113,4 @@ int load_other_segments(struct kimage *image,
 		      kbuf.mem, kbuf.bufsz, kbuf.memsz);
 
 	return 0;
-
-out_err:
-	while (image->nr_segments > orig_segments) {
-		kexec_free_segment_cma(image, image->nr_segments - 1);
-		image->nr_segments--;
-	}
-	kvfree(dtb);
-	return ret;
 }
-- 
2.34.1


