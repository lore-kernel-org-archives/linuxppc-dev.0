Return-Path: <linuxppc-dev+bounces-24735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E81AC531CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Wkp2v5bz2yn2;
	Thu, 23 Jul 2026 23:12:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784812370;
	cv=none; b=gz0x7hKc3OJ0NqDHvSr4MuRClDtVVMUQhoV8u6Ra/jv5zMMzNwP0S7qAppQ4jPsc2DPo14mDhVbot/1zGZb4GYq2i7oilWT/19WSxkx/O1ddYqVPC46Mqlc3b5yL55EgjIoSFilfKoFGKwZpAFTkL97wcYa242tZryUs3beVUo4j/3jTzCHhp4XKzSVMSBo4/p9lFkaNVDERGrXoeLxRFXabb4kP4VwrdJPbeoEWVMr6uK8rOD4a0r7DAoYDgrm191FzztVm+40qUz1Kr+CggP49HKp6H+GTmX0R/tDDHe2WTErQ+JkFl0hvKI7lgBGdcmCIeW4gLUP0kfHq7BWHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784812370; c=relaxed/relaxed;
	bh=svFv2eXHvQP7UCoP9HFVS9Hsbo7FO4p9XBWC3JmSiWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmtJL96GxgG42N2FtVFbMdIEgcGWVivTZ/+bNBG2b8RF8zeBmhXcxfoPTsw5hb31N8ZVGKIv1yBWMclYG4Zu1mZmfMAQQIEWo0O5fOWwpxsWXxTydwZK44XDKks1TXth6bcJbzLvEbk2uLFpF4ouut0rpaXIFXZeZTRll3/uvt/b8TzqPGrMeDsiTdiVbayvy1ZZwXksx2FPL9zA7sbeV85IOj4W01PoSyVDoPJUYdDnsoKVYMpQi8lVWUE9Fj7rYHDxeNVX+OuLsOIP8X1KgF8WYBbYzIK+6ajsGfMUGOu7y+xG9NO/shqnaLfHO0kyrWXFQ2kjYRys7tB0SjUEaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XGEdLd7O; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XGEdLd7O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Wkk58tPz2ygg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 23:12:46 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=svFv2eXHvQP7UCoP9HFVS9Hsbo7FO4p9XBWC3JmSiWc=;
	b=XGEdLd7OAR0H3Dn8+3Ook/xrlXJPfEpt7brFekxCYXcgV3PegYljnRfapD6Ek55C28katN2Ia
	0q7UnqevxOJ66e2ne2H5BLSOgsDUjZ5k5q5lc3/TAYrA+V70dWXMRbgALriylcKzZYtL7A6FsTC
	5SL8jQqu1LEv6xlCsi8rQok=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h5WWh35gFzcb2y;
	Thu, 23 Jul 2026 21:03:12 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DB3A4057D;
	Thu, 23 Jul 2026 21:12:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:41 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <vladimir.murzin@arm.com>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <james.morse@arm.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <kees@kernel.org>,
	<coxu@redhat.com>, <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <liaoyuanhong@vivo.com>,
	<jbouron@amazon.com>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>
Subject: [PATCH 4/8] kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
Date: Thu, 23 Jul 2026 21:12:38 +0800
Message-ID: <20260723131242.1537633-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The generic kimage_free_cma() relies on `image->nr_segments` to iterate
and free allocated CMA pages. However, during architecture-specific
segment placement retry loops (e.g., arm64's image_load()), a mid-way
failure will truncate `image->nr_segments` back to its initial value.
This truncation permanently hides any CMA pages allocated outside the
new boundary from global cleanup, causing silent background memory leaks.

To allow architecture-specific loaders to execute fine-grained memory
reclamation before truncation occurs, extract the single-pass CMA release
logic into a dedicated and exported helper:

	void kexec_free_segment_cma(struct kimage *image, unsigned long idx);

Refactor the main kimage_free_cma() to invoke this helper sequentially
to maintain backward compatibility while expanding single-slot flexibility.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_core.c   | 25 ++++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8a22bc9b8c6c..6f1eabda0300 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -532,6 +532,7 @@ extern bool kexec_file_dbg_print;
 
 extern void *kimage_map_segment(struct kimage *image, int idx);
 extern void kimage_unmap_segment(void *buffer);
+extern void kexec_free_segment_cma(struct kimage *image, unsigned long idx);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -543,6 +544,7 @@ static inline int kexec_crash_loaded(void) { return 0; }
 static inline void *kimage_map_segment(struct kimage *image, int idx)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
+static inline void kexec_free_segment_cma(struct kimage *image, unsigned long idx) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..ec7e86e085b0 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -554,22 +554,25 @@ static void kimage_free_entry(kimage_entry_t entry)
 	kimage_free_pages(page);
 }
 
-static void kimage_free_cma(struct kimage *image)
+void kexec_free_segment_cma(struct kimage *image, unsigned long idx)
 {
-	unsigned long i;
+	u32 nr_pages = image->segment[idx].memsz >> PAGE_SHIFT;
+	struct page *cma = image->segment_cma[idx];
 
-	for (i = 0; i < image->nr_segments; i++) {
-		struct page *cma = image->segment_cma[i];
-		u32 nr_pages = image->segment[i].memsz >> PAGE_SHIFT;
+	if (!cma)
+		return;
 
-		if (!cma)
-			continue;
+	arch_kexec_pre_free_pages(page_address(cma), nr_pages);
+	dma_release_from_contiguous(NULL, cma, nr_pages);
+	image->segment_cma[idx] = NULL;
+}
 
-		arch_kexec_pre_free_pages(page_address(cma), nr_pages);
-		dma_release_from_contiguous(NULL, cma, nr_pages);
-		image->segment_cma[i] = NULL;
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


