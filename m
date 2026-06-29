Return-Path: <linuxppc-dev+bounces-23046-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91431C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 04:57:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpYtS6FXkz2yT0;
	Mon, 29 Jun 2026 14:57:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782709056;
	cv=none; b=Kx8VV75K/Kr9ZsELJGr6dJOEdIXvH5kogAXLqh9H0lvhIOuuf+m9+cMkUJBCrkzguHCcw6MuoSk2Ez4CAgLlxzlGjiSlJyP3PdlVZ+HSIfO+fYwqNoK/l+/89Q99zxPUUKTBZn0T45Gu4uQecASdaDVXdkOckIW+kr4ll0b2BaY9NWNkXAKCmAVAu4ROsxZdIbx+A+5VyMmhw6NdVaIKs9ywYa8TuAu5rUfTqYvkdlOlZ9pKLW2MdikiIOIJU+Dcd9/2ewPQeodunwrvGja/iCLfiD4zqxZSad89iIfWWQmKLFWsAZv3MKTITBFEG3fPFgLYxokUXiOq0MtRj+dSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782709056; c=relaxed/relaxed;
	bh=iQD/rHZj3a8p2S8n+F8bG5yMjsLxWvoQVhtFef2fXlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh20WW3a35nEKjZ7dx6dA+DauB6Rn5LvmA8emkQxOM9TvDrD4egdwl4OH281BNP+HUCaeOhLrZs+iyCZrtkClAnp56Rth5xccP1QIveF7nJK6JCYhX7RKiQZ86vjmMakXZ2gXlotKa6CbtUZ+1RcEZh/TccHfX2OL7vqTfWlzKHQsZXHD5jyBrGrmC3UiekzAkPFNtj9IkcTnY/Y7CDHZFa+rcmpvJuF0G128Y5IgaM9fjl4RglJavT8yDRvTADHi8nSqLju4jMEqok3mSdmIDLkbzbLj6vT1sdVK+14/neyVRi/RZmN/ev7HgGT1wWhHhN5Y0n9fDRwUbcMZv6PZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=earvLXkZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=earvLXkZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpYtS0CJ5z2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 14:57:35 +1000 (AEST)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-30b6dad2382so5494530eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2026 21:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782709054; x=1783313854; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iQD/rHZj3a8p2S8n+F8bG5yMjsLxWvoQVhtFef2fXlQ=;
        b=earvLXkZleroeWM1OPD/kprCNIl29t00ayB8JHp5D6qdcV0pRRiFM/KGYmVvfpFHBf
         LCynKcR2TzVVxmacIqvBAPlcT5iUxxG/x6EzHS6DMBFgpLIuwfTGd1rSH91RFOQ3Gc7x
         lc+3ViSCq03V5jQa+vgLUwJ4UE210YBGNBVy4QTwcgpOO6u5Pw9tZJQ/LhWY6KwJHdbf
         TsukwQwgykY7JB+AIRYFzdQ0ALTyqurmgV7UCWrhSrz1Dy9V06tmYxxnx20UeYkk/nIc
         8brmW+QH4q6xLo2ULuXTSrMUYPs4l+tiKWfogY9KFQqCCgmhtQMUYwuGiytqw/pr1TJR
         1FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782709054; x=1783313854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQD/rHZj3a8p2S8n+F8bG5yMjsLxWvoQVhtFef2fXlQ=;
        b=d3ks67Uu+KXZ9UnoioP2lOuJlUYABiGpYNFxw8h0VKUZ5tjr4fFPkGulUunpJXTg6L
         Q193pcmkgePWbaK0yB/YjQP4rXSuDtot1hDMw4XFgrmcdkkIk+kMCPXsRbuoRq/bpj9i
         tQrJ1d4QJfIvyYdX3I2E7m4pVPjbEAcR9DG4iMn4UBcfvJBZlbaOX3uAiBp857AOyDGj
         0JgugIkureXVOy7LyyHYQhn1oNkXFuIjAKaWSJMiFCFBE/7X7iMmFyJyF1IjQ+tztnF+
         bt1crtsG1l5THcAcSBh0+2/nnUc+CD8L5/KZcZvyjErZbm4yPyMGIZbTmOIfJTD0BAtg
         B/Ew==
