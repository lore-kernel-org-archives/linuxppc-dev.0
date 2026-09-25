Return-Path: <linuxppc-dev+bounces-28180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060C3C9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:07:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrhbS23LZz2y2M;
	Fri, 25 Sep 2026 17:07:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790320036;
	cv=none; b=fl5oOZ22hi6v+Pn9Sp9VTBhHXOHqTOjkxvOKRIb5QWjY5w9Kt0isEhaXhcMRV/1+217ZJzeQQePnqgw/U8h3So28RASk7aRJKroB/IOqwaWkG9PVcGHM8OCcxN/o5sEs/qadrZzzNQK2PvDz1pg2Dr/daPdXoW49j9ZkWs/ZZ+qLMPC5R8NuZznPz03ApA7/C0uk29PfSdCLK2EsZZdSZfVK9VInI5PaBzdZh6k6XiLgs0H4ag8cunW6PFJFMgD8zWKfmYBM9zRzkn93l7d5Ny6L5ZY1UtWJDKFUVXmJc1p7rvv3CEij71p0KtV07mSruw991IQ2v81qxRdJvyt7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790320036; c=relaxed/relaxed;
	bh=JaEAeO+KpKKY3qs5B15P5jzMNjkhf9IQUFD5AfYaJCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzqf6bSIJlXFXcLgq0cus8rpuXYtCtNBh/SJNc6vC33hv7MF6gtGRiEFWFx6cQ8sf9FG5+HJwVs5LPWcWCSfhpNsceZevZloA8Urz7o2cFdGz95VgC2x9MG94SQJwsbT54uLOfwk+764gAsmBNE0l9qwxe81h759KH7zSe7BGO9UAlHkeNMBme+TC+Nn5Clt8bx919bmlR8KZTzdt8pTk09PgLD/FS1DskyyN3rL37h4S3ervY6a0jzAyXCj44T1s/sjwI+GJ7bOq1UEUAY6dBW4z6k32X+Nkiwy/3YrlLtbp1SyVWx+reDxbwyRObfzg07D0+FV38PA8tS7jZEVDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RFD6hs2T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RFD6hs2T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrhbR0rC9z2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 17:07:13 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-3413069aa25so299897eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790320030; x=1790924830; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JaEAeO+KpKKY3qs5B15P5jzMNjkhf9IQUFD5AfYaJCM=;
        b=RFD6hs2TMKA4UHDdLt7J0lH4odctXS1/7GxeRgs/xRIiSIajXJhJ/R2zr3UuIJzFA7
         sR+gxt2uakFul85YqDoYxN1YW4wdylwN5Y3Xpswa3v8eBrqU2qXilr9kZSgyaOqpG6ir
         ceBBJ/T/rv3uU6DYsfkcd55HMAUdZh32utDaNBy4wO0bxLwiA5jJeSau7EkroD2LLEXW
         SwZB+mQ1Pjuf10YU1tHPj6rO3UbRh+YaS7W0rP0ikoBGYZLEX3+Y11IfBG9TLciYgYmx
         mMgPa/1CXNySeswh/8fwKFSwp/yi68T/QnXIIaW8RL8MwXQjVrsQ3+zpFXq2b4EOOvqn
         ndPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790320030; x=1790924830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JaEAeO+KpKKY3qs5B15P5jzMNjkhf9IQUFD5AfYaJCM=;
        b=MzSgxIp878Uz1dwGjsVTVHOIG1T7GB8Qr/G6V1kUQxZYeZOfCsBDhnngFIPpEhXtj8
         jAtFw4Qgz4KUCU098wqjuZ7ZN7+Nxr2bX8XDRysYsB91xRr6VGTcGpBhDmg/1ClCTp4h
         G16Q1j09Z8RelQ1tkJrlRjUxEnHBia/TEQqZdLXqjWrSt2Ps14AnIfC1XVdXzQkHKwCa
         Qv+/3qZ/xiU7n1RWtHOo+LCsrMS9sqk4IcJJ/QBeQDQgcALUDQ2V0VkTxax6OQ1gbQS5
         K8zKLlmCfIChjktVNlun2g+tKENj3G7irUTDqUIPkUJPBKYoeDjsiSv5Bj1r9+rhe7NX
         pVcA==
X-Forwarded-Encrypted: i=1; AKwUvBzxOr4/tMhZFGeQ6ZD5iPQbyVBtS4zcsfAIWMAkKPyivj7p179iEbKvrBBqFK7nd5L0SkoDL2pBGmv/bUQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k2l/oloFgxHoO8eqRLM/KMpVbR88mYbMZRE9UY4Fk3WNH5ge+f
	inxxV/8deyXrk3FaF6fpVvn8xAfeUfvu4goUJzlmjGuU7KSATN1Ft1BP
