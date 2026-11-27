Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E8606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EXHf3fqU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbTgN1q4yz3bfR;
	Fri, 27 Nov 2026 21:10:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795774208;
	cv=none; b=eOh/JHktG8oXhsxfmVq7KdHAfmDLpQm7G17p6jV3pWPAxyZNBOXuLtoQEj6G68Hg6t9R7sx8hTd15QpnSPjHoKGSG5btYz5bHS6gD63PFvnBEbNxhVaCdgyUyvEnQRQ2kYmbJz8Gez1rIWgm5i3rbt4ZPkfD0ivx4KSo1uzMC1Z6MoUYXTXKgihURAg0BrIf2gKhU2Ty7qBYLOhmoSrNWnYYesvImtk6fyNGWgpkrgkuvZusfWZwNwghyV8FFYwvZJWoPY+mRgqvgtbTi1CljUFjk7QSn5SnLqmDnauxk0CVgZaKM5si2ycCuG7IE+jk3qaeCqEZlcideUGQxIEkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795774208; c=relaxed/relaxed;
	bh=t+U9SqTEB3rCz1yv6L8RikWybxFNNnwwvql8TK7w7DQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eod6GQrv9Acr6wpyv790UPbOPn7qgHjIiGRicLxuUlxKjmvsv3biJ86iPORNj+wjtyFXZJKyRtxn3GWda/JDFnooYYy1PUw4POKNnB9UcjWhHOkbu7HLdTu1Z4oVc41/zAeR78hQX36USMKTe2bzXKU+KnZ/b/C5/WVaCxE8d5JOZ8ar7nyveL02yDQ8Cll7LhslgXDJUtUft6K2S6VeymRTJ6QPBWY3Bg5/XcufMdu8SpQVKDUEublhpZPzRyh2UKVB4kUj1qW9bfmBVkykkfs7M8DDmHLb3+b2fVdkX2301UtWFn0QAim4pED/9ICYTLsdZRLTJiND4xGVGXkFiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EXHf3fqU; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EXHf3fqU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbTgJ6HTsz3bWn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 21:10:04 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t+U9SqTEB3rCz1yv6L8RikWybxFNNnwwvql8TK7w7DQ=;
	b=EXHf3fqUqP1V6i3p1IvH2Gn7zzDGvrWK7Eq4xxXTvFSUH8iCNKh71P8dUe7fVBYHp54HoJpeY
	dF+wmFAZlX/qPg/omDS1VsGYH74qUY/NDIIxWjqv0HyqI/LLp2pS7QddwnyzUqg0q3i0Y1agrPi
	hhkOzTZjHQwoGWjHdHpBFnQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jbTfn0CYDzKmT2;
	Fri, 27 Nov 2026 18:09:37 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id EFE434055B;
	Fri, 27 Nov 2026 18:09:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 18:09:54 +0800
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
Subject: [PATCH v9 08/11] kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
Date: Fri, 27 Nov 2026 18:09:22 +0800
Message-ID: <20261127100925.3019877-9-ruanjinjie@huawei.com>
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

Arch loaders truncate nr_segments when a placement fails, so the CMA
pages of the dropped segments become unreachable.  Export a per-segment
helper so they can be released first.

No functional change intended.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_core.c   | 25 +++++++++++++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 491046a90ffa..3c030e478adf 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -524,6 +524,7 @@ extern bool kexec_file_dbg_print;
 
 extern void *kimage_map_segment(struct kimage *image, int idx);
 extern void kimage_unmap_segment(void *buffer);
+void kexec_free_segment_cma(struct kimage *image, unsigned long idx);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -535,6 +536,7 @@ static inline int kexec_crash_loaded(void) { return 0; }
 static inline void *kimage_map_segment(struct kimage *image, int idx)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
+static inline void kexec_free_segment_cma(struct kimage *image, unsigned long idx) { }
 #define kexec_in_progress false
 static inline bool kexec_is_in_progress(void) { return false; }
 #endif /* CONFIG_KEXEC_CORE */
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index f4a31565c447..3ae09baee9c7 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -571,22 +571,23 @@ static void kimage_free_entry(kimage_entry_t entry)
 	kimage_free_pages(page);
 }
 
-static void kimage_free_cma(struct kimage *image)
+void kexec_free_segment_cma(struct kimage *image, unsigned long idx)
 {
-	unsigned long i;
-
-	for (i = 0; i < image->nr_segments; i++) {
-		struct page *cma = image->segment_cma[i];
-		u32 nr_pages = image->segment[i].memsz >> PAGE_SHIFT;
+	u32 nr_pages = image->segment[idx].memsz >> PAGE_SHIFT;
+	struct page *cma = image->segment_cma[idx];
 
-		if (!cma)
-			continue;
+	if (!cma)
+		return;
 
-		arch_kexec_pre_free_pages(page_address(cma), nr_pages);
-		dma_release_from_contiguous(NULL, cma, nr_pages);
-		image->segment_cma[i] = NULL;
-	}
+	arch_kexec_pre_free_pages(page_address(cma), nr_pages);
+	dma_release_from_contiguous(NULL, cma, nr_pages);
+	image->segment_cma[idx] = NULL;
+}
 
+static void kimage_free_cma(struct kimage *image)
+{
+	for (unsigned long i = 0; i < image->nr_segments; i++)
+		kexec_free_segment_cma(image, i);
 }
 
 void kimage_free(struct kimage *image)
-- 
2.34.1


