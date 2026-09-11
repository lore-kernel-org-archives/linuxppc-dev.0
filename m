Return-Path: <linuxppc-dev+bounces-27127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABC6C88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:32:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFp74JZpz2ypW;
	Fri, 11 Sep 2026 23:32:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789104109;
	cv=none; b=hJAlPtFOuyFsQPuuoUtUI4HvoJHS/dkZ2uBQwvubTTPsoACkW2qhTAhEAnCgeB8Tkz8nnRXrjura7WMZLftvgBNPvqgRgF8ETc8UNstgweUdMw/nKs1EwJqmudUB2P1xulOOryJD9MXGaiFK1tgVw0fqaGSzoYmon0AdaXhib6FplUYpww6ItznZscf7tRn+H2zWGLe2hx5Deyz9XkoSqPIpXxbPoQzPCNrERBASpb3G5xJKFEGSVvr4aqsXUiU90XDP6M0eDz65dqRto/KdpFcOJo4kIag4TZnEOGRjQkbCkVMAB4yTSwPm1VeceDId/XvdXyOD2i/CrEEloAw9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789104109; c=relaxed/relaxed;
	bh=OvxSaNqswfMI7MoABq1pjZcckfAsFzvKQ+mSQEh+4AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpT7cZ/6OJA9xnD37SvtXEb1LZU7gJRbQRn+9R6bMyqZGxFHBWLbh4urWyKs72VqfpWDS6O5+MWIwhxi67zIY5HuPXwWPnLv1GxwS80mfSbGmuoykuVdoDTDE41XRNCxZWbaS5wUuWloDdFVfuWLX1OfDePv9YCTh1tKZhp3H1QAXa8QXOoMqxVE/RSLzNuc0QMIsNd/X8bK6/zov8eRrOd8Bxudq3BI+s5FPO1BnNj+e+AUVHhgQ38upMdlW4BhKbpNELFonojwSiqGj22pEwbP6k84oGAqtZm7xgGVrEiXG731KH4rF6+VJStDSdaXldPCaUw3GLBtKb/lJ1FdMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVIcldtT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVIcldtT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2wD2WD7z2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:21:47 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-8557c3f270eso482528b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789104105; x=1789708905; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OvxSaNqswfMI7MoABq1pjZcckfAsFzvKQ+mSQEh+4AM=;
        b=HVIcldtTkCmo6NzExCbqIF8ZRf7Ut4b1G4vRiu0uXFi7WbpWbKzAsWuKSeeO6vpMtm
         SS0se0UKxQfzt41IOh6lYvoStA8tuhtXHWhzYDUwyjRZDG50DHB4iaAtiKg8XW79WLsR
         NFeOiM3LNqq21z/R+2jgKvCVVMjc+RfRyHOhXEdQnRnDMVv7MAJ22YR58X3NaFMU6Fcx
         1yMuDYVQyWiJlcuhzcXJs6Ce2GKj5rFL+GkumFvIi1Kf2G0HH45jOswzbVbKpGoqfoJ+
         6s0hVPK9Z9Yy6kAJC7eRPHaOTqHDIBFQPyQVhpaCOyLS7nObgzq5D7cF7wqifBSiZxR9
         qH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789104105; x=1789708905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvxSaNqswfMI7MoABq1pjZcckfAsFzvKQ+mSQEh+4AM=;
        b=YcKUmQwZROCdFj2xgEO5VaYddlOmVMGbgoD04fvtjG4njUQbqGjVGySglox0WGwlJb
         /74KMume2A41AndHLR9C+Rz8y47oYyXPhl0G6pJSEscMaprvHE0AJtciHF6pus2vx4fp
         2aH4naO/21pWopzFxVWKcGE8S7Xjow3qMf9Tx+o8hCuikxeIJuWjP3M3vgd7w4Bvlt3p
         8lnBADWWYzlDBNc2tyD1Zv2lzpkP/DqZVqOkEx9b91ct+u7gRV3Hr625lfjO9x5bnFq/
         nnc5avP/J5u9lKg4OmDu1NJpew1pxvh2hCOXo8cseusNP3L/euNe0nij/2wUjcVo2jEB
         smSg==
X-Forwarded-Encrypted: i=1; AKwUvBwx2ocvgeil4K1ZAWNkPPFKCH4LchQ2DzAN1Z+vv9G4dqWVt/EoQIaaNe+eiAIfx+LRmPKRVeUqvUqIsCc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nfQuFB/vKC81Fs5vCpV5/KeT7u2PVZ48so0ddE1+qCMQb3vNPk
	WFhr+GG+QK/CirKe8dqHdTVmli4UBfSzmsj9iMvFKo1JHnMhNDuGJS/H
