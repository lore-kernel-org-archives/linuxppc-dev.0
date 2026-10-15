Return-Path: <linuxppc-dev+bounces-29547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DABACC6B34
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 06:35:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4yxQ6KTbz30RN;
	Thu, 15 Oct 2026 17:35:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792046122;
	cv=none; b=hSNeGgX7wqgi794RZtgDi8empMNOewnAkeYSQOGcukxwHbeuXVubvWBadh1jE06vwmSF8BVeV2Dv7+JIImUWEgviozEeBnSe6KMzTDE631OMVSFJiEpwMsfMotvfvYhpEE+ps+x1Ew9oysgam86C8f/wjMPddw+x897Jiym6sY8Qbq+Z64kGeb+/rb1U4YOt9mWGsTYPL9fd5RWHNdRZVB8sw9J3g84rNB0s0XsF5e5D+Ywn3cos9wfBUHJf6avZs6qCgwwfjIgV/VgZ1enzklBYXVx/3ee2dAuV1YYXRwHtbAbcLj7ZOK83ewK64oV1OAxjctUKaPiAE3omw1pNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792046122; c=relaxed/relaxed;
	bh=vx7M7s3SuZxFkSx1BxbOLI08ri7SD/5H0oyHxOOrQc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCaS1arDr8+41K27GHqr1O7sC8l9gKCshmUkMN0ZMpT9eig1qIo7g+FOdpweLhzMGc6R9jYwBV+AbNHDolvN6wmzxcsTkMAUwuAE06RRkZykGwC88HiU6uJ+dwAixItk5qiaOP2UTi0pXEU7pkWEPGCtFtsGCNxr1/pRFyK6ZzkZ3gVWuK27XGMD78+FKEKSp5Pqr/3PGs5l7I6S+Nu4RAPNXhyycXT7pS7WTOL9maujyKKhmEqORhPzQoTVwSdnboe3lYB0HrYAv24ADoJwvQUFV5eX8AMNFifBXfh6MAKmPEHknmQESez979Cif8srYhIrYQ/GahKdA8bI5mDHOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eoHNCHjm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eoHNCHjm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4yxQ0Cw8z2ylj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 17:35:21 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso841804a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 23:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792046119; x=1792650919; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vx7M7s3SuZxFkSx1BxbOLI08ri7SD/5H0oyHxOOrQc0=;
        b=eoHNCHjms6+pVl8zLrT5BtkdBpz2bJO+Sfnl+JWqULJz4uZf70AHuzlDVSZ5uZyBeN
         p8KpCXnFOARcCRI9RY186CKcYovtit0IaXUem7xp7Gd1yXkTeRXP7HhuoNaIqJmZxGZF
         pR//fBKJEIiMCCkjTuFChxeW96a3vYxYxfI9ctQM8gGx1CzX0tnliAM2JWZUU2wkyk8c
         ZDzmG8dq8KdFXE8642ySZWONfIoG9fPqwo8u7LTGFM4qkcmGlxUDlU8kyhH58xx+iBz4
         UHuhuXeC84v9/U7xxDisi+YmN1JJp1V7C4u8WuFli8/7USCVa2njETF6AWtuX9kgo3KC
         sDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046119; x=1792650919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vx7M7s3SuZxFkSx1BxbOLI08ri7SD/5H0oyHxOOrQc0=;
        b=NVhGMpdi45/ownW8rlNPb5FxX4vvHgqeOHMIfnXSKpQova0TQ9zAX1BGEurziZvKCa
         zWsclu7Vj1utRqk4bZ92W3qv6hJrHet6YaKhUyGiJqXJ4wR/Djom0CP4DgdqWqRTkGQe
         UjKhgYsh7ztHxLkk9qKFApbmtikoOht55v5/goMSiHhkSS0vC9JaacDRTAOrBKpb5UoQ
         S4Z/B9eOys4l9z7T09gojgPMrjNqYl0Gl3ZngZn0D7vSQe8ov1AvcLh7lYT1xqxWIhc6
         8WUgL56ugfOGPqAboVg6IiFAMxY67JpCMTTKFCcXMqM+3ukcDvNKQUdsKxc5kTsays6Y
         JqIA==
X-Forwarded-Encrypted: i=1; AKwUvBxPyzzOPISOpOE1Qz1KPQxg8ikdy5b1E22eHTh3yXVbIv5S5BQnA1FIYWxot582g6xfZkKjTGnY1dw5kN0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIyEA8DtAUr7XYBLVisf2+npn9S+QgEkhImMKrX+NghE8QsxxOn
	Aw8H0hyPL2CwL3B3v2QvzSC1Bfiqdvsl36aFdijEhIlaD4nE2XZgJWIr
X-Gm-Gg: AYBFou2jIqWvPaU8agC1SrwXUYgbIz/O1KxkhYppBM1SJkYygJHme0zmMKJSy4hjioy
	mJgQndO98i8XMDAktX59jLz7DXOpe44P4I0nad1rJHEfTIC1nxVrw6mnbdGX9rYPeI5EPiXucuj
	1PJSsuZe2MU2Ue4ujDZrEvHTp4MXflR2yq7eonnCIuV4XM4wNKP7Y65GigZjAj19DLMzcAvOnxV
	20klOeHJkBwviztuCt6YSFlyylDRu0RoOISgz67IanwCJqjnX2HSM4QHfUd075quUUZgy42bhFw
	QXKd0wGf/6Z8e88y5TE34s7qtuLnMJFWgsQ35qktmsJFGwbzfq8aNy/9urleD77S+G05ovpiKnS
	6kYEKqE37a9/zq3GXeCPiT2JRHtWvm37crRvDuAMp3TgrKfhIvpLVT0ymPT+sXUAgXChXiEHu6N
	C8/1LwIHMTGlHIgClZBbgAXtHnR7x/AXTXC3aMJgajkTA2f0k8np4tAS5+4nO8dJX33sqgeBa+s
	FVUHJmjwBRgpm1SoPiTvqzxga/3vMX+PYiW214lRgc=
