Return-Path: <linuxppc-dev+bounces-23496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2680DC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:13:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsB2f5LPbz2xd2;
	Fri, 03 Jul 2026 21:13:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783077226;
	cv=none; b=REi7zxUkBEkd5JfrvYWcCoNNvbFG9EguqI/lv0qA96zQ9bDgQEvd7qEmvyLW2/94Dl/GrqZou81Xl/tkYJJEGaYmOS1NSljFGwaO9lvYOCMtFUBk12X6BWbEFsNqT1Z5rfB+OM2Y/4LRsTAGzIqCGBkpapR/ILWdcENbDsftAyzzbq88t+DwPeahZe/qulUMKkqMsoUzql8/5+MJLfzYxxNcZI9C5mduCrsX5mLZdraxgxE3eZ0oXI5ZIupHA56VfQdbZDL5h3+SrxDJCr/UMqH8MWgKeRfll0bpq5/DGaAaUrxy6TQZgU9p5+RiIp2UoFmjE+s1K3n0Ikx4pa3ckA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783077226; c=relaxed/relaxed;
	bh=A/K+DNLo6Rw5LUNC5Lpk7uYC0BgYbu/q5E/KtMAPChI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+803gekqEkNboAnmKOGUWp22oKUdPgmTuRZctqds4P0SQSsks/Mba9d3FndCFvI5EX6lGmQf6WOC7Lq5njmeSq1G2gPYCYtauVsJRttE95i8+qW2G/jzxULfg0uk4COcNn5iBiwQo4iJ4LwM1x+5F3G/b+yj/4W5hSu8zrupR2B3pgfyrBjXWYEjjKSY3sAibCTEZf2LXvXni9hdc+cfxw9WZSdO9SVk75XiGnBRyKtviVfdO8uQxQmmlAaQ5qMxxRf6W8zT+ZpNxLLEdvHH3trGLEfvfSzPMsOrwzLFl6txy67KcoFFpehOviYZ1t78C/ckvn11po/My+WkdfFyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SFGS+WH1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SFGS+WH1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsB2c63D8z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 21:13:43 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-847a5528b33so215347b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783077221; x=1783682021; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A/K+DNLo6Rw5LUNC5Lpk7uYC0BgYbu/q5E/KtMAPChI=;
        b=SFGS+WH1XjvKyxxGKuyt60gUN8CugVdVl0V9ozkd7lQYoHzHzcBeJe5jQx5um3Ugf9
         tZFhe0vtLAt1eiMtooVINPar6U3egdyKWdLMfTmyEYWs8rtbhsWely2QMNHN/hzpyW/h
         w5Bx2/Y0Wji5v0r5ZOelU7035FMwIkCTbJC3oT+usOfgmV6HXTrluJUZyEaF2U49q21/
         R4571RNzFNi3ReYipTa0wupnQ8r92m4wV1R8etUA5ZTUlChGOZ6cEjH81xQqPoa+hIca
         NDzGfHbmitLOF5TVTec/ZQv0FD8/tZHi1lW7tSRuzYWPuhfujJJat6AIqrGex29HIRi3
         r3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077221; x=1783682021;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/K+DNLo6Rw5LUNC5Lpk7uYC0BgYbu/q5E/KtMAPChI=;
        b=CJppqIyQOSvqycO7s9nn8FGhm6fMq+kXcQTHAeNN70onUz8OWSZJAZpN3MMNyvHFHT
         O589HRJ5V4ZKO88N687L5JMQKQmGU2JpvN/GoxCh1qMKkPKhjPU4PgfJoEkoeWDsT0l9
         5Cbvmy7OrxkLVuxnZ9wcsFKJ6NZLxboEViL723LV87XThwV2sqdxz3X5xnCFoxlXaLXb
         vEK23p37rZs+XwBW0glf9Am5Gq3uANvE4EUdA1YIK0fwZARvXbCQwpK60GwV4L4bSt34
         NYdblFkPkJ9FyzXAZdbXhnw9K724IIuLXfWMhK+7qnEpSfywP0g5+Xmo2NrxfmT/alNJ
         nYtw==
X-Forwarded-Encrypted: i=1; AFNElJ88TPukh1RH+Wn+v0He5m7/Mcyou5h0sJNXj0kSKDwShGfwJae+B+hZq7e7yQ5EF4GwkP4wgXwsnDR6ZN4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXiGlBOrr/1OWh1ucPefYE8MsId/hgl8bG771ckF1chf6NQJjL
	NfTg8oTA9PBFQQrOvokZwzWrpFujcDqOW8wDoNPR+ABk2jTgqyL6gLQG
X-Gm-Gg: AfdE7ckn1eqWy0UN0f9VfpkI0lW5x8nrW8h7d4GKsRNnjaZ/H9Qz/soUGPnJuv+E2wT
	8RRf+ga3K/qDF47Nx1rMHEOoUQRpPDbrCoxhmHCdo64y3Q4uAUs4zdmEXxuCn49lQ6kwWioDGx9
	lM4HaTm4oueBGquG/3EzIiiBG9x0ShzJ0xlE3mtABsYJAqS/v8H7YtohJta79WGDVgSWL6enZdX
	Up8d0U1SypMYyPjS1y/xEGlYHqN0FIIPpwb8y3j/Ajae9C9esQJ5xWZL48s5jsE4mkC/2lNn42g
	Er00QMPYXWGR3Z8bTutH9tc+kUQnx+SiWKoXQC9CsT8PaCRqh4ezgUMVJmQYWxZgLJEJY3thJB+
	CVfkrUsrElV1E2u9WLjRU5NrUk1KV0CwUkS0+5H8tXBH2MOqO7nP2aXdyLIHaAEr/pY7i56eRo7
	Kah+AFZ0V/OprGyltM7Dbi2pzZG9m6etv8mVQgqZ/hj18y9COq1CcqGtDGVTKl