X-Gm-Gg: AYBFou18YW/P2ctMrTVLWoHQU9WzUYOD9k/FCgnHN7fO4XFadjm2iMMWiu7ZGHJqhP/
	SdD+A6oerhFnTTYe1hq1+yO3N29sQEKJF8dGjll0+FVkoXbEDAEXcJ3iq53CGMsHi6dTRz47w20
	xpiJypAPQufj+sj7ZMeeGg3CH9xTIzJTj8kpCMoTqFCXtMCXTzuQaGsbLj5X60r+swT9Ya0PRQF
	U6+G0Fhs6oie9BTXLQR66AtnbcoxB/Rd42ISX7wX+n+h9BE/Cu0LI9vkq21+HwcigtGWkQKUtev
	rEhCpN0oBf3qx7wETF/0jdlu1nn67QIh6gDoolfHyOY3BLfxblH1uHy31O76Odp/kLqXvYJdvdx
	erxs7Yr+vYme44zBAk6NYTCUp3EBGn3YKbjGkzYPSU3qw8p2YrSPGAPhfo7euACwO6dtIhLdrBr
	GGVtuTM9vRV4d+TVShvuzsDueeK17/rIo0Z8eZ4912quR3sDbY8VN6lqccsIQix+quQylj4XIbc
	eRWUCiwz3jIz+iG07G2CMSGltsYv2Myr+blbJnMnzN/Xw==
X-Received: by 2002:a05:6a21:6f88:b0:3d1:be60:2811 with SMTP id adf61e73a8af0-3daed30037bmr5351249637.15.1789104104920;
        Thu, 10 Sep 2026 22:21:44 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8137fsm3495801c88.9.2026.09.10.22.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:21:44 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:51:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: gary@garyguo.net, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, linkmauve@linkmauve.fr, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V3] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <aqOO6_kXGaaIkCuq@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260910100801.2159785-2-mkchauras@gmail.com>
 <DLBMFNHCKSJ6.1I36FDVEACEUF@garyguo.net>
 <20260910.222417.2048885189565815846.tomo@flapping.org>
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
In-Reply-To: <20260910.222417.2048885189565815846.tomo@flapping.org>

On Thu, Sep 10, 2026 at 10:24:17PM +0900, FUJITA Tomonori wrote:
> On Thu, 10 Sep 2026 13:05:27 +0100
> "Gary Guo" <gary@garyguo.net> wrote:
> 
> > On Thu Sep 10, 2026 at 11:08 AM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> >> The Rust kernel infrastructure generates inline asm for WARN() via
> >> ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> >> preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> >> arch-specific asm template string for use in Rust's core::arch macros.
> >>
> >> powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> >> Rust builds to fail on powerpc with
> >> ```
> >> error: no rules expected `ARCH_WARN_ASM`
> >>    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.rs:1:28
> >>     |
> >>   1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flags}", "{size}"))
> > 
> > I think we probably want to catch this earlier by have something like
> > 
> > #ifndef ARCH_WARN_ASM
> > #error "ARCH_WARM_ASM is not defined"
> > #endif
> > 
> > in generated_arch_warn_asm.rs.S.
> 
> Good idea.
> 
> One thing needs to be fixed first. arm and loongarch do not define
> ARCH_WARN_ASM. rust/kernel/bug.rs uses bindings::WARN_ON() on those
> architectures, so it never includes generated_arch_warn_asm.rs. But
> rust/Makefile still generates the file for them. With #error, their
> builds would break.
> 
> I think we should add a condition to rust/Makefile to stop generating
> the file for arm and loongarch. Then #error can be unconditional.
> 
> Does that sound reasonable? I can send patches.
> 
Hey,

Sounds fair to me.
> 
> >>  arch/powerpc/include/asm/bug.h | 36 +++++++++++++++++++---------------
> >>  1 file changed, 20 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> >> index 0db48977c70c..df2183c35945 100644
> >> --- a/arch/powerpc/include/asm/bug.h
> >> +++ b/arch/powerpc/include/asm/bug.h
> >> @@ -32,34 +32,38 @@
> >>  #endif /* verbose */
> >>  
> >>  #else /* !__ASSEMBLER__ */
> >> -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> >> -   sizeof(struct bug_entry), respectively */
> >>  #ifdef CONFIG_DEBUG_BUGVERBOSE
> >> -#define _EMIT_BUG_ENTRY				\
> >> -	".section __bug_table,\"aw\"\n"		\
> >> -	"2:	.4byte 1b - .\n"		\
> >> -	"	.4byte %0 - .\n"		\
> >> -	"	.short %1, %2\n"		\
> >> -	".org 2b+%3\n"				\
> >> -	".previous\n"
> >> +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> >> +	".section __bug_table,\"aw\"\n"			\
> >> +	"2:	.4byte " label "b - .\n"		\
> > 
> > "b" is part of the label. "1b" itself is a label and "1" is just an integer.
> > 
> > If the code uses
> > 
> >     _EMIT_BUG_ENTRY(..)
> >     "1: ..."
> > 
> > then the correct label would be "1f".
> 
> Agreed.
> 
> I think keeping the label fixed, as v2 did, would be fine too. x86,
> arm64 and riscv all hardcode it. A comment that says the caller must
> put the trap at 1: might be enough.
> 
Enforcing the label would be a better idea so that we can avoid
mistakes. I'll fix these and send out a new one.

Regards,
Mukesh