X-Forwarded-Encrypted: i=1; AHgh+RogMVB+IvtZx6pq4gFoa+Bjs8dFvx+xEFHQrv9vosRR7fvmTVkBpEymq7qIhSylRRpTUt/aWsyKEFjoi78=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzn/2DqOlSATsE5b+sDx+x72aWGfDRk+r8MZKI/6hm1BzBORKFA
	DtcJegSzOEl9IrDL6v7lnxdFzqxzpx5wSq9q+EMTDWYpipyGjvTq2Fjm
X-Gm-Gg: AfdE7ckagryhzapJfYassVavzCR069HuLtCk3avPenCqwXdaxJA4Zfvv5ejYHwKsI2f
	Gh8vhPl/ZfpQdsq/7DR5I06ImrTs0DJXXyCPYlqDk49lw+//bgqK6B5ARP8wZDJEAphWYwXzGhl
	bf2+y1txzuf5TQAWcNuwMgxBWZxgjPhNrZT7hJOlSVw+DDGT4Dmse0cLSB54EwoIQ/mNIEHzKgr
	BHH8LFRKm80TPNZaAS46wM5C3t2+fZOMK+jw9kG1DYWbINM3DaOCboeQ+Hv5+voWXHhhuhpQqdG
	3yGbwWTuY5ajrHWY70gl7GVDAFnLXUDhVgD1KisUhpw8svo1cUBMHEQBSFVQrzDBGVyKE7SnsU+
	txKHMjOtbe0WziXe/b0XlpFkopxJDWnM9b5gHU35WGXHeD1PPHmjnWKMh9dBiN8oPDoAkZKflTL
	/H8mSwgFFdqspxn3bMmfs8T2uuttwmohMQ53f/iYfipjqSPpfv1S3ifcVaV7sve2Q4j21//rU=
X-Received: by 2002:a05:7300:e8a9:b0:304:bce8:fa30 with SMTP id 5a478bee46e88-30c84b2c0c8mr15331021eec.5.1782709053542;
        Sun, 28 Jun 2026 21:57:33 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca87caasm39851291eec.27.2026.06.28.21.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 21:57:33 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:27:19 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, fujita.tomonori@gmail.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, tamird@kernel.org, kees@kernel.org, 
	lyude@redhat.com, airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <akH6yuDH9ZwXVoVA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
 <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72=EVsTFkQK3LWrT2Gs5UKKViemGkv1WuitY6NOEtvcsNg@mail.gmail.com>
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
In-Reply-To: <CANiq72=EVsTFkQK3LWrT2Gs5UKKViemGkv1WuitY6NOEtvcsNg@mail.gmail.com>

On Fri, Jun 26, 2026 at 12:17:50PM +0200, Miguel Ojeda wrote:
> On Fri, Jun 26, 2026 at 8:50 AM Mukesh Kumar Chaurasiya
> <mkchauras@gmail.com> wrote:
> >
> > This corresponds to a floating point instruction. Although we have
> > disabled fpu, vsx and altivec we are still generating these. Seems like
> > we have some issue with the rustc here. I didn't dive deeper into this.
> >
> > Is it ok if we keep 1.95 as base for powerpc64le?
> 
> It may be that it is generated but unused (we have that issue
> elsewhere -- see e.g. `rust/compiler_builtins.rs`).
> 
> Having said that, if 1.95 is fine for the powerpc arch maintainers,
> then that is fine (s390 also used a higher minimum -- please see the
> recent change in `scripts/min-tool-version.sh`).
> 
> But please try to bisect upstream Rust to see where the change
> happened, i.e. what is the root cause? e.g. `core` changes, `rustc`
> changes, built-in LLVM changes... It could be that it is not tied to
> the `rustc` version but LLVM's.
> 
> Cheers,
> Miguel
Hey Miguel, 

Sure i'll bisect. Meanwhile i would still like to get this upstream.

Hey @Madhavan,

Can we pick this version up for ppc?

Regards,
Mukesh

