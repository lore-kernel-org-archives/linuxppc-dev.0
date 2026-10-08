Return-Path: <linuxppc-dev+bounces-29019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C718ECA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 01:57:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0Y6W6R9Gz2yWy;
	Thu, 08 Oct 2026 12:57:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791424675;
	cv=none; b=CJaMHvUqYHaNm2WBugidC1oLp2z7CNr1eyuXUMXWx6FkjyepprI1TVwyNZh3qnuBXDB6nZhIR+dTLfQ7+Zn4IRp/9mDx8Im9x2kgmMYXaH7GsswGGHs8BotFgglF2di12S/2wkHWddlOkb3jvple1Oq/HMchTRhEjRIQyJf3iq+4dPOQ1VEx6HUOiD1aR0cW6Ttn1RSFDE+Fj2bTmBYQO3NSX81GSO7EsYblBItr0bY9Djx+v2om5avatdJSBETV9vgVgxs3OY0i0a4dC1vTYMCsccJMp6AF2UzCQrfQ8ZINANBSJVVMOONd5OXlXuakIItKbf2qD8XTjZD7Cp1/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791424675; c=relaxed/relaxed;
	bh=bXamncWaqlfk8qQgL1B8Mu0pQVkhOxTSHqjddGG4KBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IbDuVX5zt1ReRYDPI9gLGY6Coxymh3zuDtiYrjGo1FIMUpIvpyc7A5oKDbUWJkaO+Pn3DS53OgdmQ5GqvFcdDtjk7cKyTpgnio+9Yj5ULzmZROY0Tck0DSTlfgy/4O8zo30uqcLU+89/TDpSHMnzZfcSvg68yfi+JAIeywFsGLzcW/hjpiHafU95FmO6l/147mr2Q/ckpSq/VSO/KngD3LxY/r4kycU1Km8HvmBHW+Ylb4gbgH9puL6HE9G0W4YEhFUGDSROq7YvGF3vXHz8YeNFi3PJNqrpL8BI84LQzsP+oySboVB6SKh71zl4LbjEAj9zlr8PZ+FUSBv29ewT3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=g78aXu5F; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=g78aXu5F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0Y6S3pg6z2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 12:57:50 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bXamncWaqlfk8qQgL1B8Mu0pQVkhOxTSHqjddGG4KBw=;
	b=g78aXu5F+eX1vFGrdr7ODw3mfWRzJ2xHcdspBUNlAxc5IhvP2m+84BEowtEnJ7toedzRiDPqJ
	c5RrHPIU8ToMw1OQpK0Wh1ee8RrekPA+Bcg43S7Q5Mtdi8Sp9wD1KAgm7iJsyXAjU3PESGUAKbY
	aQDiKZOBs1rzK16wrPIzn0k=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4j0Xr464hkz1K97G;
	Thu,  8 Oct 2026 09:45:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AC8D4055B;
	Thu,  8 Oct 2026 09:57:39 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 8 Oct
 2026 09:57:32 +0800
Message-ID: <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>
Date: Thu, 8 Oct 2026 09:57:30 +0800
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
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.68]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/21 17:04, Jinjie Ruan 写道:
> As Baoquan and Catalin suggested, this patch set fixes
> several pre-existing code issues found by Sashiko AI [1][2][3].
> 
> The major improvements and fixes included in this series are:
> - Fix several memory leaks for arm64, and similar issues on LoongArch.
> - Fix out-of-bounds write on 32-bit Highmem for x86.
> - Fix TOCTOU race in crash memory range collection.

Hi all,

Gentle ping.

Could anyone take a look or let me know if there's anything
else needed? I can rebase/resend if required.

