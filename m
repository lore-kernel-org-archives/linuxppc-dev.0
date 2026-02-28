Return-Path: <linuxppc-dev+bounces-17431-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7AF1048926
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 01:21:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fN6qP5ffHz30BR;
	Sat, 28 Feb 2026 12:21:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772241713;
	cv=none; b=UE+7fosMd66LFAeLqClmK3W1tqCrF6kinFKkU345/lkcn3h1ygRa0t4s8JBXyypEHSho9/MRCL/Zwz9l4Z90Q0xAFS7cMHLq21yIXYVXxRueVNd5l8KCmeeZRyQ9s0S8UTKtpeTa4kYebeDpRJmh9JVzSCFFZWWjeeOhPskpTIipYRsh0q0My7HokM9c2j2Jpm4OATsX4/ZBq/nLvydSYrYU3ntH2OE6x6psjbK7b8i3CO2v3eW/iFapWq6UKmS0KiONSUquSDBluMd4K2ywofdND5nwvZtX0CPVOjkroGdTgWo/GnYB3A/lTkBhQdKU7ojou+YgoxKQx3JfT0Oz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772241713; c=relaxed/relaxed;
	bh=g3ZfEIXgV3HlWkTi5COZHl8zAZUARnL7AI5EioOhi5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oQSNg23oj/xkx27yiqEYvVMd2Aoq3XQT4TMKIpcIqHBOF3LjEUGf0U5M1dSZMsCPKhCyxJJysMJ4W8G5PTc+71ZsHrdupZam1GVZtEFFE/+BnD1Ie97+y01pRXMZjcapXPS+c/1i0XnaJu/WRRwBm0bp68RpCPXv7ZbMhx9zfEOOiyjstK7aYVs+BmryNqUbuCGq4Nqqyr+1PAwcvtI/TL7aYjuIJIKd+BVtO9QtaIlC54AynCYKoFd89FRaL7lyBZ1DaYf31UggNtluOLDgAxTv9+LxcB8UXZ1NSuTBNxzXDpzgXWwYHfMAFUNM73CREcSs+cPCVBrbGHbxZeX31Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=y33XKsOj; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=y33XKsOj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fN6qL3SmNz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 12:21:48 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=g3ZfEIXgV3HlWkTi5COZHl8zAZUARnL7AI5EioOhi5c=;
	b=y33XKsOjrl1QPprmFk09CWLS91eyuVn46hY5LCz9lV646qeLi/6dMSMulXugarz9N8ILeIO+N
	bJLJXGjfRFU2PrRMleHTL4N1wZXFSd63gZzNuj1Fd5HTVKu8Q/eD9yscO5RcmIvCjgwCn0Mf3jK
	U8P3Rbs9yf6dM6kXmFYTB9E=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fN6jV3JjXzpT0X;
	Sat, 28 Feb 2026 09:16:46 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 53C4740569;
	Sat, 28 Feb 2026 09:21:38 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Feb 2026 09:21:34 +0800
Message-ID: <0a776b5f-5a88-2c71-7305-d30d9240c2cb@huawei.com>
Date: Sat, 28 Feb 2026 09:21:33 +0800
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
Subject: Re: [PATCH v7 3/5] crash: Use crash_exclude_core_ranges() on powerpc
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <pmladek@suse.com>,
	<rdunlap@infradead.org>, <dapeng1.mi@linux.intel.com>, <kees@kernel.org>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <arnd@arndb.de>,
	<rppt@kernel.org>, <ardb@kernel.org>, <leitao@debian.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <ryan.roberts@arm.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <samuel.holland@sifive.com>,
	<kevin.brodsky@arm.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
	<brgerst@gmail.com>, <fuqiang.wang@easystack.cn>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260226130437.1867658-1-ruanjinjie@huawei.com>
 <20260226130437.1867658-4-ruanjinjie@huawei.com>
 <3576865b-65bd-4289-babc-975a543eb775@linux.ibm.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <3576865b-65bd-4289-babc-975a543eb775@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/2/27 22:50, Sourabh Jain wrote:
