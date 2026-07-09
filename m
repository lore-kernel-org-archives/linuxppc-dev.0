Return-Path: <linuxppc-dev+bounces-23877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926B4C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 02:04:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwdYZ2L0zz3cZh;
	Thu, 09 Jul 2026 12:04:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783562642;
	cv=none; b=GCG4kKw0AYib/lork74Oc7GV0ZzlSLCpih58Uz+vxIZNcxTyvDwcSSzEdftNrzcGFxeXwLubQC9i6PNfhBZ3SvEmNJZ2K2b+WO0QqK5fCX0u0wm7hUeMVtjEsTJo+wNVwOHBkdgeIozHZyha04HEy3OzdMbKIgXtVgECntaRJbaFFdYTRTQhSso3W6l0QI8WoByHuAXDULCA27g3R7pYlHfV3Zkh6i1vGhdFxpOaEw4OdL8LYA25xi4LWqmzWtGcDdAUv7U81Legfx7hYZ6qV7QVMJtztSpjkfR2qei6YPSS0oF1WK9nSM9ZKVZJGtFbT79VGdC3xdboizNOFf1xEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783562642; c=relaxed/relaxed;
	bh=SbMumxZtxbvkP/ieepXLg1JhrafzB20Wq2MZPkH/Sw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A3ul9MkhZw5d63V4tKBd07Uz51AE2ZVJgl07yUo/387p/+ipSydlucs2lEMs0WakEvEoE6Ciey+uqs8MOw3Y//BJbQR1FJuty8dDJmzyWjBHG+qWQirohnh7DM3BoZ3j3L6M94YXB9f8dnwrL9lFp2TnUT9F6Ktdsg+MEvIo6GrsETkwvqSSOkXdg1Pf4wgAtdqzUXbO8ia8o+w6hdRZ0geoCGJ+SvHcez/FXoFHiaTQI+7NvM53IOdNzB8jppSK9QeJlgYjpo2vInIXYMqDQvGqi6fSyZwpKByh43rs7kzA7Xllym5jV1qJkiOawoabsfMVR+7zl7dX4HzqugUEdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AWDuAsAD; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AWDuAsAD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwdYW60Bxz3cZg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 12:03:57 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SbMumxZtxbvkP/ieepXLg1JhrafzB20Wq2MZPkH/Sw0=;
	b=AWDuAsADSwEvEL71EYfZ0NigOV6Nm/EE0o+eCaP1xQFlxhq8DY4cyFSYwdUDcA872iUYRmCcL
	fgkqFmw2f6REMuKThf5T1j9G/cENjZayXtYg+Tp2Kdo8RhfXnSpSgOVUD3wzxl53MN4FlPjvW4S
	5jTBmgoFDxvMSl13ULhIb7E=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwdLg6g1HzKmWh;
	Thu,  9 Jul 2026 09:54:35 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id D94DC40578;
	Thu,  9 Jul 2026 10:03:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 10:03:50 +0800
Message-ID: <cb27984f-bb8e-4deb-90f2-c3c9965b3017@huawei.com>
Date: Thu, 9 Jul 2026 10:03:49 +0800
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
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, Kees Cook <kees@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, <loongarch@lists.linux.dev>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	<linux-riscv@lists.infradead.org>, Sven Schnelle <svens@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <x86@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Russell
 King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
	<richard@nod.at>, Chris Zankel <chris@zankel.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-alpha@vger.kernel.org>,
	<linux-csky@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-um@lists.infradead.org>, Arnd Bergmann
	<arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
	<will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
	<monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
	<linux-snps-arc@lists.infradead.org>, <linux-hexagon@vger.kernel.org>,
	<linux-openrisc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, =?UTF-8?Q?Michal_Such=C3=A1nek?=
	<msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260707190254.493733289@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/8/2026 3:07 AM, Thomas Gleixner wrote:
> Invoking sys_ni_syscall() from a code path, which already knows that the
> syscall number is invalid just to assign -ENOSYS to regs->ax is a pointless
> exercise. It's even redundant as the low level entry code already has set
> regs->ax to -ENOSYS on entry.

Makes sense, the all reltaed entry has already initialized
regs->ax to -ENOSYS.

This makes the code very concise.

LGTM
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

> 
> Remove the extra conditionals and the function calls.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  arch/x86/entry/syscall_32.c |    2 --
>  arch/x86/entry/syscall_64.c |   10 +++-------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -81,8 +81,6 @@ static __always_inline void do_syscall_3
>  	if (likely(unr < IA32_NR_syscalls)) {
>  		unr = array_index_nospec(unr, IA32_NR_syscalls);
>  		regs->ax = ia32_sys_call(regs, unr);
> -	} else if (nr != -1) {
> -		regs->ax = __ia32_sys_ni_syscall(regs);
>  	}
>  }
>  
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -68,7 +68,7 @@ static __always_inline bool do_syscall_x
>  	return false;
>  }
>  
> -static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
> +static __always_inline void do_syscall_x32(struct pt_regs *regs, int nr)
>  {
>  	/*
>  	 * Adjust the starting offset of the table, and convert numbers
> @@ -80,9 +80,7 @@ static __always_inline bool do_syscall_x
>  	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
>  		xnr = array_index_nospec(xnr, X32_NR_syscalls);
>  		regs->ax = x32_sys_call(regs, xnr);
> -		return true;
>  	}
> -	return false;
>  }
>  
>  /* Returns true to return using SYSRET, or false to use IRET */
> @@ -92,10 +90,8 @@ static __always_inline bool do_syscall_x
>  
>  	instrumentation_begin();
>  
> -	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
> -		/* Invalid system call, but still a system call. */
> -		regs->ax = __x64_sys_ni_syscall(regs);
> -	}
> +	if (!do_syscall_x64(regs, nr))
> +		do_syscall_x32(regs, nr);
>  
>  	instrumentation_end();
>  	syscall_exit_to_user_mode(regs);
> 


