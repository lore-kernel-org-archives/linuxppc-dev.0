Return-Path: <linuxppc-dev+bounces-20078-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C071FE5214
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 11:57:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2BKx5sTLz2yYs;
	Fri, 24 Apr 2026 21:57:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777031877;
	cv=none; b=XqDMlrQePshFc/wGGbunrdnbyBxuUhe/RU3/52xHZ9Px/dfyPgTx+3iOf0OefrI0X9+zWns5g9lIbU4MYjmkqFJjGAUceoj/TNVxnDxFRZPRtqs+yjhYo4lNpNRziYbjHKcMmTKyV4AAjoaK4mR2mQvYRTA3e5GR5kgomnrODgu7ukMMyIt/8KBxPEQzCFM70km6ym4IkUHhf2rnTNHRt1YdCn/5SG4MSqLujoURNsb3cyLiEIQPtmZk2BVjK4F+odJuGjvyHCjqNT3YMoJA7nBoSUfWSiHv3Q1nBcWQ3CVHgsdMG4jWSWoKAFCzau7BzqrlaniyF9Wf9XweHPwJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777031877; c=relaxed/relaxed;
	bh=IdMGqN0pGmbyk8J7Ch8SXYxu5eT09q3Ta+/86Ji1lLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P49ahG7h7WLsut5hVh7Tpaaf5150Dh1IXbtpwjrVhclkneN5JIxahwW4zkJLhs51DMNeyGFDpU7u9EPvEvnVE01k6S69J0rTE9DEqbP5Im13KDOueXsy7KltytxJETradGyt90krAdPLwLqPM3hmhVyXZQRelzrnosqt07TWPKCEE7kYQ7G7DByUb9jaP1LDKwBDBUKy/2Bo+MN7hrcxm6QKlOzSxPzs8Vndzi/yQZ2FBCkVmE9Q6WbzqvTkD9V2qYEFthURzugJlqAE4tnlUPyt13afehz4f1lQxY2luFdnDhwjpqLgAtMpmcSQgGd7tXeAXDJRZxDgmOwOOdiq+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2BKw5PwKz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 21:57:56 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63OBvJ0f186057;
	Fri, 24 Apr 2026 06:57:19 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 63OBvCZI186048;
	Fri, 24 Apr 2026 06:57:12 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 24 Apr 2026 06:57:12 -0500
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
Message-ID: <aetamPA_SsWcwC4M@gate>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <aetZ3VX_Y9sop-SO@gate>
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
In-Reply-To: <aetZ3VX_Y9sop-SO@gate>

On Fri, Apr 24, 2026 at 06:54:05AM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Fri, Apr 24, 2026 at 11:17:40AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > The core crate currently depends on these two functions for i64/u64/
> > i128/u128/core::time::Duration formatting, but we shouldn’t use that in
> > the kernel so let’s panic if they are ever called.
> > 
> > This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
> > build on PPC32.
> 
> GCC uses calls to functions like even __addsi3 whenever the (sub-)target
> does not implement some RTL, doesn't have a define_insn and the like for
> it.  When you write a new port you only *have* to implement a very few
> things, the rest is done in libgcc (you might still have to write some
> of that for your target, no free lunch etc.)
> 
> 32-bit PowerPC has no instructions for 64-bit divisions, nor
> instructions that help implementing it in software.  It still very often
> helps to hand-write machine code for it, it very easily can usually be
> more than twice as fast for example (for example if the divisor is less
> than half a word big, the common case -- it can be made tens of times
> faster then).
> 
> There can be many reasons why a GCC backend decides to call a libgcc
> routine.  For __udivdi3 on -m32 rs6000 you'll be good AFAICS :-)
> (but poisoning functions like you do is a terrible idea in general!)

Whoopsie, I forgot to mention:

Approved for trunk.


Segher

