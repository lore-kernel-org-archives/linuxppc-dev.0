Return-Path: <linuxppc-dev+bounces-16822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB6DEDF021
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Feb 2026 03:28:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBLPM6NB9z2xcB;
	Thu, 12 Feb 2026 14:28:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770866935;
	cv=none; b=ovbg7u2pkrEwxkRSFFBS/gUisSBaCSufFNrXAA9kJf/RWrYMmepfxr22Y30kGlieBONlae+HdMSoBn2xSncNYwNh41YjGAmLowALMknHNo/6t51hWBCEQzDfn5saAeMWwSjF2gkB2IOomLkFMUnoaOyc+/xAwJjcegm+S0HGYlv9NIPjXWuV8XuclMsj4FpquuWfKjz0edmEUSe/3/bRVVeQs4yAkcBNchFh9a7Uim9DvA+5I8pI+1qhyzcuMkwedEOfcscMbwadHv4QQLv7LvbHxLQEy0j3o7wejXM70AJ94Noqx+LsbWy6A5O06CJ0cAELbJxCrocPwHPYbxl0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770866935; c=relaxed/relaxed;
	bh=RZTcbKUpf2wubcUUQwFd4TLSwyssXimapX4rFbyIz5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MeqOYltVJY4b2l+VjAA17jfJ9Y6sOqlfs6NHBz0SvIE/3vpEi7AC4/+SV5ORi0LO3Eav2rI7IFQmZ6PT7csgWow10E5M9USVGSzga+Wwh+HbQjdDvNIAiIsaYP27d9B5Wl3wNrGjhQPn5t0ylw98iQMI500Ws8g4p0D8ZRKEVTjXJAA9eO7MBH2vZMC0NesI2JlMN29Ut2Ifahc1yVF0QQ5js3zK/C4DYiUgyzSGvlRliNSxt06YBK+7RyrZKDlEoHwW9gWyc6qeT15u5kSoqS9pDl9DlEX0Z5bGVCgeOL/4MRhV+2ISgAS5aWS8EjN04xTDN/z7yqGjqVqIB48hqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cXMfoad+; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cXMfoad+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBLPK339Jz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2026 14:28:52 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RZTcbKUpf2wubcUUQwFd4TLSwyssXimapX4rFbyIz5A=;
	b=cXMfoad+w/Ix+LI9YndMWoNmF4Iu3IJhXflwlT1MxUXYGZVZzdihNCJKOT0lufO87rj8TPJxq
	3rCoLyHgE6YQfJO7OcmMQHWBZTvKnoxt4QdFUAjcXo3Ou/NK7Ychs3Q1erI52ZOjhspHUesfzbk
	tjGTeV7nVTLFy9vfIpqFDy4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fBLHs1gjWzRhRT;
	Thu, 12 Feb 2026 11:24:09 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 7371340567;
	Thu, 12 Feb 2026 11:28:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Feb 2026 11:28:43 +0800
Message-ID: <31c2ae53-cbb7-bfad-9b8f-f9e1a254491e@huawei.com>
Date: Thu, 12 Feb 2026 11:28:42 +0800
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
Subject: Re: [PATCH v4 1/3] crash: Exclude crash kernel memory in crash core
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <feng.tang@linux.alibaba.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<arnd@arndb.de>, <lirongqing@baidu.com>, <fvdl@google.com>,
	<leitao@debian.org>, <rppt@kernel.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<osandov@fb.com>, <ryan.roberts@arm.com>, <cfsworks@gmail.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <thuth@redhat.com>,
	<hbathini@linux.ibm.com>, <eajames@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <dwmw@amazon.co.uk>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kai.huang@intel.com>, <ubizjak@gmail.com>,
	<coxu@redhat.com>, <liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>,
	<brgerst@gmail.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
References: <20260209095931.2813152-1-ruanjinjie@huawei.com>
 <20260209095931.2813152-2-ruanjinjie@huawei.com>
 <50693f0c-c610-4347-86aa-40d50dc681fc@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <50693f0c-c610-4347-86aa-40d50dc681fc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/2/10 20:30, Sourabh Jain wrote:
