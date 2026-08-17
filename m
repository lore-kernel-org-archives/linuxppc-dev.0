Return-Path: <linuxppc-dev+bounces-25908-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B068C5DF66
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 19:38:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hP36858Nzz2yGf;
	Tue, 18 Aug 2026 05:38:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786995504;
	cv=none; b=BErynxNFurVrC5+Bd2xxdfz9qHjeD56liaftWzhzNs0MSzRaqmJITyc8cpjPkvBxCjzNr9Np4JUzA2idPPTr4Lq45War4pWUDviSOQ2JgrlSXS+YsVzcNRc6rKV5w96cC5kjIORYmlOzv4JKaJeOjfleU84/WJC+vgKktPQYfyn9ort+K6NIytU1Zm7KDiClIlnJUfo0KVco4aRBwHZVzsSl8DJbf+kfp3d+FiXnHhJvcd/RtAO1JytydWz9U+InfRvSQ0a1yEa4V+Yi7ouvmeTr7KeD0y7CprmcwFehftsxvj7ACmxlhlGI9HPsLTgEGzMI+uAfWN5zi7TlrawYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786995504; c=relaxed/relaxed;
	bh=cD3mmvYKpha8dr0drJhM5eVX4f+kSXFZpxrYv6xr2MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIGDMixSOoEBgEkyjPh/PKYNdH/uxUVoXQqRS04kQ/6JYwxOn3npcdBc8bk3g76igB7uSS9zfDDSOcsUPkz3UA3FE/gbXO8nbGzwFpKLjzFqWX2ubj27PaO7Hb/EEuk33y6znN013EXS4GFlOJY6hH92ni44SarFoeplk45o1GQd0U0kwZJvlf4Kj+9Dv4YVkBKyk026gOKNq6iT5KYUCkuKmkCKPv1SeJJMsucN+Tck7E4HUrxC4JvgQeUNa6LSgjO3Ky9p0ooI1prqrEfttEVUU5RUUJnERiESstyJHTdLHATOqO+ShdIzFP722O+24cBtDEB1aZ5B2he3lDFprg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv5RJUiu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv5RJUiu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hP3674Yxmz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 05:38:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 726F9601DE;
	Mon, 17 Aug 2026 19:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32211F000E9;
	Mon, 17 Aug 2026 19:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786995500;
	bh=cD3mmvYKpha8dr0drJhM5eVX4f+kSXFZpxrYv6xr2MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vv5RJUiurDKE+42m3+I7fooZ17angkcbBiMDqDM8ibSdc48S/D8pELAOlGV3auY2a
	 swGTKPUkuoYVei0oUYXOZ11RnUu6pf3lLUOkqe1BEVQHs9dNtxABN4RU6Vhv3eGMmw
	 VCbcM7xtWGKmpl0LKqSoknM29gzUvw9jFSbJGl35sgzARcjrfCmRz9OjWIUexJ+5w5
	 Hv1af/O5CSR+i2PSv0+6bneQJtmAVf8fpjiA1w6rmOYQUwEQLf8Ala7pJsX353LX42
	 +QoBl0WJ7uzZMkvhY+A+gdFfAzpqdZYMs+Zo0sbBk4f/ufpbCCrqxvGkJOXu574Rqc
	 dT1EoMcyHeR9A==
Date: Mon, 17 Aug 2026 12:38:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: FUJITA Tomonori <tomo@flapping.org>, linkmauve@linkmauve.fr,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
	daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com, gregkh@linuxfoundation.org,
	prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com,
	lina+kernel@asahilina.net, j@jannau.net, airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Message-ID: <20260817193810.GA4060679@ax162>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
 <anG67Q6Y59kDqh-c@desktop>
 <20260804.224035.269658578200153488.tomo@flapping.org>
 <anMsbbRNiihKB-z7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <anMsbbRNiihKB-z7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

Hi Mukesh,

