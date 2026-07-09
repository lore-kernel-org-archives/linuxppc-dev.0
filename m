Return-Path: <linuxppc-dev+bounces-23886-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0448C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 02:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwfT02bXhz3bxJ;
	Thu, 09 Jul 2026 12:45:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783565108;
	cv=none; b=ms6xyvm35NYJqFw91KZibBF3mzL+LONQho+YRFUxGk0vxKj03VFqxHJN/u+Y7bGsG6y9XDFFdIuyp7Wf/mlvkIhi5kxo7RvrCTnnJ5KWenpZdpSsWFno8M4sRtan0wVY/qeWdOdsni9OooKh5Fg0dKzaKmkKn+Yi2HbgL9xU1OsFcxxsxrzLETsb/WULOhkRefxQt0D3xxOXxkhjn5lgEYhNLKyYfzMxQ8xaB3y3pNA/a3RwKP2LhTODq2CyI7O+V1mw1ElrbSnZkNCr3JUxUYYbfPUo9g3IO7zKBKuUBqoipKCsZhI3ceRrIid+6OD0JOkz8plxmcj5mbXxDJClSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783565108; c=relaxed/relaxed;
	bh=dcBLjAZIuOcKQn3MTY+bY4X711wnRwuwnS+wCIvAotY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MtWTEmp8AwaeXSn2Hx2YRiTlj34Tc+W+r00D3PA49+25wssNBfkhWFqRABJ4dVfk/M1XIkeR+1hFoV5gTJ8uaKheXGt5cbzQunocm1+8qy0v0DcZuZEsRmtN1q376YEwgUuynppviSWNvUGFi0OEe6CiZOsahfLzopYEowYs8f/vw1538dn/MMuOkBPO6KZI0SybKYDayIz6XmXb8WCZhTysRy3p4uwF/++Rt5B/oTEj2skRxWjOuB3OBWZFRgfj2D7xRzTurKBYGZBIja9SUfSKVXa7MN7SseASAXl5/tZ1HRrLCcFNHpwDVO2oisfMqqXDtp8epjcaYgvUXvVH8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vWAJv97f; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vWAJv97f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwfSx2vjfz3bxC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 12:45:03 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dcBLjAZIuOcKQn3MTY+bY4X711wnRwuwnS+wCIvAotY=;
	b=vWAJv97fd4j7v7LNzsA1jn7LpDaj1qwxvv/Lzs0LqF+U5jdju4uyIQO/9pQ/LJxYukNVEgr9E
	NQoEi0lQj6z3nWKyFlljAYQcLzbsWESODoQ516BnoreEQp50kC1pN6GxxIn6she9WscRAAZsS6n
	UHY+SgzEAjANoQ5JULImdXU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gwfG3311mzmVZr;
	Thu,  9 Jul 2026 10:35:39 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 14A5440563;
	Thu,  9 Jul 2026 10:44:54 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 10:44:50 +0800
Message-ID: <da58e28e-7cb1-4465-a283-039b36977aa6@huawei.com>
Date: Thu, 9 Jul 2026 10:44:48 +0800
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
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, Kees Cook <kees@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, <loongarch@lists.linux.dev>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	<linux-riscv@lists.infradead.org>, Sven Schnelle <svens@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
	<linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo Ren
	<guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
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
 <20260707190254.079478122@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260707190254.079478122@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
> These functions integrate the stack randomization.
> 
> syscall_enter_from_user_mode_randomize_stack() has the advantage that the
> randomization happens early right after enter_from_user_mode().
> 
> In both cases also the overhead of get/put_cpu_var() in
> add_random_kstack_offset() is avoided.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: x86@kernel.org
> ---
>  arch/x86/entry/syscall_32.c         |   19 +++++--------------
>  arch/x86/entry/syscall_64.c         |    3 +--
>  arch/x86/include/asm/entry-common.h |    1 -
>  3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

> 
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -142,10 +142,9 @@ static __always_inline bool int80_is_ext
>  	 * int80_is_external() below which calls into the APIC driver.
>  	 * Identical for soft and external interrupts.
>  	 */
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
>  
>  	instrumentation_begin();
> -	add_random_kstack_offset();
>  
>  	/* Validate that this is a soft interrupt to the extent possible */
>  	if (unlikely(int80_is_external()))
> @@ -210,11 +209,9 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
>  {
>  	int nr;
>  
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
>  
>  	instrumentation_begin();
> -	add_random_kstack_offset();
> -
>  	/*
>  	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
>  	 * syscall number.
> @@ -252,10 +249,10 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
>  	 * orig_ax, the int return value truncates it. This matches
>  	 * the semantics of syscall_get_nr().
>  	 */
> -	nr = syscall_enter_from_user_mode(regs, nr);
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
> +
>  	instrumentation_begin();
>  
> -	add_random_kstack_offset();
>  	do_syscall_32_irqs_on(regs, nr);
>  
>  	instrumentation_end();
> @@ -268,15 +265,9 @@ static noinstr bool __do_fast_syscall_32
>  	int nr = syscall_32_enter(regs);
>  	int res;
>  
> -	/*
> -	 * This cannot use syscall_enter_from_user_mode() as it has to
> -	 * fetch EBP before invoking any of the syscall entry work
> -	 * functions.
> -	 */
> -	enter_from_user_mode(regs);
> +	enter_from_user_mode_randomize_stack(regs);
>  
>  	instrumentation_begin();
> -	add_random_kstack_offset();
>  	local_irq_enable();
>  	/* Fetch EBP from where the vDSO stashed it. */
>  	if (IS_ENABLED(CONFIG_X86_64)) {
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -86,10 +86,9 @@ static __always_inline bool do_syscall_x
>  /* Returns true to return using SYSRET, or false to use IRET */
>  __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
>  {
> -	nr = syscall_enter_from_user_mode(regs, nr);
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
>  
>  	instrumentation_begin();
> -	add_random_kstack_offset();
>  
>  	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
>  		/* Invalid system call, but still a system call. */
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -2,7 +2,6 @@
>  #ifndef _ASM_X86_ENTRY_COMMON_H
>  #define _ASM_X86_ENTRY_COMMON_H
>  
> -#include <linux/randomize_kstack.h>
>  #include <linux/user-return-notifier.h>
>  
>  #include <asm/nospec-branch.h>
> 


