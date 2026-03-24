Return-Path: <linuxppc-dev+bounces-18664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C42F532E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:14:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg0B01s78z2yj3;
	Tue, 24 Mar 2026 17:14:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774332872;
	cv=none; b=Jh4q8WLgcT3xhR4DgtTBKkYFKqxASPtzyE5g/dYa7SxkG8IlKLKc0QxvoI9prd6PQScKV/xQfSoGw/Dr0Wiffp9sVs7sTptdn70KH8ftIrVQIdJ8jwUQdQvu9XmoHA9mddpYgaHe5FT2SFcdnPKKflbzfhah2f3S5zY/Lfh2tt9uOB3xn9zegGxgodelHk1eVFifsJXK5W5q+wiXfIvfo23sjTsxc18hw2htqJDGiVhwhZsYv5CP7yGm3vwy6izgD8h0YiUq7n2YGClUAmSg+taGEjRGvy0AU2wX8nSklPIZDUG5S7H0/t/DNKKSO0I5fHRS9DNo87oeWVEbET1Q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774332872; c=relaxed/relaxed;
	bh=qfaMojy4YCJI6x7hn3yLKKO+h1WPTwEnl4yVpQYK7UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f7PVnSYNMWXYUj+ZibdHHixJPO+IwHOY3wt/FWIc1hMLf9CsOWxjBGe42Fy496ANMwCzDjFGRhLWV8t9gQbktmdTUDiM2mtFWn8K3sdJ5wbBYCvmcQ0q0xznbXEMD7sldpV+vzZbX2NhEFvqkzr/jXF4zysR14lqYV5PT0TzlyaQx0Jia/QTY8+5bCDuhGgyMn4Fk3QYoAgDhffSvrpYVfZxo2oJdBMbqbmFSu6Rd8QcPcb2Zw2JFPjr+WbgbR4kO6ztGFe9zPkcRtwVmL6HUBo01b2aebooNga77GJQOgI0WhifUehZm6KOzDvKqXr08VohygVqIFhJMztKTX1WZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jpV0OS8P; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jpV0OS8P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg09y0Gkbz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 17:14:28 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qfaMojy4YCJI6x7hn3yLKKO+h1WPTwEnl4yVpQYK7UQ=;
	b=jpV0OS8P669YME8Q51wZE1sJYxg0mWoQB30y8MPrPMbvQ22ehAAXuIqteUT/3sIxyL1MmSP7h
	RbyG9KeFJGYgssJdZyGAsROKKri5Ypb8c7977na6j8YwpXxHoqMP1oXnnOWDxdKrCxthN2TlvfT
	lJ1A1OOOgmTlVrMeRWDFqEE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fg02m0NPjz1prkX;
	Tue, 24 Mar 2026 14:08:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B7AF22012A;
	Tue, 24 Mar 2026 14:14:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 14:14:20 +0800
