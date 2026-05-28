Return-Path: <linuxppc-dev+bounces-21619-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57833CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 07:38:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQyzG4fGGz2xJT;
	Thu, 28 May 2026 17:38:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779953930;
	cv=none; b=nKONdTkPiJDhVPSJO6sXT1trc3y8JJ6lOfTxF3ygfJd0WRPKsbCqPQIxFHnWFgZr/tdXuuKsoQflSPXnr+EpBUNfs3IjR/ndWrQY0z01j9FahY+6Zvcf4qV96viWfQIrwzJ9wjsy0pjSxDZ06XTfdOYRVQx2e0ir+cYqAO3oJ2S1jYtAHOPu8chdFM/A0H5pPjEQ9G7Y5BTbar0HA3+W7aHaciZ3nQxgqimL9y9FmS4fyTL9pg2lTXMF2nHGm6WPT8KNlabIMxAgZPoJU1GEdGIkTJYE5n7Vn9pSfWLeNJ0x8MVqfxiJoZQZyGOH7b9lWZqp/FhVbp2JA6YM7lX70A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779953930; c=relaxed/relaxed;
	bh=kcfmxoAhvHW1ZhGDwtgqi/DjUNMSbaPMdIrHdQsNguc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HT+SBaxyLk6b5Qk8KyIrB4Gng+Dta7TqKRdY0go0SczlLyxER0GPyOSzKfsYNF+Xd0ofkowOyOIjv+4SaIo2djQEMrkl/oXxmUByvUUujbEylez8ouUzrDqCDHLExjfKzy0bhnhDju9Q4LTPoSDXJVIuJFo4aHDbV1xs9RRUsOCBHW8m+/+HMkblZypAa+t+IJD/xgu7Av+l3tb3JzavsVGL0YDPWj8jzar3crAzqQDLd8D5eMA1QJAAjXXx3EutkECAP+72xxtfL2zKX8B4Ubavba1OJcvva8QSHg/nJpgRCBEAb3x9cpYohmtbZk1ui0smywpO+QBCMBM0m5ovRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=f8XC3yJN; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=f8XC3yJN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQyzB6GRHz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 17:38:44 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kcfmxoAhvHW1ZhGDwtgqi/DjUNMSbaPMdIrHdQsNguc=;
	b=f8XC3yJNgC87Lps2UOgSUA93oWaCi71/L5C74Qtkh2xvvB9/wWmNmoUIUb5UVMXIubbWL8933
	e8h8uZrHE9vRx70zyh+l2grmIqGnOBqJvoqoULa9vBWTYvnrKPHZkSsRAH2oTuA7Ix9baO7kUuW
	toKQ8NrVfgquDl51K9J1RjY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gQyp223cczKm5b;
	Thu, 28 May 2026 15:30:50 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E7CD840539;
	Thu, 28 May 2026 15:38:38 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 15:38:33 +0800
Message-ID: <7ddab21c-bdb2-4a43-87fa-198b26d82f20@huawei.com>
Date: Thu, 28 May 2026 15:38:31 +0800
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
Subject: Re: [PATCH v14 00/17] arm64/riscv: Add support for crashkernel CMA
 reservation
To: Huacai Chen <chenhuacai@kernel.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<lirongqing@baidu.com>, <ebiggers@kernel.org>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <ardb@kernel.org>, <masahiroy@kernel.org>,
	<mark.rutland@arm.com>, <maz@kernel.org>, <james.morse@arm.com>,
	<leitao@debian.org>, <sourabhjain@linux.ibm.com>, <yeoreum.yun@arm.com>,
	<coxu@redhat.com>, <jbohac@suse.cz>, <ryan.roberts@arm.com>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<songshuaishuai@tinylab.org>, <junhui.liu@pigmoral.tech>,
	<vishal.moola@gmail.com>, <kas@kernel.org>, <debug@rivosinc.com>,
	<namcao@linutronix.de>, <liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>,
	<seanjc@google.com>, <guoren@kernel.org>, <chenjiahao16@huawei.com>,
	<hbathini@linux.ibm.com>, <bgwin@google.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
 <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 5/25/2026 6:14 PM, Huacai Chen wrote:
