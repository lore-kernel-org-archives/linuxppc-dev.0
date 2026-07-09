Return-Path: <linuxppc-dev+bounces-23958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F356AC44506
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:46:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3nl3xrQz2yd7;
	Fri, 10 Jul 2026 04:46:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783622763;
	cv=none; b=Vmv7wbSPOOkUF34mJh7wvJAEVt83MtYzx4jeKeHWMVJfJ51HvLboefkefkW14AhkfYzqOW2Ey98u6zE5D92EApsx4I4wTN/PeNqFXDdnBAkDVsMWJf9ZvyZlTZg1aZfV2JEJXmFmWQCp+kk1SujO7DscTeAu3ljfdoiZ7ylzn2RyqnokseY3WELv7ffxCD8fy8DoNJnhOj1OfbcH3PV+zNmMVuGlgWuG5v2fX24dyCGOvqnWkz8cj1+NjVRAAvGgYcgg6F4UpVX8E6lpauKpiBGjqgEQljT1tjMuA1yb2vbq0J/9683DbQAnCbohR9LaLrkdXfFkZVKzkybQM9EcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783622763; c=relaxed/relaxed;
	bh=QPf+9G20chtvWfhmlbsBAcrLn3a4nXZU9b8fTPixMo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajcNSB1GP0b/La+WeFJp2LGubLN58VATJYpim2A1WJmYL6wkaPRL58Xt3YRKtp/cpzI1qAQ2YrN1+UoKeqcVZbsHb+JfW5E+qIw6tY7HK24MOsgKWOvEW3z0OuJhrc2Db9HpCL+lZvxhba/s6cSQliPZSB13c1Lhl+GLRG2SJGRlFy0iJf+Pxb26nWA2ApWh5z4STz/zlP5hJq+fxPifAgOzLnUxx+KZNFDAkXG6CMBRMe/xPPrPcGAUA9SzpEq87rSTjZ8ncvMYxEv5i6MHm6MIuIzY7VXG0Be8XcdlldIbnVxlrD/DkiM/xjv28cPmo7tm0PYIdk/N7VWP9g9xcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nkBTCbzR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nkBTCbzR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3nk5lS4z2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:46:02 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8486672f03cso85787b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622760; x=1784227560; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QPf+9G20chtvWfhmlbsBAcrLn3a4nXZU9b8fTPixMo0=;
        b=nkBTCbzRULgg7gvLJEpkRcy5L9ftQDDIK7geKZA8iyMvccVXx7L+nu8KoeZv7MzyIg
         hDP6UjC01E7x4CJHlPqwgfMR+ku2NeNBRDWy27LAXYm+1ykkYa+D/FyIaBfUNeOMRNiu
         9eQHTISS/hkpfFMzeeyoUbHxJw9jYQs4tclmPR1Y+HfhU8Lc+zAYcqDl7M53BvqUH72j
         5ixFnc3ILImNEw32A6GQ4d+mpjtIFWBT8J/WBe7fyIHAT0zIeQq9I0fK6V2tIZTM3q8R
         aZad/n5VskiArAw6GjX/10y5Lg9TwX8NRelB5034wAnRMNr5TW3G6iVbo/hh9fMTxoWd
         34Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622760; x=1784227560;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPf+9G20chtvWfhmlbsBAcrLn3a4nXZU9b8fTPixMo0=;
        b=fggmM22wyFlw8JTuZzlOYxuP95rGrtHZVOi81Ay6nf+uNDYlkOMAZBpsSdrnd3mOy5
         F1JlMfWo4EmsmmCBNT1Bbzcdfqgy/yqJtYcbBSrJuIyTMwwRWO/vwJAx4MqA5lbTzvV0
         MeQPwQKNM7CVEV72M7f1GkFc+I1udMLiMC86iYLrzql1FLLXo0OxxQ69og5FnmIGQhDP
         4QV+ZShSe4Ji1S2vDoNlwWlTJthjHhJonn81cxgOZuuedlTTKge+mbV5RiFSRt7g5cyX
         XIpOuy+nnkrYywv+1sq145jMoriOpARXrbYbLelPJqteQ91XXBQPq3tdNUqcQGlu3Uo/
         qh6w==
X-Forwarded-Encrypted: i=1; AHgh+Rrqr+xBnUJt23lHZl9axLRL59rINJ/RPr6TP8ofqPjXRln47vXy09RZpnuGYUpR40x0W6YktrDCV7Xbz3A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxCByo9TYwb3TTszhu2e10jd80PTzp98jThiFW7w6ZuOyGpnPX6
	cOb2YcSgT+o+lRcP0EzzvSUc/8nt2EFLmIYWBqXYlW0SkCTaeyMvv8Ri
X-Gm-Gg: AfdE7clbrevdNDr3Num0+LxN9rtQNVfJJR6ZKnl0bPoSdlh5uMYw/oGflDaNBsOfTNp
	rNl5emS3jF0KVW5I1KtRBG151nslNSgdv/J9uuqxXQahsWTcVAD+saSwwA/wsnG0UlD8Jr1IB3B
	vqOnw21xlEKmsw3W1TXEjLJ6mqHxBnoA1XNL6aOZktRM1faSk9asrffJwBDtgWxQ1aW3fsUp4x8
	qbwug8vkj+SLXIxPTlOLjNBx3WtYbd0ucwjnsnN+W+NBYhzG1Ca0wSMELZ1o6liTle8V3zFdfXG
	nwFalCjhkmKehPYg+aX13EQMQFV2FcIp6X+h2jV2f1pmIX39S2bSa3uifFWR1cLTIzh4AWPLhIu
	Wb0QhPm9yLpO7kmMK3fzibnv+5G7EFhFoNo/uoNUPqdARg8QyRORJCiptkQ49U3ktPUho6R4ZwL
	jy9V0nXMBKfd0+FI2i7+5CT1gGQ/B30l4cKvbFH+MUOVsuNfDTguTEm8B5Bm9n
X-Received: by 2002:a05:6a20:430b:b0:3bf:ae43:4d26 with SMTP id adf61e73a8af0-3c0bcf49cacmr9958974637.5.1783622760038;
        Thu, 09 Jul 2026 11:46:00 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm33384231eec.2.2026.07.09.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:45:59 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:15:39 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
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
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
Message-ID: <ak_sOt1kr8nrVCju@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.079478122@kernel.org>
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
In-Reply-To: <20260707190254.079478122@kernel.org>

On Tue, Jul 07, 2026 at 09:06:27PM +0200, Thomas Gleixner wrote:
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
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

