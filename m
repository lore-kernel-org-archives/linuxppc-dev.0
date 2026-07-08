Return-Path: <linuxppc-dev+bounces-23780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB2BC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:18:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw9wZ2BQZz3054;
	Wed, 08 Jul 2026 18:18:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783498734;
	cv=none; b=DYmmy7x9x+Qpsx+HmRDN2X8njUb181kx9o1WKOpugQXqfO8bPub7ktC4ZShPetTnb3N3JHgPkyEKLrlIPcBRiQvI1l7hcSRxSW1XvTAFljZrmEEIUNRDoMA+d/duAsaeDSqHJ5fqIPSv+qPW6MDmTuKnoJSI/dcn+0IDHLcA5iUagpaZxpmRg/KrcWmKrgd0/+rWkgAc/ndQSqUIliNUC8D9dALJmxASFnXg4eK3pIrqEYGtoujuPTFUSZfbaP3AmyI4Z+RyxYObLeKQ+bYzdSxZdO4CrREKJev7vrLlNURbBymSqkU1W5zR+xkbdSwnkTSDpefw3KcnFvDPEHtxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783498734; c=relaxed/relaxed;
	bh=59q6kMti6TEuYkK2zAzI9NhF5BHSzay0sLHoUMAZAzs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOYJ5SuC7lkND3Dm0D1bWv3unKB3a2lU4TWa3IhCOVlOWZYTgtzuddjoRJOGfBuc3Ee23tUP09gr5Vz4fPqbRQQMprMPnAJVlFCkIzUAvr7A7eNyJPo366JEVWVwob5eJx1Eue4/pQq1IG/N/d84jG+2/OxEe95fFY8B29eUQaG6Er1qb5xPsgJwOqOr9oBuaq1awYSIMGBMvLNWGEhplozw+NA2BkbUIUwB1BsTT+H/w9vEnJosWZj+f3vYuKQh0biLU20hFcPPBlnd+htfAuZ6ldKmnUNVeFeUXR443HakL5amtLEfUiiA5PuCGSeXKRhxJs4ycvLDdnRtw2Sejw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K8bjQI/b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K8bjQI/b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw9wY3brBz3046
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:18:53 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso449607b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783498731; x=1784103531; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59q6kMti6TEuYkK2zAzI9NhF5BHSzay0sLHoUMAZAzs=;
        b=K8bjQI/brDgZfgSpfrDaBKsKtb1kUdgRlf2q8KFINKDKOsJcgOY/o+OoLOGP+3plxd
         hKXQYPNStULu90/1k1CpBFUlqNj8qs2MwytHQ9A5CcOJyOv6ReTQ5vr01Mliamzp7nyN
         RA/DfKCy1ynjVNaXL3WBz413dqC2xdRRTeu4B8C1S6vh1MVRf2+ceRft68gAYQiMPpMq
         DQhaAsF8Ym+Dh3aVDerGm8IAyv+b1OBGmlk5bu+m7y3ZJ2l8ErJ47xaNhTmxWQiVT4AF
         56Muhpk4KQuQ671hUxSfu9l0JqQKqdCejukZ6oNO7wXXEaElZWPQug4M5KbrZwT13HCV
         z37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783498731; x=1784103531;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59q6kMti6TEuYkK2zAzI9NhF5BHSzay0sLHoUMAZAzs=;
        b=kPnUy9bOHkYku2Yhi2mwqXH4qM1CBuo69g0PrG16vZVqmlLDPU2tbMEd1o1N1h2vfQ
         XratcGKjMYUyoXSAMkWVPcK5j2PnAv9cTjYUws5KF0bXUv9JbLwvggbQka+pXn85lZ/t
         UvbB9zFUg19x2Cm0m/OlePmrhOOYwg7zIG9UY5bMzGs083FYRJks3w9AntJnNewss/Zy
         HFvfiB+8fmu7opRRM3O1cIYxtWvHv+ztS1Vzma3v3j+xtNHfsByFZfQxuz+m15w1vUAg
         4uBHW66m7tG/jwm8hoezEmkSe1o6NIrFKNcBebB/HPbm7d4fuMjxeqr1Sp3coWRbZCfk
         rSDw==
