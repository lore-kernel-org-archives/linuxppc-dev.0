Return-Path: <linuxppc-dev+bounces-18612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCC7EC01A6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 09:13:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffSBb269Zz2ySc;
	Mon, 23 Mar 2026 20:13:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774257191;
	cv=none; b=hf6nHc6kK7yi7Kd6DVOxEak4bDoocy++b0sHBnEBtBfeDZEXneTZZFRnmyNucPs2batrfW1SyO3tUh4IJODkLEUAsTmI76pY7zJ8GiUS+C2xz23VKu9oSQm9XpiRhXygRsA8OPwPWbp0NB5EAcQHWnhBhFH9h+kZ2N/vsVAzjq3Jzcq5AIcNg0LzL4bGDDV73S++Ny7IMhW8iFIhYiItafStLtJKIF1uCOMT25zhsJ7be71pBvKEBBpheAZZLIH722FtVkLgJd8vrSWVv2FA4YTJrHIA7hB0ANrXxXsm+eDZXw0JA8K/TByqyZDjaZzVBjIs08MdoBMJvmANZOK5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774257191; c=relaxed/relaxed;
	bh=5R+7uXg3U7nlHkG89RoCblEJHYs9b0WeFIPTVRWLVQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JZUzNDNt7Slyi324ySd5eNfca4F5BoMWGD01+EwRhOZPn+4Y1+rr6ujzr7EV7unO5DYpt2vO7Jt16jAtGjAQgLiZRycdIY8xSEqfTTmGw3wZJOM79UOEmUrsZDVNL1shZADu/ED/5zEDC3ugJKihy5kFTK7UfW7o1HVdxG3PCoz8qMmAnJUxYykQyT4C9fzRVdEURQTVoUYSNvXAg6pIya+BR6mMnLHJw+HdzNzBWFRg4aGTisjoSD1xfF/i9g2uUITZy8dcXZN1dBciopg/7zcp//eBBWHZLtgmSNbuo08X+h5oyjt0bjZvJtLMOot7A+296Nms4XtrS26bYHNg7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Y+yWuUGN; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Y+yWuUGN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffSBX1hSXz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 20:13:05 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5R+7uXg3U7nlHkG89RoCblEJHYs9b0WeFIPTVRWLVQc=;
	b=Y+yWuUGNkhnMbElcTb6cK5zvior1en8dufiWg3gOR4G0cdsY9NSjL01IfgjvzT/1PThHnT1DO
	N0IN0CeozivqgvpXCGTPZNojc7P8FGVtCWN/YKZxEPIgaj88sEMngL51hbLGH6/RRO7Y3qheP2P
	O0zECl9CpDS39fu7NA5GQFU=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ffS426mBSznTVB;
	Mon, 23 Mar 2026 17:07:30 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B6C944056C;
	Mon, 23 Mar 2026 17:12:59 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Mar 2026 17:12:57 +0800
Message-ID: <55d9ff80-fffc-8889-1c87-5acd6de22d47@huawei.com>
Date: Mon, 23 Mar 2026 17:12:50 +0800
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
Subject: Re: [PATCH v8 2/5] crash: Exclude crash kernel memory in crash core
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <paulmck@kernel.org>,
	<lirongqing@baidu.com>, <fvdl@google.com>, <rppt@kernel.org>,
	<ardb@kernel.org>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
	<jbohac@suse.cz>, <cfsworks@gmail.com>, <osandov@fb.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <hbathini@linux.ibm.com>,
	<eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<kevin.brodsky@arm.com>, <samuel.holland@sifive.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>, <brgerst@gmail.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
 <20260302035315.3892241-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260302035315.3892241-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/2 11:53, Jinjie Ruan wrote:
