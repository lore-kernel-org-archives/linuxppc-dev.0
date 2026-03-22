Return-Path: <linuxppc-dev+bounces-18559-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E95FC72C3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 11:03:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdthj69GYz2ySb;
	Sun, 22 Mar 2026 22:03:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774177429;
	cv=none; b=B0klKlg5/l8jec/XZV12PYXLD/QW2OwlpLB7EoUaZy4TGKrepuHqOaGJmqG/4d3g8ZMd5CXLxi1DrM1cMfyl8fABXSdTwc/SSHihzdK0WymogUBwndN0Fmvx3bTStn/TflQ3Fd8Jr3UQFbirgDDQkkRSt9xNEuLf1S5WVr4ugyAIWvTHAjvZfabVH/kSiV4u1VqNTHMRLcPIGfYpI98yCYjf/kkA8p/Ngp1pKnu/Ue/ecELYXhF+aKJTcMvpBZMy2SlwkI1EhZqzo/Dud0veZCQ1O04MSgy4ifOXZe+Q7rjdxkDgsNeRmrlOy3/kYmetIqaqemMerMfn+4spuTJCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774177429; c=relaxed/relaxed;
	bh=y2uMc8piwzlAYxFSiatJbfAWN3tMY29jqB8b6nTwrg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCqMc54AEgGzEFzI7bX1w4qefMJmIu0F2qieYfYxaAuHTs4L4mnsJn/yFNw8vVzGJUElU75SuD45KwLmvPmL0jGOZug/idhsF6dgAFP7EiVZuWKrSz2z4SpQ///7cdfWLxlmEUX5Q6GgLZ0cwuYuAkgMcLXe2Uka/p24X40jQfZx6vuyWpYWGFs/swxXF0LNOnC7nmo4cDJkk+qAO9Wp2Oa0bRAGvgAPZPdlXZAzk4iS8aXUE+WoVWSvqKke4wMlHj95AmCsI/a2qZDVQfhYWZXGooIx7wP9Drzr6VhKza1aadtUMV9DZA8mwhJ18gMI6FNxT4UrbaLsrKzA5c+ykg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J+bwSgI7; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J+bwSgI7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdthg62Byz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 22:03:47 +1100 (AEDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-439bcec8613so1270488f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2026 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774177419; x=1774782219; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2uMc8piwzlAYxFSiatJbfAWN3tMY29jqB8b6nTwrg4=;
        b=J+bwSgI7PtY9ImikNdWqBod+5MrHs0jqD+4MksyECGaWn1KjJRuaGyLbaxEjI4rog7
         g42c357P1hQFNu6PB0igWUrQPaUlT5LqRcHnWixrkebzCEivp14oZplzWy4cGmvXND3M
         KLafZQftb5wxoca83YiWgJN3Xb9vwl8MVHTlZAZOXx46AAKSDpVPJQpoP9DxTM3whK4b
         DKI18Q8UnrjVMeUYpYMH6/FnctzbIHh0/HbVfhQ2At/is3+IB5HLBkH1PNKsHaLYxbpY
         MPkkrXeUchiiJozvw5t/+fH97FgRvqrnpP3NwD1Qhhp5UyOJMIPLEiNZkMklm8XO/v8O
         ODIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774177419; x=1774782219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y2uMc8piwzlAYxFSiatJbfAWN3tMY29jqB8b6nTwrg4=;
        b=EL07yErUeHOHgQE4HWWjpCOsKE42sYFz9uf1Oh7HQ76wLMA0l3Na1lln+M3yX1yrhz
         eKz2pLo0OR647wQjooWqYp7q3/eNkeDzcUm53qOn/GIKegHJlqIEz8KScVFcPN9cmk0S
         UrwNFTg+76Y+8mWOzoZy+p4hEWEOnlyeHZW+VtSwuD1Iz/otA4Cq/RqZ538HQwM94tfP
         2GfGTcpGgnxKt8tTbI004xOFBLNFbqUl9yyfkYx14F8UVzGUfMNPMWAuGIMVrS/sXtJz
         iKznUEfo8GAC2lPruhwJv8tqmi/nEsPx5Pq0FRr5CfWM6Cr+WtkN2M2Q16q2LNpmFKpX
         3e4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxTsJ0c549yUNnDqiwIBp6Lo5Y55ZKkMLtB0hSYwW66HukLD+jJyJFOoLlPOkAl+jY52KnIQYlf8viXMY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8UjIuXPcB1+miI7wljCBIzxogqTfMiKULO7zeP2n6HcrrpAtu
	TsT9kYwu0Mn67+4xiMxt+p8DoH5sGDJIlQHQj4IswnMu7u3Y5cQY+W7g
