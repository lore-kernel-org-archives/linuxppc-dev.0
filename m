Return-Path: <linuxppc-dev+bounces-23954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46236C44506
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:40:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3gB6DJMz2xYg;
	Fri, 10 Jul 2026 04:40:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783622422;
	cv=none; b=QAR4uOzRW9QSRtr5Ln/KO0CObELUqyE8YX0KzbejlnJ6Qtvb2uk3RddYmzwq8WFqOkExFUqyio2Ra70QbYdqRWttgk2KqkWt05EQeyKeIA5U3Zd9SoNpDe/M7ASiUI0J//RQTNO/za7OUaqwuRTOKGWoGfoIxgKTpUAZu2IwJvgd4O9fe9tJR7kw59gFC4l6OgA2gmgK3xOCb8htzn7+HQaKkmEQo8O2j4nR/L4sKA6aJJCiax/KB1XUoYw07HIoyJgfodW4gxUDU/iQlHZd5h5Hl6BKpGcsuQilFlBhElU4RuXG4fYwd/6fcpiMqTcmQncF1b8ntmnKxM3DhspRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783622422; c=relaxed/relaxed;
	bh=v3NWG3nzWzn0lD5brSEphHHDIxNRitNNFv0e1po41sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmtMdfznveYAXwoM1IP/nDBoi1n6TTlmfEHnL6iupSsO03ylJTNPwaWtQLDKBQv8Lfey/MKP8OHnd4vMboemw3H3c4e8rl7cDsjxhm1CxDebQIuAXhnl6BVUpJFWeI6vP/N6fvX6NZy0t7TwBYlzLZ5W2BG807IOmLE/wHsr3qAWtyKiZr5+/Dwds4BjLewrSx+xQouDaahlsaH+sDUe0x17jfdBWlzvUug6I3+CFtgB3l72tC2Mf25ZS974h0uKtCbAaiAZ2OaZPqnaiY0KEGJWATlxhOFV5KvyJseA6RqCGzlxYRT8xc3PA3XMNnTp/MBFFD2j8bSLbLLyBQsYSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ungk5qkb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ungk5qkb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3g95lLcz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:40:21 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-84861fc51a5so91946b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622419; x=1784227219; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3NWG3nzWzn0lD5brSEphHHDIxNRitNNFv0e1po41sA=;
        b=Ungk5qkbw8eERD3KLaA31PUPBXW6yI11vdNt0/s1nwQ+uklNuVGpoFQY21SL2ZmFqs
         DervN7oDpujDJ8qGhb63TG6EjfQMwEdM7IOlpwPR0W0O3408k6saVYbrCyGpU5sZULV2
         rpWHAE2pRyj2Z5uxTeJacf+CMuj+chb2i56b5MQ+GVhCmeWAPFGhE8QzGXT9YsPhg/OA
         Ra7NLbOQOL49KGTYJpSiLlJoO9C98pru46swaYmCF6s66ia0IfcX9Ehm423IMyHG31zo
         nEX/l0ZgO6CYqz7c35aua+M4SjFuVmgX+B7rUH4+xM9aWD/iPahTefRNCNFEqBy4lIlG
         +Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622419; x=1784227219;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3NWG3nzWzn0lD5brSEphHHDIxNRitNNFv0e1po41sA=;
        b=nkot7plN6mX2BKjybI3g//Mmxk1czMOth2gTNCyFkOWgIR2kgzThUbo8n+m12qQYsE
         qxomDHcIld/XOL8Le3Z9BlVNF4Wd65UMgfIpvKspUBR3LAQ7Ra6ouaO9pDsF7zyAc5IM
         A8c5X6GtpzvXInZibuWnrtHR1hdx5CBMxwY8PYmDBbPIXHJp4lTBm632HNUxn3mVVJGm
         DR3xTK0MUEM7U1pzbUFRtmWF2PIeO1jkYtNq3ptl5YrCrYoYINdmZ33c3q8/ljf0XiVr
         e1byBhuLD/xfzBZ2TmNpuDVBW2pf3SU0b7QXdAtgoNZGTOxr4yn/lulV/dBFjyQFiSYt
         +ImA==
X-Forwarded-Encrypted: i=1; AHgh+RrUdqnC64BK8MY/ndo8oz1f0cH7QtsWigWftqMA3uIY16PsKSFfqcX/GMCEwh8qSZsQ7HzKNKwBJ9YP9z4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwaGBOnmD6aDJOtliNQmouqwQyltzLeWLLrcyUsKfHnkr+fdVs8
	XflziZeBen2plu2p2qQ4DVQCFnqJvviifp7K849sAisaUKff4rF+dQjE
X-Gm-Gg: AfdE7ckLOu8w1hbDglqPJlN91vuUAd+8S+7e3XjW9VOvSdxGnPkoH9hWUNCfznD454k
	LS5F+T/6SHXRO58Ospn+uTCQd6Y8yj7I99f0hK6bP/UJ3tXhNkgmhoRjxE3CRDxDFCgD7bzFrtT
	ZuGcDH32jgdrYnJPvVc65/OUnb5NWRj2YjWSWLyYeuoov/oBvyGbDN4pn/hAolaePJUIRQ1pnPU
	cqFMLlknfZ1BUovGD3x5f/P5Ed8J13PYZPobNgD/qPz2s1+LYyHp/6OAq4rSoGGoSAqHFdu2SgE
	kTUUYpRyLrgEa/D1wt0Yr/Hbk4ZeIQA4z41TOfgQA/tnP0mp/+3t7n0dIgRghWhZ7rZQSSDGR/d
	RvR0oBCgT6MyCCTxE9J3gn98FhuT8NCtemV9K7bf8uEfM4ZKm8fefZ4I7Afy8jpszkjpY/FfdJD
	H40l7amF6LhH2ZpXJI2WdFPXm+/rWBPQYyr3RRUKUYapZXsdblbs8+p+6I4cO1
X-Received: by 2002:a05:6a21:4902:b0:3b4:8300:7019 with SMTP id adf61e73a8af0-3c0bcf656a1mr10343651637.18.1783622418932;
        Thu, 09 Jul 2026 11:40:18 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm28653518eec.14.2026.07.09.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:40:18 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:10:01 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
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
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_q9qWuifFdo_9S@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.865955911@kernel.org>
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
In-Reply-To: <20260707190253.865955911@kernel.org>

On Tue, Jul 07, 2026 at 09:06:11PM +0200, Thomas Gleixner wrote:
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
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
>  arch/loongarch/kernel/syscall.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -11,7 +11,6 @@
>  #include <linux/linkage.h>
>  #include <linux/nospec.h>
>  #include <linux/objtool.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
>  #include <linux/unistd.h>
>  
> @@ -70,9 +69,7 @@ void noinstr __no_stack_protector do_sys
>  	regs->orig_a0 = regs->regs[4];
>  	regs->regs[4] = -ENOSYS;
>  
> -	nr = syscall_enter_from_user_mode(regs, nr);
> -
> -	add_random_kstack_offset();
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
>  
>  	if (nr < NR_syscalls) {
>  		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
> 
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

