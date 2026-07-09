Return-Path: <linuxppc-dev+bounces-23966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33554C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 19:36:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx4wJ36p4z2xJT;
	Fri, 10 Jul 2026 05:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783625808;
	cv=none; b=RX39Z2asganJeowdsryZPu9YjIGq/XvD9ds9Lro+0FB4EEAqnKKrlSBvdLmzX7EYlghFsUk6dPn4btPuLWVG31YgdhZE7QXRTTOuKkZ+teZ89RLpZ+/4VXNghT9HjWFOEMJFDjXrOsDajtk7dFwvjGobB9ekSXWLv59MLAD3JHAmWD8q9h8MRFZ72+ZHkLkm4+H0W5jt8kWKNg+ot0HMmgVH66JHKkz3edDcwNWO5a4THrB58JTJna+vovJoVsE+DRoBpVXqrOHm4jw5mZpJ8utX6dWi/EtRsfyQyXJLqTQtd3mzsxRMJSgF5YPcgBD/A6nMwStMkeKAA5ELr87Pyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783625808; c=relaxed/relaxed;
	bh=9elVVpqR9aiL0byPjRlVnER0ZdQgMR4U6A5Xm6QA3+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clS2JhSr2jkXr5ufkFfFtwEq0ct8nuUf1h0uc+RWk1gp4AESorcPfPIke7UQiyEU2AdDezN9k9a9svqZ1dgbpDxp9MCv2Afi6jl+etbaacQNXpYHKLGzg3UGG3aLv+aTC+FAD2yDiQNt2vkoCdTcvCIadKzgHuUP3gsKjGpDH7LW/Oa9kSGDKXSFVt7k1R1+oNhl4L/2xJ4/liUSsdG6EEWJ0qYXLYoup5V3mF5MNJXzaBqFXyxBXliuJGRfOOGi3mMXw9GqgfFqWKzDkLsb65z0un6Ibinqvp5zDxO/6E4Fdag+Fgo6+Q96tRjeocI2YIwTaJdCB1wPUoS3SDpycw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YAHUHo6B; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YAHUHo6B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx4wG4Yrmz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 05:36:46 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-382ef647e20so318608a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625804; x=1784230604; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9elVVpqR9aiL0byPjRlVnER0ZdQgMR4U6A5Xm6QA3+4=;
        b=YAHUHo6BfqDc1s0QBNdu0MF8OpnKR7rpYYLoTONHslEkR4de4Q2Mnkn77STe4ihJeT
         JoguS1DeBFyWCeZKwrYerBDTwZkbQsfYyENbDw7ROHs0h3iq5LqLTwVOBMdhdd/UJqSm
         oBmKXXGdivXQ/riZICs1d6NfB+owUDN5X97IAGS7ekGcJMtz96w9eVmpBBwqQVrRKHvx
         Bq+iyrrw9IRmD2CFwPEKEdjJidk6EUt3KJH1J/gR8GcDykm7wKlzbmAkfXiuMB731xCf
         BbGJxTfnLKhs/LulLH/WSyuTxggECOdZeCxrLD4Gcx09+EbMv7tBzxeQ7aWUh5siYTUy
         00xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625804; x=1784230604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9elVVpqR9aiL0byPjRlVnER0ZdQgMR4U6A5Xm6QA3+4=;
        b=BDggteRNoJ/1b+9K7928wRjXRxU4a7I2jG+DGXIHUXSSnT4rhX5vCJ6e+OsOBCWrKk
         a+4cRL/F0B5gMEQOvGG3mV/a++Jm01UCvaculBGKEPjJEaXqvY7OSYsZcxPCb1ahKM1Z
         XeNRw+tfi19wLXmxAW6xanh2CJKa4O2s53oNtCStg/ffT4lVDcr71N8OW9PjtOf/qHo5
         fn5Sqw4Im/M8lv+WTz0g7lij8mRcDKSukyCawHCi0y44S1qyvQYoyP393ykrT7cZmWFQ
         sMfuoKXyqh2VabobdCq82vYAappfnGMWhP2SpQpbtr+x5SWXFWDw70hqpndok8v1ZbUs
         djeQ==
X-Forwarded-Encrypted: i=1; AHgh+RronaNXpoTM58ZRXtNO18TL0Fj8dnro5VwQMoZOQqigkzVJXFlfJSpp0N0NfDsjepuQ+BBawhEkKvxIGlo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxCwmyWEUo+kx9P22aBFwS4KVFPOP2ep3Dj6OYjFXbEAcGsbmgo
	iY7o+H4rXi2MgKl1wDkvq15SVf04ZATd9oDj6cZwYPHTQvghPC84on8j
