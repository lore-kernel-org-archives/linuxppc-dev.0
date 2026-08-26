Return-Path: <linuxppc-dev+bounces-26101-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71E4C61DCB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:26:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVK4s1tRnz3btt;
	Wed, 26 Aug 2026 19:25:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787736333;
	cv=none; b=a9PYTIWI5xfIMsNhmPlEH6KfVNjSpeN3Ln8gYiRJvQ6OoLgW20aoGeW2RuDh8l/e06UQOEy554onOEGEuH0Pj7R5R6JORYs8aLlb7SZnXZc78d6yPJ8/LnTzJgcxOFu+fl7unL29FodN+klPD8reZFYNLR19yJEjqe1bp1VYJWj2PG9vDG+DJ2HuAmWSJmiPk+3b+iACQw3tWAcwmiwIFSKaqMEV6qA1p8P17zCpFf4vCQJD00YZnjkEMVLF4ha4peH5cTjz1sZiNxS/jkE4COa9ZfzUVPjcTX4M72pLKGQoHuSsM7eWqXyMcuuEDt0nnfh4kGcKOirYs89EhNqCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787736333; c=relaxed/relaxed;
	bh=y759v80hfcLGexoE6U+P0qCW895e0rqrtykfndhs3p4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGJOMbpYQoRwJYr7uWbFW9XEF+U7RZ0wGHwpUAsAuZxMC6hTdN0RllX5BJ18imxm2/wMUjFuFnOXvwZ2y3oSsNusKpi3R9lJc/xKTbq9GXVVXYP4ywTu8m2d7piB+3wLI71rFEGK+6tCHwOrwJjJtDin5+/aimjp9+74x/x0tLqnubNeyw+7fHuASo0/bk2A59ECjDegwRH1Kdm5x363YDvTYGzPi09BR7AdPxk83by2lqU6w1PJ7e5+pWv0DkMkmcUcB3Si8PLZ1CzlIqTEkIrNPeHTVMwWz7NMJRJ1wMk6Ujt4fUO4Z3gjPKHyJVBz44bW8cp/Lc6ST2Jyp4QuMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=i/qQKHNz; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=i/qQKHNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVK4q32z8z3bSw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:25:30 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=y759v80hfcLGexoE6U+P0qCW895e0rqrtykfndhs3p4=;
	b=i/qQKHNz8OxKmJLSE6ETOW3Vyzml5TlfhhQAVfoBCgLl3ppxbzz6ZfYvrUMLwW7wzTAHquxJ5
	7xkkPqtSSJUuN3dgmG4MYGSJZEltvqtaf1bLmuJ2Nfz2lINRwFVWYySZIoIptnPTMwZvuSdXvB9
	ZX7arRtCRna8ymHdQexhtqQ=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrJ0mhvzLlXB;
	Wed, 26 Aug 2026 17:14:40 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B445D4058A;
	Wed, 26 Aug 2026 17:25:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<thuth@redhat.com>, <gshan@redhat.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 07/17] crash_dump: Fix potential double-free of keys_header
Date: Wed, 26 Aug 2026 17:25:31 +0800
Message-ID: <20260826092541.3905933-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826092541.3905933-1-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
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
 dggpemf500011.china.huawei.com (7.185.36.131)

`keys_header` was freed in `build_keys_header()` without being reset
to NULL, and the error path in `crash_load_dm_crypt_keys()` freed it
unconditionally even when reused, leading to double-free or
use-after-free.

Add `free_keys_header()` to centralize freeing and NULL-setting.
Use it in `build_keys_header()` and only free in the error path when
the header was newly built (`!is_dm_key_reused`).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: stable@vger.kernel.org
Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_dump_dm_crypt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index c685497cd470..ed0960ff0987 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -363,15 +363,21 @@ static struct configfs_subsystem config_keys_subsys = {
 	},
 };
 
+static void free_keys_header(void)
+{
+	if (keys_header) {
+		kvfree(keys_header);
+		keys_header = NULL;
+	}
+}
+
 static int build_keys_header(void)
 {
 	struct config_item *item = NULL;
 	struct config_key *key;
 	int i, r;
 
-	if (keys_header != NULL)
-		kvfree(keys_header);
-
+	free_keys_header();
 	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
 	if (!keys_header)
 		return -ENOMEM;
@@ -441,7 +447,8 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	r = kexec_add_buffer(&kbuf);
 	if (r) {
 		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
-		kvfree((void *)kbuf.buffer);
+		if (!is_dm_key_reused)
+			free_keys_header();
 		return r;
 	}
 	image->dm_crypt_keys_addr = kbuf.mem;
-- 
2.34.1


