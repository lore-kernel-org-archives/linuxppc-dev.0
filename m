Return-Path: <linuxppc-dev+bounces-23969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54599C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 20:15:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx5nC5SYZz2xYg;
	Fri, 10 Jul 2026 06:15:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783628143;
	cv=none; b=QhjlPPFWJrqfRss63Rf+xmEvUb62f0Un3G1lqE4jpypx5pPiLwJMyPEmwF7Sm5iyFWkhNiycG11GS8kQfArvSPOJ+ZnmkUGaWEBBeo10ARmCC+xrEMPTHSF4nrgqTxv2MLy5zNYxGck6elb4aKi/RIVFOSok9A5FHVZMtbqBgMND7OfdG+BjBkjnu8gZmSX4uPCfcv3os5HkolngY0yYfj+yh86ixylPfsWQG7NwkLY85nmZdYuIOw8MYOMAiqyg/E+LjvH0n1E9UdlfI+zVt+9QbYqJzzSmLdmS1K7MhqDgYW0ekb/ryS6sDTDm9uRZyq7u4i8Y4ehirDNSyiEHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783628143; c=relaxed/relaxed;
	bh=4V4fuwVKw9a+buqSTfOSwTO6Zlt+2k8vx+/ObUQlSos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH1MoM+8pT3E6RMuUrYM3GAbjQk0po9NLjuoC+kdPO/QwK+Wc+16J19b4MMctP9N7PTbPwpsfXH5NOrSmOT0b8rJgKWRdJBHbo/Kl5wUCB9V5wLjvq7lpFgs6Cw2NEY/oy2PV+9sT0KP5wzRe3gLfIlf5pWJnqsucsqfB8PYpHH9A+TpEDzVyjiAUeCjNe8/O5SOO+2SAbqLj74BBRE0bjeTDzFnOqFLXb9H9160OzY0W2y3+oVVnjnlL8IuwTJih2dsItu31hPNp4yQ0vyFS+BMjxb/dOYDMvJYtypO8fO/f483D5pXMol8FubJWBqcPBsRsXJbsTKZpz/k2JYmVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rvpumNrB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rvpumNrB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx5n96dJ8z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 06:15:40 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso170377a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783628139; x=1784232939; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4V4fuwVKw9a+buqSTfOSwTO6Zlt+2k8vx+/ObUQlSos=;
        b=rvpumNrBVTtMyOL8q/jAzTL+3ILL4J3VFEhuYuWcb8zV7g2CX658j1kWawHKC/Jcde
         cLg1pV99V2AMY2aqmDe8ar1h3U/Xa8EKfsSfYA0noiZDuoKbV7cjUAMKQDjV+CQUC6XX
         ffAiJcmEJyWc90SEqzyOgiLrVo0qOdM3q4hBRxN5624/PDdoc4fDOdEHNuCiz+npttur
         FJ1nnbr2dqlmljfVhBeRPYKUumDEIilxR8Fpzw7Oup/LupG3R8liyf26Z9gzGELWnHhj
         lw74CGXPXikCbjmnssCPS7JdO6f8mB7BIUAi1Gfk6XmSc2dU7dIsF9QBcQCLx2F0y08M
         fTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628139; x=1784232939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4V4fuwVKw9a+buqSTfOSwTO6Zlt+2k8vx+/ObUQlSos=;
        b=d92msLKUR25ZNy3ye/VMaMg70h+SRswiEEXTm+QoR3/BbSlIhrqP9vR02H4LY2HzT6
         x8ssV5OdZE0wnwgIH8XUV+GDvnlnA8Cz4DvVw5we+7vZywSavtpDxZlGDzeUEu2Oau/u
         bvLEzWCAfueEWF2DtV1KtLRrSx7LPYrez/HQ6Of93h0ZGMtCIkTG00A2dBhUmoMw6jVv
         BQPIJ3cblKkfOS+oBxLe30Xl1WNSfA1iYLHZG/gV3WQ/XnomGysMaOL3Ew0i8TUJN/iJ
         UdZsUnb/QULzXZvCneO6G4W8Z4ZRIeFH/asMyW84Kk0nBPZ7MJy4JsnBP35rGU0WolXJ
         1cMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEsieFq4rQex9Q1ryvfMcnG+GoU0Q4uUm8+WHOgYUnHM3J5Npqe0/3hY9R3WSGTJihmCEZVyrCtyLVqMw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvhHAbqlh1mNFpC23etECcTtGzAmmLeMWd3z+hmLhfaDObEeNM
	8POQGY948vtPdAtd1uLKZjOlOYg4B3MqZadurHTqxVNoICkmKq6YS3m/