> Hello Jinjie,
> 
> On 09/02/26 15:29, Jinjie Ruan wrote:
>> The exclude of crashk_res, crashk_low_res and crashk_cma memory
>> are almost identical across different architectures, handling them
>> in the crash core would eliminate a lot of duplication, so do
>> them in the common code.
>>
>> And move the size calculation (and the realloc if needed) into the
>> generic crash core so that:
>>
>> - New CMA regions or future crash-memory types can automatically
>>    accounted for in crash core;
>>
>> - Each architecture no longer has to play whack-a-mole with
>>    its private array size.
>>
>> To achieve the above goal, 4 architecture-specific functions are
>> introduced:
>>
>> - arch_get_system_nr_ranges() and arch_prepare_elf64_ram_headers().
>>    The 1st function pre-counts the number of memory ranges, and
>>    the 2st function fill the memory ranges into the cmem->ranges[] array,
>>    and count the actual number of ranges filled. The default
>> implementation
>>    is consistent with arm64 and loongson.
>>
>> - arch_crash_exclude_mem_range(). Realloc for powerpc. The default
>>    implementation is crash_exclude_mem_range(), and use
>>    crash_exclude_mem_range_guarded() to implement the arch version
>>    for powerpc.
>>
>> - arch_get_crash_memory_ranges(). Get crash memory ranges for arch and
>>    the default implementation is generic across x86, arm64, riscv, and
>>    loongson by using the first two arch functions above. powerpc has its
>>    own implementation by calling get_crash_memory_ranges().
>>
>> Tested on x86, arm64 and riscv with QEMU.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/arm64/kernel/machine_kexec_file.c     |  47 +--------
>>   arch/loongarch/kernel/machine_kexec_file.c |  45 +-------
>>   arch/powerpc/include/asm/kexec.h           |  13 +++
>>   arch/powerpc/kexec/crash.c                 |  52 ++++++----
>>   arch/powerpc/kexec/file_load_64.c          |  17 ++-
>>   arch/powerpc/kexec/ranges.c                |  18 +---
>>   arch/riscv/include/asm/kexec.h             |  10 ++
>>   arch/riscv/kernel/machine_kexec_file.c     |  37 ++-----
>>   arch/x86/include/asm/kexec.h               |  10 ++
>>   arch/x86/kernel/crash.c                    | 104 ++-----------------
>>   include/linux/crash_core.h                 | 114 +++++++++++++++++++--
>>   kernel/crash_core.c                        |  71 +++++++++++--
>>   12 files changed, 269 insertions(+), 269 deletions(-)
>>

[...]