X-Gm-Gg: ATEYQzyf7lAoMJcjE1v9C8qze0lVpeAsvG2wvUJiGfvlEYHKfhk8kFsjw7qsQwJLk5s
	V+xzwPuY6cSslpWdbDdfsEb63aOEWKnVyunUyOtNcp1KZfOPYvg7+vUSbbpUPsZwZm3p0lmC1Ll
	9HB2iN7e4iqAdexDAL+qeTjSVcI8mJNAAw6zCrMJPekGvDDt6rnOBr2Kn8OBm/3gTIy9AKAh+o+
	LUY+NaHNqmsTRxcGvAs5TQlvbrn+rNQ92eK87oMVy6Yf9G0K3VB/gwboM7IExCHYWRhttCbLkRg
	cqZyRBwN9b/H0F0wUE3kOy+elYMwb/IEX4SQUw8jZa/sR2xP6YlV8AxsfBMGjFOYlOKB1zg3NGW
	Or/a2EZUGialtu6ePlRCrNQ618Uym4vU6HxEtEi5DDSwUMCXiWJBOJ0FdmxurtOQORi5A2fCXwO
	EGM1JNRW9GiwtGUzKHEKNynEgkiwj+VTibnnhPDpK2Y+NpyEWcYV9wfkfup4NnjepY
X-Received: by 2002:a05:6000:2dc2:b0:43b:4aba:8f44 with SMTP id ffacd0b85a97d-43b64287241mr13236711f8f.45.1774177418769;
        Sun, 22 Mar 2026 04:03:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm24424857f8f.12.2026.03.22.04.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 04:03:38 -0700 (PDT)
Date: Sun, 22 Mar 2026 11:03:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Simplify access_ok()
Message-ID: <20260322110336.66cd54af@pumpkin>
In-Reply-To: <56dd1a892279fade2292b7eef7a52112901ae2fd.1773770778.git.chleroy@kernel.org>
References: <56dd1a892279fade2292b7eef7a52112901ae2fd.1773770778.git.chleroy@kernel.org>
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

On Tue, 17 Mar 2026 19:07:04 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> With the implementation of masked user access, we always have a memory
> gap between user memory space and kernel memory space, so use it to
> simplify access_ok() by relying on access fault in case of an access
> in the gap.
> 
> Most of the time the size is known at build time.
> 
> On powerpc64, the kernel space starts at 0x8000000000000000 which is
> always more than two times TASK_USER_MAX so when the size is known at
> build time and lower than TASK_USER_MAX, only the address needs to be
> verified. If not, a binary or of address and size must be lower than
> TASK_USER_MAX. As TASK_USER_MAX is a power of 2, just check that
> there is no bit set outside of TASK_USER_MAX - 1 mask.
> 
> On powerpc32, there is a garanteed gap of 128KB so when the size is
> known at build time and not greater than 128KB, just check that the
> address is below TASK_SIZE. Otherwise use the original formula.

Given that the whole thing relies on the kernel code 'obeying the rules'
is it enough to require that the accesses will be 'moderately sequential'?
Provided there are no jumps greater than 128k the length can be ignored.

I think Linus thought about doing that for x86-64.

I can't imagine that happening unless there is code that probes the end of
the user buffer before starting a transfer - and that is pretty pointless.

There are places that skip a few bytes (or just access in the wrong order)
but it is likely to be alignment padding, and code should be doing the
access_ok() check for each fragment - not on the entire buffer.

> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  arch/powerpc/include/asm/uaccess.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 570b3d91e2e4..ec210ae62be7 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -15,8 +15,34 @@
>  #define TASK_SIZE_MAX		TASK_SIZE_USER64
>  #endif
>  
> +#define __access_ok __access_ok
> +
>  #include <asm-generic/access_ok.h>
>  
> +/*
> + * On powerpc64, TASK_SIZE_MAX is 0x0010000000000000 then even if both ptr and size
> + * are TASK_SIZE_MAX we are still inside the memory gap. So make it simple.
> + */
> +static __always_inline int __access_ok(const void __user *ptr, unsigned long size)
> +{
> +	unsigned long addr = (unsigned long)ptr;
> +
> +	if (IS_ENABLED(CONFIG_PPC64)) {
> +		BUILD_BUG_ON(!is_power_of_2(TASK_SIZE_MAX));
> +		BUILD_BUG_ON(TASK_SIZE_MAX > 0x0010000000000000);
> +
> +		if (__builtin_constant_p(size))
> +			return size <= TASK_SIZE_MAX && !(addr & ~(TASK_SIZE_MAX - 1));
> +		else
> +			return !((size | addr) & ~(TASK_SIZE_MAX - 1));

The compiler may know an upper bound for 'size' even when it isn't a constant.
It might be 32bit or from 'size = is_compat_foo ? 16 : 24', so:
		if (statically_true(size < TASK_SIZE_MAX)
			return !(addr & ~(TASK_SIZE_MAX - 1);
		return !((size | addr) & ~(TASK_SIZE_MAX - 1));

> +	} else {
> +		if (__builtin_constant_p(size) && size < SZ_128K)

Again the compiler may know an upper bound even if the value isn't constant:
		if (statically_true(size < SZ_128K)

	David

> +			return addr < TASK_SIZE;
> +		else
> +			return size <= TASK_SIZE && addr <= TASK_SIZE - size);
> +	}
> +}
> +
>  /*
>   * These are the main single-value transfer routines.  They automatically
>   * use the right size if we just have the right pointer type.


