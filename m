Return-Path: <linuxppc-dev+bounces-25440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A838FC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:29:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFV8t00Plz2y8c;
	Wed, 05 Aug 2026 22:29:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932973;
	cv=none; b=b1gahVXY+teaZQltskXiG4Prv++Bxkl2nO18mlpjGxXj+cBdhTncNzZExp5RWSU2n0mLA/qL2QD1Criq18K++JxLKttEC8nWjLi1jfMSM4HHEl+g0UwLLxFmdeo0b6c3/XJ2xzvkEoUm5PNgjts+HN+CALR8BOtbDglNTZn/Xypo9xEyxQOuy5xvPMZPzd5Y+aoWsOf73IYHbkrSAoSTtfXRnVPmE8ZV73Trh6E5LnPKUgE1u30FiWXOcRKPYu8sOwitG5FEe2LNoR29KIWyjjF9O84HBtIbwOzJQVFnLmSCSC1SScd+L4vDOcg0eiJA3JavQYfDEBRkjzHpJ42ZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932973; c=relaxed/relaxed;
	bh=lDfE3MImKDd5lzHD3TwQos1pByv1t0VuukoOAZQ7kIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbNjFNWX1NzBF5GwVWQt76ZiUNgKnFb9lTt4rv5XO+zU+cQO579SlKCZeb0cvDhy4MfIXlJ0MLIRYU5Uzug5hShr5wcJxzZRX+9O6fEgH54KscgujyGq8BdObaFFeMLxYbFM5whb8WvqLuvAlIS+r17Msb0mAEkY43W+hA7g6hmXs35FS9YrOOT90Bpu/IeFz2zmU9YroUB19y1FFZyVkgy8LCTFMnMjR5oJN8kgL0ir81czCI3+ABd/pcP8LPIYjwZmw6ZZ8nAUHo2mMz8Z38+TX8ZSNxZ6twR8JlKrIuiD9IWgvxUAq3tTKOZ2CdPI2SQS99zoDxiNEZWNmnnP9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qle4eJBi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qle4eJBi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFV8r6nrwz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:29:32 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so831561a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785932971; x=1786537771; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lDfE3MImKDd5lzHD3TwQos1pByv1t0VuukoOAZQ7kIw=;
        b=Qle4eJBiP0aZpig+cCaaQv+Vl4az26lIl+BIVrbyWNxbx5RXkzCTNFm3kbZzr1MiSS
         G6fVD+YipBf5eNaVsRLzHpOwiKq0m/jA1E8TE8cFXgFctv34njNdvhWPKlIyvHavQ5LT
         d6WH8Oxn22Jc3lRJR0tQX+Il4xbWxxwx1Ep1TKVV81r1wuG8KZt/B4/O2xf++C/tPMNz
         FMh8LdFqDTqy7bMfVXnMcij+4TYb4VONVvY0QdattpMbsDYwzl+kFqtYnKwdt6WR8OYi
         YEsXyBaSen54GQtScnZDsWPw7mx7PiQwoX05HBT78TQ7IjSP8hJkcraMrrd8m1tHFnuK
         rueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932971; x=1786537771;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lDfE3MImKDd5lzHD3TwQos1pByv1t0VuukoOAZQ7kIw=;
        b=d4OvKYgeTxYnRm/A8igV1jmY05Zxl9Q0kmUr+fowuier7zsZbOd0ijOhV+MPH30f/E
         oDReV5AtK3Dfh0ZHHkd7Wvxu1upauDKoxRbOzc5Z1EnQ2S7wI3S57jFGMaDqIHkzO1u+
         U9KEPQoPd+DL+r9g0iRX38AWkH2GcxevkNh28NO9IL2Hgn5u2PgvCrvjjYoXtbtugvgT
         LFvBTL3kPbQ1bsBROCw0YNPpo87Y+Y2m+S4eSF7pqWN0JTr+htgiaPSkhCOgSJy9M0au
         np8KinFsb15Uev2xrYdVrLG1AjlvLgVHS12LmKz+DdluRpNrXe7+zoW+yKKWVK+iJCsV
         LI9w==
