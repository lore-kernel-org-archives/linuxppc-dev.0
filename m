Return-Path: <linuxppc-dev+bounces-27016-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CE9C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 09:13:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgX5Y3wpjz2yYY;
	Thu, 10 Sep 2026 19:13:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789031585;
	cv=none; b=AHPRJZ0drRfENkoYMa0Y6wV4YVpddkEexunStxLn2bJsIMUwba2RBHUd0QVyh3eO15LcVu+BTQ3+6jUHLbp8b8Ed510BT+knOk6RvzEy3NqEdm5xDylluiSCYla9eOZro6VDdgf5f6wO4OJyj1ZX8l1eDZ/vzW8Ln/4zT/O2t+Tkv9lHIPh5SnWJwrkATedFTJdF7lKbJX2zz8y7TlLXjVps6VLn0nQgmKIo0Hsf51zfaGpJvtJcvuLvac9ddTU7xZ+YBZDsE5zk4XdD/FRQAFg3osJ9C4Y1+6w/FDMUbvZ/YxXHa5FuTPXWamK7v15NNspr/TNtMcjMIWwwQNTOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789031585; c=relaxed/relaxed;
	bh=x80sULQ0zZu1BIKAuLseVrEbYl+Sg0KA4OXi22FchTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXYAfa5jkIGp/xKmRi9x7x7g3W1oXg7tsubFs4v8XpPTFTXgil7pJmM5ZwRnl9GmRclh88wFqCGqlYZy2uFodxY/S2TRgf0Ib7I+YOIt8Hyxnylj6d/dsw24ypTkBzTw9y7v+SK/poZGzCKBm4b9z0+TH/yFDHxQqtlv7E6+eRgKskaNqQQ+n1qwUDeFT2Hq77Sf2QD+rNErbxs0r1b3kydzsZ0KuopT3m/mbv8kXUO6PucU5458PNCPejfLzEUMkhzrFNi2lmCJ2V3Ws21lnq/QE1it+1QatsE/R60CNKU96BgdAjqvmo8QAoA4FEAko23HEj2aZJ+IWAFftMlcUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MZtIsulY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MZtIsulY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgX5X03C5z2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 19:13:02 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4ab4fe290so227887a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789031580; x=1789636380; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x80sULQ0zZu1BIKAuLseVrEbYl+Sg0KA4OXi22FchTM=;
        b=MZtIsulYgx2xpSUFX2hG3bIft3ARKosRNV3XuxcdUDSLYSQU6gdzZiPA0ALcIIIHtY
         IHrU023tECYtgSLbCKxCmxRdM7Y0Qeg+7T4DCEPVlS5c2gtgGW9t7jIUo1azTlaW5Vs/
         GKBbpyLlrYLg08lTiAoFZoorAqLQWZ+jokPpTJuzZVMkgdUAmY+64vr3SDK41byrRYgo
         khnQ8WIm4RUq3vl6a0Bjt6ik4stx57nH30YXu4aFI/rhP/sSbHLk5LolemzOcuu0WT/f
         29pq2X16lq67XTtHERHRHLEspNk3KXfTv3HYI5y772bx+LuaEILxhrBbMD1w5i7gi5jc
         eTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789031580; x=1789636380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x80sULQ0zZu1BIKAuLseVrEbYl+Sg0KA4OXi22FchTM=;
        b=k/vnGbKYFYOVnLO4ZCjANQMVzVn42I4QQ/+zwFTHu7IFrylvOASFTZzjNmiQaeQOHR
         cQKRpJPWchJGbF2jKxD5jnBupRZ6mV2tpaWap6gdr97NKn/SsNnNDA542NXIgPjOOw4D
         Jt5NEU6bm26apw0WnAoba3MF+N20Wbwa4l11aBEp5IcSDLh4vLwaJtlL/QnTBRkeEu5c
         BVq+DOFRcqFn8vLjEyWwbhlTy+r5TiQnNl/YulZfSw57oezZdiSot+RLJxPV68LGkTsj
         t9j0pp5kuQEwbKCsaKeaginATgYQlRH0Y31vRBADFd52eGTk7E3T2iUKfSeIjcfnRE4n
         Gt4A==