> Hi, Jinjie,
> 
> On Mon, May 25, 2026 at 4:50 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
>> and crashk_cma memory are almost identical across different architectures,
>> This patch set handle them in crash core in a general way, which eliminate
>> a lot of duplication code.
>>
>> And add support for crashkernel CMA reservation for arm64 and riscv.
>>
>> Also add support for arm64 crash hotplug.
>>
>> This patch set is rebased on v7.1-rc1.
>>
>> Basic second kernel boot test were performed on QEMU platforms for x86,
>> ARM64 and RISC-V architectures with the following parameters:
>>
>>         "cma=256M crashkernel=4G crashkernel=64M,cma"
>>
>> For first kernel, there will be such log:
>>
>>         # dmesg | grep crash
>>         [    0.000000] crashkernel low memory reserved: 0xe8000000 - 0xf0000000 (128 MB)
>>         [    0.000000] crashkernel reserved: 0x000000023e600000 - 0x000000033e600000 (4096 MB)
>>         [    0.000000] crashkernel CMA reserved: 64 MB in 1 ranges
>>
>>         # dmesg | grep cma
>>         [    0.000000] cma: Reserved 256 MiB at 0x00000000f0000000
>>         [    0.000000] cma: Reserved 64 MiB at 0x0000000100000000
>>
>> For second kernel, there will be such log:
>>
>>         [    0.000000] OF: fdt: Looking for usable-memory-range property...
>>         [    0.000000] OF: fdt: cap_mem_regions[0]: base=0x000000023e600000, size=0x0000000100000000
>>         [    0.000000] OF: fdt: cap_mem_regions[1]: base=0x00000000e8000000, size=0x0000000008000000
>>         [    0.000000] OF: fdt: cap_mem_regions[2]: base=0x0000000100000000, size=0x0000000004000000
>>
>> Changes in v14:
>> - Fix image->elf_headers memory leak during retry loop for arm64 as Sashiko
>>   AI code review pointed out.
>> - Solve the hotplug notifier arch_crash_handle_hotplug_event() AA
>>   self-deadlock problem as Sashiko AI code review pointed out.
>> - Fix the TOCTOU issue in prepare_elf_headers() by get_online_mems().
>> - -ENOMEM -> -EAGAIN as Breno suggested.
>> - Add support for arm64 crash hotplug.
>> - Link to v13: https://lore.kernel.org/all/20260511030454.1730881-1-ruanjinjie@huawei.com/
>>
>> Changes in v13:
>> - Rebased on v7.1-rc1.
>> - Update the commit message.
>> - Add Reviewed-by.
>> - Link to v12: https://lore.kernel.org/all/20260402072701.628293-1-ruanjinjie@huawei.com/
>>
>> Changes in v12:
>> - Remove the unused "nr_mem_ranges" for x86.
>> - Add "Fix crashk_low_res not exclude bug" test log.
>> - Provide a separate patch for each architecture for using
>>   crash_prepare_headers(), which will make the review more convenient.
>> - Add Reviewed-by and Tested-by.
>> - Link to v11: https://lore.kernel.org/all/20260328074013.3589544-1-ruanjinjie@huawei.com/
>>
>> Changes in v11:
>> - Avoid silently drop crash memory if the crash kernel is built without
>>   CONFIG_CMA.
>> - Remove unnecessary "cmem->nr_ranges = 0" for arch_crash_populate_cmem()
>>   as we use kvzalloc().
>> - Provide a separate patch for each architecture to fix the existing
>>   buffer overflow issue.
>> - Add Acked-bys for arm64.
>>
>> Changes in v10:
>> - Fix crashk_low_res not excluded bug in the existing
>>   RISC-V code.
>> - Fix an existing memory leak issue in the existing PowerPC code.
>> - Fix the ordering issue of adding CMA ranges to
>>   "linux,usable-memory-range".
>> - Fix an existing concurrency issue. A Concurrent memory hotplug may occur
>>   between reading memblock and attempting to fill cmem during kexec_load()
>>   for almost all existing architectures.
>> - Link to v9: https://lore.kernel.org/all/20260323072745.2481719-1-ruanjinjie@huawei.com/
>>
>> Changes in v9:
>> - Collect Reviewed-by and Acked-by, and prepare for Sashiko AI review.
>> - Link to v8: https://lore.kernel.org/all/20260302035315.3892241-1-ruanjinjie@huawei.com/
>>
>> Changes in v8:
>> - Fix the build issues reported by kernel test robot and Sourabh.
>> - Link to v7: https://lore.kernel.org/all/20260226130437.1867658-1-ruanjinjie@huawei.com/
>>
>> Changes in v7:
>> - Correct the inclusion of CMA-reserved ranges for kdump kernel in of/kexec
>>   for arm64 and riscv.
>> - Add Acked-by.
>> - Link to v6: https://lore.kernel.org/all/20260224085342.387996-1-ruanjinjie@huawei.com/
>>
>> Changes in v6:
>> - Update the crash core exclude code as Mike suggested.
>> - Rebased on v7.0-rc1.
>> - Add acked-by.
>> - Link to v5: https://lore.kernel.org/all/20260212101001.343158-1-ruanjinjie@huawei.com/
>>
>> Jinjie Ruan (16):
>>   riscv: kexec_file: Fix crashk_low_res not exclude bug
>>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>>   arm64: kexec: Fix image->elf_headers memory leak during retry loop
>>   x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
>>   arm64: kexec_file: Fix potential buffer overflow in
>>     prepare_elf_headers()
>>   riscv: kexec_file: Fix potential buffer overflow in
>>     prepare_elf_headers()
>>   LoongArch: kexec: Fix potential buffer overflow in
>>     prepare_elf_headers()
>>   crash: Add crash_prepare_headers() to exclude crash kernel memory
>>   arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
>>   x86/kexec: Use crash_prepare_headers() helper to simplify code
>>   riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
>>   LoongArch: kexec: Use crash_prepare_headers() helper to simplify code
>>   crash: Use crash_exclude_core_ranges() on powerpc
>>   arm64: kexec: Add support for crashkernel CMA reservation
>>   riscv: kexec: Add support for crashkernel CMA reservation
>>   arm64/crash: Add crash hotplug support
> I have some bikesheedings about the subjects. Can we unify the prefix formats?
> x86/kexec, arm64: kexec_file, riscv: kexec_file, LoongArch: kexec .....
> 
> Huacai

