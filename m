Return-Path: <linuxppc-dev+bounces-26099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6877C61DC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:25:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVK4p5G5dz30CZ;
	Wed, 26 Aug 2026 19:25:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787736330;
	cv=none; b=SudMef25nfu4+5AjdORVSDMVHX/6clCyxrjJ5h6STIfWLgxw2k6k8a+1fLsRMDIlBWOux4tjqB+7gHaMAQgRw37kT/7fTfUshDbnAQv2nEi/1uDL7ha9BssGy7Aao58lb/99SbJaanf7YP+FjPMEnE3JClejoNLRBEqwIIQF49JzinzCtQE6+oZI/3TBusGztVOMJ4szU3YYlX45m3hvNDi90hop+oMH/u8bNYlXBmyaCkd2GNpELp+mhZZriJ5FA8jU8wOZFpKY4xp+Rix1BBN3KkPM8NuuPcDtBaJ/AvZ8b5t3Z5JI5Ytiwfqx+IBKEKf5VciHeWZ735GQoVJKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787736330; c=relaxed/relaxed;
	bh=6U6CPPAT7oq2s1cbcD6b76t+xbaZUc0osrokVU5xyX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om+CTObToCELPwFDglwA6HGj+jGnFqiVljL2rPib50z/bzOx9IO32zVP2ErIuelQgm9Uh+WR3rUpSlh6+3thVpTt6B4XRCBC0mWRmShysIUDEChs10tke70TDe+sOZKJp9+mrCBquv//+esFNoUWILStNB0LkOSt0tEhkDq0w72Ai8A2RqLoHzY8PW85RSRMP26s7Fu3igy4igdpy7dPxxs5DnIUYHrWIB6krttE0J/1GVSUcQTBCv3QP2HqxPxUi9wokheT12UfUfBzWZjq2AZcK64wVchvnnkyE1JE9aqmiucVNTNlvr876Gf1A1bHbr/JgU+bwPo4XA+1gTH2Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PPmdK3kJ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PPmdK3kJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVK4j2GRXz2yf9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:25:21 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6U6CPPAT7oq2s1cbcD6b76t+xbaZUc0osrokVU5xyX0=;
	b=PPmdK3kJEMBO9dLIkD+9RHj9K6ETQ7E3tZgwSwg33u+8Apv5S6QInyvdcPqW0uOeefZfFNifs
	avI2H1N0SMkKMKxRlaBr3B6rKK1J201kwoZ5XBWxgys2j83mYzT2hMzLuCu5ieeFkde+xyuGeWc
	2zoCN5E9bV1d+v7S1XueOJc=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrd1dDrznTVd;
	Wed, 26 Aug 2026 17:14:57 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A4F4340586;
	Wed, 26 Aug 2026 17:25:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:09 +0800
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
Subject: [PATCH v3 01/17] kexec: Record allocated CMA pages to fix release size mismatch
Date: Wed, 26 Aug 2026 17:25:25 +0800
Message-ID: <20260826092541.3905933-2-ruanjinjie@huawei.com>
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

The CMA pages allocated for a kexec segment are released using the
segment's memsz to calculate the number of pages. However, some
architecture loaders modify the segment's memsz after allocation
(e.g. arm64 subtracts text_offset), causing the release function to
free fewer pages than were originally allocated, leaking the remaining
CMA pages.

Add a per-segment `segment_cma_pages` array to store the number of
pages actually allocated from CMA. Populate it during
kexec_add_buffer() using the aligned memsz, and use it in
kimage_free_cma() to accurately release all allocated pages.

This avoids relying on the potentially modified segment->memsz and
prevents silent CMA memory leaks.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Brian Mak <makb@juniper.net>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Justinien Bouron <jbouron@amazon.com>
Cc: Li Chen <me@linux.beauty>
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/kexec.h |  1 +
 kernel/kexec_core.c   |  3 ++-
 kernel/kexec_file.c   | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0af8ae4fdd08..83c296c0eb6c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -349,6 +349,7 @@ struct kimage {
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
 	struct page *segment_cma[KEXEC_SEGMENT_MAX];
+	unsigned int segment_cma_pages[KEXEC_SEGMENT_MAX];
 
 	struct list_head control_pages;
 	struct list_head dest_pages;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..611b15bb1369 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -560,7 +560,7 @@ static void kimage_free_cma(struct kimage *image)
 
 	for (i = 0; i < image->nr_segments; i++) {
 		struct page *cma = image->segment_cma[i];
-		u32 nr_pages = image->segment[i].memsz >> PAGE_SHIFT;
+		unsigned int nr_pages = image->segment_cma_pages[i];
 
 		if (!cma)
 			continue;
@@ -568,6 +568,7 @@ static void kimage_free_cma(struct kimage *image)
 		arch_kexec_pre_free_pages(page_address(cma), nr_pages);
 		dma_release_from_contiguous(NULL, cma, nr_pages);
 		image->segment_cma[i] = NULL;
+		image->segment_cma_pages[i] = 0;
 	}
 
 }
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d8..bfae3fee7f2f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -670,7 +670,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
 
 static int kexec_alloc_contig(struct kexec_buf *kbuf)
 {
-	size_t nr_pages = kbuf->memsz >> PAGE_SHIFT;
+	size_t nr_pages = PFN_DOWN(kbuf->memsz);
 	unsigned long mem;
 	struct page *p;
 
@@ -756,6 +756,8 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
  */
 int kexec_add_buffer(struct kexec_buf *kbuf)
 {
+	unsigned long nr_segments = kbuf->image->nr_segments;
+	size_t nr_pages;
 	struct kexec_segment *ksegment;
 	int ret;
 
@@ -763,7 +765,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 	if (!kbuf->image->file_mode)
 		return -EINVAL;
 
-	if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
+	if (nr_segments >= KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
 	/*
@@ -789,12 +791,18 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
 		return ret;
 
 	/* Found a suitable memory range */
-	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
+	ksegment = &kbuf->image->segment[nr_segments];
 	ksegment->kbuf = kbuf->buffer;
 	ksegment->bufsz = kbuf->bufsz;
 	ksegment->mem = kbuf->mem;
 	ksegment->memsz = kbuf->memsz;
-	kbuf->image->segment_cma[kbuf->image->nr_segments] = kbuf->cma;
+	kbuf->image->segment_cma[nr_segments] = kbuf->cma;
+	if (kbuf->cma) {
+		nr_pages = (unsigned int)(PFN_DOWN(kbuf->memsz));
+		kbuf->image->segment_cma_pages[nr_segments] = nr_pages;
+	} else {
+		kbuf->image->segment_cma_pages[nr_segments] = 0;
+	}
 	kbuf->image->nr_segments++;
 	return 0;
 }
-- 
2.34.1


