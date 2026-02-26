Return-Path: <linuxppc-dev+bounces-17220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D618FD460C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 03:25:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLxfg55N2z2yvy;
	Thu, 26 Feb 2026 14:25:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772076315;
	cv=none; b=m+JCO78K2Sn9b9tXiu3hVaWqHFPVp1uwKAFmnNKBhL2tLqin5qpUFkOm6/PDNVYf56xac7GpvbQEJWr4vioMNv1LicZiWUN4XwVDFmQ4ncFiZUVL/Wh+wPyXVoPB2t/U0hmipeLYXM3WcSbRkPwOD5KiYXCAWBJOolr4AyeZg1J3huu52W0YOiKfjporm9DupfQbmg2GfHhatzsDVA9aCXc2FmCyz5rmzXP++uDim6VlYQ0FAZ4L8Y00r/WGJxmIQRM7gmMEO8ws5TH2Y7ao/BfI+2k0wonBhECm3uVMIegJ4WxugdxJYz0+cI3+h1LK1oigU2eaoNpyK/VSdOa2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772076315; c=relaxed/relaxed;
	bh=X/tw47XVxnBSBQVQnzbdQeBRFqR3Av4K63nH/lDW8AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ng6vNIx9Ny26mmAzBGBtUAqTwIuDJXSeJZlWDzHxmum63faIU+ux7ff5PLc5QTOLp3nQi6mu1vYuIUGbTQu5deIfc79QElrTHiYDKqqwyxbIllTgvD7Um8NpcZsgkRIUOLtC1nDNRC4d/ouFgaSErl/u8wr1Bw/asgLexiY4BeI9bKeUfglB7oLpU3koJhbb45gp8+U7A4p2A+SDHzhJSue765V5NWY/OI8ABfsVjMHpiNhY5/5/E1s3VdKDozZL5slPY9Y4matLVqafw50eOTGn7sy/ehQNwcDME24nomVC9L/X8NwhauzCQy4pSY08ZLYGnua+IFpN7d7eA5xsPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=x1l2VLMm; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=x1l2VLMm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLxfT4cXBz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 14:25:04 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=X/tw47XVxnBSBQVQnzbdQeBRFqR3Av4K63nH/lDW8AE=;
	b=x1l2VLMmjYlYgtz9e9QHe2mOtGBgkKNh7hz5MB9XCgwIHUNdvwywy/MiST1AdgYMZ8Zyzmb27
	xiMAI8GTBB37K4MPa+6n43+ne+oVZQwZt5AaCiT8i/cHG9pw7k06FxwueZqr+OCknXS8TuOpk3e
	TFufapm/JkqBD70EL8N9gQs=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fLxXn5h2NznTW8;
	Thu, 26 Feb 2026 11:20:09 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E70340561;
	Thu, 26 Feb 2026 11:24:50 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 11:24:46 +0800
Message-ID: <0b0c0a34-f67d-9cf5-d5fc-ed8e1870a104@huawei.com>
Date: Thu, 26 Feb 2026 11:24:45 +0800
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
Subject: Re: [PATCH v6 4/5] arm64: kexec: Add support for crashkernel CMA
 reservation
To: Mike Rapoport <rppt@kernel.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <dapeng1.mi@linux.intel.com>, <kees@kernel.org>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <arnd@arndb.de>,
	<ardb@kernel.org>, <leitao@debian.org>, <cfsworks@gmail.com>,
	<ryan.roberts@arm.com>, <sourabhjain@linux.ibm.com>,
	<tangyouling@kylinos.cn>, <eajames@linux.ibm.com>, <hbathini@linux.ibm.com>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>,
	<samuel.holland@sifive.com>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>, <jbohac@suse.cz>,
	<brgerst@gmail.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
References: <20260224085342.387996-1-ruanjinjie@huawei.com>
 <20260224085342.387996-5-ruanjinjie@huawei.com> <aZ8Z2WXw3QwaXRo8@kernel.org>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aZ8Z2WXw3QwaXRo8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/2/25 23:48, Mike Rapoport wrote:
