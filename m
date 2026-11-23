Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF48606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=guV9eUba
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXxtm0WKBz2xwP;
	Mon, 23 Nov 2026 18:11:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795417872;
	cv=none; b=m7x/8mGEvl1GSRuoGDzGFXofmRzoNiBym2LfCVTNrD8APdznPLYLGWsfcXXQ5vOmhqXE1zi32w/oZQkS+jev+/gz4Ro7uZazL2oi8Is10jvACVaCgm/1e+JSMLhEN+Mvnb21LjOTls8TjpINDLxZFEpjFh74zsa1fQC4V12byoO5JB2ff5KPLAFTx+uQ3Z0ugEHZEMC+imll/jOra3injlbjj7xqKQgV+LdbFLiwBhX4cZ6BasFfEOR3hr6qHMx/u7DEa3/EFuytq4gp1Caw5GLTqQrR5wKBpHsdp1ul9QhursNZ1DEtJRVh/D91m2Ficc1t10PmSjZW3GiEzvHUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795417872; c=relaxed/relaxed;
	bh=aUC6dwvADLWcIIFgIfO7ZojWD6NXidysfo4b9W39AAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jTiF17jf+MY93yIQaf1YxmMO4NVyM77ZXscXzpc1iZsdkivBw+9/F0PCCrBuuOd8CvGIewsq+IwfvG36Yt0jj7Ulw7LlASgS2W9lzQUWZIGwQfeaDOsd1q556GdM2jkrdB2ThPX5ePxT/DycGLqlTNfOoqd8p0LH739Jiasn6ygH3FtIWsu+TnTdR8WeWSivzAvczaCgtC5PvxkrFqY7ncu6iNf1re+zhFOsCe2Lp//z+5Hu8sj+OxE+XPQndktIhch+DXuP13rD0xXXoLFwWAHdGf9pEKyvB4L8wWp9Fq1nDYY+St6zHPdSWiBwGxehtug1knpkPAPhUt6rmKXohg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=guV9eUba; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=guV9eUba;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXxth6Qv4z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:11:06 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aUC6dwvADLWcIIFgIfO7ZojWD6NXidysfo4b9W39AAY=;
	b=guV9eUba+R5PDayFm8H06i5ZTYBsUhnHD4vQWNFcLcZtduyG4gmBeeAB+LML0q7m2R3X3WcAk
	hq/BWQ1RYPlOPu9P52463fbpuoyQt2HGQ1Yx/Ul7gbqJV/FVf0Mc5IJKgZSNsosmbXxuWk9wJBd
	tEXKc1taTNkcoLdTc3eqClM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jXxt80klzzRhRC;
	Mon, 23 Nov 2026 15:10:40 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 81BD440579;
	Mon, 23 Nov 2026 15:10:57 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 15:10:54 +0800
Message-ID: <584a0e7a-230e-4a95-9e09-a1d6499a6ea9@huawei.com>
Date: Mon, 23 Nov 2026 15:10:53 +0800
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
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<mpilaniy@redhat.com>, <robh@kernel.org>, <coiby.xu@gmail.com>,
	<Yeking@Red54.com>, <prudo@redhat.com>, <brads@mainlining.org>,
	<sourabhjain@linux.ibm.com>, <mkchauras@gmail.com>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <qirui.001@bytedance.com>, <hui.wang@canonical.com>,
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261112133418.4044428-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/12 21:34, Jinjie Ruan 写道:
> ARM64, LoongArch, RISC-V, x86 and powerpc build the elf core header
> and place it together with the initrd and the DTB with almost identical
> code.
> 
> This series reworks that path into common helpers that the architectures
> reuse, and fixes the CMA page and elf core header leaks in the arm64
> and LoongArch placement retry loops.
> 
> The patch organization is as follows:
> 
> - Patch 1 moves the release of the elf core header into the generic
>   post-load cleanup, so that the architectures no longer free it
>   themselves.
> 
> - Patch 2 adds the common helpers
> 
> - Patches 3-7 convert arm64, LoongArch, RISC-V, X86 and Powerpc to
>   reuse the common helpers
> 
> - Patches 8-11 fix the CMA pages leaked by the retry loops and
>   the loop that makes no progress
> 
> Tested with kexec_file_load() on arm64, LoongArch, RISC-V, X86 and
> Powerpc under QEMU, including the CMA retry paths, loading a crash
> kernel and booting the second kernel, with the agent help.
> 
> This series is also available at:
> 	https://github.com/ruanjinjie-eng/linux/tree/kexec_rework_cma_bugfx_v9
> 
> Changes in v8:
> - Rework the common code as Mike suggested: the core provides building
>   blocks and the architectures uses them (Mike)
> - Build the elf core header once and only place it on the retries (Mike)
> - Keep the segment order and the arch placement policy unchanged (Mike)
> - Convert x86 and powerpc as well
> - Move the CMA fixes to the end of the series (Mike)

Hi Mike,

Does this refactoring now meet your expectations?

In my view, there is still an issue worth discussing: should we reserve
for the crash hotplug elf core header in the framework code
kexec_add_elf_core_header(), or only implement it in the x86
architecture code, and consider generalizing it after the ARM64
implementation is available?

Best regards,
Jinjie


> - Link to v7: https://lore.kernel.org/all/20261026075201.699550-1-ruanjinjie@huawei.com/
> 
> Previous Versions are as below:
> - v6: https://lore.kernel.org/all/20260921090450.807575-1-ruanjinjie@huawei.com/
> - v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
> - v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
> - v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
> - v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
> - v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t
> 
> Jinjie Ruan (11):
>   kexec: Free the elf core header in kimage_file_post_load_cleanup()
>   kexec: Add helpers to load the elf core header, initrd and FDT
>   arm64: kexec_file: Load the other segments with common helpers
>   LoongArch: kexec_file: Load the other segments with common helpers
>   riscv: kexec_file: Load the extra segments with common helpers
>   x86: kexec_file: Use the common segment helpers
>   powerpc: kexec_file: Use the common segment helpers
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   kexec: Add kexec_rollback_segments() helper
>   arm64: kexec_file: Fix CMA segment placement retries
>   LoongArch: kexec_file: Fix CMA segment placement retries
> 
>  arch/arm64/include/asm/kexec.h             |   4 +-
>  arch/arm64/kernel/kexec_image.c            |  15 ++-
>  arch/arm64/kernel/machine_kexec_file.c     |  87 ++++----------
>  arch/loongarch/include/asm/kexec.h         |   3 +-
>  arch/loongarch/kernel/kexec_efi.c          |  15 ++-
>  arch/loongarch/kernel/kexec_elf.c          |   3 +-
>  arch/loongarch/kernel/machine_kexec_file.c |  80 +++++--------
>  arch/powerpc/kexec/elf_64.c                |   9 +-
>  arch/powerpc/kexec/file_load_64.c          |  18 +--
>  arch/riscv/include/asm/kexec.h             |   4 +-
>  arch/riscv/kernel/kexec_elf.c              |   3 +-
>  arch/riscv/kernel/kexec_image.c            |   3 +-
>  arch/riscv/kernel/machine_kexec_file.c     |  83 ++++----------
>  arch/x86/kernel/crash.c                    |  25 +----
>  arch/x86/kernel/kexec-bzimage64.c          |   8 +-
>  arch/x86/kernel/machine_kexec_64.c         |   4 -
>  include/linux/kexec.h                      |  14 +++
>  kernel/kexec_core.c                        |  25 +++--
>  kernel/kexec_file.c                        | 125 +++++++++++++++++++++
>  19 files changed, 254 insertions(+), 274 deletions(-)
> 


