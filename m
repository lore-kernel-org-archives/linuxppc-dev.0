Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EFF606A33B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Z3shP3oo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCm841xZpz2yPq;
	Mon, 26 Oct 2026 18:53:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001188;
	cv=none; b=DXaPr+OSAcKUUkeTE3NsRqSbup1Q6BNYSgLqhPwPLHAudvMUYNp2RJrGZjc/vdvuVH9r4ma8YWV5+YsStsdKt31LOjl8V1XTTc1Kt1YglhmsSPiczRj1/Phh5ApfstX0ORtBN+35UD8mDIGaJ4Sj1GpzFuOnw+m6z0OypFbZwGNO6KJuFY7DvmwYe7jpLckAuGkvP7hWy2ugdZ3VRq47/p+9KUY4Ia4pBtVBhEq6IGO/NiTq7WpVNj0g7U8q/7Lf9QxAeW+YbAGTFdssYJ/naRfx9Hp8F2/X/tbbWCm7Bl31orTPNco7gvuScUSg/pZlaR+PqXvLYxwV6O07FrPsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001188; c=relaxed/relaxed;
	bh=Q37eFExC6M3HhNsbtTO2StjSIwhNf+LEG0N/7SGQYv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDQQbbRUlWCcP4T/37J43Jj3gt5AfUnGySgdAGE5HWrW3ytfOsxXtMYW8UpRtv88Nesi4D1HWocQOI18N2zvyI2z0YflnrPXf67mtXO/RxJ+ii32ZKLAPS5aJrQNd7hNGa6XNyhDVv0vw5Lgct7Dk6YWdm3n2vpZAf9jNbdr+YaoXiqxnrXSRDd3xc05f1j9fIcQnKIQn9qHVLg5AnnC1GnpH92vkWZBCc7iSX0UALt+Y80OMAxl/Tre1KmVlGePseawaZ1hd1FV4+CyqGjONJVKVny4ms3V+YvQ/5UiFiHZ9PO8d/TJ6PcC2r7GBVnyzBrOh9FsBUPwMM/El/cUXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Z3shP3oo; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Z3shP3oo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCm7y0Kpkz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 18:52:58 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q37eFExC6M3HhNsbtTO2StjSIwhNf+LEG0N/7SGQYv4=;
	b=Z3shP3ooxReMBA6K6DclOtd/c2nZdN888LJ5ncwYrjzheXC87zR6soeusaGbvrPDnNaF8GwCQ
	tc4X52XOgex3AWsBhHnMMeeLI33bz6Y1GZcn3FLoZQhPUDgfmMnazgw/k4BKLKkBbrSfJ9uqVwE
	/IsGeUkCOtVWYA6xCLw6NHY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jCm7s1zgyz12LJ2;
	Mon, 26 Oct 2026 15:52:57 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B53B4057D;
	Mon, 26 Oct 2026 15:52:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 15:52:51 +0800
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
Subject: [PATCH v7 01/15] arm64: kexec_file: Stop using the Image text_offset
Date: Mon, 26 Oct 2026 15:51:47 +0800
Message-ID: <20261026075201.699550-2-ruanjinjie@huawei.com>
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

image_load() adds text_offset to kernel_segment->mem and subtracts it
from kernel_segment->memsz.  For CMA backed segments this breaks the
load path: the payload is copied to page_address(cma), which is the CMA
base, while image->start is set to the adjusted address, so kexec jumps
into the middle of the kernel.  kimage_map_segment() has the same
mismatch when a segment has been moved.

The adjusted memsz also breaks the release path: the CMA pages are
freed using segment->memsz >> PAGE_SHIFT, which is fewer than were
allocated, leaking the tail of the allocation.

Since commit 751c263bb74f ("arm64: remove TEXT_OFFSET randomization")
TEXT_OFFSET is always zero.  This has been upstream since v5.8, so no
LTS kernel carries a non-zero text_offset.  Drop the adjustment and
reject images with a non-zero value instead of booting them from a
wrong address.  With the adjustment gone, segments stay at their CMA
base and the release size matches the allocation.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/all/20260921090450.807575-2-ruanjinjie@huawei.com/
Link: https://lore.kernel.org/all/20260921090450.807575-3-ruanjinjie@huawei.com/
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/kexec_image.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index b8d0fb0a9daf..74d24c8aa2fa 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -80,12 +80,17 @@ static void *image_load(struct kimage *image,
 	kbuf.bufsz = kernel_len;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.memsz = le64_to_cpu(h->image_size);
+	/*
+	 * Pre-v5.8 images carry a non-zero text_offset, which is no longer
+	 * honored; reject them instead of loading them at a wrong address.
+	 */
 	text_offset = le64_to_cpu(h->text_offset);
+	if (text_offset) {
+		pr_err("Unsupported Image text_offset 0x%lx\n", text_offset);
+		return ERR_PTR(-ENOEXEC);
+	}
 	kbuf.buf_align = MIN_KIMG_ALIGN;
 
-	/* Adjust kernel segment with TEXT_OFFSET */
-	kbuf.memsz += text_offset;
-
 	kernel_segment_number = image->nr_segments;
 
 	/*
@@ -117,8 +122,6 @@ static void *image_load(struct kimage *image,
 	}
 
 	kernel_segment = &image->segment[kernel_segment_number];
-	kernel_segment->mem += text_offset;
-	kernel_segment->memsz -= text_offset;
 	image->start = kernel_segment->mem;
 
 	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-- 
2.34.1


