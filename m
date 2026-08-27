Return-Path: <linuxppc-dev+bounces-26156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F127C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 22:31:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWGSz1S0Bz2xHK;
	Fri, 28 Aug 2026 08:31:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787869875;
	cv=none; b=aqzyMwSWq6DV7ky8pewcZaUvuq+mepDJILJhtBxtUWbr1QyjYJaLFkui/Q/nZdoLonskuXG41jHx79OAx10DNaI3SvS6DOPqzbXuOODqHDXZM6p3H1A2ZRlDrD/8AeVopO1j1QdR+/tlphUMv59ryFaYm8mmNnwT46FaxzgtWejvAIoBv69TmtNcpcwQFc45mfX+CBaz7lOPf8MS4QaF43dssIaUvNIkvNMAM4rRNywJG8oGZv5jfUx+LzvYtRmPhuC5xAb6JsnIBaf4V7/YMFcLwyeNx5uegxxtFJ/oHjr0YZ2xv6ag1KQxSahQiXTx2rVcBQbhsGgyCe3MlYhzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787869875; c=relaxed/relaxed;
	bh=LZKaCTEQCsGwD2GMVqaYbcSqk2BZFOtph9TUIqgES9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfRRIDzP/37CgkgzUkvshhbpHxSNOIg6wyRpfpGoDQ8XlWc+tCNqH6lGOyCKiejGifdMg1bl+kwbNcLIr//gDQpPICwOmcgHxVRmAwt58l8bRMrpsqChuI+FCXvEO2WLOgjWa7rClaOdp5SSagjj7Ek7PtUJmM7H2GK7HzpGtoqlYj9GHXN5Rc1iyeq0JstU3IjRELShJ0SYjbxC1eYFv/AKwwoF05I4k2GVGrh/kDWE5tsXbh9U2ujeT/RkJjw+GW+Iql2jYOZXNuKOSfvj82BHK5xtP1BCkbREf+C2c1uXAc9idyy8ZIBlqcQB3VqmHo3qo5fMBgUi2mZxN+ZQgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026072801 header.b=gNMC6j97; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026072801 header.b=gNMC6j97;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 423 seconds by postgrey-1.37 at boromir; Fri, 28 Aug 2026 08:31:12 AEST
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWGSw1Ydsz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 08:31:11 +1000 (AEST)
Received: from [IPV6:2601:646:8081:8d71:abf3:5091:f2d1:704c] ([IPv6:2601:646:8081:8d71:abf3:5091:f2d1:704c])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 67RMMfVr1791603
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Aug 2026 15:22:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 67RMMfVr1791603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026072801; t=1787869372;
	bh=LZKaCTEQCsGwD2GMVqaYbcSqk2BZFOtph9TUIqgES9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gNMC6j97IhbcMMgbmy2ny/QcgirAYDsXNjEkUGVM1Znjxud9QCneQ+NaB5oSLG7gQ
	 v5jvb30334qIMdinwHRV9Mkm1vAkB5dFCtDPrhTExA9+mhWKMhkyyY7pwNNDXV+nYa
	 ZIUdNM5QoTekGZ7e8HvCcyeQNddaLDAOWN/Jvy8Uxxv9wNTihWITw7TCmVqP1EgGTN
	 kCIbtTmc82Op/HsTj3eTn45BlM2A5KPVDP0EK2g3yw1TIdDnwOqpIsCW0Ta4Fd3LkB
	 DEHUft1fSZPVoc0UzuPw3ALg0KFFm7VuvuV0p1CXapd4uXhsjXORgINVOEreyDf3f9
	 wBqVK82EaU2Nw==
