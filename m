Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFCE9B7CD7
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 20:40:42 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o0J9blcG026796
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 20:37:47 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0J9egt11589288
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 20:40:42 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0J9efUF013489
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 20:40:42 +1100
Date: Tue, 19 Jan 2010 15:10:35 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100119094035.GD9971@in.ibm.com>
References: <20091211160409.GB23156@in.ibm.com>
	<20091214005648.82BA31DE@magilla.sf.frob.com>
	<20091214180324.GA18406@in.ibm.com>
	<20091214192626.3F9171DE@magilla.sf.frob.com>
	<20091217190320.GA20331@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091217190320.GA20331@in.ibm.com>
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

On Fri, Dec 18, 2009 at 12:33:20AM +0530, K.Prasad wrote:
> On Mon, Dec 14, 2009 at 11:26:26AM -0800, Roland McGrath wrote:
<snipped>
> > What remains less than clear is how preemption relates.  For any per-thread
> > hw_breakpoint, there is no high-level reason to care one way or the other.
> > The thread, its HW breakpoints, its register state including state of
> > stepping, are all part of per-thread state and no reason to do any less (or
> > more) preemption than normally happens.
> > 
> 
> I get that reasoning now...I'd been unduly worried about pre-emption
> and hence the introduction of pre-emption disabled state.
> 
> But of course, in the existing design, the per-cpu variables would be
> affected because if pre-emption was to occur. I'll see how that can be
> factored in, while retaining the abstraction provided by the interfaces.
> 
<snipped>
> 
> As stated above, I was worried about a pre-emption happening between a
> return from breakpoint exception handler and the execution of the
> causative instruction....but as I learn, it seems fine now. It is just that
> the kernel code needs to be tweaked keeping this in mind.
> 
> Thanks,
> K.Prasad
> 

Hi Roland,
	The cost of allowing pre-emption (such as storing the per-cpu
variables into per-thread structures for user-space breakpoints and
offsetting the effect of a new process between the hw-breakpoint handler
and single-step handler) appears to far out-weigh the present approach
(where pre-emption is disabled between two user-space instructions).

It is also not clear to me if disabling pre-emption for the user-space
(albeit for a very tiny time-window) is incorrect and if their side-effects
are known. If otherwise, I think we should choose to operate in pre-empt
safe mode and avoid all costs associated when done without it.

I'm eager to know what you think.

Thanks,
K.Prasad