X-Forwarded-Encrypted: i=1; AKwUvBycImnV1lchlP10TZ1wMeRfFQSGrpAFxGWHDRst3tqyis9zCM+p2wFBQE4u5XbL+mFsZiT9bICwWmPoD30=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kxdFUN8hrQS/sBktCx/AYzA3m2n7+WpWa8z4BfYjx1pI1Evms9
	ngSLY2qHyxGyr/FYtC+sahkQiLglrWnxN+w7+Ghcmamqh4CO/WPqVGol
X-Gm-Gg: AYBFou0UQhrYsDGvbbh9RxJCkrRUrVb6RrYkvXBeJydzX1K1wP/L744RvByIt1O0626
	xwAW8lqxQT186aKYaPhb6mB4HCfUynlqnBRGXj/ob3Jjw+lLMl4t7hm7CqcXyLEagzWaZBo+92p
	JpxLurai8OxQZ+Oxab5ihURxkZ51uY5f+cqsOly6bGVr1KLjEeMKMTEKpPHGlznPlnBvzWKe4H0
	u/TT+tl81iJdlXl5QX+ICoQ378edlvrFiNLInJ31SLBFksZMk8ezF4hE6vzE/m2uETcRySqBmkr
	57J5nOTOg/cPHM8+gfKQBViJHmXj70JaxvVJfGoiwakNL+PYVirY6mINPzZbmF6Fkw5xdZdccYk
	i3U2MUbyt8U7jv7MZ5HDGiDHzasAKByEiCR/Gy8XUJXxqehmHAYqgawFxTGWwzFGfpDHEhhNYld
	mOFQJT3gtypF74c+wzqiZeCZCoLLfkGfrLSe/K2ZAeKMZepOaurDYfT+LMKRbJ93X4omsZPT/5M
	yUygyQ0y1KN5cKy3+6qWFjwsj/HGEbBRol8kV71khw=
X-Received: by 2002:a17:90b:2b4f:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-39d77a029c6mr3299345a91.4.1789031579674;
        Thu, 10 Sep 2026 02:12:59 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e82fa21sm3426201a91.9.2026.09.10.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:12:59 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:42:47 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, linkmauve@linkmauve.fr, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, FUJITA Tomonori <tomo@flapping.org>
Subject: Re: [PATCH V2] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <aqJ0QZYuft-VWrnW@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260910071252.1950488-2-mkchauras@gmail.com>
 <0605f2ed-32a1-492d-850e-d1080007b4bc@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0605f2ed-32a1-492d-850e-d1080007b4bc@kernel.org>

On Thu, Sep 10, 2026 at 09:36:34AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 10/09/2026 à 09:12, Mukesh Kumar Chaurasiya (IBM) a écrit :
> > The Rust kernel infrastructure generates inline asm for WARN() via
> > ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> > preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> > arch-specific asm template string for use in Rust's core::arch macros.
> > 
> > powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> > Rust builds to fail on powerpc with
> > ```
> > error: no rules expected `ARCH_WARN_ASM`
> >     --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.rs:1:28
> >      |
> >    1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flags}", "{size}"))
> >      |                            ^^^^^^^^^^^^^ no rules expected this token in macro call
> >      |
> >     ::: ../rust/kernel/lib.rs:279:1
> >      |
> > 279 | macro_rules! concat_literals {
> >      | ---------------------------- when calling this macro
> >      |
> >      = note: while trying to match sequence start
> > 
> > error: no rules expected `ARCH_WARN_REACHABLE`
> >     --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable_asm.rs:1:28
> >      |
> >    1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
> >      |                            ^^^^^^^^^^^^^^^^^^^ no rules expected this token in macro call
> >      |
> >     ::: ../rust/kernel/lib.rs:279:1
> >      |
> > 279 | macro_rules! concat_literals {
> >      | ---------------------------- when calling this macro
> >      |
> >      = note: while trying to match sequence start
> > 
> > error: aborting due to 2 previous errors
> > ```
> > 
> > Refactor _EMIT_BUG_ENTRY to accept explicit (file, line, flags) string
> > arguments rather than relying on positional asm operand references
> > (%0, %1, %2, %3). This allows the macro to be composed as a plain
> > string concatenation, which is required for ARCH_WARN_ASM where no asm
> > operand context exists.
> 
> For a cleaner _EMIT_BUG_ENTRY() macro, shouldn't it also pass the label
> where the trap sits as a macro argument instead of blindly relying on it
> being 1: ?
> 
> Christophe
> 
Hey Thanks for pointing it out.

