Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFB606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ej+0fabs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbHxg6VjWz2xqh;
	Fri, 27 Nov 2026 13:51:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795747911;
	cv=none; b=dpyzz8ItFccbB52aqnssBDZexCbG5cVTK1s7HnvrbAYyEMgmknuF9ImlaIak0Z4kFrYXWSrz5Tt70jynEuKdhDHNd0jNNAw4D4X8I2YIPzdxYRshhleLVfHDDDT2S58H4tZjV+z4cuhYwcRNSQ9Yxa0IXGKTzIvC9ge9oLxKbVlPvBk62jCXyogzROG2a1/P/UHc6yT5yV0OkTDVwR0dMhvKE29u8v9i0zKygEUgovP1fpX0kLvVImk95VB7yLpWjJk/Vs7QR086vHwTgT4z/ZoBQzjbhdP86BPF7o6Z5IisMSDR//HmpYfYI37/3+2U07ixOR4LXfQZ32BA21JP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795747911; c=relaxed/relaxed;
	bh=+E04+1aBGfLLVpwGpqqzD9wY4oSras1xIIjdVXw1Xf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OrhVw1K7cd7x3epFBUCqOziQ1FW9IEIYelZSd4xySMJ9Jlt/5Peb/23yN3hgl8MLtFvyoFT3B65y/ANhhZWKSpLrrvixa8al0XItA0c9KPcCEKKToNqXydlGj8JHU6DLiDGumBpd9BNe3BFpRGGYceeoQ0v0G+uVosgPp1YGryYdxttDdKczxhwNE9sCWGJz7ufjeO+2VI+VcP1lW9e5Fe2VbaRXwuTarN8LqmVLmvRAQffzhBB5KBOEf9qMGKtycj9yUPTCb6SO4Kj+hDhVDJWu4m04DxPs6vJ9pB2cn4IFGnfYKqYTXnfpdWYG2tfTTZ/T210Ztw4duqOXjigVzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ej+0fabs; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ej+0fabs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbHxc4hnFz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 13:51:45 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+E04+1aBGfLLVpwGpqqzD9wY4oSras1xIIjdVXw1Xf4=;
	b=ej+0fabsQIXeqdncA0bubFcuvkNmxkRJBYp5ZzHUdRXVaNK3kQGFUUshRhUPEsOAG65yMY32s
	MdQ8zcRYTEay/Bx9oDxZLdX+dStvMb3ZlVAIovzcHgsDk2OOEW12vqVRfCQf0C7+lm6IwRbKIuy
	WGoPDhAEM4F8V2D+AlWc0tU=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jbHwR0X5LznTVd;
	Fri, 27 Nov 2026 10:50:47 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1550340578;
	Fri, 27 Nov 2026 10:51:35 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 10:51:32 +0800
Message-ID: <83aa091e-81c4-408a-af67-18e89b19aca0@huawei.com>
Date: Fri, 27 Nov 2026 10:51:32 +0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/11] kexec: Rework segment loading and fix CMA
 retries
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <mpilaniy@redhat.com>,
	<robh@kernel.org>, <coiby.xu@gmail.com>, <Yeking@red54.com>,
	<prudo@redhat.com>, <brads@mainlining.org>, <sourabhjain@linux.ibm.com>,
	<mkchauras@gmail.com>, <blum@kernel.org>, <adityag@linux.ibm.com>,
	<qirui.001@bytedance.com>, <hui.wang@canonical.com>,
	<sohammetha01@gmail.com>, <guoren@kernel.org>, <gaohan@iscas.ac.cn>,
	<ionut.nechita@windriver.com>, <vishal.l.verma@intel.com>,
	<seanjc@google.com>, <ardb@kernel.org>, <richard.lyu@suse.com>,
	<arnd@arndb.de>, <tzimmermann@suse.de>, <rick.p.edgecombe@intel.com>,
	<kai.huang@intel.com>, <kas@kernel.org>, <piliu@redhat.com>,
	<thuth@redhat.com>, <shradhagupta@linux.microsoft.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <tangyouling@kylinos.cn>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <584a0e7a-230e-4a95-9e09-a1d6499a6ea9@huawei.com>
 <awgmlnibFRpjgG2a@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <awgmlnibFRpjgG2a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/26 20:31, Mike Rapoport 写道:
> Hi Jinjie,

Hi Mike,

