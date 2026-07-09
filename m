Return-Path: <linuxppc-dev+bounces-23960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CF8C44506
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:51:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3vf4y8hz2xrC;
	Fri, 10 Jul 2026 04:51:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783623070;
	cv=none; b=oEY1WYVIrGY43q7rkqb3ugCC8zT/kj/cKmdleFfz+LTFLw4iSFzwICCYgxh0Ud6WP8Cx5ZB2IulZ1yoYX2WdRLTQj33V16YRd2oBk2D5uywFkWrrBvuCs+3RPV79U2HStWTiolkIYMuGi3yPF5EZX5rbWn+5wKg/oG4viVWb7JgqZ5rPIQGjFkipAMY7vpiWgIqfi6p3zxMC9L5cca5gCxgR9ts9+Q3XGhsixelz42WgYUVUnWAsfRKaV0sADKhHE+uvzAFLyK+qf//GlbXODpskpaBOQhXRWZffIljFzWRP8hD+0o0m4COvXeEs3taAwIRab86QtT60x/CmW+W4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783623070; c=relaxed/relaxed;
	bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+fTChvt2srR1TXfxEtexkesxzLxTr+hxj0ND/s+YXlqfzP9SMHwbmHi9TRTAD07/iwzwRk95wX6Z30ODs84tzLfd7L5Liw/EkTx0y69z4ZbqJ3Hh21+oM9VpN4IEe3ZB/iP6Nn0RUXF9tkK56xX7HH/X6JQcNOhDhnQGn7DomBMNrzlM3HAVP/7ss/5+9Rk3NZw//+3brF+b8IIPNU5IamsRJR5m4JtJajs+If7vQebABQez+MJYys11ZJkAdZ1VBcAkFQs/6e9yKTxXatUVcGXfSu0jcjxlfCc/P+F9cNn45WouOFreCnZsBtfFqOuDWgxVzomlVsDuY3RTpYcWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TqBVFLzJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TqBVFLzJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3vd6MRWz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:51:08 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-388b404ea89so195425a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783623067; x=1784227867; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
        b=TqBVFLzJJzRbEjK4jCwypHcTM8U4RCEqoFqynhnTDblMXx5GZPkxYw+1/wHa9R9Usp
         l/+ZbV48q3l8X2D6CBW7aoRZ6D2MAfTY5H/nDKynwOHdigMYq16cAqgo6KFz/0lSRWkl
         kexDUMg4Y+y0NOBgjLAPbj68m/DtAc+XvhIRU3vlYCF/CxWailQknAd/qIwmbBHh7L/X
         y8ZWEYBuKQy6+lumad3mSFxEcesQ7po467cvXRnJ1wn9psXcSxtwNJvrXWrKIw5q6WK0
         +DCrecZw2jHSt2Fk9t0JdTl4V86RDIO4bAJ2IMBEIQRg5x0vepUWwywU8My3dzAvIdkN
         RV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623067; x=1784227867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
        b=juF5Jt8D5oD5JhiS9NYUjkxfpaMyKXq0c4N2xoPTnf4FNR7w6jvEKqpxBmfOZmzy+Z
         Uwa2YRVXkDYWDLWoHsVCp8zN3lCnnJZ4GXvnjce616w9ZnjfvZg6hbYptiR0OE6C3I1P
         emC48nlIlVwZt2r1NXHwErXFI1wWr0o1fu3/PqsUDopcNvBzQzZhuWWICASsCBeyFiVi
         +RJ3S/IgFF57GHruM57dMoWOGXu0volF4eExopkYoUCE+LIyongk2AYyksU6pl8x/wf7
         YmVJZ3w3RVYWcSFcKXh+hFCiIWl+zBFFoN1cLTouVzua4BNJ2KuaVkZpHB4cv+gTZXDn
         Z02Q==
X-Forwarded-Encrypted: i=1; AHgh+RqM9lfeckZLGvIv2bb2uCNbjWhaanRIwci14xM716d4CJdqiAD/JDjhK/tanVEPmzLKtH5CkT9hnmnYb6g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKsn12TY/B2lohHbmuQmJVYscr7yCDcz/ZS4Mi0pCDTjVEWglc
	SAFXl+nVUXfWlJBKo/Rd6fIO5ZtrrBh4ksPxiuBNv6NXY2v2nQDe4u9T
X-Gm-Gg: AfdE7clbnPHPZMksFTyI0imMhV4c5Gi5ju5v/Ox2vhIhXqVWZXkiArDQ/wqmUrrspC0
	9O57KApX8t/Bz9Bg5KR93hD8bNLqD5KjaJRVoCIt05goZi2D7GI1BRdD42OgOw0SKOPHmreb0x7
	wdQtQqPJpwKAYQ44LJjGMDO/Dj37GPRlbm8PdjH57h7q5ut6Dm+2AeBea9MjnBNBPCAjtGvcAz1
	EBtCNutESiI3TWwD0g2nSrWhodzx9C+J7HiYXljLkdkkH8fuU+kUEU2Dtve/piEp9ikc0urFsQX
	VjsrBpfokkT1ba2Q8P3cNM1SVReWmu8B7ZxxFYfb4DzDTK0Y0EOL9PmGn5LFOvPL3uTEByz5EaC
	prpB6UJVZD28f5TWCS28Is1pQd7CDm7JIriNRoLKapZWevH0uNOnahQdrt75kSCIdmRBnrMbvTR
	rDaId1n3IZMkgemQBie6xv6W9DkcWJWcNzEI5Layrx+JzY19N+FSqpSgvHN8R0
X-Received: by 2002:a17:90b:3d86:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38d15876f4amr425299a91.15.1783623066680;
        Thu, 09 Jul 2026 11:51:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm33415688eec.2.2026.07.09.11.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:51:05 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:20:46 +0530
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
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Message-ID: <ak_tgBEhNxX5m700@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.181086755@kernel.org>
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
In-Reply-To: <20260707190254.181086755@kernel.org>

On Tue, Jul 07, 2026 at 09:06:36PM +0200, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -70,9 +70,10 @@ static inline void syscall_enter_audit(s
>  	}
>  }
>  
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work)
> +static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
> +						long syscall)
>  {
> -	long syscall, ret = 0;
> +	long ret = 0;
>  
>  	/*
>  	 * Handle Syscall User Dispatch.  This must comes first, since
> @@ -90,7 +91,7 @@ static __always_inline long syscall_trac
>  	 * through hrtimer_interrupt().
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall_get_nr(current, regs));
> +		rseq_syscall_enter_work(syscall);
>  
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
> @@ -145,7 +146,7 @@ static __always_inline long syscall_ente
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
>  	if (work & SYSCALL_WORK_ENTER)
> -		syscall = syscall_trace_enter(regs, work);
> +		syscall = syscall_trace_enter(regs, work, syscall);
>  
>  	return syscall;
>  }
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

