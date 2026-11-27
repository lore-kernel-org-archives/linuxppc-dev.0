Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E44606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=I1MJXjfc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbTgK6qNkz3bbm;
	Fri, 27 Nov 2026 21:10:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795774205;
	cv=none; b=nueiIbbB+JIyF4RZVYL4Jtp14y/fIVgxN6AWp9dzbREobTBPiklrIHaBlFQg/fvasKdaIW2qPM7aiVhK4Tzww+YLE9940tPMiLRW094kBdLPPJPRRJphpJQHa/mf1v7vREwvr253rbqsaAJsTTcyssIWodKp9WHBRA02JhPU5Q5ap4HdSmNlm+4ElmZqq905W47L1O8kWIYiiJCg/TvLVpgUwkFefJQB0Li0bhrg6dvoYYOaZnm6e7kLEzbsipHazsoYgfdJk7krKoCJkDWX7SV3gOY79ZwDrRvHJFougHE8V6mJc7JsY+yOSzrmxxRSDqOYjlqYmY6EmnWqjsaDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795774205; c=relaxed/relaxed;
	bh=XQb1skFCjLphQHWfA2YEBdV+jAhH6kVOU72rY/VpDtA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/58F4n5KGtdcVQY8OGLDZSyKFIJSoYha3II9A4qTbM2AI9PZWBS2Er8AJQ20Ix9C+3RI9U141eqJCExsg85/4RMz2lENGUNoud7lZOD1/+d7PsesT2X4o0Yze3jYCJBEMycnSkS3R/5N/lwoAbv33jkbXpKjgRGKkgax1lEmfBe/+ZxVs66SZMNzU2TxSqmBYFWvTHrSENQceXaVDaT0QRptmeAZEivJLm6RHbRyB73qWAEkB+aed4N157nVKW35PRPz0P8ayg7n7t17Yri53UEAquc1I+bwLDhn4I8OiewDErGKl6BydDZB7OwOVCgamPtP4TKezqAmhOQE2hi7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=I1MJXjfc; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=I1MJXjfc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbTgC1mnkz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 21:09:58 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XQb1skFCjLphQHWfA2YEBdV+jAhH6kVOU72rY/VpDtA=;
	b=I1MJXjfcizOvg7LgeufidGKqECOwTqHeXQmh59XulFZAjVQYFbjwfTn2PmpsihH6pNQ/vgJWd
	VYBXso2Wx9GFNmSXc7OPAh8+FJw69cRBa5Ez4rAhFIb7GwKrcBY9pWFzXe24Rc9uCkowL0bCk0d
	CM3pJcKDNVCbVT7BvBcetEk=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jbTdk1tkHzcb26;
	Fri, 27 Nov 2026 18:08:42 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 69A3E4057F;
	Fri, 27 Nov 2026 18:09:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 18:09:49 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ben@cressey.dev>, <leitao@debian.org>, <mpilaniy@redhat.com>,
	<yeoreum.yun@arm.com>, <coiby.xu@gmail.com>, <Yeking@Red54.com>,
	<prudo@redhat.com>, <bradley.morgan@linux.dev>, <sourabhjain@linux.ibm.com>,
	<blum@kernel.org>, <hbathini@linux.ibm.com>, <qirui.001@bytedance.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <ionut.nechita@windriver.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <ardb@kernel.org>,
	<arnd@arndb.de>, <tzimmermann@suse.de>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <mhklinux@outlook.com>, <piliu@redhat.com>,
	<shradhagupta@linux.microsoft.com>, <thuth@redhat.com>,
	<ebiggers@kernel.org>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <tangyouling@kylinos.cn>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v9 05/11] riscv: kexec_file: Load the extra segments with common helpers
Date: Fri, 27 Nov 2026 18:09:19 +0800
Message-ID: <20261127100925.3019877-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127100925.3019877-1-ruanjinjie@huawei.com>
References: <20261127100925.3019877-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the common segment helpers to load the elf core header, the initrd
and the DTB instead of open coding them.  The initrd and the command line
come from the image.

Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/include/asm/kexec.h         |  4 +-
 arch/riscv/kernel/kexec_elf.c          |  3 +-
 arch/riscv/kernel/kexec_image.c        |  3 +-
 arch/riscv/kernel/machine_kexec_file.c | 79 +++++++-------------------
 4 files changed, 24 insertions(+), 65 deletions(-)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index e218835eb10c..34da4d0e2cdc 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -70,9 +70,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 
 int load_extra_segments(struct kimage *image, unsigned long kernel_start,
-			unsigned long kernel_len, char *initrd,
-			unsigned long initrd_len, char *cmdline,
-			unsigned long cmdline_len);
+			unsigned long kernel_len);
 #endif
 
 #ifdef CONFIG_CRASH_HOTPLUG
diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/kexec_elf.c
index ca5abbad59e5..2071a22b846c 100644
--- a/arch/riscv/kernel/kexec_elf.c
+++ b/arch/riscv/kernel/kexec_elf.c
@@ -126,8 +126,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	if (ret)
 		goto out;
 