X-Gm-Gg: AYBFou26DALfxfLKUNndjy823XuoHLdOzu1TOCJqFPm8sjvxKJSIvPNYP8du1UQ0hA6
	TJA/AK5HnSrGFN11+6yGeex4GjOMkP+9xvgekOARewfzAstClslkYPnHJMwEKpLCIen/lhyUjol
	u7yNjfS6Nw2IwXG5lgMfozlA1fjWqho3wMHni30zFbinAxTDPAba2ifr5yznDq0qFnMyL9aC8bD
	yyx1VMTVuJ5vhkUsYfIoADIADYvZyA/7q0cFqtiTDBA2iEBi+FawzBYqXHyqXYWgrugn3XCckXM
	yfjTFJ+SpDWGyFYvwwhygo+0KLqOwebhsldRCtfNAbmkc2xMY6iKss2tspCVhvH4UTMSabEczGF
	VqzRgxqmLG7TDKjA9v12RpsCTXpETm45lRyp8/IBqBvt4iiXCRFT7N+dqvrmZ1KAOU/Et+En+zu
	GKpCJFYy7k9WRmzdgabQn0JXViESy0w+dASaqnZk+Uhv7BlNt8x1tnTgTFND+dscXkLVi4PkJ1Y
	fg0QUNTk5yi1MHdLj5wi218fwQSmjgbXq7CItov0+Dg
X-Received: by 2002:a05:693c:42d4:b0:33b:e47c:f384 with SMTP id 5a478bee46e88-34004f81e77mr3753409eec.18.1790320029935;
        Fri, 25 Sep 2026 00:07:09 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407c548sm4116769eec.8.2026.09.25.00.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 00:07:09 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:36:59 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	ritesh.list@gmail.com, sshegde@linux.ibm.com, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	linkmauve@linkmauve.fr, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, FUJITA Tomonori <tomo@flapping.org>
Subject: Re: [PATCH V6] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <arYcMdA3Zn10Xbr1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054311.906816-1-mkchauras@gmail.com>
 <c91d9441-27ce-4fdd-b3c7-10b972f867af@kernel.org>
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
In-Reply-To: <c91d9441-27ce-4fdd-b3c7-10b972f867af@kernel.org>

On Thu, Sep 24, 2026 at 02:55:55PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 22/09/2026 à 07:43, Mukesh Kumar Chaurasiya (IBM) a écrit :
> > The Rust kernel infrastructure generates inline asm for WARN() via
> > ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> > preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> > arch-specific asm template string for use in Rust's core::arch macros.
> > 
> > powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> > Rust builds to fail on powerpc with
> 
> I'm a bit puzzled by the macro name. The name ARCH_WARN_ASM suggests that it
> is used for warnings like WARN() and/or WARN_ON(). Which means it should
> include flags BUGFLAG_WARNING and BUGFLAG_TAINT(TAINT_WARN).
> 
ARCH_WARN_ASM is a raw asm template used by the Rust warn infrastructure
(rust/kernel/bug.rs). It does not bake in BUGFLAG_WARNING or
BUGFLAG_TAINT(TAINT_WARN) — the caller (warn_flags! macro) is responsible
for ORing those into 'flags' before expanding this macro. This matches
the x86 convention where _BUG_FLAGS_ASM is also flags-agnostic.

> Also I have the feeling that it only handles WARN().
> WARN_ON() seems to have been forgotten.
> 
I might be wrong here but WARN_ON uses an unconditional trap and
requires a register operand in C side. I am not sure if rust can do
that.
> Christophe
> 

