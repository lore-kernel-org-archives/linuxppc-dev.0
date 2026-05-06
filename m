Return-Path: <linuxppc-dev+bounces-20525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EAACD343B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 14:43:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9dRf3YmBz2xnM;
	Thu, 07 May 2026 00:43:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778078622;
	cv=none; b=KaadGZ54rCzdwzz/r9BlflzhZzbEYlG1yDO7/AyJNvgLcWxS/E2VUEIaUn3TNB8R36QwIE7dvZXhhhncMAomuil72GyUgGxq16AZnHs1YMqNc/FwPRsE4COfc7daQwnSU3Klo4nSpdEV/tDxYN2M7R8qlcS+r+eE8YWPSUy3j6wgFUcxg6rQ7xzc89JGH6nt4+lLJcXnwWjl34Ub3J5JMI9RjAexNJ0rd3eb0ZaziYGFXkPrc6TWlaG159Ta+TNoYZYqyAaNVvB0ULcK/rY+QQe6fE+WG35MwVWHVvBruRVk9f7eJeooCoxnkX2H9t0BfoKcOYHVnYzlofl95eqKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778078622; c=relaxed/relaxed;
	bh=g6j+4hvOZbb2pIziVXaTVtYdQKT2UGPALNLn+EoB9Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3r7Ln7ONcqaC+hLLg79DWTh4aFaCZvu3TplPTl0NaRpawQ/o4OOWE7rsFvCXvMhLhcwXh5IvkXOJgexN4rDbrgFSrnj9kORfbQwhv88+Lzy+I1YRGHMpQTjEufbgFI/RfrFxHaGdHUgoH3/5NgYnJSNM71mmky0YtvPT/AJAVdgw+iPYPqvXaQsRY9AI7d6ILYcO7gBQZSV3P/KrAvfckBOjaq0J2mqXE2k98dg4RdxXKI85mI4GenfkDJv0mf2/7DLiB33kNbj3eNvCxbuWifzO2QjyhnOC4V1K0Ib7PEdW94uf/lDo8H3wtfZrDbn/BaelOqgGw9ppLw6N6Gyxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9dRd2dn5z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 00:43:40 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 646Eh2V8354877;
	Wed, 6 May 2026 09:43:02 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 646Egtn5354867;
	Wed, 6 May 2026 09:42:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 6 May 2026 09:42:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sathvika Vasireddy <sv@linux.ibm.com>, nathan@kernel.org, nsc@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, jpoimboe@kernel.org, ojeda@kernel.org,
        masahiroy@kernel.org, lossin@kernel.org, tamird@kernel.org,
        thomas.weissschuh@linutronix.de, rostedt@goodmis.org,
        ihor.solodrai@linux.dev, thuth@redhat.com, pmladek@suse.com,
        aliceryhl@google.com, elver@google.com, kees@kernel.org,
        legion@kernel.org, ardb@kernel.org, yuxuan.zuo@outlook.com,
        alexghiti@rivosinc.com, alexandre.chartre@oracle.com, bp@alien8.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 1/6] objtool/powerpc: Add build-time fixup of
 alternate feature branch targets
Message-ID: <aftTbxYxnnfFr_rn@gate>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
 <afoTSvawD4CXCCy1@gate>
 <20260506070000.GZ3126523@noisy.programming.kicks-ass.net>
 <aftJIWxB70eNRX8l@gate>
 <20260506142214.GD3126523@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260506142214.GD3126523@noisy.programming.kicks-ass.net>

Hi!

On Wed, May 06, 2026 at 04:22:14PM +0200, Peter Zijlstra wrote:
> On Wed, May 06, 2026 at 08:58:57AM -0500, Segher Boessenkool wrote:
> > Huh.
> > 
> > On function entry, there is *no* accessible stack frame, on our ABIs
> > (typically you can still access your parent's frame of course, but then
> > you first need to find out who your parent is, etc.)  All stack frames
> > are always set up by separate store instructions.  We are a RISC
> > architecture after all (POWER means "Performance Optimisation With
> > Enhanced RISC").  So objtool checks if we actually tore down all
> > stack frames?  What a very useful thing to do.
> > 
> > Stack frames are a software concept in the first place, it has nothing
> > to do with the hardware, *at all*.  This is a bit different on archs
> > that *actually* have such a thing as a frame pointer, that don't emulate
> > it using a GPR (or something in memory!)
> 
> So, remember that objtool was born to generate ORC stack unwind data.
> It needs to track the stack state at every instruction to accomplish
> this.

Yup.

> One of the basic sanity checks it does is ensuring there is no lingering
> stack state on RETURN -- this would obviously cause the
> caller/returned-to context to get a wee bit upset.
> 
> And yes, I realize this might sound quite mad to a compiler person. But

It doesn't sound weird *at all*, we have to jump through many hoops in
the compiler as well as in the ABIs to make this work at all.

> remember that we have a ton of ASM (inline and otherwise) mixed in with
> our C code. And while you can add DWARF CFI to ASM, this has
> historically been a bit of a trainwreck, not in the least because the
> annotations got wrong and nothing warned about it until the unwinder
> would explode.

Typically, someone who writes inline assembler code cannot write CFI
statements properly *at all*, he/she just doesn't have all the necessary
information!  Only the compiler does.  It can put all kinds of stuff on
the stack for example.  Writing CFI statements manually is really forr
 someone writing machine code, or actual assembler code perhaps.

> > There are many other archs where all (or almost all, "all normal", call/
> > return sequences use a "link register", often called exactly that.  It's
> > the modern consensus to design call/return around that, I'd say even.
> > It would be nice if this abstraction worked well ;-)
> 
> Agreed. Its just that this thing has a very strong x86 flavour per its
> legacy ;-) We'll get it sorted.

Thanks for the care!


Segher

