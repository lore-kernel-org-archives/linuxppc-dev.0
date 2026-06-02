Return-Path: <linuxppc-dev+bounces-21828-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EA3CD6E56
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 01:43:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTtsB0qKGz2xmV;
	Tue, 02 Jun 2026 11:43:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780364622;
	cv=none; b=OPFRQ3wlDoirqciYRP80kQCWOo6gTrFiDfQF+GVjy2FboddGzbdhQ8NNo8VzS0FAVB3/e2TM0Jb80QsdjvigG8/pEOUCzXyCZ5kYCEKnwwmTn2703ispzZqGmw1rAbRUhhml/l+4RTSc4NPStbnXzPUNcA+4FNruuNTJtqdRPK4XbneKRx5TSi9FCWIT5SlMN76Kt6vWUUzxDrGvJRmM0fqhdeKU/zfTwTTLFCUhVK9VdPjIh4WPCph7ewDWuvX0RKUyIvLKqpxKUhqQCZBDZCm9CYcjWFeXaArh/FuMp00VBjxSzhiyVlDYIhPclEmpi864rurkeMNSGBkEq/0NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780364622; c=relaxed/relaxed;
	bh=lSyN8uzwXhmY7DMOaiH5+32B3ctfvf5QTlFldSqrORg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CyVHWQbo0vKK3PBdNVXScy/VSa9ruBPH/rGHLt39LGLD7EC83hlEIO06PpD9RprIhGXI0AghgezKqk2mcdB8SF8p0qX7yJy7WOaqx6CNSLKH7QVdl+qHltFVSyrtoUol5w9WoBORk4wQW9ciqgjXyomf53ZKsDjMGPbwCLB1I3Hnj3XIsNPI1RJxY/ExL4OC+Vdgab1gKpLwPb9xuDjikzzMctBEE6M3vz+hVA1P1EJlmQepsqZXdxv5PW2r2xKaFGEHftHJc5bNu5cq88oCdpXbuIAUr88UjDaL4TFfrk9zYnC8iLIppCKp3OawP0w6K/xCNGPSFLCt+fJOaKYpDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rHaZ8PNG; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rHaZ8PNG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTts7030mz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 11:43:36 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lSyN8uzwXhmY7DMOaiH5+32B3ctfvf5QTlFldSqrORg=;
	b=rHaZ8PNGA+gISgwgik10XoynkWfz7ayOHWp5pYg2DR9+kM7LRE6sFvvbCwY7WZuExcMNMQCQS
	XuZ/RD3H3jG0SNieTYmEXXudVXbblnFxAcsCDvSXYCJwK6nxFw20KYn+MN8CS9fgZgl4GqZ8Sc9
	+cBgIb8sYmtBRoiL2hN8lbA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gTthC4T77zpStZ;
	Tue,  2 Jun 2026 09:35:55 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A94E940561;
	Tue,  2 Jun 2026 09:43:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 09:43:27 +0800
Message-ID: <1a459706-80db-43d8-b163-76fc09da338d@huawei.com>
Date: Tue, 2 Jun 2026 09:43:26 +0800
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
Subject: Re: [PATCH v15 00/23] arm64/riscv: Add support for crashkernel CMA
 reservation
To: Baoquan He <baoquan.he@linux.dev>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <sourabhjain@linux.ibm.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <masahiroy@kernel.org>, <gshan@redhat.com>,
	<james.morse@arm.com>, <maz@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <suzuki.poulose@arm.com>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <djordje.todorovic@htecgroup.com>,
	<austin.kim@lge.com>, <namcao@linutronix.de>, <djbw@kernel.org>,
	<chao.gao@intel.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <makb@juniper.net>, <graf@amazon.com>,
	<piliu@redhat.com>, <rafael.j.wysocki@intel.com>,
	<mario.limonciello@amd.com>, <jbouron@amazon.com>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
 <ah2Lx7KHI60tzd0v@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ah2Lx7KHI60tzd0v@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 6/1/2026 9:40 PM, Baoquan He wrote:
> Hi Jinjie,
> 
> On 06/01/26 at 05:47pm, Jinjie Ruan wrote:
> ...snip... 
>> Changes in v15:
>> - Unify the subject prefix formats as Huacai suggested.
>> - Fix powerpc pre-existing NULL pointer dereference [Sashiko [1]]
>> - Fix powerpc pre-existing __merge_memory_ranges() memory range
>>   truncation [Sashiko [1]].
>> - Fix pre-existing arm64 CMA page leaks [Sashiko[2]].
>> - Fix pre-existing crash_load_dm_crypt_keys() Use-After-Free and
>>   Double Free issue [Sashiko[3]].
>> - Fix vfree(headers) and uninitialized variables issue
>>   and simplify the fix [Sashiko[2]].
>> - As walk_system_ram_res() and for_each_mem_range() use different
>>   lock, unify and simplify the fix of TOCTOU buffer overflow via memory
>>   region padding [Sashiko[4]].
>> - Fix the arm64 crash dump issues in Sashiko[5].
>> - Link to v14: https://lore.kernel.org/all/20260525084932.934910-1-ruanjinjie@huawei.com/
> 
> Do these Fixes have anything with the main target of this patch series
> you mentioned in cover-letter:"arm64/riscv: Add support for crashkernel CMA"?
> The patches become more and more in each new version, I am wondering if
> it relies on these Fixes patches to implement your adding support for
> crashkernel CMA on arm64/risc-v.
> 
> If not relying on them, could you split them into different patchset
> on different purpose? 

Hi Baoquan,

Thank you for your valuable guidance.

You are absolutely right. Most of these fix patches are indeed not
strictly related to the core implementation of the crashkernel CMA
support. They are pre-existing bugs in the surrounding kexec/crash code
that were flagged during our review.

Previously, Andrew suggested taking a look at the code review comments
from the Sashiko AI system, which is why these fixes kept expanding. I
completely agree with your advice that there is no need to keep them
together. I will split them into two completely different patchsets
based on their purpose:

1. A cleaner version of this series, strictly focused on adding the core
crashkernel CMA support for arm64/riscv.

2. One standalone bugfix patchset dedicated entirely to fixing these
pre-existing issues.

By the way, I would also appreciate some advice on how to handle further
AI reviews. It seems that the more code we touch or refactor to fix
these pre-existing issues, the more tangential bugs the AI flags in the
newly exposed areas, making the series extremely difficult to converge.

Should I continue to address all AI-reported bugs associated with the
surrounding code in this series, or should we draw a strict line
and only focus on the core CMA logic moving forward?

I will prepare the split patchsets shortly. Thanks again for
straightening this out!

Best regards,
Jinjie Ruan


> 
> Thanks
> Baoquan
> 
>>
>> [1]: https://lore.kernel.org/all/20260525092207.96B9D1F000E9@smtp.kernel.org/
>> [2]: https://lore.kernel.org/all/20260525091149.1A1E01F00A3D@smtp.kernel.org/
>> [3]: https://lore.kernel.org/all/20260525105227.3C2421F000E9@smtp.kernel.org/
>> [4]: https://lore.kernel.org/all/20260525095447.944E11F000E9@smtp.kernel.org/
>> [5]: https://lore.kernel.org/all/20260525101746.9959D1F000E9@smtp.kernel.org/
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

[...]
>>  24 files changed, 430 insertions(+), 338 deletions(-)
>>  create mode 100644 arch/arm64/kernel/crash.c
>>
>> -- 
>> 2.34.1
>>


