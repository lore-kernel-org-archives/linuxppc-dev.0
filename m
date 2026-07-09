Return-Path: <linuxppc-dev+bounces-23900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1598CC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:37:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwlct2FmCz3c9k;
	Thu, 09 Jul 2026 16:37:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783579038;
	cv=none; b=Gom5+GeYpiiJb5nbYCc1JMb8IohjRiZ3rXHnYkkGNX85J8HhHQoo7P+TV36qMf3JsxYtqFCI+Fgg7J/rCnXRqm9uJa6IIuJ4467QdmEW5mTqa1tZOEoi/gKLyjW4oD2Am6iS71XYavzCbTLVbwF1g1UUyRUkfwxubGQIZ69/llPTbFNlnZMvgBUL7ZfEE0iPH1v8BRF5xa/3ZW56rD9A4p2CVX7QlcleBedebFvPzuQZn+V4KAHoqFKIvO++GHfpRQs0DvANYR3E3Fmx8dK6fHPk7JZP/fxa6Fi5FJblgHwzZHfBVZtdwoSnS4IWgPGAUelnpUP1ERfHi+Ne2sEuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783579038; c=relaxed/relaxed;
	bh=nx9uTIIpEYlLKn/TlkCDaDRFao/mdFBZNp54PrQsjPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FrRGQoYrHPggK2rauFGP8fCvgGHI/H8I1Ys3c+oz5vGt7x3E03jGkyFfvZAXP60J5S+8j4P0r5X2lqXxvRBQ53oE9WyqGlW25y1TLcFkp5O4TitXY38cfnrjY9lue30hCYxGVpNt+dYVM01kPE5h2RfhXiRqtgQvk/myHY6PrM+58/qbrtfmDuRBrF2BVf9XdLgCK3USmc5eLZwjTpAHHE6oYLLz4Jvdf591dgmVMCy1D81ttxOtvyQcMDH0bubbIf/6yxEAVFNuaaHBs8tjKu+Dhm5vf7OnIU9cvwoPWgkppZJqAvyOcDJFyBdX82rR9Q6MIa60tdKcWW1x5r7oaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ktnvhwnt; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ktnvhwnt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwlcs1lRgz3byZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:37:16 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nx9uTIIpEYlLKn/TlkCDaDRFao/mdFBZNp54PrQsjPw=;
	b=ktnvhwntGgaRfWEAoNl4nP/eMAv3WF40w6U+rHuISN9Agz4HcuqKVmp7oYolkH1rs7mUNfj74
	gCHhpWuGxUwoXRpbuDGJzqHbbuU4k1jP4vTX4mO+NAfGMKawslgm9u9z/t6vpBkLBD6GuiT0hg5
	ivGaNCxTDm241yTFRway9Ns=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gwlQ654XpzRhRh;
	Thu,  9 Jul 2026 14:27:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id ED73340579;
	Thu,  9 Jul 2026 14:37:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 14:37:07 +0800
Message-ID: <21875fb4-434b-480d-b68b-e2ffd5fff5ae@huawei.com>
Date: Thu, 9 Jul 2026 14:37:05 +0800
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
Subject: Re: [PATCH v16 18/18] arm64: vdso: Expose sigreturn address on vdso
 to the kernel
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
CC: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@hansenpartnership.com>,
	<deller@gmx.de>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<luto@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <chris@zankel.net>,
	<jcmvbkbc@gmail.com>, <peterz@infradead.org>, <wad@chromium.org>,
	<thuth@redhat.com>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<kevin.brodsky@arm.com>, <linusw@kernel.org>, <yeoreum.yun@arm.com>,
	<song@kernel.org>, <james.morse@arm.com>, <anshuman.khandual@arm.com>,
	<broonie@kernel.org>, <liqiang01@kylinos.cn>, <pengcan@kylinos.cn>,
	<ryan.roberts@arm.com>, <yangtiezhu@loongson.cn>, <sshegde@linux.ibm.com>,
	<mchauras@linux.ibm.com>, <austin.kim@lge.com>, <jchrist@linux.ibm.com>,
	<arnd@arndb.de>, <sohil.mehta@intel.com>, <andrew.cooper3@citrix.com>,
	<jgross@suse.com>, <kas@kernel.org>, <x86@kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-csky@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-m68k@lists.linux-m68k.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-um@lists.infradead.org>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-19-ruanjinjie@huawei.com>
 <20260630172619-6c78c2e2-c2d3-44be-88e6-6c82de12baf4@linutronix.de>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260630172619-6c78c2e2-c2d3-44be-88e6-6c82de12baf4@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 6/30/2026 11:32 PM, Thomas Weißschuh wrote:
> On Mon, Jun 29, 2026 at 09:06:16PM +0800, Jinjie Ruan wrote:
>> Syscall User Dispatch (SUD) requires the signal trampoline code to not be
>> intercepted. This is necessary to support returning with a locked selector
>> while avoiding infinite recursion back into the signal handler.
>>
>> Implement arch_syscall_is_vdso_sigreturn() for arm64 to support this
>> exclusion mechanism. For native 64-bit tasks, it checks whether the current
>> PC matches the 'svc #0' instruction inside the vDSO sigreturn trampoline.
>>
>> 	SYM_CODE_START(__kernel_rt_sigreturn)
>> 	        mov     x8, #__NR_rt_sigreturn
>> 	        svc     #0
>> 	SYM_CODE_END(__kernel_rt_sigreturn)
>>
>> For COMPAT tasks, it verifies if the instruction falls within
>> the architecture's 'sigpage' range, allowing the kernel to safely bypass
>> dispatching syscalls originating from these areas back to userspace.
>>
>> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Suggested-by: kemal <kmal@cock.li>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/include/asm/elf.h |  1 +
>>  arch/arm64/kernel/vdso.c     | 16 ++++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
>> index d2779d604c7b..f43d4dea916a 100644
>> --- a/arch/arm64/include/asm/elf.h
>> +++ b/arch/arm64/include/asm/elf.h
>> @@ -185,6 +185,7 @@ do {									\
>>  struct linux_binprm;
>>  extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>>  				       int uses_interp);
>> +extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
> 
> A header for that?

Sure, it need a cleanup, as currently, there is no syscall_user_dispatch
header file related to the architecture.

> 
>>  /* 1GB of VA */
>>  #ifdef CONFIG_COMPAT
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index 592dd8668de4..5a0314a3c26e 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -343,3 +343,19 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>  
>>  	return ret;
>>  }
>> +
>> +bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>> +{
>> +	unsigned long sigtramp;
>> +
>> +#ifdef CONFIG_COMPAT
>> +	if (is_compat_task()) {
>> +		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
>> +
>> +		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
>> +	}
>> +#endif
>> +	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
>> +
>> +	return regs->pc == (sigtramp + 8);
> 
> Instead of hardcoding 'sigtramp + 8' you could add a new label to the 'svc #0'
> instruction and use that with VDSO_SYMBOL().

It seems that the modification of __kernel_rt_sigreturn() is not recommended

> 
> 
> Thomas


