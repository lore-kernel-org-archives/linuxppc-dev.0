Return-Path: <linuxppc-dev+bounces-27823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CC3C982ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:04:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHNG25Syz30WT;
	Mon, 21 Sep 2026 19:04:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981454;
	cv=none; b=W7UWFthspYK9PhPnaNMO7nK3bqartEwSyRSX0OKfrB/TIN70hQx/vUoFe49hKo/1vmHMg4XElCZ9KhaeN5i9mhky5ZsnuRqJmGi8++HbCSytQaP/qZ+Q2ySwhSg8IngAYH0xYpe0UHl6eqy6pVNYqTgta+P7yBkSMkeTJAw2qVxjFn85zqDdiZfhtseDazeSeKIfvsgQkysjL2ySO39GHZ2X4oicb/BhP2/gS5Foq7AmPfUzPaOyDYG0DloTXY0si4h7leATH6rW0g/iUAAf0Qf0UzuS9NndVFNEn8Yx3LJdTkoMwFEnw0EWiaD6rh7L5BHSUcEGyB60FUFxOMXMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981454; c=relaxed/relaxed;
	bh=gpQ4A2b+D+By6QZW9O9qxQ5TRwnsaRRG5wXvsN8j1G0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIzt3NSGMSCNBSEQ1VVIbKwCOPk16ugvmhz/ok0sYsu0m+Lkq5AXENlAPeY5d6i2+zpHQtCd4NA5A4/a4USnikalFc0doJtVdZUkkNhod9C8anvwy9AfG58G8LYC84bFiEpZnekvcROfcBUzmuo9rMRygVL4zlRIc4HKg4dYvG5DNl7hN0+2jrRB3rb0EH7hHsz6/jzBPrPQI1VwP7b/YhmPxEscw/F9ChvI36Y6mlwh8dUxzLvtJ3WdwZpJgGbB6QoOD8K3W2lIaU2vtYwAK5PLTt0nCS7fPS2HV7jCyNwNJ12yqaA5432O+7MMDCkSox5zwntsQM5uJNn1g2ADEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5yDR7210; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5yDR7210;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHND5FMRz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:04:12 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gpQ4A2b+D+By6QZW9O9qxQ5TRwnsaRRG5wXvsN8j1G0=;
	b=5yDR7210dJfFq/El83BSXaQy/Jd4qrijPdu6t1uJW27ICVE72mId1HUucilMR6cVQd3YNcu7c
	xJ5//H/5qFgYAEzzu6wOukrEi962MoeeOLcvKCME4ofqLX6PhTa+0b5cozuDLTi8F4toCSxeO1s
	JMdlwRJnBmcNHALe2SgT2/w=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hpH665BLqzRhQs;
	Mon, 21 Sep 2026 16:51:58 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4738540561;
	Mon, 21 Sep 2026 17:03:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:03:57 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 01/14] kexec: Fix CMA segment address translation with non-zero text_offset
Date: Mon, 21 Sep 2026 17:04:37 +0800
Message-ID: <20260921090450.807575-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
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
 kwepemk200008.china.huawei.com (7.202.194.74)

kimage_load_cma_segment() and kimage_map_segment() both translate
a CMA segment using page_address(cma), which returns the CMA base
address. This ignores segment->mem.

On arm64, image_load() adds text_offset to segment->mem before the
segment is loaded:

	kernel_segment->mem += text_offset;
	kernel_segment->memsz -= text_offset;
	image->start = kernel_segment->mem;

so segment->mem no longer matches the CMA base.  The kernel payload is
therefore copied to the wrong offset, while image->start points past
it, and kexec jumps into the middle of the kernel.

kimage_map_segment() has the same problem for any CMA segment whose
mem has been moved.

Add kimage_cma_vaddr() to translate a boot physical address inside a
CMA segment to its virtual address, and use it in both places.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Justinien Bouron <jbouron@amazon.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/kexec_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..7f7cb77f0caa 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -738,11 +738,23 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	return page;
 }
 
+/*
+ * Translate a boot physical address inside a CMA segment to a kernel
+ * virtual address.  Architecture loaders may move segment->mem away from
+ * the CMA base (arm64 adds text_offset), so the offset must be preserved.
+ */
+static void *kimage_cma_vaddr(struct page *cma, unsigned long mem)
+{
+	unsigned long cma_base = page_to_boot_pfn(cma) << PAGE_SHIFT;
+
+	return page_address(cma) + (mem - cma_base);
+}
+
 static int kimage_load_cma_segment(struct kimage *image, int idx)
 {
 	struct kexec_segment *segment = &image->segment[idx];
 	struct page *cma = image->segment_cma[idx];
-	char *ptr = page_address(cma);
+	char *ptr = kimage_cma_vaddr(cma, segment->mem);
 	size_t ubytes, mbytes;
 	int result = 0;
 	unsigned char __user *buf = NULL;
@@ -965,7 +977,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
 
 	cma = image->segment_cma[idx];
 	if (cma)
-		return page_address(cma);
+		return kimage_cma_vaddr(cma, image->segment[idx].mem);
 
 	addr = image->segment[idx].mem;
 	size = image->segment[idx].memsz;
-- 
2.34.1


