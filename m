Return-Path: <linuxppc-dev+bounces-20340-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C67CD13D3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 07:29:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5m5g5ZmVz2xjk;
	Thu, 30 Apr 2026 17:29:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777534183;
	cv=none; b=cBU0JkdLsr308ZTl/m7SWQMG1LBKd9f5fAIR+hzX3z7TpEYTjYGftufYOpeJ8GXLkbTjgVYApmnHPf+U9SlpyCdsVdBO6sA5kT3m3vD5k2xNmnzGdKQ3YhwBRh2/iYNU0Rl+yY5PjT3O1mmvB/mMITQOaoHVFSDGfbIlDQPZf3deq8QTCQa1+/XcIXoEM5g0Cr9qVZXYE7kM6M81km+Mj1aDdw8Qs1xC3ShdQWxvtJN8FDhxqYz9esAe+f9qBcWyOWkHTVisota01zFXkERoSU/q4wnv0Nut9cNH5zQRAl8uuEPLNeoKsGQHU0B9gM6p0Io8flkHV/+MYCUETB6z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777534183; c=relaxed/relaxed;
	bh=0ltKK1NTBIxI4tmmAgwYrZVN6incxK415s9umw/K/2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4fAYam/n4prjfEy/8hvwZssGgFY0ygCitTLf9UJ7xxDrunDjjXR8ST0lliOX1pzpfgJZstMsDQLu8gFWSxgv0wtBjevauqiuHqDYkegVDMorV3ngYT3fiIfTtwpMbpv51pDMB/3kUUVQNIsUBkwUMTFNXv+AGBp5S/ORxDTyEgqiYns1UhCXYDbvRIGfx9ykdN3v6rRz1LxX6Z21wakhEbk9EDC6URaqtKl1ZWieHHupMvQx0DJnia+gY9inUXHRCG87jErUfXim0WC+1rXi6XJPREex7+FfVC4YDeWpw/U1E/pnu3bw3X4nxtuFsT/+dTZxXlxEq4L7v7TEwzaoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4qrHUuqj; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4qrHUuqj; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=xieyuanbin1@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4qrHUuqj;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4qrHUuqj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=xieyuanbin1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5m5c5tYbz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 17:29:40 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0ltKK1NTBIxI4tmmAgwYrZVN6incxK415s9umw/K/2s=;
	b=4qrHUuqjB2Ldo30BrvO8GDtQwcXYf/SUQegRFIHagkY2YXiyDLNvC41gVmtFFr/iBfcb5isoc
	Npajhmjp8FKg0Jpbvz6VON5wcTxGVpgCTIDC9VNtit5G2VY68n30v26Nfo6V+8TD5qavdAEW5Cr
	oNJ7ANEM3xfP1kZEXPTkew0=
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4g5m5Q6ZfRz1BGC5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 15:29:30 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0ltKK1NTBIxI4tmmAgwYrZVN6incxK415s9umw/K/2s=;
	b=4qrHUuqjB2Ldo30BrvO8GDtQwcXYf/SUQegRFIHagkY2YXiyDLNvC41gVmtFFr/iBfcb5isoc
	Npajhmjp8FKg0Jpbvz6VON5wcTxGVpgCTIDC9VNtit5G2VY68n30v26Nfo6V+8TD5qavdAEW5Cr
	oNJ7ANEM3xfP1kZEXPTkew0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g5lx72NsnznTZF;
	Thu, 30 Apr 2026 15:22:19 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id A9AB64064A;
	Thu, 30 Apr 2026 15:29:29 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Apr 2026 15:29:29 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <chleroy@kernel.org>, <andriy.shevchenko@intel.com>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<kees@kernel.org>, <andy@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread compilation error
Date: Thu, 30 Apr 2026 15:28:38 +0800
Message-ID: <20260430072913.62348-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5cfae419-427a-471b-8bbe-645f56442e2c@kernel.org>
References: <5cfae419-427a-471b-8bbe-645f56442e2c@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.17]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

Hi, Christophe Leroy!

On Mon, 9 Feb 2026 14:41:51 +0100, Christophe Leroy (CS GROUP) wrote:
> On 09/02/2026 14:25, Xie Yuanbin wrote:
>> When CONFIG_PPC64_ELF_ABI_V1=y, it seems that the try of lookupinp
>> the original non-dot symbol is missing.
>>
>> What about this (Only the compilation test is performed):
>> ```c
>> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
>> {
>> 	unsigned long addr = kallsyms_lookup_name(name);
>>
>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
>> 		addr = ppc_function_entry((void *)addr);
>>
>> 	return addr;
>> }
>>
>> #define ppc_kallsyms_lookup_name(x) ({					\
>> 		unsigned long addr = 0;					\
>> 		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))		\
>> 			addr = __ppc_kallsyms_lookup_name("." x);	\
>> 		if (!addr)						\
>> 			addr = __ppc_kallsyms_lookup_name(x);		\
>> 		addr;							\
>> 	})
>> ```
>
> Good point.
>
> To avoid duplicating the string I'd suggest:
>
> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
> {
> 	unsigned long addr = kallsyms_lookup_name(name);
>
> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1) && !addr)
> 		addr = kallsyms_lookup_name(name + 1);
> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
> 		addr = ppc_function_entry((void *)addr);
>
> 	return addr;
> }
>
> #ifdef CONFIG_PPC64_ELF_ABI_V1
> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." x);
> #else
> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
> #endif

I would like to submit the modification as a new patch, and include you
as Co-developer. Do you agree?

Full of the patch:
```patch
From fbf07e5c1a97da7c8572435537f2b92213ede39d Mon Sep 17 00:00:00 2001
From: Xie Yuanbin <xieyuanbin1@huawei.com>
Date: Thu, 30 Apr 2026 14:15:26 +0800
Subject: [PATCH V2] powerpc/text-patching: simplify the implementation of ppc_kallsyms_lookup_name()

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
In function ‘ppc_kallsyms_lookup_name’,
    inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:209:21:
./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
  232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘ppc_kallsyms_lookup_name’,
    inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:210:22:
./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
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
Co-developed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
v1->v2: https://lore.kernel.org/20260205100517.292858-2-xieyuanbin1@huawei.com
  - Not use strlen()

 arch/powerpc/include/asm/text-patching.h | 42 ++++++++----------------
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
```