>>   extern void crash_ipi_callback(struct pt_regs *regs);
>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>> index a325c1c02f96..5ade9a853fb0 100644
>> --- a/arch/powerpc/kexec/crash.c
>> +++ b/arch/powerpc/kexec/crash.c
>> @@ -419,30 +419,21 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>       return sizeof(struct elfhdr) + (phdr_cnt * sizeof(Elf64_Phdr));
>>   }
>>   -/**
>> - * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it
>> with old
>> - *                   elfcorehdr in the kexec segment array.
>> - * @image: the active struct kimage
>> - * @mn: struct memory_notify data handler
>> - */
>> -static void update_crash_elfcorehdr(struct kimage *image, struct
>> memory_notify *mn)
>> +int arch_get_crash_memory_ranges(struct crash_mem **cmem, unsigned
>> long *nr_mem_ranges,
>> +                 struct kimage *image, struct memory_notify *mn)
>>   {
>> +    unsigned long base_addr, size;
>>       int ret;
>> -    struct crash_mem *cmem = NULL;
>> -    struct kexec_segment *ksegment;
>> -    void *ptr, *mem, *elfbuf = NULL;
>> -    unsigned long elfsz, memsz, base_addr, size;
>>   -    ksegment = &image->segment[image->elfcorehdr_index];
>> -    mem = (void *) ksegment->mem;
>> -    memsz = ksegment->memsz;
>> -
>> -    ret = get_crash_memory_ranges(&cmem);
>> +    ret = get_crash_memory_ranges(cmem);
>>       if (ret) {
>>           pr_err("Failed to get crash mem range\n");
>> -        return;
>> +        return ret;
>>       }
>>   +    if (!image || !mn)
>> +        return 0;
>> +
>>       /*
>>        * The hot unplugged memory is part of crash memory ranges,
>>        * remove it here.
>> @@ -450,14 +441,34 @@ static void update_crash_elfcorehdr(struct
>> kimage *image, struct memory_notify *
>>       if (image->hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY) {
>>           base_addr = PFN_PHYS(mn->start_pfn);
>>           size = mn->nr_pages * PAGE_SIZE;
>> -        ret = remove_mem_range(&cmem, base_addr, size);
>> +        ret = remove_mem_range(cmem, base_addr, size);
> 
> I like the overall design for handling crashkernel memory exclusion
> in this patch series, especially the way you managed to free the
> crash_mem object (mem) in the generic code (crash_prepare_elf64_headers()).

Thanks for the review.

> 
> However, the way crash memory is prepared after a memory hotplug
> event on powerpc by calling remove_mem_range(), can leave the crash
> memory ranges unsorted. This can cause issues in the generic code
> when excluding crashkernel memory, because crash_exclude_mem_range()
> expects crash_mem to be sorted.

You are absolutely correct.

> 
> So I wrote a simple patch to cover this scenario. Including the
> patch below as the first patch in this series would be helpful.
> https://lore.kernel.org/all/20260210120803.433978-1-sourabhjain@linux.ibm.com/

Thanks for the additional patch. I'll add it as the first patch in the
next revision to ensure crash_mem remains sorted after memory hotplug
events on powerpc.

Best regards,
Jinjie

> 
> Jinjie, will it be possible for you to include the above patch in this
> patch series?

My pleasure.

>>           if (ret) {
>>               pr_err("Failed to remove hot-unplugged memory from crash
>> memory ranges\n");
>> -            goto out;
>> +            return ret;
>>           }
>>       }
>>   -    ret = crash_prepare_elf64_headers(cmem, false, &elfbuf, &elfsz);
>> +    return 0;
>> +}
>> +
>> +/**
>> + * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it
>> with old
>> + *                   elfcorehdr in the kexec segment array.
>> + * @image: the active struct kimage
>> + * @mn: struct memory_notify data handler
>> + */
>> +static void update_crash_elfcorehdr(struct kimage *image, struct
>> memory_notify *mn)
>> +{
>> +    void *ptr, *mem, *elfbuf = NULL;
>> +    struct kexec_segment *ksegment;
>> +    unsigned long elfsz, memsz;
>> +    int ret;
>> +
>> +    ksegment = &image->segment[image->elfcorehdr_index];
>> +    mem = (void *) ksegment->mem;
>> +    memsz = ksegment->memsz;
>> +
>> +    ret = crash_prepare_elf64_headers(false, &elfbuf, &elfsz, NULL,
>> image, mn);
>>       if (ret) {
>>           pr_err("Failed to prepare elf header\n");
>>           goto out;
>> @@ -486,7 +497,6 @@ static void update_crash_elfcorehdr(struct kimage
>> *image, struct memory_notify *
>>           xchg(&kexec_crash_image, image);
>>       }
>>   out:
>> -    kvfree(cmem);
>>       kvfree(elfbuf);
>>   }

[...]

>> +int crash_prepare_elf64_headers(int need_kernel_map, void **addr,
>> +                unsigned long *sz, unsigned long *nr_mem_ranges,
>> +                struct kimage *image, struct memory_notify *mn)
>>   {
>> -    Elf64_Ehdr *ehdr;
>> -    Elf64_Phdr *phdr;
>>       unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
>> -    unsigned char *buf;
>> -    unsigned int cpu, i;
>>       unsigned long long notes_addr;
>> +    struct crash_mem *mem = NULL;
>>       unsigned long mstart, mend;
>> +    unsigned int cpu, i;
>> +    unsigned char *buf;
>> +    Elf64_Ehdr *ehdr;
>> +    Elf64_Phdr *phdr;
>> +    int ret = 0;
>> +
>> +    ret = arch_get_crash_memory_ranges(&mem, nr_mem_ranges, image, mn);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (mem) {
>> +        ret = crash_exclude_mem_ranges(mem, nr_mem_ranges);
>> +        if (ret)
>> +            goto out;
>> +    }
>>         /* extra phdr for vmcoreinfo ELF note */
>>       nr_phdr = nr_cpus + 1;
>> @@ -192,8 +240,10 @@ int crash_prepare_elf64_headers(struct crash_mem
>> *mem, int need_kernel_map,
>>       elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>>         buf = vzalloc(elf_sz);
>> -    if (!buf)
>> -        return -ENOMEM;
>> +    if (!buf) {
>> +        ret = -ENOMEM;
>> +        goto out;
>> +    }
>>         ehdr = (Elf64_Ehdr *)buf;
>>       phdr = (Elf64_Phdr *)(ehdr + 1);
>> @@ -262,7 +312,10 @@ int crash_prepare_elf64_headers(struct crash_mem
>> *mem, int need_kernel_map,
>>         *addr = buf;
>>       *sz = elf_sz;
>> -    return 0;
>> +
>> +out:
>> +    kvfree(mem);
>> +    return ret;
>>   }
>>     /**
> 

