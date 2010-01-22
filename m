Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FEA9B7CDA
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 18:14:10 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o0M7BC94008668
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 18:11:12 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0M79RAP1765542
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 18:09:27 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0M7E85H030439
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 18:14:09 +1100
Date: Fri, 22 Jan 2010 12:44:02 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100122071402.GA3356@in.ibm.com>
References: <20091211160409.GB23156@in.ibm.com>
	<20091214005648.82BA31DE@magilla.sf.frob.com>
	<20091214180324.GA18406@in.ibm.com>
	<20091214192626.3F9171DE@magilla.sf.frob.com>
	<20091217190320.GA20331@in.ibm.com>
	<20100119094035.GD9971@in.ibm.com>
	<20100119100335.3EB621DE@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100119100335.3EB621DE@magilla.sf.frob.com>
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

On Tue, Jan 19, 2010 at 02:03:35AM -0800, Roland McGrath wrote:
> > It is also not clear to me if disabling pre-emption for the user-space
> > (albeit for a very tiny time-window) is incorrect and if their side-effects
> > are known. If otherwise, I think we should choose to operate in pre-empt
> > safe mode and avoid all costs associated when done without it.
> 
> I never really gave much consideration to returning to user mode with
> preemption disabled.  It would not really have occurred to me that was
> even possible.  I can't say it seems to me like it could ever be a very
> good idea.  I find it hard even to start listing the cans of worms that
> might be opened by that.  Perhaps the powerpc maintainers have a clearer
> picture of it than I do.
> 
> What does it mean when there is something that prevents it from returning
> to user mode?  i.e., TIF_SIGPENDING or TIF_NEED_RESCHED, or whatever.  It
> could do a lot in the kernel before it gets back to user mode.  What if in
> there somewhere it blocks voluntarily?
> 
> Similarly, what does it mean if you get to user mode but the single-stepped
> instruction is a load/store that gets a page fault?  What if it blocks in
> the page fault handler?
> 
> For that matter, what about a page fault for the kernel-mode case?
> 
> Perhaps I'm imagining gremlins where there aren't any, but I just cannot
> really get my head around this "disable preemption while running some
> unknown instruction that normally runs with preemption enabled" thing--let
> alone "disable preemption while returning to user mode".
> 
> 
> Thanks,
> Roland

I posted a patch which re-enables pre-emption after a hw-breakpoint is
processed (linuxppc-dev ref: 20100121084640.GA3252@in.ibm.com). It does
lead to clumsiness (due to the new variables to track states, prior
breakpoints, etc.) but with the reasons you pointed out, it is much
better than having uncertain/incorrect code.

Thanks for your comments.
-- K.Prasad
