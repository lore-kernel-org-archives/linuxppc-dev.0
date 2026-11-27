Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F07606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EH9gi59W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbTgM4vJpz3bf2;
	Fri, 27 Nov 2026 21:10:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795774207;
	cv=none; b=IuzmqPBYtCURaZ79tWUWiyoF+ONVLTAsp7JF4Jyt41zO7VY2BBRPHf0UpUae8f1C4/gtdwnlzmYz1fUoOUJOqmqhkPSiOWtFjd3zhxRmjAiFr4j6eu7uNDyNjz4jyVXCETOXu3hmL8+QRCEJYnBJ+ZPzhgH/LBBwYxHcQjenD/qGgjMj0Ee6h20ufr7MnQJadAw1KPlJ7hBQOD+UR0BK0HIIcHOISITDpF55Idq98Uyg+icq+EDeYpwqBrGAISIKEkAdC6zN6jwcbT3IjQnpUFc6P/w7rQMPq6mAjPiWUVKm+WA/AYkg/g7KY9YxRsMCYLNdVx6KmSY8ooOxcb0Z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795774207; c=relaxed/relaxed;
	bh=j5utrnwiKYMPXhLTIGusrabxZitsD+sBaIfvDHphdLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfZm8CHc8R/8jQjZf/reQR60/Vw5cOm2mfOOrhqOauTyv5UXSR0bG1yGxr/t54ukyQim1AmQfG6/tmwh8/jbMztIIZsAXK6EkyXD+VwDe79a5xP68l8niOqxlnB4cJSjsuEgLs8uIXQMk48Hcw0vwR53Coi0VMZlpSVgFXZRWbZPrmLQPPphpzhIkUrpKuVo61JtLdF4KMZQ3UiDPx0G9lT8/An+ijBNeJ324uz2fM+jOWa2OMvfCqeC1OthioC9bYCalQnn7gTuDlQ/QhUrfvW7Nt+2MUVoZEr2Rx7FKbZ9icd4HjJGjruF0vxLIbTIW0BG+1cwhAsrW/AfNZ16mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EH9gi59W; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EH9gi59W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbTgG5xBpz30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 21:10:02 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j5utrnwiKYMPXhLTIGusrabxZitsD+sBaIfvDHphdLU=;
	b=EH9gi59WRKCLGVPL7KzLlizykGbVtHwUkJ5qyJtTWeirYCS8rjK4vushHzcDqzzrFYov8fMSD
	EiYCC7qEx9YGHySFI8g2DBxNie8Nex06nbZD8lVGNaavrql7kNAij9tw5P+oulOnPSLNdol4QVy
	yUXOGvOhiTkFyhT+ngbz4UQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jbTdq2VG2zpStD;
	Fri, 27 Nov 2026 18:08:47 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4210940575;
	Fri, 27 Nov 2026 18:09:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 18:09:51 +0800
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
Subject: [PATCH v9 06/11] x86: kexec_file: Use the common segment helpers
Date: Fri, 27 Nov 2026 18:09:20 +0800
Message-ID: <20261127100925.3019877-7-ruanjinjie@huawei.com>
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

crash_load_segments() open codes the elf core header loading: it builds
the header, accounts for crash hotplug and places the segment.

Use kexec_prepare_elf_core_header() and kexec_add_elf_core_header()
instead.  The crash hotplug reserved size is still computed and recorded
here, as the VMCOREINFO, kernel map, CPU and memory range accounting is
x86 specific.

bzImage64_load() also loads the initrd by hand, use kexec_add_initrd()
for it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c           | 34 ++++++++++++++-----------------
 arch/x86/kernel/kexec-bzimage64.c |  8 +-------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e6f23933a6df..94c0dde6070a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -348,20 +348,20 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 
 int crash_load_segments(struct kimage *image)
 {
-	int ret;
-	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
+	unsigned long hotplug_sz;
+	unsigned long pnum = 0;
+	int ret;
 
 	/* Prepare elf headers and add a segment */
-	ret = crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
-				    &kbuf.bufsz, &pnum);
+	ret = kexec_prepare_elf_core_header(image, IS_ENABLED(CONFIG_X86_64),
+					    &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers	= kbuf.buffer;
-	image->elf_headers_sz	= kbuf.bufsz;
-	kbuf.memsz		= kbuf.bufsz;
+	hotplug_sz = image->elf_headers_sz;
+	kbuf.memsz = hotplug_sz;
 
 #ifdef CONFIG_CRASH_HOTPLUG
 	/*
@@ -374,28 +374,24 @@ int crash_load_segments(struct kimage *image)
 		pnum += 2 + CONFIG_NR_CPUS;
 
 	if (pnum < (unsigned long)PN_XNUM) {
-		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
-		kbuf.memsz += sizeof(Elf64_Ehdr);
-
+		hotplug_sz = pnum * sizeof(Elf64_Phdr) + sizeof(Elf64_Ehdr);
+		kbuf.memsz = hotplug_sz;
 		image->elfcorehdr_index = image->nr_segments;
-
-		/* Mark as usable to crash kernel, else crash kernel fails on boot */
-		image->elf_headers_sz = kbuf.memsz;
 	} else {
 		pr_err("number of Phdrs %lu exceeds max\n", pnum);
 	}
 #endif
 
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
-	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-	ret = kexec_add_buffer(&kbuf);
+
+	ret = kexec_add_elf_core_header(image, &kbuf);
 	if (ret)
 		return ret;
-	image->elf_load_addr = kbuf.mem;
-	kexec_dprintk("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
-	return ret;
+	/* Mark as usable to crash kernel, else crash kernel fails on boot. */
+	image->elf_headers_sz = hotplug_sz;
+
+	return 0;
 }
 #endif /* CONFIG_KEXEC_FILE */
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 3aa77006adab..c8e285c9a4c6 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -626,19 +626,13 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 
 	/* Load initrd high */
 	if (initrd) {
-		kbuf.buffer = initrd;
-		kbuf.bufsz = kbuf.memsz = initrd_len;
 		kbuf.buf_align = PAGE_SIZE;
 		kbuf.buf_min = MIN_INITRD_LOAD_ADDR;
-		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-		ret = kexec_add_buffer(&kbuf);
+		ret = kexec_add_initrd(image, &kbuf);
 		if (ret)
 			goto out_free_params;
 		initrd_load_addr = kbuf.mem;
 
-		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			      initrd_load_addr, initrd_len, initrd_len);
-
 		setup_initrd(params, initrd_load_addr, initrd_len);
 	}
 
-- 
2.34.1


