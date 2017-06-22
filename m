Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wthhv4HBpzDr34
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 23:08:15 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id s66so2865107pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 06:08:15 -0700 (PDT)
Date: Thu, 22 Jun 2017 23:08:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/6] powerpc/64s: Blacklist system_call() and
 system_call_common() from kprobes
Message-ID: <20170622230800.08369dce@roar.ozlabs.ibm.com>
In-Reply-To: <87a850s2kd.fsf@concordia.ellerman.id.au>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <e602b626323ee22ac39de305b62385a2a0210018.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622133640.66861cda@roar.ozlabs.ibm.com>
 <87a850s2kd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jun 2017 21:07:46 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Thu, 22 Jun 2017 00:08:39 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >  
> >> Convert some of the symbols into private symbols and blacklist
> >> system_call_common() and system_call() from kprobes. We can't take a
> >> trap at parts of these functions as either MSR_RI is unset or the kernel
> >> stack pointer is not yet setup.
> >> 
> >> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>  
> >
> > I don't have a problem with this bunch of system call labels
> > going private. They've never added much for me in profiles.
> >
> > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > Semi-related question, why is system_call: where it is?  
> 
> Ancient history.
> 
> We used to have:
> 
> 	bne	syscall_dotrace
> syscall_dotrace_cont:
> 	cmpldi	0,r0,NR_syscalls
> 	bge-	syscall_enosys
> 
> system_call:			/* label this so stack traces look sane */
> 
> 
> So it was there to hide syscall_dotrace_cont from back traces.
> 
> But we made syscall_dotrace_cont local in 2012 and then removed it
> entirely in 2015.
> 
> > Should we move it up to right after the mtmsrd / wrteei instruction?
> > (obviously for another patch). It's pretty common to get PMU
> > interrupts coming in right after mtmsr and this makes profiles split
> > the syscall into two which is annoying.  
> 
> Move it wherever makes sense and gives good back traces.

I'd be in favour of moving it to right after the interurpt enable.
I suppose you'd want a separate patch for that though. But we could
put it in this series since we're changing a lot of labels.

Thanks,
Nick
