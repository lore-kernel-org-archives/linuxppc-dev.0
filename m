Return-Path: <linuxppc-dev+bounces-27126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F63C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFnJ3V4xz2yqx;
	Fri, 11 Sep 2026 23:31:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103786;
	cv=none; b=GReWwsvm63s922201h97ggUz1OdPuEaI3AMb6kSmwWuOS0t94VuSocaG4yVWkOTeJTqrWw6JPuAxYziXdQzXRB2BEdr/N4Ul48AbWjieOZLIf3wbo+e2HVtajFm+bMy1qAtSNS/YHftZTiSMgfCy9b+3gdpcOs0gPgDwy1KJYb0iUnvZx/dgErtxI6VANTswt/7zjckBabdY38TEW2PRauNzB9uSPRMVJvLRRIe1TCc9A3YDcqBmuMuk4K+tgr9Yz5HanBXU6YmC/J5djDBD04ovWMfJY1xIGNXFjG58Z/PgJuBe/E6DsMb6snOHgOuPHuAddVBKQmtinCjl/9JBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103786; c=relaxed/relaxed;
	bh=JQ54+lD2n/aIXsWwyvLa1NXcPj36AMrVbfAkkYOl2fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuQoZqEd3WV7UjrDRxZHJp2D3hL0jelYv4PGJT29zdDr9O/ghqNYTW3lLGKuUjplAjtWVK7IXIvrWC+gW22YJThwClaoz8gNVHJtT97CocEVySwKExF6nazgm/zYwDaMSKX368NpdR/v8KAy2xzryLIn95IpAvPR81YSzcsb4g5lrHlzTfmoQDpbRGizbFtmetSkOaXV5J4lka5j0JP/veJ04Ebs5i6lq6bp9YM875S/B10y/oB9D0ST0YGKIolTlA2iZEC+Ci8qVxLQp2mZl1fSxtlfrIwu5pJEJVq2ZxlOprWALG+sl8bT9thuOyFtgUclj9aX5rZyfm3MVrpsXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwUzU//p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwUzU//p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2p12mrvz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:16:24 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-cc149372c14so421050a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103782; x=1789708582; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JQ54+lD2n/aIXsWwyvLa1NXcPj36AMrVbfAkkYOl2fw=;
        b=kwUzU//p6NlNS8pgD3/dCH9UBsDiXNkgH6xIOspVQpLXyyVZsaUUkg5RIoCok2wHJ1
         f7LqwDjKEAxrCgppDCYYVhd88Pl/8jZy7iYNt8ixnE0U3+yRrYl8qEY8IBHHPPr/KwqU
         wadCDPL9XxIdikF3ZLQ7cbFz56l+Qz0gcFxS21MpDFHKZ+ANRu7otCF1wDW5uXMUydTQ
         eVNiw/u+4La2JOKhX0byJy/p5n+h7anpmRXtfi4QMDbShi/n52xRBZNogZMOQX/PUXtp
         2fGspAhUbOwRzwj43bILcNZof+4jhc/GdQp9VXrFBu1AmsbpJgVeon1SP5c5O4ocVCLu
         WQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103782; x=1789708582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQ54+lD2n/aIXsWwyvLa1NXcPj36AMrVbfAkkYOl2fw=;
        b=Jt9apcFPxosdrMbiBapHhY2CZiqiQv8wJG1TRVDB3Qk1oU1GVTVnqoJkyr9d/hleRV
         583odliKwesiiRsIqrd3x6gyR4vKM4Q1HsiS8JaJg9u1KO1+ZaPcXRSmOojK1fpFE67A
         IzHMEBeWToWXpUQhNbgEsmLuXdxS69H85xqwghtosXFYnNnxOCqtLCTs6KgGLIvW8PRh
         cA3aCzDioQMgDXV1LnLeOfyvpjtInE1+egnrdNoc4IuMp/MYstZYChar0yPlwXYCV4N5
         pIsUezHZxpsDVABV1G3gZaR0iEQ9CwEVkljmTc0Nh0AAa3UHMmosSd+dvRp+1aZHWiGQ
         y/nA==
X-Forwarded-Encrypted: i=1; AKwUvBxkf2RSC2kxnm1e/Pznn7F8MTw5oSJc6LR0XTInTZEIw4M1NAuNT4Yf5y8t9ffFOK8b58hP/C8MM8KvFxc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nBfUyJulwRTBSVzDxMTOF3Sy+/uv3lFYZch5zlUVGt7h9+3MAi
	BlCmTcP3+6dMGcXcDr+F2L9RwNFS0S2j3FCCDkH6USqWgeKaALTFUXfq
