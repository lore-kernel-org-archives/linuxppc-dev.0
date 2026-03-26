Return-Path: <linuxppc-dev+bounces-18825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2ED10A62CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 13:09:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhPJF6zP3z2yS4;
	Fri, 27 Mar 2026 00:09:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774530589;
	cv=none; b=KE3m1FTJ48EceXSKjnysK8PpbBlYKL6eXThmct8+k5fRmoLBN0VTk54lpUMjr+Zyac4NLPpTH8duN0iY1rM3JDN9YxeOB4vmyBpFLBiZFpRuyZXzbPjadpAieOHPhSHYrXHEcpm1XNCkcUpmkDAufL56N59VjK0eS9Ay85b3bFNLnegP8qXobj3/tTHKwhQHe0BoUWcThXFmsROg+YQXhVTVaalzZZTr2rt9HpM5OBfqsEKFqY5JBMJO1FwBfghWJPi+vJHJQ6PK+8PQ4uqi9CeerXJIF7Y6gwa+5OYdXAO0CNyZNZqOtXIj2NuwEJyawYWOi7qK3AhI09TwOeZpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774530589; c=relaxed/relaxed;
	bh=jLyfKSEzGPeE1dJtR15Kc0eOwoYz6wTxdsqltUK1s+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f1J+KUufyDCfz0s/BTyrKDs0j6ISBbT83/2R8s0SkJu5fGydHoekImNSLxj8MIkd6Zkb5LKjGhcRAggJ/Bq46EP7uWdvkjauqBVJnrrfoc2oN0IWZpznI4Ri7q/74oIJvHBwFz1kzvwrkKzvUC3mG+JnaSmohJiS8HMUfwC4lMTHT2T90h6OJW4JKG6MXOjtgw4K8XmBi6OTHeetPyDj1t+sMTYk59+Gu+FKVPwSA3yF5yxKib3RP9A69hZgmKkmukIOtnWkTXGJdtXTpXBIMJLcrRAdlyprNCM2/JM4bVps+8nxn58MqaKnSzAjysBeuXnYG5KNcIf0wQolI45FuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=r27NhnWJ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=r27NhnWJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhPJ74Pdnz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 00:09:39 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jLyfKSEzGPeE1dJtR15Kc0eOwoYz6wTxdsqltUK1s+8=;
	b=r27NhnWJDoBRU0BLviPWrzC48eoWH2aXc39RU0NNg9RfVmkYMPQAakNbwupG9o1vLSlUZgi3I
	9q6pjI1LWhogcfA3FIhnuqdaqvSt3N0ef5hNY4GTFUKrfjR9jw+KWWzREvNA4nYdsjVC61P8MMl
	7eCWHr3D/yJXJKgUr+I5ku0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fhP8m1T9zzRhQP;
	Thu, 26 Mar 2026 21:03:20 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 757E14056A;
	Thu, 26 Mar 2026 21:09:26 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 21:09:22 +0800
Message-ID: <b82f26e6-adac-e921-6547-94d3284d2678@huawei.com>
Date: Thu, 26 Mar 2026 21:09:16 +0800
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
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v10 0/8] arm64/riscv: Add support for crashkernel CMA
 reservation
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <rdunlap@infradead.org>,
	<peterz@infradead.org>, <pawan.kumar.gupta@linux.intel.com>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <paulmck@kernel.org>,
	<lirongqing@baidu.com>, <rppt@kernel.org>, <ardb@kernel.org>,
	<leitao@debian.org>, <osandov@fb.com>, <cfsworks@gmail.com>,
	<tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <eajames@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
	<jbohac@suse.cz>, <fuqiang.wang@easystack.cn>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <james.morse@arm.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
 <20260325210049.28cca592a001e745954b3241@linux-foundation.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260325210049.28cca592a001e745954b3241@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/26 12:00, Andrew Morton wrote:
