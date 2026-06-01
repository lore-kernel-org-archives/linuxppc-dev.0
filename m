Return-Path: <linuxppc-dev+bounces-21786-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CE3CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:49:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTTgQ0yKjz3brx;
	Mon, 01 Jun 2026 19:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780307330;
	cv=none; b=f6XK2ud4ZiRmolhBEXR49oJD7gIx8hG0Mt8j7ayQRnbmf6pDdd6Waxu1Nx653/zoJOiUPyOsXhrol+weWqaSKySNMvlfsIcneeBMHAhR1pMs6Wy8NiTGX0Sg0x6gQFY35hXXy/8Ib+xYMpZjIvzWndN7ajlLfVwiRPqyy2c1e8JZj79NEH0yf8WJEoqsE9rqc54USRZsqmj2PbUBwnIO8rCGmGpD9dyborKi96C8V/cBFguwlEgWteX6vdS34P1y0Ei331O25rAxC8oPqtFWag3zsIskDX+zGfCE8bqHzkvBQTerSEHGQgA3gYTaGPbxLsOSYbPfq6Nha8T0lg7Rtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780307330; c=relaxed/relaxed;
	bh=4eT52ydG2t54NS/b5dXPgA7jwihQzEhqa1y7/Wo7/ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAth8bGPnIhiR1mHdSZtU9kG17TaHpyQAuxvk78t92lEbgQ23X6t9RSQeMngmYH9y9MModIpEY9iq209VdHmwgIn2dAoE7K+jmMv7sBCjVHI1plyC75mqCk4QXYc81ItsGwuE2VNCHEFUatlYyeqp0q9gHb35zgn45mwCk7tKcxbXImR0JCpvaoysrBWS1ovspAkMW8GDatzRG+GKCFmvC9dzjT1OyVRLff2C4Qk9HDhYh9wbe7Dph5T9PV3MiwSWIAfXB1Ftuu0GnX5yCh6OfO86tNQLHCsEoger7XDJ4lEH0gFrUkDJGvZ4ENVTG5U3UKvSsXZLhMv7ua6V2a+Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6KPOa2av; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6KPOa2av;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTTgP1z1Pz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 19:48:49 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4eT52ydG2t54NS/b5dXPgA7jwihQzEhqa1y7/Wo7/ig=;
	b=6KPOa2avTUx1m2s1M1NqpwzXyvocvApJn4LiFv0Fj9rEPMgVobIxbK7O1QwldATXBoob5fmmd
	8dmxCFHqe5YvdPmuS6cpdFMFC6WcjElx/b56lcNYqMuGSoWq16uU6xAHPAZcffBCM8/T3UjgXFo
	n8DkXNneauhrog+mHvXzWT4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gTTV90cdgz12LGX;
	Mon,  1 Jun 2026 17:40:49 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E5B004048F;
	Mon,  1 Jun 2026 17:48:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:48:41 +0800
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
	<rdunlap@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <sourabhjain@linux.ibm.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <masahiroy@kernel.org>, <gshan@redhat.com>,
	<james.morse@arm.com>, <maz@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <suzuki.poulose@arm.com>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <djordje.todorovic@htecgroup.com>,
	<austin.kim@lge.com>, <namcao@linutronix.de>, <djbw@kernel.org>,
	<chao.gao@intel.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <makb@juniper.net>, <graf@amazon.com>,
	<piliu@redhat.com>, <rafael.j.wysocki@intel.com>,
	<mario.limonciello@amd.com>, <jbouron@amazon.com>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v15 03/23] powerpc/kexec_file: Fix NULL pointer dereference in kexec_extra_fdt_size_ppc64()
Date: Mon, 1 Jun 2026 17:47:45 +0800
Message-ID: <20260601094805.2928614-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601094805.2928614-1-ruanjinjie@huawei.com>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
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

A static Sashiko AI review identified a potential NULL pointer dereference
in kexec_extra_fdt_size_ppc64().

When get_reserved_memory_ranges() successfully returns 0 on platforms
without any reserved memory regions, the allocated 'rmem' pointer remains
NULL. Passing this unallocated pointer directly to
kexec_extra_fdt_size_ppc64() leads to a kernel panic when evaluating
'rmem->nr_ranges'.

Fix this by adding a defensive NULL pointer check at the beginning of
kexec_extra_fdt_size_ppc64(), returning 0 extra space immediately if
no reserved memory structure exists.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
Fixes: 0d3ff067331e ("powerpc/kexec_file: fix extra size calculation for kexec FDT")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/file_load_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 8c72e12ea44e..fdeedf102c38 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -649,6 +649,9 @@ unsigned int kexec_extra_fdt_size_ppc64(struct kimage *image, struct crash_mem *
 	struct device_node *dn;
 	unsigned int cpu_nodes = 0, extra_size = 0;
 
+	if (!rmem)
+		return 0;
+
 	// Budget some space for the password blob. There's already extra space
 	// for the key name
 	if (plpks_is_available())
-- 
2.34.1