> 
> This patch set is rebased on v7.3-rc3. Compared to the previous version,
> split out arm64 crash hotplug patches as Breno suggested, which are based
> on these bugfix patches and will be resubmitted after this patch series
> is merged.
> 
> Slightly tested on x86_64 and arm64 qemu with:
> - kexec_load (--kexec-syscall --hotplug)
> - kexec_load (--kexec-file-syscall)
> 
> All boot successfully into the second kernel.
> 
> [1]: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
> [2]: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
> [3]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> 
> Changes in v6:
> - Split out arm64 crash hotplug patches as Breno suggested.
> - Remove unused elfcorehdr_updated [4].
> - Make the patch split more clear.
> - Link to v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
> 
> [4]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> 
> Changs in v5:
> - Rebased on v7.3-rc3.
> - Fix several pre-existing code issues reported by Sashiko AI review. [3]
> - Add an extra slot for memory hot-unplug.
> - Add device_hotplug_lock_assert_held() helper.
> - Rework to let the hotplug paths to skip CPU events entirely, which avoid
>   the TOCTOU race of memory hotplug events and internal CPU offline path
>   without holding device_hotplug_lock.
> - Link to v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
> 
> Changes in v4:
> - Rebased on v7.3-rc1.
> - Update the kexec_core code as Mike suggested.
> - Update the LoongArch subject as Huacai suggested.
> - Drop crash_dump_dm_crypt patch which will be fixed by Coiby in [4] as
>   Sourabh suggested.
> - Drop x86 related patches because of branch conflict, which will
>   be done later.
> - Drop the incorrect CRASH_MAX_MEMORY_RANGES patch.
> - Handle elfcorehdr_index in arm64 arch code.
> - Link to v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
> 
> [4] https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/
> 
> Changes in v3:
> - Handle "KEXEC_CRASH_HP_REMOVE_MEMORY" action.
> - Fix several pre-existing code issues reported by Sashiko AI review [3].
> - Introduce crash_extra_elfcorehdr_size() and elf64_phdr_size() helper.
> - Rework related crash and arch code.
> - Add test method.
> - v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
> 
> Changes in v2:
> - Split out Powerpc bugfix patch as Mike suggested.
> - Use phys_to_virt() instead of __va() in update_crash_elfcorehdr().
> - Convert pnum_hdr_sz() to a function.
> - Only assign elfcorehdr_index after kexec_add_buffer succeeds, considering
>   crash_handle_hotplug_event() already performs validity check on
>   elfcorehdr_index:
>   - We can safely remove the check for CPU hotplug
>     in arch_crash_handle_hotplug_event().
>   - The elfcorehdr_index's segment mem will be valid in
>     update_crash_elfcorehdr(), so we can safely remove the NULL check.
> - Simplify the commit message.
> - v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t
> 
> Jinjie Ruan (14):
>   kexec: Fix CMA segment address translation with non-zero text_offset
>   kexec: Record allocated CMA pages to fix release size mismatch
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix elf_headers memory leak in retry loop
>   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
>     loops
>   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
>   LoongArch: kexec_file: Fix a modified_cmdline leak
>   x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
>   crash: Extract crash_get_memory_ranges() helper
>   crash: Factor out crash_find_elfcorehdr() helper
>   crash: Normalize the kexec_load elfcorehdr at load time
>   driver core: Add device_hotplug_lock_assert_held() helper
>   crash: Fix TOCTOU race in crash memory range collection
> 
>  arch/arm64/kernel/kexec_image.c            |   1 +
>  arch/arm64/kernel/machine_kexec_file.c     |   9 +-
>  arch/loongarch/kernel/kexec_efi.c          |   1 +
>  arch/loongarch/kernel/machine_kexec.c      |   2 +
>  arch/loongarch/kernel/machine_kexec_file.c |  10 +-
>  arch/powerpc/kexec/crash.c                 |   1 +
>  arch/x86/kernel/crash.c                    |  40 +++++---
>  drivers/base/core.c                        |   5 +
>  include/linux/crash_core.h                 |   2 +
>  include/linux/device.h                     |   1 +
>  include/linux/kexec.h                      |   4 +-
>  kernel/crash_core.c                        | 114 +++++++++++++++++----
>  kernel/kexec.c                             |   4 +
>  kernel/kexec_core.c                        |  43 +++++---
>  kernel/kexec_file.c                        |  13 ++-
>  15 files changed, 192 insertions(+), 58 deletions(-)
> 

-- 
Best regards,
Jinjie


