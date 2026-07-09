Return-Path: <linuxppc-dev+bounces-23965-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336ADC44506
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 19:23:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx4cZ59jmz2xKh;
	Fri, 10 Jul 2026 05:23:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783624990;
	cv=none; b=eGDWWMp2l5E5/qkJGjXsL88bRfxxvPsGybL4vdRpsc9PhpocVfA5krbgv0H6CIe/HI/hqiQBmF+T+Iy5P0i38msUOiQYe37AF4EoHxlO8mLV8xib50wpdFdyWssCuTBCEV9iMit54Eh18hItmk50NTki8szssPr/9IPrt/d8ZA+gPDzcV6qTBz8B4wPglazezR/3yVzqUyh1A+5ZVfiTKppaQM+sDtWmeIuz5riG2Rs0s9G8z/qO9wfTXOXNvg1Dg75mvKznl2I+i7N68gN0vEyU5fSCb4fZQ2Wt2ic4x6zlDcslRtRwo5wU+p9hoXAr3FT430KvazC0Z6zOMnjmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783624990; c=relaxed/relaxed;
	bh=bVq923fN3xICcTFI/CD38blZ0rxbZHjRTcEK6CjQmAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXnXkjYKbbbLWfjPMO8ae2b0cnfy+y3b6QtDAvjNAfKuw2c0S/OVMWA/xvGu0qCE9dAYWDqvUBvMg9DizWP/MhhD0vlX5Qo8eYU13Jkqvxi62o9EfJ/XvcYC6PzBieGe0cfTAmv3tH8jfIl4K9hfqezYrhNOH5vAKjJ1GL0JvZKW+ny6B1W4dJDl0lGUyltpPNcBBvazdH8+Bd8EPjNgBPzS1IcwRGI9qX0jsK1bmaxxKXHjPLnLA9CZflolpEzzJebhcrHL3GTMErTK6h0o7Lcog3oC6n+2M+qMp/RBCoFFwrR1GKAfn5AheQg1fHCVDSyivEwnZe1XLeWARwV4KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UtLJ5d9N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UtLJ5d9N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx4cY5XBqz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 05:23:08 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso1654135ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783624986; x=1784229786; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bVq923fN3xICcTFI/CD38blZ0rxbZHjRTcEK6CjQmAw=;
        b=UtLJ5d9NedHGOazE62mnOsRNnp7vXLSsNLar/s8syllPpLY+GwrrmQzHm/gDmjCjj9
         QPH0il1haMHzRHrHXQc3ksr5mMOtuMN74MfzbgVeItU5N/bxRf5DWN9XelvHHi2wFO8j
         InB5grFzpgDXyM5gItwAynMXktbOCHF/9gU940wSkWrEV0vs7G3lhHA4p/GoiTSx3qTQ
         1pnenbzFIm0s7hhb7QlOGAGLzpoMKGURwjr+WLrVvMFesKCBxjrklhmFUho5oUx9uDz/
         n2ZHVjboAnNbj0sZNNFbYMFS+X/9vPDQFjIqqZoekH1/2qp9FJvFheFtE4MSi+q6uBkA
         Y6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624986; x=1784229786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVq923fN3xICcTFI/CD38blZ0rxbZHjRTcEK6CjQmAw=;
        b=KJojqCfJFEwL9CiPfBwX+WqoR49IG/c638NY0CGGiewkTJWQ0flXGHwUTiyQ6gozvm
         pP2o8ytuD+5UFM+l5tyzNOkZb02lbJvRhHR+icUEjCTLUSJIFckfaOCPh6M1Zx8PNon+
         gNTjxnZV5/0HIu23L2j7CCH0EZ8a/fNcEFwreZWJ7LEpXCGCxjufGs4Hz0JNHOMLSieB
         RlJgRO3iVnpyWos95qd+i7enpSiBEODamDpog+MXd6UiK/quJ+nTpq3OY2vAuliIegxh
         jB0DmBeGTqHUsWRLVdepNi1AX1reZ7EZzmhVDb7EgZ4TX4atdn+SJEKywq2Q52jM3LmC
         jLWw==
X-Forwarded-Encrypted: i=1; AHgh+RpU/jbalW/mgJDytiYmy+uKPbEJ5DqBkuaqc9ahfzqP+zM0eURWyv4c4TyD7eRpV/w8XbrWxVftD4lyAfk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx2HOEfLMKEpt+sgMqP2vl1U+itcorKAG7H/mqfxrZQVSrrs03f
	jOmDEgf6yZNasXCP5WEG28c9EDPDKv/MJJ6fxhKwgAxaLs6kbDYGkiC6
