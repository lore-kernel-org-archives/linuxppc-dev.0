Return-Path: <linuxppc-dev+bounces-26676-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043D3C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:54:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdn7X57jdz2xmh;
	Mon, 07 Sep 2026 22:53:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788785624;
	cv=none; b=fp2tCXE9vXslx7CjSv+/OIZc1vh5tFXNh3+wB4dLR/QeQyI3yhT/wNgao0T9olYTIffmrJhYBuxUBMY3ILtdr33pDur4LwDRuf545NiiZ7wNq+JQpjRICrZ+cV1z6YkjEV6GOjrHtM1tS0EwJh/s1oqK/TMBholsyuDl0+IsScMP82ZbTLMgijlxNEc4ac8NgXN8ZAqy/55vp0SXbW+bjdBX92LK5G8IV5pnIA/csqdAoTbuIbJ7zOw5adSi1VISyhNX+Ow6aPbgXWZoURn+YUo7gOFeMBXoCgqIdSTRtnoGPkP7rjKjQLNGmoBdGcj6zY0Ywev7RygykwWNsgaPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788785624; c=relaxed/relaxed;
	bh=+SZRrezQ0aGrf6aoi2mjbpyD9DzDa0MzzJwmMo2zVh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXw5UX809KJAAK04rMTuDAD9e2/dKx3pqUiFFcQeNbTrbzRFAN57n9xAKxWYx5o68GhUSQvKNFPDIBrds1V87eT6M5YANakFlZH29yW7DoEPAjtOpTSi9qlTfp/W7dCgDb6mrQD4Yw87G38MegLWlUJjh+uuGCUHJeV+zKqKUO80qJS/xG7A2/nhAvADrEqrhFqqz1nUXqG01GCwZU+bsud0raf2TTyL83Wuc2jsaW0FpZ6YaDcRoL0pY5pCqTe1YkCmteVvhWsg/jdHytye3BXT7Qlk63wEccr+gCVgv20+YGtRknQVA4tMCAHUPDQE4of2MkC77MvSRf5TxbGupQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QDOtzo0Y; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QDOtzo0Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdn7Q5jvFz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:53:38 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+SZRrezQ0aGrf6aoi2mjbpyD9DzDa0MzzJwmMo2zVh0=;
	b=QDOtzo0YbEPraF8hBNN1eIHHylUMG/0f8u5ka7yGUNTwM1OnOYxP9zWXeAlrcrPh3LHLBghb2
	nIQRJeX/fS4RhMOLtRND7crtI/jS6NinldAxrfL97sRs7OyUEmKcrvK/a+f42xeMlDcgBE0logz
	Y70h41sj0wu9iQS94ph0bQ8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hdmtl1jcHz1prQs;
	Mon,  7 Sep 2026 20:42:39 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0873C40538;
	Mon,  7 Sep 2026 20:53:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 20:53:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<ruanjinjie@huawei.com>, <thuth@redhat.com>, <jic23@kernel.org>,
	<tan.shaopeng@jp.fujitsu.com>, <zengheng4@huawei.com>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<djbw@kernel.org>, <seanjc@google.com>, <liaoyuanhong@vivo.com>,
	<vishal.l.verma@intel.com>, <fuqiang.wang@easystack.cn>, <makb@juniper.net>,
	<piliu@redhat.com>, <ebiggers@kernel.org>, <jbouron@amazon.com>,
	<mclapinski@google.com>, <me@linux.beauty>, <graf@amazon.com>,
	<bgwin@google.com>, <takahiro.akashi@linaro.org>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 07/12] crash: Extract crash_get_memory_ranges() helper
Date: Mon, 7 Sep 2026 20:53:59 +0800
Message-ID: <20260907125404.922123-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260907125404.922123-1-ruanjinjie@huawei.com>
References: <20260907125404.922123-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200008.china.huawei.com (7.202.194.74)

Factor out the crash memory range collection logic from
crash_prepare_headers() into a separate function. This allows
the memory hotplug path to obtain and modify the range list
(e.g. remove offlined memory) before generating the elfcorehdr.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/crash_core.h |  1 +
 kernel/crash_core.c        | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index bc087124cd78..b1c816e98143 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -62,6 +62,7 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
 extern int crash_prepare_headers(int need_kernel_map, void **addr,
 				 unsigned long *sz, unsigned long *nr_mem_ranges);
 extern int crash_exclude_core_ranges(struct crash_mem **cmem);
+int crash_get_memory_ranges(struct crash_mem **mem_ranges);
 
 struct kimage;
 struct kexec_segment;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..406b68d2adfd 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -317,8 +317,7 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
 	return 0;
 }
 
-int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
-			  unsigned long *nr_mem_ranges)
+int crash_get_memory_ranges(struct crash_mem **mem_ranges)
 {
 	unsigned int max_nr_ranges;
 	struct crash_mem *cmem;
@@ -344,13 +343,30 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 	if (ret)
 		goto out;
 
+	*mem_ranges = cmem;
+	return 0;
+
+out:
+	kvfree(cmem);
+	return ret;
+}
+
+int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			  unsigned long *nr_mem_ranges)
+{
+	struct crash_mem *cmem = NULL;
+	int ret;
+
+	ret = crash_get_memory_ranges(&cmem);
+	if (ret)
+		return ret;
+
 	/* Return the computed number of memory ranges, for hotplug usage */
 	if (nr_mem_ranges)
 		*nr_mem_ranges = cmem->nr_ranges;
 
 	ret = crash_prepare_elf64_headers(cmem, need_kernel_map, addr, sz);
 
-out:
 	kvfree(cmem);
 	return ret;
 }
-- 
2.34.1