X-Gm-Gg: AYBFou2r3iu09WHBz2HB7SHjDBckgmxx7+tEIBBp+y3Kw68wMV0b4C7wVp0YEfvBsNC
	aDNQ2J30pLj3qXJdd8a1FHns6YhlPy8smhEbM1UNGhItH5tE2aJqQ4/JLyu22f9UVN9HJDUwMJy
	AQ4hLV+xr80O4jkSFQxYUjynoj49zfzXnGfLxSmosHa2ihlZ7Tq2i9ntASmAF/tMxSGd4Y70KyR
	FBMVaZbgSY1e7/Y2DQQsUBDivWqQoCbeqZsP4Ou8Ezk9/HlMVJyU4PVDT8YY8dP3VZt4fgd9oib
	7Qi+srPtdNeBgrk+QwvLnkC1sjWT5N0IHXbfe0nirkzhQNGumTW+FTaShmNkzgyfUaOBjUruvkS
	E/UqXL+teICQusnHn4MDfm56BnktYucBeNN78dRTL2fx07rWpBdLlzxHZkgwUmQAHnoOcw2mYhI
	chV8A93V2ijpoV3AgMICKid3UBr0q6m52pAakwTeoHClM25cCwtGZoTRU9zjMn1lqH6cTrBv1FE
	DIUduYOUArm0wvsU2IHQrmZ1mwkm1k9wd1fkURQ7AvW2f2basUilpgc
X-Received: by 2002:a05:6a20:7347:b0:3d1:39e9:b269 with SMTP id adf61e73a8af0-3daed15388dmr4300321637.4.1789103782257;
        Thu, 10 Sep 2026 22:16:22 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed79absm3295201eec.17.2026.09.10.22.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:16:21 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:46:10 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, linkmauve@linkmauve.fr, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, FUJITA Tomonori <tomo@flapping.org>
Subject: Re: [PATCH V3] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <aqON9aluXdKk8nNq@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260910100801.2159785-2-mkchauras@gmail.com>
 <DLBMFNHCKSJ6.1I36FDVEACEUF@garyguo.net>
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
In-Reply-To: <DLBMFNHCKSJ6.1I36FDVEACEUF@garyguo.net>

On Thu, Sep 10, 2026 at 01:05:27PM +0100, Gary Guo wrote:
> On Thu Sep 10, 2026 at 11:08 AM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> > The Rust kernel infrastructure generates inline asm for WARN() via
> > ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> > preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> > arch-specific asm template string for use in Rust's core::arch macros.
> >
> > powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> > Rust builds to fail on powerpc with
> > ```
> > error: no rules expected `ARCH_WARN_ASM`
> >    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.rs:1:28
> >     |
> >   1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flags}", "{size}"))
> 
> I think we probably want to catch this earlier by have something like
> 
> #ifndef ARCH_WARN_ASM
> #error "ARCH_WARM_ASM is not defined"
> #endif
> 
> in generated_arch_warn_asm.rs.S.
> 
Hey Gary,

Sounds good.
[...]
> >
> >  arch/powerpc/include/asm/bug.h | 36 +++++++++++++++++++---------------
> >  1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> > index 0db48977c70c..df2183c35945 100644
> > --- a/arch/powerpc/include/asm/bug.h
> > +++ b/arch/powerpc/include/asm/bug.h
> > @@ -32,34 +32,38 @@
> >  #endif /* verbose */
> >  
> >  #else /* !__ASSEMBLER__ */
> > -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> > -   sizeof(struct bug_entry), respectively */
> >  #ifdef CONFIG_DEBUG_BUGVERBOSE
> > -#define _EMIT_BUG_ENTRY				\
> > -	".section __bug_table,\"aw\"\n"		\
> > -	"2:	.4byte 1b - .\n"		\
> > -	"	.4byte %0 - .\n"		\
> > -	"	.short %1, %2\n"		\
> > -	".org 2b+%3\n"				\
> > -	".previous\n"
> > +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> > +	".section __bug_table,\"aw\"\n"			\
> > +	"2:	.4byte " label "b - .\n"		\
> 
> "b" is part of the label. "1b" itself is a label and "1" is just an integer.
> 
> If the code uses
> 
>     _EMIT_BUG_ENTRY(..)
>     "1: ..."
> 
> then the correct label would be "1f".
> 
> Best,
> Gary
> 
Thanks, I missed that part.

Will fix it and send it out.

Regards,
Mukesh
> 
[...]

