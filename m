Return-Path: <linuxppc-dev+bounces-20524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD8FCD3440
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 14:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9d7Z0y7gz2xnM;
	Thu, 07 May 2026 00:29:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778077786;
	cv=none; b=abSUt12n+xbZ7dEYo4RNsZATojHqJd8Y06E44dUv2GYUPGnM+S27209UENchFl9D+UWSOtL4oALELDQBkcA1R+4T2zyZBLHKuTB7shYUv5FBu62FIvVfaeaVR6OR4wUWxA7wpZ3++RIjBZKbUX6o6i3PE2HjI1eZUL8/hQPtIv4s6zzCNahRr867PEKXwrRLkN3Z6Cksh6JJQdLKHlgaG65c6r2C7lHHM4h/KPuZXNi2HRqDxb/BYnTzlJvjG3ZKqTid2RObKlK+WRIVNUUvlPfRhmhnpU3Cd6KeKv6tZl2TNUsqFpW6CerzxBCt7ERpE1QcusTXm9pHfCtQvRK6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778077786; c=relaxed/relaxed;
	bh=PdfgUaioiBTDMaMoGXeLryTj15P45hjggW9aPDlyS+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZfMWekiUtrXq/bmCZrq6bHBYFsVY5OQ6o92KTF0h3t8OBcNQO7msLgS7ZpKaItLdRxdZFy08pN2+1fk/wYb5y64QJVJnbKJvo4AU669SkVbV7Ois9BhhPOl5XfBiTn3qmQ6cOdalbqixyvBMzF7tMYFAt415ciiWJOnvQJPGtmLe9g1N0qu2C3rJgz9gWCbdmwy8AXGiRtOCWrjf/Nfb1QNRIu9wI2e3ncSz+XWL5v2tSQhiG92jkP7Xhh+gQ2NIcWGF/EvbzGl+IShBcnnWWGSR3qrP9RhG/sO7lkgcLF9lYFqnqSMt2WjIVepmd2j3A2qLT8+ZKqmUAGVklaYxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9d7X6pNSz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 00:29:44 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 646ESaYa352811;
	Wed, 6 May 2026 09:28:36 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 646ESUw9352806;
	Wed, 6 May 2026 09:28:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 6 May 2026 09:28:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>, nathan@kernel.org,
        nsc@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, jpoimboe@kernel.org, ojeda@kernel.org,
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
Message-ID: <aftQDiJBZ032-Oem@gate>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
 <20260505144949.GO3102924@noisy.programming.kicks-ass.net>
 <669fbc9a-a243-43e8-8888-93bfb9d6ee12@kernel.org>
 <20260506071753.GA3126523@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260506071753.GA3126523@noisy.programming.kicks-ass.net>

On Wed, May 06, 2026 at 09:17:53AM +0200, Peter Zijlstra wrote:
> On Tue, May 05, 2026 at 05:48:32PM +0200, Christophe Leroy (CS GROUP) wrote:
> > bclr (which is the return INSN_RETURN) has type 19
> > 
> > By the way you can have a look at https://patchwork.ozlabs.org/project/linuxppc-dev/patch/bfa8364da047d8610a09458a1cd924a0566aedbb.1736955567.git.christophe.leroy@csgroup.eu/
> 
> That is indeed more; isn't bcl something like COND_CALL ? (another one
> of them things we don't have).

Yeah, all of bc[l][a] are conditional branches.  "a" (AA=1) means the
branch target is an absolute address (in the top or bottom 8kB of the
address space), and "l" (LK=1) means set LR to the NIA ("next
instruction address") before doing the branch.

The BO field describes the condition.  0x14 means "always".  (But there
also are primary opcodes for b[l][a], with a bigger target field, 24
bits instead of the 14 bits of bc[l][a]; you do not have the BI and BO
fields then of course) ("branch index" and "branch option" btw).

> > That patch has all the objtool decoding. By the way objtool is missing a
> > INSN_CONDITIONAL_RETURN, also see https://patchwork.ozlabs.org/project/linuxppc-dev/patch/537e5d8f181b1f1c2b8918f1aefa1dba3f972c03.1736955567.git.christophe.leroy@csgroup.eu/
> 
> Right, that is not something x86 has, but I don't see a reason we can't
> add that. With return thunks, Clang (and I've heard GCC is also
> considering this) does something very close to conditional return.

A conditional blr does not map well to most compiled languages.  It is
nice for hand-written machine code though :-)

For compiled code you almost always want to make some of the associated
stack frame maintenance conditional as well (because the ABIs require
this, if nothing else!)

I guess we could add some special-case stuff for it, maybe a peephole,
but we probably would have to write a whole new pass for it, stuff with
branch instructions always requires special checks :-p

> That way we do the return checks, but don't terminate the control flow.
> After all, when the condition is taken, we had better have the stack
> frame in the same state etc.

Ugh, mixed abstractions again :-(


Segher

