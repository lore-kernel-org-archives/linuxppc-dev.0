Return-Path: <linuxppc-dev+bounces-16742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5F5E81BC1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 13:25:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8lnC0lNSz2yFm;
	Tue, 10 Feb 2026 00:25:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770643535;
	cv=none; b=jE0nqFQuGRhA1DMopOA4nzSs9sdWiSUAInuOUxuFXMESsWL7bvSb6DVKXfanTb2Gf5GKeMPLRB6c6TGFHzvca+H2EY0EREk5t7HerUzOGV+bkV13mJwXA9L4sFbmC19kjte3d/MZdTd3uxE+z9g1QOiWFeVeycQCr01nkIGgaYsxW1Lfde1sMDlqqLykg/avoBEE9MSnnP5JS0sJXIZ7BUBWzezzYg58BQBzvw30EusS3+gDul1GvI4fZceHXX3WNUl290ll8o7f62uSJQLrMLBAE4RvwPwqHCS2AZ0JLr4e9uJMrdOByVZHPY8A5VqEljjQmuu++HIfYIA7H4q4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770643535; c=relaxed/relaxed;
	bh=JP4IbHsF/5YAbH5J94xCvyClExqMVG02cDoNWQwvPBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhHeXyNIZ8ZzUDCaC5go3/ZrpYKSPs4TsSekn2+9K13puUGk1FabUuIRfqmqgHTW9TGxfigSqPWkjOPWjwmFlHX5XqfrTYOzDTmnskrWokJXmSvez1U2CTYEhnYmQ01YDmKjaD0QfhDSbgXWEjn17YSe2+z2zmTr7/P4JBJSKGkGBnuo0g1erH30R8YXLnNgeD8jT0JjlZjQDlUs7tOvpvjWdwdC9mwfT65hsZgO/VIM8qU3Mfp+c1mgrdxwY4yFoIA30+fvPQt27Y7xOj998jT0PI4MX33GNXh2j+TvbjEyFNK8P2v9sWxgXoWPK6l1STYMcbq9dGHL97ZvhEDFVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FLZEIi8w; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=xieyuanbin1@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FLZEIi8w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=xieyuanbin1@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8ln53Myjz2xBV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2026 00:25:26 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JP4IbHsF/5YAbH5J94xCvyClExqMVG02cDoNWQwvPBQ=;
	b=FLZEIi8wDbq1RCgJ/4jdPYnzhY5Y09gbuel1W6qKZ8xZWUlTu8O9yb6QHzPK4lA6JKobB2+9n
	5ehZ+TITYJNmAH2ho7wCxuB92k7OX/Z++k7k+KxHhpi2gbsIwy/AgGTR6w5tzv7YoeduelL7Da+
	CYmv34HS43pkBShRogReoHw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f8lgd3BGyz1T4GQ;
	Mon,  9 Feb 2026 21:20:45 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 170CC4056A;
	Mon,  9 Feb 2026 21:25:15 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 9 Feb 2026 21:25:14 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <chleroy@kernel.org>, <andriy.shevchenko@intel.com>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<kees@kernel.org>, <andy@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread compilation error
Date: Mon, 9 Feb 2026 21:25:01 +0800
Message-ID: <20260209132510.84205-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <bca0abe3-5b8d-4493-a338-b41322e9e85d@kernel.org>
References: <bca0abe3-5b8d-4493-a338-b41322e9e85d@kernel.org>
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
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.17]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Fri, 6 Feb 2026 20:53:55 +0100, Christophe Leroy (CS GROUP) wrote:
> Le 06/02/2026 à 19:26, Kees Cook a écrit :
>>
>> Isn't it possible to do this and not need __compiletime_strlen at all?
>>
>> 	n_len = strnlen(name, min(__member_size(name), KSYM_NAME_LEN));
>
> ppc_kallsyms_lookup_name() only has two callers and they call it with a
> built-in string. I think we can do something a lot simpler, something
> like (untested):
>
> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
> {
> 	unsigned long addr = kallsyms_lookup_name(name);
>
> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
> 		addr = ppc_function_entry((void *)addr);
>
> 	return addr;
> }
>
> #ifdef CONFIG_PPC64_ELF_ABI_V1
> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." ## x);
> #else
> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
> #endif
>
> Christophe

When CONFIG_PPC64_ELF_ABI_V1=y, it seems that the try of lookupinp
the original non-dot symbol is missing.

What about this (Only the compilation test is performed):
```c
static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
{
	unsigned long addr = kallsyms_lookup_name(name);

	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
		addr = ppc_function_entry((void *)addr);

	return addr;
}

#define ppc_kallsyms_lookup_name(x) ({					\
		unsigned long addr = 0;					\
		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))		\
			addr = __ppc_kallsyms_lookup_name("." x);	\
		if (!addr)						\
			addr = __ppc_kallsyms_lookup_name(x);		\
		addr;							\
	})
```

