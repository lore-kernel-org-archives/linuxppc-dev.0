Return-Path: <linuxppc-dev+bounces-20259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A63FF8864
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 05:19:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g55FW02lKz2xls;
	Wed, 29 Apr 2026 15:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777439950;
	cv=none; b=EdjT15cUZyOQkrNqhP32Wni0BbredRmnXNu2r6AWS5YGFaNcUkxfTXTIhgtLqW0xEq7i1UlN2Xd8RcqWxVBODxnFWrp5kxfqgqMNyaLzauFJyPeFvMY/tjjZxZq1xBo9x9FpjG+ywNFDxPcWVGWkD5DFikxQVNeD0ex2DiYofTYN2lVo6a8I4P4k6Gg9jDTAMRGfktI8bwbWuKSX550qAxkutL5Re0IXN1fThVw4JV9X8+J9ZYXC4SfNyV1vzcrXaAzP0ygKi9D4vBt6jfk88GqBJBlthRhJ8tmOoiOkEs8mpWOpveT+NnoXljDOUkjn0Z8qY1mGcr+UfFNyaoLSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777439950; c=relaxed/relaxed;
	bh=wADOe/Ijbv0iSvyti5z+slPn7HaZRO67y/qPpz50QTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7ueTOuLJoytgsLhTjYEmTYZZ+bNMioAK4HGZgTrof8xuDtFoxlqf5SP3dMfyKDss7qilBkZaXseBqwFYibc+tOD+MxEv7nxaMjUTDe7LlKjIcTCZnkd45YJQAWGSwq1SnEJ2s9cID3pterRnx/JduzyI0HSIq7hW6gUENu75SNU/pWixrSeQ/s2pJpS77d5qlflhfyvuK7a9J4q1RDsiCf2rjn8LqS7y8M7BaGdSWCVW4B/LjtoP9XibAHtaM6S+2Cby0JvcDBhefZPQWob2fRZxZmyaayVcvF4oWix4zioOQlooTT6mJGt50BAi6N3JErxyoUMG/KWMJco4KHVIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fp92dXN5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fp92dXN5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g55FV1gnxz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 15:19:10 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so10436456a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 22:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777439948; x=1778044748; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wADOe/Ijbv0iSvyti5z+slPn7HaZRO67y/qPpz50QTE=;
        b=fp92dXN5Wfv+Q6Tt4AW7aVEipwMQnkKf9La97CDtF6/fdvcoh13SA7Z0+p9E2abXRI
         4RY4QG0uR+BKRC7Iphk9JQJjBQAPLBJOciwUrcg+4MfUOn/FM+0SBgpOvP+Hmb32zeK/
         C5z6gr42Re/1O3KV72QHQVgtaD1wqjCgp9qwFNnsbT+eLLqr5FQ6jZOKqIj7ldEkjYUB
         1XLBmbA0ApM+f5XV123Krr9TCEE/EJdwmtp67rwPrzvc+vlQ1MVJ/LM+t/JZXccmZ9EP
         pWALIA02hDipPSSTqixWUGveMiuV9Ddi6k/Akvc59WzzoKDJo5A+xTIae8dP8hL/uVOV
         k2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777439948; x=1778044748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wADOe/Ijbv0iSvyti5z+slPn7HaZRO67y/qPpz50QTE=;
        b=mKz35tyVIQ/B6eE1pAAOkkKjyzq9Qh1a9J+9yztEkqW9iAZPx+17Rkqjfh2/OW1f3z
         MGH7B2x5Y49uqosv2B1+bKX6m5agORHH02R0Op20d4DyeSOCNQNheFOEKFJt2jW3LAsX
         Cfw/814NBVo7W0q41nsRs5SN9n2PLta5JPzdV2Aq4XfoKqK+QmRnMqXLXqBW3MsNdwaQ
         z15IgSoDZ2mUOVACS6hOn/+K1tGQZTaiXN5/PXfHTJnkMN6TRF8zVJPi8hI9cYy4xVk2
         QTp9Xn+glA/qxrcdAHHATnKv7bGYHCE2MN97yaobp+PvMkLC/kwgYjB/7/cXQhpSFGoA
         sydQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jV5UBOjMn7UJ9FJm7nHXfim9/bTkFcSzl02A1RRYmYeOrWuEhoXFOX5ddm1hKfQjKlJRuUkjwRblivvg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLXK8SsIpIkv6I31OPGeS0jRI8+Z/DsJ3h+zPVdZqWsNllEIxu
	TowkM1Goj30rhXOeUGyRIYfByzyByc3u0+wcOuLYIm9CMsQwB/IgMi8g
