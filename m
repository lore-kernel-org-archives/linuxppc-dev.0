Return-Path: <subrata@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C641CB70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Oct 2010 18:25:57 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9M7Ib7K014152
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Oct 2010 03:18:37 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9M7Pql2305708
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Oct 2010 03:25:52 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9M7PpbR016755
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Oct 2010 01:25:52 -0600
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
Date: Fri, 22 Oct 2010 12:55:50 +0530
Message-Id: <1287732351.4949.0.camel@subratamodak.linux.ibm.com>
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

Yes, definitely. Givmme some time.

Regards--
Subrata

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
