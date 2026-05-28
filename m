Return-Path: <linuxppc-dev+bounces-21621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6427DCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 07:48:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQzBN0zN6z2xRs;
	Thu, 28 May 2026 17:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779954508;
	cv=none; b=FWWO95LVeUkcwp3ysL/kCU9wGedvPLD3dk+pdannsLn8c1WnBIjbyCQfyg7u7Es7ayGqn+Urd7/B8CwK36TrX0J2yuQdpSbLI3e4gJSXuXqmrEhWw76T57gLkqS2oLppYxdAr5YHY8hHdeuZqrZKCVkMIg+tpq8ep9ju4+5FL5bGj1ZxWf6ren57pkzZCNAf0DJtnkuCkeb8wCypN2f/H9Ridj4/ARZrMVEW0Ktp7DLmheYWMC76nYHQpHt7KYJIcw+KIk/1vMgcPGQT7dKOngRZLyPspnc3oTEKl27pszG2njkDvxfeK2+CJFmFhlWKQrh0Vss/fgADDz2yda6BFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779954508; c=relaxed/relaxed;
	bh=dpnGK6j+kvjnma6YHvrd5wwrLUxTfDRQvHYx5YGFkW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=euK1jmBM/osvZDpQtN/DXyTUMARFavOagD5UIy//5Xbno0vEyppvJbft6ZmcsO9A1Xdl3XRr/xQ2ng3iiT+iVlUOt9D7kp3vJ1Yds0hSA7ctRKdPEyyGwojyBiXtYg0NSi8QY2pA1rfPGF9DbaLpKVSTjODR9zSrJXbEw6y2JELiVDQF9BUyJiHofZxzz+J/7iGL2nnKngflCnIpncd1NmNkCIpfw0KEjJ/ORv9LGTvbzLHUHnX23ArnKGLqNWRyf3QsnYw4XG1IdK8wCMVB+/e5gpscztqrdxXra1UKB3EiYCUuloONKVaxTqAXlB9utVP+1xGVTWKKH/nGHF7svg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1P43YydG; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1P43YydG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQzBM13qDz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 17:48:26 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dpnGK6j+kvjnma6YHvrd5wwrLUxTfDRQvHYx5YGFkW8=;
	b=1P43YydGlenQu7gtjAUK3WkAvoYefi1zaef3ts/PCFV8z8jXMftJzmpGqo5LjAapMRdRXr6/a
	N1fDE/FHFxcXRLBxskpsButEzn/mkgSXUmZGYLvw2ukswIM6zPl+B8AGyjYLYkBV/NlrO3ruwSZ
	nO8/hOI1gcFH8PiH3P2wFRQ=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gQz1K6V9Wz1cyQK;
	Thu, 28 May 2026 15:40:37 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 95504402AB;
	Thu, 28 May 2026 15:48:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 15:48:16 +0800
Message-ID: <08ab6756-091c-4bee-9d49-cb84d0be027c@huawei.com>
Date: Thu, 28 May 2026 15:48:15 +0800
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
To: Huacai Chen <chenhuacai@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <ardb@kernel.org>,
	<masahiroy@kernel.org>, <mark.rutland@arm.com>, <maz@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>,
	<junhui.liu@pigmoral.tech>, <vishal.moola@gmail.com>, <kas@kernel.org>,
	<debug@rivosinc.com>, <namcao@linutronix.de>, <liaoyuanhong@vivo.com>,
	<fuqiang.wang@easystack.cn>, <seanjc@google.com>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
 <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com>
 <ahQ0WRiMsB011tym@kernel.org>
 <CAAhV-H5x3m08=acrUr2VOAQ8-r2PhN1xTdr3NihHocoPM5=3hQ@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAAhV-H5x3m08=acrUr2VOAQ8-r2PhN1xTdr3NihHocoPM5=3hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 5/25/2026 9:17 PM, Huacai Chen wrote:
> On Mon, May 25, 2026 at 7:37 PM Mike Rapoport <rppt@kernel.org> wrote:
>>
>> Hi Huacai,
>>
>> On Mon, May 25, 2026 at 06:14:52PM +0800, Huacai Chen wrote:
>>> On Mon, May 25, 2026 at 4:50 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>>>
>>>> Jinjie Ruan (16):
>>>>   riscv: kexec_file: Fix crashk_low_res not exclude bug
>>>>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>>>>   arm64: kexec: Fix image->elf_headers memory leak during retry loop
>>>>   x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
>>>>   arm64: kexec_file: Fix potential buffer overflow in
>>>>     prepare_elf_headers()
>>>>   riscv: kexec_file: Fix potential buffer overflow in
>>>>     prepare_elf_headers()
>>>>   LoongArch: kexec: Fix potential buffer overflow in
>>>>     prepare_elf_headers()
>>>>   crash: Add crash_prepare_headers() to exclude crash kernel memory
>>>>   arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
>>>>   x86/kexec: Use crash_prepare_headers() helper to simplify code
>>>>   riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
>>>>   LoongArch: kexec: Use crash_prepare_headers() helper to simplify code
>>>>   crash: Use crash_exclude_core_ranges() on powerpc
>>>>   arm64: kexec: Add support for crashkernel CMA reservation
>>>>   riscv: kexec: Add support for crashkernel CMA reservation
>>>>   arm64/crash: Add crash hotplug support
>>> I have some bikesheedings about the subjects. Can we unify the prefix formats?
>>> x86/kexec, arm64: kexec_file, riscv: kexec_file, LoongArch: kexec .....
>>
>> It might look weird in the series, but powerpc and x86 use '/' and arm64 and
>> riscv use ':' so in the logs in arch/ this would be actually fine.
> OK, but at least we can unify kexec and kexec_file.

That looks fine.

Jinjie

> 
> Huacai
> 
>>
>> With the only exception of arm64/crash that should have been arm64: crash:
>>
>>> Huacai
>>
>> --
>> Sincerely yours,
>> Mike.
> 


