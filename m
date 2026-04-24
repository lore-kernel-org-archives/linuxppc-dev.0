Return-Path: <linuxppc-dev+bounces-20082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44D1FED3C5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 12:54:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2CbH0jsJz2xwH;
	Fri, 24 Apr 2026 22:54:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777035275;
	cv=none; b=cCuoUXsiImrX/Z/DWzl5fgAx1N5PDkiDv2qFhCf/wk3J8dQvBa+mOGFyq47rT1DdqOouPc2hmBiPR0nNpq1wcrBUQTnKw8YrFAYk9jpuJPtANGTkLwT5LT9C2gNjo2ggQYcNcQPjLfoi9lTeka8Pa03KkP+gpNNqyqFjDuVQKRjifbkKmH+vV/5eiS9bwgqxKok+lHxwsWskE02JBqxpygTFYSRD+3L3IMf9ErGs/AtMBC8lp5zHXMlB2rqQqL2r0F93JXAlTGYba5Y6DT2kBpB1l5gFO2uQIpWF7ay0cSwLVuV8zkZ9AXdM3/snjOOSVEkhfnbuUIjfz9jyP0efGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777035275; c=relaxed/relaxed;
	bh=kAR6eWHeLAHdfiZel9idOKhb7FZJp/1ZVQ+s0RseUhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHMVDrAOUFVrsPvCKq2fc8hz/7YgJIp4r2/qUZixWeY1bjb8UzUsTbwm+3ggngDxLNH3KTjBKdVEATNALhDfL5ZJ3+MvPLMtZ5OH7aCNLs/fDxOcqYYavu8xpdzLK87YwXEXioaHL8cVamiMvx6V7Px4F7dMC6UOHtv+dX5HX3LMRiDUoyTP1mq6Q7zuJ9Ti93vmx87O5AagA7dP5ID7qYtYJl5UzV0vrlU9hq3MEiQgn/v641r6sF+ArU4VfFWS1h6MX6obG3ycB5dSxTSKlnMW95zKQcwjj5dexXsIeFUXdoo+SZec8LOAqDoX+SWhDnusQCxszuMOWxmrG2jUwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2CbF1vj1z2xQC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 22:54:32 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63OCrj9o193708;
	Fri, 24 Apr 2026 07:53:45 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 63OCrhor193703;
	Fri, 24 Apr 2026 07:53:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 24 Apr 2026 07:53:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
        ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
        ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
        nick.desaulniers+lkml@gmail.com, morbo@google.com,
        justinstitt@google.com, tamird@kernel.org, arnd@arndb.de,
        nsc@kernel.org, simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
        Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <aetn16xR-uy7M7WA@gate>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <aetZ3VX_Y9sop-SO@gate>
 <aetamPA_SsWcwC4M@gate>
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
In-Reply-To: <aetamPA_SsWcwC4M@gate>

On Fri, Apr 24, 2026 at 06:57:12AM -0500, Segher Boessenkool wrote:
> On Fri, Apr 24, 2026 at 06:54:05AM -0500, Segher Boessenkool wrote:
> > Hi!
> > 
> > On Fri, Apr 24, 2026 at 11:17:40AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > The core crate currently depends on these two functions for i64/u64/
> > > i128/u128/core::time::Duration formatting, but we shouldn’t use that in
> > > the kernel so let’s panic if they are ever called.
> > > 
> > > This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
> > > CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
> > > build on PPC32.
> > 
> > GCC uses calls to functions like even __addsi3 whenever the (sub-)target
> > does not implement some RTL, doesn't have a define_insn and the like for
> > it.  When you write a new port you only *have* to implement a very few
> > things, the rest is done in libgcc (you might still have to write some
> > of that for your target, no free lunch etc.)
> > 
> > 32-bit PowerPC has no instructions for 64-bit divisions, nor
> > instructions that help implementing it in software.  It still very often
> > helps to hand-write machine code for it, it very easily can usually be
> > more than twice as fast for example (for example if the divisor is less
> > than half a word big, the common case -- it can be made tens of times
> > faster then).
> > 
> > There can be many reasons why a GCC backend decides to call a libgcc
> > routine.  For __udivdi3 on -m32 rs6000 you'll be good AFAICS :-)
> > (but poisoning functions like you do is a terrible idea in general!)
> 
> Whoopsie, I forgot to mention:
> 
> Approved for trunk.

Ugh, for some reason I thought this is a GCC patch :-(


Segher

