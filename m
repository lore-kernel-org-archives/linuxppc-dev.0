Return-Path: <linuxppc-dev+bounces-23956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E7AC44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:42:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3jy0X3Xz2yS0;
	Fri, 10 Jul 2026 04:42:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783622566;
	cv=none; b=Nnh5fMpN+v1Pl0y63Mlr6rxRbeTJ4+yBWGMryfs8EM8SBg0Re2WNCOeEUgDayTQ0a3QCWYH/ATc4a1LavfhNiz/CTasXRCOYPSP85vq16nnbMTVuaxT0sGXa2dHWb5WuHz4133oJoECOEaQ9SCAQKol5FJRRFBmY3hEKSDroDTj8k4oi1W6PnO72tcxpZ/J8PJzgnmE/Rc4qWgrc2NEv4Xz8SMwhx8jjUgd+RZs8gMg8MBz34EtguG+BU9CjL6snCyf+d9xxBsSJ2ASQ5rBUfSZj3fTyJT+pP73QfFiAfaYLLNqViq6tbAeEP8Kg6fOUMHezSHCbtTY+9uin+FfDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783622566; c=relaxed/relaxed;
	bh=SzGAEyDF8npliwHJTsZ1x6gPZlMpJ+A+8igDYDtce2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOGv+wZ0X3dSuWUUXJMxTyOayYVa8KMidae1yyNbDNXADPjVsb6/xwSgCYCNB3BbPsF6kkVIezjZsNKxjjBktaO+RlVVu/FV0DhoW3Z/d6dc5FH1ps6JNYZ+9QgI3CNtD8GgDoUAlD7KtoFhcZ06F3QX4aLGsmF4u8BezR1fsGRBjFEK0ccgtX/b/adT96y8xvTdvxHZmb5+iPF4UlY7HhEgxIABh/cZSq1T7PiWpxRf3ac9dgryJb1DWDEMoLC0DFkAX2e62G4HYi9q4fkBd3NVkmStcpbIY6rzZqcY/8FLltpOIBY4nJk/LQfOQNSrb5U9dgelons6+QzDVYmb0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Om1y60J0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Om1y60J0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3jx2tPNz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:42:45 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c999f162c9aso92183a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622563; x=1784227363; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzGAEyDF8npliwHJTsZ1x6gPZlMpJ+A+8igDYDtce2g=;
        b=Om1y60J0/m8fyjcwP8CZYKfDas3w/e4IsLpJSxd7b5X+KAcTtb1CQdXkRCVD8LwZrx
         Fm+BOgToNtTWCqR+bAdzDy996cOvYFwWKQTfb6PC1OcbJxBvmKdqVP4UBNt/oGvuXF28
         ylca1X12bPibe37zBZVU35vQoHjdNeU53kaNLNQfCPG1PnGZdmlkG/uDWmihB9FgN9kU
         P/hIjEAAjugGwIfvSbEQFrsTsJd0GEEh6n7uTUZsx9+tSDN+dTV3kQfbLB6W3lRg/jq2
         W+5MVJyXzdgY5yaZB6N88vZdoQFydiUHM4iwu0gIpGj9Cy/CexjqL0dmghqfBAGyilOQ
         3A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622563; x=1784227363;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzGAEyDF8npliwHJTsZ1x6gPZlMpJ+A+8igDYDtce2g=;
        b=T47sUtZKDbJ4DjXR05+Sm7YG0VWzzQQ4OfthzB+bAsEz09RCcBOpYInP+necGfC8+A
         aCkVhgrDxDR1k+bMbM+NFEE7GMWoTCjFwiXkRRLa1ul1N9OIh6X9icQr/UFcuT5ycdsT
         2zqcsSarK0aZrMhCXeZ2T/olze+HW7WJGUAxEqwOdOmclQV8b3HFVb/CPclrnkVBaRs5
         sl8MLilZW6aTpCHc6QZI48IcGK7349mP/w10BGZUMWln2eyQy2BSpR1JF1J/XNiYp7Aa
         /qpCjd6R31NLOpgkoMw1Pdzm0jVrWxyfzwgA1UdPNbZXoyOvBsAg+dem6HgjX7l8pIZa
         9xkw==
X-Forwarded-Encrypted: i=1; AHgh+RrTNISE5mjwlseMhYUQMchb4GKbNJwap+gvZWJL5LXZLkoe4cg6RKDKH/3nVyDoEjccFVyct8+M1jgPN5I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxPY6ETeIZCd9a1kRi/Hl4KNu8TyHepXJso4jfrrEpkb0KgPA2R
	TW9rgBWu3R49Lhi8J14EEzQL7vLLnD4v5aDkwXBdipiP02F/fRK/0lcg
X-Gm-Gg: AfdE7clEznoJaML8sI+nUY9du790CP2FnXuLT/vt/3w+w9aeCoAoX1UeGwMc6MH2jMR
	/iDhYitnRiCL+WR2kH5Yat/BNHg0Pk7LyM9FVzcQ7sIrYwv49rAkJYjalW5259KVXeZYxOPGOYV
	nFdcgENYf4AdOWthMnZuQtbzHEEiQ3dhHtHBBRltQ+s5FyUw5v7d6v0Mnnmoke6uFUjioxmbhcr
	z+S7MWnXDBfKTXPm0iLm4ZUK9ico1Y7MLNT7VL+tlREmjt/5W09zf44PbtWDF4hh4Et5VfjtYv8
	ilF3pOibBxaB0jlSwniZmoWUGp/PNRwl8m3ZjAtkMeU5HIxUDtDU+KIuMbdxxnRrOwUK9renfF9
	2IjwV8/y3Xc+UKA4aEPjpSCvpwDv8ZzqGH6dIyTibwbOm5BUK6JXSpvP12oJdqrfT5I8RZ76Ihy
	VLM9gHaxLbjslnER9ATkGTNThRtnD51r44jxd34iQXm4PBo2HMs0oidaMwgF/U
X-Received: by 2002:a05:6a21:682:b0:3bf:b50f:71bb with SMTP id adf61e73a8af0-3c0bc9acb33mr9806931637.27.1783622563297;
        Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm19491362eec.17.2026.07.09.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:42:42 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:12:23 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, 
	Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_rfwwd1OtaQxka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.974626922@kernel.org>
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
In-Reply-To: <20260707190253.974626922@kernel.org>

On Tue, Jul 07, 2026 at 09:06:19PM +0200, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/kernel/traps.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -7,7 +7,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/irqflags.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
>  
>  		riscv_v_vstate_discard(regs);
>  
> -		syscall = syscall_enter_from_user_mode(regs, syscall);
> -
> -		add_random_kstack_offset();
> +		syscall = syscall_enter_from_user_mode_randomize_stack(regs, syscall);
>  
>  		if (syscall >= 0 && syscall < NR_syscalls) {
>  			syscall = array_index_nospec(syscall, NR_syscalls);
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