> On Wed, 25 Mar 2026 10:58:56 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
>> and crashk_cma memory are almost identical across different architectures,
>> This patch set handle them in crash core in a general way, which eliminate
>> a lot of duplication code.
>>
>> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> So who is patchmonkey for this.
> 
>>  .../admin-guide/kernel-parameters.txt         |  16 +--
>>  arch/arm64/kernel/machine_kexec_file.c        |  39 ++-----
>>  arch/arm64/mm/init.c                          |   5 +-
>>  arch/loongarch/kernel/machine_kexec_file.c    |  39 ++-----
>>  arch/powerpc/include/asm/kexec_ranges.h       |   1 -
>>  arch/powerpc/kexec/crash.c                    |   7 +-
>>  arch/powerpc/kexec/ranges.c                   | 101 +----------------
>>  arch/riscv/kernel/machine_kexec_file.c        |  38 ++-----
>>  arch/riscv/mm/init.c                          |   5 +-
>>  arch/x86/kernel/crash.c                       |  89 ++-------------
>>  drivers/of/fdt.c                              |   9 +-
>>  drivers/of/kexec.c                            |   9 ++
>>  include/linux/crash_core.h                    |   9 ++
>>  kernel/crash_core.c                           | 105 +++++++++++++++++-
> 
> Me, I guess, with as many arch acks as I can gather, please.
> 
> I'm seriously trying to slow things down now, but I guess I can make an
> exception for non-MM material.
> 
> AI review asks a few questions:
> 	https://sashiko.dev/#/patchset/20260325025904.2811960-1-ruanjinjie@huawei.com
> 
> Can you please check these?  And I'm interested in learning how many of
> these are valid.  Thanks.

Thanks for the feedback. At the very least, the issue highlighted below
remains valid and needs to be addressed, which can be fixed with below
fixed number usable ranges.

+#define MAX_USABLE_RANGES		(6)

"
> */
> -#define MAX_USABLE_RANGES		2
> +#define MAX_USABLE_RANGES		(2 + CRASHKERNEL_CMA_RANGES_MAX)
Could this silently drop crash memory if the crash kernel is built without
CONFIG_CMA?
If the main kernel is compiled with CONFIG_CMA, it might append up to 6
regions to the linux,usable-memory-range property (2 standard + 4 CMA).
If the crash kernel is compiled without CONFIG_CMA,
CRASHKERNEL_CMA_RANGES_MAX
evaluates to 0. During boot, the crash kernel's FDT parsing logic limits the
ranges to MAX_USABLE_RANGES (which would be 2). This truncates the ranges
and drops all the CMA-backed crash memory.
Since the crash kernel only registers these regions as normal RAM, it
doesn't
require CONFIG_CMA to use them. Should MAX_USABLE_RANGES unconditionally
accommodate the maximum possible ranges any sender might provide?"



Regarding the concurrency issue mentioned below, as noted in my v9
response, could we confirm if this is indeed a bug? If so, I believe
each affected architecture might need a separate fix, as this issue
already exists in the current code and likely requires a more
comprehensive solution. Does anyone have thoughts on whether this is a
valid concern or suggestions on how to address it?


Link:
https://lore.kernel.org/all/4cfde40c-673a-12b0-dfc5-703d582d6ea9@huawei.com/


"
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -326,15 +326,25 @@ int crash_prepare_headers(int need_kernel_map,
void **addr, unsigned long *sz,
>  	struct crash_mem *cmem;
>  	int ret;
>
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		lock_device_hotplug();
Can this cause a self-deadlock during memory hotplug?
When memory is onlined or offlined via sysfs (for example, in state_store()
calling lock_device_hotplug_sysfs()), the device_hotplug_lock is already
acquired before initiating the hotplug sequence.
Since crash_prepare_headers() can be invoked by the crash_memhp_notifier
during these memory hotplug operations, acquiring device_hotplug_lock again
here would cause a recursive mutex acquisition.
> +
>  	max_nr_ranges = arch_get_system_nr_ranges();
> -	if (!max_nr_ranges)
> -		return -ENOMEM;
> +	if (!max_nr_ranges) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
>
>  	cmem = alloc_cmem(max_nr_ranges);
> -	if (!cmem)
> -		return -ENOMEM;
> +	if (!cmem) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
>
>  	ret = arch_crash_populate_cmem(cmem);
While the locking attempts to address the race, is it possible that the
architecture specific population callbacks could still write out of bounds?
The callbacks appear to unconditionally write to
cmem->ranges[cmem->nr_ranges]
without verifying if cmem->nr_ranges >= cmem->max_nr_ranges.
Would it be safer to also add explicit bounds checking inside the populate
callbacks to return an error like -ENOMEM when the array capacity is
exceeded?"

> 

