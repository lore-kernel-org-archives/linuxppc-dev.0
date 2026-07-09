Return-Path: <linuxppc-dev+bounces-23953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B5DC44506
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:34:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3Xj1g7Gz2xll;
	Fri, 10 Jul 2026 04:34:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783622085;
	cv=none; b=ehNXw5LM4Hr+f4MTt/2dn7wVSZ0DH8aH0ZSAqZvfeUvnPBc382VQ0PPJ+3jUIwh4/lO9n8BRvlgsuamFoEwAhJEHCox0R8IcfKhMu4Lq12AQHOhx43ZnsYrxa/Evft9/VpfRh6oyFqnPcGAgYM7Damd1hqxQP7GbHjmcR3nc8dP74XpRBjzBQUeqM34fai0NkgkIaGec4rTFts6mqzSn8sCQ8fYYHu5ecYr5fhh5gkLJTgCmcGcnYIAALWO4DqkELXYdZ+p8TLPpc/9TFr6hwcv59wanGOWA5sVqUQcyBzRo0HPnhYb3TauO5QVqaO01PfT6RbB+KvHYSRTD96ytow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783622085; c=relaxed/relaxed;
	bh=yghYN6q10g6FdWlsVt4/TtDo8QYt/j/TS6a9b2++LOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtSCvkY43PrghQr1m3LopesEcdhon1WYVRvA+waSEyMaBh7nFUW0erHFezqyGQWSy/IM6pI4DJP352eQ76UdUM3HLnDfrj9gzEi0hYkYdgDJG3Q9X+L32gHnoP64T6jUDage6A0c2KmAPS+OS9Lh1XlNrBtooJjubkpyFGEmubBtFKxtYvQ+aZq//TBOAxhX7EW4BpjbwxMAujr8pDSG9pPL24lS3RdWLY5WwYN0hqaogwsXbj6zjM/N/Q3Trjqj0JFv4nrwGj4ZXEKRBMP+rDw7KawQaoockosgA6aBeU0+XHgLa7uefeXTNer+wqT0RQ3HXIhSW6lAPpkbZ1x/DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AZ9je86d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AZ9je86d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3Xg2zvHz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:34:43 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so195433a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622081; x=1784226881; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yghYN6q10g6FdWlsVt4/TtDo8QYt/j/TS6a9b2++LOM=;
        b=AZ9je86dWPz1XXUijRwJJMmbSQ8XNKXVsM0t1wlvPXYymWrAH2+q4kl+dF1HaIpDqu
         dPlx4SCl+7ZxfTEMe2yVKZ2dxwDd9c6yra8kR2L0s40JVi9GzErejVvGLc1uzRVlKTAt
         ERuEmzBjP1ks2WclLtk7PgPV2i0uw948LH1Fl1RfsBPQo1eCQVxCu9CwgsSEEBfNy0NG
         jyzrlWZcbOnzn1SZBLOBhAzZwF9G0LVVHTXjjXFXHBZbylue5sFGPI6lRrpte7TFNKDZ
         1Ry1tmc4gVqlkvbQjFnchF+CI/5Vq30uBGlkO5ykL5hqpgHHp0J+DXIn/iZH3dUrtFSl
         mZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622081; x=1784226881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yghYN6q10g6FdWlsVt4/TtDo8QYt/j/TS6a9b2++LOM=;
        b=Jw1lC4e829A3bXG02RbAncRuD3sUtt+hZr5yw1f9n3lD9ZS2q+KoLJLdK4t6ob36W7
         wE0E6Wu2neHVgTmYwXHp6QFXb+bn42RaWF+yZOw9Yn/Pg/1/JbIEh2hJ5i3OYy4ciYZ+
         Yd66djdxo7zk5YyC26tb0HWLdLGDPGQ/W0/OSJi1nl9jVkx5r0v8OhlFA9BXNx/C5h7R
         MGpJyrZlrKtByOcMTrerReu94GJeTrnhg4CY/kTa1LS1dKLoKhdUSedcQbP/HxjWWvQ9
         q5eQcq6goML3jekPQQEXTXnIn7g74ocqC0PjaFOprojYK3ix9bvgtYYVJPADueWraok4
         6TiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyPSocV2Zg/1FLXtU2SUX0OEkF3OgrGbUMMv8R0PbqnMSYyRK76n6Gi1N9VbswCBEOtNCgpwP21CTZsKg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjtOrW8Ox0OiN1TPJBBxhf+xM3o9nm3e5Hwb51iJdaigJa8EHl
	pvKB7Q3kSKfVZZrXrP0H51LEvjGHrMKzb1Vjf0myl0mzmhGG4BW5Uc7k
X-Gm-Gg: AfdE7cmFmbdJMDd/PFh9d+qH1VHkPNA+zAQLCBsvQl4PdE9Wtflu4wBo8vY1aIzQS3I
	z+8ilzBd8oYL4D6PtPLaml0yOxn0i1Z7pgRow1xUYOmbqjpLsO+xy3OQ1InAs62n4vLyvRfbcXw
	5hQ/1+HWBu+2PVykqpJQ8fy6eXCp6fwNbWT91IaKia2kVhfSwfI79Eh0cMJrFOCFLL7VB9SxwCW
	HIUdCTcHn0U3BAN0o5BaAeOaW+6HuCfJN9MfYsCO4iiVvUTlfNrIsKPtfGs+qDQ0mTbpeoF+Gmq
	M1sG3+GkEUKUp/8oolH0HbhLERRTybIyiUGIWkU7YAjp4jnN7cvvuI8PBYg3eh+yLMKAwAVA6Mp
	5e0wo6Qz/6zOMaGn2GM44kjVpxks4n/9b84ylxm6I5CND39chyfhBRMJbBETlaj3dkwN4gWhvhr
	7DAP8fBhlFiIYj6po+L4qRxeU8v+9D3UE6dTDQAxWyd3lqygdiYpPLCs7BwDEH
X-Received: by 2002:a17:90b:2752:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-389417e4858mr8140301a91.22.1783622081049;
        Thu, 09 Jul 2026 11:34:41 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm11123455eec.22.2026.07.09.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:34:40 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:04:21 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
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
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
Message-ID: <ak_piRRvfiMc9m7N@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.768842729@kernel.org>
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
In-Reply-To: <20260707190253.768842729@kernel.org>

On Tue, Jul 07, 2026 at 09:06:02PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
> 
> Provide a irqsoff() variant, which avoids that.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> ---
>  include/linux/randomize_kstack.h |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -77,8 +77,27 @@ static __always_inline u32 get_kstack_of
>  	}								\
>  } while (0)
>  
> +/**
> + * add_random_kstack_offset_irqsoff - Increase stack utilization by a random offset.
> + *
> + * This should be used in the syscall entry path after user registers have been
> + * stored to the stack. Interrupts must be still disabled.
> + */
> +#define add_random_kstack_offset_irqsoff()					\
> +do {										\
> +	lockdep_assert_irqs_disabled();						\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,		\
> +				&randomize_kstack_offset)) {			\
> +		u32 offset = prandom_u32_state(raw_cpu_ptr(&kstack_rnd_state));	\
> +		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));		\
> +		/* Keep allocation even after "ptr" loses scope. */		\
> +		asm volatile("" :: "r"(ptr) : "memory");			\
> +	}									\
> +} while (0)
> +
>  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  #define add_random_kstack_offset()		do { } while (0)
> +#define add_random_kstack_offset_irqsoff()	do { } while (0)
>  #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  
>  #endif
> 
LGTM.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> 
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