> 
> On Mon, Nov 23, 2026 at 03:10:53PM +0800, Jinjie Ruan wrote:
>>
>> 在 2026/11/12 21:34, Jinjie Ruan 写道:
>>> ARM64, LoongArch, RISC-V, x86 and powerpc build the elf core header
>>> and place it together with the initrd and the DTB with almost identical
>>> code.
>>>
>>> This series reworks that path into common helpers that the architectures
>>> reuse, and fixes the CMA page and elf core header leaks in the arm64
>>> and LoongArch placement retry loops.
>>>
>>> The patch organization is as follows:
>>>
>>> - Patch 1 moves the release of the elf core header into the generic
>>>   post-load cleanup, so that the architectures no longer free it
>>>   themselves.
>>>
>>> - Patch 2 adds the common helpers
>>>
>>> - Patches 3-7 convert arm64, LoongArch, RISC-V, X86 and Powerpc to
>>>   reuse the common helpers
>>>
>>> - Patches 8-11 fix the CMA pages leaked by the retry loops and
>>>   the loop that makes no progress
>>>
>>> Tested with kexec_file_load() on arm64, LoongArch, RISC-V, X86 and
>>> Powerpc under QEMU, including the CMA retry paths, loading a crash
>>> kernel and booting the second kernel, with the agent help.
>>>
>>> This series is also available at:
>>> 	https://github.com/ruanjinjie-eng/linux/tree/kexec_rework_cma_bugfx_v9
>>>
>>> Changes in v8:
>>> - Rework the common code as Mike suggested: the core provides building
>>>   blocks and the architectures uses them (Mike)
>>> - Build the elf core header once and only place it on the retries (Mike)
>>> - Keep the segment order and the arch placement policy unchanged (Mike)
>>> - Convert x86 and powerpc as well
>>> - Move the CMA fixes to the end of the series (Mike)
>>
>> Hi Mike,
>>
>> Does this refactoring now meet your expectations?
> 
> I only had time for a quick skim, and overall it looks good to me.
> 
> The only thing that stood out was kexec_add_fdt() in kexec/kexec_file.c.
> I believe drivers/of/kexec.c is a better place for it.

I got it, of_kexec_alloc_and_setup_fdt() also here, and it will be
better to name the helper of_kexec_add_fdt().

>  
>> In my view, there is still an issue worth discussing: should we reserve
>> for the crash hotplug elf core header in the framework code
>> kexec_add_elf_core_header(), or only implement it in the x86
>> architecture code, and consider generalizing it after the ARM64
>> implementation is available?
> 
> I think it's better to keep it in x86 for now and generalize later.

OK, expect this will make the elf core header more cleaner and simplify
the code. I will follow the instructions. Will also address the issues
pointed out by Sashiko.

Thanks
Jinjie

>  
>> Best regards,
>> Jinjie
>>
>>
>>> - Link to v7: https://lore.kernel.org/all/20261026075201.699550-1-ruanjinjie@huawei.com/
>>>
>>> Previous Versions are as below:
>>> - v6: https://lore.kernel.org/all/20260921090450.807575-1-ruanjinjie@huawei.com/
>>> - v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
>>> - v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
>>> - v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
>>> - v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
>>> - v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t
>>>
>>> Jinjie Ruan (11):
>>>   kexec: Free the elf core header in kimage_file_post_load_cleanup()
>>>   kexec: Add helpers to load the elf core header, initrd and FDT
>>>   arm64: kexec_file: Load the other segments with common helpers
>>>   LoongArch: kexec_file: Load the other segments with common helpers
>>>   riscv: kexec_file: Load the extra segments with common helpers
>>>   x86: kexec_file: Use the common segment helpers
>>>   powerpc: kexec_file: Use the common segment helpers
>>>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>>>   kexec: Add kexec_rollback_segments() helper
>>>   arm64: kexec_file: Fix CMA segment placement retries
>>>   LoongArch: kexec_file: Fix CMA segment placement retries
>>>
>>>  arch/arm64/include/asm/kexec.h             |   4 +-
>>>  arch/arm64/kernel/kexec_image.c            |  15 ++-
>>>  arch/arm64/kernel/machine_kexec_file.c     |  87 ++++----------
>>>  arch/loongarch/include/asm/kexec.h         |   3 +-
>>>  arch/loongarch/kernel/kexec_efi.c          |  15 ++-
>>>  arch/loongarch/kernel/kexec_elf.c          |   3 +-
>>>  arch/loongarch/kernel/machine_kexec_file.c |  80 +++++--------
>>>  arch/powerpc/kexec/elf_64.c                |   9 +-
>>>  arch/powerpc/kexec/file_load_64.c          |  18 +--
>>>  arch/riscv/include/asm/kexec.h             |   4 +-
>>>  arch/riscv/kernel/kexec_elf.c              |   3 +-
>>>  arch/riscv/kernel/kexec_image.c            |   3 +-
>>>  arch/riscv/kernel/machine_kexec_file.c     |  83 ++++----------
>>>  arch/x86/kernel/crash.c                    |  25 +----
>>>  arch/x86/kernel/kexec-bzimage64.c          |   8 +-
>>>  arch/x86/kernel/machine_kexec_64.c         |   4 -
>>>  include/linux/kexec.h                      |  14 +++
>>>  kernel/kexec_core.c                        |  25 +++--
>>>  kernel/kexec_file.c                        | 125 +++++++++++++++++++++
>>>  19 files changed, 254 insertions(+), 274 deletions(-)
>>>
>>
> 


