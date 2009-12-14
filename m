Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2A22B6F1C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 05:03:38 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBEI1t9L003533
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 05:01:55 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBEHxg2L1433646
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 04:59:42 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBEI3aM0020584
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 05:03:37 +1100
Date: Mon, 14 Dec 2009 23:33:24 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20091214180324.GA18406@in.ibm.com>
References: <20091211160409.GB23156@in.ibm.com>
	<20091214005648.82BA31DE@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091214005648.82BA31DE@magilla.sf.frob.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 13, 2009 at 04:56:48PM -0800, Roland McGrath wrote:
> I can't see anything you've done to keep this use of MSR_SE in the
> user-mode register state from interfering with user_enable_single_step().
> It looks to me like you'd swallow the normal step indications.
> 

Yes, it does unset MSR_SE bit in single_step_dabr_instruction()
irrespective of whether it was previously enabled through
user_enable_single_step(). This could be mitigated with the use of a
separate flag which can be used to conditionally unset MSR_SE, however
given further concerns about pre-emption (as expressed by you below),
I'm afraid of substantial revamp of the user-space semantics.

> Likewise I'm not very clear on the interaction with kprobes, kgdb,
> or whatnot for kernel-mode cases.  But I'll leave those concerns to
> others, since I know more about the user-mode situations.
>

Kprobes has been tested to work simultaneously with hw-breakpoints. KGDB
has not been ported yet to use the hw-breakpoint interfaces (KGDB had
issues in it, that prevented it from being tested during our
development...though its maintainer has begun showing interest
recently).

Xmon was (and I believe is still) in a state where data breakpoints did
not work. It needs to be ported too, to benefit from the hw-breakpoint
interfaces.
 
> Back to the user-mode case, is it really reasonable to disable
> preemption in hw_breakpoint_handler and leave it so across returning
> to user mode?  (Is that even possible?  I thought user mode was
> always preemptible.)  That is done very casually with little comment
> in hw_breakpoint_handler and single_step_dabr_instruction, but it
> seems like an extremely deep and magical thing that merits more
> explanation.  I guess the need for it has to do with the per_cpu
> variable you're using, but the whole situation is not very clear on
> first reading.  Even for kernel mode, what does this mean when the
> stepped instruction does a page fault?
> 

I must admit that the issue of pre-emption should have been given more
thought. Suppose there's a stream of user-space instructions "i1, i2, i3,
.....i<n>" and if 'i2' instruction can cause a hw-breakpoint exception,
then there exists a small window between i1 and i2 where pre-emption is
disabled (while a schedule operation could have taken place otherwise).

Disabling pre-emption is necessary to ensure that hw-breakpoints are
enabled immediately after the causative instruction has finished
execution (the control flow may go astray if pre-emption occurs between
i1 and i2). The root cause of this behaviour is a combination of
'trigger-before-execute' behaviour (for data-exceptions) and a desire
for 'continuous' exceptions (as opposed to one-shot behaviour seen in
ptrace). The per-cpu variable 'last_hit_bp' just helps identify a
single-step exception resulting from a hbp_handler vs other sources.

Resorting to one-shot behaviour (which is the easiest workaround
available) will break the desired uniformity in behaviour for
hw-breakpoint interfaces - say every register_user_<> interface must be
accompanied by a unregister_<> interface, etc. Post perf-events'
integration, ensuring a one-shot behaviour might also have its own
bunch of undesirable consequences (such as circular locks), that must be
overcome.

Unless I see a way to re-instate the breakpoints (surviving a
pre-emption), I will send out a new patch that resorts to a one-shot
behaviour for user-space (kernel-space is fine though).

Thank you for the insightful comments!

K.Prasad