X-Gm-Gg: AfdE7cnF594XGiQM+IguhS0De3Z2i7VhdY/8AJIbcoB7fbZ5Yw/yybLhy0YSyuCOYOl
	qJZ/rftDoo4pzm+lPG+k1Hgt41samm5xWD4QPG/lKCZTpXcCcS7E6n1NfKs6vuZLkqAeDVuZSHi
	AozK0q8baNV9lLEElqAh0/c66Jx/VPlCcNzw6fSHeMm6FYdQtO5jpDAQjS2r4/nXapHcxT2a9ic
	QFlcTNoElOtU2k1oYmoz+QmB2z5WokNmTwjiYI0qWQLILbci1b041kKvSISFrGnh12Q3t6sevpH
	1bk8sJx9C5CWvlg4iFzGfAL2xchM8U4PP7Xd6HFM0HAKDuJwJwG25qCTZ+LsY6HtAUwtgFBYw5Q
	slyJdQfqBY9Fxnvhbv9mSOgMuSDoL4RnC7qWDaGjclrZm8xV+kOgFHpOSLYcFq93DGIFFRwTLQq
	q4CBHU4iWofRqCtp69p+aWRB/e6BjRTeJYupMB1zhmarvCrYb1Bp46CA0fIY7a
X-Received: by 2002:a05:6a20:430b:b0:3bf:bfe6:ab6e with SMTP id adf61e73a8af0-3c0bcf49b4emr10854965637.6.1783625803970;
        Thu, 09 Jul 2026 12:36:43 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm33007037c88.0.2026.07.09.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:36:42 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:06:23 +0530
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
Subject: Re: [patch 14/18] entry: Make return type of syscall_trace_enter()
 bool
Message-ID: <ak_4LT2HMSi88bA6@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.392010241@kernel.org>
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
In-Reply-To: <20260707190254.392010241@kernel.org>

On Tue, Jul 07, 2026 at 09:06:53PM +0200, Thomas Gleixner wrote:
> This prepares for changing the return types of
> syscall_enter_from_user_mode[_work]() to bool, which in turn separates the
> decision of invoking the syscall from the syscall number, which might have
> been changed in the call by ptrace, seccomp, tracing.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h |   28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -71,8 +71,8 @@ static inline void syscall_enter_audit(s
>  	}
>  }
>  
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
> -						long syscall)
> +static __always_inline bool syscall_trace_enter(struct pt_regs *regs, unsigned long work,
> +						long *syscall)
>  {
>  	/*
>  	 * Handle Syscall User Dispatch.  This must comes first, since
> @@ -81,7 +81,7 @@ static __always_inline long syscall_trac
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
>  		if (syscall_user_dispatch(regs))
> -			return -1L;
> +			return false;
>  	}
>  
>  	/*
> @@ -90,32 +90,32 @@ static __always_inline long syscall_trac
>  	 * through hrtimer_interrupt().
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall);
> +		rseq_syscall_enter_work(*syscall);
>  
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>  		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
>  		    (work & SYSCALL_WORK_SYSCALL_EMU))
> -			return -1L;
> +			return false;
>  	}
>  
>  	/* Do seccomp after ptrace, to catch any tracer changes. */
>  	if (work & SYSCALL_WORK_SECCOMP) {
>  		if (!__seccomp_permit_syscall())
> -			return -1L;
> +			return false;
>  	}
>  
>  	/* Either of the above might have changed the syscall number */
> -	syscall = syscall_get_nr(current, regs);
> +	*syscall = syscall_get_nr(current, regs);
>  
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
> -		if (!trace_syscall_enter(regs, &syscall))
> -			return -1L;
> +		if (!trace_syscall_enter(regs, syscall))
> +			return false;
>  	}
>  
> -	syscall_enter_audit(regs, syscall);
> +	syscall_enter_audit(regs, *syscall);
>  
> -	return syscall;
> +	return true;
>  }
>  
>  /**
> @@ -145,8 +145,10 @@ static __always_inline long syscall_ente
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
> -	if (work & SYSCALL_WORK_ENTER)
> -		syscall = syscall_trace_enter(regs, work, syscall);
> +	if (work & SYSCALL_WORK_ENTER) {
> +		if (!syscall_trace_enter(regs, work, &syscall))
> +			return -1L;
> +	}
>  
>  	return syscall;
>  }
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