Yeah the assuption to always use 1 shouldn't be there. It should come as
an argument. Will fix this and send out a new revision.

Regards,
Mukesh
> > 
> > Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
> > the BUG_ENTRY() call site to preserve existing behaviour while enabling
> > ARCH_WARN_ASM to supply its own size operand independently.
> > 
> > Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
> > convention, indicating that no additional reachability annotation is
> > needed after a WARN on powerpc.
> > 
> > This brings powerpc into line with x86, arm64, s390, and riscv, all of
> > which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.
> > 
> > Reported-by: FUJITA Tomonori <tomo@flapping.org>
> > Closes: https://lore.kernel.org/all/anG67Q6Y59kDqh-c@desktop
> > Fixes: 73b741adb264 ("rust: Add PowerPC support")
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> > Changelog:
> > V1 -> V2:
> > - commit message now has error, fixes tag and closes tag
> > 
> >   arch/powerpc/include/asm/bug.h | 28 ++++++++++++++++------------
> >   1 file changed, 16 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> > index 0db48977c70c..8aba39e0cf26 100644
> > --- a/arch/powerpc/include/asm/bug.h
> > +++ b/arch/powerpc/include/asm/bug.h
> > @@ -32,34 +32,38 @@
> >   #endif /* verbose */
> >   #else /* !__ASSEMBLER__ */
> > -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> > -   sizeof(struct bug_entry), respectively */
> >   #ifdef CONFIG_DEBUG_BUGVERBOSE
> > -#define _EMIT_BUG_ENTRY				\
> > +#define _EMIT_BUG_ENTRY(file, line, flags)	\
> >   	".section __bug_table,\"aw\"\n"		\
> >   	"2:	.4byte 1b - .\n"		\
> > -	"	.4byte %0 - .\n"		\
> > -	"	.short %1, %2\n"		\
> > -	".org 2b+%3\n"				\
> > -	".previous\n"
> > +	"	.4byte " file " - .\n"		\
> > +	"	.short " line ", " flags "\n"
> >   #else
> > -#define _EMIT_BUG_ENTRY				\
> > +#define _EMIT_BUG_ENTRY(file, line, flags)	\
> >   	".section __bug_table,\"aw\"\n"		\
> >   	"2:	.4byte 1b - .\n"		\
> > -	"	.short %2\n"			\
> > -	".org 2b+%3\n"				\
> > -	".previous\n"
> > +	"	.short " flags "\n"
> >   #endif
> >   #define BUG_ENTRY(cond_str, insn, flags, ...)		\
> >   	__asm__ __volatile__(				\
> >   		"1:	" insn "\n"			\
> > -		_EMIT_BUG_ENTRY				\
> > +		_EMIT_BUG_ENTRY("%0", "%1", "%2")	\
> > +		".org 2b+%3\n"				\
> > +		".previous\n"				\
> >   		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
> >   		  "i" (flags),				\
> >   		  "i" (sizeof(struct bug_entry)),	\
> >   		  ##__VA_ARGS__)
> > +#define ARCH_WARN_ASM(file, line, flags, size)		\
> > +		"1:	twi 31, 0, 0\n"			\
> > +		_EMIT_BUG_ENTRY(file, line, flags)	\
> > +		".org 2b+" size "\n"			\
> > +		".previous\n"
> > +
> > +#define ARCH_WARN_REACHABLE
> > +
> >   /*
> >    * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
> >    * optimisations. However depending on the complexity of the condition
> 

