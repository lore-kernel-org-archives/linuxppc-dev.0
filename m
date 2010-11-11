Return-Path: <subrata@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5E25B7119
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 18:57:48 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAB7nQre014120
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 00:49:26 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id oAB7vaSs119962
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 00:57:36 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAB7vZEE012392
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 00:57:36 -0700
Subject: Re: [PATCH] powerpc: Fix hcall tracepoint recursion
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: Li Zefan <lizf@cn.fujitsu.com>
In-Reply-To: <4CC13BB8.7090003@cn.fujitsu.com>
References: <4C85A88D.10700@cn.fujitsu.com>
	<1285689961.11429.12.camel@subratamodak.linux.ibm.com>
	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>
	<4CB55FE6.6000604@cn.fujitsu.com>	<4CB5615C.4070406@cn.fujitsu.com>
	<4CB59825.7060504@cn.fujitsu.com>
	<1286995066.4893.17.camel@subratamodak.linux.ibm.com>
	<4CBBBCB0.8070406@cn.fujitsu.com> <20101021215212.4a982c85@kryten>
	<4CC13BB8.7090003@cn.fujitsu.com>
Content-Type: text/plain
Date: Thu, 11 Nov 2010 13:27:16 +0530
Message-Id: <1289462236.5622.43.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: ltp-list@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I tested and reported back the results. The patch works fine. Can you
please find out if it has been committed to Linus tree and if yes, then
the commit id please ?

Regards--
Subrata

On Fri, 2010-10-22 at 15:22 +0800, Li Zefan wrote: 
> Anton Blanchard wrote:
> > Hi,
> > 
> >> This is a dead loop:
> >>
> >> trace_hcall_entry() -> trace_clock_global() -> trace_hcall_entry() ..
> >>
> >> And this is a PPC specific bug. Hope some ppc guys will fix it?
> >> Or we kill trace_clock_global() if no one actually uses it..
> > 
> > Nasty! How does the patch below look? I had to disable irqs otherwise
> > we would sometimes drop valid events (if we take an interrupt anywhere
> > in the region where depth is elevated, then the entire interrupt will
> > be blocked from calling hcall tracepoints.
> > 
> 
> Thanks!
> 
> Subrata, could you test the patch below?
> 
> > Anton
> > --
> > 
> > Subject: [PATCH] powerpc: Fix hcall tracepoint recursion
> > 
> > Spinlocks on shared processor partitions use H_YIELD to notify the
> > hypervisor we are waiting on another virtual CPU. Unfortunately this means
> > the hcall tracepoints can recurse.
> > 
> > The patch below adds a percpu depth and checks it on both the entry and
> > exit hcall tracepoints.
> > 
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> > ---
> > 
> > Index: powerpc.git/arch/powerpc/platforms/pseries/lpar.c
> > ===================================================================
> > --- powerpc.git.orig/arch/powerpc/platforms/pseries/lpar.c	2010-10-21 17:32:00.980003644 +1100
> > +++ powerpc.git/arch/powerpc/platforms/pseries/lpar.c	2010-10-21 17:34:54.942681273 +1100
> > @@ -701,6 +701,13 @@ EXPORT_SYMBOL(arch_free_page);
> >  /* NB: reg/unreg are called while guarded with the tracepoints_mutex */
> >  extern long hcall_tracepoint_refcount;
> >  
> > +/* 
> > + * Since the tracing code might execute hcalls we need to guard against
> > + * recursion. One example of this are spinlocks calling H_YIELD on
> > + * shared processor partitions.
> > + */
> > +static DEFINE_PER_CPU(unsigned int, hcall_trace_depth);
> > +
> >  void hcall_tracepoint_regfunc(void)
> >  {
> >  	hcall_tracepoint_refcount++;
> > @@ -713,12 +720,42 @@ void hcall_tracepoint_unregfunc(void)
> >  
> >  void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
> >  {
> > +	unsigned long flags;
> > +	unsigned int *depth;
> > +
> > +	local_irq_save(flags);
> > +
> > +	depth = &__get_cpu_var(hcall_trace_depth);
> > +
> > +	if (*depth)
> > +		goto out;
> > +
> > +	(*depth)++;
> >  	trace_hcall_entry(opcode, args);
> > +	(*depth)--;
> > +
> > +out:
> > +	local_irq_restore(flags);
> >  }
> >  
> >  void __trace_hcall_exit(long opcode, unsigned long retval,
> >  			unsigned long *retbuf)
> >  {
> > +	unsigned long flags;
> > +	unsigned int *depth;
> > +
> > +	local_irq_save(flags);
> > +
> > +	depth = &__get_cpu_var(hcall_trace_depth);
> > +
> > +	if (*depth)
> > +		goto out;
> > +
> > +	(*depth)++;
> >  	trace_hcall_exit(opcode, retval, retbuf);
> > +	(*depth)--;
> > +
> > +out:
> > +	local_irq_restore(flags);
> >  }
> >  #endif
> > 
> > 