X-Forwarded-Encrypted: i=1; AHgh+RoObTezZbbJcqsok6irT/nrqMcCWbudMGGHuH3fAlFvyPjoAdQ5gznCPVUrcF5uBnMZeoCl6xY+ODl6k2Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwkOQQvVeC78CElQjIP8iTPKipe+YIBnceqIHHvQK/gIABSyZ6W
	uCmNsQm4iGf6CmSm/Kylc9/f4qgM/0oGrCbBCcBNJNu8fdroO23huSx2
X-Gm-Gg: AfdE7cl/Cj0PRzoytbJgrYWCPSpungSXE29aunJp1R2uGvaD3/+S+dEvknDgESa2gOS
	rpHHhTyUyg7xkv+bamVI3sL3LTRG3606o5ysgeRpXTfmcbRwMYDt8nVIgQoybuRcprY7FDpapI2
	yQBAfGVdGHIY8pT2z8/sNEruFBMOgYGbQNYxN4DVImT1TPZByVt+URmMpynneZGX7nzxkipGoDC
	XFzdlNlnr8AzlJtRrm2uJDJx0MyAQNyr08LSoGgy7TvVWD9XKlOO68JGn0ShMrEZ48bsL2e/i9D
	OzjuHfoaQq0GTtHZTgZX7Z7PNzSvfy1d8KLzSV7q+DU1rKmJmhJEINILZCYCNVTRg1G/0hD+fVD
	vhVS+bzn0GT9GpSnBZu+o6Li9ami/KPAXanmUXSUWTliPFyl9mnrJx0r4zoNCddRHC/J79zksTE
	uWQm7G80fiOJBGVePeJvdm29lyVd84Kkr8p+ur++HryxaZfjTqmaZBr6fS6zpU
X-Received: by 2002:a05:6a00:ad6:b0:845:c8f9:6ce0 with SMTP id d2e1a72fcca58-84842f2af17mr1578608b3a.21.1783498731120;
        Wed, 08 Jul 2026 01:18:51 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162a49sm2012879a12.15.2026.07.08.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:18:50 -0700 (PDT)
Date: Wed, 8 Jul 2026 13:48:35 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, oleg@redhat.com, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, msuchanek@suse.de, sshegde@linux.ibm.com, mchauras@linux.ibm.com, 
	thuth@redhat.com, segher@kernel.crashing.org, ryan.roberts@arm.com, 
	fujita.tomonori@gmail.com, joelagnelf@nvidia.com, prafulrai522@gmail.com, 
	gregkh@linuxfoundation.org, nsc@kernel.org, japo@linux.ibm.com, lyude@redhat.com, 
	lina+kernel@asahilina.net, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V17 0/8] Rust Support for powerpc
Message-ID: <ak4HwGN_rJ9UN0Rt@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260708081633.1248382-1-mkchauras@gmail.com>
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
In-Reply-To: <20260708081633.1248382-1-mkchauras@gmail.com>