> The crash memory alloc, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> handling them in the crash core would eliminate a lot of duplication, so
> do them in the common code.
> 
> To achieve the above goal, three architecture-specific functions are
> introduced:
> 
> - arch_get_system_nr_ranges(). Pre-counts the max number of memory ranges.
> 
> - arch_crash_populate_cmem(). Collects the memory ranges and fills them
>   into cmem.
> 
> - arch_crash_exclude_ranges(). Architecture's additional crash memory
>   ranges exclusion, defaulting to empty.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c     | 39 +++-------
>  arch/loongarch/kernel/machine_kexec_file.c | 39 +++-------
>  arch/riscv/kernel/machine_kexec_file.c     | 38 +++------
>  arch/x86/kernel/crash.c                    | 89 +++-------------------
>  include/linux/crash_core.h                 |  5 ++
>  kernel/crash_core.c                        | 82 +++++++++++++++++++-
>  6 files changed, 132 insertions(+), 160 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index fba260ad87a9..c338506a580b 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -40,23 +40,23 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_CRASH_DUMP
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +unsigned int arch_get_system_nr_ranges(void)
>  {
> -	struct crash_mem *cmem;
> -	unsigned int nr_ranges;
> -	int ret;
> -	u64 i;
> +	unsigned int nr_ranges = 2; /* for exclusion of crashkernel region */
>  	phys_addr_t start, end;
> +	u64 i;
>  
> -	nr_ranges = 2; /* for exclusion of crashkernel region */
>  	for_each_mem_range(i, &start, &end)
>  		nr_ranges++;
>  
> -	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
> -	if (!cmem)
> -		return -ENOMEM;
> +	return nr_ranges;
> +}
> +
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
> +{
> +	phys_addr_t start, end;
> +	u64 i;
>  
> -	cmem->max_nr_ranges = nr_ranges;
>  	cmem->nr_ranges = 0;
>  	for_each_mem_range(i, &start, &end) {
>  		cmem->ranges[cmem->nr_ranges].start = start;
> @@ -64,22 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  		cmem->nr_ranges++;
>  	}
>  
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		goto out;
> -
> -	if (crashk_low_res.end) {
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> -
> -out:
> -	kfree(cmem);
> -	return ret;
> +	return 0;
>  }
>  #endif
>  
> @@ -109,7 +94,7 @@ int load_other_segments(struct kimage *image,
>  	void *headers;
>  	unsigned long headers_sz;
>  	if (image->type == KEXEC_TYPE_CRASH) {
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
>  		if (ret) {
>  			pr_err("Preparing elf core header failed\n");
>  			goto out_err;
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index 5584b798ba46..4b318a94b564 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -56,23 +56,23 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
>  }
>  
>  #ifdef CONFIG_CRASH_DUMP
> -
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +unsigned int arch_get_system_nr_ranges(void)
>  {
> -	int ret, nr_ranges;
> -	uint64_t i;
> +	int nr_ranges = 2; /* for exclusion of crashkernel region */
>  	phys_addr_t start, end;
> -	struct crash_mem *cmem;
> +	uint64_t i;
>  
> -	nr_ranges = 2; /* for exclusion of crashkernel region */
>  	for_each_mem_range(i, &start, &end)
>  		nr_ranges++;
>  
> -	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
> -	if (!cmem)
> -		return -ENOMEM;
> +	return nr_ranges;
> +}
> +
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
> +{
> +	phys_addr_t start, end;
> +	uint64_t i;
>  
> -	cmem->max_nr_ranges = nr_ranges;
>  	cmem->nr_ranges = 0;
>  	for_each_mem_range(i, &start, &end) {
>  		cmem->ranges[cmem->nr_ranges].start = start;
> @@ -80,22 +80,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  		cmem->nr_ranges++;
>  	}
>  
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret < 0)
> -		goto out;
> -
> -	if (crashk_low_res.end) {
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> -		if (ret < 0)
> -			goto out;
> -	}
> -
> -	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> -
> -out:
> -	kfree(cmem);
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> @@ -163,7 +148,7 @@ int load_other_segments(struct kimage *image,
>  		void *headers;
>  		unsigned long headers_sz;
>  
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
>  		if (ret < 0) {
>  			pr_err("Preparing elf core header failed\n");
>  			goto out_err;
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index 54e2d9552e93..d0e331d87155 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -44,6 +44,15 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>  	return 0;
>  }
>  
> +unsigned int arch_get_system_nr_ranges(void)
> +{
> +	unsigned int nr_ranges = 1; /* For exclusion of crashkernel region */
> +
> +	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +
> +	return nr_ranges;
> +}
> +
>  static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  {
>  	struct crash_mem *cmem = arg;
> @@ -55,33 +64,10 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  	return 0;
>  }
>  
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	struct crash_mem *cmem;
> -	unsigned int nr_ranges;
> -	int ret;
> -
> -	nr_ranges = 1; /* For exclusion of crashkernel region */
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> -
> -	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
> -	if (!cmem)
> -		return -ENOMEM;
> -
> -	cmem->max_nr_ranges = nr_ranges;
>  	cmem->nr_ranges = 0;
> -	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -	if (ret)
> -		goto out;

Hi, Baoquan

While using AI tools to assist in the review, I noticed the following
issues in the RISC-V implementation:

riscv supports crashk_low_res in commit 5882e5acf18d ("riscv: kdump:
Implement crashkernel=X,[high,low]"),  so it should have excluded the
"crashk_low_res" reserved ranges from the crash kernel memory to prevent
them from being exported through /proc/vmcore, and the exclusion would
need an extra crash_mem range as below.

Should I include a fix for this in this patch set?

--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -61,7 +61,7 @@ static int prepare_elf_headers(void **addr, unsigned
long *sz)
        unsigned int nr_ranges;
        int ret;

-       nr_ranges = 1; /* For exclusion of crashkernel region */
+       nr_ranges = 2; /* For exclusion of crashkernel region */
        walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);

        cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
@@ -76,8 +76,16 @@ static int prepare_elf_headers(void **addr, unsigned
long *sz)

        /* Exclude crashkernel region */
        ret = crash_exclude_mem_range(cmem, crashk_res.start,
crashk_res.end);
-       if (!ret)
-               ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+       if (ret)
+               goto out;
+
+       if (crashk_low_res.end) {
+               ret = crash_exclude_mem_range(cmem,
crashk_low_res.start, crashk_low_res.end);
+               if (ret)
+                       goto out;
+       }
+
+       ret = crash_prepare_elf64_headers(cmem, true, addr, sz);

 out:
        kfree(cmem);



> -
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (!ret)
> -		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> -
> -out:
> -	kfree(cmem);
> -	return ret;
> +	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
>  }
>  
>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
> @@ -273,7 +259,7 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
>  	if (image->type == KEXEC_TYPE_CRASH) {
>  		void *headers;
>  		unsigned long headers_sz;
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
>  		if (ret) {
>  			pr_err("Preparing elf core header failed\n");
>  			goto out;
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 335fd2ee9766..3ad3f8b758a4 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -152,16 +152,8 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>  	return 0;
>  }
>  
> -/* Gather all the required information to prepare elf headers for ram regions */
> -static struct crash_mem *fill_up_crash_elf_data(void)
> +unsigned int arch_get_system_nr_ranges(void)
>  {
> -	unsigned int nr_ranges = 0;
> -	struct crash_mem *cmem;
> -
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> -	if (!nr_ranges)
> -		return NULL;
> -
>  	/*
>  	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
>  	 * may cause range splits. So add extra slots here.
> @@ -176,49 +168,16 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>  	 * But in order to lest the low 1M could be changed in the future,
>  	 * (e.g. [start, 1M]), add a extra slot.
>  	 */
> -	nr_ranges += 3 + crashk_cma_cnt;
> -	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
> -	if (!cmem)
> -		return NULL;
> -
> -	cmem->max_nr_ranges = nr_ranges;
> +	unsigned int nr_ranges = 3 + crashk_cma_cnt;
>  
> -	return cmem;
> +	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +	return nr_ranges;
>  }
>  
> -/*
> - * Look for any unwanted ranges between mstart, mend and remove them. This
> - * might lead to split and split ranges are put in cmem->ranges[] array
> - */
> -static int elf_header_exclude_ranges(struct crash_mem *cmem)
> +int arch_crash_exclude_ranges(struct crash_mem *cmem)
>  {
> -	int ret = 0;
> -	int i;
> -
>  	/* Exclude the low 1M because it is always reserved */
> -	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
> -	if (ret)
> -		return ret;
> -
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		return ret;
> -
> -	if (crashk_low_res.end)
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
> -					      crashk_low_res.end);
> -	if (ret)
> -		return ret;
> -
> -	for (i = 0; i < crashk_cma_cnt; ++i) {
> -		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
> -					      crashk_cma_ranges[i].end);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> +	return crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
>  }
>  
>  static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> @@ -232,35 +191,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  	return 0;
>  }
>  
> -/* Prepare elf headers. Return addr and size */
> -static int prepare_elf_headers(void **addr, unsigned long *sz,
> -			       unsigned long *nr_mem_ranges)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	struct crash_mem *cmem;
> -	int ret;
> -
> -	cmem = fill_up_crash_elf_data();
> -	if (!cmem)
> -		return -ENOMEM;
> -
> -	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -	if (ret)
> -		goto out;
> -
> -	/* Exclude unwanted mem ranges */
> -	ret = elf_header_exclude_ranges(cmem);
> -	if (ret)
> -		goto out;
> -
> -	/* Return the computed number of memory ranges, for hotplug usage */
> -	*nr_mem_ranges = cmem->nr_ranges;
> -
> -	/* By default prepare 64bit headers */
> -	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> -
> -out:
> -	vfree(cmem);
> -	return ret;
> +	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
>  }
>  #endif
>  
> @@ -418,7 +351,8 @@ int crash_load_segments(struct kimage *image)
>  				  .buf_max = ULONG_MAX, .top_down = false };
>  
>  	/* Prepare elf headers and add a segment */
> -	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
> +	ret = crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
> +				    &kbuf.bufsz, &pnum);
>  	if (ret)
>  		return ret;
>  
> @@ -529,7 +463,8 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>  	 * memory resources.
>  	 */
> -	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
> +	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz,
> +				  &nr_mem_ranges)) {
>  		pr_err("unable to create new elfcorehdr");
>  		goto out;
>  	}
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index d35726d6a415..033b20204aca 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -66,6 +66,8 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mend);
>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  				       void **addr, unsigned long *sz);
> +extern int crash_prepare_headers(int need_kernel_map, void **addr,
> +				 unsigned long *sz, unsigned long *nr_mem_ranges);
>  
>  struct kimage;
>  struct kexec_segment;
> @@ -83,6 +85,9 @@ int kexec_should_crash(struct task_struct *p);
>  int kexec_crash_loaded(void);
>  void crash_save_cpu(struct pt_regs *regs, int cpu);
>  extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
> +extern unsigned int arch_get_system_nr_ranges(void);
> +extern int arch_crash_populate_cmem(struct crash_mem *cmem);
> +extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
>  
>  #else /* !CONFIG_CRASH_DUMP*/
>  struct pt_regs;
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2c1a3791e410..96a96e511f5a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -170,9 +170,6 @@ static inline resource_size_t crash_resource_size(const struct resource *res)
>  	return !res->end ? 0 : resource_size(res);
>  }
>  
> -
> -
> -
>  int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  			  void **addr, unsigned long *sz)
>  {
> @@ -274,6 +271,85 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  	return 0;
>  }
>  
> +static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
> +{
> +	struct crash_mem *cmem;
> +
> +	cmem = kvzalloc_flex(*cmem, ranges, nr_ranges);
> +	if (!cmem)
> +		return NULL;
> +
> +	cmem->max_nr_ranges = nr_ranges;
> +	return cmem;
> +}
> +
> +unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
> +int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
> +int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
> +
> +static int crash_exclude_core_ranges(struct crash_mem *cmem)
> +{
> +	int ret, i;
> +
> +	/* Exclude crashkernel region */
> +	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		return ret;
> +
> +	if (crashk_low_res.end) {
> +		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < crashk_cma_cnt; ++i) {
> +		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
> +					      crashk_cma_ranges[i].end);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
> +			  unsigned long *nr_mem_ranges)
> +{
> +	unsigned int max_nr_ranges;
> +	struct crash_mem *cmem;
> +	int ret;
> +
> +	max_nr_ranges = arch_get_system_nr_ranges();
> +	if (!max_nr_ranges)
> +		return -ENOMEM;
> +
> +	cmem = alloc_cmem(max_nr_ranges);
> +	if (!cmem)
> +		return -ENOMEM;
> +
> +	ret = arch_crash_populate_cmem(cmem);
> +	if (ret)
> +		goto out;
> +
> +	ret = crash_exclude_core_ranges(cmem);
> +	if (ret)
> +		goto out;
> +
> +	ret = arch_crash_exclude_ranges(cmem);
> +	if (ret)
> +		goto out;
> +
> +	/* Return the computed number of memory ranges, for hotplug usage */
> +	if (nr_mem_ranges)
> +		*nr_mem_ranges = cmem->nr_ranges;
> +
> +	ret = crash_prepare_elf64_headers(cmem, need_kernel_map, addr, sz);
> +
> +out:
> +	kvfree(cmem);
> +	return ret;
> +}
> +
>  /**
>   * crash_exclude_mem_range - exclude a mem range for existing ranges
>   * @mem: mem->range contains an array of ranges sorted in ascending order

