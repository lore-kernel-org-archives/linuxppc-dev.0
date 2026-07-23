Return-Path: <linuxppc-dev+bounces-24739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6FBC531CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Wkv5Sknz2yv9;
	Thu, 23 Jul 2026 23:12:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784812375;
	cv=none; b=QbKBtzmyprYf0agkxR4LoL3WcDzc2GxNJQ5+Kj0tqsMDEdhgnG8H5OhDrpYrMxI/dOK06SmJ+8q4i5YfoSc4bBDYUroTm01eXyGN11hroTlvZYy2ixkVddY14IN2wJecctqdBJZxUCQ0Wt2Gbs3rmH5aH8qGVG14AxcnKpUfNxfIWAx/C6ncRLay32/nfIQ0u8fGdSxav0ybGkqKaOXswev6JZP3lqZsDHAIehXP3V8SQCSFYi73MiFpNImUsjOX+W6R5lwPa9PKAOKuDtFCtqzxoCKpAWlOhlZO5vN7k1+NUeLZOPyj2Cf+kHDPAcc2MUd4SNE5Qfz5yurwynjDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784812375; c=relaxed/relaxed;
	bh=XBRyczQwUicQtBBF1Rfna0wwogsOMJkyennASZbUqG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZL7v8NQbKtPahtrSNzmCZzWqArm78xXDiN3glTs9OpjVP0e69JESf6zOJAusS6uQJnuKTTxgl1UBNasGBghTKna98wB6uqIlGj0zioT8ACGCkehEWWf3qC6WtpKf3fNqJBt+8aY3OslHoA8WNaWYnJjjjkXTzyBpm4Xwm/x6C8/6NE+VcsBcCduTnMw8m8JSNOgWpAwsbVoN5B6Ov6BB+ZRmVbdWQeB5puYOfF7as68Fjy+vGT3HcxnGqx0DgKBvZDOLnohCSEH3yy5WhMM2zgOjeqOkNEWBPtEgu4y1RbFejeF/6r5Z4MLzL/NbzBSfgW2M71WsQGrsgoc58uLsag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xrXL96KM; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xrXL96KM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Wkr6spTz2ygg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 23:12:52 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XBRyczQwUicQtBBF1Rfna0wwogsOMJkyennASZbUqG0=;
	b=xrXL96KMqhACloc5kZ0eU2CaXFKslQqforMcwbaswUh74FG5EwH0b3dSRzgaZd34mKBmBongL
	mBF3AnK/w4jpfBEJwjtyu2ylTcTT9snI7+G3oZot7nUJoLyF5FW8OrsIL1K/i9X8eeNqE1TXLnJ
	3AWjsUMYGnE+d+EzlGzbFqA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h5WXB1VM1zpStj;
	Thu, 23 Jul 2026 21:03:38 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F4014057D;
	Thu, 23 Jul 2026 21:12:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 21:12:43 +0800
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
Subject: [PATCH 5/8] arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
Date: Thu, 23 Jul 2026 21:12:39 +0800
Message-ID: <20260723131242.1537633-6-ruanjinjie@huawei.com>
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

Sashiko AI code review pointed out, during kexec image placement retry
loops in image_load(), the loader attempts to find a suitable memory
hole for the kernel and its associated segments (initrd, dtb, etc.).
When a placement attempt fails midway, it restores `image->nr_segments` to
its initial state to purge failed segments.

However, this truncation causes a memory leak. Any CMA pages allocated
via kexec_add_buffer() during the failed attempt are tracked  in
the `image->segment_cma` array. Because the subsequent cleanup
kimage_free_cma() cleanup only iterates up to the truncated `nr_segments`
boundary, these allocated CMA pages outside the new boundary permanently
leaked.

Fix this by using kexec_free_segment_cma() to explicitly release the
associated CMA buffers in the failure paths before `image->nr_segments`
is reduced.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Kees Cook <kees@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: stable@vger.kernel.org
Fixes: 07d24902977e4 ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/kexec_image.c        | 1 +
 arch/arm64/kernel/machine_kexec_file.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index b70f4df15a1a..ffcb7f9075e6 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -107,6 +107,7 @@ static void *image_load(struct kimage *image,
 		 * We couldn't find space for the other segments; erase the
 		 * kernel segment and try the next available hole.
 		 */
+		kexec_free_segment_cma(image, kernel_segment_number);
 		image->nr_segments -= 1;
 		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 854d872dfd0f..e48f29167b38 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -179,7 +179,10 @@ int load_other_segments(struct kimage *image,
 	return 0;
 
 out_err:
-	image->nr_segments = orig_segments;
+	while (image->nr_segments > orig_segments) {
+		kexec_free_segment_cma(image, image->nr_segments - 1);
+		image->nr_segments--;
+	}
 	kvfree(dtb);
 	return ret;
 }
-- 
2.34.1