On Wed, Jul 08, 2026 at 01:46:25PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Enable experimental rust support for ppc64le and ppc32be. The patch for
> ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> `rust: Add PowerPC support` and the discussion for that is done here[1].
> 
> This has been tested on
> - powernv9 hardware
> - pseries P11 hardware
> - pseries(9, 10) qemu
> - powernv(9, 10) qemu
> - rustdoc on x86 and powerpc64le
> - rusttest on x86 and powerpc64le
> 
> We are actively working with our LLVM team to get the target for ppc,
> ppc64 and ppc64le in the rust compiler.
> 
> [1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
> [2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com
> 
> Changelog:
> V16 -> V17:
> - Rebased to latest v7.2-rc2 
> 
> V15 -> V16:
> - Rebased to latest v7.1-rc4
> V15: https://lore.kernel.org/all/20260426105932.2270364-1-mkchauras@gmail.com/
> 
> V14 -> V15:
> - Fix an issue with rustdoc build on ppc64le
> V14: https://lore.kernel.org/all/20260426085725.2090827-1-mkchauras@gmail.com/
> 
> V13 -> V14:
> - 2nd patch is rewritten (Christian)
> - Fixed a small typo in rust/Makefile (Sashiko)
> - Fixed commit message in Patch 4 (Sashiko)
> V13: https://lore.kernel.org/all/20260424054742.45832-1-mkchauras@gmail.com/
> 
> V12 -> V13:
> - Added a patch for fixing build issue on ppc32 by Link Mauve
> - Added another patch to fix a build issue in dma-buf
> - Added another patch to enforce minimum `rustc` version for powerpc
> V12: https://lore.kernel.org/all/20260421120958.190430-1-mkchauras@gmail.com/
> 
> V11 -> V12:
> - Rebased to mainline (rust/Makefile conflict resolved)
> V11: https://lore.kernel.org/all/20260417152253.2312961-1-mkchauras@gmail.com/
> 
> V10 -> V11:
> - Updated `rust/Makefile`
> - Not all libraries are move to `rust/host` directory now. Only
>   proc_macro2, quote and syn are moved
> - Special handling for pin init is added. Details in commit
> - Removed mkdir for `rust/host`, this is now handled by toolchain.
> V10: https://lore.kernel.org/all/20260406200149.3727922-1-mkchauras@gmail.com/
> 
> V9 -> V10:
> - rust/Makefile updated with review comments from Miguel
> - Patch 1/4 updated with commit message and subject
> V9: https://lore.kernel.org/all/20260404121610.1956528-1-mkchauras@gmail.com/
> 
> V8 -> V9:
> - rust/Makefile updated with a directory instead of abspath
> V8: https://lore.kernel.org/all/20260403145308.1042622-1-mkchauras@gmail.com/
> 
> V7 -> V8:
> - rust/Makefile updated to separate host libraries from target
> V7: https://lore.kernel.org/all/20260329160254.2592207-1-mkchauras@gmail.com/
> 
> Changelog:
> V6 -> V7:
> - Documentation removed as powerpc is still under development
> - Added a fix for race condition in rust/Makefile
> V6: https://lore.kernel.org/all/20260210090023.2587534-1-mkchauras@gmail.com
> 
> V5 -> V6:
> - Added a missing Tested by from Venkat which got missed since V3
> - Support is marked as Maintained instead of experimental
> V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@gmail.com
> 
> V4 -> V5:
> - Removed a nested ifdef from PPC64 for Little endian toolchain
> V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@gmail.com
> 
> V3 -> V4:
> - Co-developed-by header added in patch 1
> V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@gmail.com
> 
> V2 -> V3:
> - Splited HAVE_RUST in 2 lines
> - BINDGEN_TARGET_powerpc initialized before assigning the same to
>   BINDGEN_TARGET
> V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gmail.com
> 
> V1 -> V2:
> - jump label fix for rust has been moved to a separate patch
> - PPC32 support has been taken
> - rust support has been marked experimental
> - target.json dependency has been removed
> - HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
> V1: https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com 
> 
> Link Mauve (2):
>   rust: Make __udivdi3() and __umoddi3() panic
>   rust: Add PowerPC support
> 
> Mukesh Kumar Chaurasiya (IBM) (6):
>   powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
>   rust: Fix "multiple candidates for rmeta dependency core" error
>   dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is
>     disabled
>   powerpc/jump_label: adjust inline asm to be consistent
>   rust/powerpc: Set min rustc version for powerpc
>   powerpc: Enable Rust for ppc64le
> 
>  arch/powerpc/Kconfig                   |  2 +
>  arch/powerpc/Makefile                  |  7 ++++
>  arch/powerpc/include/asm/jump_label.h  | 23 ++++++-----
>  arch/powerpc/include/asm/ptrace.h      | 22 +++++++++-
>  arch/powerpc/include/asm/syscall.h     |  6 +++
>  arch/powerpc/include/uapi/asm/ptrace.h |  6 ++-
>  arch/powerpc/kernel/ptrace/ptrace.c    |  2 +
>  arch/powerpc/kernel/syscall.c          | 18 +++++++++
>  rust/Makefile                          | 56 +++++++++++++++++---------
>  rust/compiler_builtins.rs              |  6 +++
>  rust/helpers/helpers.c                 |  2 +
>  scripts/min-tool-version.sh            |  2 +
>  12 files changed, 119 insertions(+), 33 deletions(-)
> 
> -- 
> 2.55.0
> 

Please ignore this.

Regards,
Mukesh

