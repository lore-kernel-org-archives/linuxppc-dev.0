Return-Path: <linuxppc-dev+bounces-19209-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE046CC6B35
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 08:58:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmbNV31mFz2ySk;
	Thu, 02 Apr 2026 19:58:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775120282;
	cv=none; b=mCdQrc6P24yOio3O6HbCgGcdIVS821XKEoqGMREW1Zrr6xKDhyTlFwV4c2CysJOv3btcHvkyPftTqIQbth8Lx1Zkqn1kTe25hcNswFZcThjgdJ7DbsFeDadcBMdviV/Qbmhkkt7hZ0IaB5NTLDUl/rfYQZNAY6e1kTG5S2Uqtw78WAm7MbuN2xVfJEZwohioSu1liRBfEOdvKTRRcU1dWZkI3vWjCJVY7on5/36fmhRp7JCyPHe2yHIWicmXCJsBT5XENehwMp1ViZkwLkZuDyOXxYj1Q3E24PNO6zHm1kU5uSanBKZBFEVxSPwEgfJwrnqK1vmmlLntDRIwqOn3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775120282; c=relaxed/relaxed;
	bh=LnQTQFMkaspyfTBlP7NJBNzFuL146lWNPT7LvqeL2XU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wnjidmomrz2HXlU1vo8pcWQmT4R0P/mk2JgFz7VtEtorLchrNDhdQigUlYizOTZSOJb30dXiLi6nthoQrkFYmrE4QRlJGlIRSb99b3YTcXSjut4U5rhDkVIFSv6ux7Xo+R4E0+FuFoxIdv3X09jRp2L7P44PdrGurE7SvP48Xgjm7vc+5RhELHB66u3Ij3FEcmYtwfTKxoYJ5aNZ/yhcTW0PsWsnkaZD+uvRxhKH0AVLPM9nXRKwKaPQJmIICrZXlVMB4NigEXGfDTYcXdAnX1oVz55fbuvigglb77s5NjQCfXqZr57m3vZeQVW3xBcsgYBFSJgjc8IsPu6iW6ZXaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s7OZk4Ay; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s7OZk4Ay;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmbNR6rydz2xls
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 19:57:58 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso5220115e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120270; x=1775725070; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnQTQFMkaspyfTBlP7NJBNzFuL146lWNPT7LvqeL2XU=;
        b=s7OZk4AyxPNCQM8seQHu4f10QLtKc9TzQYLgDtQrvBQo9+fUpMsAY24ow0qdm/Qu/M
         cnqXZNkrVKE2e+ZQvYNxwTUzJH2dz6EIS+E15/uDwo42ioIebTwVXhV67GOKN+2vXQI1
         2+9RKvdBkllXUd7/PUyUYQRYlQxfC/sukAsEddohyonsgLCGodFOXYbhFMNBHmb/dUGU
         yxT+Xqz56MSNko5kcQk1n/B6H5DLUPwi+ltYfmeluXCwZma9VAbCI6gqCLlv5prom2qT
         1qxkPjbEAhh67NR4G3LkE7gKYTgsY/AfODLLq6qM12m7NrXOT8fxFREm/ChqLFi7FkLx
         eKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120270; x=1775725070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LnQTQFMkaspyfTBlP7NJBNzFuL146lWNPT7LvqeL2XU=;
        b=IUS97Y1APIQ5vgLVVEb6kDVhauKX0yg+HrXfPh2Il5uxTYtrFnQu0cYz8RopLSqBUb
         vcn9g1lizxw/XeoONGZ2ypTweWNHqcLzpkXrWp93L4/tTawCR0G/drWsw/9dENwozZuH
         JAImYc30g3RMVIMxbV904wQf0PIsXz2HNZwUJ4PlwJMemPmAu1UQFXXcInCS8gRYwXHi
         XWmBw2DwyFQ0nQTVcbd5JdWEbbwQ71W5FBxf+fyy7vR79RqiVPw/hmx8TrSp96T5UOCP
         Wvp2UKXNlBr4z9u+uXleviWdyL9wlmQxKZ874tiaX/frn+cPIiigUpVrnLFWjckbfD6B
         B/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqXj3FzJqsBbi9nOGcAluPbXgKMtZVV9ms7BxbY85UG50tyIbzyUkifTSr4RxR5UUo4qIepqctj1IBsHY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwO5t98L1qwBBpKLSDWqmYVirFW4hFPB3xLqd0Z5ghxRaq+Cod4
	eBlGESyeg54YdxGSCzQd6hhIKgImRRtJ5xZ5SZJTfxTG1Zv8+u+Tan3y