X-Received: by 2002:a17:90b:384a:b0:39e:6a81:c923 with SMTP id 98e67ed59e1d1-3ab3a90a112mr13973663a91.22.1792046118994;
        Wed, 14 Oct 2026 23:35:18 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e755bsm2856756a91.2.2026.10.14.23.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:35:18 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:05:07 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <tomo@flapping.org>
Subject: Re: [PATCH V6] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <atBzxk9JFdXKYHfN@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054311.906816-1-mkchauras@gmail.com>
 <as08wgiYOGOx5Jzo@desktop>
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
In-Reply-To: <as08wgiYOGOx5Jzo@desktop>

On Mon, Oct 12, 2026 at 10:02:10PM +0200, Link Mauve wrote:
> Hi,
> 
> With 7.3 close to release, and this patch still not merged, the kernel
> will still fail to build with CONFIG_RUST=y on PowerPC.
> 
> Should the Rust support for this architecture get disabled as an
> emergency measure before 7.3?  Should this patch get in instead?  Should
> we ignore the issue as not many people will use this architecture
> anyway?  Is there another solution I’m not seeing?
> 
> Sorry I haven’t made it known sooner, I was busy with things.
> 
> As an aside, this patch does fix building Rust drivers for a Wii, so it
> gets my:
> Tested-by: Link Mauve <linkmauve@linkmauve.fr>
> 
Hey Link,

This is in line for 7.4.

Regards,
Mukesh
> On Tue, Sep 22, 2026 at 11:13:11AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
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
> >     |                            ^^^^^^^^^^^^^ no rules expected this token in macro call
> >     |
> >    ::: ../rust/kernel/lib.rs:279:1
> >     |
> > 279 | macro_rules! concat_literals {
> >     | ---------------------------- when calling this macro
> >     |
> >     = note: while trying to match sequence start
> > 
> > error: no rules expected `ARCH_WARN_REACHABLE`
> >    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable_asm.rs:1:28
> >     |
> >   1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
> >     |                            ^^^^^^^^^^^^^^^^^^^ no rules expected this token in macro call
> >     |
> >    ::: ../rust/kernel/lib.rs:279:1
> >     |
> > 279 | macro_rules! concat_literals {
> >     | ---------------------------- when calling this macro
> >     |
> >     = note: while trying to match sequence start
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
> >  - Dropped KUit tests from this series. It will be sent separately.
> > V5: https://lore.kernel.org/all/20260915090453.1227034-1-mkchauras@gmail.com/
> > 
> > V4 -> V5:
> >  - Fixed a build error with DEBUG_BUGVERBOSE=n
> >  - Added a label for bug entry
> > V4: https://lore.kernel.org/all/20260912065902.24017-1-mkchauras@gmail.com/
> > 
> > V3 -> V4:
> >  - Fix Label with appending b at end
> >  - Add KUnit test patch
> >  - Tested on ppc64le pseries: pass:5 fail:0 skip:0
> >  - Tested on ppc32 QEMU mac99 G4: pass:5 fail:0 skip:0
> >  - Tested on ppc64le QEMU pseries: pass:5 fail:0 skip:0
> > V3: https://lore.kernel.org/all/20260910100801.2159785-2-mkchauras@gmail.com
> > 
> > V2 -> V3:
> >  - Add label argument in _EMIT_BUG_ENTRY
> > V2: https://lore.kernel.org/all/20260910071252.1950488-2-mkchauras@gmail.com
> > 
> > V1 -> V2:
> >  - commit message now has error, fixes tag and closes tag
> > V1: https://lore.kernel.org/all/20260819084825.969116-1-mkchauras@gmail.com
> > 
> >  arch/powerpc/include/asm/bug.h | 46 ++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> > index 0db48977c70c..bf31ee1e902a 100644
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
> > +#define _EMIT_BUG_ENTRY(bug_entry, trap, file, line, flags)	\
> > +	".section __bug_table,\"aw\"\n"				\
> > +	#bug_entry ":	.4byte " #trap " - .\n"			\
> > +	"		.4byte " file " - .\n"			\
> > +	"		.short " line ", " flags "\n"
> >  #else
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
> >  #endif
> >  
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
> >  		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
> > -		  "i" (flags),				\
> > -		  "i" (sizeof(struct bug_entry)),	\
> > +		  "i" (flags),					\
> > +		  "i" (sizeof(struct bug_entry)),		\
> >  		  ##__VA_ARGS__)
> >  
> > +#define ARCH_WARN_ASM(file, line, flags, size)			\
> > +		"1:	twi 31, 0, 0\n"				\
> > +		_EMIT_BUG_ENTRY(2, 1b, file, line, flags)	\
> > +		".org 2b+" size "\n"				\
> > +		".previous\n"
> > +
> > +#define ARCH_WARN_REACHABLE
> > +
> >  /*
> >   * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
> >   * optimisations. However depending on the complexity of the condition
> > -- 
> > 2.55.0
> > 
> 
> -- 
> Link Mauve

