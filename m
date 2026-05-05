Return-Path: <linuxppc-dev+bounces-20481-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46475CD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 15:58:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g938g5Smlz2xfB;
	Wed, 06 May 2026 01:58:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777996723;
	cv=none; b=KS1azfh1NN09/5bgDnaflplzWbA3+rrq+srpwzqkcwUNqIyj1NLe8iaOL3yz7pQkhno/gD4lQdJmIm2a0csFXv0Pa1hnW1QkDsB6L8XgFzEaZeYVE6pKKftkhV8GGZpIdYYbJqeD0bXm28YQKQw9ylqKeyYJltsUVl1c6OYMzuRS/CZDjWpO7lIk8KUtajk6cDGihVZsrBa7uWlvcn0sVV84xK13W1q3vLJZ3RbcW+fOW/oLv9vaBlSaFEN8V+hsMDufDD57lNJlqQdQ73G4LVU3ZJnBo7KNVRPB4ptrVnTWn+zOfz1bIx7fMs6HJp6eOfhMPJvl5Sgp0ySMV0gexw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777996723; c=relaxed/relaxed;
	bh=rSFnuj2S2pOktYS6KR8pu0EM6XWflOBaN/tj/8NJgMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFNjg/pJx6AKr5m9tF5kJcNGKeoyiq2MMaEmovSD0mhqJVrgi3lmErRTVKD7zMHsyxpvDrpft89VAYQ1NFaK8jitUEYCpdaeOJy7t3ewOdKkDvSE6D0NoqNzxSlEj2JRYVJSGBpnJ5nldJcJq35+EkjbV7NXw8Yn7/ULhSmTnA58OtCy86B/GuIdONGKxZuNOMLWJXwmXKQb2cKEzUn9TL7hyVBQOcac1PgrFLtNlQc4eu7cwjWeFTtRPAzEr0MKZSWiU0ODP78Yg3SulQtKQCTCY155rSQJIfvxM7aWPaLR0LxezHDtIeTVc8SScyy/Y6dHqwUVY9fj/f0BgXFSqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g938f0JHPz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 01:58:41 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 645Fv4oO164706;
	Tue, 5 May 2026 10:57:04 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 645Fuwtk164700;
	Tue, 5 May 2026 10:56:58 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 5 May 2026 10:56:58 -0500
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
Message-ID: <afoTSvawD4CXCCy1@gate>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260505144539.GX3126523@noisy.programming.kicks-ass.net>

Hi!

On Tue, May 05, 2026 at 04:45:39PM +0200, Peter Zijlstra wrote:
> On Tue, May 05, 2026 at 02:16:23PM +0530, Sathvika Vasireddy wrote:
> >  	switch (opcode) {
> > +	case 16:
> 
> Like case 18 below, this wants a comment describing which instruction
> this is; bclr ?

Yes.  It is 19/16, b[c]lr (primary opcode 19, secondary opcode 16).

Where is it described what INSN_RETURN actually means for objtool?  Not
in the header file :-(

For PowerPC, all three of b[c]lr[l], b[c]ctr[l], and b[c]tar[l] are
indirect jumps, to an address in a register.  They do absolutely nothing
typically done in a function epilog, like "return" insns in some other
archs do.  But the BH field ("branch hint") in the instruction helps
predict the control flow involving the insn as something in a call and
return pattern :-)


Segher

