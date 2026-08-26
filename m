Return-Path: <linuxppc-dev+bounces-26109-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA8BC61DC2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:27:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVK591X5kz2yh4;
	Wed, 26 Aug 2026 19:25:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787736349;
	cv=none; b=f5E6N//sS1FFHRc50bol5bOIbWz0WLk9yBQRardbroBmlEdgj3Y+aod9tHpWoDF8pMizN5AddxD5I/6woH1/W9aS2UF1brroE4DoZZ3oUjs5PuD82qR+/uScGuFfa965qfSWwbLND1+QVuXlG5xUZ1b0QR/EtcQFzNNfKKFSjZIARGNfSK7vkkoaLPxPQyn5fY9eLwMUxEnt7rZQOusldL1snLicLy33uEzTamlaO/Fbt2mGa3Zy7qhh5M3khj4TXX/pjBw5zA1TLpX6XOy+2cn9WWoERGIOxwh9mc8L9wa+Z1skHc4w2IkWMVz9WzFWfXOsFwUEwPzszCd7Xno8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787736349; c=relaxed/relaxed;
	bh=oXgq3/Gz7CGC/Wi4k6l57KKkgsMLlKANbfKYe/2S3+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5dLTkOC9ILPXs7QAo230DXprkD3sLRIkTcRDebJ/wIXL6Y4f351OK2YjhJ1/B028TEobwxAf/5Y7QQh7ZkkDFWPO7+YHtFr8F+sX3jjwDOzK9frmN9JGVKtkBW1xfURrJfGaIK5LIyQ1fJKPvzZV6Izig9Rd0ueH8+rJkFzy94P6LZnvjmYHN4QsaDaU2MPQtnZB1vI6dVqkMviycxxI5tNVTXgCzwo93y1n0uzIUKGHFV+CgyYm0zdD9+PG/qPdlD1vUGvtbs29cc/quZZIfpuvIk6tZDw8R/w3zrZM8WCwXlrYQBStKARLVU2rH67vq8C23zgwfj01P3VzY31Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=M2WCjUV3; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=M2WCjUV3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVK566lYgz3c5N
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:25:46 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oXgq3/Gz7CGC/Wi4k6l57KKkgsMLlKANbfKYe/2S3+8=;
	b=M2WCjUV36RnHb5fNe4vvLb2ECdr0SMY463sjrUv623cM5rtnEGxtrh7Jm17vAKP9UZkTNrCdo
	4xEpxcC38LZJXMGdX94QIQPU5uBerz/eQFv4Hc6UV3ZlxTKy/gxQTre5I4ALJj/5VKN0N7CO2JZ
	Dri1ZnSNgYAZMZLggRJdoJE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrf11brzRhR0;
	Wed, 26 Aug 2026 17:14:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CE3AC40537;
	Wed, 26 Aug 2026 17:25:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<thuth@redhat.com>, <gshan@redhat.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 14/17] x86/crash: Simplify crash_load_segments() using crash_extra_elfcorehdr_size()
Date: Wed, 26 Aug 2026 17:25:38 +0800
Message-ID: <20260826092541.3905933-15-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826092541.3905933-1-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Replace the open-coded elfcorehdr reservation logic in
crash_load_segments() with the generic crash_extra_elfcorehdr_size()
helper. The helper centralizes all PN_XNUM and memory range checks,
reducing code duplication.

The elfcorehdr_index is handled separately in crash_handle_hotplug_event()
during the first hotplug event, so it does not need to be set in
crash_load_segments().

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index afe2aea19f47..99eb8583d932 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -348,42 +348,20 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 
 int crash_load_segments(struct kimage *image)
 {
-	int ret;
-	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
+	unsigned long nr_ranges = 0;
+	int ret;
 
 	/* Prepare elf headers and add a segment */
 	ret = crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
-				    &kbuf.bufsz, &pnum);
+				    &kbuf.bufsz, &nr_ranges);
 	if (ret)
 		return ret;
 
 	image->elf_headers	= kbuf.buffer;
-	image->elf_headers_sz	= kbuf.bufsz;
-	kbuf.memsz		= kbuf.bufsz;
-
-#ifdef CONFIG_CRASH_HOTPLUG
-	/*
-	 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map,
-	 * maximum CPUs and maximum memory ranges.
-	 */
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		pnum = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
-	else
-		pnum += 2 + num_possible_cpus();
-
-	if (pnum < (unsigned long)PN_XNUM) {
-		kbuf.memsz = elf64_phdr_size(pnum);
-
-		image->elfcorehdr_index = image->nr_segments;
-
-		/* Mark as usable to crash kernel, else crash kernel fails on boot */
-		image->elf_headers_sz = kbuf.memsz;
-	} else {
-		pr_err("number of Phdrs %lu exceeds max\n", pnum);
-	}
-#endif
+	kbuf.memsz = kbuf.bufsz + crash_extra_elfcorehdr_size(nr_ranges);
+	image->elf_headers_sz	= kbuf.memsz;
 
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
-- 
2.34.1


