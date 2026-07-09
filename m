Return-Path: <linuxppc-dev+bounces-23957-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2E1C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3lH3ncqz2yYK;
	Fri, 10 Jul 2026 04:43:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783622635;
	cv=none; b=KqI3nS+wbtBblxzB+Kf9i8Db8TBhF78StG5BrcwEd6YAWMpisevIr8LfqhJp3X30Y0dzeOkr+LG3rBx/iBFIcFAMkYbv9t5XwBpwnTrqwgbqHv04gIVZZSL1Aazb9GZHaaEV5/bwFGY2lxUw7czAk74vKBqHZ1QdxLBGUQcBUACw74VILrg886XJqAEy4StG5tdnjLjoZq9rr8+uLwft5uUloEy0bqqekSbmfgoLhVsCfPtnOZXqR0ElMJisuL+bVi8IBAJ0ScSEyO2NUc6qLeaRWdq7CqLqmm19VkbY2azrRnyI1caOD2eagqz219WRSOQFcV+z3gsJONxpK/hguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783622635; c=relaxed/relaxed;
	bh=0SnVDTLPnMBjkQSM4oCN+URozdUIH28ywJdKUrWn7bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MALyhA/0sE5qThW34Kyn6YF9ZnqdD4EL1ySW9OOCv/XJjraom6XKFNxf79YMvLaQPUrBk1i57+Atd05GDQIg0qZa5Xd/SOupXAXuIpE/AjUoSxoCRy7A/wwVUPGUqLWYnAd2BAf0KzPHZz/x8TDCTsWGLIy9d1LTVBOUspKFCc0vXCHdmbR0CIrf/o92jAlZo/4ogwQLk15zYb73wOMGQMOgKtUFaKXSQ5s5D7g7kW1VKJJBgK8BtKhLZTJOyFHD7k9sOcPhG6STtwWf2So57P6NOEuu8thE2EJLraKFxkJosr1muqHSo4itpvPJoLYG1oN4yIpBgZF5+PYL62Pweg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGQtTveQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGQtTveQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3lG4Hqzz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:43:54 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so227086a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622632; x=1784227432; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0SnVDTLPnMBjkQSM4oCN+URozdUIH28ywJdKUrWn7bI=;
        b=BGQtTveQbi+1M94wNAQdFWWoA3LXt2eINLPNy02HQ1jgC/UMrFYyqqkmaREMrUaqou
         iklVUbqmKQ/4yJO3fH+2atTSf+2hYXsT8BTdsdzXglXGZgCzxO2iCtQTQ6ePHxTZtLP9
         CTiCGJSreKmQ/Z6Al1PGx5JdsgodZmWfApmsd9T3LYkMj69XbsOl7r6YCmlq3h449DT9
         OcntXGHhjheKwpR1OqXQcV46a7H+eMciaozbDbUzzXcb9hkHdT/58b0axwdb6Q/m1KJl
         cG0M9XNrRhC/FH34A3Bgauc+FYhYc1fVxJptjHT7BYNj1Npi160SZeTOXjMO7pBO0nZG
         RtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622632; x=1784227432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SnVDTLPnMBjkQSM4oCN+URozdUIH28ywJdKUrWn7bI=;
        b=VS9CriWtU98kC+fq4gIviN1iqLur0TbNDx+OMKmlPqcEXL4NL17y+h/OnoFSAw6V7R
         Gp1/eNc1kmH2bnbDanwkzZFflg445m9JOD4Ta5gb6K06IthMNNJhfYL2RbGa71N3Oi3n
         6+mVigcf/X4ZxVNZgOvamgQGDb2ka97R7qW5RxsxwdHPyoPU9Ys8fhZpio1QPHGuAl8p
         7BW4Nj7MamiASlnpOaiKqNmkmSQYJfHwSI+92vGAxCTP+iEX4cktF/NxL58ttBqtPcZ9
         A0N+StCXmDGWQRg+h9tbKcBCSwo5C8HHEInEJDxuIZVC6AYgBgjVLuywAr4TCRJNZtz5
         ehDg==
X-Forwarded-Encrypted: i=1; AHgh+RrsYgalO/pvZk1Hm8EbG/1FXooFr6F87sQEXCBuadhhiijkDDyiIkR7cIVmNWCknw6cLKnoWOpAg8H/hg8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yznxt7oZ9Rmjl3OjwD1KBKUrk+3TsxiY36cXg6pd/I0bQmQvAdk
	NAySV/q+2gypi58EkS+Uv8l8JHi8tV56IzzhNw2vBiifGQoKFmgMIxNz
X-Gm-Gg: AfdE7cmHK9VmdxTNYx9dCE/i3uVoK7qCPopNegSFBtu6XrCtnwERzCqu3fUDv1kYUc9
	cBuS8OwPAeOrNhNUkGxdd0aMDudzLHbE3TyiOPXqJLMkcQQlJoGixHGioQaCn3EhASug0VJWQBH
	ONKhB/3MnxWGW7VPPZQ99yuQ56bmFQQs6gOfUwqrkSM16a682vBT3/K+tR5DIID5cT7o/j8fJi3
	Aimly1yia58uVnCFoJ3+m2HC4A3OjWnBe3+aCBR7mQr+7sbr5Er7ZTrOBKj5c2wqi3IO/OCOt61
	48rj6XRM/llVlEFkTPDJ3rQSRSACNj2pGsT7G8YyqImcGHcf/KdF+0DklxcMWOQqt7lNMjmaK24
	Gt9is8jk03O6S8QGcX4T4OE8DG+WnOK3lIYDg1NqE3SwKv0YhoAMClvU+IA/qfVPgmObhIWiCf4
	ss3HWEMizqA1Ddxhpyp5q8551Rco3lSps/QvOMjUzgO1fIKawsr3CuqiAujK85
X-Received: by 2002:a17:90b:564d:b0:387:e0db:3d90 with SMTP id 98e67ed59e1d1-38943d404dfmr8538131a91.43.1783622632431;
        Thu, 09 Jul 2026 11:43:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm35673867eec.30.2026.07.09.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:43:52 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:13:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, x86@kernel.org, 
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
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
Message-ID: <ak_rx2gFCLtG-Qpy@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.030598804@kernel.org>
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
In-Reply-To: <20260707190254.030598804@kernel.org>

On Tue, Jul 07, 2026 at 09:06:23PM +0200, Thomas Gleixner wrote:
> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
> the subsequent invocation of add_random_kstack_offset_irqsoff().
> 
> As a bonus this avoids the overhead of get/put_cpu_var() in
> add_random_kstack_offset().
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/syscall.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>  {
>  	unsigned long nr;
>  
> -	enter_from_user_mode(regs);
> -	add_random_kstack_offset();
> +	enter_from_user_mode_randomize_stack(regs);
> +
>  	regs->psw = get_lowcore()->svc_old_psw;
>  	regs->int_code = get_lowcore()->svc_int_code;
>  	update_timer_sys();
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

