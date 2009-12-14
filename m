Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id D2148B6F19
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 06:26:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: prasad@linux.vnet.ibm.com
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
In-Reply-To: K.Prasad's message of  Monday, 14 December 2009 23:33:24 +0530
	<20091214180324.GA18406@in.ibm.com>
References: <20091211160409.GB23156@in.ibm.com>
	<20091214005648.82BA31DE@magilla.sf.frob.com>
	<20091214180324.GA18406@in.ibm.com>
Message-Id: <20091214192626.3F9171DE@magilla.sf.frob.com>
Date: Mon, 14 Dec 2009 11:26:26 -0800 (PST)
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Yes, it does unset MSR_SE bit in single_step_dabr_instruction()
> irrespective of whether it was previously enabled through
> user_enable_single_step(). This could be mitigated with the use of a
> separate flag which can be used to conditionally unset MSR_SE, however
> given further concerns about pre-emption (as expressed by you below),
> I'm afraid of substantial revamp of the user-space semantics.

There is already TIF_SINGLESTEP set by user_enable_single_step.  So for
that aspect, it is probably relatively straightforward to cover that
interaction.  The code has to be pretty exact and will merit some comments
about subtleties, but I suspect the actual new code required will be just a
tiny amount.

> Kprobes has been tested to work simultaneously with hw-breakpoints. KGDB
> has not been ported yet to use the hw-breakpoint interfaces (KGDB had
> issues in it, that prevented it from being tested during our
> development...though its maintainer has begun showing interest
> recently).
> 
> Xmon was (and I believe is still) in a state where data breakpoints did
> not work. It needs to be ported too, to benefit from the hw-breakpoint
> interfaces.

That is not really what I meant at all.  That is good stuff to work out.
But I just meant the interactions with kprobes/kgdb's use of single-stepping,
the direct analogy to the user_enable_single_step issue.

> I must admit that the issue of pre-emption [...]

I understand the reason for using stepping.  (I have advised in the past
that I thought this magical implicit step logic was too hairy to roll in
under the covers and that a low-level facility expressing the different
hardware semantics to a kernel API would be OK.  I do agree with the
motivation of cross-arch uniformity of the semantics.  I don't object to
making it magically right--I just expressed general skepticism/fear about
getting that right so that I didn't want to try writing that magic.  Now
I'm just responding about the particular details I've noticed about that
can of worms.  It's certainly great if you can resolve all that.  But I'll
note that I am still by no means confident that the details I have raised
cover all the worms in that can.)

What remains less than clear is how preemption relates.  For any per-thread
hw_breakpoint, there is no high-level reason to care one way or the other.
The thread, its HW breakpoints, its register state including state of
stepping, are all part of per-thread state and no reason to do any less (or
more) preemption than normally happens.

> Disabling pre-emption is necessary to ensure that hw-breakpoints are
> enabled immediately after the causative instruction has finished
> execution (the control flow may go astray if pre-emption occurs between
> i1 and i2).

I don't understand what "go astray" means here.  The only thing I can think
of is the effect on any per-cpu variables you are using in hw_breakpoint
implementation.


Thanks,
Roland
