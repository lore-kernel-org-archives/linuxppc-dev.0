Return-Path: <linuxppc-dev+bounces-23967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE939C44506
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 19:43:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx54C1kfYz2xJT;
	Fri, 10 Jul 2026 05:43:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783626219;
	cv=none; b=jd9miI0xQOVMHiDvZ2VthFZLEfRPfLw//EBgbzkgouRzuqqNYxBrIm7i0nVzCj1Zie5n7IFSCasUzFUXwnfLbq2R+yLVMMnkFA6pqs+PFkWOUoxTbEYHgebOK+FsiUBFu6C8RlPGh6wvP6vAE1bIRC3xEInLypUF6pU5rQqILfTpvQo6q8fo63JfNYuat43xEFjWXO9yKNZrhY4pu50HclgWmRiCqDl1cAqcHbKl+lRWuTgtx8/0G4sBhAEkypNnsImxu6UZk2qx/dEjLAoAqL5v94xWtC1O2k/LgVksmkoO39Wd8SDFypfuk2kvgr/k8Y5wTxEatP6Ogovs+cL/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783626219; c=relaxed/relaxed;
	bh=vcViCEZV9Tm/crNMdaH3VAbncnTvlz/mpQaPDKjBGxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw9CgGiraQlAnQyQy3Vv2w3SIFXgHzuhEyPIlxISzOerCZu6OmKMCevkFEMokVzz4oTppsXvlz0oK1uA+Ouvy/BTSmDzuggy8ihSd1hE9QuhuTI3VS7jDQxgQYmw9i4Dz5Elnd/JG5TWYFN1cHo36bQSsbhq3VVsnNcfSxg8NZBanBHq5y1hfp0ftr7kywwOnIRZaxHUshJ3z4sGqzdoBuDo35Vx+ddXdICBPD88rmwqOwGsBZzEWUcI8YfeGL5pUcg86/WVKd2w0/0Ls3g+t9h7/aWplqHZST66zJGmE16Kx1fuvq9OvdvnwMMi623TvcgcHxizU6WE+KyfrlCY5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C2i4VcJB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C2i4VcJB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx54B3HrCz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 05:43:37 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so116911a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626215; x=1784231015; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vcViCEZV9Tm/crNMdaH3VAbncnTvlz/mpQaPDKjBGxQ=;
        b=C2i4VcJBnAgIETdUXkbLxG7e/+wuLDgXUE7VDz+ZVfQCsScV/wOSLjL1RdjC/sWgxu
         GsBDULNNkN2CF9dI1CFEMtSnbym1L2i9p53HK+G6OdrdLNx1AzgqnIsS63t+Bz4RqkiQ
         LZ5FD2w7443TdAygQb2OOycL6ivKlD4TkL2jJVN1Ruyi/txPoNiZ2kkOOl+oScR//HO7
         yRP+NVBfoNlSX03IxVv8jmH4oVul4Yp5XiVFzhkmfceZuY7cMR7IQqjB4PGqjsvP8FRl
         nhdKJj+Jzuxc2O2+HgDkRa0PMCoCUUJ5dDuTcVoTYCZcoHtoJ7Euuox8sg8cHc5olrdz
         BUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626215; x=1784231015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcViCEZV9Tm/crNMdaH3VAbncnTvlz/mpQaPDKjBGxQ=;
        b=Ho3v7vq7Z7kGyw+0IvkFGFVTjO9zBQLyPaya+KXsKCes42f9rA2r4Ra4hGp9k1id4t
         BLUCgYQbS9qn2E/jlzE4BExfi90qxiiGsWOuuNNlp5p0oghzTjYgTSwhDrrUG6Xsbouh
         uJQ7LZgPGUc765U92iJ0gYunXyLE0tMz4klxqbrXg4tZww3rYX39Ki1IpOgsEqVb1olg
         95QvRFUBKUzOWlASyg7BmVq+XtbgO9XSHLwfHbwBO61ONglaXIhV6BVjn8g5mk7eSZ/C
         jaZ/0q+zOVG19/hQR+Blv5Av48jNMWqdmgivLlsBcYvbGpdhKoBEGGH+H9963Fsjy530
         9Y8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpKhPc1VXCphLaAmikAzFXa3W7RLrMP3Qro1wd7Ej8NGeqfajWl2RiGzyN+521CkIlD6hmb4p/OTd7miTo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzSmzuwlwRyGe3W9efgNgNwSX82M449W8gU70N+HfvNixnyy2vY
	PmOEgPqhih2Ev4F3uw/Bg0/bHOVeGZ1+xTUKu5qHX12cCqkq2bEJ1Nek
