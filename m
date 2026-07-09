Return-Path: <linuxppc-dev+bounces-23896-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD32C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 06:30:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwlT01Jmpz3byZ;
	Thu, 09 Jul 2026 16:30:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783578628;
	cv=none; b=Ego9hCIT6tqQ+VYSkzhGWGfiHWUIKUMPibLuBeO0sImKwvXT7kyyCx3qhmdwPsbdSqPygw/0pqFcx8+Ll3Dcno+y9yz9oN8XGmoD4ojVigixOKGfywV63AFUcMT/oOW4+u9f1ZhzRqeVl/1F6bixc+UhNrgyR9v4KrbMZBxDlR3K1tFhAsYSjJQ7Q7t3bphk2a3664/HuuniS46aVhSQz6/XNqi7ugCIErvzi41LF5jjTxYgChJ8XBAjq0CJ4vhOkMVFnghm8jqE25jAHsQPyMIa/NrXGdUsh5cihkL8n5DLFe3Kio723vzDhKkEp5YLL7Dh/1kPCdgJNCgQc9bgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783578628; c=relaxed/relaxed;
	bh=XPEUhf19vuUBFdiEFO1XIuZL6JrCsEiMauadhYQeXkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EO60e/XpSUBn2TEOg1VcaVRYNc/4o97h+WmWTcjyPkxOaDnf7aBFdRirX9OyR06+JLz9XXQK7Yc6S+dZ8PiVMS3CfSl5f7dt9oPXbZp2MTe6oZWqFchfD61cF9D5953yKtQ+oq6QuKcSG8ZKIen/0dJjkDRvvycM4vDhDhUtOqLsBoHixm7qtEj6OFfGf4kjdyzNjrghIt9FXlFXSyDJWwpfbAuC3AqC/zIo5xTVSI3O/FvEEOtR+T9W1TTTo+wKsHRTWhXxEvkDWfBQAqy7i9UQc6HGYH+/hN4D7SRw1P28kQ2oOqOvtyRfMUqqWI6qohFv4CkywlYcldnJWy3aHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ezKkmXBT; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ezKkmXBT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwlSx3VW0z3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 16:30:23 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XPEUhf19vuUBFdiEFO1XIuZL6JrCsEiMauadhYQeXkI=;
	b=ezKkmXBTzR/qNWnLeDbF+5BJNIo8pxBj9ojrafj3ZsTNYsFYXSZEejUWq4j67MLSYDOtlML8b
	4d5j0Apq64AYWvH9mkFxelT89X6YltSvbtnX3ieBwv4tiM+7+5GgVA1Sav5ubsVZtqfEBcyCMa8
	2mgoep7V9O3WqitLx2zHOl8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gwlGL6KHvz1T4gk;
	Thu,  9 Jul 2026 14:21:14 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CAD922012A;
	Thu,  9 Jul 2026 14:30:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 14:30:12 +0800
Message-ID: <3ac6d4be-7c57-44c2-80a0-408e2c6f8136@huawei.com>
Date: Thu, 9 Jul 2026 14:30:11 +0800
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
Subject: Re: [PATCH v16 02/18] syscall_user_dispatch: Introduce a weak
 fallback for arch_syscall_is_vdso_sigreturn()
To: Mark Rutland <mark.rutland@arm.com>
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
	<thuth@redhat.com>, <ada.coupriediaz@arm.com>, <kevin.brodsky@arm.com>,
	<linusw@kernel.org>, <yeoreum.yun@arm.com>, <song@kernel.org>,
	<james.morse@arm.com>, <anshuman.khandual@arm.com>, <broonie@kernel.org>,
	<liqiang01@kylinos.cn>, <pengcan@kylinos.cn>, <ryan.roberts@arm.com>,
	<yangtiezhu@loongson.cn>, <sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>,
	<austin.kim@lge.com>, <jchrist@linux.ibm.com>, <arnd@arndb.de>,
	<thomas.weissschuh@linutronix.de>, <sohil.mehta@intel.com>,
	<andrew.cooper3@citrix.com>, <jgross@suse.com>, <kas@kernel.org>,
	<x86@kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-um@lists.infradead.org>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-3-ruanjinjie@huawei.com> <akegeU59jSK9t7FX@J2N7QTR9R3>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <akegeU59jSK9t7FX@J2N7QTR9R3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/3/2026 7:43 PM, Mark Rutland wrote:
> On Mon, Jun 29, 2026 at 09:06:00PM +0800, Jinjie Ruan wrote:
>> Currently, multiple architectures (LoongArch, RISC-V, S390, Powerpc)
>> provide identical stubs for arch_syscall_is_vdso_sigreturn() that simply
>> return false. This results in redundant boilerplate code across the tree.
>>
>> Introduce a default __weak implementation of
>> arch_syscall_is_vdso_sigreturn() directly in syscall_user_dispatch.c that
>> returns false. This allows architectures that do not utilize a vDSO
>> sigreturn to entirely drop their redundant inline definitions.
>>
>> Architectures requiring a specialized check (such as x86) will continue to
>> override this fallback with their strong symbol definitions.
>>
>> Clean up the redundant implementations in loongarch, riscv, s390
>> and powerpc.
> 
>> +bool __weak arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>> +{
>> +	return false;
>> +}
> 
> If we need this, please make it:
> 
> #ifndef arch_syscall_is_vdso_sigreturn
> static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> {
> 	return false;
> }
> #endif
> 
> ... and require that architectures which need this provide a CPP
> definition.
> 
> The use of __weak is generally problematic, as it prevents the compiler
> form being able to elide code, and gets in the way of symbol resolution.
> It's perfectly fine to require that architectures need to provide a CPP
> definition alongside their own implementation of this function.
> 
> That said, as per my comment on v15, I'd prefer that for now we DO NOT
> enable syscall user dispatch on arm64, and we first make it possible for
> architecture to express whether or not they support that, even if they
> use GENERIC_ENTRY. That might mean this patch isn't necessary right now.

That sounds good. First, focus on switching to generic entry, without
having to implement syscall user dispatch immediately.

> 
> [1] https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
> 
> Mark.
> 


