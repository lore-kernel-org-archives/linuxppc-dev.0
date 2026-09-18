Return-Path: <linuxppc-dev+bounces-27694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A945C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:04:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmSs7597Sz30Tm;
	Fri, 18 Sep 2026 20:04:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789725867;
	cv=none; b=aA4fbS/aTIvLc/R7HGe0TOm9grbJfIH5q5i6w/iq4cYDwp0AnMeh5viv8csHAKnWRKhRwsz2dncC/bgxl701c7PisXiir0thI6rjvrWSMN+YpPOgPaPFnZZYuZlIZ6wgbjklzUoBRGkQuxGPcW1fay/ZljIgly634N8mzuACXNzLLBIQlzIT87o1RzG4qpffXRvxKezFyqsFU7eHz05ICjons2U9XHeENIS8v2xEJr1qwxD3zQj/S4Ppsp9dlxzmwsjH1aTliLWSvq+P361I/1sg42Tt9MT2jerjX92w4nLy62hWgl0XsHTl6yX2JqHzVRMWI3LHTZbvRh2HkwfJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789725867; c=relaxed/relaxed;
	bh=2Eq1XJNYhRFTE/SJtlUDPWTtcQMeeDeygEezx5WcQDg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ew2QsLOReSYQu3KLI+0BJnmYUAfodOBf8DIJQCaT0DxISD8XG1F/K5lgD8nwEO/N7KWmEyM8YqCl8THFFa25U34xzOStznmKPtirbUo74WR19AeQ31lTf2RQwycyZ2D6jdkJkPglYg8eG3/2zIi0zxEiW8/NepHoNyAC1/FuSvEU/Tcnq/63zoi6SoNMdii5dmKLSDoZ2FlsOP6IjWGD049MgdMhTzuc8i/YEUEOQMDYykTtqUTiMsA1YlRWc8sB/t65zvn6x7kYh7JLjuyBVmOR+L/7TUZxffhMwAeQ3zHonoKHph5y2DQEZhAYiFa0g1g7zfA0n6sL+804YJCtrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=M3xDCzOS; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=M3xDCzOS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmSs04xyPz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:04:19 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2Eq1XJNYhRFTE/SJtlUDPWTtcQMeeDeygEezx5WcQDg=;
	b=M3xDCzOSH1ex1aIXQYlZy5bUMNl8IOExQZttwkBTy/1chlRHO/kzqULiUCzyJpa1xmha57Pt9
	6lPA8D6mDEfjpfxI7U4GV7kTxHty4Tg4b4+dOqX5QVt6cyuL1vky1HDVwNZXgBujl8bGaIfFt0t
	WgzQI/6r2eltMXLNXd6LJ7c=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hmSbD4MBGzpStW;
	Fri, 18 Sep 2026 17:52:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B2E5B40537;
	Fri, 18 Sep 2026 18:04:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:12 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 03/17] kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
Date: Fri, 18 Sep 2026 18:04:28 +0800
Message-ID: <20260918100442.3841135-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
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


