Return-Path: <linuxppc-dev+bounces-19191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0B3CC6B11
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:25:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmYL820Glz2yYK;
	Thu, 02 Apr 2026 18:25:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775114752;
	cv=none; b=Nl6p+UWmDzhoYt6TQAMMJIt4jQ4ET7nstGJTYpZi81Si5DMWZjIZ96ZLXGw16JTmURJjz4jnfyTTDQuGdLKvAgTfPT2Ya6UwgeXBwXLx7zbT0r2bmNtF1qsENq2JozWKdvYwIhW/XZi7gSL8WmGF2mPmIiXL9hnzJgceyCwWasF63V9CyEo3aUb/7SQhcsH1qJTSqQQ5bpRd2qhXOJ5VQO57kGs4aE1/++bcbXJcrLn8e+xz8mUM7DEtTHGuYXyu6HLfJzFD9Sfvx5uTJw01eZO+ExfPVuweA4as3mhLZkahZgTkPfUrkADAxk3z0ReqO6Wqg+n8TYnwzNUnjxK4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775114752; c=relaxed/relaxed;
	bh=MS+svJjwX+WERXmMYEnQYyI5Mc94faKy2CdWQtmAb8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZ9Y4f/HmDPnHfDtxIAKnmut7XM/D3Xpe7E3wmliz+dqbybEcplNpIrAv7cFdqSk6wiN4N4DIAxG4Sh0HmGLXwFbuSjjYg9hF5zCpKmHrsNJjIHrWEWY9RSvHR9bwPSqDncMQ1GnILn+mvprjzqG4PFOXv6ll6IStNggi9U5/zTtajM9MaCWnq5OZdqwMtnQrAF1Sz5iXUNqEt6UJSg68bPRWJ25sjqJmYophvx0Xbc8f9y1XTY/FOWPgapGHVpI7lBzkX4DZIwr87GMV+RlcL4O4pXH8V8q7wWwIZZD2mtozatnPhNGKeO25s6/s8m4Wt5Sv+RItn3DP1JSLRhcsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xXm5VJ0g; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xXm5VJ0g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmYL55VpCz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 18:25:49 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MS+svJjwX+WERXmMYEnQYyI5Mc94faKy2CdWQtmAb8o=;
	b=xXm5VJ0gzjFo5FI6ifJNt2lYYB9fpiEFwKvKrblrK5cZ5X5QR0VEIsC4iprJlRC3urHXpb75e
	XRqctvGI7uS/yew73xY6QXp4G2a2n8T+yKdd4nuZDj5kccyoaXIEo3Ic4MOgmKWA5NZ5J2KJg3p
	VaGi5GtRXJK44kah7P/dE2Q=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fmYBv53hPzRhWN;
	Thu,  2 Apr 2026 15:19:35 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 14BA14056B;
	Thu,  2 Apr 2026 15:25:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 15:25:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v12 01/15] riscv: kexec_file: Fix crashk_low_res not exclude bug
Date: Thu, 2 Apr 2026 15:26:47 +0800
Message-ID: <20260402072701.628293-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402072701.628293-1-ruanjinjie@huawei.com>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
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


