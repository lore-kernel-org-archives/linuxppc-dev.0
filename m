Return-Path: <linuxppc-dev+bounces-26435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41590C624D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 10:01:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZdYC1gm6z2xlY;
	Wed, 02 Sep 2026 20:01:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788343295;
	cv=none; b=ASdxpw7gjnyn5vE7zH56uejwTJOs50FKxZCNcm99xIzAQEiB363HMPiFXfaajjeAB/HnmIecwHjcGENfxE4A+a3S9DDO9QJzhTomRQxDLLQKW3mpzqa04FWQPn1RVkmJIPEBH/qMMSL3NoJmRai+MvSj+acMf2Io6Kb6ZbhoGdADSt1JJxoMBwL7uiiSgwYBMN8lDt0GGLA+iNioAbWx9VghZQ/x9REpQIqdNGcb06a5mCyIxC4eCq7dY7WncNUywpiBMN0i0qQ8hwFtidFPPz68wNspkMvN/SsScXXFWZtI+PMa2bMSfkI8iym5JD05KG7iMw/XO7AFP9igXxNQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788343295; c=relaxed/relaxed;
	bh=5muCGImxQEXCs9mgbU84wjK603R7oDB3KGXYhDYZoIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KVgnzyhPx77/eMBXptHEqjdIcqs/Hv2+Kabpu6WyOQTqe3CpktwGpPhY2NFhkA9j+ekWq/71ijtDNvjXUxQR+oMzb7mSPy/dyglHrzToqQjKG+S7flbR4KyCMrsaaUblPDQ+qzXpAi6VkJygpIz77RI6eY0CpJ482x9DENWMNOo+o7vrxUGdgMflk/wyJ0wXfJcIkhMC3yu7DirPVQqoVdEY6TmSqiuEyduLkHlkqxALeT6YNVdw5MXeQBRb+OALltEJvf2bjLzf6XWC/germznM41Kk/kuDPDrK0xv/IwZy58nXOTQqfQXynvv6oHy0YTTyS7ix0bsRdL8dbtfTnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1OKXC1Wl; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1OKXC1Wl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZdY770yhz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 20:01:28 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5muCGImxQEXCs9mgbU84wjK603R7oDB3KGXYhDYZoIc=;
	b=1OKXC1WlAcuXvATuYy9843J+ts23aqDRPtEBmymokcm2wcDFN7n+VLXs5YlFtuuOI17YRGOle
	AE1kaDyBL8Psb6qsvqP6GD+2KaR9IZFlJSaA9VKKZKh4vJ8pLjxN4lSw5BvQVM6ddEVaTK1WC49
	5AuTsqZ1V1GNz92YBNN1IQA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZdHw4T64znTwN;
	Wed,  2 Sep 2026 17:50:04 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C74E54057A;
	Wed,  2 Sep 2026 18:01:17 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Sep 2026 18:01:15 +0800
Message-ID: <d12302b0-f0b3-4df6-963c-bf25b6e720c7@huawei.com>
Date: Wed, 2 Sep 2026 18:01:14 +0800
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
Subject: Re: [PATCH v3 12/17] x86/crash: Use num_possible_cpus() for
 elfcorehdr size
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mark.rutland@arm.com>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <jic23@kernel.org>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<coxu@redhat.com>, <tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>,
	<adityag@linux.ibm.com>, <ionut.nechita@windriver.com>,
	<liaoyuanhong@vivo.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<makb@juniper.net>, <piliu@redhat.com>, <ebiggers@kernel.org>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-13-ruanjinjie@huawei.com>
 <99b1121d-4277-4764-8c3a-b3f6d9a47ab0@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <99b1121d-4277-4764-8c3a-b3f6d9a47ab0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/9/2 14:14, Sourabh Jain 写道:
> Hello Jinjie,
> 
> This patch makes the below patch redundant..
> https://lore.kernel.org/all/20260826073527.21487-2-
> ionut.nechita@windriver.com/
> 
> I suggest dropping the first patch from the above series and including
> the second patch from that series in this patch series with the updated
> comment.

Agreed. This approach makes sense to me.

I will update it in v4.

> 
> - Sourabh Jain
> 
> 
> On 26/08/26 14:55, Jinjie Ruan wrote:
>> Use num_possible_cpus() instead of CONFIG_NR_CPUS to calculate the
>> elfcorehdr buffer size, matching what crash_prepare_elf64_headers()
>> already uses for the actual header content.
>>
>> This avoids over-allocation when the system has fewer possible CPUs
>> than the compile-time limit, and aligns x86 with PowerPC.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/x86/kernel/crash.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index a3bf786286d4..afe2aea19f47 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
>>        * maximum CPUs and maximum memory ranges.
>>        */
>>       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -        pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +        pnum = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>       else
>> -        pnum += 2 + CONFIG_NR_CPUS;
>> +        pnum += 2 + num_possible_cpus();
>>         if (pnum < (unsigned long)PN_XNUM) {
>>           kbuf.memsz = elf64_phdr_size(pnum);
>> @@ -429,7 +429,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>       unsigned int sz;
>>         /* kernel_map, VMCOREINFO and maximum CPUs */
>> -    sz = 2 + CONFIG_NR_CPUS;
>> +    sz = 2 + num_possible_cpus();
>>       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>>           sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>>       sz *= sizeof(Elf64_Phdr);
> 