> On Tue, Feb 24, 2026 at 04:53:41PM +0800, Jinjie Ruan wrote:
>> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
>> crashkernel= command line option") and commit ab475510e042 ("kdump:
>> implement reserve_crashkernel_cma") added CMA support for kdump
>> crashkernel reservation.
>>
>> Crash kernel memory reservation wastes production resources if too
>> large, risks kdump failure if too small, and faces allocation difficulties
>> on fragmented systems due to contiguous block constraints. The new
>> CMA-based crashkernel reservation scheme splits the "large fixed
>> reservation" into a "small fixed region + large CMA dynamic region": the
>> CMA memory is available to userspace during normal operation to avoid
>> waste, and is reclaimed for kdump upon crash—saving memory while
>> improving reliability.
>>
>> So extend crashkernel CMA reservation support to arm64. The following
>> changes are made to enable CMA reservation:
>>
>> - Parse and obtain the CMA reservation size along with other crashkernel
>>   parameters.
>> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
>> - Include the CMA-reserved ranges for kdump kernel to use.
>> - Exclude the CMA-reserved ranges from the crash kernel memory to
>>   prevent them from being exported through /proc/vmcore, which is already
>>   done in the crash core.
>>
>> Update kernel-parameters.txt to document CMA support for crashkernel on
>> arm64 architecture.
>>
>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v3:
>> - Add Acked-by.
>> v2:
>> - Free cmem in prepare_elf_headers()
>> - Add the mtivation.
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>>  arch/arm64/kernel/machine_kexec_file.c          | 8 +++++++-
>>  arch/arm64/mm/init.c                            | 5 +++--
>>  3 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index cb850e5290c2..497f63b76898 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1121,7 +1121,7 @@ Kernel parameters
>>  			It will be ignored when crashkernel=X,high is not used
>>  			or memory reserved is below 4G.
>>  	crashkernel=size[KMG],cma
>> -			[KNL, X86, ppc] Reserve additional crash kernel memory from
>> +			[KNL, X86, ARM64, ppc] Reserve additional crash kernel memory from
>>  			CMA. This reservation is usable by the first system's
>>  			userspace memory and kernel movable allocations (memory
>>  			balloon, zswap). Pages allocated from this memory range
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index c338506a580b..c8862a762eb3 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -42,7 +42,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>  #ifdef CONFIG_CRASH_DUMP
>>  unsigned int arch_get_system_nr_ranges(void)
>>  {
>> -	unsigned int nr_ranges = 2; /* for exclusion of crashkernel region */
>> +	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
>>  	phys_addr_t start, end;
>>  	u64 i;
>>  
>> @@ -64,6 +64,12 @@ int arch_crash_populate_cmem(struct crash_mem *cmem)
>>  		cmem->nr_ranges++;
>>  	}
>>  
>> +	for (i = 0; i < crashk_cma_cnt; i++) {
>> +		cmem->ranges[cmem->nr_ranges].start = crashk_cma_ranges[i].start;
>> +		cmem->ranges[cmem->nr_ranges].end = crashk_cma_ranges[i].end;
>> +		cmem->nr_ranges++;
>> +	}
> 
> Why do we need to add cma ranges here? They are anyway will be excluded in
> crash_exclude_core_ranges().
> 
> The same comment applies to riscv patch.

Indeed, it should not be placed here. In the kexec DT code, these memory
regions need to be included in the "usable-memory-range",which is
equivalent to the x86 crash_setup_memmap_entries() function.

> 
>>  	return 0;
>>  }
>>  #endif
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 96711b8578fd..144e30fe9a75 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -96,8 +96,8 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>>  
>>  static void __init arch_reserve_crashkernel(void)
>>  {
>> +	unsigned long long crash_base, crash_size, cma_size = 0;
>>  	unsigned long long low_size = 0;
>> -	unsigned long long crash_base, crash_size;
>>  	bool high = false;
>>  	int ret;
>>  
>> @@ -106,11 +106,12 @@ static void __init arch_reserve_crashkernel(void)
>>  
>>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>>  				&crash_size, &crash_base,
>> -				&low_size, NULL, &high);
>> +				&low_size, &cma_size, &high);
>>  	if (ret)
>>  		return;
>>  
>>  	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
>> +	reserve_crashkernel_cma(cma_size);
>>  }
>>  
>>  static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>> -- 
>> 2.34.1
>>
> 

