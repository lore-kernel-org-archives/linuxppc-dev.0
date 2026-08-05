Return-Path: <linuxppc-dev+bounces-25437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C550C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:21:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTzF5PbKz2y8c;
	Wed, 05 Aug 2026 22:21:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932473;
	cv=none; b=ErVbwlDJHGJyIz9kHUHC5ICLxsHm87ciXlVRmXiteLaiOyKkNA6bxpIpXPzj5eyYlzl8HsiNHIlyYdL2k4Ds397qHlY3kn67r4dYhWkNp6R5f2n9JTmKUOlfbnm2jD9wzyjz6elwvlakoju21SAgY+AAM63xNq9y4hSFTzRjmsvPsygmFoG/eKWSak4UwBeYDjFUeNrzCr0NVm5czp6fMW7zyTRAIsn7hTpSUviaI44/kB0YB8rGftwjXLXDkib9/FZIa+5alMKenqMQvuUVoyEcDm1nM2JZI9slWLxm8Q/AfKoNApDpKpe9+rlEAKBY+wcjlV31L21CyTexXuZi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932473; c=relaxed/relaxed;
	bh=f8fKXiu457ws+zyyN3JFRc3wwhL6ADOAY1a3PJv8Y14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2OEA+DMVnLE5RRqZ6Hb9FL+fqdwCaBEAdrF5CgxZJOoR6iIRrCjKgjZMv+WmqPRJpmvNikbhNZFExa0x4qhMfhKPxR14lOlO/ncDFxyxqRBCIsBCbtps1O9nm0hSFvgLuh7bfY3ZJgfdzzWcROqApauzAPzOHarLuOtqCIyndsaExuu7LifH2DH4XeuSafoMIneva9tQCc5SrCamXZT0XN2GqkALZJ73hNi7zJ2yHIQ5ZD3rCeuUK3QvVN6gCHsjrw/y2bIivOS0aodB1Y1IyrfxnhPTMCYBjwXnFGm2PTHlShLL1lztsLeZwKVKZ+ch7NJ2U0KqBm0nlST4CpPSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OdJds9AE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OdJds9AE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTzD6Ct3z2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:21:12 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso8851995ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785932470; x=1786537270; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f8fKXiu457ws+zyyN3JFRc3wwhL6ADOAY1a3PJv8Y14=;
        b=OdJds9AE++kAOg1BcG0LndCrcOaG+l5Qx77E5kwydd39va0othjgiq13rBVrYN+llj
         PbLtggxup2YAH0qY+HAGrw94DCdM2YQV8Bit2cikCCs6Wed0FWoeQ0AMkS8gvOyvOlaP
         p2/6xan4ihVeJykD0fgfR1EdYRoY7Rk/e7/w+VmjiEbD4V1qbRx69xCPIuPRzMScg6sd
         /bosjHF5QFeibMO16uMZq8wUL7O/5o0jY4h229eWxJoocU1/FCDixjiA0OXa0AsWTQ3J
         h35ZHuc2ALWE6ocOv7eu4lOG5yfg1LVSCuO6tnaYu7CyeWvmDEn17srQ4e1IbCglmpSi
         R1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932470; x=1786537270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f8fKXiu457ws+zyyN3JFRc3wwhL6ADOAY1a3PJv8Y14=;
        b=FUHmwxVXF0m88MN9H82WPJYyURyD2ntTvid7GbiZazdoj+QUX0bvKSZx9LrPzNBYGS
         zzX8+rhXqc2aAO2vWn5SYoBHClE6TMjdKJD9llIwxMlIYYaWxan908YuC9EQnDGasNXx
         bmhcuAHxEdonozvob3lhst9q0/UN6R2acLP1iMpPJMixRqne3Lu6TIisoBr7OWHhfwvC
         ILd5cFr0kZWTkaAfX9wFu7es5o4oSmwhLQDUduoSAZjV9z3e4S5W+nzSzRfZkcOJLjiU
         RlHE1ZwF1GgtKbY5kjAjW2Ru/x8+USdu2ZYPJQ/thjzaAgnZHay1j8tMX26m+YdRa0Qb
         FElA==
