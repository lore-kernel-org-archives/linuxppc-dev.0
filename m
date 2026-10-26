Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C3606A327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EmN5Y3m+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCm891Hl9z2yjp;
	Mon, 26 Oct 2026 18:53:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001192;
	cv=none; b=oo82sKpnvZkueC63OUrZiF6v2m912VwMOgBV1forKXpH++3oTOLbsVy7LmgTEdgzPQPYFVnk6ZK3Aeso9HF0RldQudaUsQwYxLUHP8m1kXFuNlU+uk7AfrCWpR3x6teyztVbw2kCgkDH4Z0hbMnfm4k3DKzhBHuEa0qXr/TW7FgAUp96fA0GeswZD14/tYTGiVLZVQNScrgL0k9zqaF7O9zLu6vlzUsP+OnoOEIPC7Lojy+XJ2JvueAv8VtvMn9TW3khYpaux4JXb2w4JQvD8zIw7kSnMBsor4yJtikxSHUNPI35V+kyB7DP0jd7bh/3EK8mjO+TDhHicckxTWCGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001192; c=relaxed/relaxed;
	bh=zXnStd3RUENrUNXK75DqxF/nRrh4yXstLfuIj9T8Ge4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2LCwoPrKSuZAvFE9FLj0tO4Bg17P+47/fIWLbB5NWSIanWAmcR4trWRXjA+tXcuYUcY4kydA/Nmz+fQwXXytUyZZZija16yICBcmAKYx3268xzvMnmVWHRF5DTfN2bZF6NuUQTNN9zCgpbkc8cA2n0heYgyfXTXHyXF0l2OBKq6xu+h7AI3FCq0U7l/ZjbzMJrAnUT+dFbj9IhkyfeK4qaXGSSnJcKODSFA1mr88ZJ7mI7aiwvipZK8I+cMNWaMPJypq8tUvA8FW8jaknOKwSDy3HOgS9wPcKYOs5SERavszz0L1sfMcycKLZ0xwvWrKT9ZunE5nKrcsXnNqlCLDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EmN5Y3m+; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=EmN5Y3m+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCm821fx8z2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 18:53:06 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zXnStd3RUENrUNXK75DqxF/nRrh4yXstLfuIj9T8Ge4=;
	b=EmN5Y3m+8L8TB9rlGQojOZ1+kwebRNg5GHiRjJZ+7P52pxXrcbLCZ77HJnAoYDTiuRsDAgqGE
	OMi+tNR8dxXL7GFP9tqELWk/pXsMjYHhcIY9wWBH20W650Enc4Jnxl7V8NaI14K6ViMeefhxgc1
	IiPn5BkZIfkwDKusm1GbOJQ=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jCm7j1rhGz1T4MR;
	Mon, 26 Oct 2026 15:52:49 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0051E202E6;
	Mon, 26 Oct 2026 15:52:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 15:52:54 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <ruanjinjie@huawei.com>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <robh@kernel.org>,
	<sourabhjain@linux.ibm.com>, <kees@kernel.org>, <coiby.xu@gmail.com>,
	<Yeking@Red54.com>, <tangyouling@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <hui.wang@canonical.com>, <sohammetha01@gmail.com>,
	<guoren@kernel.org>, <gaohan@iscas.ac.cn>, <kai.huang@intel.com>,
	<kas@kernel.org>, <vishal.l.verma@intel.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
Subject: [PATCH v7 03/15] arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
Date: Mon, 26 Oct 2026 15:51:49 +0800
Message-ID: <20261026075201.699550-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026075201.699550-1-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The retry loop drops nr_segments, leaking the CMA pages of the failed
segments.  Release them first, and disable CMA for the retry: it
ignores buf_min and would hand out the same region forever.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/kexec_image.c        | 8 ++++++++
 arch/arm64/kernel/machine_kexec_file.c | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 74d24c8aa2fa..6ed1991e3142 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -111,6 +111,14 @@ static void *image_load(struct kimage *image,
 		 * We couldn't find space for the other segments; erase the
 		 * kernel segment and try the next available hole.
 		 */
+		/*
+		 * kexec_alloc_contig() ignores buf_min, so disable CMA to
+		 * let the retry make progress.
+		 */
+		if (image->segment_cma[kernel_segment_number])
+			image->no_cma = true;
+
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