X-Forwarded-Encrypted: i=1; AHgh+Rro6NpQr40kS1DJ9D0ctX1LvP5y5b/H61mWcSKVV6b9lwZvDUSY3d9GbDMZk9O11+UBKXiJDn0HgDa4NSw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqEN/s3krcl7TSBoo87wVleJUBy2/1ZbWomr/fNMGsLRhHY1iM
	aToSec5zsVD7kKdaVwoEZMvrBUE0OXRtvp81cD8z6iNUpsMxXWJuh72n
X-Gm-Gg: AR+sD10wYrxi/laG91xTYlv5kpB/Ta/aNd64MBa7/6x6wTrzZpvJ5RcTLs79YUEX5uy
	YyJuhZnGzNzYK6PdvWq/mF7NL79rpfZEogU/hJCepXJW1qmBjrylrI7O+sdZqBgqlhJjJd4TLAD
	h7EPd0WS6DwMaSYzxRn8d0MPPpuoj9wfnkGgyGlquHkmajZ19szSaQBSL8Ae4fc9zmnFqvkmtYX
	wyQxPYKYTJnDBn1UIwxERHLgNQbfovuaaeD2Br4ThmYpjHpHCjGfUnulmWE3KbkL5njKhTnglV+
	MrSOjQAr0L4nDaoyKwqSYyy1CnLwSq6CB3iKShngEovtLaeBGsT74equ7VVaWIPlcg1MrkgFFeZ
	S9tJGJgeqQCKl/TIfOYQxEeUsZx5abB9XJ1VwX7jkY4Wojx0mO8KtjfpjRxxfLJulrhohf/sXCa
	1mz7SSKC6ccKAYJ5Hfm6cs4NhaCqG4NFFges/o79XMlG+aDCrXADRbiXTjWPQ8oLTR3v1nIClqb
	o1p0QxTiilSfn8A+Szn6KMu0zEuz7PYnQy2
X-Received: by 2002:a05:6a20:cfa2:b0:3c4:397a:69b8 with SMTP id adf61e73a8af0-3cb85e6c93amr8849745637.21.1785932970620;
        Wed, 05 Aug 2026 05:29:30 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.161.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe707ea3ebsm1514279a12.8.2026.08.05.05.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:29:30 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:59:14 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: linkmauve@linkmauve.fr, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, fujita.tomonori@gmail.com, joelagnelf@nvidia.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com, 
	lina+kernel@asahilina.net, j@jannau.net, airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Message-ID: <anMsbbRNiihKB-z7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
 <anG67Q6Y59kDqh-c@desktop>
 <20260804.224035.269658578200153488.tomo@flapping.org>
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
In-Reply-To: <20260804.224035.269658578200153488.tomo@flapping.org>

