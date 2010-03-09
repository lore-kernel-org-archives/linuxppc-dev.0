Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E8C4B7D1E
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 13:14:12 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o292B43v012902
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 13:11:04 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o292EAZ01024152
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 13:14:11 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o292E9Tm026680
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 13:14:09 +1100
Date: Tue, 9 Mar 2010 07:44:00 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100309021400.GA3576@in.ibm.com>
References: <20100215055605.GB3670@in.ibm.com>
	<20100215055914.GA6017@in.ibm.com> <20100221010130.GA5187@nowhere>
	<20100222131746.GA3228@in.ibm.com> <20100226015807.GF5592@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100226015807.GF5592@nowhere>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Will Deacon <will.deacon@arm.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 26, 2010 at 02:58:12AM +0100, Frederic Weisbecker wrote:
> On Mon, Feb 22, 2010 at 06:47:46PM +0530, K.Prasad wrote:
> > The 'name' field here is actually a legacy inherited from x86 code. It
> > is part of x86's arch-specific hw-breakpoint structure since:
> > - inspired by the kprobe implementation which accepts symbol name as
> >   input.
> > - kallsyms_lookup_name() was 'unexported' and a module could not resolve
> >   symbol names externally, so the core-infrastructure had to provide
> >   such facilities.
> > - I wasn't sure about the discussions behind 'unexporting' of
> >   kallsyms_lookup_name(), so did not venture to export them again (which
> >   you rightfully did :-)
> > 
> > Having said that, I'll be glad to remove this field (along with that in
> > x86),
> 
> Cool, I'll integrate the x86 name field removal to the .24 series
> 

I've removed the .name field in the latest version of the patch sent
(linuxppc-dev message-id: 20100308181232.GA3406@in.ibm.com).

> > > > +void ptrace_triggered(struct perf_event *bp, int nmi,
> > > > +		      struct perf_sample_data *data, struct pt_regs *regs)
> > > > +{
> > > > +	struct perf_event_attr attr;
> > > > +
> > > > +	/*
> > > > +	 * Disable the breakpoint request here since ptrace has defined a
> > > > +	 * one-shot behaviour for breakpoint exceptions in PPC64.
> > > > +	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> > > > +	 * We don't have to do anything about that here
> > > > +	 */
> > > 
> > > 
> > > Oh, why does ptrace use a one-shot behaviour in ppc? Breakpoints
> > > only trigger once?
> > > 
> > 
> > Yes, ptrace breakpoints on PPC64 are designed to trigger once and this
> > patch retains that behaviour. It is very convenient to use one-shot
> > behaviour on archs where exceptions are triggered-before-execute.
> 
> Ah, Why?
>

Because we don't have to create the single_step_dabr_instruction()
function :-)

With one-shot behaviour, the hw_breakpoint_handler() doesn't have to
worry about entering into an infinite-loop (since exceptions are
triggered before instruction execution, and if breakpoints are still
active every attempt to execute the causative instruction raises the
breakpoint exception). To circumvent infinite looping, we temporarily
disable the breakpoints, enable single-stepping (to single-step over
the causative instruction) and re-enable them inside single-step 
exception handler. For the one-shot type breakpoint, the pain of
re-registration is left to the end-user.

I've wondered why PowerPC was designed to be 'trigger-before-execute'
when handling the exception can grow complex as this. Perhaps it is
meant to give absolute control over the data value (stored in the target
address) before the instruction gets to see it. For instance,
breakpoints can be used to change the data to a 'desirable' value before
actually being 'seen' by instructions.

Thanks,
K.Prasad
