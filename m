Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 3FB38B7C63
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 21:04:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: prasad@linux.vnet.ibm.com
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
In-Reply-To: K.Prasad's message of  Tuesday,
	19 January 2010 15:10:35 +0530 <20100119094035.GD9971@in.ibm.com>
References: <20091211160409.GB23156@in.ibm.com>
	<20091214005648.82BA31DE@magilla.sf.frob.com>
	<20091214180324.GA18406@in.ibm.com>
	<20091214192626.3F9171DE@magilla.sf.frob.com>
	<20091217190320.GA20331@in.ibm.com>
	<20100119094035.GD9971@in.ibm.com>
Message-Id: <20100119100335.3EB621DE@magilla.sf.frob.com>
Date: Tue, 19 Jan 2010 02:03:35 -0800 (PST)
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

> It is also not clear to me if disabling pre-emption for the user-space
> (albeit for a very tiny time-window) is incorrect and if their side-effects
> are known. If otherwise, I think we should choose to operate in pre-empt
> safe mode and avoid all costs associated when done without it.

I never really gave much consideration to returning to user mode with
preemption disabled.  It would not really have occurred to me that was
even possible.  I can't say it seems to me like it could ever be a very
good idea.  I find it hard even to start listing the cans of worms that
might be opened by that.  Perhaps the powerpc maintainers have a clearer
picture of it than I do.

What does it mean when there is something that prevents it from returning
to user mode?  i.e., TIF_SIGPENDING or TIF_NEED_RESCHED, or whatever.  It
could do a lot in the kernel before it gets back to user mode.  What if in
there somewhere it blocks voluntarily?

Similarly, what does it mean if you get to user mode but the single-stepped
instruction is a load/store that gets a page fault?  What if it blocks in
the page fault handler?

For that matter, what about a page fault for the kernel-mode case?

Perhaps I'm imagining gremlins where there aren't any, but I just cannot
really get my head around this "disable preemption while running some
unknown instruction that normally runs with preemption enabled" thing--let
alone "disable preemption while returning to user mode".


Thanks,
Roland
