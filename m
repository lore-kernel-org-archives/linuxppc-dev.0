Return-Path: <linuxppc-dev+bounces-26425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C178C624D5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 01:19:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZPz03kVqz2x9g;
	Wed, 02 Sep 2026 11:19:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788311980;
	cv=none; b=f/2Y6b3nTGIkVjTYD8jGjft6J4Ilhz4/XKUa+1U56pCyJ8syxaNnWNXRfa35HEgZ5L2UNovwb6VLx3LUZUdn3UJwYn4a29+WV2ixf/O7qzcgOkzEGJnHVzEnwZ+S2NLHWKgTJyQgeT3kPoXKygSmB1TzR8kiFf1QXYUV/W+EQ4hf8TY4aNLQbc0VO6Ff3YUCstVhG0PqQjuoI9WVWyDIeWOXphAAjOM39dYeidJ8oPK8jg5SNTbZ/xhWJ1EyX5YO9ypob7oXENbTvQZ+ynfsS2A5lF4+SmRBulsX9lPeEX6NIeVvLjgNkoTSnFZmMv1/1nAbqkuIcTGtHNBH7ciPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788311980; c=relaxed/relaxed;
	bh=t9UK13JKhSsPM/Vc9steoJSl+OnutIzRnlZukeamK+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fJCBly6R0bRks+nL3Sr+H9Int7NOs3b78rVY/lfVItR6BxEv1jWsjf3ahP+1XIg22LbiXYa0i9IX3WX1FrTUkuadqUsQ1QW+pL2YDZdPu1Mk0BsGHEK4anUfs+TUF7nS0+1aeqWV1XKFScqnz/Mqhy7fZbDyqOeXPkpWdMJhg5lXxiAK3PXvw1BQ1nO9f6z7IVoUwN8cONqeuoyOsxkDhyYAy0FbfRAb/CIiqX/d/qIVYJNoBytjy9sAdpjA24AykeRmcIS+PBKUj7GBRxgRpfS3xRqyph80H0VS7HR+yvmj41G4cu1MD36PF2hj3QlnmUfRnqN4PnoV74Ra2c7dsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JSc/QrUE; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JSc/QrUE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZPyy3Wvzz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 11:19:38 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t9UK13JKhSsPM/Vc9steoJSl+OnutIzRnlZukeamK+o=;
	b=JSc/QrUEAnbPE7s6EK6aHXX4FMrI/ak+7N46GxWAYjo+hv4+e8IRFqw3R57vf10ZXvwgmTnw1
	5LsKKvi+A3v/zJR4bWOVaYI3bbjz5k4AHVvkI67n+bm/COW12+QwJBDOanQFb2mbBv/tq3BctvX
	qaDBA0HnMSM+ut7AmVDhzas=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZPjt2PDTznTVd;
	Wed,  2 Sep 2026 09:08:18 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B4C9C40565;
	Wed,  2 Sep 2026 09:19:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Sep 2026 09:19:29 +0800
Message-ID: <96ba8924-b857-4dbc-9161-4c464901f974@huawei.com>
Date: Wed, 2 Sep 2026 09:19:28 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] crash: Simplify CRASH_MAX_MEMORY_RANGES handling
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <jic23@kernel.org>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <coxu@redhat.com>, <tangyouling@kylinos.cn>,
	<hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-16-ruanjinjie@huawei.com>
 <178829364021.3691424.12328056849597833403.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <178829364021.3691424.12328056849597833403.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/9/2 4:14, Mike Rapoport 写道:
> Hi,
> 
>> Set CRASH_MAX_MEMORY_RANGES to 0 when MEMORY_HOTPLUG is disabled, then
>> remove the now unnecessary IS_ENABLED(CONFIG_MEMORY_HOTPLUG) checks in
>> powerpc and x86 arch_crash_get_elfcorehdr_size().
>>
>> No functional change intended.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>> index fc0105c7af4c3..c47e3f867ea1f 100644
>> --- a/arch/powerpc/kexec/crash.c
>> +++ b/arch/powerpc/kexec/crash.c
>> @@ -474,9 +474,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>  	unsigned long phdr_cnt;
>>  
>>  	/* A program header for possible CPUs + vmcoreinfo */
>> -	phdr_cnt = num_possible_cpus() + 1;
>> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +	phdr_cnt = num_possible_cpus() + 1 + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>  
>>  	return elf64_phdr_size(phdr_cnt);
>>  }
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 99eb8583d9321..116410ac90fb4 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -407,9 +407,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>  	unsigned int sz;
>>  
>>  	/* kernel_map, VMCOREINFO and maximum CPUs */
>> -	sz = 2 + num_possible_cpus();
>> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +	sz = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>  	sz *= sizeof(Elf64_Phdr);
>>  	return sz;
>>  }
>> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>> index a97ed9605602f..e6251dfe451a8 100644
>> --- a/kernel/Kconfig.kexec
>> +++ b/kernel/Kconfig.kexec
>> @@ -160,7 +160,8 @@ config CRASH_HOTPLUG
>>  
>>  config CRASH_MAX_MEMORY_RANGES
>>  	int "Specify the maximum number of memory regions for the elfcorehdr"
>> -	default 8192
>> +	default 8192 if MEMORY_HOTPLUG
>> +	default 0 if !MEMORY_HOTPLUG
> 
> This only sets the default, but a user can change the value explicitly.

You're right. Let me drop this patch for now. Thanks for the review!

> 


