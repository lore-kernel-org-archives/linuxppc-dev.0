Return-Path: <linuxppc-dev+bounces-25393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C277DC55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 20:39:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF54h3y9Gz2yMl;
	Wed, 05 Aug 2026 06:39:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785875972;
	cv=none; b=HhEQEbv47LVlTFRJ29gsV4GvHsKmjEvy+MZ2Fy1BswVwAXiZIpu9zboNrgxn2PDLIix5DyYWSuUC1yZeh1crurw5OK6MBi4pe+4L8WrxczswHgpybiZp7WtsxDY6hA6z3exEhGss8DM5W/rPIKQKkKxjAhy8iiWRDUJanbE6xN+j/7hu0RtyD9YKyP7hGMot2fn4HnsDUY9nfS86tBB8DyomqI9avg/803iKKT8RTgLYDf/j0Q/145XOw1wfzVrDwtXKXXyM4Fz5GoK5ktk4hriR5bi9B8akKgDmZv1GvVqYN4kCf162WUdVTIgGfN/KUx8LgeUDZ0M5b9LepuUIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785875972; c=relaxed/relaxed;
	bh=C0xWssrTetXfZtRCdVxJiXHUZuqnRag+Pm8HQskuXxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5gcS5L/+VXY987tBk387xsMme7KU3u53gF/7oRcZoxXegOU/vU2lPGgO+dZs2M4/z63dh3EhEzxvJa4tJ0TJEZl642zTCp6Fi/35a0FZpJndx1VPnlE/bvo1PxxK5GFAvlbJxcn7hYnY+dsP5l0/mmdpTJZn/lzNoO5uql7JGFKKVZQHDydrOadOpcD3Cg2JNrmzO3dq2lGcGW56OSmYJPm+cq0TQvIfZQDVPINJalsB7EcOgdJVHnltLjqMcomzGbWFaSvszqJxn6nHuA6EBEtCJMLOET4oTm4oMRbUNtXcl/SOl1q3xgol3FuvWLQ9XeT1q6yz8jCIrODW3Hmdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF54f4dZ5z2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 06:39:30 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 5E9B870A0AA0; Tue, 04 Aug 2026 22:39:27 +0200 (CEST)
Date: Tue, 4 Aug 2026 22:39:27 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org,
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com,
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com, gregkh@linuxfoundation.org,
	prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com,
	lina+kernel@asahilina.net, j@jannau.net, airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Message-ID: <anJN_3eAlTqxqfnI@desktop>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804202217.GA1109939@ax162>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

On Tue, Aug 04, 2026 at 01:22:17PM -0700, Nathan Chancellor wrote:
> On Tue, Aug 04, 2026 at 12:11:57PM +0200, Link Mauve wrote:
> > Hi,
> > 
[…]
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

Those four are explicitly disabled in arch/powerpc/Makefile, but only
for CONFIG_PPC64, not for CONFIG_PPC…  Maybe they should, I’ve only
tested 32-bit on the Wii which has no altivec or vsx, but has hard
floats, and I’m not sure about mma.

Could you test this patch on your platform?  I’ll submit it properly if
it does fix those four warnings:
```
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9385db478c59..8fba9310acfa 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -63,10 +63,10 @@ endif

 ifdef CONFIG_PPC64
 KBUILD_RUSTFLAGS       += --target=powerpc64le-unknown-linux-gnu
-KBUILD_RUSTFLAGS       += -Ctarget-feature=-mma,-vsx,-hard-float,-altivec
 else
 KBUILD_RUSTFLAGS       += --target=powerpc-unknown-linux-gnu
 endif
+KBUILD_RUSTFLAGS       += -Ctarget-feature=-mma,-vsx,-hard-float,-altivec

 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CPPFLAGS        += -mlittle-endian
```

> 
>   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:5:9: warning: '_IOC_SIZEBITS' macro redefined [-Wmacro-redefined]
>   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:6:9: warning: '_IOC_DIRBITS' macro redefined [-Wmacro-redefined]
>   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:8:9: warning: '_IOC_NONE' macro redefined [-Wmacro-redefined]
>   clang diag: arch/powerpc/include/uapi/asm/ioctl.h:10:9: warning: '_IOC_WRITE' macro redefined [-Wmacro-redefined]
>   warning: 4 warnings emitted

I have no idea about those.

> 
> when building this series in next-20260804 with rustc 1.97.1. I am not
> sure where the clang diagnostic warnings come from. I assume the target
> feature warnings are expected but it would be good to get those
> addressed sooner rather than later. I see '-hard-float' has an issue
> open
> 
>   https://github.com/rust-lang/rust/issues/117347

In the kernel we want to disallow all floats, unless there is a very
specific and cibled usecase.  This issue is about enabling them.

And no, warnings are never expected, you just tested on a platform
neither of us tested until now. :)

> 
> but I don't think I see issues open for the other ones.
> 
> -- 
> Cheers,
> Nathan

-- 
Link Mauve

