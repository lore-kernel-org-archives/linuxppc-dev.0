Return-Path: <linuxppc-dev+bounces-20523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0496BCD343B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 14:22:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9czN3fDJz2xnM;
	Thu, 07 May 2026 00:22:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778077360;
	cv=none; b=JOdwuelcAuECqRht+TnVdxciC+HHS5jz6U097SjLsz3gfyRhdMClBN6z5JAU6Y+4nDkBhG7Z6uTVE2YtxSleqRWHFqEXDzcekPQ0giSeFqd35ecW2EW3kWoRV3GDjNHASd+qoBGrfAfZM/tsO8bVMBz5pkymaxOn8SkHjJQUkaN/h0OXD9ui4dU9wKqnWKIlYPtKiRfSMeiJE1LqiDYwNK9eIfmppS1/ll2zlleQ7aKLWitXwelBgLrTBPCswOsBSD41JMeKWbHlkf86vav8WFMTY5CH5fppWXWvryq2Q3OJI3+3uCcLCUVSv0xMsEcvfAQ0mWOTIEDnDVkI+ja8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778077360; c=relaxed/relaxed;
	bh=VmAS648/kcaQ/LEkA2wqHc5ENPuoTr9ZPMlVRMOgdMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyAPNyfzrW/5YHR/aUkYR+iYnTglQ7sjABAoguOIROUGUyCS1AwF3Qv/Nz1m+CJMNnFcbylkJbMHXXj3GNWHwKQLKjXopIfxGXsf5Fag3dwRf1Hak1hLUeIah+DpDWpHC+Cjd5hULM9e75kGi2eqqSOkFywzMg/sNl5yT/1mDVX3o/4yXQWlriRs6AUYbf5Nuge8hYvwGmNCqVDKQutBe3pmc3XUMYZrqW+m5hnP+nU28KoVeDEjlZqkYmq0re5lYiBXFQXJa+ilHzE2h+ElD20yI5qXMNzwVtwPCVbKvGnNcPjUTvKrjPAEii0pGUQAbfBnAOUSscTiNDn4yK9ZiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Lu5PJll/; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Lu5PJll/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9czL3Gbkz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 00:22:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VmAS648/kcaQ/LEkA2wqHc5ENPuoTr9ZPMlVRMOgdMY=; b=Lu5PJll/0x3f0vhnejQ21r0/JI
	FbIt7A+P0Tw6TBmqd4g8bGojwQEL4FTJxc4UY5wDFvDhQG1+iF33oz4IgEgh9xJPSSvoDtWNY5H+Q
	yWUMWHHPWyPJAnjvyFMcDu1y5YG5D1THIOcaNTr+78Qqa1a2ruLJwzN5VXF6E2hzOkw1MPCoqtykt
	33ID+PToQX92vdgxv1K6pDsIwuepGjBPZiMsx/Jnr85oM1BadqoPv+s1dmmbSRHK9PcU925TDtIOk
	nrCE/RJ9EdNE/fawOfcvKTynx57WQLWL1S61dwIB2VEmmItHVsZNNzAqdaUgpc7MDIbbAGdTwKUyI
	PR1qB+EQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKd8h-00000001KYx-3ETU;
	Wed, 06 May 2026 14:22:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A91E2303011; Wed, 06 May 2026 16:22:14 +0200 (CEST)
Date: Wed, 6 May 2026 16:22:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Sathvika Vasireddy <sv@linux.ibm.com>, nathan@kernel.org,
	nsc@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, jpoimboe@kernel.org,
	ojeda@kernel.org, masahiroy@kernel.org, lossin@kernel.org,
	tamird@kernel.org, thomas.weissschuh@linutronix.de,
	rostedt@goodmis.org, ihor.solodrai@linux.dev, thuth@redhat.com,
	pmladek@suse.com, aliceryhl@google.com, elver@google.com,
	kees@kernel.org, legion@kernel.org, ardb@kernel.org,
	yuxuan.zuo@outlook.com, alexghiti@rivosinc.com,
	alexandre.chartre@oracle.com, bp@alien8.de,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 1/6] objtool/powerpc: Add build-time fixup of
 alternate feature branch targets