On Wed, Aug 05, 2026 at 05:59:14PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Aug 04, 2026 at 10:40:35PM +0900, FUJITA Tomonori wrote:
> > On Tue, 4 Aug 2026 12:11:57 +0200
> > Link Mauve <linkmauve@linkmauve.fr> wrote:
> > > I just tested those again in linux-next, with the Wii support series on
> > > top, but now the kernel fails to build due to ARCH_WARN_ASM and
> > > ARCH_WARN_REACHABLE not being defined on PowerPC:
> > > ```
> > > error: no rules expected `ARCH_WARN_ASM`
> > >    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.rs:1:28
> > >     |
> > >   1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flags}", "{size}"))
> > >     |                            ^^^^^^^^^^^^^ no rules expected this token in macro call
> > >     |
> > >    ::: ../rust/kernel/lib.rs:279:1
> > >     |
> > > 279 | macro_rules! concat_literals {
> > >     | ---------------------------- when calling this macro
> > >     |
> > >     = note: while trying to match sequence start
> > > 
> > > error: no rules expected `ARCH_WARN_REACHABLE`
> > >    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable_asm.rs:1:28
> > >     |
> > >   1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
> > >     |                            ^^^^^^^^^^^^^^^^^^^ no rules expected this token in macro call
> > >     |
> > >    ::: ../rust/kernel/lib.rs:279:1
> > >     |
> > > 279 | macro_rules! concat_literals {
> > >     | ---------------------------- when calling this macro
> > >     |
> > >     = note: while trying to match sequence start
> > > 
> > > error: aborting due to 2 previous errors
> > > ```
> > 
> > Looks like powerpc needs something like the followings:
> > 
> > diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> > index 0db48977c70c..8aba39e0cf26 100644
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
> > +#define _EMIT_BUG_ENTRY(file, line, flags)	\
> >  	".section __bug_table,\"aw\"\n"		\
> >  	"2:	.4byte 1b - .\n"		\
> > -	"	.4byte %0 - .\n"		\
> > -	"	.short %1, %2\n"		\
> > -	".org 2b+%3\n"				\
> > -	".previous\n"
> > +	"	.4byte " file " - .\n"		\
> > +	"	.short " line ", " flags "\n"
> >  #else
> > -#define _EMIT_BUG_ENTRY				\
> > +#define _EMIT_BUG_ENTRY(file, line, flags)	\
> >  	".section __bug_table,\"aw\"\n"		\
> >  	"2:	.4byte 1b - .\n"		\
> > -	"	.short %2\n"			\
> > -	".org 2b+%3\n"				\
> > -	".previous\n"
> > +	"	.short " flags "\n"
> >  #endif
> >  
> >  #define BUG_ENTRY(cond_str, insn, flags, ...)		\
> >  	__asm__ __volatile__(				\
> >  		"1:	" insn "\n"			\
> > -		_EMIT_BUG_ENTRY				\
> > +		_EMIT_BUG_ENTRY("%0", "%1", "%2")	\
> > +		".org 2b+%3\n"				\
> > +		".previous\n"				\
> >  		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
> >  		  "i" (flags),				\
> >  		  "i" (sizeof(struct bug_entry)),	\
> >  		  ##__VA_ARGS__)
> >  
> > +#define ARCH_WARN_ASM(file, line, flags, size)		\
> > +		"1:	twi 31, 0, 0\n"			\
> > +		_EMIT_BUG_ENTRY(file, line, flags)	\
> > +		".org 2b+" size "\n"			\
> > +		".previous\n"
> > +
> > +#define ARCH_WARN_REACHABLE
> > +
> >  /*
> >   * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
> >   * optimisations. However depending on the complexity of the condition
> 
> Yeah, This makes sense.
> 
> I'll work on this and send out a fix soon.

Did a fix for this ever materialize? I am still seeing the errors that
Link posted above in next-20260817.

-- 
Cheers,
Nathan

