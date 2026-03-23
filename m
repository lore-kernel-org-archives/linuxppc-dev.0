Return-Path: <linuxppc-dev+bounces-18564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EBAD58CBE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 01:44:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffGF31Tchz2ySB;
	Mon, 23 Mar 2026 12:44:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774230279;
	cv=none; b=BBusy7ogY3IveZztlGJCJAUr3TLwota9ZhXk8TwB3/kCy+G7s/bu7LQxNCr/AKxt42IbcFhIZFsIlG3pEcsxIxACNdy8PnywutVQzIzUnRt87/hAklfpd0iSYGUOtPmGCFYVf97TBZqMqMJUa2ZHd+gCh2lhF6SQkwtmeq5tOEnuEXYEUtv7jbaJc/GO4RFqKNBayu1DS830QAFIl3tzLjgD+7zgnczXj5QvcFdu8DsnJ/AwLoxaFmDQZf1NH28EI5IvYKZRPodNToyAPYdjq5cxkKroXovB4Zmxc7y4kabfZ/SXVXpyy7lXuUNqdEdo22stLrabDHgXw93HiXvJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774230279; c=relaxed/relaxed;
	bh=pSMsxgVPNUNI/+qvUNa5KlapyBTF883qZfslgr8BRmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E/iH3Z03w3tW38XU54xNlAPwocf1q8ZWLRd2LqIe5jUkUoPbtSfkoqoxVqK3ouCpDqY6Q7KWDM6AuuRIpxM5ttjCcLLXUV2Tt8RfN4+70vKfWAzs2pnPNxbrV3R945/2ckMAUgJIJzeFbxXuytC7Umo6P5epgDDcfi2pId8jFIfbTO5+F5ARh9+ZgtvaGkTc51riCbT0T5klQaMwv2/VYlO2StD7C6XY35CAeABvPVRHGQlT1EueWEhzDsUssaQNGmEmG8kd2vgdt0s1EbzJyuCOXgji7f/gqBUt21/vgWzuD16T/3HBHizaU8HNsMKFzvdxPwMLw5Bin/0Nkt3K6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=APNd9D7y; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=APNd9D7y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffGDz6T4fz2xQ1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 12:44:33 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pSMsxgVPNUNI/+qvUNa5KlapyBTF883qZfslgr8BRmc=;
	b=APNd9D7y2JNHp4D4QOOD++LuCQoXp2QHGLVpl/YYZBBISWJ4nCvGXpi11BSZy4k87VAZexJaK
	DmZQwZXpcskLul5yIs2ECY31UOgkgDmF+7RBLtrOpvZZtNV6++VEVf15kNxt/OZz+Dny78134bp
	B+Weax2Qis1460o5BUYRBJI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ffG5q0HjQzRhRZ;
	Mon, 23 Mar 2026 09:38:23 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3283840567;
	Mon, 23 Mar 2026 09:44:27 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Mar 2026 09:44:22 +0800
Message-ID: <ce99a024-f910-cd83-c60a-28e60db318d3@huawei.com>
Date: Mon, 23 Mar 2026 09:44:21 +0800
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
Subject: Re: [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Content-Language: en-US
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260302035315.3892241-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)


If there are no other review comments, I'd like to ask if this is ready
to be merged.

On 2026/3/2 11:53, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> Rebased on v7.0-rc1.
> 
> Basic second kernel boot test were performed on QEMU platforms for x86,
> ARM64, and RISC-V architectures with the following parameters:
> 
> 	"cma=256M crashkernel=256M crashkernel=64M,cma"
> 
> Changes in v8:
> - Fix the build issues reported by kernel test robot and Sourabh.
> - Link to v7: https://lore.kernel.org/all/20260226130437.1867658-1-ruanjinjie@huawei.com/
> 
> Changes in v7:
> - Correct the inclusion of CMA-reserved ranges for kdump kernel in of/kexec
>   for arm64 and riscv.
> - Add Acked-by.
> - Link to v6: https://lore.kernel.org/all/20260224085342.387996-1-ruanjinjie@huawei.com/
> 
> Changes in v6:
> - Update the crash core exclude code as Mike suggested.
> - Rebased on v7.0-rc1.
> - Add acked-by.
> - Link to v5: https://lore.kernel.org/all/20260212101001.343158-1-ruanjinjie@huawei.com/
> 
> Changes in v5:
> - Fix the kernel test robot build warnings.
> - Sort crash memory ranges before preparing elfcorehdr for powerpc
> - Link to v4: https://lore.kernel.org/all/20260209095931.2813152-1-ruanjinjie@huawei.com/
> 
> Changes in v4:
> - Move the size calculation (and the realloc if needed) into the
>   generic crash.
> - Link to v3: https://lore.kernel.org/all/20260204093728.1447527-1-ruanjinjie@huawei.com/
> 
> Jinjie Ruan (4):
>   crash: Exclude crash kernel memory in crash core
>   crash: Use crash_exclude_core_ranges() on powerpc
>   arm64: kexec: Add support for crashkernel CMA reservation
>   riscv: kexec: Add support for crashkernel CMA reservation
> 
> Sourabh Jain (1):
>   powerpc/crash: sort crash memory ranges before preparing elfcorehdr
> 
>  .../admin-guide/kernel-parameters.txt         |  16 +--
>  arch/arm64/kernel/machine_kexec_file.c        |  39 +++----
>  arch/arm64/mm/init.c                          |   5 +-
>  arch/loongarch/kernel/machine_kexec_file.c    |  39 +++----
>  arch/powerpc/include/asm/kexec_ranges.h       |   1 -
>  arch/powerpc/kexec/crash.c                    |   5 +-
>  arch/powerpc/kexec/ranges.c                   | 101 +-----------------
>  arch/riscv/kernel/machine_kexec_file.c        |  38 +++----
>  arch/riscv/mm/init.c                          |   5 +-
>  arch/x86/kernel/crash.c                       |  89 +++------------
>  drivers/of/fdt.c                              |   9 +-
>  drivers/of/kexec.c                            |   9 ++
>  include/linux/crash_core.h                    |   9 ++
>  kernel/crash_core.c                           |  89 ++++++++++++++-
>  14 files changed, 178 insertions(+), 276 deletions(-)
> 