X-Forwarded-Encrypted: i=1; AHgh+RrWjNhxGYqUHoY+EFHNm9GIkiKJjwmubJ8/LPQSMXudylrs0nwySW99glYCQhGEkArIAEyXcH+aeCdDV4k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKavGVVHsRsphhtopiTea8M7AV+MTfFRgVHl98KbvAV4JhPBVv
	9P5wHyulbysGeO94b9b5C9f1HCnTDrwHq6tKkfzUSYAQ2alXPFJ3n8zp
X-Gm-Gg: AR+sD11/PrjZuC7pZd26l0unkEtW4tb1r4o9pif6yqCAC7jBfSJ1dPm+OgfSGHTGv9J
	1jieWfvyc8euomV+HEDhMlxAvEPtvF8rRfjDvjvGLEYfQjAsoMxCG7KpDAG3CGoNh7c95puHCgR
	j71gcuMuPxZSzs1dqJM+w1t3juYqGMEAvjXL/qE2qQHfFzcUVSodzZWv8N5xAZC5cvUbzKcHteV
	8iz5bIzwu6oulii8+Dj0T5LD+RGSSbG9l3oGRGlIMvHh9gx1umm45dct6tTQNLtasmuvdvQqZi3
	guj1dgiQWkk7bvalMyTe8L4Olu21lWlTUjd/VdlJKbdAaid2hS9JChqhTdnPsOCDXTJj1Bk0AgC
	fqKARBCg/Gu10CTFz8rhQevUbXqYpSeP6gpuqbuQ+p6ZN5QrS190l9+hu8o8z/bS4UaVYaGDvu4
	vLwAG3CenNICTSEF+qGAhAaAMOg2K4kMXIdkNNf0kChFWZzr1+LSnoBCythcl0wCeKmG3kB9f0b
	g+woshN81IEOIyts3Lp90NF/fuoUAuEf9YT
X-Received: by 2002:a17:903:2312:b0:2c9:d88e:f996 with SMTP id d9443c01a7336-2d0ca7fa497mr66481405ad.9.1785932470282;
        Wed, 05 Aug 2026 05:21:10 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.161.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4bda53sm15577065ad.63.2026.08.05.05.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:21:09 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:50:54 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, 
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, fujita.tomonori@gmail.com, 
	joelagnelf@nvidia.com, gregkh@linuxfoundation.org, prafulrai522@gmail.com, 
	nsc@kernel.org, japo@linux.ibm.com, lina+kernel@asahilina.net, j@jannau.net, 
	airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Message-ID: <anMqe3eVCZVxgoPj@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
 <anG67Q6Y59kDqh-c@desktop>
 <20260804202217.GA1109939@ax162>
 <anMnoT0KLd5PRGmX@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <anMnoT0KLd5PRGmX@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Wed, Aug 05, 2026 at 05:40:42PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Aug 04, 2026 at 01:22:17PM -0700, Nathan Chancellor wrote:
> > On Tue, Aug 04, 2026 at 12:11:57PM +0200, Link Mauve wrote:
> > > Hi,
> > > 
> > > On Mon, Aug 03, 2026 at 12:27:13PM +0530, Madhavan Srinivasan wrote:
> > > > On Wed, 08 Jul 2026 13:54:47 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > > > Enable experimental rust support for ppc64le and ppc32be. The patch for
> > > > > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> > > > > merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> > > > > `rust: Add PowerPC support` and the discussion for that is done here[1].
> > > > > 
> > > > > This has been tested on
> > > > > - powernv9 hardware
> > > > > - pseries P11 hardware
> > > > > - pseries(9, 10) qemu
> > > > > - powernv(9, 10) qemu
> > > > > - rustdoc on x86 and powerpc64le
> > > > > - rusttest on x86 and powerpc64le
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied to powerpc/next.
> > > > 
> > > > [1/7] rust: Fix "multiple candidates for rmeta dependency core" error
> > > >       https://git.kernel.org/powerpc/c/00cdfd072c709c608606461d7d44d4613119bfa9
> > > > [2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
> > > >       https://git.kernel.org/powerpc/c/be809b60cbb61aab96179f44ac3670242ae72996
> > > > [3/7] powerpc/jump_label: adjust inline asm to be consistent
> > > >       https://git.kernel.org/powerpc/c/13244c0a40139fe66c4c5c5655f4d732a6002957
> > > > [4/7] rust/powerpc: Set min rustc version for powerpc
> > > >       https://git.kernel.org/powerpc/c/e299147cdc8e19c6421a6b7863dc82a35b09d967
> > > > [5/7] rust: Make __udivdi3() and __umoddi3() panic
> > > >       https://git.kernel.org/powerpc/c/c93c194e4ee71a734986fd99a8b1ec9fbb7a9b8b
> > > > [6/7] rust: Add PowerPC support
> > > >       https://git.kernel.org/powerpc/c/73b741adb264967093ef4eb59905618a7e0d0de0
> > > > [7/7] powerpc: Enable Rust for ppc64le
> > > >       https://git.kernel.org/powerpc/c/bc87cbdb952e9223616b839d64bdb4723aa2ed1d
> > > > 
> > > > cheers
> > > > 
> > > 
> > > I just tested those again in linux-next, with the Wii support series on
> > > top, but now the kernel fails to build due to ARCH_WARN_ASM and
> > > ARCH_WARN_REACHABLE not being defined on PowerPC:
> > 
> > I also see the following warnings (in addition to that error):
> > 
> >   warning: unknown and unstable feature specified for `-Ctarget-feature`: `mma`
> >     |
> >     = note: it is still passed through to the codegen backend, but use of this feature might be unsound and the behavior of this feature can change in the future
> >     = help: consider filing a feature request
> > 
> >   warning: unstable feature specified for `-Ctarget-feature`: `vsx`
> >     |
> >     = note: this feature is not stably supported; its behavior can change in the future
> > 
> >   warning: unknown and unstable feature specified for `-Ctarget-feature`: `hard-float`
> >     |
> >     = note: it is still passed through to the codegen backend, but use of this feature might be unsound and the behavior of this feature can change in the future
> >     = help: consider filing a feature request
> > 
> >   warning: unstable feature specified for `-Ctarget-feature`: `altivec`
> >     |
> >     = note: this feature is not stably supported; its behavior can change in the future
> > 
> Hey Nathan,
> 
> For these i'll raise issues.
Here's bug on rustc for the same.
https://github.com/rust-lang/rust/issues/160561

Regards,
Mukesh
> >   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:5:9: warning: '_IOC_SIZEBITS' macro redefined [-Wmacro-redefined]
> >   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:6:9: warning: '_IOC_DIRBITS' macro redefined [-Wmacro-redefined]
> >   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:8:9: warning: '_IOC_NONE' macro redefined [-Wmacro-redefined]
> >   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:10:9: warning: '_IOC_WRITE' macro redefined [-Wmacro-redefined]
> >   warning: 4 warnings emitted
> > 
> For these warnings below diff should fix it. I'll send out a patch soon.
> 
> diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
> index 06d7d1a2e8da..acec2d2fede7 100644
> --- a/rust/uapi/uapi_helper.h
> +++ b/rust/uapi/uapi_helper.h
> @@ -6,7 +6,7 @@
>   * Sorted alphabetically.
>   */
>  
> -#include <uapi/asm-generic/ioctl.h>
> +#include <uapi/linux/ioctl.h>
>  #include <uapi/drm/drm.h>
>  #include <uapi/drm/nova_drm.h>
>  #include <uapi/drm/panthor_drm.h>
> 
> Regards,
> Mukesh
> 
> > when building this series in next-20260804 with rustc 1.97.1. I am not
> > sure where the clang diagnostic warnings come from. I assume the target
> > feature warnings are expected but it would be good to get those
> > addressed sooner rather than later. I see '-hard-float' has an issue
> > open
> > 
> >   https://github.com/rust-lang/rust/issues/117347
> > 
> > but I don't think I see issues open for the other ones.
> > 
> > -- 
> > Cheers,
> > Nathan