Message-ID: <20260506142214.GD3126523@noisy.programming.kicks-ass.net>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
 <afoTSvawD4CXCCy1@gate>
 <20260506070000.GZ3126523@noisy.programming.kicks-ass.net>
 <aftJIWxB70eNRX8l@gate>
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
In-Reply-To: <aftJIWxB70eNRX8l@gate>

On Wed, May 06, 2026 at 08:58:57AM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Wed, May 06, 2026 at 09:00:00AM +0200, Peter Zijlstra wrote:
> > On Tue, May 05, 2026 at 10:56:58AM -0500, Segher Boessenkool wrote:
> > > On Tue, May 05, 2026 at 04:45:39PM +0200, Peter Zijlstra wrote:
> > > > On Tue, May 05, 2026 at 02:16:23PM +0530, Sathvika Vasireddy wrote:
> > > > >  	switch (opcode) {
> > > > > +	case 16:
> > > > 
> > > > Like case 18 below, this wants a comment describing which instruction
> > > > this is; bclr ?
> > > 
> > > Yes.  It is 19/16, b[c]lr (primary opcode 19, secondary opcode 16).
> > > 
> > > Where is it described what INSN_RETURN actually means for objtool?  Not
> > > in the header file :-(
> > 
> > Yeah, nowhere much I'm afraid, it is very much organic growth that is
> > firmly rooted in x86.
> > 
> > RETURN, along with sibling/tail CALLs validate things like the stack
> > frame being in identical state as on function entry and a few other
> > sanity checks (DF flag not set, no uaccess).
> 
> Huh.
> 
> On function entry, there is *no* accessible stack frame, on our ABIs
> (typically you can still access your parent's frame of course, but then
> you first need to find out who your parent is, etc.)  All stack frames
> are always set up by separate store instructions.  We are a RISC
> architecture after all (POWER means "Performance Optimisation With
> Enhanced RISC").  So objtool checks if we actually tore down all
> stack frames?  What a very useful thing to do.
> 
> Stack frames are a software concept in the first place, it has nothing
> to do with the hardware, *at all*.  This is a bit different on archs
> that *actually* have such a thing as a frame pointer, that don't emulate
> it using a GPR (or something in memory!)

So, remember that objtool was born to generate ORC stack unwind data.
It needs to track the stack state at every instruction to accomplish
this.

One of the basic sanity checks it does is ensuring there is no lingering
stack state on RETURN -- this would obviously cause the
caller/returned-to context to get a wee bit upset.

And yes, I realize this might sound quite mad to a compiler person. But
remember that we have a ton of ASM (inline and otherwise) mixed in with
our C code. And while you can add DWARF CFI to ASM, this has
historically been a bit of a trainwreck, not in the least because the
annotations got wrong and nothing warned about it until the unwinder
would explode.

Objtool solves all of that, by doing build time reconstruction of the
control flow and stack state it guarantees everything is consistent at
build time. Additionally it can deal with fun things like alternatives
/ static branches etc.

It can deal with both -fframe-pointer and -fomit-frame-pointer (on x86).
When the frame pointer reg (BP) is used, it also validates this is done
correctly.

This has caught many whoopsies over the years.

Then because this thing is parsing object files and decoding control
flow, features were added, like the uaccess scope checks.

> > There is also a pile of hacks around the whole return thunk mitigation
> > thing. But that might be less relevant for other archs.
> 
> I don't really want to think about it :-)  Horrors!
> 
> There are many other archs where all (or almost all, "all normal", call/
> return sequences use a "link register", often called exactly that.  It's
> the modern consensus to design call/return around that, I'd say even.
> It would be nice if this abstraction worked well ;-)

Agreed. Its just that this thing has a very strong x86 flavour per its
legacy ;-) We'll get it sorted.

