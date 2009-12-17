Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC278B6EED
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 06:03:28 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id nBHJ3PiC030327
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 00:33:25 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBHJ3Pdi3567846
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 00:33:25 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBHJ3O0o014264
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 00:33:25 +0530
Date: Fri, 18 Dec 2009 00:33:20 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20091217190320.GA20331@in.ibm.com>
References: <20091211160409.GB23156@in.ibm.com>
	<20091214005648.82BA31DE@magilla.sf.frob.com>
	<20091214180324.GA18406@in.ibm.com>
	<20091214192626.3F9171DE@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091214192626.3F9171DE@magilla.sf.frob.com>
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

On Mon, Dec 14, 2009 at 11:26:26AM -0800, Roland McGrath wrote:
<snipped>
> I understand the reason for using stepping.  (I have advised in the past
> that I thought this magical implicit step logic was too hairy to roll in
> under the covers and that a low-level facility expressing the different
> hardware semantics to a kernel API would be OK.  I do agree with the
> motivation of cross-arch uniformity of the semantics.  I don't object to
> making it magically right--I just expressed general skepticism/fear about
> getting that right so that I didn't want to try writing that magic.  Now
> I'm just responding about the particular details I've noticed about that
> can of worms.  It's certainly great if you can resolve all that.  But I'll
> note that I am still by no means confident that the details I have raised
> cover all the worms in that can.)
> 
> What remains less than clear is how preemption relates.  For any per-thread
> hw_breakpoint, there is no high-level reason to care one way or the other.
> The thread, its HW breakpoints, its register state including state of
> stepping, are all part of per-thread state and no reason to do any less (or
> more) preemption than normally happens.
> 

I get that reasoning now...I'd been unduly worried about pre-emption
and hence the introduction of pre-emption disabled state.

But of course, in the existing design, the per-cpu variables would be
affected because if pre-emption was to occur. I'll see how that can be
factored in, while retaining the abstraction provided by the interfaces.

> > Disabling pre-emption is necessary to ensure that hw-breakpoints are
> > enabled immediately after the causative instruction has finished
> > execution (the control flow may go astray if pre-emption occurs between
> > i1 and i2).
> 
> I don't understand what "go astray" means here.  The only thing I can think
> of is the effect on any per-cpu variables you are using in hw_breakpoint
> implementation.
> 

As stated above, I was worried about a pre-emption happening between a
return from breakpoint exception handler and the execution of the
causative instruction....but as I learn, it seems fine now. It is just that
the kernel code needs to be tweaked keeping this in mind.

Thanks,
K.Prasad
