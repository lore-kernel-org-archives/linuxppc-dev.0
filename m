Return-Path: <linuxppc-dev+bounces-20495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAF5CD342F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 02:12:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Jmq4qVHz2xdh;
	Wed, 06 May 2026 12:12:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778033547;
	cv=none; b=AYfx/BTds77R0l87GY0hy41oIKBFzBbVE7eqFrdTeteGyJL3qzSCEzkKpuNktcyt0AjLvkZ7+7zhrsWXYMrl3iY985ykX+xU7RJc0m5rwbFBk2p5WPiphx2L+L52jqVddyFtKgEJ3YJCzimznF7gnLX9lzl+9J+G65mrmH/sdSKejiOVNeFCRTQygH4f8bSCzKoIKryJ2OUyoOSLAaSLjsLAFVtBFB4LNtCGBEx/bdjStI8ueQHwW3EnSN+drbXA2VtBcwhG1qjALc9OLxv3W8PCFnticV6sZtSZ+GRMGE066GrrvFCNkEQHTZUX6TAL9cH2H29zEeaAblF32/PuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778033547; c=relaxed/relaxed;
	bh=HMqHW+wl1jJEGGmKKzAemuQMuR+F3aEoMElUydaAiH0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NHBD53+4jEp9Uj2b+CM+Jj76U0oWGANN2UeycjhrRp3sOfMICUYLqJIKvotyWca9hu26CaZkBqu6vkOsVc+GNDO5IDjf+OHkvLxRjPgVa0JqRzFmgpWXiOfPkRe7H7TZiHJlTOvtFETFJRGuQDon8cu++Z9wtqqPJY6ItvTpysCqlPMcNRePtFXGYuT52XhShWw28QcGu4rGLIkTS0HXamtscvRnn/Vi8O4B8Z+kzrGDZtWhtsz6VqmklTWmtIfbv5/CQUet0XJPG02nQygfpni1J700R9k4wgr4s6I9TWf4gnnHFOptUhkcw+GxuqtOMkmeL8peJwxGnbwfvrVKdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yNTbuRmo; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yNTbuRmo; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=xieyuanbin1@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yNTbuRmo;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yNTbuRmo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=xieyuanbin1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Jmj5zYLz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 12:12:21 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HMqHW+wl1jJEGGmKKzAemuQMuR+F3aEoMElUydaAiH0=;
	b=yNTbuRmolm/SEoq+MkaSp/cYhtRgK4nsCKZwtO3fqA6+9ZhleNRt68Jnv2/RrJISaYn6gSd+u
	aCx6xYY7OF2l0Uw8iMfP40fycKvDbh7HTo3w3AmhHFNraYyNk8UjMKjfYVfDjZn7E4qgOx7xeYc
	cbrTTJrKbUV2daiXo8CM/wE=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4g9JmK4Q6Xz1BFST
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2026 10:12:01 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HMqHW+wl1jJEGGmKKzAemuQMuR+F3aEoMElUydaAiH0=;
	b=yNTbuRmolm/SEoq+MkaSp/cYhtRgK4nsCKZwtO3fqA6+9ZhleNRt68Jnv2/RrJISaYn6gSd+u
	aCx6xYY7OF2l0Uw8iMfP40fycKvDbh7HTo3w3AmhHFNraYyNk8UjMKjfYVfDjZn7E4qgOx7xeYc
	cbrTTJrKbUV2daiXo8CM/wE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4g9Jbn3WcSzRhRT;
	Wed,  6 May 2026 10:04:37 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id CC7FD40561;
	Wed,  6 May 2026 10:12:09 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 6 May 2026 10:12:09 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <chleroy@kernel.org>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <andriy.shevchenko@intel.com>, <kees@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lilinjie8@huawei.com>, <liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: [PATCH V2] powerpc/text-patching: simplify the implementation of ppc_kallsyms_lookup_name()
Date: Wed, 6 May 2026 10:11:43 +0800
Message-ID: <20260506021143.13797-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
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
X-Originating-IP: [10.67.109.17]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100009.china.huawei.com (7.202.194.3)

