Return-Path: <linuxppc-dev+bounces-22752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0BCCD98ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 01:45:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggk7w29Dcz2xSb;
	Thu, 18 Jun 2026 11:45:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781747132;
	cv=none; b=THWqKE11mOK3qjtwBEoZjySWruj7Bipd8k52Wgu1HhqbsMKBygJSxtkS9Hmb2Kw6c8HTAWtjB+2JqInKjxG6yHXmzD6PDW5oR0DRj87Yyj1yg310Lr6EjpkbbZw2aKDD4wGosXLaD+xdJS0BzBsFBz1v82Q4wHRw4gWRjjaIkZpucBRkfQYO5PH2oJvIYZltkT3JcTEKOTfGBGxzM0qOc8oOLPKXMh6RFZmaDUf87C9ptWuxpdLyz4xtHF55fT88Cxhj5Y5s5kxWde/35tdrCdYDOY7TuhQ7Ra4dE6Zzn9L14qfSax+VMk0LrPLOHvoKsS+/d0Nzb5AceX8EOzCNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781747132; c=relaxed/relaxed;
	bh=elgYJ9FctEuOCR5N0/Evesj9qTtWETUXJRRIi/jFI38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AVPGFasKEaGSep8dVw5qc7DadYJWZIxc5hvRsFFwROI8l2ddzC95+nEw0h5EREz9GtMbgrOXRpUCeYH5AmK5Whu32S2HhRQYQoo1FJ7Y4y1Ea0Lpuo3Kk+L9SJ0VWI/23wB+ewu83SPdbRp/onIhLjaOpN5jt3YLbVaa3wDAnRerGRz2y/pOT4y/S0MERYQ8B/viKpeQFk8sVCWzMY9kSHcSWoocAUCtnIR3A9yTcxA0o8xr3Z0ASwzGELLOLr4OsV72Waea1i//2CckKM1VSnPiJI1Pf9Q6sJvzjgNmd1B46rAQW7QV2sQeHj7GPbyEU48e02lI1SOjUAn+uIoxHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=mKZIAMgr; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=mKZIAMgr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggk7r6n15z2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 11:45:26 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=elgYJ9FctEuOCR5N0/Evesj9qTtWETUXJRRIi/jFI38=;
	b=mKZIAMgrv0yhhqfotPRGtcu6nLs4Chv0duVXxR76TfyQ3YmTy1nupn328cT3+Yi8uyhE+9n3j
	uc7hX8yW3e8zJNd2aoWbAUFQRgY3AFqjEchvsWtvpFlpDHyb9xAegYA4dU42PHQBl0b7E74Ye3c
	bNyffaauQdereWE6+Bi3IAM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ggjyS3PN2zKm62;
	Thu, 18 Jun 2026 09:37:20 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DADF3402AB;
	Thu, 18 Jun 2026 09:45:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Jun 2026 09:45:17 +0800
Message-ID: <6437c0e3-d5c5-44b1-9157-b30bae2a6335@huawei.com>
Date: Thu, 18 Jun 2026 09:45:17 +0800
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
Subject: Re: [PATCH v16 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
To: Mike Rapoport <rppt@kernel.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <rdunlap@infradead.org>,
	<peterz@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <leitao@debian.org>, <coxu@redhat.com>,
	<Liam.Howlett@oracle.com>, <ryan.roberts@arm.com>, <osandov@fb.com>,
	<jbohac@suse.cz>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <ardb@kernel.org>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
 <ajLr53EK6mJbng-7@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ajLr53EK6mJbng-7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 6/18/2026 2:48 AM, Mike Rapoport wrote:
> Hi Jinjie,
> 
> On Mon, Jun 08, 2026 at 03:34:49PM +0800, Jinjie Ruan wrote:
>> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
>> and crashk_cma memory are almost identical across different architectures,
>> This patch set handle them in crash core in a general way, which eliminate
>> a lot of duplication code.
>>
>> And add support for crashkernel CMA reservation for arm64 and riscv.
>>
>> This patch set is rebased on v7.1-rc1.
> 
> Please rebase this set on v7.2-rc1 once that's out.
> 
> I'm going to queue it in the liveupdate tree then to expose to the wider
> testing.
> 
> Meanwhile it would be great to chase riscv and x86 maintainers for acks :)

Thanks! That sounds great.

I will rebase this patch set on v7.2-rc1 as soon as it is out and send v17.

In the meantime, I will CC and reach out to the RISC-V and x86
maintainers to request their reviews and Acks.

Best regards,
Jinjie

> 