Regards,
Mukesh


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
> > To add ARCH_WARN_ASM, _EMIT_BUG_ENTRY first needs to be refactored.
> > The old definition was a bare macro with no parameters, relying on
> > positional asm operand references (%0-%3), hardcoding the backward
> > reference to local label 1b, and including .org/.previous directives
> > inline. That made it impossible to compose as a plain string outside of
> > an asm operand context, and left an invisible contract that callers must
> > always emit their trap at label 1:.
> > 
> > Refactor _EMIT_BUG_ENTRY to take explicit (bug_entry, trap, file, line, flags)
> > string arguments via string concatenation. This removes the dependency
> > on asm operand numbering and makes the labels an explicit argument,
> > so the caller's intent is visible at the call site and a future caller
> > using a different label cannot silently produce a wrong bug table entry.
> > 
> > Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
> > each call site, so BUG_ENTRY() can still pass sizeof(struct bug_entry)
> > as an asm operand while ARCH_WARN_ASM can supply its own size string
> > independently.
> > 
> > Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
> > convention, indicating that no additional reachability annotation is
> > needed after a WARN on powerpc.
> > 
> > Reported-by: FUJITA Tomonori <tomo@flapping.org>
> > Closes: https://lore.kernel.org/all/anG67Q6Y59kDqh-c@desktop
> > Fixes: 73b741adb264 ("rust: Add PowerPC support")
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> > Changelog:
> > V5 -> V6:
> >   - Dropped KUit tests from this series. It will be sent separately.
> > V5: https://lore.kernel.org/all/20260915090453.1227034-1-mkchauras@gmail.com/
> > 
> > V4 -> V5:
> >   - Fixed a build error with DEBUG_BUGVERBOSE=n
> >   - Added a label for bug entry
> > V4: https://lore.kernel.org/all/20260912065902.24017-1-mkchauras@gmail.com/
> > 
> > V3 -> V4:
> >   - Fix Label with appending b at end
> >   - Add KUnit test patch
> >   - Tested on ppc64le pseries: pass:5 fail:0 skip:0
> >   - Tested on ppc32 QEMU mac99 G4: pass:5 fail:0 skip:0
> >   - Tested on ppc64le QEMU pseries: pass:5 fail:0 skip:0
> > V3: https://lore.kernel.org/all/20260910100801.2159785-2-mkchauras@gmail.com
> > 
> > V2 -> V3:
> >   - Add label argument in _EMIT_BUG_ENTRY
> > V2: https://lore.kernel.org/all/20260910071252.1950488-2-mkchauras@gmail.com
> > 
> > V1 -> V2:
> >   - commit message now has error, fixes tag and closes tag
> > V1: https://lore.kernel.org/all/20260819084825.969116-1-mkchauras@gmail.com
> > 
> >   arch/powerpc/include/asm/bug.h | 46 ++++++++++++++++++----------------
> >   1 file changed, 25 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> > index 0db48977c70c..bf31ee1e902a 100644
> > --- a/arch/powerpc/include/asm/bug.h
> > +++ b/arch/powerpc/include/asm/bug.h
> > @@ -32,34 +32,38 @@
> >   #endif /* verbose */
> >   #else /* !__ASSEMBLER__ */
> > -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> > -   sizeof(struct bug_entry), respectively */
> >   #ifdef CONFIG_DEBUG_BUGVERBOSE
> > -#define _EMIT_BUG_ENTRY				\
> > -	".section __bug_table,\"aw\"\n"		\
> > -	"2:	.4byte 1b - .\n"		\
> > -	"	.4byte %0 - .\n"		\
> > -	"	.short %1, %2\n"		\
> > -	".org 2b+%3\n"				\
> > -	".previous\n"
> > +#define _EMIT_BUG_ENTRY(bug_entry, trap, file, line, flags)	\
> > +	".section __bug_table,\"aw\"\n"				\
> > +	#bug_entry ":	.4byte " #trap " - .\n"			\
> > +	"		.4byte " file " - .\n"			\
> > +	"		.short " line ", " flags "\n"
> >   #else
> > -#define _EMIT_BUG_ENTRY				\
> > -	".section __bug_table,\"aw\"\n"		\
> > -	"2:	.4byte 1b - .\n"		\
> > -	"	.short %2\n"			\
> > -	".org 2b+%3\n"				\
> > -	".previous\n"
> > +#define _EMIT_BUG_ENTRY(bug_entry, trap, file, line, flags)	\
> > +	".section __bug_table,\"aw\"\n"				\
> > +	#bug_entry ":	.4byte " #trap " - .\n"			\
> > +	"		.short " flags "\n"
> >   #endif
> > -#define BUG_ENTRY(cond_str, insn, flags, ...)		\
> > -	__asm__ __volatile__(				\
> > -		"1:	" insn "\n"			\
> > -		_EMIT_BUG_ENTRY				\
> > +#define BUG_ENTRY(cond_str, insn, flags, ...)			\
> > +	__asm__ __volatile__(					\
> > +		"1:	" insn "\n"				\
> > +		_EMIT_BUG_ENTRY(2, 1b, "%0", "%1", "%2")	\
> > +		".org 2b+%3\n"					\
> > +		".previous\n"					\
> >   		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
> > -		  "i" (flags),				\
> > -		  "i" (sizeof(struct bug_entry)),	\
> > +		  "i" (flags),					\
> > +		  "i" (sizeof(struct bug_entry)),		\
> >   		  ##__VA_ARGS__)
> > +#define ARCH_WARN_ASM(file, line, flags, size)			\
> > +		"1:	twi 31, 0, 0\n"				\
> > +		_EMIT_BUG_ENTRY(2, 1b, file, line, flags)	\
> > +		".org 2b+" size "\n"				\
> > +		".previous\n"
> > +
> > +#define ARCH_WARN_REACHABLE
> > +
> >   /*
> >    * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
> >    * optimisations. However depending on the complexity of the condition
> 