Message-ID: <ed8b99e6-4d90-4622-9d43-451bf6a8db2c@zytor.com>
Date: Thu, 27 Aug 2026 15:22:35 -0700
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
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry
 handling
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260707181957.433213175@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-07-07 12:05, Thomas Gleixner wrote:
> Sorry for the long CC list, but this is a treewide change.
> 
> Michal recently posted a RFC patch to separate the potential syscall number
> modifications in syscall_enter_user_mode_work() from the information
> whether the syscall should be processed and the return value modified:
> 
>   https://lore.kernel.org/lkml/CE1qW@kunlun.suse.cz
> 
> The existing logic is:
> 
> arch_syscall()
> 	regs->result = -ENOSYS;
> 
> 	syscallnr = syscall_enter_from_user_mode(regs, syscall);
> 
> 	if (syscallnr != -1L)
> 		regs->result = invoke_syscall(regs, syscall;
> 
> syscall_enter_from_user_mode() invokes ptrace, seccomp and
> tracing/BPF/Probes. All of them can modify the syscall number.
> 
> ptrace and seccomp explicitly set the syscall number to -1L to indicate
> that the syscall invocation needs to be skipped and the result has not to
> be modified as it might have been modified by ptrace or seccomp. The
> tracer/BPF/Probes mechanism can modify the syscall number as well and
> relies implicitly on the -1L logic.
> 
> This can obviously not be differentiated from a syscall invocation where
> userspace provided -1 as syscall number.
> 
> The general agreement of the discussion was that the current mechanism,
> while functionally correct is non-intuitive and something like Michals
> proposal would make that code clearer and easier to handle on the
> architecture side:
> 
> arch_syscall()
> 	regs->result = -ENOSYS;
> 
> 	if (syscall_enter_from_user_mode(regs, &syscall)) 
> 		regs->result = invoke_syscall(regs, syscall;
> 
> That discussion made me look deeper into the related code and as usual
> there were a lot of other things to discover.
> 
>   1) Stack randomization
> 
>      add_random_kstack_offset() can only be invoked after
>      enter_from_user_mode() established proper state as it calls into
>      instrumentable code.
> 
>      PowerPC got that wrong and the other architectures either invoke it
>      after enter_from_user_mode() or after syscall_enter_from_user_mode().
> 
>      The latter is suboptimal as the randomization takes place after all
>      the user mode entry work. Aside of that add_random_kstack_offset()
>      uses get/put_cpu_var(), which makes it usable in preemptible code, but
>      when invoked in the interrupt disabled region that's pointless
>      overhead.
> 
>   2) As discussed in the above thread just changing the function signature
>      of syscall_enter_from_user_mode[_work]() so they take a pointer
>      argument for the syscall and then return 0 on success is not really
>      intuitive either. Aside of that this breaks the implicit assumption of
>      the tracer when setting the syscall number to -1.
> 
>   3) The x86 entry code has some historically accumulated oddities
> 
> The following series addresses this by:
> 
>   1) Providing new [syscall_]enter_from_user_mode() variants, which include
>      stack randomization and utilize a new add_random_kstack_offset_irqsoff()
>      variant, which avoids the get/put_cpu_var() overhead and converting all
>      usage sites over
> 
>   2) Picking up Jinjie's seccomp patch from:
> 
>      https://lore.kernel.org/lkml/20260629130616.642022-2-ruanjinjie@huawei.com
> 
>      and addressing the feedback (renaming the seccomp functions)
> 
>   3) Making the ptrace and tracer related functions return a boolean value
>      to indicate syscall permission
> 
>   4) Addressing the x86 oddities
> 
>   5) Converting the tree over to the new scheme
> 
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
> 
> There should be no functional changes, at least there are none intended.
> 
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
> 
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
> 
> The series applies on Linus tree and is also available from git:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
> 
Hi,

It looks like I didn't get a personal Cc: on this one and so I missed it (it
happened just before I found out I would be departing Intel, so I can make the
excuse that I was just a bit distracted.)

This series is a great cleanup, but it did make me concerned on one count: it
ends up making it universal that the syscall number is always stored and
fetched from memory. I'm worried that this may have undesirable effects on
future CPUs which incorporate data speculation, which is probably something
that will happen at some point (this is a general statement, not in any way
related to any former employers of mine.)

As such, I was looking at changing that to *always* keep the system call
number in a register, to allow the CPU to consistently maintain a "chain of
custody" of this value.

This isn't a hard thing to solve in any way: replacing the pointer argument
with a two-element structure return would do the trick. As far as I know,
*all* architectures that support Linux support returning structures with two
register-sized values in registers.

However, before digging into this I would like to hear people's opinions.

	-hpa