-	ret = load_extra_segments(image, image->start, kernel_len,
-				  initrd, initrd_len, cmdline, cmdline_len);
+	ret = load_extra_segments(image, image->start, kernel_len);
 out:
 	kexec_free_elf_info(&elf_info);
 	return ret ? ERR_PTR(ret) : NULL;
diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
index 963a25f5b55b..010a84085cf8 100644
--- a/arch/riscv/kernel/kexec_image.c
+++ b/arch/riscv/kernel/kexec_image.c
@@ -83,8 +83,7 @@ static void *image_load(struct kimage *image,
 	pr_info("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 		kbuf.mem, kbuf.bufsz, kbuf.memsz);
 
-	ret = load_extra_segments(image, kbuf.mem, kbuf.memsz,
-				  initrd, initrd_len, cmdline, cmdline_len);
+	ret = load_extra_segments(image, kbuf.mem, kbuf.memsz);
 
 out:
 	return ret ? ERR_PTR(ret) : NULL;
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 1d67fb42617a..a8b6767cbf6a 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -236,53 +236,37 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 
 
 int load_extra_segments(struct kimage *image, unsigned long kernel_start,
-			    unsigned long kernel_len, char *initrd,
-			    unsigned long initrd_len, char *cmdline,
-			    unsigned long cmdline_len)
+			unsigned long kernel_len)
 {
-	int ret;
-	void *fdt;
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = kernel_start + kernel_len,
+		.buf_max = PFN_PHYS(max_low_pfn),
+	};
+	char *cmdline = image->cmdline_buf;
 	unsigned long initrd_pbase = 0UL;
-	struct kexec_buf kbuf = {};
 	char *modified_cmdline = NULL;
-
-	kbuf.image = image;
-	kbuf.buf_min = kernel_start + kernel_len;
-	kbuf.buf_max = PFN_PHYS(max_low_pfn);
+	void *fdt = NULL;
+	int ret = 0;
 
 #ifdef CONFIG_CRASH_DUMP
 	/* Add elfcorehdr */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		void *headers;
-		unsigned long headers_sz;
-		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
-		if (ret) {
-			pr_err("Preparing elf core header failed\n");
+		ret = kexec_prepare_elf_core_header(image, true, NULL);
+		if (ret)
 			goto out;
-		}
 
-		kbuf.buffer = headers;
-		kbuf.bufsz = headers_sz;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		kbuf.memsz = headers_sz;
 		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 		kbuf.top_down = true;
+		kbuf.memsz = image->elf_headers_sz;
 
-		ret = kexec_add_buffer(&kbuf);
-		if (ret) {
-			vfree(headers);
+		ret = kexec_add_elf_core_header(image, &kbuf);
+		if (ret)
 			goto out;
-		}
-		image->elf_headers = headers;
-		image->elf_load_addr = kbuf.mem;
-		image->elf_headers_sz = headers_sz;
-
-		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 		/* Setup cmdline for kdump kernel case */
 		modified_cmdline = setup_kdump_cmdline(image, cmdline,
-						       cmdline_len);
+						       image->cmdline_buf_len);
 		if (!modified_cmdline) {
 			pr_err("Setting up cmdline for kdump kernel failed\n");
 			ret = -EINVAL;
@@ -311,46 +295,25 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 #endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
 
 	/* Add the initrd to the image */
-	if (initrd != NULL) {
-		kbuf.buffer = initrd;
-		kbuf.bufsz = kbuf.memsz = initrd_len;
+	if (image->initrd_buf) {
 		kbuf.buf_align = PAGE_SIZE;
 		kbuf.top_down = true;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		ret = kexec_add_buffer(&kbuf);
+		ret = kexec_add_initrd(image, &kbuf);
 		if (ret)
 			goto out;
 		initrd_pbase = kbuf.mem;
-		kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_pbase);
 	}
 
 	/* Add the DTB to the image */
-	fdt = of_kexec_alloc_and_setup_fdt(image, initrd_pbase,
-					   initrd_len, cmdline, 0);
-	if (!fdt) {
-		pr_err("Error setting up the new device tree.\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	fdt_pack(fdt);
-	kbuf.buffer = fdt;
-	kbuf.bufsz = kbuf.memsz = fdt_totalsize(fdt);
 	kbuf.buf_align = PAGE_SIZE;
-	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.top_down = true;
-	ret = kexec_add_buffer(&kbuf);
-	if (ret) {
-		pr_err("Error add DTB kbuf ret=%d\n", ret);
-		goto out_free_fdt;
-	}
+	ret = of_kexec_add_fdt(image, &kbuf, initrd_pbase, cmdline, &fdt);
+	if (ret)
+		goto out;
+
 	/* Cache the fdt buffer address for memory cleanup */
 	image->arch.fdt = fdt;
-	kexec_dprintk("Loaded device tree at 0x%lx\n", kbuf.mem);
-	goto out;
 
-out_free_fdt:
-	kvfree(fdt);
 out:
 	kfree(modified_cmdline);
 	return ret;
-- 
2.34.1