On Tue, Aug 04, 2026 at 10:40:35PM +0900, FUJITA Tomonori wrote:
> On Tue, 4 Aug 2026 12:11:57 +0200
> Link Mauve <linkmauve@linkmauve.fr> wrote:
> 
> > Hi,
> > 
> > On Mon, Aug 03, 2026 at 12:27:13PM +0530, Madhavan Srinivasan wrote:
> >> On Wed, 08 Jul 2026 13:54:47 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> >> > Enable experimental rust support for ppc64le and ppc32be. The patch for
> >> > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> >> > merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> >> > `rust: Add PowerPC support` and the discussion for that is done here[1].
> >> > 
> >> > This has been tested on
> >> > - powernv9 hardware
> >> > - pseries P11 hardware
> >> > - pseries(9, 10) qemu
> >> > - powernv(9, 10) qemu
> >> > - rustdoc on x86 and powerpc64le
> >> > - rusttest on x86 and powerpc64le
> >> > 
> >> > [...]
> >> 
> >> Applied to powerpc/next.
> >> 
> >> [1/7] rust: Fix "multiple candidates for rmeta dependency core" error
> >>       https://git.kernel.org/powerpc/c/00cdfd072c709c608606461d7d44d4613119bfa9
> >> [2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
> >>       https://git.kernel.org/powerpc/c/be809b60cbb61aab96179f44ac3670242ae72996
> >> [3/7] powerpc/jump_label: adjust inline asm to be consistent
> >>       https://git.kernel.org/powerpc/c/13244c0a40139fe66c4c5c5655f4d732a6002957
> >> [4/7] rust/powerpc: Set min rustc version for powerpc
> >>       https://git.kernel.org/powerpc/c/e299147cdc8e19c6421a6b7863dc82a35b09d967
> >> [5/7] rust: Make __udivdi3() and __umoddi3() panic
> >>       https://git.kernel.org/powerpc/c/c93c194e4ee71a734986fd99a8b1ec9fbb7a9b8b
> >> [6/7] rust: Add PowerPC support
> >>       https://git.kernel.org/powerpc/c/73b741adb264967093ef4eb59905618a7e0d0de0
> >> [7/7] powerpc: Enable Rust for ppc64le
> >>       https://git.kernel.org/powerpc/c/bc87cbdb952e9223616b839d64bdb4723aa2ed1d
> >> 
> >> cheers
> >> 
> > 
> > I just tested those again in linux-next, with the Wii support series on
> > top, but now the kernel fails to build due to ARCH_WARN_ASM and
> > ARCH_WARN_REACHABLE not being defined on PowerPC:
> > ```
> > error: no rules expected `ARCH_WARN_ASM`
> >    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.rs:1:28
> >     |
> >   1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flags}", "{size}"))
> >     |                            ^^^^^^^^^^^^^ no rules expected this token in macro call
> >     |
> >    ::: ../rust/kernel/lib.rs:279:1
> >     |
> > 279 | macro_rules! concat_literals {
> >     | ---------------------------- when calling this macro
> >     |
> >     = note: while trying to match sequence start
> > 
> > error: no rules expected `ARCH_WARN_REACHABLE`
> >    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable_asm.rs:1:28
> >     |
> >   1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
> >     |                            ^^^^^^^^^^^^^^^^^^^ no rules expected this token in macro call
> >     |
> >    ::: ../rust/kernel/lib.rs:279:1
> >     |
> > 279 | macro_rules! concat_literals {
> >     | ---------------------------- when calling this macro
> >     |
> >     = note: while trying to match sequence start
> > 
> > error: aborting due to 2 previous errors
> > ```
> > 
> > This is in addition to the bindings::kvfree_call_rcu() call, but that
> > one is already being handled in a different thread.
> 
> Looks like powerpc needs something like the followings:
> 
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index 0db48977c70c..8aba39e0cf26 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -32,34 +32,38 @@
>  #endif /* verbose */
>  
>  #else /* !__ASSEMBLER__ */
> -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> -   sizeof(struct bug_entry), respectively */
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
> -#define _EMIT_BUG_ENTRY				\
> +#define _EMIT_BUG_ENTRY(file, line, flags)	\
>  	".section __bug_table,\"aw\"\n"		\
>  	"2:	.4byte 1b - .\n"		\
> -	"	.4byte %0 - .\n"		\
> -	"	.short %1, %2\n"		\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +	"	.4byte " file " - .\n"		\
> +	"	.short " line ", " flags "\n"
>  #else
> -#define _EMIT_BUG_ENTRY				\
> +#define _EMIT_BUG_ENTRY(file, line, flags)	\
>  	".section __bug_table,\"aw\"\n"		\
>  	"2:	.4byte 1b - .\n"		\
> -	"	.short %2\n"			\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +	"	.short " flags "\n"
>  #endif
>  
>  #define BUG_ENTRY(cond_str, insn, flags, ...)		\
>  	__asm__ __volatile__(				\
>  		"1:	" insn "\n"			\
> -		_EMIT_BUG_ENTRY				\
> +		_EMIT_BUG_ENTRY("%0", "%1", "%2")	\
> +		".org 2b+%3\n"				\
> +		".previous\n"				\
>  		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
>  		  "i" (flags),				\
>  		  "i" (sizeof(struct bug_entry)),	\
>  		  ##__VA_ARGS__)
>  
> +#define ARCH_WARN_ASM(file, line, flags, size)		\
> +		"1:	twi 31, 0, 0\n"			\
> +		_EMIT_BUG_ENTRY(file, line, flags)	\
> +		".org 2b+" size "\n"			\
> +		".previous\n"
> +
> +#define ARCH_WARN_REACHABLE
> +
>  /*
>   * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
>   * optimisations. However depending on the complexity of the condition

Yeah, This makes sense.

I'll work on this and send out a fix soon.

Thanks and Regards,
Mukesh