ppc_kallsyms_lookup_name() is called only twice in the kernel code, and
the parameters are all constant strings. strnlen(name, KSYM_NAME_LEN) is
called inside ppc_kallsyms_lookup_name(), when the compiler detects that
KSYM_NAME_LEN is larger then the constant strings,
the following error will be triggered:
```log
  CC      arch/powerpc/kernel/optprobes.o
In file included from ./arch/powerpc/include/asm/kprobes.h:24,
                 from ./include/linux/kprobes.h:31,
                 from arch/powerpc/kernel/optprobes.c:8:
In function 'ppc_kallsyms_lookup_name',
    inlined from 'arch_prepare_optimized_kprobe' at arch/powerpc/kernel/optprobes.c:209:21:
./arch/powerpc/include/asm/text-patching.h:232:13: error: 'strnlen' specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
  232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'ppc_kallsyms_lookup_name',
    inlined from 'arch_prepare_optimized_kprobe' at arch/powerpc/kernel/optprobes.c:210:22:
./arch/powerpc/include/asm/text-patching.h:232:13: error: 'strnlen' specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
  232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
```

The error can be reproduced in the following ways:
Use lastest linux-next source, change ppc_kallsyms_lookup_name() to
__always_inline, use default ppc64_defconfig, set CONFIG_EXPERT=y,
CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n, CONFIG_CC_OPTIMIZE_FOR_SIZE=y,
and use gcc-14 or a later version for compilation.

Since ppc_kallsyms_lookup_name() is called only twice in the kernel,
and the parameters are all constant strins, simplify the implementation
of ppc_kallsyms_lookup_name() and avoid calling strnlen().

Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>
Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
v1->v2: https://lore.kernel.org/20260205100517.292858-2-xieyuanbin1@huawei.com
  - Not use strlen()

 arch/powerpc/include/asm/text-patching.h | 50 ++++++++----------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
index e7f14720f630..2d3f698cb4f1 100644
--- a/arch/powerpc/include/asm/text-patching.h
+++ b/arch/powerpc/include/asm/text-patching.h
@@ -221,39 +221,23 @@ static inline unsigned long ppc_global_function_entry(void *func)
  * - For ABIv1, we lookup the dot variant.
  * - For ABIv2, we return the local entry point.
  */
-static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
-{
-	unsigned long addr;
-#ifdef CONFIG_PPC64_ELF_ABI_V1
-	/* check for dot variant */
-	char dot_name[1 + KSYM_NAME_LEN];
-	bool dot_appended = false;
-
-	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
-		return 0;
-
-	if (name[0] != '.') {
-		dot_name[0] = '.';
-		dot_name[1] = '\0';
-		strlcat(dot_name, name, sizeof(dot_name));
-		dot_appended = true;
-	} else {
-		dot_name[0] = '\0';
-		strlcat(dot_name, name, sizeof(dot_name));
-	}
-	addr = kallsyms_lookup_name(dot_name);
-	if (!addr && dot_appended)
-		/* Let's try the original non-dot symbol lookup	*/
-		addr = kallsyms_lookup_name(name);
-#elif defined(CONFIG_PPC64_ELF_ABI_V2)
-	addr = kallsyms_lookup_name(name);
-	if (addr)
-		addr = ppc_function_entry((void *)addr);
-#else
-	addr = kallsyms_lookup_name(name);
-#endif
-	return addr;
-}
+static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
+{
+	unsigned long addr = kallsyms_lookup_name(name);
+
+	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1) && !addr)
+		addr = kallsyms_lookup_name(name + 1);
+	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
+		addr = ppc_function_entry((void *)addr);
+
+	return addr;
+}
+
+#ifdef CONFIG_PPC64_ELF_ABI_V1
+#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." x)
+#else
+#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
+#endif
 
 /*
  * Some instruction encodings commonly used in dynamic ftracing
-- 
2.53.0


