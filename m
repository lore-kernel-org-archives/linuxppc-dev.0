Return-Path: <linuxppc-dev+bounces-18997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785EAFF494B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 07:11:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkj9018K9z2xpt;
	Mon, 30 Mar 2026 18:11:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774854692;
	cv=none; b=ErBZw89sjLzaGbyj6MPF/XqEiAXA+CL82Ik9SY8czl5z2Cxrj4HyKQGDUwPEqoM5CaiMR8ZAnKIRdNZKWdXS6VPKQgpL/0qrXT6znP290YgBEYmY6iUwv7fvseZJgaeatUEgBe+cFaHXFrs6cA70R5v/7pKfH+k2BJUF5O4nUx8KEtQ8C3xJ8E6vysD3pAAqF1WoNMhdn/G4U4785GWoM4dmmTA/LpzUvnVCKo+ECXNC9PLbVUtomFvmUkxHSD83W8ONtjh1YBWCIYIJO7Lt2KeOPTaUZutBQonGtyB1SQ+SR+Q/7audkVvBt4B/QaKGpRiza6ZDlCie1TEmkNIs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774854692; c=relaxed/relaxed;
	bh=dtxKLBtxeK7WnTNaRuRN6wjCIkUS/712dvNiyCme+dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DCkGrf7iua/oA7kWDpjTop1KssPBVRQxYsCIgjEl2jaO7JqufhyotvzselptMXaDQET0I25bdodGN6lVHBVbUfHf4K0wNaStSP4REj+fRgSsacJXS0kj+SdGZvl6W9lFyTR5cqE0V9Whw9DImDOSqvRE81Metl6FYo+IYAYETAozB4ptMfT00Yc7dx8xQqyHLGFC+39bKSDOmYFn+8vIm50CuVXN/jKMIaVtkgtSOuOQRYy+8VZdIz7VK9Mu17TTw3MZozzUB9kqLk4RaxaI6KHKo+FsFhPrcpZ5RPm8aX1+HYdMXAOSHWoag1O6DJOedYK6xgrzrHndssRfBCyCwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=REz6lrKf; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=REz6lrKf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkj8x60Prz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 18:11:28 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dtxKLBtxeK7WnTNaRuRN6wjCIkUS/712dvNiyCme+dM=;
	b=REz6lrKfLnmTbZnTSrloA8Qxl9ytOsPa/OKwvl5w3Tr9CHfmTc48CSuaquXePwoPkmMac2rJ+
	Ia8doJegFbzncelLLc+WY8AD1bp7J4dS8mfObdEHsZoC3f0vux4WUTdBtkywh/SHtrYyCW4VUbm
	dhD5rc1J2Q4kAhnpMA6VL/8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fkj2Z2x0tz12LDJ;
	Mon, 30 Mar 2026 15:05:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E15B240537;
	Mon, 30 Mar 2026 15:11:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 15:11:17 +0800
Message-ID: <baa90080-9e6e-c1e5-13a1-b17496c690b4@huawei.com>
Date: Mon, 30 Mar 2026 15:11:13 +0800
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
Subject: Re: [PATCH v11 01/11] riscv: kexec_file: Fix crashk_low_res not
 exclude bug
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <pawan.kumar.gupta@linux.intel.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <cfsworks@gmail.com>,
	<osandov@fb.com>, <jbohac@suse.cz>, <tangyouling@kylinos.cn>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<kevin.brodsky@arm.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260328074013.3589544-1-ruanjinjie@huawei.com>
 <20260328074013.3589544-2-ruanjinjie@huawei.com>
 <CAJF2gTRN=RpgzQsQ7QDbwjDmyQZP9anQZ+CaK2r-Mrz9dQbohQ@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAJF2gTRN=RpgzQsQ7QDbwjDmyQZP9anQZ+CaK2r-Mrz9dQbohQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/30 11:49, Guo Ren wrote:
> On Sat, Mar 28, 2026 at 3:41 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> As done in commit 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
>> and commit 4831be702b95 ("arm64/kexec: Fix missing extra range for
>> crashkres_low.") for arm64, while implementing crashkernel=X,[high,low],
>> riscv should have excluded the "crashk_low_res" reserved ranges from
>> the crash kernel memory to prevent them from being exported through
>> /proc/vmcore, and the exclusion would need an extra crash_mem range.
>>
>> Cc: Guo Ren <guoren@kernel.org>
>> Cc: Baoquan He <bhe@redhat.com>
>> Fixes: 5882e5acf18d ("riscv: kdump: Implement crashkernel=X,[high,low]")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/riscv/kernel/machine_kexec_file.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
>> index 54e2d9552e93..3f7766057cac 100644
>> --- a/arch/riscv/kernel/machine_kexec_file.c
>> +++ b/arch/riscv/kernel/machine_kexec_file.c
>> @@ -61,7 +61,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>>         unsigned int nr_ranges;
>>         int ret;
>>
>> -       nr_ranges = 1; /* For exclusion of crashkernel region */
>> +       nr_ranges = 2; /* For exclusion of crashkernel region */
>>         walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
>>
>>         cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
>> @@ -76,8 +76,16 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>>
>>         /* Exclude crashkernel region */
>>         ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
>> -       if (!ret)
>> -               ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
>> +       if (ret)
>> +               goto out;
>> +
>> +       if (crashk_low_res.end) {
>> +               ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> Exclude crashk_low_res is reasonable, but have you tested this?

Just simply tested on qemu with crashkernel=4G with following kexec
mentioned in
https://lore.kernel.org/all/20230726175000.2536220-1-chenjiahao16@huawei.com/.
And the second kernel can be started normally.

https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2

# dmesg | grep crash
[    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000
(128 MB)
[    0.000000] crashkernel reserved: 0x000000017fe00000 -
0x000000027fe00000 (4096 MB)



> 
>> +               if (ret)
>> +                       goto out;
>> +       }
>> +
>> +       ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
>>
>>  out:
>>         kfree(cmem);
>> --
>> 2.34.1
>>
> 
> 

