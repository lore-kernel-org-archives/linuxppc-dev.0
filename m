Return-Path: <linuxppc-dev+bounces-27819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55399C982ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:04:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHNB4XnTz2yft;
	Mon, 21 Sep 2026 19:04:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981450;
	cv=none; b=bO1RyEnO6HzhtCJK1uTnJIiVqpMUfYcxiwxWrsnvD6RKzSULNAgVPFGAgq1/VCN7/vlvxfYQUqp7gH3p7/RRf6kOvSQlJZrpdWFPAcMKSD0QLwVPQ+lH+QM2UtRVVsLcQ7UEz54No6GHeJIpEAkJUyakY1vHvIVmWpwO3/lME637aZ7gvh/G62J55QZ45inDv/ClxpzO8lNLFecPXqMz7Og/I+6xDt9/faIAIWe9cUn1d4bwRrCA8VQxxK5CYOFDBxqAJq4rQhPFoUnQZc1mcGWCGsT1NYG7M3OM2OAi3lVC+USpHmNXYY83G72hGAbFnb8e68Tjpwr/uezIpYCFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981450; c=relaxed/relaxed;
	bh=B+70TPDD35nexD8E4QoPE3SOYsXBOKYnCVcHssGZ2ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dP7il2kDoEtltiLos3qUFYGZB+xHR4FO+b27JyIQPJHnRsrFd6eo/0VF72TCPX/WWrPiTIZZT5I41dSpNxLJeO1UedoDjRRS6+6OmMZtMK5VaIe7m0OilM/jsgSVFoKZhC+VW8pOFehr8geVIgYn3sRyTzzjDk9JY2weiB3ECO5Q/U46crGRYVk16WHUXIZK0lE5HO9Bv4O+fZSLgSMjlskF+758Bc37+4cECb41QbdEDTAfK/A3ycLA4JlfWh08fvN8TZbjCAkAlimB20GdgDBK7C1Uf9wlAqGJdmREQpuW5OK+GSZ3Q18j4hYjVdrX4Caa/wzYX2ilDZOUFY1zaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=pbi6s2T9; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=pbi6s2T9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHN92X6Pz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:04:09 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=B+70TPDD35nexD8E4QoPE3SOYsXBOKYnCVcHssGZ2ag=;
	b=pbi6s2T9Am2gqC06IbJsrFr/pvE3E9XWw6VsBqhZOOS3LOhAstM0zNEtS0NaTRhOIQ6WKpZY7
	7RxfvMA9w4AF4qW8ExOGe9tqlcNRsWv0AW5+OGhlZ3SG8ulDOQc0BHTfJ0Ipv6rtIXFqn8lrp8Y
	OIBJWCGhq/wAj67/fU1BpNY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hpH7H5fWpz1prpK;
	Mon, 21 Sep 2026 16:52:59 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CD4EF4057F;
	Mon, 21 Sep 2026 17:04:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:04:00 +0800
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
Subject: [PATCH v6 03/14] kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
Date: Mon, 21 Sep 2026 17:04:39 +0800
Message-ID: <20260921090450.807575-4-ruanjinjie@huawei.com>
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

kimage_free_cma() relies on image->nr_segments to iterate over segments.
When an architecture loader (e.g., arm64) truncates nr_segments on a
mid-way failure, CMA pages allocated beyond the new boundary become
unreachable, causing silent memory leaks.

Extract the per-segment freeing logic into the exported helper
kexec_free_segment_cma(), so that architecture loaders can release
individual segments before nr_segments is truncated. Refactor
kimage_free_cma() to loop over the new helper, preserving existing
behavior.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_core.c   | 27 +++++++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6b1df80524bf..72258d813301 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -533,6 +533,7 @@ extern bool kexec_file_dbg_print;
 
 extern void *kimage_map_segment(struct kimage *image, int idx);
 extern void kimage_unmap_segment(void *buffer);
+void kexec_free_segment_cma(struct kimage *image, unsigned long idx);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -544,6 +545,7 @@ static inline int kexec_crash_loaded(void) { return 0; }
 static inline void *kimage_map_segment(struct kimage *image, int idx)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
+static inline void kexec_free_segment_cma(struct kimage *image, unsigned long idx) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5493591a9e4b..31c8228318a7 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -554,23 +554,26 @@ static void kimage_free_entry(kimage_entry_t entry)
 	kimage_free_pages(page);
 }
 
-static void kimage_free_cma(struct kimage *image)
+void kexec_free_segment_cma(struct kimage *image, unsigned long idx)
 {
-	unsigned long i;
+	unsigned long nr_pages = image->segment_cma_pages[idx];
+	struct page *cma = image->segment_cma[idx];
 
-	for (i = 0; i < image->nr_segments; i++) {
-		struct page *cma = image->segment_cma[i];
-		unsigned long nr_pages = image->segment_cma_pages[i];
+	if (!cma)
+		return;
 
-		if (!cma)
-			continue;
+	arch_kexec_pre_free_pages(page_address(cma), (unsigned int)nr_pages);
+	dma_release_from_contiguous(NULL, cma, (int)nr_pages);
+	image->segment_cma[idx] = NULL;
+	image->segment_cma_pages[idx] = 0;
+}
 
-		arch_kexec_pre_free_pages(page_address(cma), (unsigned int)nr_pages);
-		dma_release_from_contiguous(NULL, cma, (int)nr_pages);
-		image->segment_cma[i] = NULL;
-		image->segment_cma_pages[i] = 0;
-	}
+static void kimage_free_cma(struct kimage *image)
+{
+	unsigned long i;
 
+	for (i = 0; i < image->nr_segments; i++)
+		kexec_free_segment_cma(image, i);
 }
 
 void kimage_free(struct kimage *image)
-- 
2.34.1