X-Gm-Gg: AeBDiet8EapORT184ZOVPiMjplOmeGGaDR8le6A18s99sLOBA5tgBOaPSPgotIcP1Zw
	AuRRECJ+Qv3JP5UkOuYk3snbmDsBvVdqlSGkyK59mW0VVQIeUcpMs3SR0JCcf+UpCHtVrkVDb/O
	XgNEMwaqKyXIyggSi9INEtgGFc9EG7LBcmsz7hs7X9XMPHHuWRPSPTg17FaR4Sub5sAHRJsJzdM
	lLm9eZhxVWhNprNg8jmLSHP8lM1/jgY2671DczW4cE1NULRmZnD5S8zvRFxSmwP1isyE93QX4ZD
	Q9whnXUJksh5LcsIszIwWBIRURnOA3pEW0BdjS8b6NHvSVOdja0rBU4q4ZDCxG02JO1BQyA9w4x
	ff41Y1lZMCyYiiD39SLzKgAKlWELT5bNcZ7rLyb+ilT6svOesXm/B36LgatBOf8XKStRF1Xe9kF
	Hz2RhRbXwxYuumHh9YJgi3GIfK+R0MuJ2H4Psp+2qdWlHtnIehY5IlERY19FG8OdATKOzK+xcHc
	9Crqo2fMYI=
X-Received: by 2002:a17:90b:4c4a:b0:35b:e593:b1d7 with SMTP id 98e67ed59e1d1-3649201a3admr6483688a91.12.1777439947551;
        Tue, 28 Apr 2026 22:19:07 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([223.187.127.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a2a4b65dsm399601a91.14.2026.04.28.22.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:19:07 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:48:34 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, fujita.tomonori@gmail.com, viresh.kumar@linaro.org, 
	prafulrai522@gmail.com, gregkh@linuxfoundation.org, arnd@arndb.de, tamird@kernel.org, 
	mark.rutland@arm.com, lyude@redhat.com, lina+kernel@asahilina.net, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V15 6/7] rust: Add PowerPC support
Message-ID: <afGUgjRQJgu34Dfh@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260426105932.2270364-1-mkchauras@gmail.com>
 <20260426105932.2270364-7-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426105932.2270364-7-mkchauras@gmail.com>

On Sun, Apr 26, 2026 at 04:29:31PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> From: Link Mauve <linkmauve@linkmauve.fr>
> 
> For now only Big Endian 32-bit PowerPC is supported, as that is the only
> hardware I have.  This has been tested on the Nintendo Wii so far, but I
> plan on also using it on the GameCube, Wii U and Apple G4.
> 
> These changes aren’t the only ones required to get the kernel to compile
> and link on PowerPC, libcore will also have to be changed to not use
> integer division to format u64, u128 and core::time::Duration, otherwise
> __udivdi3() and __umoddi3() will have to be added.  I have tested this
> change by replacing the three implementations with unimplemented!() and
> it linked just fine.
> 
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> Link: https://github.com/Rust-for-Linux/linux/issues/105
> Link: https://github.com/linuxppc/issues/issues/451
> Acked-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Upstream Issue for powerpc target.
Link: https://github.com/rust-lang/compiler-team/issues/986

Regards,
Mukesh
> ---
>  arch/powerpc/Kconfig  | 1 +
>  arch/powerpc/Makefile | 2 ++
>  rust/Makefile         | 4 +++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e93df95b79e7..4ac897b650d4 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -285,6 +285,7 @@ config PPC
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RELIABLE_STACKTRACE
>  	select HAVE_RSEQ
> +	select HAVE_RUST			if PPC32
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_SETUP_PER_CPU_AREA		if PPC64
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index a58b1029592c..589613eaa5dc 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -61,6 +61,8 @@ else
>  KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
>  endif
>  
> +KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
> +
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  KBUILD_LDFLAGS	+= -EL
> diff --git a/rust/Makefile b/rust/Makefile
> index d70fb186cae9..54096ce8a675 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -400,13 +400,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
>  	-fstrict-flex-arrays=% -fmin-function-alignment=% \
>  	-fzero-init-padding-bits=% -mno-fdpic \
>  	-fdiagnostics-show-context -fdiagnostics-show-context=% \
> -	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference
> +	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference \
> +	-ffixed-r2 -mmultiple -mno-readonly-in-sdata
>  
>  # Derived from `scripts/Makefile.clang`.
>  BINDGEN_TARGET_x86	:= x86_64-linux-gnu
>  BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
>  BINDGEN_TARGET_arm	:= arm-linux-gnueabi
>  BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
> +BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
>  BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
>  BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
>  
> -- 
> 2.53.0
> 

