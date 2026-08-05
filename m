Return-Path: <linuxppc-dev+bounces-25436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A72FC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:11:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTlW3jlWz2yMl;
	Wed, 05 Aug 2026 22:11:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785931863;
	cv=none; b=ODekReiCAwLnmVqxpGhJUF7II/1Fi6pQI1HfBzv6zoQRCjO/UjlOkyGp1y3vqfhYlYCmtPJSKG/bOrf9yGg2Nb5q36emJVraLD5m1ruwnVilaHk6WMgxW2NvBG0LIgNB+wR76qEXf4hcWzYEmq/flTpD/ncXqi+nkxEVJQYBCr0abfXKJEreIzZgnxYpB4afw1plERsSBYStJVVBKcw+fakfK1ue9e23bJzf+eNExEDJFDrPK0Kd4fuotRZMacDRirViKPwB6aSBzGEAh+Z4rZi3qysMKoSklYJe+jx+ajakkns5rqKk9ZHXlFijhs79ILN8loRtPBrZH/ZJD6EQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785931863; c=relaxed/relaxed;
	bh=RZ+Qj6t2nj2/2rI2iQ3ztizRdb4KUFylPQ/pRqcseoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CspQ0IavkdGMa0v/B7H+43j7MYAWH26nWn2dMka4Gc8dh9JLD2Q6HzZHh+tMARYXYgYoXKIF6fNpjYwd3iV6WGkv2/dDaVW5MZ1jcLXcIOLuIWcj4ZyXLr06FQSOnciUZW23oAVrgLmv1H/48oekE6otU9yPEXH464q4E8ZiwncGv/n6QPKSX1L3R9dss7Z0Gwtjgw+JoZMMwJnpqzii5lmujpUfq9dpLpTlDxawWwXFKfmeL93pIU6q9ebD13dp2+tcKW7bzS4FljI878UrFEjFOa1c7LbOB1c8eDvjEmr7x/CF0tq9rSrMrESMoZaDGwkAQqbEFgQ+AlUpsv+bGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rUeOfK0X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rUeOfK0X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTlV1fGMz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:11:01 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-8486672f03cso1087995b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785931859; x=1786536659; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RZ+Qj6t2nj2/2rI2iQ3ztizRdb4KUFylPQ/pRqcseoU=;
        b=rUeOfK0XROUHWBumDIlRB7DvawUhhrgwoPRs+5zNclLtB/oGEywZIHuUak1EfvGhvf
         c+VtstJ4KGeHsQnW8qBYdsxWirLzEmX0jTgXWl4FaxqFJy2wNVb5VQ3dnSY962DaU73+
         YONfYnbmZxN61kqF6cSRY1Gw1l36Jp4mz6YmxEGaxGaT4JCvTqvW7W4j15MpSJYO9Dtv
         t8nzy181oDHHmRbbFRnxgI7tO7zDeKl+ylleN2+94wKHBMLc8jVV4Ij+Lyh1QdVIYfgt
         ULq1vRWw7B0yoIWzZQ0ScBfcRIpj4IuYsYIdRhOJ9dM/6o/zkIYgMX0W0Bkdbf8MJsIt
         Oacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785931859; x=1786536659;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZ+Qj6t2nj2/2rI2iQ3ztizRdb4KUFylPQ/pRqcseoU=;
        b=BcEi2t4/k2MKnkiGkxCQxMfMVJFFyV+cgcX2hSdiIwiz/4++br2oVR4EWiSqE/BhWt
         UeJdWPn7blHTk+ZWb7JVVFps1ANVgMEXTs58ZalK1/wbhRWbQZk/G2xsuSgCi/32+Qp4
         yFoxQD/THNmYj5dU/KS/i0jYMx3bEiyd14lZvi2vxa8N+nms9FyRi5BUJJxGwUI48MIQ
         MQc4F1XxBuhxf/KB5YwCSDeH9o4kKW5iCYhQQYNREjEZ+UIwB3PR8AK50pQR5JYZ+eiG
         X6laKIa05Bxv9RFo4pbwnDK4cGa5oH9AA+vQjxz/6HdpBNG9D6+/0bONVRmNGInRypVK
         cPsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKCkPhx+hV/l8h1sChAV5dgEoMdOGWLkeXq8ljpTiMh48RozuAUD4oPT7wwvP0ueMsL/cdB9u+/Er4vZY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1RE0M/YMTrumj9Gd+x5geb5gYIwK4D+3kNZsNQQ8eRiCQkAK7
	WJPeMYNfPTVO16xvwgsGpYq3dqK2KsIpRZKvV9G49BSeYICos+z9c2Oj
X-Gm-Gg: AR+sD12sNJL2/a909ABNNizQSqTl0HPoYI2jgSMuoTTyBE95Ypac1r8frZAMNzdGyDa
	wK90yPfxu5HQYBrPMVUaUVW8soBujWb3kAkWDLA5DgO/ZS60v3F6unpNwCICufn57kHzaZmm2YY
	Rwc7XVJnS3Wy1LLU3gjBJHQIpQ3zJp1LwhbDZl66DKbUBu/fXrWrvsX++pvGtlac17hUnQaKamb
	3RmANyERy+tEwC0HBHNFwpF8XIMK4nVrQctPhM9Ey4Lsjzd0iWtKh2f8LCsZOA/tlrbKZthxOzP
	fHevrehThnx4hr3wMoaB1q7LHWOua9dLcdStk3gXi0G476J/BiHuLkF8Bj/RATUAZiME+nvuTCP
	7tnIXBDBWV7ez+POLMLrvH3RBozoLAPNG+2Pcf+e76NWgg4+jW0zdggKzVvoWz4wJQw4ihxf+2f
	v4ZltGmh+HxkjD2ncH+EfTDDGb4XRX7zjvGmiYgYBseAFVtMnqHXuOjQYclZipeI7p+OPg6K32q
	XNa2nv297Uwaf5EO4J19X3Q6bi5gZberbgk