X-Gm-Gg: ATEYQzzU4tYHc/bXy2wgVGigSp2mIShEw7JLVNISTLO4kG6jo6oW7cd/FeKrV+ohajm
	xsB4+6wLJyalD7UHZXkhrAgoiQnSJIW6UzS9b7xzxKqi7YCZ0sb+WDfcUdwnf1ceiVhpSnMH37G
	gvzhDBjS6cP0BFS5qWb/qkYqrStPKRBoKjE/bA6tCCvrJ9J/67OYszlRxNOadqiWlo9rgHMyrgW
	08ZTeEeEVQay1xEaC/bRKzczJxifrirLSp3R/D7AwDLGp5JKzsVluqT7lYLZ2HujHmHmyHDchLT
	U0RtvKFAuaEu2uSmVBhB7shsHqbYCSXlFYHYbMJ4i7XWY1LznKLOeNCCqvM3dNoes+W+XyX99bQ
	6fYo93+a/vwlXTJlggSPVirBmIDc1KC0BKMa+n/QCho9P0//sogxf8SbjaBVI46K896ttVgyhxk
	T+Ge1nPy/e6GfO7fYWy7wuSR4Z6JABdogEdfXufPfQq9KpBWY3rG8GjC9u5iCR
X-Received: by 2002:a05:600c:630f:b0:487:288:1198 with SMTP id 5b1f17b1804b1-4888359da58mr102555095e9.22.1775120270131;
        Thu, 02 Apr 2026 01:57:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm217845265e9.0.2026.04.02.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:57:49 -0700 (PDT)
Date: Thu, 2 Apr 2026 09:57:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner
 <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Brian Cain <bcain@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH] cmpxchg: allow const-qualified old value in cmpxchg()
Message-ID: <20260402095747.6efbd456@pumpkin>
In-Reply-To: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
References: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Apr 2026 14:56:01 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> The old value passed to cmpxchg() is semantically read-only: it is
> only loaded into a register as a comparand and is never written back.
> However, the macro currently assigns it implicitly to a local variable
> of type __typeof__(*(ptr)), which triggers -Werror=discarded-qualifiers
> when old is a const-qualified pointer and ptr points to a non-const type.
> 
> To avoid this, let's add an explicit cast to __typeof__(*(ptr)) for the
> old local variable in the cmpxchg macros. This explicit cast suppresses
> the -Wdiscarded-qualifiers diagnostic.
> 
> The new value is intentionally left without a cast: new will be stored
> into *ptr, so silently accepting a const-qualified new would allow
> callers to store a pointer-to-const into a non-const location without
> any compiler warning.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
...
> 
> diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> index ae1b96479d0c..b4b8dac759c4 100644
> --- a/arch/alpha/include/asm/cmpxchg.h
> +++ b/arch/alpha/include/asm/cmpxchg.h
> @@ -234,7 +234,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
>  
>  #define arch_cmpxchg_local(ptr, o, n)					\
>  ({									\
> -	__typeof__(*(ptr)) _o_ = (o);					\
> +	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
>  	__typeof__(*(ptr)) _n_ = (n);					\
>  	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
>  					  (unsigned long)_n_,		\

That looks like it loses the check that 'o' has the same type as '*ptr'.
Maybe this works?
	auto _o_ = 1 ? (o) : *(ptr);

  David