X-Gm-Gg: AfdE7cm4QSdZbLknjZVPsjMA5a1BH25G7Z+imUEHjKbsOH7jwZfrGKyzB0XVcgOQnR0
	B63d+swonI/Wr1XgBxBRc2Ax8ETLEjlWEjE7TbwJqD5CCMZlk4U4Dm1ySU7CmVXPV+6yNSoGHdR
	6/j5gXQUA6quu7zdFnCIfJ5OBX3ICxnHyfcdklYDVB9FeGbRZ72MsI8RSKLpwjJ4JmWIS6ysHAc
	BkY1R0CQhJpFCf4WzKxL6o1gVVHYFsfRzpsC6IYA8dFapvMVptN5sLeZhw/+4tUPByscuS1LxyV
	WU41MIaT5VoBECgGFT2vQ6xfLtocyxou6BCx9ovL+7fM8d9qlLFOT3sEIB0r3ncIJVthaJhf8Ge
	FNuuBMjagux4QoOWU02nz+JS02nCh04ZjRmrw9UbwgrdCsKzgmieO1hMwHSLzFh86myhvbGG6/w
	2Ok5lHfjxV+IpgZ5sAYdoDmy8P7ifxg6dfoD2GosXlEHN3QLsR4iz1j9OWbh5K
X-Received: by 2002:a05:6a21:6e8f:b0:3b3:1951:489b with SMTP id adf61e73a8af0-3c0bcbc046bmr10368851637.45.1783624986079;
        Thu, 09 Jul 2026 12:23:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm29005934eec.14.2026.07.09.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:23:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:52:35 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 12/18] ptrace, treewide: Rename
 ptrace_report_syscall_entry() to ptrace_report_syscall_permit_entry()
Message-ID: <ak_0g7JaD9Z_ApYe@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.280015701@kernel.org>
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
In-Reply-To: <20260707190254.280015701@kernel.org>

On Tue, Jul 07, 2026 at 09:06:44PM +0200, Thomas Gleixner wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
> 
> Rename the function so the purpose is clear and make the return type bool.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Brian Cain <bcain@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> ---
>  arch/alpha/kernel/ptrace.c      |    2 +-
>  arch/arc/kernel/ptrace.c        |    2 +-
>  arch/arm/kernel/ptrace.c        |    2 +-
>  arch/arm64/kernel/ptrace.c      |    2 +-
>  arch/csky/kernel/ptrace.c       |    2 +-
>  arch/hexagon/kernel/traps.c     |    2 +-
>  arch/m68k/kernel/ptrace.c       |    2 +-
>  arch/microblaze/kernel/ptrace.c |    2 +-
>  arch/mips/kernel/ptrace.c       |    2 +-
>  arch/nios2/kernel/ptrace.c      |    2 +-
>  arch/openrisc/kernel/ptrace.c   |    2 +-
>  arch/parisc/kernel/ptrace.c     |   10 ++++------
>  arch/sh/kernel/ptrace_32.c      |    2 +-
>  arch/sparc/kernel/ptrace_32.c   |    2 +-
>  arch/sparc/kernel/ptrace_64.c   |    2 +-
>  arch/um/kernel/ptrace.c         |    2 +-
>  arch/xtensa/kernel/ptrace.c     |    2 +-
>  include/asm-generic/syscall.h   |    4 ++--
>  include/linux/entry-common.h    |   25 ++++++++++++-------------
>  include/linux/ptrace.h          |   13 ++++++-------
>  20 files changed, 40 insertions(+), 44 deletions(-)
> 
[...]
> --- a/arch/parisc/kernel/ptrace.c
> +++ b/arch/parisc/kernel/ptrace.c
> @@ -326,7 +326,7 @@ long compat_arch_ptrace(struct task_stru
>  long do_syscall_trace_enter(struct pt_regs *regs)
>  {
>  	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
> -		int rc = ptrace_report_syscall_entry(regs);
> +		bool permit = ptrace_report_syscall_permit_entry(regs);
>  
>  		/*
>  		 * As tracesys_next does not set %r28 to -ENOSYS
> @@ -334,12 +334,10 @@ long do_syscall_trace_enter(struct pt_re
>  		 */
>  		regs->gr[28] = -ENOSYS;
>  
> -		if (rc) {
> +		if (!permit) {
>  			/*
> -			 * A nonzero return code from
> -			 * ptrace_report_syscall_entry() tells us
> -			 * to prevent the syscall execution.  Skip
> -			 * the syscall call and the syscall restart handling.
> +			 * Skip the syscall call and the syscall restart
> +			 * handling.
Hey Thomas,

This comment `syscall call` sounds a bit weird.

Apart from this, Everything looks good.

Regards,
Mukesh

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