X-Received: by 2002:a05:6a00:c93:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-84f2de6ab12mr6280866b3a.0.1785931858748;
        Wed, 05 Aug 2026 05:10:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.161.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e52f84esm732908b3a.57.2026.08.05.05.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:10:58 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:40:42 +0530
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
Message-ID: <anMnoT0KLd5PRGmX@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
 <anG67Q6Y59kDqh-c@desktop>
 <20260804202217.GA1109939@ax162>
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
In-Reply-To: <20260804202217.GA1109939@ax162>

On Tue, Aug 04, 2026 at 01:22:17PM -0700, Nathan Chancellor wrote:
> On Tue, Aug 04, 2026 at 12:11:57PM +0200, Link Mauve wrote:
> > Hi,
> > 
> > On Mon, Aug 03, 2026 at 12:27:13PM +0530, Madhavan Srinivasan wrote:
> > > On Wed, 08 Jul 2026 13:54:47 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > > Enable experimental rust support for ppc64le and ppc32be. The patch for
> > > > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> > > > merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> > > > `rust: Add PowerPC support` and the discussion for that is done here[1].
> > > > 
> > > > This has been tested on
> > > > - powernv9 hardware
> > > > - pseries P11 hardware
> > > > - pseries(9, 10) qemu
> > > > - powernv(9, 10) qemu
> > > > - rustdoc on x86 and powerpc64le
> > > > - rusttest on x86 and powerpc64le
> > > > 
> > > > [...]
> > > 
> > > Applied to powerpc/next.
> > > 
> > > [1/7] rust: Fix "multiple candidates for rmeta dependency core" error
> > >       https://git.kernel.org/powerpc/c/00cdfd072c709c608606461d7d44d4613119bfa9
> > > [2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
> > >       https://git.kernel.org/powerpc/c/be809b60cbb61aab96179f44ac3670242ae72996
> > > [3/7] powerpc/jump_label: adjust inline asm to be consistent
> > >       https://git.kernel.org/powerpc/c/13244c0a40139fe66c4c5c5655f4d732a6002957
> > > [4/7] rust/powerpc: Set min rustc version for powerpc
> > >       https://git.kernel.org/powerpc/c/e299147cdc8e19c6421a6b7863dc82a35b09d967
> > > [5/7] rust: Make __udivdi3() and __umoddi3() panic
> > >       https://git.kernel.org/powerpc/c/c93c194e4ee71a734986fd99a8b1ec9fbb7a9b8b
> > > [6/7] rust: Add PowerPC support
> > >       https://git.kernel.org/powerpc/c/73b741adb264967093ef4eb59905618a7e0d0de0
> > > [7/7] powerpc: Enable Rust for ppc64le
> > >       https://git.kernel.org/powerpc/c/bc87cbdb952e9223616b839d64bdb4723aa2ed1d
> > > 
> > > cheers
> > > 
> > 
> > I just tested those again in linux-next, with the Wii support series on
> > top, but now the kernel fails to build due to ARCH_WARN_ASM and
> > ARCH_WARN_REACHABLE not being defined on PowerPC:
> 
> I also see the following warnings (in addition to that error):
> 
>   warning: unknown and unstable feature specified for `-Ctarget-feature`: `mma`
>     |
>     = note: it is still passed through to the codegen backend, but use of this feature might be unsound and the behavior of this feature can change in the future
>     = help: consider filing a feature request
> 
>   warning: unstable feature specified for `-Ctarget-feature`: `vsx`
>     |
>     = note: this feature is not stably supported; its behavior can change in the future
> 
>   warning: unknown and unstable feature specified for `-Ctarget-feature`: `hard-float`
>     |
>     = note: it is still passed through to the codegen backend, but use of this feature might be unsound and the behavior of this feature can change in the future
>     = help: consider filing a feature request
> 
>   warning: unstable feature specified for `-Ctarget-feature`: `altivec`
>     |
>     = note: this feature is not stably supported; its behavior can change in the future
> 
Hey Nathan,

For these i'll raise issues.
>   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:5:9: warning: '_IOC_SIZEBITS' macro redefined [-Wmacro-redefined]
>   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:6:9: warning: '_IOC_DIRBITS' macro redefined [-Wmacro-redefined]
>   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:8:9: warning: '_IOC_NONE' macro redefined [-Wmacro-redefined]
>   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:10:9: warning: '_IOC_WRITE' macro redefined [-Wmacro-redefined]
>   warning: 4 warnings emitted
> 
For these warnings below diff should fix it. I'll send out a patch soon.

diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 06d7d1a2e8da..acec2d2fede7 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -6,7 +6,7 @@
  * Sorted alphabetically.
  */
 
-#include <uapi/asm-generic/ioctl.h>
+#include <uapi/linux/ioctl.h>
 #include <uapi/drm/drm.h>
 #include <uapi/drm/nova_drm.h>
 #include <uapi/drm/panthor_drm.h>

Regards,
Mukesh

> when building this series in next-20260804 with rustc 1.97.1. I am not
> sure where the clang diagnostic warnings come from. I assume the target
> feature warnings are expected but it would be good to get those
> addressed sooner rather than later. I see '-hard-float' has an issue
> open
> 
>   https://github.com/rust-lang/rust/issues/117347
> 
> but I don't think I see issues open for the other ones.
> 
> -- 
> Cheers,
> Nathan