X-Gm-Gg: AfdE7ckNfcUIiHX9E2mqtqUNbfNKfloF0XeeCiyZRg0E8TAcdNQlDLsTmy42OFcTkgo
	BnUb7dyxsa+Huk8SvwQuIVArR3rOy7SnJ+xiIqjm0N6D0YYA63FRwiUVjWXuNd8rgdX6Ss07uJv
	Ha7uQdC/FM8y422EmtWcsKT2VKsv2szOd3rvnFVMK5WKedmaZyCsIlv3cSPw64wjXtm8ySVGZ6v
	9U/aHS+Yz0MPkcxjQyiAUqPwKFLUUNYWkVuSvgO9FcELtbv93flqYy0bKSNSFo/Q7BuJxccpqLz
	3oq2B2pi5YR4bES116GfU9+LdwQZC8XE5oqZyT3j6fAoZQRcEhCQ9GKUFdHz81vozaxC5npVxTJ
	yRUkxi5u0sOWjjOkOPjVGTNjA6kxPrcfrm1GkXIM3Ay/ya86oSTZPaXJZaVYBq7DKrnpVX7pltQ
	TmlAPB74jLjJ2WPxplzWzfvMxvKRzk6KWk7cCztu3QlO8czCbCoOWlIhvHRPB9
X-Received: by 2002:a05:6a21:6daa:b0:3c0:9c1a:8949 with SMTP id adf61e73a8af0-3c0bd287dd3mr11145411637.65.1783626215188;
        Thu, 09 Jul 2026 12:43:35 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c9a1sm39667491c88.2.2026.07.09.12.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:43:34 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:13:15 +0530
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
Subject: Re: [patch 15/18] x86/entry: Make syscall functions static
Message-ID: <ak_5y-p4DPztR-CH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.438361565@kernel.org>
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
In-Reply-To: <20260707190254.438361565@kernel.org>

On Tue, Jul 07, 2026 at 09:06:57PM +0200, Thomas Gleixner wrote:
> They are only used in the respective source files. No point in exposing
> them.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  arch/x86/entry/syscall_32.c    |    2 +-
>  arch/x86/entry/syscall_64.c    |   10 ++++++----
>  arch/x86/include/asm/syscall.h |    8 --------
>  3 files changed, 7 insertions(+), 13 deletions(-)
> 
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -41,7 +41,7 @@ const sys_call_ptr_t sys_call_table[] =
>  #endif
>  
>  #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
> -long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
> +static noinline long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
>  	switch (nr) {
>  	#include <asm/syscalls_32.h>
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -32,7 +32,7 @@ const sys_call_ptr_t sys_call_table[] =
>  #undef  __SYSCALL
>  
>  #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> -long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
> +static noinline long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
>  	switch (nr) {
>  	#include <asm/syscalls_64.h>
> @@ -40,15 +40,17 @@ long x64_sys_call(const struct pt_regs *
>  	}
>  }
>  
> -#ifdef CONFIG_X86_X32_ABI
> -long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
> +static noinline long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
> +#ifdef CONFIG_X86_X32_ABI
>  	switch (nr) {
>  	#include <asm/syscalls_x32.h>
>  	default: return __x64_sys_ni_syscall(regs);
>  	}
> -}
> +#else
> +	return -ENOSYS;
>  #endif
> +}
>  
>  static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
>  {
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -21,14 +21,6 @@ typedef long (*sys_call_ptr_t)(const str
>  extern const sys_call_ptr_t sys_call_table[];
>  
>  /*
> - * These may not exist, but still put the prototypes in so we
> - * can use IS_ENABLED().
> - */
> -extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
> -extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
> -extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
> -
> -/*
>   * Only the low 32 bits of orig_ax are meaningful, so we return int.
>   * This importantly ignores the high bits on 64-bit, so comparisons
>   * sign-extend the low 32 bits.
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

