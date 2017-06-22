Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtkdT0wbmzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 00:35:24 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MEYTlu095110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 10:35:22 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7vn8dw3r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 10:35:20 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 23 Jun 2017 00:35:17 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5MEZ68X64880804
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 00:35:14 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5MEYfrP003383
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 00:34:42 +1000
Date: Thu, 22 Jun 2017 20:04:23 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/6] powerpc/64s: Blacklist system_call() and
 system_call_common() from kprobes
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <e602b626323ee22ac39de305b62385a2a0210018.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622133640.66861cda@roar.ozlabs.ibm.com>
 <87a850s2kd.fsf@concordia.ellerman.id.au>
 <20170622230800.08369dce@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170622230800.08369dce@roar.ozlabs.ibm.com>
Message-Id: <20170622143423.4fbbhtnss2vg5dyp@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/22 11:08PM, Nicholas Piggin wrote:
> On Thu, 22 Jun 2017 21:07:46 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Nicholas Piggin <npiggin@gmail.com> writes:
> > 
> > > On Thu, 22 Jun 2017 00:08:39 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > >  
> > >> Convert some of the symbols into private symbols and blacklist
> > >> system_call_common() and system_call() from kprobes. We can't take a
> > >> trap at parts of these functions as either MSR_RI is unset or the kernel
> > >> stack pointer is not yet setup.
> > >> 
> > >> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>  
> > >
> > > I don't have a problem with this bunch of system call labels
> > > going private. They've never added much for me in profiles.
> > >
> > > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks for the review.

> > >
> > > Semi-related question, why is system_call: where it is?  
> > 
> > Ancient history.
> > 
> > We used to have:
> > 
> > 	bne	syscall_dotrace
> > syscall_dotrace_cont:
> > 	cmpldi	0,r0,NR_syscalls
> > 	bge-	syscall_enosys
> > 
> > system_call:			/* label this so stack traces look sane */
> > 
> > 
> > So it was there to hide syscall_dotrace_cont from back traces.
> > 
> > But we made syscall_dotrace_cont local in 2012 and then removed it
> > entirely in 2015.
> > 
> > > Should we move it up to right after the mtmsrd / wrteei instruction?
> > > (obviously for another patch). It's pretty common to get PMU
> > > interrupts coming in right after mtmsr and this makes profiles split
> > > the syscall into two which is annoying.  
> > 
> > Move it wherever makes sense and gives good back traces.
> 
> I'd be in favour of moving it to right after the interurpt enable.
> I suppose you'd want a separate patch for that though. But we could
> put it in this series since we're changing a lot of labels.

Sure, I'll add a patch that does that.

- Naveen
