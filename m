Return-Path: <linuxppc-dev+bounces-20674-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0163FCD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 03:05:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDPkD2kYvz2xnQ;
	Mon, 11 May 2026 13:05:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778468756;
	cv=none; b=A/842z52bN6obdw/Nv2eDxUKvqvNkoNwbHGAbutFe1HQ4vpTVr5zM95IY9nP4dwlmbf2aVDDQ87yXUvEXJRb1J2GlXh6CAGOH30eGbpgQOafJ+DyPABwhsZZChxKburbPokLGHJ2ox+7SoAYOAQTosQ5/XUcL6KDQw2J1x5r7O9cb2PfL07+pekWvaXOF2K5VNKu0SZCOD1FCBnXxC1lHVVLXcgTxhMgo0NdoibzmfHkazIovKjZOUKTxHg8SiqTKIk93gKAwbdcK/Wiyh6xSmDkoPO26D3ANIhREU6WbS0PO8fnSx+VNsy0zFCd5KTNAeMnzXZ3oJaGWSD7j0LwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778468756; c=relaxed/relaxed;
	bh=MS+svJjwX+WERXmMYEnQYyI5Mc94faKy2CdWQtmAb8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNY76BqthKHNrfAwuE9vgrSYxHXs2cKRk0WSVPmrN5gXWzaaVl1hgH3kw8a534OnQLGTVS5U+vH6TeWB+GUJN6nfAvT7NhcsBk8KBjBcjy3hfwgcp+qFZA4u4aWeDudzCts4vV9I6AdvSjeCEC0xz/B2W2dgu6g7RGo8hnuNMYNDQMKc/w42LduuFczVgXXIMqWgYlJNkzZVv+N9rEqMVOugVrtUe0ss059EUPrR5Hxn+0/6etzKaezObal/JPeEc7Fh/UwmE64QTxOhX1aLlZwhun88t2rousn8VAXSQ6WjXRiDuRRQn2+FttmJDOQxUwfQ8hrN5uyxf3szmEMBiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xXm5VJ0g; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xXm5VJ0g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDPk82Flxz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 13:05:51 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MS+svJjwX+WERXmMYEnQYyI5Mc94faKy2CdWQtmAb8o=;
	b=xXm5VJ0gzjFo5FI6ifJNt2lYYB9fpiEFwKvKrblrK5cZ5X5QR0VEIsC4iprJlRC3urHXpb75e
	XRqctvGI7uS/yew73xY6QXp4G2a2n8T+yKdd4nuZDj5kccyoaXIEo3Ic4MOgmKWA5NZ5J2KJg3p
	VaGi5GtRXJK44kah7P/dE2Q=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gDPYF3Hxjz1T4FV;
	Mon, 11 May 2026 10:58:09 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 95FE540537;
	Mon, 11 May 2026 11:05:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 May
 2026 11:05:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <paulmck@kernel.org>,
	<ruanjinjie@huawei.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<leitao@debian.org>, <jbohac@suse.cz>, <ryan.roberts@arm.com>,
	<osandov@fb.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <adityag@linux.ibm.com>, <guoren@kernel.org>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>,
	<wangruikang@iscas.ac.cn>, <namcao@linutronix.de>, <chao.gao@intel.com>,
	<seanjc@google.com>, <fuqiang.wang@easystack.cn>, <ardb@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v13 01/15] riscv: kexec_file: Fix crashk_low_res not exclude bug
Date: Mon, 11 May 2026 11:04:40 +0800
Message-ID: <20260511030454.1730881-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511030454.1730881-1-ruanjinjie@huawei.com>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

As done in commit 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
and commit 4831be702b95 ("arm64/kexec: Fix missing extra range for
crashkres_low.") for arm64, while implementing crashkernel=X,[high,low],
riscv should have excluded the "crashk_low_res" reserved ranges from
the crash kernel memory to prevent them from being exported through
/proc/vmcore, and the exclusion would need an extra crash_mem range.

Just simply tested on qemu with crashkernel=4G with kexec in [1] mentioned
in [2]. And the second kernel can be started normally.

	# dmesg | grep crash
	[    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
	[    0.000000] crashkernel reserved: 0x000000017fe00000 - 0x000000027fe00000 (4096 MB)

Cc: Guo Ren <guoren@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
[1]: https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
[2]: https://lore.kernel.org/all/20230726175000.2536220-1-chenjiahao16@huawei.com/
Fixes: 5882e5acf18d ("riscv: kdump: Implement crashkernel=X,[high,low]")
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/kernel/machine_kexec_file.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 54e2d9552e93..3f7766057cac 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -61,7 +61,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	unsigned int nr_ranges;
 	int ret;
 
-	nr_ranges = 1; /* For exclusion of crashkernel region */
+	nr_ranges = 2; /* For exclusion of crashkernel region */
 	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
@@ -76,8 +76,16 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	if (ret)
+		goto out;
+
+	if (crashk_low_res.end) {
+		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		if (ret)
+			goto out;
+	}
+
+	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
-- 
2.34.1