Message-ID: <e51d5a5d-40d4-950b-274f-229e1d72e60d@huawei.com>
Date: Tue, 24 Mar 2026 14:14:18 +0800
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
Subject: Re: [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <rdunlap@infradead.org>,
	<peterz@infradead.org>, <feng.tang@linux.alibaba.com>,
	<pawan.kumar.gupta@linux.intel.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <paulmck@kernel.org>,
	<lirongqing@baidu.com>, <safinaskar@gmail.com>, <rppt@kernel.org>,
	<ardb@kernel.org>, <leitao@debian.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <eajames@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
	<fuqiang.wang@easystack.cn>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
 <20260323095548.fa4e13d6e8ae5005ae585e13@linux-foundation.org>
 <4cfde40c-673a-12b0-dfc5-703d582d6ea9@huawei.com>
 <595e793d-adc3-4acb-af18-f0a3cf2d5e73@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <595e793d-adc3-4acb-af18-f0a3cf2d5e73@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/24 12:29, Sourabh Jain wrote:
> 
> 
> On 24/03/26 09:32, Jinjie Ruan wrote:
>>
>> On 2026/3/24 0:55, Andrew Morton wrote:
>>> On Mon, 23 Mar 2026 15:27:40 +0800 Jinjie Ruan
>>> <ruanjinjie@huawei.com> wrote:
>>>
>>>> The crash memory allocation, and the exclude of crashk_res,
>>>> crashk_low_res
>>>> and crashk_cma memory are almost identical across different
>>>> architectures,
>>>> This patch set handle them in crash core in a general way, which
>>>> eliminate
>>>> a lot of duplication code.
>>>>
>>>> And add support for crashkernel CMA reservation for arm64 and riscv.
>>> Thanks.  AI review has completed and it asks questions:
>>>     https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie@huawei.com
>> I believe it identified 4 valid issues:
>>
>> - The already discovered crashk_low_res not excluded bug in the existing
>> RISC-V code.
>>
>> - An existing memory leak issue in the existing PowerPC code.
> 
> Yes and suggested approach to fix the issue looks good.
> Which is basically replace return with goto out.
> 
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 898742a5205c..1426d2099bad 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -440,7 +440,7 @@ static void update_crash_elfcorehdr(struct kimage
> *image, struct memory_notify *
>         ret = get_crash_memory_ranges(&cmem);
>         if (ret) {
>                 pr_err("Failed to get crash mem range\n");
> -               return;
> +               goto out;
>         }
> 
>         /*
> 
> Are you planning to handle this in this patch series? Or do you want me
> to send a separate fix patch?

Yes, will fix it in v10, thanks for the clarification.

Best regards,
Jinjie

> 
> 
>>
>> - The ordering issue of adding CMA ranges to "linux,usable-memory-range".
>>
>> - An existing concurrency issue. A Concurrent memory hotplug may occur
>> between reading memblock and attempting to fill cmem during kexec_load()
>> for almost all existing architectures，I'm not sure if this is a
>> practical issue in reality..

What are your thoughts on this concurrency issue?

>>
>>   Race Condition Scenario
>>
>>    Timeline:
>>    ---------------------------------------------------------------------
>>    T1: kexec_load() syscall starts
>>    T2: kexec_trylock() acquires kexec_lock
>>    T3: crash_prepare_headers() is called
>>    T4: arch_get_system_nr_ranges() queries memblock → finds 100 memory
>> ranges
>>    T5: cmem = alloc_cmem(100) allocates buffer for 100 ranges
>>    T6: [RACE WINDOW] Another process triggers memory hotplug
>>    T7: add_memory() → lock_device_hotplug() → memblock_add_node()
>>    T8: New memory region added to memblock
>>    T9: arch_crash_populate_cmem() iterates: now finds 102 ranges
>>    T10: cmem->ranges[100] → OUT OF BOUNDS WRITE!
>>    T11: cmem->ranges[101] → OUT OF BOUNDS WRITE!
>>    T12: Kernel crash or memory corruption
>>
>>    Why This Happens
>>
>>    1. Different locks used:
>>      - kexec_load() uses kexec_trylock (atomic_t)
>>      - Memory hotplug uses device_hotplug_lock (mutex)
>>    2. No synchronization between these two operations
>>    3. Time-of-check to time-of-use (TOCTOU) issue:
>>      - Step T4-T5: We query the number of ranges and allocate buffer
>>      - Step T6-T9: Memory hotplug adds new ranges between query and
>> population
>>
>>
>>
>> Any comments or suggestions on the following approach?
>>
>>
>> int crash_prepare_headers(...)
>>    {
>>        unsigned int max_nr_ranges;
>>        struct crash_mem *cmem;
>>        int ret;
>>
>>        lock_device_hotplug();
>>
>>        max_nr_ranges = arch_get_system_nr_ranges();
>>        // ...
>>        ret = arch_crash_populate_cmem(cmem);
>>        // ...
>>
>>        unlock_device_hotplug();
>>        return ret;
>>    }
>>
>>
> 

