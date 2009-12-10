Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D2A53B6F0A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 07:34:11 +1100 (EST)
Date: Thu, 10 Dec 2009 15:33:59 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev
	<linuxppc-dev@ozlabs.org>
Subject: Re: Floating point in the kernel
Message-ID: <20091210153359.3a480488@lappy.seanm.ca>
In-Reply-To: <1260476379.16132.224.camel@pasglop>
References: <20091210131311.78cab78c@lappy.seanm.ca>
	<1260476379.16132.224.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 Dec 2009 07:19:39 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I'm not sure that will work in all cases, you are playing a bit with
> fire :-) I suppose I could think it through after breakfast but my
> first thought is "don't do that !". Among other things you may not
> have a pt_regs to save the registers to.

Actually, we usually do have pt_regs, or we are stealing some ;)

> > We also hit another problem under high RTP load... and this is the
> > patch that fixes it:
> > 
> > diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> > index fc8f5b1..051a02c 100644
> > --- a/arch/powerpc/kernel/fpu.S
> > +++ b/arch/powerpc/kernel/fpu.S
> > @@ -83,6 +83,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
> >         stfd    fr0,THREAD_FPSCR(r4)
> >         PPC_LL  r5,PT_REGS(r4)
> >         toreal(r5)
> > +
> > +       /* Under heavy RTP load the hsp thread can have a NULL
> > pt_regs. */
> > +       PPC_LCMPI       0,r5,0
> > +       beq     1f
> > +  
> 
> Right and that means you just lost the content of your FP registers.

This only happens once in a blue moon, even under heavy RTP load. But I
agree, this could be a real problem.

> >         PPC_LL  r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> >         li      r10,MSR_FP|MSR_FE0|MSR_FE1
> >         andc    r4,r4,r10               /* disable FP for previous
> > task */
> > 
> > So, if you are still reading this far, I am just looking for any
> > suggestions. Are there better ways of handling this? Have I
> > missed something? Anybody know why pt_regs might be NULL?  
> 
> Just don't schedule when you enable_kernel_fp() or move your workload
> to userspace :-)

To be honest, I can't find *why* we are scheduling :( They only way we
give up the CPU is with locking... and none of the locks where hit
during the problem. We also never get near our timeslice... the longest
run I saw when the problem happened was 670us. 

Is there a way to disable scheduling? We currently do not have preempt
enabled... but may in the future.

Cheers,
   Sean