X-Gm-Gg: AfdE7clzp/7Pl30rfhmgmzQ0MrZkkc9hGl4uzIC448HBnjNoCE9P5ZgBxB3TEhL9vZ+
	9KViqAPfr6N5NWCRAryD+Fu1cCtjN1EBhvlz465hNQldPzhaU4CM5XW25ZG8uD0hrPwQK7PuN4O
	oN8AYMCCCisc4fBOmgzIkWVjwWdD5BZpfNZRWfYbLYfRvMHfWlUDPyi7iq17bEdUnXAYMHjWTuN
	gsQZS58LnxmDGPwSVCdEgxEC39yMl28rAU4Xg3HflBvenWAS07xjP0rC04DtRwDItwiA1cgdr0q
	jYXFtXTJg/5uVyA37M+WfhVzQ1fKMIDOgp2tjD3ouAN4h1h46JnxMFSbKlL9Rb5jQ5wg9SAJX7J
	ct5fjLUpUTTLXDyNbzbj6hpTKGH4tkftHxZVOC7pr+XMvvMcG/GFNadnBEdJbQQGoOwXAOkaMxm
	8hqgRZdCx2d8Vt1S8GBc3hbVh+isGmhlSEAplVr9LDCbC3NPuFsDYY4lsNEIOHEoUrez8VEWU=
X-Received: by 2002:a05:6a21:32a2:b0:398:8870:b58f with SMTP id adf61e73a8af0-3c0bcbe77a5mr11679805637.14.1783628138627;
        Thu, 09 Jul 2026 13:15:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm2908315eec.15.2026.07.09.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:15:38 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:45:19 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry
 handling
Message-ID: <ak_7lawD_OujooyZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707181957.433213175@kernel.org>

On Tue, Jul 07, 2026 at 09:05:53PM +0200, Thomas Gleixner wrote:
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
> Thanks,
> 
> 	tglx
> ---
>  Documentation/core-api/entry.rst      |   33 +++++---
>  arch/alpha/kernel/ptrace.c            |    4 -
>  arch/arc/kernel/ptrace.c              |    2 
>  arch/arm/kernel/ptrace.c              |    4 -
>  arch/arm64/kernel/ptrace.c            |    4 -
>  arch/csky/kernel/ptrace.c             |    4 -
>  arch/hexagon/kernel/traps.c           |    2 
>  arch/loongarch/kernel/syscall.c       |   17 +---
>  arch/m68k/kernel/ptrace.c             |    4 -
>  arch/microblaze/kernel/ptrace.c       |    2 
>  arch/mips/kernel/ptrace.c             |    4 -
>  arch/nios2/kernel/ptrace.c            |    2 
>  arch/openrisc/kernel/ptrace.c         |    2 
>  arch/parisc/kernel/ptrace.c           |   12 +--
>  arch/powerpc/kernel/syscall.c         |    5 -
>  arch/riscv/kernel/traps.c             |   14 +--
>  arch/s390/kernel/syscall.c            |   11 +-
>  arch/sh/kernel/ptrace_32.c            |    4 -
>  arch/sparc/kernel/ptrace_32.c         |    2 
>  arch/sparc/kernel/ptrace_64.c         |    2 
>  arch/um/kernel/ptrace.c               |    2 
>  arch/um/kernel/skas/syscall.c         |    2 
>  arch/x86/entry/syscall_32.c           |   70 +++++++------------
>  arch/x86/entry/syscall_64.c           |   61 ++++++----------
>  arch/x86/entry/vsyscall/vsyscall_64.c |   14 +--
>  arch/x86/include/asm/entry-common.h   |    1 
>  arch/x86/include/asm/syscall.h        |   10 --
>  arch/xtensa/kernel/ptrace.c           |    5 -
>  include/asm-generic/syscall.h         |    4 -
>  include/linux/entry-common.h          |  125 ++++++++++++++++++++--------------
>  include/linux/irq-entry-common.h      |    6 -
>  include/linux/ptrace.h                |   13 +--
>  include/linux/randomize_kstack.h      |   19 +++++
>  include/linux/seccomp.h               |   12 +--
>  kernel/entry/syscall-common.c         |    7 +
>  kernel/seccomp.c                      |   35 ++++-----
>  36 files changed, 264 insertions(+), 256 deletions(-)
> 
> 
> 
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

Boot tested this on P11 LPAR and P9 powernv system.
Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