X-Received: by 2002:a05:6a00:ac8a:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-847c512cab4mr8348296b3a.35.1783077220720;
        Fri, 03 Jul 2026 04:13:40 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb6dc4d0sm2701298b3a.3.2026.07.03.04.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:13:40 -0700 (PDT)
Date: Fri, 3 Jul 2026 16:43:11 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	geert@linux-m68k.org, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, luto@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	peterz@infradead.org, wad@chromium.org, thuth@redhat.com, mark.rutland@arm.com, 
	ada.coupriediaz@arm.com, kevin.brodsky@arm.com, linusw@kernel.org, yeoreum.yun@arm.com, 
	song@kernel.org, james.morse@arm.com, anshuman.khandual@arm.com, 
	broonie@kernel.org, liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com, 
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com, 
	austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de, 
	thomas.weissschuh@linutronix.de, sohil.mehta@intel.com, andrew.cooper3@citrix.com, 
	jgross@suse.com, kas@kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org
Subject: Re: [PATCH v16 02/18] syscall_user_dispatch: Introduce a weak
 fallback for arch_syscall_is_vdso_sigreturn()
Message-ID: <akeYzL3uQoxaddgU@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-3-ruanjinjie@huawei.com>
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
In-Reply-To: <20260629130616.642022-3-ruanjinjie@huawei.com>

On Mon, Jun 29, 2026 at 09:06:00PM +0800, Jinjie Ruan wrote:
> Currently, multiple architectures (LoongArch, RISC-V, S390, Powerpc)
> provide identical stubs for arch_syscall_is_vdso_sigreturn() that simply
> return false. This results in redundant boilerplate code across the tree.
> 
> Introduce a default __weak implementation of
> arch_syscall_is_vdso_sigreturn() directly in syscall_user_dispatch.c that
> returns false. This allows architectures that do not utilize a vDSO
> sigreturn to entirely drop their redundant inline definitions.
> 
> Architectures requiring a specialized check (such as x86) will continue to
> override this fallback with their strong symbol definitions.
> 
> Clean up the redundant implementations in loongarch, riscv, s390
> and powerpc.
> 
> Cc: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/loongarch/include/asm/syscall.h  | 5 -----
>  arch/powerpc/include/asm/syscall.h    | 5 -----
>  arch/riscv/include/asm/syscall.h      | 5 -----
>  arch/s390/include/asm/syscall.h       | 5 -----
>  include/linux/syscall_user_dispatch.h | 1 +
>  kernel/entry/syscall_user_dispatch.c  | 5 +++++
>  6 files changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
> index df8ea223c77b..946886794ced 100644
> --- a/arch/loongarch/include/asm/syscall.h
> +++ b/arch/loongarch/include/asm/syscall.h
> @@ -85,9 +85,4 @@ static inline int syscall_get_arch(struct task_struct *task)
>  #endif
>  }
>  
> -static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> -{
> -	return false;
> -}
> -
>  #endif	/* __ASM_LOONGARCH_SYSCALL_H */
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 834fcc4f7b54..4b3c52ed6e9d 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -139,9 +139,4 @@ static inline int syscall_get_arch(struct task_struct *task)
>  	else
>  		return AUDIT_ARCH_PPC64;
>  }
> -
> -static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> -{
> -	return false;
> -}
>  #endif	/* _ASM_SYSCALL_H */
> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> index 8067e666a4ca..987c9a78806f 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -112,11 +112,6 @@ static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
>  	regs->a0 = fn(regs);
>  }
>  
> -static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> -{
> -	return false;
> -}
> -
>  asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
>  
>  asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> index 4271e4169f45..5f310caad1fc 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -89,11 +89,6 @@ static inline int syscall_get_arch(struct task_struct *task)
>  	return AUDIT_ARCH_S390X;
>  }
>  
> -static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> -{
> -	return false;
> -}
> -
>  #define SYSCALL_FMT_0
>  #define SYSCALL_FMT_1 , "0" (r2)
>  #define SYSCALL_FMT_2 , "d" (r3) SYSCALL_FMT_1
> diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
> index 3858a6ffdd5c..73d69e02807d 100644
> --- a/include/linux/syscall_user_dispatch.h
> +++ b/include/linux/syscall_user_dispatch.h
> @@ -10,6 +10,7 @@
>  
>  #ifdef CONFIG_GENERIC_ENTRY
>  
> +bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
>  int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
>  			      unsigned long len, char __user *selector);
>  
> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> index d89dffcc2d64..acf545774d37 100644
> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c
> @@ -32,6 +32,11 @@ static void trigger_sigsys(struct pt_regs *regs)
>  	force_sig_info(&info);
>  }
>  
> +bool __weak arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> +{
> +	return false;
> +}
> +
>  bool syscall_user_dispatch(struct pt_regs *regs)
>  {
>  	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
> -- 
> 2.34.1
> 

Build and boot tested on ppc with P11 LPAR. LGTM.

Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

