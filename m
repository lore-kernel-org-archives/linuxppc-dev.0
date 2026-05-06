Return-Path: <linuxppc-dev+bounces-20521-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A14CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 14:00:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9cTQ6F3cz2xnM;
	Thu, 07 May 2026 00:00:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778076010;
	cv=none; b=gzfzQ5Hn8xso+Zj50jYKGqCh+SJtj1CcXTeQ4PIKe3WBixCzcO8N5ZcIz9yBsb+0OBVchGLE7xU9Nldr5Z3NzkQthgmlPC6LPkgg0PW/xEWvUA7GVc6IUk4qtk7rcEeLN/tEgeEbmqqaUTcdI8CqRP92xEbEJpMh7xKbSJhO8kXVRmQuEHbokY5W8z3XwGwkzGgMkaC8qZk58zVERV1WLgauUvF7+QeR5sG56PNJ94lAV6xmBji1L0XarO0b6Qvita6eclTOJ1Kfh9Jtc/tRgCCdw2jfPFe0zUqNmFXSLpsnQRQ12fMsHq3Co7/B7RLSjpbmvYXz0gkwS7CbWOaFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778076010; c=relaxed/relaxed;
	bh=jG4ocBrcevMQGFd6HsTzDquxSVgEva/D714YN3FtOcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKpjWhF0JqrgQBdLxisGe6GllK0MF7qkZWJjyCMce+0e+zP4FZZDd6KO7jOUnp/36igzEfPpoS6bujXmRWkd/ltYz9DMrLPFF3keBAgvRlWcoJQd5BNYeINQ9dvfYGO5ZiFMpzPF3qyDS1nWQ7zPkGNSnKJ80OGuOfJ+V3N+YmMkzCvsW8O/GxNY8IMqkl3kQ5tNJhnAZEEe103uzBSGQkdUebELm6Vq3wZLvSQMx4PuFSMFSV93TxQEpHw+ovN2xv3MakNiZ97rrAMBDMl9EOUXiYDGOZuS2EuUw7IZWVzZAlYjcwy/Jjb8MIOlT5Qu9DYULWjLZlSeJF1nLKydrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9cTN5pyhz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 00:00:07 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 646Dx5Bn347610;
	Wed, 6 May 2026 08:59:05 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 646DwvZ2347563;
	Wed, 6 May 2026 08:58:57 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 6 May 2026 08:58:57 -0500
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
Message-ID: <aftJIWxB70eNRX8l@gate>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
 <afoTSvawD4CXCCy1@gate>
 <20260506070000.GZ3126523@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260506070000.GZ3126523@noisy.programming.kicks-ass.net>

Hi!

On Wed, May 06, 2026 at 09:00:00AM +0200, Peter Zijlstra wrote:
> On Tue, May 05, 2026 at 10:56:58AM -0500, Segher Boessenkool wrote:
> > On Tue, May 05, 2026 at 04:45:39PM +0200, Peter Zijlstra wrote:
> > > On Tue, May 05, 2026 at 02:16:23PM +0530, Sathvika Vasireddy wrote:
> > > >  	switch (opcode) {
> > > > +	case 16:
> > > 
> > > Like case 18 below, this wants a comment describing which instruction
> > > this is; bclr ?
> > 
> > Yes.  It is 19/16, b[c]lr (primary opcode 19, secondary opcode 16).
> > 
> > Where is it described what INSN_RETURN actually means for objtool?  Not
> > in the header file :-(
> 
> Yeah, nowhere much I'm afraid, it is very much organic growth that is
> firmly rooted in x86.
> 
> RETURN, along with sibling/tail CALLs validate things like the stack
> frame being in identical state as on function entry and a few other
> sanity checks (DF flag not set, no uaccess).

Huh.

On function entry, there is *no* accessible stack frame, on our ABIs
(typically you can still access your parent's frame of course, but then
you first need to find out who your parent is, etc.)  All stack frames
are always set up by separate store instructions.  We are a RISC
architecture after all (POWER means "Performance Optimisation With
Enhanced RISC").  So objtool checks if we actually tore down all
stack frames?  What a very useful thing to do.

Stack frames are a software concept in the first place, it has nothing
to do with the hardware, *at all*.  This is a bit different on archs
that *actually* have such a thing as a frame pointer, that don't emulate
it using a GPR (or something in memory!)

> There is also a pile of hacks around the whole return thunk mitigation
> thing. But that might be less relevant for other archs.

I don't really want to think about it :-)  Horrors!

There are many other archs where all (or almost all, "all normal", call/
return sequences use a "link register", often called exactly that.  It's
the modern consensus to design call/return around that, I'd say even.
It would be nice if this abstraction worked well ;-)


Segher