Sure, will update it in next version.

> 
>>
>> Sourabh Jain (1):
>>   powerpc/crash: sort crash memory ranges before preparing elfcorehdr
>>
>>  .../admin-guide/kernel-parameters.txt         |  16 +--
>>  arch/arm64/Kconfig                            |   3 +
>>  arch/arm64/include/asm/kexec.h                |  14 +-
>>  arch/arm64/kernel/Makefile                    |   1 +
>>  arch/arm64/kernel/crash.c                     | 125 ++++++++++++++++++
>>  arch/arm64/kernel/kexec_image.c               |  22 ++-
>>  arch/arm64/kernel/machine_kexec_file.c        |  78 ++++++-----
>>  arch/arm64/mm/init.c                          |   5 +-
>>  arch/loongarch/kernel/machine_kexec_file.c    |  43 +++---
>>  arch/powerpc/include/asm/kexec_ranges.h       |   1 -
>>  arch/powerpc/kexec/crash.c                    |   7 +-
>>  arch/powerpc/kexec/ranges.c                   | 101 +-------------
>>  arch/riscv/kernel/machine_kexec_file.c        |  42 +++---
>>  arch/riscv/mm/init.c                          |   5 +-
>>  arch/x86/kernel/crash.c                       |  92 ++-----------
>>  drivers/of/fdt.c                              |   9 +-
>>  drivers/of/kexec.c                            |   9 ++
>>  include/linux/crash_core.h                    |  11 ++
>>  include/linux/crash_reserve.h                 |   4 +-
>>  kernel/crash_core.c                           | 102 +++++++++++++-
>>  20 files changed, 392 insertions(+), 298 deletions(-)
>>  create mode 100644 arch/arm64/kernel/crash.c
>>
>> --
>> 2.34.1
>>
> 