> Resend of:
> https://lore.kernel.org/all/19cf18b5-362d-4ff2-8b85-e2e72809250c@linux.ibm.com/
> 
> On 26/02/26 18:34, Jinjie Ruan wrote:
>> The crash memory exclude of crashk_res and crashk_cma memory on powerpc
>> are almost identical to the generic crash_exclude_core_ranges().
>>
>> By introducing the architecture-specific arch_crash_exclude_mem_range()
>> function with a default implementation of crash_exclude_mem_range(),
>> and using crash_exclude_mem_range_guarded as powerpc's separate
>> implementation, the generic crash_exclude_core_ranges() helper function
>> can be reused.
>>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/powerpc/kexec/ranges.c | 16 ++++------------
>>   include/linux/crash_core.h  |  4 ++++
>>   kernel/crash_core.c         | 19 +++++++++++++------
>>   3 files changed, 21 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
>> index 6c58bcc3e130..e5fea23b191b 100644
>> --- a/arch/powerpc/kexec/ranges.c
>> +++ b/arch/powerpc/kexec/ranges.c
>> @@ -553,9 +553,9 @@ int get_usable_memory_ranges(struct crash_mem
>> **mem_ranges)
>>   #endif /* CONFIG_KEXEC_FILE */
>>     #ifdef CONFIG_CRASH_DUMP
>> -int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
>> -                       unsigned long long mstart,
>> -                       unsigned long long mend)
>> +int arch_crash_exclude_mem_range(struct crash_mem **mem_ranges,
>> +                 unsigned long long mstart,
>> +                 unsigned long long mend)
> 
> 
> update_crash_elfcorehdr() in arch/powerpc/kexec/crash.c still calls
> crash_exclude_mem_range_guarded(), causing a build failure.
> 
> ld: arch/powerpc/kexec/crash.o: in function `update_crash_elfcorehdr':
> /root/linux/arch/powerpc/kexec/crash.c:454: undefined reference to
> `crash_exclude_mem_range_guarded'
> 
> 
> To fix this:
> --------------
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 898742a5205c..e59e909c369d 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -451,7 +451,7 @@ static void update_crash_elfcorehdr(struct kimage
> *image, struct memory_notify *
>                 base_addr = PFN_PHYS(mn->start_pfn);
>                 size = mn->nr_pages * PAGE_SIZE;
>                 end = base_addr + size - 1;
> -               ret = crash_exclude_mem_range_guarded(&cmem, base_addr,
> end);
> +              ret = arch_crash_exclude_mem_range(&cmem, base_addr, end);
>                 if (ret) {
>                         pr_err("Failed to remove hot-unplugged memory
> from crash memory ranges\n");
>                         goto out;
> 
> With the above change included, things are working fine on powerpc.

It seems the declaration of crash_exclude_mem_range_guarded() added in
arch/powerpc/include/asm/kexec_ranges.h can also be removed.

> 
> 
>>   {
>>       struct crash_mem *tmem = *mem_ranges;
>>   @@ -604,18 +604,10 @@ int get_crash_memory_ranges(struct crash_mem
>> **mem_ranges)
>>               sort_memory_ranges(*mem_ranges, true);
>>       }
>>   -    /* Exclude crashkernel region */
>> -    ret = crash_exclude_mem_range_guarded(mem_ranges,
>> crashk_res.start, crashk_res.end);
>> +    ret = crash_exclude_core_ranges(mem_ranges);
>>       if (ret)
>>           goto out;
>>   -    for (i = 0; i < crashk_cma_cnt; ++i) {
>> -        ret = crash_exclude_mem_range_guarded(mem_ranges,
>> crashk_cma_ranges[i].start,
>> -                          crashk_cma_ranges[i].end);
>> -        if (ret)
>> -            goto out;
>> -    }
>> -
>>       /*
>>        * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
>>        *        regions are exported to save their context at the time of
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index 033b20204aca..dbec826dc53b 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -68,6 +68,7 @@ extern int crash_prepare_elf64_headers(struct
>> crash_mem *mem, int need_kernel_ma
>>                          void **addr, unsigned long *sz);
>>   extern int crash_prepare_headers(int need_kernel_map, void **addr,
>>                    unsigned long *sz, unsigned long *nr_mem_ranges);
>> +extern int crash_exclude_core_ranges(struct crash_mem **cmem);
>>     struct kimage;
>>   struct kexec_segment;
>> @@ -88,6 +89,9 @@ extern int kimage_crash_copy_vmcoreinfo(struct
>> kimage *image);
>>   extern unsigned int arch_get_system_nr_ranges(void);
>>   extern int arch_crash_populate_cmem(struct crash_mem *cmem);
>>   extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
>> +extern int arch_crash_exclude_mem_range(struct crash_mem **mem,
>> +                    unsigned long long mstart,
>> +                    unsigned long long mend);
>>     #else /* !CONFIG_CRASH_DUMP*/
>>   struct pt_regs;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 96a96e511f5a..300d44ad5471 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -287,24 +287,31 @@ unsigned int __weak
>> arch_get_system_nr_ranges(void) { return 0; }
>>   int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return
>> -1; }
>>   int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) {
>> return 0; }
>>   -static int crash_exclude_core_ranges(struct crash_mem *cmem)
>> +int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
>> +                    unsigned long long mstart,
>> +                    unsigned long long mend)
>> +{
>> +    return crash_exclude_mem_range(*mem, mstart, mend);
>> +}
>> +
>> +int crash_exclude_core_ranges(struct crash_mem **cmem)
>>   {
>>       int ret, i;
>>         /* Exclude crashkernel region */
>> -    ret = crash_exclude_mem_range(cmem, crashk_res.start,
>> crashk_res.end);
>> +    ret = arch_crash_exclude_mem_range(cmem, crashk_res.start,
>> crashk_res.end);
>>       if (ret)
>>           return ret;
>>         if (crashk_low_res.end) {
>> -        ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
>> crashk_low_res.end);
>> +        ret = arch_crash_exclude_mem_range(cmem,
>> crashk_low_res.start, crashk_low_res.end);
>>           if (ret)
>>               return ret;
>>       }
>>         for (i = 0; i < crashk_cma_cnt; ++i) {
>> -        ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
>> -                          crashk_cma_ranges[i].end);
>> +        ret = arch_crash_exclude_mem_range(cmem,
>> crashk_cma_ranges[i].start,
>> +                           crashk_cma_ranges[i].end);
>>           if (ret)
>>               return ret;
>>       }
>> @@ -331,7 +338,7 @@ int crash_prepare_headers(int need_kernel_map,
>> void **addr, unsigned long *sz,
>>       if (ret)
>>           goto out;
>>   -    ret = crash_exclude_core_ranges(cmem);
>> +    ret = crash_exclude_core_ranges(&cmem);
>>       if (ret)
>>           goto out;
>>   
> 

